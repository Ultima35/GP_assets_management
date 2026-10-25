"use client";

import { useState, useEffect, useCallback, useRef } from "react";
import { createPortal } from "react-dom";
import Image from "next/image";
import { useRouter } from "next/navigation";
import { createPeminjaman, getNextKodePinjam } from "../../../lib/peminjamanService";
import { getAllAssets } from "../../../lib/assetService";
import { getAllAksesoris } from "../../../lib/aksesorisService";
import { getActivePegawai, getApprovers } from "../../../lib/pegawaiService";
import api from "../../../lib/api";
import { getUserContext } from "../../../lib/authService";
import { toCapitalEachWord, toSentenceCase } from "../../../lib/stringUtils";
import { ChevronLeft, FileText, Package, Plus, X, Check, AlertTriangle, Camera, Trash2, Grid, Image as ImageIcon, Search, Layers, Minus, Info } from "lucide-react";

const getBackendURL = () => {
  if (process.env.NEXT_PUBLIC_API_URL) {
    return process.env.NEXT_PUBLIC_API_URL.replace(/\/api$/, '');
  }
  if (typeof window !== "undefined") {
    return `http://${window.location.hostname}:5000`;
  }
  return "http://localhost:5000";
};
const BACKEND_URL = getBackendURL();

const getImageUrl = (gambar) => {
  if (!gambar) return null;
  if (gambar.startsWith("http")) return gambar;
  return `${BACKEND_URL}${gambar}`;
};

function ItemThumbnail({ src, alt, width = 150, height = 150, className = "w-full h-full object-cover", iconSize = "w-8 h-8" }) {
  const [failedSrc, setFailedSrc] = useState(null);
  const imageUrl = getImageUrl(src);

  if (!imageUrl || failedSrc === imageUrl) {
    return <Package className={`${iconSize} text-slate-400`} />;
  }

  return (
    <Image
      src={imageUrl}
      alt={alt || "Gambar Item"}
      width={width}
      height={height}
      unoptimized
      onError={() => setFailedSrc(imageUrl)}
      className={className}
    />
  );
}

export default function TambahPeminjamanPage() {
  const router = useRouter();

  // User & Auth State
  const [userRole, setUserRole] = useState("");
  const [userId, setUserId] = useState(null);
  const [userName, setUserName] = useState("");

  // Form Data State
  const [kodePinjam, setKodePinjam] = useState("");
  const [namaPeminjam, setNamaPeminjam] = useState("");
  const [yangMenyerahkan, setYangMenyerahkan] = useState("");
  const [tanggalPeminjaman, setTanggalPeminjaman] = useState("");
  const [keperluanList, setKeperluanList] = useState([{ keperluan: "" }]);
  const [items, setItems] = useState([]);
  const [buktiFiles, setBuktiFiles] = useState([]);
  const [buktiPreviews, setBuktiPreviews] = useState([]);

  // Dropdown Data State
  const [pegawaiList, setPegawaiList] = useState([]);
  const [approversList, setApproversList] = useState([]);
  const [allItems, setAllItems] = useState([]);

  // UI State
  const [submitting, setSubmitting] = useState(false);
  const [toast, setToast] = useState(null);
  const [isLoaded, setIsLoaded] = useState(false);
  const [viewMode, setViewMode] = useState("list"); // "list" atau "grid"
  const [itemSearch, setItemSearch] = useState("");
  const [itemFilter, setItemFilter] = useState("semua"); // "semua" | "asset" | "aksesoris"
  const [brandFilter, setBrandFilter] = useState("semua"); // "semua" | "Galeria Studio" | "Galeria Production"
  const [detailModalItem, setDetailModalItem] = useState(null);
  const [modalSelectedUnitIds, setModalSelectedUnitIds] = useState([]);
  const [modalJumlah, setModalJumlah] = useState(1);
  const fileInputRef = useRef(null);
  const cameraInputRef = useRef(null);

  // Initialize user context
  useEffect(() => {
    const ctx = getUserContext();
    if (ctx) {
      setUserRole(ctx.role || "");
      setUserId(ctx.id);
      setUserName(ctx.namaLengkap || "");
      
      // Untuk non-super admin, autofill nama peminjam
      if (ctx.role !== "super admin") {
        setNamaPeminjam(ctx.namaLengkap || "");
      }
    }
  }, []);

  // Toast management
  useEffect(() => {
    if (toast) {
      const timer = setTimeout(() => setToast(null), 4000);
      return () => clearTimeout(timer);
    }
  }, [toast]);

  const showToast = (message, type = "success") => setToast({ message, type });

  // Fetch initial data
  const fetchInitialData = useCallback(async () => {
    try {
      const [kode, assets, aksesoris, pegawai, approvers] = await Promise.all([
        getNextKodePinjam(),
        getAllAssets(),
        getAllAksesoris(),
        getActivePegawai(),
        getApprovers(),
      ]);

      setKodePinjam(kode);
      setPegawaiList(pegawai);
      setApproversList(approvers);

      // Combine assets dan aksesoris
      const combined = [
        ...assets
          .filter((a) => a.kondisi !== "Dijual")
          .map((a) => {
            const tipeHarga = a.tipeHarga || "Per Unit";
            const jumlahTotal = Number(a.jumlahTotal || a.jumlah || 1);
            const hargaUnit = tipeHarga === "Per Paket" && jumlahTotal > 0
              ? Math.round((Number(a.hargaAset) || 0) / jumlahTotal)
              : (Number(a.hargaAset) || 0);

            return {
              id: a.id,
              nama: a.namaAset,
              kode: a.kodeAset,
              kategori: a.kategori,
              merek: a.merek,
              harga: hargaUnit,
              hargaAsetOriginal: a.hargaAset || 0,
              tipeHarga,
              jumlahTotal,
              stok: a.jumlah,
              kondisi: a.kondisi,
              gambar: a.gambar,
              jenisAset: a.jenisAset,
              tipe: "asset",
              units: a.units || [],
            };
          }),
        ...aksesoris
          .filter((ak) => ak.kondisi !== "Dijual")
          .map((ak) => {
            const tipeHarga = ak.tipeHarga || "Per Unit";
            const jumlahTotal = Number(ak.jumlahTotal || ak.jumlahUnit || 1);
            const hargaUnit = tipeHarga === "Per Paket" && jumlahTotal > 0
              ? Math.round((Number(ak.hargaAset) || 0) / jumlahTotal)
              : (Number(ak.hargaAset) || 0);

            return {
              id: ak.id,
              nama: ak.namaAksesoris,
              kode: ak.kodeAksesoris,
              kategori: ak.kategori,
              merek: ak.merek,
              harga: hargaUnit,
              hargaAsetOriginal: ak.hargaAset || 0,
              tipeHarga,
              jumlahTotal,
              stok: ak.jumlahUnit,
              kondisi: ak.kondisi,
              gambar: ak.gambar,
              jenisAset: ak.jenisAset,
              tipe: "aksesoris",
              units: ak.units || [],
            };
          }),
      ];
      setAllItems(combined);
    } catch (err) {
      console.error("Error fetching data:", err);
      showToast("Gagal memuat data awal", "error");
    }
  }, []);

  useEffect(() => {
    fetchInitialData();
  }, [fetchInitialData]);

  // Load temp data
  useEffect(() => {
    if (!isLoaded) {
      const saved = localStorage.getItem("tempPeminjaman");
      if (saved) {
        try {
          const parsed = JSON.parse(saved);
          // Hanya restore namaPeminjam untuk super admin (non-super admin sudah autofill)
          if (parsed.namaPeminjam && userRole === "super admin") setNamaPeminjam(parsed.namaPeminjam);
          if (parsed.yangMenyerahkan && userRole === "super admin") setYangMenyerahkan(parsed.yangMenyerahkan);
          if (parsed.tanggalPeminjaman) setTanggalPeminjaman(parsed.tanggalPeminjaman);
          if (parsed.keperluanList) setKeperluanList(parsed.keperluanList);
          if (parsed.items) setItems(parsed.items);
        } catch (e) {}
      }
      setIsLoaded(true);
    }
  }, [isLoaded, userRole]);

  // Save temp data
  useEffect(() => {
    if (isLoaded) {
      localStorage.setItem(
        "tempPeminjaman",
        JSON.stringify({
          namaPeminjam,
          yangMenyerahkan,
          tanggalPeminjaman,
          keperluanList,
          items,
        })
      );
    }
  }, [namaPeminjam, yangMenyerahkan, tanggalPeminjaman, keperluanList, items, isLoaded]);

  // File handling
  const handleFileChange = (e) => {
    const files = Array.from(e.target.files || []);
    if (files.length === 0) return;
    const validTypes = ["image/jpeg", "image/jpg", "image/png", "image/heic", "image/heif", "image/webp"];
    const validExts = [".jpg", ".jpeg", ".png", ".heic", ".heif", ".webp"];
    let filesToAdd = [];

    for (let file of files) {
      const ext = "." + (file.name.split(".").pop() || "").toLowerCase();
      if (!validTypes.includes(file.type) && !validExts.includes(ext)) {
        showToast("Format file harus JPG, JPEG, PNG, HEIC, atau WebP", "error");
        e.target.value = "";
        return;
      }
      filesToAdd.push(file);
    }

    if (buktiFiles.length + filesToAdd.length > 5) {
      showToast("Maksimal 5 gambar", "error");
      e.target.value = "";
      return;
    }

    const updated = [...buktiFiles, ...filesToAdd];
    setBuktiFiles(updated);

    const previews = updated.map((f) => URL.createObjectURL(f));
    setBuktiPreviews(previews);
    e.target.value = "";
  };

  const removeFile = (index) => {
    const updated = buktiFiles.filter((_, i) => i !== index);
    setBuktiFiles(updated);
    setBuktiPreviews(updated.map((f) => URL.createObjectURL(f)));
  };

  // Keperluan management
  const addKeperluan = () => {
    setKeperluanList([...keperluanList, { keperluan: "" }]);
  };

  const removeKeperluan = (index) => {
    if (keperluanList.length > 1) {
      setKeperluanList(keperluanList.filter((_, i) => i !== index));
    }
  };

  const updateKeperluan = (index, field, value) => {
    const updated = [...keperluanList];
    updated[index][field] = field === "keperluan" ? toSentenceCase(value) : value;
    setKeperluanList(updated);
  };

  // Unit statistics helper
  const getItemUnitStats = (item) => {
    if (!item.units || item.units.length === 0) {
      const isReady = item.kondisi === "Siap Digunakan" && (Number(item.stok) || 0) > 0;
      return {
        hasUnits: false,
        total: Number(item.jumlahTotal || item.stok || 0),
        ready: isReady ? Number(item.stok || 0) : 0,
        rusak: item.kondisi === "Rusak" ? Number(item.stok || 0) : 0,
        rusakBerat: item.kondisi === "Rusak Berat" ? Number(item.stok || 0) : 0,
        maintenance: item.kondisi === "Maintenance" ? Number(item.stok || 0) : 0,
        dipinjam: 0,
        isAvailable: isReady,
      };
    }

    const total = item.units.length;
    const ready = item.units.filter((u) => u.status_pinjam === "Tersedia" && u.kondisi === "Siap Digunakan").length;
    const rusak = item.units.filter((u) => u.kondisi === "Rusak").length;
    const rusakBerat = item.units.filter((u) => u.kondisi === "Rusak Berat").length;
    const maintenance = item.units.filter((u) => u.kondisi === "Maintenance").length;
    const dipinjam = item.units.filter((u) => u.status_pinjam === "Dipinjam").length;

    return {
      hasUnits: true,
      total,
      ready,
      rusak,
      rusakBerat,
      maintenance,
      dipinjam,
      isAvailable: ready > 0,
    };
  };

  // Unit modal management
  const openDetailModal = (item) => {
    const existing = items.find((it) => it.id === item.id && it.tipe === item.tipe);
    setDetailModalItem(item);

    if (item.units && item.units.length > 0) {
      if (existing && existing.unitIds && existing.unitIds.length > 0) {
        setModalSelectedUnitIds([...existing.unitIds]);
      } else {
        const availableIds = (item.units || [])
          .filter((u) => u.status_pinjam === "Tersedia" && u.kondisi === "Siap Digunakan")
          .map((u) => u.id);
        setModalSelectedUnitIds(availableIds);
      }
    } else {
      if (existing) {
        setModalJumlah(existing.jumlah || 1);
      } else {
        setModalJumlah(1);
      }
    }
  };

  const toggleModalUnit = (unitId, isDisabled) => {
    if (isDisabled) return;
    if (modalSelectedUnitIds.includes(unitId)) {
      setModalSelectedUnitIds(modalSelectedUnitIds.filter((id) => id !== unitId));
    } else {
      setModalSelectedUnitIds([...modalSelectedUnitIds, unitId]);
    }
  };

  const handleSaveModal = () => {
    if (!detailModalItem) return;

    const hasUnits = detailModalItem.units && detailModalItem.units.length > 0;
    const existingIndex = items.findIndex(
      (it) => it.id === detailModalItem.id && it.tipe === detailModalItem.tipe
    );

    if (hasUnits) {
      if (modalSelectedUnitIds.length === 0) {
        showToast("Pilih minimal 1 unit", "error");
        return;
      }

      const selectedUnits = (detailModalItem.units || []).filter((u) =>
        modalSelectedUnitIds.includes(u.id)
      );
      const unitNames = selectedUnits.map((u) => u.nama_unit || u.kode_unit).join(", ");

      const newItem = {
        id: detailModalItem.id,
        nama: detailModalItem.nama,
        kode: detailModalItem.kode,
        tipe: detailModalItem.tipe,
        harga: detailModalItem.harga,
        tipeHarga: detailModalItem.tipeHarga,
        hargaAsetOriginal: detailModalItem.hargaAsetOriginal,
        jumlahTotal: detailModalItem.jumlahTotal,
        stok: detailModalItem.stok,
        jumlah: modalSelectedUnitIds.length,
        kategori: detailModalItem.kategori,
        merek: detailModalItem.merek,
        jenisAset: detailModalItem.jenisAset,
        kondisi: detailModalItem.kondisi,
        hasUnits: true,
        units: detailModalItem.units,
        unitIds: modalSelectedUnitIds,
        unitNames: unitNames,
      };

      if (existingIndex >= 0) {
        const updated = [...items];
        updated[existingIndex] = newItem;
        setItems(updated);
        showToast(`Pilihan unit ${detailModalItem.nama} diperbarui (${modalSelectedUnitIds.length} unit)`, "success");
      } else {
        setItems([...items, newItem]);
        showToast(`${detailModalItem.nama} ditambahkan (${modalSelectedUnitIds.length} unit)`, "success");
      }
    } else {
      const qty = Math.max(1, Math.min(modalJumlah, detailModalItem.stok || 1));
      const newItem = {
        id: detailModalItem.id,
        nama: detailModalItem.nama,
        kode: detailModalItem.kode,
        tipe: detailModalItem.tipe,
        harga: detailModalItem.harga,
        tipeHarga: detailModalItem.tipeHarga,
        hargaAsetOriginal: detailModalItem.hargaAsetOriginal,
        jumlahTotal: detailModalItem.jumlahTotal,
        stok: detailModalItem.stok,
        jumlah: qty,
        kategori: detailModalItem.kategori,
        merek: detailModalItem.merek,
        jenisAset: detailModalItem.jenisAset,
        kondisi: detailModalItem.kondisi,
        hasUnits: false,
      };

      if (existingIndex >= 0) {
        const updated = [...items];
        updated[existingIndex] = newItem;
        setItems(updated);
        showToast(`Jumlah ${detailModalItem.nama} diperbarui (${qty} unit)`, "success");
      } else {
        setItems([...items, newItem]);
        showToast(`${detailModalItem.nama} ditambahkan (${qty} unit)`, "success");
      }
    }

    setDetailModalItem(null);
    setModalSelectedUnitIds([]);
    setModalJumlah(1);
  };

  // Item click handler
  const handleItemClick = (item) => {
    const stats = getItemUnitStats(item);

    // If item is completely unavailable, show informative error toast
    if (!stats.isAvailable) {
      if (stats.hasUnits) {
        showToast(`"${item.nama}" tidak memiliki unit yang siap digunakan`, "error");
      } else if (item.kondisi !== "Siap Digunakan") {
        showToast(`"${item.nama}" kondisi ${item.kondisi}, tidak siap digunakan`, "error");
      } else {
        showToast(`"${item.nama}" stok kosong`, "error");
      }
      return;
    }

    // Check if already selected
    const existing = items.find((it) => it.id === item.id && it.tipe === item.tipe);
    if (existing) {
      // If item has more than 1 unit or stock > 1, open modal to edit
      if ((stats.hasUnits && item.units.length > 1) || (!stats.hasUnits && item.stok > 1)) {
        openDetailModal(item);
        return;
      } else {
        showToast(`"${item.nama}" sudah dipilih`, "info");
        return;
      }
    }

    // User Feedback 2: Jika ada unit aset dan aksesoris yang hanya punya 1 unit, tidak perlu modal, langsung tampil ke item terpilih
    if (stats.hasUnits && item.units.length === 1) {
      const readyUnits = item.units.filter((u) => u.status_pinjam === "Tersedia" && u.kondisi === "Siap Digunakan");
      const theUnit = readyUnits[0] || item.units[0];
      const newItem = {
        id: item.id,
        nama: item.nama,
        kode: item.kode,
        tipe: item.tipe,
        harga: item.harga,
        tipeHarga: item.tipeHarga,
        hargaAsetOriginal: item.hargaAsetOriginal,
        jumlahTotal: item.jumlahTotal,
        stok: item.stok,
        jumlah: 1,
        kategori: item.kategori,
        merek: item.merek,
        jenisAset: item.jenisAset,
        kondisi: theUnit.kondisi || item.kondisi,
        hasUnits: true,
        units: item.units,
        unitIds: [theUnit.id],
        unitNames: theUnit.nama_unit || theUnit.kode_unit,
      };
      setItems([...items, newItem]);
      showToast(`${item.nama} (${theUnit.nama_unit || theUnit.kode_unit}) ditambahkan`, "success");
      return;
    }

    if (!stats.hasUnits && item.stok === 1) {
      const newItem = {
        id: item.id,
        nama: item.nama,
        kode: item.kode,
        tipe: item.tipe,
        harga: item.harga,
        tipeHarga: item.tipeHarga,
        hargaAsetOriginal: item.hargaAsetOriginal,
        jumlahTotal: item.jumlahTotal,
        stok: item.stok,
        jumlah: 1,
        kategori: item.kategori,
        merek: item.merek,
        jenisAset: item.jenisAset,
        kondisi: item.kondisi,
        hasUnits: false,
      };
      setItems([...items, newItem]);
      showToast(`${item.nama} ditambahkan`, "success");
      return;
    }

    // If has multiple units or stock > 1: open Item Detail Modal
    openDetailModal(item);
  };

  const removeItemFromList = (index) => {
    setItems(items.filter((_, i) => i !== index));
  };

  const updateItemJumlah = (index, jumlah) => {
    const updated = [...items];
    updated[index].jumlah = Math.max(1, Math.min(jumlah, updated[index].stok));
    setItems(updated);
  };

  // Form submit
  const handleSubmit = async (e) => {
    e.preventDefault();

    // Validation
    if (!namaPeminjam || !tanggalPeminjaman) {
      showToast("Nama peminjam dan tanggal harus diisi", "error");
      return;
    }

    if (userRole === "super admin" && !yangMenyerahkan) {
      showToast("Yang menyerahkan harus diisi", "error");
      return;
    }

    if (!keperluanList[0]?.keperluan?.trim()) {
      showToast("Keperluan peminjaman harus diisi", "error");
      return;
    }

    if (items.length === 0) {
      showToast("Pilih minimal 1 item", "error");
      return;
    }

    if (buktiFiles.length === 0) {
      showToast("Upload bukti peminjaman minimal 1 gambar", "error");
      return;
    }

    // Validate stock
    for (const item of items) {
      if (item.jumlah > item.stok) {
        showToast(`Stok "${item.nama}" tidak cukup`, "error");
        return;
      }
    }

    try {
      setSubmitting(true);

      // Otomatis capture current time saat simpan
      const now = new Date();
      const hours = String(now.getHours()).padStart(2, "0");
      const minutes = String(now.getMinutes()).padStart(2, "0");
      const seconds = String(now.getSeconds()).padStart(2, "0");
      const dateTimeStr = `${tanggalPeminjaman} ${hours}:${minutes}:${seconds}`;

      const formattedKeperluanList = keperluanList
        .filter((k) => k.keperluan?.trim())
        .map((k) => ({ ...k, keperluan: toSentenceCase(k.keperluan.trim()) }));

      await createPeminjaman(
        {
          namaPeminjam: toCapitalEachWord(namaPeminjam.trim()),
          yangMenyerahkan: yangMenyerahkan?.trim() ? toCapitalEachWord(yangMenyerahkan.trim()) : null,
          tanggalPeminjaman: dateTimeStr,
          alasanPeminjaman: formattedKeperluanList[0]?.keperluan || "",
          keperluanList: formattedKeperluanList,
          items: items.map((item) => ({
            [item.tipe === "asset" ? "assetId" : "aksesorisId"]: item.id,
            jumlah: parseInt(item.jumlah) || 0,
            unitIds: item.unitIds || undefined,
          })),
        },
        buktiFiles
      );

      showToast("Peminjaman berhasil dibuat!", "success");
      localStorage.removeItem("tempPeminjaman");

      setTimeout(() => {
        router.push("/aset/peminjaman");
      }, 1500);
    } catch (err) {
      showToast(err.message || "Gagal membuat peminjaman", "error");
    } finally {
      setSubmitting(false);
    }
  };

  // Helper functions
  const getKondisiBadge = (kondisi, isList = false) => {
    const borderClass = isList ? " border " : "";
    const badges = {
      "Siap Digunakan": `bg-green-100 text-green-800${isList ? " border-green-200" : ""}`,
      Rusak: `bg-red-100 text-red-800${isList ? " border-red-200" : ""}`,
      "Rusak Berat": `bg-red-900 text-white${isList ? " border-red-800" : ""}`,
      Maintenance: `bg-yellow-100 text-yellow-800${isList ? " border-yellow-200" : ""}`,
    };
    return (badges[kondisi] || `bg-gray-100 text-gray-800${isList ? " border-gray-200" : ""}`) + borderClass;
  };

  const calculateTotal = () => {
    return items.reduce((sum, item) => sum + item.harga * item.jumlah, 0);
  };

  const renderBrandBadge = (jenisAset, isList = false) => {
    const borderClass = isList ? " border " : "";
    const baseClass = `${isList ? "w-[84px]" : "w-auto"} text-center inline-block text-[10px] sm:text-xs px-1 sm:px-2 py-0.5 rounded-full font-semibold shrink-0`;
    if (jenisAset === "Galeria Studio") {
      return <span className={`${baseClass} bg-amber-100 text-amber-700${borderClass}${isList ? "border-amber-200" : ""}`}>Studio</span>;
    }
    if (jenisAset === "Galeria Production") {
      return <span className={`${baseClass} bg-teal-100 text-teal-700${borderClass}${isList ? "border-teal-200" : ""}`}>Production</span>;
    }
    return null;
  };

  // Filtered items for search & filter
  const filteredItems = allItems.filter((item) => {
    const matchSearch = itemSearch === "" ||
      item.nama.toLowerCase().includes(itemSearch.toLowerCase()) ||
      item.kode.toLowerCase().includes(itemSearch.toLowerCase()) ||
      (item.kategori && item.kategori.toLowerCase().includes(itemSearch.toLowerCase())) ||
      (item.merek && item.merek.toLowerCase().includes(itemSearch.toLowerCase()));
    const matchTipe = itemFilter === "semua" || item.tipe === itemFilter;
    const matchBrand = brandFilter === "semua" || item.jenisAset === brandFilter;
    return matchSearch && matchTipe && matchBrand;
  });

  if (itemFilter === "semua" && brandFilter === "semua") {
    filteredItems.sort((a, b) => a.nama.localeCompare(b.nama));
  }

  // Render
  if (!isLoaded) {
    return (
      <div className="flex items-center justify-center py-20">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-slate-600">Memuat data...</p>
        </div>
      </div>
    );
  }

  return (
    <div>
        {/* Header */}
        <div className="mb-6 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <button
              onClick={() => router.back()}
              className="cursor-pointer p-2 bg-primary rounded-lg transition hover:bg-primary-hover"
            >
              <ChevronLeft className="w-5 h-5 text-white" />
            </button>
            <div>
              <h1 className="text-2xl font-bold text-slate-900">Tambah Peminjaman Alat</h1>
              <p className="text-sm text-slate-500">Kode: {kodePinjam}</p>
            </div>
          </div>
        </div>

        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Section 1: Data Peminjam & Keperluan (Merged) */}
          <div className="bg-white rounded-lg shadow-sm border border-slate-200 border-t-4 border-t-primary p-6">
            <h2 className="text-lg font-semibold text-slate-900 mb-4 flex items-center gap-2">
              <FileText className="w-5 h-5" />
              Informasi Peminjaman
            </h2>

            <div className="grid md:grid-cols-2 gap-4">
              {/* Nama Peminjam - Manual Input */}
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-2">
                  Nama Peminjam *
                </label>
                <p className="mb-2 -mt-1 text-xs text-slate-400 italic">↳ Nama orang yang meminjam alat</p>
                <input
                  type="text"
                  placeholder="Masukkan nama peminjam"
                  value={namaPeminjam}
                  onChange={(e) => setNamaPeminjam(toCapitalEachWord(e.target.value))}
                  readOnly={userRole !== "super admin"}
                  className={`w-full rounded-lg border border-slate-300 px-3 py-2 text-slate-900 placeholder:text-slate-400 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none ${userRole !== "super admin" ? "bg-slate-50 cursor-not-allowed text-slate-500" : ""}`}
                  required
                />
              </div>

              {/* Tanggal Peminjaman */}
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-2">
                  Tanggal Peminjaman *
                </label>
                <p className="mb-2 -mt-1 text-xs text-slate-400 italic">↳ Tanggal alat mulai dipinjam</p>
                <input
                  type="date"
                  value={tanggalPeminjaman}
                  onChange={(e) => setTanggalPeminjaman(e.target.value)}
                  min={userRole !== "super admin" ? new Date().toISOString().split("T")[0] : undefined}
                  className="w-full rounded-lg border border-slate-300 px-3 py-2 text-slate-900 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none"
                  required
                />
              </div>

              {/* Yang Menyerahkan - Hanya visible untuk super admin */}
              {userRole === "super admin" && (
                <div className="md:col-span-2">
                  <label className="block text-sm font-medium text-slate-700 mb-2">
                    Yang Menyerahkan *
                  </label>
                  <p className="mb-2 -mt-1 text-xs text-slate-400 italic">↳ Penanggung jawab yang menyerahkan alat</p>
                  <input
                    type="text"
                    placeholder="Masukkan nama yang menyerahkan"
                    value={yangMenyerahkan}
                    onChange={(e) => setYangMenyerahkan(toCapitalEachWord(e.target.value))}
                    className="w-full rounded-lg border border-slate-300 px-3 py-2 text-slate-900 placeholder:text-slate-400 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none"
                    required
                  />
                </div>
              )}
            </div>

            {/* Divider */}
            <hr className="my-6 border-slate-200" />

            {/* Keperluan Peminjaman (merged into this card) */}
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-base font-semibold text-slate-800 flex items-center gap-2">
                <FileText className="w-4 h-4" />
                Keperluan Peminjaman
              </h3>
              <button
                type="button"
                onClick={addKeperluan}
                className="cursor-pointer flex items-center gap-2 px-3 py-1 bg-primary text-white text-sm rounded-lg hover:bg-primary-hover transition"
              >
                <Plus className="w-4 h-4" /> Tambah Keperluan
              </button>
            </div>

            <div className="space-y-3">
              {keperluanList.map((k, idx) => (
                <div key={idx} className="flex gap-3">
                  <input
                    type="text"
                    placeholder="Keperluan peminjaman (misal: Acara, Dokumentasi, dsb)"
                    value={k.keperluan}
                    onChange={(e) => updateKeperluan(idx, "keperluan", e.target.value)}
                    className="flex-1 rounded-lg border border-slate-300 px-3 py-2 text-sm text-slate-900 placeholder:text-slate-400 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none"
                    required={idx === 0}
                  />
                  <button
                    type="button"
                    onClick={() => removeKeperluan(idx)}
                    className="cursor-pointer p-2 text-red-600 hover:bg-red-50 rounded-lg transition shrink-0"
                    disabled={keperluanList.length === 1}
                    style={{ opacity: keperluanList.length === 1 ? 0.5 : 1 }}
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>
              ))}
            </div>
          </div>

          {/* Section 2: Item Selection */}
          <div className="bg-white rounded-lg shadow-sm border border-slate-200 border-t-4 border-t-primary p-6">
            {/* Header Row: Title + Search + Filter + View Toggle */}
            <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-3 mb-4">
              <h2 className="text-lg font-semibold text-slate-900 flex items-center gap-2 shrink-0">
                <Package className="w-5 h-5" />
                Pilih Item ({items.length} terpilih)
              </h2>
              <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 flex-1 lg:justify-end">
                {/* Search */}
                <div className="relative flex-1 sm:max-w-xs">
                  <Search className="absolute left-3 top-2.5 h-4 w-4 text-slate-400" />
                  <input
                    type="text"
                    placeholder="Cari nama, kode, kategori..."
                    value={itemSearch}
                    onChange={(e) => setItemSearch(e.target.value)}
                    className="w-full rounded-lg border border-slate-300 py-2 pl-10 pr-4 text-sm text-slate-900 placeholder:text-slate-400 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none"
                  />
                </div>
                {/* Filter Dropdowns */}
                <div className="flex gap-2 items-center">
                  <select
                    value={itemFilter}
                    onChange={(e) => setItemFilter(e.target.value)}
                    className="cursor-pointer rounded-lg border border-slate-300 px-3 py-2 text-sm text-slate-900 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none bg-white"
                  >
                    <option value="semua">Semua Tipe</option>
                    <option value="asset">Aset</option>
                    <option value="aksesoris">Aksesoris</option>
                  </select>
                  <select
                    value={brandFilter}
                    onChange={(e) => setBrandFilter(e.target.value)}
                    className="cursor-pointer rounded-lg border border-slate-300 px-3 py-2 text-sm text-slate-900 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none bg-white"
                  >
                    <option value="semua">Semua Brand</option>
                    <option value="Galeria Studio">Galeria Studio</option>
                    <option value="Galeria Production">Galeria Production</option>
                  </select>
                </div>
                {/* View Mode Toggle */}
                <div className="flex gap-1.5">
                  <button
                    type="button"
                    onClick={() => setViewMode("list")}
                    className={`cursor-pointer px-3 py-2 text-sm rounded-lg transition ${
                      viewMode === "list"
                        ? "bg-primary text-white hover:bg-primary-hover"
                        : "bg-slate-100 text-slate-600 hover:bg-slate-200"
                    }`}
                  >
                    List
                  </button>
                  <button
                    type="button"
                    onClick={() => setViewMode("grid")}
                    className={`cursor-pointer px-3 py-2 text-sm rounded-lg transition ${
                      viewMode === "grid"
                        ? "bg-primary text-white hover:bg-primary-hover"
                        : "bg-slate-100 text-slate-600 hover:bg-slate-200"
                    }`}
                  >
                    <Grid className="w-4 h-4 inline mr-1" /> Grid
                  </button>
                </div>
              </div>
            </div>

            {/* Item Selection - Grid View */}
            {viewMode === "grid" && (
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6 max-h-96 overflow-y-auto">
                {filteredItems.map((item) => {
                  const stats = getItemUnitStats(item);
                  const isSelected = items.some((it) => it.id === item.id && it.tipe === item.tipe);
                  const selectedItem = items.find((it) => it.id === item.id && it.tipe === item.tipe);
                  const isDisabled = !stats.isAvailable;

                  return (
                    <div
                      key={`${item.tipe}-${item.id}`}
                      onClick={() => handleItemClick(item)}
                      className={`p-4 rounded-lg border-2 transition flex flex-col justify-between ${
                        isSelected
                          ? "border-primary bg-blue-50/70"
                          : isDisabled
                          ? "border-slate-200 bg-slate-50/50 opacity-60 cursor-not-allowed"
                          : "border-slate-200 hover:border-primary hover:bg-slate-50 cursor-pointer"
                      }`}
                    >
                      <div>
                        {/* Gambar */}
                        <div className="mb-3 h-40 bg-slate-100 rounded-lg overflow-hidden flex items-center justify-center relative">
                          <ItemThumbnail
                            src={item.gambar}
                            alt={item.nama}
                            width={150}
                            height={150}
                            className="w-full h-full object-cover"
                            iconSize="w-8 h-8"
                          />
                          {isSelected && (
                            <div className="absolute top-2 right-2 bg-primary text-white p-1 rounded-full shadow">
                              <Check className="w-3.5 h-3.5 stroke-[3]" />
                            </div>
                          )}
                        </div>

                        {/* Info */}
                        <p className="font-semibold text-slate-900 text-sm truncate" title={item.nama}>{item.nama}</p>
                        <p className="text-xs text-slate-500 truncate">{item.kode}</p>

                        {/* Badges */}
                        <div className="flex gap-1 mt-2 flex-nowrap items-center overflow-hidden">
                          {renderBrandBadge(item.jenisAset, false)}
                          <span className={`shrink-0 text-center inline-block text-[10px] sm:text-xs px-1 sm:px-2 py-0.5 rounded-full font-semibold ${
                            item.tipe === "asset"
                              ? "bg-blue-100 text-blue-700"
                              : "bg-purple-100 text-purple-700"
                          }`}>
                            {item.tipe === "asset" ? "Aset" : "Aksesoris"}
                          </span>
                          <span className={`shrink-0 text-center inline-block text-[10px] sm:text-xs px-1 sm:px-2 py-0.5 rounded-full font-semibold ${getKondisiBadge(item.kondisi, false)}`}>
                            {item.kondisi}
                          </span>
                        </div>

                        {/* Stok & Harga */}
                        <div className="mt-2 pt-2 border-t border-slate-200 text-xs">
                          <p className="text-slate-600">
                            Stok: <span className={`font-semibold ${stats.ready > 0 ? "text-slate-800" : "text-red-500"}`}>{stats.ready}</span>
                          </p>
                          {item.harga > 0 && (
                            <div className="mt-0.5">
                              <p className="text-slate-600">Harga: <span className="font-semibold text-emerald-600">Rp {(item.harga || 0).toLocaleString('id-ID')}/unit</span></p>
                              {item.tipeHarga === "Per Paket" && (
                                <p className="text-[10px] text-purple-600 font-medium">(Paket: Rp {Number(item.hargaAsetOriginal).toLocaleString('id-ID')})</p>
                              )}
                            </div>
                          )}
                        </div>

                        {/* Indikator Unit Ringkas */}
                        {stats.hasUnits && (
                          <div className="mt-2 pt-2 border-t border-slate-100 flex items-center gap-1.5 text-[11px] text-slate-500">
                            <Layers className="w-3.5 h-3.5 text-slate-400" />
                            <span>
                              <strong className={stats.ready > 0 ? "text-emerald-600" : "text-red-500"}>{stats.ready}</strong>/{stats.total} unit tersedia
                            </span>
                          </div>
                        )}
                      </div>

                      {isSelected && (
                        <div className="mt-3 pt-2 border-t border-blue-200 flex items-center justify-center text-primary text-xs font-semibold">
                          <Check className="w-4 h-4 mr-1" />
                          {selectedItem?.hasUnits
                            ? `${selectedItem.unitIds?.length || selectedItem.jumlah} Unit Terpilih`
                            : `${selectedItem?.jumlah || 1} Terpilih`}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            )}

            {/* Item Selection - List View */}
            {viewMode === "list" && (
              <div className="space-y-2 mb-6 max-h-96 overflow-y-auto">
                {filteredItems.map((item) => {
                  const stats = getItemUnitStats(item);
                  const isSelected = items.some((it) => it.id === item.id && it.tipe === item.tipe);
                  const selectedItem = items.find((it) => it.id === item.id && it.tipe === item.tipe);
                  const isDisabled = !stats.isAvailable;

                  return (
                    <div
                      key={`${item.tipe}-${item.id}`}
                      onClick={() => handleItemClick(item)}
                      className={`p-3 rounded-lg border-2 transition flex flex-col sm:flex-row sm:items-center justify-between gap-3 sm:gap-2 ${
                        isSelected
                          ? "border-primary bg-blue-50/70"
                          : isDisabled
                          ? "border-slate-200 bg-slate-50/50 opacity-60 cursor-not-allowed"
                          : "border-slate-200 hover:border-primary hover:bg-slate-50 cursor-pointer"
                      }`}
                    >
                      <div className="flex flex-col sm:flex-row sm:items-center gap-2 flex-1 w-full min-w-0">
                        <div className="flex items-center gap-2 shrink-0">
                          {renderBrandBadge(item.jenisAset, true)}
                          <span className={`w-[84px] text-center inline-block text-[10px] sm:text-xs px-1 sm:px-2 py-0.5 rounded-full font-semibold border shrink-0 ${
                            item.tipe === "asset"
                              ? "bg-blue-100 text-blue-700 border-blue-200"
                              : "bg-purple-100 text-purple-700 border-purple-200"
                          }`}>
                            {item.tipe === "asset" ? "Aset" : "Aksesoris"}
                          </span>
                        </div>
                        <div className="flex-1 min-w-0 mt-1 sm:mt-0">
                          <div className="flex items-center gap-2">
                            <p className="font-semibold text-slate-900 truncate">{item.nama}</p>
                            {isSelected && (
                              <span className="inline-flex items-center gap-0.5 px-2 py-0.5 rounded-full bg-blue-100 text-blue-700 text-[10px] font-bold">
                                <Check className="w-3 h-3" />
                                {selectedItem?.hasUnits ? `${selectedItem.jumlah} Unit` : `${selectedItem?.jumlah} Terpilih`}
                              </span>
                            )}
                          </div>
                          <p className="text-xs text-slate-500 truncate">{item.kode} • {item.kategori} • {item.merek}</p>
                          {stats.hasUnits && (
                            <div className="flex items-center gap-1.5 text-[11px] text-slate-500 mt-1">
                              <Layers className="w-3.5 h-3.5 text-slate-400" />
                              <span>
                                <strong className={stats.ready > 0 ? "text-emerald-600 font-semibold" : "text-red-500 font-semibold"}>
                                  {stats.ready}
                                </strong>
                                /{stats.total} unit tersedia
                              </span>
                            </div>
                          )}
                        </div>
                      </div>
                      <div className="flex flex-wrap items-center justify-between sm:justify-end gap-3 sm:gap-2 shrink-0 border-t sm:border-0 border-slate-100 pt-2 sm:pt-0 w-full sm:w-auto">
                        <div className="flex items-center gap-3 sm:gap-2">
                          <span className={`text-xs font-semibold ${stats.ready > 0 ? "text-slate-700" : "text-red-500"}`}>
                            Stok: {stats.ready}
                          </span>
                          {item.harga > 0 && (
                            <div className="flex flex-col text-right">
                              <span className="text-xs font-semibold text-emerald-600">Rp {(item.harga || 0).toLocaleString('id-ID')}</span>
                              {item.tipeHarga === "Per Paket" && (
                                <span className="text-[10px] text-purple-600 font-medium">Paket</span>
                              )}
                            </div>
                          )}
                        </div>
                        <span className={`text-center inline-block text-[10px] sm:text-xs px-2 py-0.5 rounded-full font-semibold border ${getKondisiBadge(item.kondisi, true)}`}>
                          {item.kondisi}
                        </span>
                      </div>
                    </div>
                  );
                })}
              </div>
            )}

            {/* Empty state */}
            {filteredItems.length === 0 && (
              <div className="text-center py-8 text-slate-400">
                <Package className="w-10 h-10 mx-auto mb-2 opacity-50" />
                <p className="text-sm">Tidak ada item yang cocok dengan pencarian</p>
              </div>
            )}
          </div>

          {/* Section 3: Selected Items */}
          {items.length > 0 && (
            <div className="bg-white rounded-lg shadow-sm border border-slate-200 border-t-4 border-t-primary p-6">
              <h3 className="text-lg font-semibold text-slate-900 mb-4 flex items-center gap-2">
                <Package className="w-5 h-5 text-primary" />
                Item Terpilih ({items.length})
              </h3>

              <div className="space-y-2 max-h-[300px] overflow-y-auto pr-1">
                {items.map((item, idx) => (
                  <div key={idx} className="p-3 rounded-lg border-2 border-slate-200 bg-white flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                    {/* Item Info */}
                    <div className="flex flex-col sm:flex-row sm:items-center gap-2 flex-1 w-full min-w-0">
                      <div className="flex items-center gap-2 shrink-0">
                        {renderBrandBadge(item.jenisAset, true)}
                        <span className={`w-[84px] text-center inline-block text-[10px] sm:text-xs px-1 sm:px-2 py-0.5 rounded-full font-semibold border shrink-0 ${
                          item.tipe === "asset"
                            ? "bg-blue-100 text-blue-700 border-blue-200"
                            : "bg-purple-100 text-purple-700 border-purple-200"
                        }`}>
                          {item.tipe === "asset" ? "Aset" : "Aksesoris"}
                        </span>
                      </div>
                      <div className="flex-1 min-w-0 mt-1 sm:mt-0">
                        <p className="font-semibold text-slate-900 truncate">{item.nama}</p>
                        <p className="text-xs text-slate-500 truncate">
                          {item.kode} • Stok: {item.stok}
                          {item.kondisi && (
                            <span className="ml-1.5 inline-block">
                              • <span className={`px-1.5 py-0.5 rounded text-[10px] font-semibold ${getKondisiBadge(item.kondisi, false)}`}>{item.kondisi}</span>
                            </span>
                          )}
                        </p>
                        {item.hasUnits && (
                          <div className="flex flex-wrap items-center gap-1 mt-1.5">
                            <span className="text-[11px] text-slate-500 font-semibold">Unit:</span>
                            {(item.units || [])
                              .filter((u) => item.unitIds?.includes(u.id))
                              .map((u) => (
                                <span key={u.id} className="text-xs px-2 py-0.5 bg-blue-100 text-blue-700 font-bold rounded border border-blue-200">
                                  {u.nama_unit || u.kode_unit}
                                </span>
                              ))}
                            <button
                              type="button"
                              onClick={() => {
                                const orig = allItems.find((it) => it.id === item.id && it.tipe === item.tipe) || item;
                                openDetailModal(orig);
                              }}
                              className="cursor-pointer text-xs text-primary hover:underline font-semibold ml-2"
                            >
                              Ubah Unit
                            </button>
                          </div>
                        )}
                        {!item.hasUnits && (item.stok > 1) && (
                          <button
                            type="button"
                            onClick={() => {
                              const orig = allItems.find((it) => it.id === item.id && it.tipe === item.tipe) || item;
                              openDetailModal(orig);
                            }}
                            className="cursor-pointer text-xs text-primary hover:underline font-semibold mt-1 inline-block"
                          >
                            Atur Jumlah
                          </button>
                        )}
                      </div>
                    </div>

                    {/* Quantity & Actions */}
                    <div className="flex items-center gap-3 shrink-0">
                      {item.harga > 0 && (
                        <div className="text-right hidden sm:block">
                          <p className="text-xs font-semibold text-emerald-600">
                            Rp {(item.harga * item.jumlah).toLocaleString('id-ID')}
                          </p>
                        </div>
                      )}
                      
                      {item.hasUnits ? (
                        <div className="flex items-center gap-1.5 bg-blue-50 px-3 py-1.5 rounded-lg border border-blue-200">
                          <span className="text-xs font-bold text-blue-800">{item.jumlah} Unit</span>
                        </div>
                      ) : (
                        <div className="flex items-center gap-2 bg-slate-50 p-1 rounded-lg border border-slate-200">
                          <label className="text-xs text-slate-600 font-medium ml-1">Jml:</label>
                          <input
                            type="number"
                            min="1"
                            max={item.stok}
                            value={item.jumlah}
                            onChange={(e) => updateItemJumlah(idx, parseInt(e.target.value))}
                            className="w-14 rounded bg-white border border-slate-300 px-2 py-1 text-sm text-slate-900 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none"
                          />
                        </div>
                      )}

                      <button
                        type="button"
                        onClick={() => removeItemFromList(idx)}
                        className="cursor-pointer p-1.5 text-red-600 hover:bg-red-50 hover:text-red-700 rounded-lg transition"
                        title="Hapus Item"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  </div>
                ))}
              </div>

              {/* Total Value */}
              {items.some((it) => it.harga > 0) && (
                <div className="mt-4 pt-4 border-t border-slate-200 text-right">
                  <p className="text-sm text-slate-600">Total Nilai Aset:</p>
                  <p className="text-2xl font-bold text-emerald-600">
                    Rp {calculateTotal().toLocaleString('id-ID')}
                  </p>
                  <p className="text-xs text-slate-500 mt-1">
                    Anda bertanggung jawab atas aset di atas
                  </p>
                </div>
              )}
            </div>
          )}

          {/* Section 4: Bukti Peminjaman */}
          <div className="bg-white rounded-lg shadow-sm border border-slate-200 border-t-4 border-t-primary p-6">
            <h2 className="text-lg font-semibold text-slate-900 mb-4 flex items-center gap-2">
              <Camera className="w-5 h-5" />
              Bukti Peminjaman ({buktiFiles.length}/5)
            </h2>

            <div className="space-y-4">
              {/* Upload Area */}
              <div className="border-2 border-dashed border-slate-200 rounded-xl p-6 text-center hover:border-primary/50 transition">
                <ImageIcon className="w-8 h-8 text-slate-300 mx-auto mb-2" />
                <p className="text-sm font-medium text-slate-700">Upload Bukti Peminjaman</p>
                <p className="text-xs text-slate-400 mb-4">PNG, JPG, HEIC, WebP (maks. 5 gambar)</p>
                
                <div className="flex flex-col sm:flex-row items-center justify-center gap-3">
                  {/* Opsi Kamera */}
                  <input
                    ref={cameraInputRef}
                    type="file"
                    accept="image/*"
                    capture="environment"
                    onChange={handleFileChange}
                    className="hidden"
                  />
                  <button
                    type="button"
                    onClick={() => cameraInputRef.current?.click()}
                    className="cursor-pointer w-full sm:w-auto flex items-center justify-center gap-2 px-5 py-2.5 bg-white border border-slate-200 shadow-sm rounded-xl hover:border-primary hover:text-primary transition-colors text-sm font-semibold text-slate-700"
                  >
                    <Camera className="h-4 w-4 text-primary" />
                    Buka Kamera
                  </button>

                  {/* Opsi Galeri */}
                  <input
                    ref={fileInputRef}
                    type="file"
                    multiple
                    accept="image/jpeg,image/jpg,image/png,image/heic,image/heif,image/webp"
                    onChange={handleFileChange}
                    className="hidden"
                  />
                  <button
                    type="button"
                    onClick={() => fileInputRef.current?.click()}
                    className="cursor-pointer w-full sm:w-auto flex items-center justify-center gap-2 px-5 py-2.5 bg-white border border-slate-200 shadow-sm rounded-xl hover:border-primary hover:text-primary transition-colors text-sm font-semibold text-slate-700"
                  >
                    <ImageIcon className="h-4 w-4 text-primary" />
                    Pilih Galeri
                  </button>
                </div>
              </div>

              {/* Preview */}
              {buktiPreviews.length > 0 && (
                <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-3">
                  {buktiPreviews.map((preview, idx) => (
                    <div key={idx} className="relative group">
                      <img
                        src={preview}
                        alt={`Preview ${idx + 1}`}
                        className="w-full h-24 object-cover rounded-lg border border-slate-200"
                      />
                      <button
                        type="button"
                        onClick={() => removeFile(idx)}
                        className="cursor-pointer absolute -top-2 -right-2 bg-red-600 text-white rounded-full p-1 opacity-0 group-hover:opacity-100 transition"
                      >
                        <X className="w-3 h-3" />
                      </button>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </div>

          {/* Submit Button */}
          <div className="flex gap-3 justify-end">
            <button
              type="button"
              onClick={() => router.back()}
              className="cursor-pointer px-6 py-2.5 rounded-lg border-2 border-slate-400 text-slate-700 font-semibold hover:bg-slate-200 hover:border-slate-500 hover:text-slate-900 transition"
            >
              Batal
            </button>
            <button
              type="submit"
              disabled={submitting}
              className="cursor-pointer px-6 py-2.5 rounded-lg bg-primary text-white font-medium hover:bg-primary-hover disabled:opacity-50 disabled:cursor-not-allowed transition flex items-center gap-2"
            >
              <Check className="w-4 h-4" />
              {submitting ? "Menyimpan..." : "Simpan Peminjaman"}
            </button>
          </div>
        </form>

      {/* Modal Pemilihan Item / Unit */}
      {detailModalItem && createPortal(
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-in fade-in duration-150">
          <div className="bg-white rounded-2xl shadow-2xl border border-slate-200 border-t-4 border-t-primary w-full max-w-xl overflow-hidden flex flex-col max-h-[90vh]">
            {/* Modal Header */}
            <div className="px-6 py-4 border-b border-slate-200 flex items-center justify-between bg-slate-50">
              <div className="flex items-center gap-3 min-w-0">
                <div className="w-12 h-12 rounded-xl bg-slate-100 border border-slate-200 overflow-hidden flex items-center justify-center shrink-0">
                  <ItemThumbnail
                    src={detailModalItem.gambar}
                    alt={detailModalItem.nama}
                    width={48}
                    height={48}
                    className="w-full h-full object-cover"
                    iconSize="w-6 h-6"
                  />
                </div>
                <div className="min-w-0">
                  <div className="flex items-center gap-1.5 flex-wrap">
                    {renderBrandBadge(detailModalItem.jenisAset, false)}
                    <span className={`text-[10px] px-2 py-0.5 rounded-full font-semibold ${
                      detailModalItem.tipe === "asset"
                        ? "bg-blue-100 text-blue-700"
                        : "bg-purple-100 text-purple-700"
                    }`}>
                      {detailModalItem.tipe === "asset" ? "Aset" : "Aksesoris"}
                    </span>
                    <span className={`text-[10px] px-2 py-0.5 rounded-full font-semibold ${getKondisiBadge(detailModalItem.kondisi, false)}`}>
                      {detailModalItem.kondisi}
                    </span>
                  </div>
                  <h3 className="text-base font-bold text-slate-900 truncate mt-0.5">
                    {detailModalItem.nama}
                  </h3>
                  <p className="text-xs text-slate-500 truncate">
                    {detailModalItem.kode} • {detailModalItem.kategori} • {detailModalItem.merek}
                  </p>
                </div>
              </div>
              <button
                type="button"
                onClick={() => setDetailModalItem(null)}
                className="cursor-pointer p-1.5 text-slate-400 hover:text-slate-600 hover:bg-slate-200 rounded-lg transition shrink-0 ml-2"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            {/* Modal Body */}
            <div className="p-6 overflow-y-auto flex-1 space-y-4">
              {/* Quick Info bar */}
              <div className="grid grid-cols-2 sm:grid-cols-3 gap-3 p-3 bg-slate-50 rounded-xl border border-slate-200 text-xs">
                <div>
                  <span className="text-slate-500 block">Stok Tersedia</span>
                  <span className="text-sm font-bold text-slate-900">
                    {detailModalItem.units && detailModalItem.units.length > 0
                      ? `${detailModalItem.units.filter(u => u.status_pinjam === 'Tersedia' && u.kondisi === 'Siap Digunakan').length} Unit`
                      : `${detailModalItem.stok} Unit`}
                  </span>
                </div>
                <div>
                  <span className="text-slate-500 block">Kondisi Alat</span>
                  <span className="text-sm font-bold text-emerald-600">
                    {detailModalItem.kondisi}
                  </span>
                </div>
                {detailModalItem.harga > 0 && (
                  <div>
                    <span className="text-slate-500 block">Harga / Unit</span>
                    <span className="text-sm font-bold text-emerald-600">
                      Rp {detailModalItem.harga.toLocaleString('id-ID')}
                    </span>
                  </div>
                )}
              </div>

              {/* JIKA ITEM MEMILIKI UNIT (units.length > 0) */}
              {detailModalItem.units && detailModalItem.units.length > 0 ? (
                <div>
                  {/* Status Breakdown Legend */}
                  {(() => {
                    const stats = getItemUnitStats(detailModalItem);
                    return (
                      <div className="flex flex-wrap items-center gap-1.5 text-xs bg-slate-50 p-2.5 rounded-lg border border-slate-200 mb-3">
                        <span className="font-semibold text-slate-600 mr-1">Status Unit:</span>
                        <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-emerald-100 text-emerald-800 font-medium text-[11px]">
                          <span className="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                          {stats.ready} Siap
                        </span>
                        {stats.dipinjam > 0 && (
                          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-amber-100 text-amber-800 font-medium text-[11px]">
                            <span className="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                            {stats.dipinjam} Dipinjam
                          </span>
                        )}
                        {stats.maintenance > 0 && (
                          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-yellow-100 text-yellow-800 font-medium text-[11px]">
                            <span className="w-1.5 h-1.5 rounded-full bg-yellow-500"></span>
                            {stats.maintenance} Maintenance
                          </span>
                        )}
                        {stats.rusak > 0 && (
                          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-red-100 text-red-800 font-medium text-[11px]">
                            <span className="w-1.5 h-1.5 rounded-full bg-red-500"></span>
                            {stats.rusak} Rusak
                          </span>
                        )}
                        {stats.rusakBerat > 0 && (
                          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-red-900 text-white font-medium text-[11px]">
                            <span className="w-1.5 h-1.5 rounded-full bg-red-300"></span>
                            {stats.rusakBerat} Rusak Berat
                          </span>
                        )}
                      </div>
                    );
                  })()}

                  {/* Actions & Selected count */}
                  <div className="flex items-center justify-between mb-3 pb-2 border-b border-slate-100">
                    <span className="text-xs font-medium text-slate-600">
                      Unit Terpilih: <strong className="text-primary font-bold">{modalSelectedUnitIds.length}</strong> unit
                    </span>
                    <div className="flex gap-2">
                      <button
                        type="button"
                        onClick={() => {
                          const avail = (detailModalItem.units || [])
                            .filter((u) => u.status_pinjam === "Tersedia" && u.kondisi === "Siap Digunakan")
                            .map((u) => u.id);
                          setModalSelectedUnitIds(avail);
                        }}
                        className="cursor-pointer text-xs px-2.5 py-1 rounded bg-blue-50 text-blue-700 font-semibold hover:bg-blue-100 transition"
                      >
                        Pilih Semua Siap
                      </button>
                      <button
                        type="button"
                        onClick={() => setModalSelectedUnitIds([])}
                        className="cursor-pointer text-xs px-2.5 py-1 rounded bg-slate-100 text-slate-600 font-semibold hover:bg-slate-200 transition"
                      >
                        Reset
                      </button>
                    </div>
                  </div>

                  {/* Unit List */}
                  <div className="space-y-2 max-h-72 overflow-y-auto pr-1">
                    {(detailModalItem.units || []).map((u) => {
                      const isDipinjam = u.status_pinjam === "Dipinjam";
                      const isRusak = u.kondisi === "Rusak";
                      const isRusakBerat = u.kondisi === "Rusak Berat";
                      const isMaintenance = u.kondisi === "Maintenance";
                      const isUnavailable = isDipinjam || isRusak || isRusakBerat || isMaintenance;
                      const isSelected = modalSelectedUnitIds.includes(u.id);

                      let statusLabel = "Siap Digunakan";
                      let statusBadgeClass = "bg-emerald-100 text-emerald-800 border-emerald-200";
                      if (isDipinjam) {
                        statusLabel = "Dipinjam";
                        statusBadgeClass = "bg-amber-100 text-amber-800 border-amber-200";
                      } else if (isRusakBerat) {
                        statusLabel = "Rusak Berat";
                        statusBadgeClass = "bg-red-900 text-white border-red-800";
                      } else if (isRusak) {
                        statusLabel = "Rusak";
                        statusBadgeClass = "bg-red-100 text-red-800 border-red-200";
                      } else if (isMaintenance) {
                        statusLabel = "Maintenance";
                        statusBadgeClass = "bg-yellow-100 text-yellow-800 border-yellow-200";
                      }

                      return (
                        <div
                          key={u.id}
                          onClick={() => toggleModalUnit(u.id, isUnavailable)}
                          className={`relative px-4 py-3 rounded-xl border transition-all flex items-center justify-between gap-3 select-none ${
                            isUnavailable
                              ? "bg-slate-100/80 border-slate-200 opacity-60 cursor-not-allowed"
                              : isSelected
                              ? "bg-blue-50/70 border-primary ring-1 ring-primary shadow-xs cursor-pointer"
                              : "bg-white border-slate-200 hover:border-primary/50 hover:bg-slate-50 cursor-pointer"
                          }`}
                        >
                          <div className="flex items-center gap-3 min-w-0">
                            {/* Checkbox Icon */}
                            {isSelected ? (
                              <div className="w-5 h-5 rounded-md bg-primary text-white flex items-center justify-center shrink-0 shadow-xs">
                                <Check className="w-3.5 h-3.5 stroke-[3]" />
                              </div>
                            ) : (
                              <div className={`w-5 h-5 rounded-md border shrink-0 ${
                                isUnavailable ? "border-slate-300 bg-slate-200" : "border-slate-300 bg-white"
                              }`} />
                            )}

                            {/* Unit Details: Name & Code */}
                            <div className="min-w-0">
                              <p className={`text-sm font-semibold truncate ${
                                isSelected ? "text-primary" : isUnavailable ? "text-slate-500" : "text-slate-800"
                              }`}>
                                {u.nama_unit || u.kode_unit}
                              </p>
                              <p className="text-xs text-slate-500 font-mono">
                                {u.kode_unit}
                              </p>
                            </div>
                          </div>

                          {/* Unit Status Badge */}
                          <div className="shrink-0 flex items-center gap-2">
                            <span className={`px-2.5 py-1 rounded-full text-[11px] font-semibold border ${statusBadgeClass}`}>
                              {statusLabel}
                            </span>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              ) : (
                /* JIKA ITEM TANPA UNIT (Item Bulk / Stok > 1) */
                <div className="py-2">
                  <label className="block text-sm font-semibold text-slate-700 mb-2">
                    Tentukan Jumlah Pinjam
                  </label>
                  <div className="flex items-center gap-3">
                    <button
                      type="button"
                      onClick={() => setModalJumlah((prev) => Math.max(1, prev - 1))}
                      disabled={modalJumlah <= 1}
                      className="cursor-pointer w-10 h-10 rounded-lg border border-slate-300 flex items-center justify-center text-slate-700 hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed transition"
                    >
                      <Minus className="w-4 h-4" />
                    </button>
                    <input
                      type="number"
                      min="1"
                      max={detailModalItem.stok}
                      value={modalJumlah}
                      onChange={(e) => {
                        const val = parseInt(e.target.value) || 1;
                        setModalJumlah(Math.max(1, Math.min(val, detailModalItem.stok)));
                      }}
                      className="w-24 text-center font-bold text-lg rounded-lg border border-slate-300 py-1.5 text-slate-900 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none"
                    />
                    <button
                      type="button"
                      onClick={() => setModalJumlah((prev) => Math.min(detailModalItem.stok, prev + 1))}
                      disabled={modalJumlah >= detailModalItem.stok}
                      className="cursor-pointer w-10 h-10 rounded-lg border border-slate-300 flex items-center justify-center text-slate-700 hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed transition"
                    >
                      <Plus className="w-4 h-4" />
                    </button>
                    <span className="text-xs text-slate-500 font-medium">
                      / {detailModalItem.stok} unit tersedia
                    </span>
                  </div>
                </div>
              )}

              {/* Price Calculation Box */}
              {detailModalItem.harga > 0 && (
                <div className="mt-4 p-3 bg-slate-50 rounded-xl border border-slate-200 flex items-center justify-between text-xs">
                  <div>
                    <span className="text-slate-500 block">
                      Estimasi Nilai ({detailModalItem.units && detailModalItem.units.length > 0 ? modalSelectedUnitIds.length : modalJumlah} unit):
                    </span>
                    <span className="text-[11px] text-slate-400">
                      @ Rp {detailModalItem.harga.toLocaleString("id-ID")} / unit
                    </span>
                  </div>
                  <span className="text-base font-bold text-emerald-600">
                    Rp {(detailModalItem.harga * (detailModalItem.units && detailModalItem.units.length > 0 ? modalSelectedUnitIds.length : modalJumlah)).toLocaleString("id-ID")}
                  </span>
                </div>
              )}
            </div>

            {/* Modal Footer */}
            <div className="px-6 py-4 border-t border-slate-200 bg-slate-50 flex items-center justify-between">
              <button
                type="button"
                onClick={() => setDetailModalItem(null)}
                className="cursor-pointer px-4 py-2 text-sm rounded-lg border border-slate-300 font-semibold text-slate-700 hover:bg-slate-200 transition"
              >
                Batal
              </button>
              <button
                type="button"
                disabled={detailModalItem.units && detailModalItem.units.length > 0 ? modalSelectedUnitIds.length === 0 : modalJumlah <= 0}
                onClick={handleSaveModal}
                className="cursor-pointer px-5 py-2 text-sm rounded-lg bg-primary text-white font-semibold hover:bg-primary-hover disabled:opacity-50 disabled:cursor-not-allowed transition flex items-center gap-1.5"
              >
                <Check className="w-4 h-4" />
                Simpan ({detailModalItem.units && detailModalItem.units.length > 0 ? modalSelectedUnitIds.length : modalJumlah} Unit)
              </button>
            </div>
          </div>
        </div>,
        document.body
      )}

      {/* Toast */}
      {typeof document !== 'undefined' && toast && createPortal(
        <div className={`fixed top-20 right-6 z-[9999] flex items-center gap-2 rounded-xl px-5 py-3 shadow-lg text-sm font-medium text-white transition-all animate-[slideIn_0.3s_ease] ${
          toast.type === "error"
            ? "bg-rose-500"
            : toast.type === "info"
            ? "bg-blue-500"
            : "bg-emerald-500"
        }`}>
          {toast.type === "error" ? (
            <X className="h-4 w-4" />
          ) : toast.type === "info" ? (
            <Info className="h-4 w-4" />
          ) : (
            <Check className="h-4 w-4" />
          )}
          {toast.message}
        </div>,
        document.body
      )}
    </div>
  );
}
