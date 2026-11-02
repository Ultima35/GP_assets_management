const express = require('express');
const router = express.Router();
const auditController = require('../controllers/auditController');
const { verifyToken, requireRole } = require('../middlewares/authMiddleware');

// Hanya admin dan super admin yang bisa melihat log
router.get('/', verifyToken, requireRole('super admin', 'admin'), auditController.getAll);

// Khusus super admin: Hapus seluruh log audit
router.delete('/bulk/delete-all', verifyToken, requireRole('super admin'), auditController.deleteAll);

module.exports = router;
