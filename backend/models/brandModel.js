const db = require("../config/db");

const Brand = {
  getAll: async () => {
    const [rows] = await db.query(`
      SELECT b.*, 
             CASE 
               WHEN b.tipe = 'aset' THEN (SELECT COUNT(*) FROM assets a WHERE TRIM(LOWER(a.merek)) = TRIM(LOWER(b.nama)))
               WHEN b.tipe = 'aksesoris' THEN (SELECT COUNT(*) FROM aksesoris ak WHERE TRIM(LOWER(ak.merek)) = TRIM(LOWER(b.nama)))
               ELSE (
                 (SELECT COUNT(*) FROM assets a WHERE TRIM(LOWER(a.merek)) = TRIM(LOWER(b.nama))) +
                 (SELECT COUNT(*) FROM aksesoris ak WHERE TRIM(LOWER(ak.merek)) = TRIM(LOWER(b.nama)))
               )
             END AS qty,
             CASE 
               WHEN b.tipe = 'aset' THEN (SELECT COALESCE(SUM(COALESCE(a.jumlah_total, a.jumlah, 1)), 0) FROM assets a WHERE TRIM(LOWER(a.merek)) = TRIM(LOWER(b.nama)))
               WHEN b.tipe = 'aksesoris' THEN (SELECT COALESCE(SUM(COALESCE(ak.jumlah_total, ak.jumlah_unit, 1)), 0) FROM aksesoris ak WHERE TRIM(LOWER(ak.merek)) = TRIM(LOWER(b.nama)))
               ELSE (
                 (SELECT COALESCE(SUM(COALESCE(a.jumlah_total, a.jumlah, 1)), 0) FROM assets a WHERE TRIM(LOWER(a.merek)) = TRIM(LOWER(b.nama))) +
                 (SELECT COALESCE(SUM(COALESCE(ak.jumlah_total, ak.jumlah_unit, 1)), 0) FROM aksesoris ak WHERE TRIM(LOWER(ak.merek)) = TRIM(LOWER(b.nama)))
               )
             END AS total_units
      FROM brands b 
      ORDER BY b.nama ASC
    `);
    return rows;
  },

  getByTipe: async (tipe) => {
    const [rows] = await db.query(`
      SELECT b.*, 
             CASE 
               WHEN b.tipe = 'aset' THEN (SELECT COUNT(*) FROM assets a WHERE TRIM(LOWER(a.merek)) = TRIM(LOWER(b.nama)))
               WHEN b.tipe = 'aksesoris' THEN (SELECT COUNT(*) FROM aksesoris ak WHERE TRIM(LOWER(ak.merek)) = TRIM(LOWER(b.nama)))
               ELSE 0
             END AS qty,
             CASE 
               WHEN b.tipe = 'aset' THEN (SELECT COALESCE(SUM(COALESCE(a.jumlah_total, a.jumlah, 1)), 0) FROM assets a WHERE TRIM(LOWER(a.merek)) = TRIM(LOWER(b.nama)))
               WHEN b.tipe = 'aksesoris' THEN (SELECT COALESCE(SUM(COALESCE(ak.jumlah_total, ak.jumlah_unit, 1)), 0) FROM aksesoris ak WHERE TRIM(LOWER(ak.merek)) = TRIM(LOWER(b.nama)))
               ELSE 0
             END AS total_units
      FROM brands b 
      WHERE b.tipe = ? 
      ORDER BY b.nama ASC
    `, [tipe]);
    return rows;
  },

  findById: async (id) => {
    const [rows] = await db.query("SELECT * FROM brands WHERE id = ?", [id]);
    return rows[0];
  },

  findByNama: async (nama, tipe = "aset") => {
    const [rows] = await db.query(
      "SELECT * FROM brands WHERE TRIM(LOWER(nama)) = TRIM(LOWER(?)) AND tipe = ?",
      [nama, tipe]
    );
    return rows[0];
  },

  create: async (nama, tipe = "aset") => {
    const [result] = await db.query(
      "INSERT INTO brands (nama, tipe) VALUES (?, ?)",
      [nama, tipe]
    );
    return { id: result.insertId, nama, tipe };
  },

  delete: async (id) => {
    const [result] = await db.query("DELETE FROM brands WHERE id = ?", [id]);
    return result.affectedRows;
  },

  update: async (id, oldNama, nama, tipe) => {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();
      
      await connection.query("UPDATE brands SET nama = ? WHERE id = ?", [nama, id]);
      
      if (oldNama !== nama) {
        if (tipe === 'aset') {
          await connection.query("UPDATE assets SET merek = ? WHERE merek = ?", [nama, oldNama]);
        } else if (tipe === 'aksesoris') {
          await connection.query("UPDATE aksesoris SET merek = ? WHERE merek = ?", [nama, oldNama]);
        }
      }
      
      await connection.commit();
      return true;
    } catch (err) {
      await connection.rollback();
      throw err;
    } finally {
      connection.release();
    }
  },
};

module.exports = Brand;
