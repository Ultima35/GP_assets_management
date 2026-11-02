const Category = require("../models/categoryModel");
const db = require("../config/db");
const AuditLog = require("../models/auditModel");

const categoryController = {
  getAll: async (req, res) => {
    try {
      const { tipe } = req.query;
      const categories = tipe ? await Category.getByTipe(tipe) : await Category.getAll();
      res.json({ success: true, data: categories });
    } catch (error) {
      console.error("Error getAll categories:", error);
      res.status(500).json({ success: false, message: "Gagal mengambil data kategori" });
    }
  },

  create: async (req, res) => {
    try {
      const { nama, kode_singkat, tipe } = req.body;
      if (!nama || !kode_singkat) {
        return res.status(400).json({ success: false, message: "Nama dan Kode Singkat wajib diisi" });
      }

      const categoryTipe = tipe || "aset";
      const existing = await Category.findByNama(nama, categoryTipe);
      if (existing) {
        return res.status(409).json({ success: false, message: "Kategori sudah ada" });
      }

      const newCategory = await Category.create(nama, kode_singkat, categoryTipe);
      res.status(201).json({ success: true, message: "Kategori berhasil ditambahkan", data: newCategory });
    } catch (error) {
      console.error("Error create category:", error);
      if (error.code === "ER_DUP_ENTRY") {
        return res.status(409).json({ success: false, message: "Nama atau Kode Singkat kategori sudah ada" });
      }
      res.status(500).json({ success: false, message: "Gagal menambahkan kategori" });
    }
  },

  update: async (req, res) => {
    try {
      const { id } = req.params;
      const { nama, kode_singkat } = req.body;
      if (!nama || !kode_singkat) {
        return res.status(400).json({ success: false, message: "Nama dan Kode Singkat wajib diisi" });
      }

      const existingCategory = await Category.findById(id);
      if (!existingCategory) {
        return res.status(404).json({ success: false, message: "Kategori tidak ditemukan" });
      }

      // Check duplicate name
      const duplicate = await Category.findByNama(nama, existingCategory.tipe);
      if (duplicate && duplicate.id !== parseInt(id)) {
        return res.status(409).json({ success: false, message: "Nama kategori sudah digunakan" });
      }

      await Category.update(id, existingCategory.nama, nama, kode_singkat, existingCategory.tipe);
      res.json({ success: true, message: "Kategori berhasil diperbarui" });
    } catch (error) {
      console.error("Error update category:", error);
      if (error.code === "ER_DUP_ENTRY") {
        return res.status(409).json({ success: false, message: "Nama atau Kode Singkat kategori sudah ada" });
      }
      res.status(500).json({ success: false, message: "Gagal memperbarui kategori" });
    }
  },

  delete: async (req, res) => {
    try {
      const { id } = req.params;
      const affectedRows = await Category.delete(id);
      if (affectedRows === 0) {
        return res.status(404).json({ success: false, message: "Kategori tidak ditemukan" });
      }
      res.json({ success: true, message: "Kategori berhasil dihapus" });
    } catch (error) {
      console.error("Error delete category:", error);
      res.status(500).json({ success: false, message: "Gagal menghapus kategori" });
    }
  },

  // DELETE /api/categories/bulk/delete-all (Super Admin only)
  deleteAll: async (req, res) => {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();

      const { target = "both" } = req.body || {}; // "both", "categories", "brands"

      let detailTarget = "";
      if (target === "categories" || target === "both") {
        await connection.query("DELETE FROM categories");
        await connection.query("ALTER TABLE categories AUTO_INCREMENT = 1");
        await connection.query("UPDATE assets SET kategori = NULL");
        await connection.query("UPDATE aksesoris SET kategori = NULL");
        detailTarget += "Kategori";
      }

      if (target === "brands" || target === "both") {
        await connection.query("DELETE FROM brands");
        await connection.query("ALTER TABLE brands AUTO_INCREMENT = 1");
        await connection.query("UPDATE assets SET merek = NULL");
        await connection.query("UPDATE aksesoris SET merek = NULL");
        if (detailTarget) detailTarget += " & Merek";
        else detailTarget = "Merek";
      }

      await connection.commit();

      await AuditLog.create({
        userId: req.user?.userId,
        userName: req.user?.nama,
        action: 'DELETE',
        entityType: 'System',
        entityId: 'ALL',
        details: `SUPER ADMIN menghapus seluruh data: ${detailTarget}`
      });

      res.json({
        success: true,
        message: `Berhasil menghapus seluruh data ${detailTarget}!`,
      });
    } catch (error) {
      await connection.rollback();
      console.error("Error deleteAll categories/brands:", error);
      res.status(500).json({
        success: false,
        message: "Gagal menghapus seluruh data",
        error: error.message,
      });
    } finally {
      connection.release();
    }
  },
};

module.exports = categoryController;
