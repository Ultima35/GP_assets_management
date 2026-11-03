const Paket = require("../models/paketModel");
const AuditLog = require("../models/auditModel");
const { optimizeImage } = require("../utils/imageOptimizer");
const path = require("path");
const fs = require("fs");

const paketController = {
  // GET /api/paket
  getAll: async (req, res) => {
    try {
      const data = await Paket.getAll();
      res.json({ success: true, data });
    } catch (error) {
      console.error("Error get all paket:", error);
      res.status(500).json({ success: false, message: "Gagal mengambil data paket", error: error.message });
    }
  },

  // GET /api/paket/:id
  getById: async (req, res) => {
    try {
      const { id } = req.params;
      const data = await Paket.getById(id);
      if (!data) {
        return res.status(404).json({ success: false, message: "Paket tidak ditemukan" });
      }
      res.json({ success: true, data });
    } catch (error) {
      console.error("Error get paket by id:", error);
      res.status(500).json({ success: false, message: "Gagal mengambil detail paket", error: error.message });
    }
  },

  // POST /api/paket
  create: async (req, res) => {
    try {
      const { nama_paket, deskripsi, items } = req.body;

      if (!nama_paket || !nama_paket.trim()) {
        return res.status(400).json({ success: false, message: "Nama paket wajib diisi!" });
      }

      let parsedItems = items;
      if (typeof items === "string") {
        try {
          parsedItems = JSON.parse(items);
        } catch (e) {
          parsedItems = [];
        }
      }

      if (!parsedItems || !Array.isArray(parsedItems) || parsedItems.length === 0) {
        return res.status(400).json({ success: false, message: "Minimal harus ada 1 barang dalam paket!" });
      }

      // Handle gambar
      let gambarUrl = null;
      if (req.file) {
        const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
        const newFilename = await optimizeImage(
          req.file.path,
          path.join(__dirname, "..", "public", "uploads"),
          `paket-${uniqueSuffix}`
        );
        gambarUrl = `/uploads/${newFilename}`;
      }

      const paketId = await Paket.create(
        {
          nama_paket: nama_paket.trim(),
          deskripsi: deskripsi?.trim() || null,
          gambar: gambarUrl,
        },
        parsedItems
      );

      // Audit Log
      await AuditLog.create({
        userId: req.user?.userId,
        userName: req.user?.nama,
        action: "CREATE",
        entityType: "Paket Peminjaman",
        entityId: paketId,
        details: `Membuat template paket: ${nama_paket} (${parsedItems.length} item)`,
      });

      res.status(201).json({
        success: true,
        message: "Template paket berhasil dibuat!",
        data: { id: paketId },
      });
    } catch (error) {
      console.error("Error create paket:", error);
      res.status(500).json({ success: false, message: "Gagal membuat paket", error: error.message });
    }
  },

  // PUT /api/paket/:id
  update: async (req, res) => {
    try {
      const { id } = req.params;
      const existing = await Paket.getById(id);
      if (!existing) {
        return res.status(404).json({ success: false, message: "Paket tidak ditemukan" });
      }

      const { nama_paket, deskripsi, items } = req.body;

      if (!nama_paket || !nama_paket.trim()) {
        return res.status(400).json({ success: false, message: "Nama paket wajib diisi!" });
      }

      let parsedItems = items;
      if (typeof items === "string") {
        try {
          parsedItems = JSON.parse(items);
        } catch (e) {
          parsedItems = null;
        }
      }

      const paketData = {
        nama_paket: nama_paket.trim(),
        deskripsi: deskripsi !== undefined ? (deskripsi?.trim() || null) : existing.deskripsi,
      };

      let oldImageToDelete = null;
      if (req.file) {
        const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
        const newFilename = await optimizeImage(
          req.file.path,
          path.join(__dirname, "..", "public", "uploads"),
          `paket-${uniqueSuffix}`
        );
        paketData.gambar = `/uploads/${newFilename}`;
        if (existing.gambar) {
          oldImageToDelete = path.join(__dirname, "..", "public", existing.gambar);
        }
      } else if (req.body.hapus_gambar === "true" || req.body.hapus_gambar === true) {
        paketData.gambar = null;
        if (existing.gambar) {
          oldImageToDelete = path.join(__dirname, "..", "public", existing.gambar);
        }
      }

      await Paket.update(id, paketData, parsedItems);

      // Hapus file gambar lama jika diganti
      if (oldImageToDelete && fs.existsSync(oldImageToDelete)) {
        try { fs.unlinkSync(oldImageToDelete); } catch (e) { }
      }

      // Audit Log
      await AuditLog.create({
        userId: req.user?.userId,
        userName: req.user?.nama,
        action: "UPDATE",
        entityType: "Paket Peminjaman",
        entityId: id,
        details: `Memperbarui template paket: ${nama_paket}`,
      });

      res.json({
        success: true,
        message: "Template paket berhasil diperbarui!",
      });
    } catch (error) {
      console.error("Error update paket:", error);
      res.status(500).json({ success: false, message: "Gagal memperbarui paket", error: error.message });
    }
  },

  // DELETE /api/paket/:id
  delete: async (req, res) => {
    try {
      const { id } = req.params;
      const existing = await Paket.getById(id);
      if (!existing) {
        return res.status(404).json({ success: false, message: "Paket tidak ditemukan" });
      }

      await Paket.delete(id);

      // Hapus gambar jika ada
      if (existing.gambar) {
        const fullPath = path.join(__dirname, "..", "public", existing.gambar);
        if (fs.existsSync(fullPath)) {
          try { fs.unlinkSync(fullPath); } catch (e) { }
        }
      }

      // Audit Log
      await AuditLog.create({
        userId: req.user?.userId,
        userName: req.user?.nama,
        action: "DELETE",
        entityType: "Paket Peminjaman",
        entityId: id,
        details: `Menghapus template paket: ${existing.nama_paket}`,
      });

      res.json({
        success: true,
        message: "Template paket berhasil dihapus!",
      });
    } catch (error) {
      console.error("Error delete paket:", error);
      res.status(500).json({ success: false, message: "Gagal menghapus paket", error: error.message });
    }
  },

  // DELETE /api/paket/bulk/delete-all (Super Admin only)
  deleteAll: async (req, res) => {
    try {
      const deletedImages = await Paket.deleteAll();

      // Bersihkan file gambar
      deletedImages.forEach(img => {
        if (img) {
          const fullPath = path.join(__dirname, "..", "public", img);
          if (fs.existsSync(fullPath)) {
            try { fs.unlinkSync(fullPath); } catch (e) { }
          }
        }
      });

      // Audit Log
      await AuditLog.create({
        userId: req.user?.userId,
        userName: req.user?.nama,
        action: "DELETE",
        entityType: "System",
        entityId: "ALL",
        details: "SUPER ADMIN menghapus seluruh template paket peminjaman",
      });

      res.json({
        success: true,
        message: "Seluruh template paket berhasil dihapus dan ID telah di-reset ke 1!",
      });
    } catch (error) {
      console.error("Error deleteAll paket:", error);
      res.status(500).json({ success: false, message: "Gagal menghapus seluruh paket", error: error.message });
    }
  },
};

module.exports = paketController;
