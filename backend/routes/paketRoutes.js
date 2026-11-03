const express = require("express");
const router = express.Router();
const multer = require("multer");
const path = require("path");
const paketController = require("../controllers/paketController");
const { verifyToken, requireRole } = require("../middlewares/authMiddleware");

// Konfigurasi Multer
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, "..", "public", "uploads"));
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    const ext = path.extname(file.originalname);
    cb(null, `paket-${uniqueSuffix}${ext}`);
  },
});

const fileFilter = (req, file, cb) => {
  const allowedTypes = ["image/jpeg", "image/jpg", "image/png", "image/heic", "image/heif", "image/webp"];
  const allowedExtensions = [".jpg", ".jpeg", ".png", ".heic", ".heif", ".webp"];
  const ext = path.extname(file.originalname).toLowerCase();
  if (allowedTypes.includes(file.mimetype) || allowedExtensions.includes(ext)) {
    cb(null, true);
  } else {
    cb(new Error("Hanya file JPG, JPEG, PNG, HEIC, dan WebP yang diperbolehkan"), false);
  }
};

const upload = multer({
  storage,
  fileFilter,
  limits: { fileSize: 5 * 1024 * 1024 } // 5MB
});

// Priority route: bulk delete
router.delete("/bulk/delete-all", verifyToken, requireRole("super admin"), paketController.deleteAll);

// CRUD routes
router.get("/", verifyToken, paketController.getAll);
router.get("/:id", verifyToken, paketController.getById);
router.post("/", verifyToken, requireRole("super admin", "admin"), upload.single("gambar"), paketController.create);
router.put("/:id", verifyToken, requireRole("super admin", "admin"), upload.single("gambar"), paketController.update);
router.delete("/:id", verifyToken, requireRole("super admin", "admin"), paketController.delete);

module.exports = router;
