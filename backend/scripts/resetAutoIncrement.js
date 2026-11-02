const db = require("../config/db");

async function resetAutoIncrement() {
  const tables = [
    "assets",
    "asset_units",
    "aksesoris",
    "aksesoris_units",
    "categories",
    "brands",
    "peminjaman",
    "peminjaman_items",
    "audit_logs",
    "notifications",
  ];

  console.log("==========================================");
  console.log("  RESET AUTO_INCREMENT KE 1               ");
  console.log("==========================================\n");

  for (const table of tables) {
    try {
      await db.query(`ALTER TABLE \`${table}\` AUTO_INCREMENT = 1`);
      console.log(`✅ [${table}] AUTO_INCREMENT berhasil diatur kembali ke 1`);
    } catch (err) {
      console.error(`❌ [${table}] Gagal: ${err.message}`);
    }
  }

  console.log("\nSelesai! Jika tabel kosong, ID data berikutnya akan mulai dari 1.");
  console.log("Catatan: Jika tabel masih berisi data, MySQL akan mengatur ID berikutnya ke (ID tertinggi saat ini + 1).");
  process.exit(0);
}

resetAutoIncrement();
