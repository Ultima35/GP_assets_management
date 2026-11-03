const db = require("../config/db");

const Paket = {
  // GET SEMUA PAKET
  getAll: async () => {
    const query = `
      SELECT 
        p.id,
        p.nama_paket,
        p.deskripsi,
        p.gambar,
        p.created_at,
        p.updated_at,
        COUNT(pi.id) AS total_items,
        COALESCE(SUM(pi.jumlah), 0) AS total_qty
      FROM paket_peminjaman p
      LEFT JOIN paket_peminjaman_items pi ON p.id = pi.paket_id
      GROUP BY p.id
      ORDER BY p.id DESC
    `;
    const [rows] = await db.query(query);
    return rows;
  },

  // GET PAKET BY ID (beserta items & status unit terbarunya)
  getById: async (id) => {
    const [paketRows] = await db.query(
      "SELECT * FROM paket_peminjaman WHERE id = ?",
      [id]
    );
    if (!paketRows[0]) return null;

    const paket = paketRows[0];

    // Ambil items dalam paket
    const itemsQuery = `
      SELECT 
        pi.id,
        pi.paket_id,
        pi.asset_id,
        pi.aksesoris_id,
        pi.jumlah,
        CASE 
          WHEN pi.asset_id IS NOT NULL THEN 'asset'
          ELSE 'aksesoris'
        END AS tipe,
        COALESCE(a.nama_aset, ak.nama_aksesoris) AS nama_item,
        COALESCE(a.kode_aset, ak.kode_aksesoris) AS kode_item,
        COALESCE(a.gambar, ak.gambar) AS gambar_item,
        COALESCE(a.kategori, ak.kategori) AS kategori,
        COALESCE(a.merek, ak.merek) AS merek,
        COALESCE(a.jumlah, ak.jumlah_unit, 0) AS stok,
        COALESCE(a.kondisi, ak.kondisi, 'Siap Digunakan') AS kondisi,
        COALESCE(a.tipe_harga, ak.tipe_harga, 'Per Unit') AS tipe_harga,
        COALESCE(a.harga_aset, ak.harga_aset, 0) AS harga_aset
      FROM paket_peminjaman_items pi
      LEFT JOIN assets a ON pi.asset_id = a.id
      LEFT JOIN aksesoris ak ON pi.aksesoris_id = ak.id
      WHERE pi.paket_id = ?
      ORDER BY pi.id ASC
    `;
    const [items] = await db.query(itemsQuery, [id]);

    // Ambil unit fisik untuk setiap item (agar form peminjaman bisa auto-select unit yang siap)
    for (const item of items) {
      if (item.tipe === "asset" && item.asset_id) {
        const [units] = await db.query(
          "SELECT id, kode_unit, nama_unit, kondisi, status_pinjam FROM asset_units WHERE asset_id = ? ORDER BY id ASC",
          [item.asset_id]
        );
        item.units = units;
      } else if (item.tipe === "aksesoris" && item.aksesoris_id) {
        const [units] = await db.query(
          "SELECT id, kode_unit, nama_unit, kondisi, status_pinjam FROM aksesoris_units WHERE aksesoris_id = ? ORDER BY id ASC",
          [item.aksesoris_id]
        );
        item.units = units;
      } else {
        item.units = [];
      }
    }

    paket.items = items;
    return paket;
  },

  // CREATE PAKET
  create: async (paketData, items = []) => {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();

      const { nama_paket, deskripsi, gambar } = paketData;
      const [result] = await connection.query(
        "INSERT INTO paket_peminjaman (nama_paket, deskripsi, gambar) VALUES (?, ?, ?)",
        [nama_paket, deskripsi || null, gambar || null]
      );
      const paketId = result.insertId;

      if (Array.isArray(items) && items.length > 0) {
        for (const item of items) {
          const assetId = item.asset_id || item.assetId || null;
          const aksesorisId = item.aksesoris_id || item.aksesorisId || null;
          const jumlah = parseInt(item.jumlah, 10) || 1;

          if (assetId || aksesorisId) {
            await connection.query(
              "INSERT INTO paket_peminjaman_items (paket_id, asset_id, aksesoris_id, jumlah) VALUES (?, ?, ?, ?)",
              [paketId, assetId, aksesorisId, jumlah]
            );
          }
        }
      }

      await connection.commit();
      return paketId;
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  },

  // UPDATE PAKET
  update: async (id, paketData, items = null) => {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();

      const { nama_paket, deskripsi, gambar } = paketData;
      let updateSql = "UPDATE paket_peminjaman SET nama_paket = ?, deskripsi = ?";
      const updateParams = [nama_paket, deskripsi || null];

      if (gambar !== undefined) {
        updateSql += ", gambar = ?";
        updateParams.push(gambar);
      }

      updateSql += " WHERE id = ?";
      updateParams.push(id);

      await connection.query(updateSql, updateParams);

      // Jika items dikirim, replace items lama
      if (Array.isArray(items)) {
        await connection.query("DELETE FROM paket_peminjaman_items WHERE paket_id = ?", [id]);

        for (const item of items) {
          const assetId = item.asset_id || item.assetId || null;
          const aksesorisId = item.aksesoris_id || item.aksesorisId || null;
          const jumlah = parseInt(item.jumlah, 10) || 1;

          if (assetId || aksesorisId) {
            await connection.query(
              "INSERT INTO paket_peminjaman_items (paket_id, asset_id, aksesoris_id, jumlah) VALUES (?, ?, ?, ?)",
              [id, assetId, aksesorisId, jumlah]
            );
          }
        }
      }

      await connection.commit();
      return true;
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  },

  // DELETE SINGLE PAKET
  delete: async (id) => {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();

      // Hapus data (paket_peminjaman_items auto cascade)
      await connection.query("DELETE FROM paket_peminjaman WHERE id = ?", [id]);

      await connection.commit();

      // Cek jika tabel paket sekarang kosong, otomatis reset auto_increment
      try {
        const [remaining] = await connection.query("SELECT COUNT(*) AS count FROM paket_peminjaman");
        if (remaining[0]?.count === 0) {
          await connection.query("ALTER TABLE paket_peminjaman AUTO_INCREMENT = 1");
          await connection.query("ALTER TABLE paket_peminjaman_items AUTO_INCREMENT = 1");
        }
      } catch (e) {
        console.error("Gagal reset AUTO_INCREMENT paket:", e.message);
      }

      return true;
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  },

  // DELETE ALL PAKET
  deleteAll: async () => {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();

      // Ambil gambar untuk dibersihkan
      const [pakets] = await connection.query("SELECT gambar FROM paket_peminjaman WHERE gambar IS NOT NULL");

      await connection.query("DELETE FROM paket_peminjaman_items");
      await connection.query("DELETE FROM paket_peminjaman");

      await connection.commit();

      try {
        await connection.query("ALTER TABLE paket_peminjaman AUTO_INCREMENT = 1");
        await connection.query("ALTER TABLE paket_peminjaman_items AUTO_INCREMENT = 1");
      } catch (e) {
        console.error("Gagal reset AUTO_INCREMENT paket:", e.message);
      }

      return pakets.map(p => p.gambar).filter(Boolean);
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
};

module.exports = Paket;
