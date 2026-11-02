import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";
import * as XLSX from "xlsx";
import ExcelJS from "exceljs";
import { getAllCategories } from "./categoryService";
import { getAllBrands } from "./brandService";

/**
 * Export data to PDF using jsPDF and jspdf-autotable
 * @param {Array} columns - Array of column objects { header: 'Name', dataKey: 'key' }
 * @param {Array} data - Array of objects matching dataKeys
 * @param {String} filename - Output filename
 * @param {String} title - Title printed on the PDF document
 */
export const exportToPDF = (columns, data, filename = "Report.pdf", title = "Laporan") => {
  const doc = new jsPDF();

  // Add Title
  doc.setFontSize(16);
  doc.text(title, 14, 15);
  doc.setFontSize(10);
  doc.text(`Tanggal Cetak: ${new Date().toLocaleDateString("id-ID")}`, 14, 22);

  // Generate Table
  autoTable(doc, {
    startY: 28,
    head: [columns.map(col => col.header)],
    body: data.map(item => columns.map(col => item[col.dataKey] || "-")),
    theme: 'grid',
    styles: { fontSize: 8, cellPadding: 2 },
    headStyles: { fillColor: [51, 65, 85] }, // slate-700
    alternateRowStyles: { fillColor: [248, 250, 252] }, // slate-50
  });

  doc.save(filename);
};

/**
 * Export data to Excel as an Official Native Excel Table using ExcelJS
 * @param {Array} columns - Array of column objects { header: 'Name', dataKey: 'key' }
 * @param {Array} data - Array of objects matching dataKeys
 * @param {String} filename - Output filename
 * @param {String} sheetName - Worksheet name
 */
export const exportToExcel = async (columns, data, filename = "Report.xlsx", sheetName = "Data") => {
  const workbook = new ExcelJS.Workbook();
  workbook.creator = "Galeria Asset Management";
  workbook.created = new Date();

  const worksheet = workbook.addWorksheet(sheetName, {
    views: [{ showGridLines: true }]
  });

  // Table columns definition
  const tableColumns = columns.map(col => ({
    name: col.header,
    filterButton: true,
  }));

  // Row data: 2D array [ [valCol1, valCol2, ...], ... ]
  const rows = data.map(item => {
    return columns.map(col => {
      const val = item[col.dataKey];
      if (val === null || val === undefined) return "-";
      return val;
    });
  });

  // Sanitized unique table name (alphanumeric and underscores only)
  const safeTableName = `Table_${sheetName.replace(/[^a-zA-Z0-9]/g, "_")}_${Date.now()}`;

  // Add native official Excel table
  worksheet.addTable({
    name: safeTableName,
    ref: "A1",
    headerRow: true,
    totalsRow: false,
    style: {
      theme: "TableStyleMedium9", // Modern blue/navy theme with zebra stripes & border
      showRowStripes: true,
    },
    columns: tableColumns,
    rows: rows.length > 0 ? rows : [columns.map(() => "-")],
  });

  // Auto-fit column widths based on maximum content length
  columns.forEach((col, idx) => {
    let maxLen = col.header ? String(col.header).length : 10;
    data.forEach(item => {
      const val = item[col.dataKey];
      if (val !== null && val !== undefined) {
        const str = String(val);
        if (str.length > maxLen) {
          maxLen = str.length;
        }
      }
    });

    const worksheetColumn = worksheet.getColumn(idx + 1);
    worksheetColumn.width = Math.min(Math.max(maxLen + 4, 14), 45);
    worksheetColumn.alignment = { vertical: "middle", horizontal: "left" };
  });

  // Generate binary buffer & trigger download in browser
  const buffer = await workbook.xlsx.writeBuffer();
  const blob = new Blob([buffer], {
    type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  });
  const url = window.URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  window.URL.revokeObjectURL(url);
};

/**
 * Export template Excel dengan dropdown data validation untuk mencegah typo pengisian data
 * @param {Array} columns - Array of column objects { header: 'Name', dataKey: 'key' }
 * @param {Array} data - Sample data
 * @param {String} filename - Output filename
 * @param {String} sheetName - Worksheet name
 * @param {Object} validations - Map of dataKey -> Array of options (e.g. { jenisAset: ["Galeria Production", "Galeria Studio"] })
 */
export const exportTemplateToExcel = async (
  columns,
  data,
  filename = "Template.xlsx",
  sheetName = "Template",
  validations = {}
) => {
  const workbook = new ExcelJS.Workbook();
  workbook.creator = "Galeria Asset Management";
  workbook.created = new Date();

  // 1. Lembar utama (Template input)
  const worksheet = workbook.addWorksheet(sheetName, {
    views: [{ showGridLines: true }],
  });

  // 2. Lembar referensi (Daftar Opsi / Dropdown)
  const refSheet = workbook.addWorksheet("Referensi", {
    views: [{ showGridLines: true }],
  });

  // Table columns definition
  const tableColumns = columns.map((col) => ({
    name: col.header,
    filterButton: true,
  }));

  // Row data: 2D array [ [valCol1, valCol2, ...], ... ]
  const rows = data.map((item) => {
    return columns.map((col) => {
      const val = item[col.dataKey];
      if (val === null || val === undefined) return "";
      return val;
    });
  });

  const safeTableName = `Table_${sheetName.replace(/[^a-zA-Z0-9]/g, "_")}_${Date.now()}`;

  // Add native official Excel table
  worksheet.addTable({
    name: safeTableName,
    ref: "A1",
    headerRow: true,
    totalsRow: false,
    style: {
      theme: "TableStyleMedium9",
      showRowStripes: true,
    },
    columns: tableColumns,
    rows: rows.length > 0 ? rows : [columns.map(() => "")],
  });

  // Helper konversi index kolom (1-based) ke huruf Excel (A, B, ..., Z, AA, AB, ...)
  const getColLetter = (n) => {
    let s = "";
    while (n > 0) {
      const m = (n - 1) % 26;
      s = String.fromCharCode(65 + m) + s;
      n = Math.floor((n - m) / 26);
    }
    return s;
  };

  // Isi data referensi ke sheet "Referensi"
  let refColIdx = 1;
  const validationMap = {};

  Object.entries(validations).forEach(([key, options]) => {
    if (Array.isArray(options) && options.length > 0) {
      const letter = getColLetter(refColIdx);
      const colHeader = columns.find(c => c.dataKey === key)?.header || key;

      // Header kolom di sheet Referensi
      const headerCell = refSheet.getCell(1, refColIdx);
      headerCell.value = colHeader;
      headerCell.font = { bold: true, color: { argb: "FFFFFFFF" } };
      headerCell.fill = {
        type: "pattern",
        pattern: "solid",
        fgColor: { argb: "FF334155" }, // slate-700
      };

      // Tulis opsi baris per baris
      options.forEach((opt, rIdx) => {
        refSheet.getCell(rIdx + 2, refColIdx).value = opt;
      });

      refSheet.getColumn(refColIdx).width = Math.min(Math.max(colHeader.length + 4, 18), 40);

      validationMap[key] = {
        colLetter: letter,
        count: options.length,
        // Kategori dan merek diizinkan custom (jika tidak ada di dropdown, pengguna bisa ketik sendiri)
        isCustomAllowed: ["kategori", "merek"].includes(key),
      };

      refColIdx++;
    }
  });

  // Terapkan data validation ke baris 2 s.d 500 di sheet utama
  columns.forEach((col, idx) => {
    const colNumber = idx + 1;
    const vInfo = validationMap[col.dataKey];
    if (vInfo) {
      const formula = `'Referensi'!$${vInfo.colLetter}$2:$${vInfo.colLetter}$${vInfo.count + 1}`;
      for (let r = 2; r <= 500; r++) {
        const cell = worksheet.getCell(r, colNumber);
        if (vInfo.isCustomAllowed) {
          // Dropdown aktif, dan TIDAK diblokir jika user mengetikkan kategori/merek baru
          cell.dataValidation = {
            type: "list",
            allowBlank: true,
            formulae: [formula],
            showErrorMessage: false, // Bebas ketik nilai baru jika belum terdaftar
            showInputMessage: true,
            promptTitle: `Pilihan ${col.header}`,
            prompt: `Pilih ${col.header} dari daftar dropdown, atau ketik nama baru jika belum terdaftar di sistem.`,
          };
        } else {
          // Dropdown ketat untuk pilihan enum tetap (jenis brand, kondisi, tipe perhitungan harga)
          cell.dataValidation = {
            type: "list",
            allowBlank: true,
            formulae: [formula],
            showErrorMessage: true,
            errorTitle: "Pilihan Tidak Valid",
            error: `Silakan pilih salah satu opsi dari daftar pilihan ${col.header}.`,
          };
        }
      }
    }
  });

  // Auto-fit column widths based on maximum content length
  columns.forEach((col, idx) => {
    let maxLen = col.header ? String(col.header).length : 10;
    data.forEach((item) => {
      const val = item[col.dataKey];
      if (val !== null && val !== undefined) {
        const str = String(val);
        if (str.length > maxLen) {
          maxLen = str.length;
        }
      }
    });

    const worksheetColumn = worksheet.getColumn(idx + 1);
    worksheetColumn.width = Math.min(Math.max(maxLen + 4, 16), 45);
    worksheetColumn.alignment = { vertical: "middle", horizontal: "left" };
  });

  // Generate binary buffer & trigger download in browser
  const buffer = await workbook.xlsx.writeBuffer();
  const blob = new Blob([buffer], {
    type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  });
  const url = window.URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  window.URL.revokeObjectURL(url);
};

/**
 * Download Template Excel untuk Import Aset
 * @param {Array} customCats - Opsional daftar kategori
 * @param {Array} customBrands - Opsional daftar merek
 */
export const downloadAssetTemplate = async (customCats = null, customBrands = null) => {
  const columns = [
    { header: "Nama Aset", dataKey: "namaAset" },
    { header: "Jenis Brand", dataKey: "jenisAset" },
    { header: "Kategori", dataKey: "kategori" },
    { header: "Merek", dataKey: "merek" },
    { header: "Model", dataKey: "model" },
    { header: "Jumlah", dataKey: "jumlah" },
    { header: "Harga Aset", dataKey: "hargaAset" },
    { header: "Tipe Perhitungan Harga", dataKey: "tipeHarga" },
    { header: "Tanggal Pembelian", dataKey: "tanggalPembelian" },
    { header: "Lokasi Aset", dataKey: "lokasiAset" },
    { header: "Kondisi", dataKey: "kondisi" },
    { header: "Pengelola", dataKey: "pengguna" },
    { header: "Serial Number", dataKey: "noSN" },
    { header: "Spesifikasi", dataKey: "spesifikasi" },
    { header: "Keterangan", dataKey: "keterangan" },
  ];

  const sampleData = [
    {
      namaAset: "Sony Alpha 7 III Body",
      jenisAset: "Galeria Production",
      kategori: "Kamera",
      merek: "Sony",
      model: "ILCE-7M3",
      jumlah: 1,
      hargaAset: 25000000,
      tipeHarga: "Per Unit",
      tanggalPembelian: "2024-01-15",
      lokasiAset: "Lemari Kamera A",
      kondisi: "Siap Digunakan",
      pengguna: "John Doe",
      noSN: "SN-98765432",
      spesifikasi: "24.2 MP, 4K HDR, Full-Frame",
      keterangan: "Lengkap dengan strap & charger",
    },
    {
      namaAset: "Videotron P3.9 Indoor (1 Box 6 Kabinet)",
      jenisAset: "Galeria Production",
      kategori: "Videotron",
      merek: "Absen",
      model: "P3.9",
      jumlah: 6,
      hargaAset: 25000000,
      tipeHarga: "Per Paket",
      tanggalPembelian: "2024-03-20",
      lokasiAset: "Gudang Utama",
      kondisi: "Siap Digunakan",
      pengguna: "Jane Smith",
      noSN: "",
      spesifikasi: "1 Box isi 6 kabinet, harga 25 jt per paket box",
      keterangan: "Harga Per Paket (otomatis dihitung Rp 4.166.667 / kabinet saat dipinjam)",
    },
  ];

  // Ambil daftar kategori & merek dari Kelola Kategori & Merek
  let categoriesList = [];
  let brandsList = [];

  if (Array.isArray(customCats) && customCats.length > 0) {
    categoriesList = customCats.map(c => typeof c === "string" ? c : c.nama).filter(Boolean);
  } else {
    try {
      const cats = await getAllCategories("aset");
      categoriesList = (cats || []).map(c => c.nama).filter(Boolean);
    } catch (e) {
      console.warn("Gagal mengambil data kategori dari server:", e);
    }
  }

  if (Array.isArray(customBrands) && customBrands.length > 0) {
    brandsList = customBrands.map(b => typeof b === "string" ? b : b.nama).filter(Boolean);
  } else {
    try {
      const brands = await getAllBrands("aset");
      brandsList = (brands || []).map(b => b.nama).filter(Boolean);
    } catch (e) {
      console.warn("Gagal mengambil data merek dari server:", e);
    }
  }

  // Fallback defaults jika server offline / data kosong
  if (categoriesList.length === 0) {
    categoriesList = ["Kamera", "Videotron", "Lensa", "Audio", "Lighting", "Monitor", "Drone", "Broadcast"];
  }
  if (brandsList.length === 0) {
    brandsList = ["Sony", "Canon", "Blackmagic", "DJI", "Absen", "Aputure", "Sennheiser", "Yamaha"];
  }

  const templateValidations = {
    jenisAset: ["Galeria Production", "Galeria Studio"],
    kategori: categoriesList,
    merek: brandsList,
    tipeHarga: ["Per Unit", "Per Paket"],
    kondisi: ["Siap Digunakan", "Maintenance", "Rusak"],
  };

  await exportTemplateToExcel(columns, sampleData, "Template_Import_Aset.xlsx", "Template_Aset", templateValidations);
};

/**
 * Download Template Excel untuk Import Aksesoris
 * @param {Array} customCats - Opsional daftar kategori
 * @param {Array} customBrands - Opsional daftar merek
 */
export const downloadAksesorisTemplate = async (customCats = null, customBrands = null) => {
  const columns = [
    { header: "Nama Aksesoris", dataKey: "namaAksesoris" },
    { header: "Jenis Brand", dataKey: "jenisAset" },
    { header: "Kategori", dataKey: "kategori" },
    { header: "Merek", dataKey: "merek" },
    { header: "Model", dataKey: "model" },
    { header: "Jumlah Unit", dataKey: "jumlahUnit" },
    { header: "Harga Aset", dataKey: "hargaAset" },
    { header: "Tipe Perhitungan Harga", dataKey: "tipeHarga" },
    { header: "Tanggal Pembelian", dataKey: "tanggalPembelian" },
    { header: "Lokasi", dataKey: "lokasi" },
    { header: "Kondisi", dataKey: "kondisi" },
    { header: "Keterangan", dataKey: "keterangan" },
  ];

  const sampleData = [
    {
      namaAksesoris: "Baterai Sony NP-FZ100",
      jenisAset: "Galeria Production",
      kategori: "Baterai",
      merek: "Sony",
      model: "NP-FZ100",
      jumlahUnit: 4,
      hargaAset: 1100000,
      tipeHarga: "Per Unit",
      tanggalPembelian: "2024-02-10",
      lokasi: "Kotak Baterai 1",
      kondisi: "Siap Digunakan",
      keterangan: "Baterai cadangan kamera Sony",
    },
    {
      namaAksesoris: "Kabel Set Audio XLR (Isi 10 Pcs)",
      jenisAset: "Galeria Production",
      kategori: "Kabel",
      merek: "Canare",
      model: "L-2T2S",
      jumlahUnit: 10,
      hargaAset: 1500000,
      tipeHarga: "Per Paket",
      tanggalPembelian: "2024-03-01",
      lokasi: "Kotak Audio",
      kondisi: "Siap Digunakan",
      keterangan: "Paket 1 bundle isi 10 kabel",
    },
  ];

  // Ambil daftar kategori & merek dari Kelola Kategori & Merek
  let categoriesList = [];
  let brandsList = [];

  if (Array.isArray(customCats) && customCats.length > 0) {
    categoriesList = customCats.map(c => typeof c === "string" ? c : c.nama).filter(Boolean);
  } else {
    try {
      const cats = await getAllCategories("aksesoris");
      categoriesList = (cats || []).map(c => c.nama).filter(Boolean);
    } catch (e) {
      console.warn("Gagal mengambil data kategori aksesoris dari server:", e);
    }
  }

  if (Array.isArray(customBrands) && customBrands.length > 0) {
    brandsList = customBrands.map(b => typeof b === "string" ? b : b.nama).filter(Boolean);
  } else {
    try {
      const brands = await getAllBrands("aksesoris");
      brandsList = (brands || []).map(b => b.nama).filter(Boolean);
    } catch (e) {
      console.warn("Gagal mengambil data merek aksesoris dari server:", e);
    }
  }

  if (categoriesList.length === 0) {
    categoriesList = ["Baterai", "Kabel", "Charger", "Media Simpan", "Audio", "Lighting Stand", "Filter Lensa"];
  }
  if (brandsList.length === 0) {
    brandsList = ["Sony", "Canare", "Godox", "SmallRig", "SanDisk", "Uticon", "Broco"];
  }

  const templateValidations = {
    jenisAset: ["Galeria Production", "Galeria Studio"],
    kategori: categoriesList,
    merek: brandsList,
    tipeHarga: ["Per Unit", "Per Paket"],
    kondisi: ["Siap Digunakan", "Maintenance", "Rusak"],
  };

  await exportTemplateToExcel(columns, sampleData, "Template_Import_Aksesoris.xlsx", "Template_Aksesoris", templateValidations);
};

/**
 * Parse file Excel (.xlsx / .xls) menjadi array of objects menggunakan XLSX
 * @param {File} file
 * @returns {Promise<Array>}
 */
export const parseExcelFile = (file) => {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      try {
        const data = new Uint8Array(e.target.result);
        const workbook = XLSX.read(data, { type: "array" });
        if (!workbook.SheetNames || workbook.SheetNames.length === 0) {
          throw new Error("File Excel tidak memiliki sheet yang valid.");
        }
        const firstSheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[firstSheetName];
        const json = XLSX.utils.sheet_to_json(worksheet, { defval: "", raw: false, dateNF: "yyyy-mm-dd" });
        resolve(json);
      } catch (err) {
        reject(err);
      }
    };
    reader.onerror = (err) => reject(err);
    reader.readAsArrayBuffer(file);
  });
};

export const normalizeDate = (val) => {
  if (!val) return "";
  if (typeof val === "number" || (!isNaN(val) && !isNaN(parseFloat(val)) && isFinite(val) && Number(val) > 10000 && Number(val) < 100000)) {
    const excelEpoch = new Date(Date.UTC(1899, 11, 30));
    const date = new Date(excelEpoch.getTime() + Number(val) * 86400000);
    if (!isNaN(date.getTime())) {
      return date.toISOString().split("T")[0];
    }
  }
  const str = String(val).trim();
  if (!str) return "";
  const ymdMatch = str.match(/^(\d{4})[-/.](\d{1,2})[-/.](\d{1,2})/);
  if (ymdMatch) {
    const year = ymdMatch[1];
    const month = String(ymdMatch[2]).padStart(2, "0");
    const day = String(ymdMatch[3]).padStart(2, "0");
    return `${year}-${month}-${day}`;
  }
  const dmyMatch = str.match(/^(\d{1,2})[-/.](\d{1,2})[-/.](\d{4})/);
  if (dmyMatch) {
    const day = String(dmyMatch[1]).padStart(2, "0");
    const month = String(dmyMatch[2]).padStart(2, "0");
    const year = dmyMatch[3];
    return `${year}-${month}-${day}`;
  }
  const parsed = new Date(str);
  if (!isNaN(parsed.getTime())) {
    const y = parsed.getFullYear();
    const m = String(parsed.getMonth() + 1).padStart(2, "0");
    const d = String(parsed.getDate()).padStart(2, "0");
    if (y > 1900 && y < 2100) {
      return `${y}-${m}-${d}`;
    }
  }
  return str;
};

