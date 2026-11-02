const db = require('../config/db');

// Helper to generate a clean 3-4 letter uppercase code from category name
function generateKodeSingkat(nama, existingKodes) {
  const cleaned = (nama || '').replace(/[^a-zA-Z0-9\s]/g, '').trim();
  const words = cleaned.split(/\s+/).filter(Boolean);
  let code = '';
  
  if (words.length >= 2) {
    code = (words[0].slice(0, 2) + words[1].slice(0, 2)).toUpperCase();
  } else if (words.length === 1) {
    code = words[0].slice(0, 4).toUpperCase();
  } else {
    code = 'GEN';
  }

  // Ensure code uniqueness
  let finalCode = code;
  let counter = 1;
  while (existingKodes.has(finalCode)) {
    finalCode = (code.slice(0, 3) + counter).toUpperCase();
    counter++;
  }
  existingKodes.add(finalCode);
  return finalCode;
}

async function sync() {
  console.log('--- Memulai Sinkronisasi Kategori & Merek ---');

  // 1. Bersihkan spasi di data categories dan brands yang sudah ada
  await db.query(`UPDATE categories SET nama = TRIM(nama), kode_singkat = TRIM(UPPER(kode_singkat))`);
  await db.query(`UPDATE brands SET nama = TRIM(nama)`);

  // 2. Ambil kategori yang sudah ada
  const [existingCats] = await db.query(`SELECT id, LOWER(TRIM(nama)) as nama_lower, kode_singkat, tipe FROM categories`);
  const catMap = new Map(); // key: "nama_lower|tipe" -> item
  const existingKodes = new Set();
  for (const c of existingCats) {
    catMap.set(`${c.nama_lower}|${c.tipe}`, c);
    if (c.kode_singkat) existingKodes.add(c.kode_singkat.toUpperCase());
  }

  // 3. Ambil kategori unik dari tabel assets
  const [assetCats] = await db.query(`
    SELECT DISTINCT TRIM(kategori) as kategori 
    FROM assets 
    WHERE kategori IS NOT NULL AND TRIM(kategori) != ''
  `);

  let addedAssetCats = 0;
  for (const row of assetCats) {
    const nama = row.kategori;
    const key = `${nama.toLowerCase()}|aset`;
    if (!catMap.has(key)) {
      const kode = generateKodeSingkat(nama, existingKodes);
      await db.query(
        `INSERT INTO categories (nama, kode_singkat, tipe) VALUES (?, ?, 'aset')`,
        [nama, kode]
      );
      catMap.set(key, { nama, kode_singkat: kode, tipe: 'aset' });
      addedAssetCats++;
      console.log(`+ Added Kategori Aset: ${nama} (${kode})`);
    }
  }

  // 4. Ambil kategori unik dari tabel aksesoris
  const [aksCats] = await db.query(`
    SELECT DISTINCT TRIM(kategori) as kategori 
    FROM aksesoris 
    WHERE kategori IS NOT NULL AND TRIM(kategori) != ''
  `);

  let addedAksCats = 0;
  for (const row of aksCats) {
    const nama = row.kategori;
    const key = `${nama.toLowerCase()}|aksesoris`;
    if (!catMap.has(key)) {
      const kode = generateKodeSingkat(nama, existingKodes);
      await db.query(
        `INSERT INTO categories (nama, kode_singkat, tipe) VALUES (?, ?, 'aksesoris')`,
        [nama, kode]
      );
      catMap.set(key, { nama, kode_singkat: kode, tipe: 'aksesoris' });
      addedAksCats++;
      console.log(`+ Added Kategori Aksesoris: ${nama} (${kode})`);
    }
  }

  // 5. Ambil merek yang sudah ada
  const [existingBrands] = await db.query(`SELECT id, LOWER(TRIM(nama)) as nama_lower, tipe FROM brands`);
  const brandMap = new Map();
  for (const b of existingBrands) {
    brandMap.set(`${b.nama_lower}|${b.tipe}`, b);
  }

  // 6. Ambil merek unik dari tabel assets
  const [assetBrands] = await db.query(`
    SELECT DISTINCT TRIM(merek) as merek 
    FROM assets 
    WHERE merek IS NOT NULL AND TRIM(merek) != ''
  `);

  let addedAssetBrands = 0;
  for (const row of assetBrands) {
    const nama = row.merek;
    const key = `${nama.toLowerCase()}|aset`;
    if (!brandMap.has(key)) {
      await db.query(
        `INSERT INTO brands (nama, tipe) VALUES (?, 'aset')`,
        [nama]
      );
      brandMap.set(key, { nama, tipe: 'aset' });
      addedAssetBrands++;
      console.log(`+ Added Merek Aset: ${nama}`);
    }
  }

  // 7. Ambil merek unik dari tabel aksesoris
  const [aksBrands] = await db.query(`
    SELECT DISTINCT TRIM(merek) as merek 
    FROM aksesoris 
    WHERE merek IS NOT NULL AND TRIM(merek) != ''
  `);

  let addedAksBrands = 0;
  for (const row of aksBrands) {
    const nama = row.merek;
    const key = `${nama.toLowerCase()}|aksesoris`;
    if (!brandMap.has(key)) {
      await db.query(
        `INSERT INTO brands (nama, tipe) VALUES (?, 'aksesoris')`,
        [nama]
      );
      brandMap.set(key, { nama, tipe: 'aksesoris' });
      addedAksBrands++;
      console.log(`+ Added Merek Aksesoris: ${nama}`);
    }
  }

  console.log(`Sinkronisasi Selesai!`);
  console.log(`- Kategori Aset baru ditambahkan: ${addedAssetCats}`);
  console.log(`- Kategori Aksesoris baru ditambahkan: ${addedAksCats}`);
  console.log(`- Merek Aset baru ditambahkan: ${addedAssetBrands}`);
  console.log(`- Merek Aksesoris baru ditambahkan: ${addedAksBrands}`);
}

sync()
  .catch(console.error)
  .finally(() => process.exit());
