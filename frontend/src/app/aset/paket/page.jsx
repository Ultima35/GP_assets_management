"use client";

import { useState, useEffect, useCallback, useMemo } from "react";
import { createPortal } from "react-dom";
import { useRouter } from "next/navigation";
import { 
  getAllPaket, 
  getPaketById, 
  createPaket, 
  updatePaket, 
  deletePaket, 
  deleteAllPaket 
} from "../../lib/paketService";
import { getAllAssets } from "../../lib/assetService";
import { getAllAksesoris } from "../../lib/aksesorisService";
import { getUserContext } from "../../lib/authService";
import { 
  Plus, 
  Trash2, 
  X, 
  Check, 
  Search, 
  Pencil, 
  Boxes, 
  Package, 
  AlertTriangle, 
  Layers, 
  Info, 
  Grid, 
  List, 
  ChevronsLeft, 
  ChevronLeft, 
  ChevronRight, 
  ChevronsRight, 
  ArrowRight 
} from "lucide-react";

const ROWS_OPTIONS_GRID = [8, 16, 24, 32];
const ROWS_OPTIONS_TABLE = [10, 25, 50, 100];

export default function PaketPage() {
  const router = useRouter();

  // State Utama
  const [pakets, setPakets] = useState([]);
  const [loading, setLoading] = useState(true);
  const [userRole, setUserRole] = useState("user");
  const [mounted, setMounted] = useState(false);
  const [toast, setToast] = useState(null);
  const [search, setSearch] = useState("");
  const [viewMode, setViewMode] = useState("grid"); // "grid" | "table"

  // Paginasi State
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(8);

  // Inventaris untuk Item Picker
  const [availableItems, setAvailableItems] = useState([]);
  const [loadingInventory, setLoadingInventory] = useState(false);

  // Modals
  const [showFormModal, setShowFormModal] = useState(false);
  const [editingPaket, setEditingPaket] = useState(null);
  const [showDetailModal, setShowDetailModal] = useState(null);
  const [showDeleteModal, setShowDeleteModal] = useState(null);
  const [submitting, setSubmitting] = useState(false);

  // Super Admin Delete All
  const [showDeleteAllModal, setShowDeleteAllModal] = useState(false);
  const [deleteAllConfirmation, setDeleteAllConfirmation] = useState("");
  const [deleteAllLoading, setDeleteAllLoading] = useState(false);

  // Form State
  const [formData, setFormData] = useState({
    nama_paket: "",
    deskripsi: "",
    items: [],
  });

  // Item Picker State
  const [showItemPicker, setShowItemPicker] = useState(false);
  const [pickerSearch, setPickerSearch] = useState("");
  const [pickerTab, setPickerTab] = useState("all"); // "all" | "asset" | "aksesoris"
  const [pickerBrand, setPickerBrand] = useState("semua"); // "semua" | "Galeria Production" | "Galeria Studio"

  // Toast Helper
  const showToast = (message, type = "success") => {
    setToast({ message, type });
    setTimeout(() => setToast(null), 3500);
  };

  useEffect(() => {
    setMounted(true);
    const ctx = getUserContext();
    if (ctx) setUserRole(ctx.role || "user");

    // Load viewMode preference
    try {
      const savedView = localStorage.getItem("paketViewMode");
      if (savedView === "grid" || savedView === "table") {
        setViewMode(savedView);
        setItemsPerPage(savedView === "grid" ? 8 : 10);
      }
    } catch (e) {
      // ignore
    }
  }, []);

  // Sync rows per page on view mode change
  const handleToggleViewMode = (mode) => {
    setViewMode(mode);
    setCurrentPage(1);
    setItemsPerPage(mode === "grid" ? 8 : 10);
    try {
      localStorage.setItem("paketViewMode", mode);
    } catch (e) {
      // ignore
    }
  };

  // Close modals on Escape key
  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === "Escape") {
        if (showItemPicker) setShowItemPicker(false);
        else if (showFormModal) setShowFormModal(false);
        else if (showDetailModal) setShowDetailModal(null);
        else if (showDeleteModal) setShowDeleteModal(null);
        else if (showDeleteAllModal) setShowDeleteAllModal(false);
      }
    };
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [showItemPicker, showFormModal, showDetailModal, showDeleteModal, showDeleteAllModal]);

  // Fetch Semua Paket Bundling
  const fetchPakets = useCallback(async () => {
    try {
      setLoading(true);
      const data = await getAllPaket();
      setPakets(data || []);
    } catch (err) {
      console.error("Error fetch pakets:", err);
      showToast("Gagal memuat data paket bundling", "error");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchPakets();
  }, [fetchPakets]);

  // Fetch Inventaris Gabungan (Aset + Aksesoris) untuk Picker
  const fetchInventory = useCallback(async () => {
    try {
      setLoadingInventory(true);
      const [assetsRes, aksesorisRes] = await Promise.all([
        getAllAssets(),
        getAllAksesoris(),
      ]);

      const assetList = (assetsRes.data || []).map((a) => {
        const readyUnits = (a.units || []).filter(
          (u) => u.status_pinjam === "Tersedia" && (u.kondisi === "Siap Digunakan" || !u.kondisi)
        );
        const actualStok = a.units && a.units.length > 0 ? readyUnits.length : (a.jumlah || 0);

        return {
          asset_id: a.id,
          aksesoris_id: null,
          nama: a.namaAset,
          kode: a.kodeAset,
          tipe: "asset",
          stok: actualStok,
          jenisAset: a.jenisAset || "Galeria Studio",
          kategori: a.kategori || "-",
          merek: a.merek || "-",
        };
      });

      const aksesorisList = (aksesorisRes.data || []).map((ak) => ({
        asset_id: null,
        aksesoris_id: ak.id,
        nama: ak.namaAksesoris,
        kode: ak.kodeAksesoris,
        tipe: "aksesoris",
        stok: ak.jumlah || 0,
        jenisAset: ak.jenisAset || "Galeria Studio",
        kategori: ak.kategori || "-",
        merek: "-",
      }));

      setAvailableItems([...assetList, ...aksesorisList]);
    } catch (err) {
      console.error("Error fetching inventory:", err);
      showToast("Gagal memuat inventaris peralatan", "error");
    } finally {
      setLoadingInventory(false);
    }
  }, []);

  useEffect(() => {
    fetchInventory();
  }, [fetchInventory]);

  // Open Create Modal
  const handleOpenCreate = () => {
    setEditingPaket(null);
    setFormData({
      nama_paket: "",
      deskripsi: "",
      items: [],
    });
    setPickerSearch("");
    setPickerTab("all");
    setPickerBrand("semua");
    setShowItemPicker(false);
    setShowFormModal(true);
  };

  // Open Edit Modal
  const handleOpenEdit = async (paket) => {
    try {
      setSubmitting(true);
      const detail = await getPaketById(paket.id);
      setEditingPaket(detail);
      setFormData({
        nama_paket: detail.nama_paket || "",
        deskripsi: detail.deskripsi || "",
        items: (detail.items || []).map((it) => {
          const matchedInv = availableItems.find(
            (inv) =>
              (it.asset_id && inv.asset_id === it.asset_id) ||
              (it.aksesoris_id && inv.aksesoris_id === it.aksesoris_id)
          );
          const currentMaxStok = matchedInv ? matchedInv.stok : (it.stok || 1);

          return {
            asset_id: it.asset_id,
            aksesoris_id: it.aksesoris_id,
            nama: it.nama_item,
            kode: it.kode_item,
            tipe: it.tipe,
            stok: currentMaxStok,
            jumlah: Math.min(it.jumlah || 1, currentMaxStok > 0 ? currentMaxStok : (it.jumlah || 1)),
            kategori: it.kategori,
            merek: it.merek,
          };
        }),
      });
      setPickerSearch("");
      setPickerTab("all");
      setPickerBrand("semua");
      setShowItemPicker(false);
      setShowFormModal(true);
    } catch (err) {
      showToast("Gagal memuat detail paket", "error");
    } finally {
      setSubmitting(false);
    }
  };

  // Open Detail Modal
  const handleOpenDetail = async (paket) => {
    try {
      const detail = await getPaketById(paket.id);
      setShowDetailModal(detail);
    } catch (err) {
      showToast("Gagal memuat detail paket", "error");
    }
  };

  // Form Submit (Create or Update)
  const handleSubmitForm = async (e) => {
    e.preventDefault();
    if (!formData.nama_paket.trim()) {
      showToast("Nama paket wajib diisi!", "error");
      return;
    }
    if (formData.items.length === 0) {
      showToast("Minimal pilih 1 jenis alat untuk paket ini!", "error");
      return;
    }

    // Validasi stok tidak boleh melebihi stok yang ada
    for (const it of formData.items) {
      const maxStok = Math.max(1, parseInt(it.stok, 10) || 1);
      if (it.jumlah > maxStok) {
        showToast(`Jumlah "${it.nama}" (${it.jumlah}) melebihi stok yang tersedia (${maxStok})!`, "error");
        return;
      }
    }

    try {
      setSubmitting(true);
      const payload = {
        nama_paket: formData.nama_paket.trim(),
        deskripsi: formData.deskripsi.trim(),
        items: formData.items.map((it) => ({
          asset_id: it.asset_id || null,
          aksesoris_id: it.aksesoris_id || null,
          jumlah: parseInt(it.jumlah, 10) || 1,
        })),
      };

      if (editingPaket) {
        await updatePaket(editingPaket.id, payload);
        showToast("Paket bundling berhasil diperbarui!", "success");
      } else {
        await createPaket(payload);
        showToast("Paket bundling baru berhasil dibuat!", "success");
      }

      setShowFormModal(false);
      fetchPakets();
    } catch (err) {
      console.error("Error submit paket:", err);
      showToast(err.response?.data?.message || "Gagal menyimpan paket", "error");
    } finally {
      setSubmitting(false);
    }
  };

  // Delete Single Paket
  const handleDeleteConfirm = async () => {
    if (!showDeleteModal) return;
    try {
      setSubmitting(true);
      await deletePaket(showDeleteModal.id);
      showToast("Paket berhasil dihapus!", "success");
      setShowDeleteModal(null);
      fetchPakets();
    } catch (err) {
      showToast(err.response?.data?.message || "Gagal menghapus paket", "error");
    } finally {
      setSubmitting(false);
    }
  };

  // Delete All (Super Admin only)
  const handleDeleteAllConfirm = async () => {
    if (deleteAllConfirmation.trim() !== "HAPUS SEMUA") {
      showToast("Ketik 'HAPUS SEMUA' dengan huruf besar untuk konfirmasi", "error");
      return;
    }
    try {
      setDeleteAllLoading(true);
      const res = await deleteAllPaket();
      showToast(res.message || "Seluruh data paket berhasil dibersihkan!", "success");
      setShowDeleteAllModal(false);
      setDeleteAllConfirmation("");
      fetchPakets();
    } catch (err) {
      showToast(err.response?.data?.message || "Gagal menghapus seluruh paket", "error");
    } finally {
      setDeleteAllLoading(false);
    }
  };

  // Add Item from Item Picker
  const handleAddItemToPaket = (item, quantity = 1) => {
    const maxStok = Math.max(1, parseInt(item.stok, 10) || 1);

    if (item.stok <= 0) {
      showToast(`Stok ${item.nama} saat ini kosong (0 unit) di gudang!`, "error");
      return;
    }

    const isAlreadyAdded = formData.items.some((it) => 
      (item.asset_id && it.asset_id === item.asset_id) || 
      (item.aksesoris_id && it.aksesoris_id === item.aksesoris_id)
    );

    if (isAlreadyAdded) {
      setFormData((prev) => {
        let reachedLimit = false;
        const updated = prev.items.map((it) => {
          if ((item.asset_id && it.asset_id === item.asset_id) || (item.aksesoris_id && it.aksesoris_id === item.aksesoris_id)) {
            if (it.jumlah >= maxStok) {
              reachedLimit = true;
              return it;
            }
            const nextQty = Math.min(maxStok, it.jumlah + quantity);
            return { ...it, jumlah: nextQty };
          }
          return it;
        });

        if (reachedLimit) {
          showToast(`Jumlah ${item.nama} sudah mencapai batas stok maksimal (${maxStok} unit)`, "error");
        } else {
          showToast(`Jumlah ${item.nama} diperbarui`, "info");
        }
        return { ...prev, items: updated };
      });
      return;
    }

    const initialQty = Math.min(maxStok, Math.max(1, quantity));

    setFormData((prev) => ({
      ...prev,
      items: [
        ...prev.items,
        {
          asset_id: item.asset_id,
          aksesoris_id: item.aksesoris_id,
          nama: item.nama,
          kode: item.kode,
          tipe: item.tipe,
          stok: maxStok,
          jumlah: initialQty,
          kategori: item.kategori,
          merek: item.merek,
        },
      ],
    }));
    showToast(`${item.nama} ditambahkan ke paket`, "success");
  };

  // Remove Item from Form Items
  const handleRemoveItemFromPaket = (index) => {
    setFormData((prev) => ({
      ...prev,
      items: prev.items.filter((_, idx) => idx !== index),
    }));
  };

  // Change Item Qty in Form
  const handleChangeItemQty = (index, delta) => {
    setFormData((prev) => {
      const updated = [...prev.items];
      const maxStok = Math.max(1, parseInt(updated[index].stok, 10) || 1);
      const currentQty = parseInt(updated[index].jumlah, 10) || 1;
      const proposedQty = currentQty + delta;

      if (proposedQty > maxStok) {
        showToast(`Jumlah ${updated[index].nama} tidak boleh melebihi stok yang tersedia (${maxStok} unit)!`, "error");
        updated[index] = { ...updated[index], jumlah: maxStok };
      } else if (proposedQty < 1) {
        updated[index] = { ...updated[index], jumlah: 1 };
      } else {
        updated[index] = { ...updated[index], jumlah: proposedQty };
      }

      return { ...prev, items: updated };
    });
  };

  // Filtered Inventory for Picker Modal
  const filteredPickerItems = useMemo(() => {
    return availableItems.filter((item) => {
      const matchesSearch = 
        item.nama?.toLowerCase().includes(pickerSearch.toLowerCase()) ||
        item.kode?.toLowerCase().includes(pickerSearch.toLowerCase()) ||
        item.kategori?.toLowerCase().includes(pickerSearch.toLowerCase()) ||
        item.merek?.toLowerCase().includes(pickerSearch.toLowerCase());
      
      const matchesTab = 
        pickerTab === "all" ? true : item.tipe === pickerTab;

      const matchesBrand =
        pickerBrand === "semua" ? true : item.jenisAset === pickerBrand;

      return matchesSearch && matchesTab && matchesBrand;
    });
  }, [availableItems, pickerSearch, pickerTab, pickerBrand]);

  // Filtered Pakets for Main List
  const filteredPakets = useMemo(() => {
    if (!search.trim()) return pakets;
    const q = search.toLowerCase();
    return pakets.filter((p) => 
      p.nama_paket?.toLowerCase().includes(q) ||
      p.deskripsi?.toLowerCase().includes(q)
    );
  }, [pakets, search]);

  // Pagination Calculations
  const totalPages = Math.ceil(filteredPakets.length / itemsPerPage) || 1;
  const startIndex = (currentPage - 1) * itemsPerPage;
  const paginatedPakets = filteredPakets.slice(startIndex, startIndex + itemsPerPage);

  const getPageNumbers = () => {
    const p = [];
    if (totalPages <= 5) {
      for (let i = 1; i <= totalPages; i++) p.push(i);
    } else if (currentPage <= 3) {
      for (let i = 1; i <= 3; i++) p.push(i);
      p.push("...");
      p.push(totalPages);
    } else if (currentPage >= totalPages - 2) {
      p.push(1);
      p.push("...");
      for (let i = totalPages - 2; i <= totalPages; i++) p.push(i);
    } else {
      p.push(1);
      p.push("...");
      p.push(currentPage);
      p.push("...");
      p.push(totalPages);
    }
    return p;
  };

  const Pagination = () => (
    <div className="flex flex-col sm:flex-row items-center justify-between px-5 py-3 gap-3">
      <div className="hidden sm:flex items-center gap-3">
        <p className="text-sm text-slate-500 text-nowrap">
          Menampilkan {filteredPakets.length === 0 ? 0 : startIndex + 1}-{Math.min(startIndex + itemsPerPage, filteredPakets.length)} dari{" "}
          <span className="font-semibold text-slate-700">{filteredPakets.length}</span> data
        </p>
        <div className="flex items-center gap-2">
          <select
            value={itemsPerPage}
            onChange={(e) => {
              setItemsPerPage(Number(e.target.value));
              setCurrentPage(1);
            }}
            className="cursor-pointer rounded-lg bg-primary px-2 py-1 text-xs font-semibold text-white focus:outline-none focus:ring-1 focus:ring-primary-hover shadow-sm transition-colors hover:bg-primary-hover"
          >
            {(viewMode === "grid" ? ROWS_OPTIONS_GRID : ROWS_OPTIONS_TABLE).map((opt) => (
              <option key={opt} value={opt} className="bg-white text-slate-700">
                {opt}
              </option>
            ))}
          </select>
          <p className="text-sm text-slate-500 text-nowrap">baris per halaman</p>
        </div>
      </div>
      <div className="flex items-center gap-1">
        <button
          onClick={() => setCurrentPage(1)}
          disabled={currentPage === 1}
          className="cursor-pointer rounded-lg px-2 py-1.5 text-sm text-slate-500 transition-colors hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed"
          title="Halaman Pertama"
        >
          <ChevronsLeft className="h-4 w-4" />
        </button>
        <button
          onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
          disabled={currentPage === 1}
          className="cursor-pointer rounded-lg px-2 py-1.5 text-sm text-slate-500 transition-colors hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed"
          title="Sebelumnya"
        >
          <ChevronLeft className="h-4 w-4" />
        </button>
        {getPageNumbers().map((page, idx) =>
          page === "..." ? (
            <span key={`e-${idx}`} className="min-w-[32px] px-1 py-1.5 text-center text-sm text-slate-400">
              ...
            </span>
          ) : (
            <button
              key={page}
              onClick={() => setCurrentPage(page)}
              className={`cursor-pointer min-w-[32px] rounded-lg px-2.5 py-1.5 text-sm font-medium transition-colors ${
                currentPage === page ? "bg-primary text-white" : "text-slate-600 hover:bg-slate-100"
              }`}
            >
              {page}
            </button>
          )
        )}
        <button
          onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
          disabled={currentPage === totalPages || totalPages === 0}
          className="cursor-pointer rounded-lg px-2 py-1.5 text-sm text-slate-500 transition-colors hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed"
          title="Berikutnya"
        >
          <ChevronRight className="h-4 w-4" />
        </button>
        <button
          onClick={() => setCurrentPage(totalPages)}
          disabled={currentPage === totalPages || totalPages === 0}
          className="cursor-pointer rounded-lg px-2 py-1.5 text-sm text-slate-500 transition-colors hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed"
          title="Halaman Terakhir"
        >
          <ChevronsRight className="h-4 w-4" />
        </button>
      </div>
    </div>
  );

  const canManage = ["super admin", "admin"].includes(userRole);

  if (!mounted) return null;

  return (
    <div className="space-y-6">
      {/* Toast Notification via Portal */}
      {typeof document !== "undefined" && toast && createPortal(
        <div className={`fixed top-20 right-6 z-[9999] flex items-center gap-2 rounded-xl px-5 py-3 shadow-lg text-sm font-medium text-white transition-all animate-[slideIn_0.3s_ease] ${
          toast.type === "error" ? "bg-rose-500" : toast.type === "info" ? "bg-blue-500" : "bg-emerald-500"
        }`}>
          {toast.type === "error" ? <AlertTriangle className="h-4 w-4" /> : toast.type === "info" ? <Info className="h-4 w-4" /> : <Check className="h-4 w-4" />}
          {toast.message}
        </div>,
        document.body
      )}

      {/* Header Halaman Standar */}
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-slate-800">Paket Bundling Peminjaman</h1>
        <p className="text-sm text-slate-500">
          Kelola paket bundling peminjaman alat
        </p>
      </div>

      {/* Container Kontrol & Toolbar dengan Style Top Border (border-t-4 border-t-primary) */}
      <div className="relative overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm border-t-4 border-t-primary">
        {/* Toolbar */}
        <div className="p-4 sm:p-5 border-b border-slate-300 flex flex-col xl:flex-row xl:items-center justify-between gap-3 sm:gap-4 bg-slate-50/50">
          {/* Search Bar */}
          <div className="relative w-full xl:max-w-md">
            <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400" />
            <input
              type="text"
              value={search}
              onChange={(e) => {
                setSearch(e.target.value);
                setCurrentPage(1);
              }}
              placeholder="Cari nama paket atau deskripsi..."
              className="w-full pl-10 pr-9 py-2 text-sm bg-white border-2 border-slate-200 rounded-lg focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary transition-colors hover:border-slate-300 text-slate-700 placeholder:text-slate-400"
            />
            {search && (
              <button
                type="button"
                onClick={() => {
                  setSearch("");
                  setCurrentPage(1);
                }}
                className="cursor-pointer absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
              >
                <X className="h-4 w-4" />
              </button>
            )}
          </div>

          {/* Right Toolbar: View Mode Toggle, Tambah Paket, Hapus Seluruh Data */}
          <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-2.5 sm:gap-3 w-full xl:w-auto justify-between xl:justify-end">
            {/* Toggle Button Kartu / Tabel (Dipertebal sedikit agar jelas terlihat) */}
            <div className="inline-flex items-center p-1 bg-slate-200/90 rounded-lg border-2 border-slate-300 shrink-0 self-start sm:self-auto w-full sm:w-auto">
              <button
                type="button"
                onClick={() => handleToggleViewMode("grid")}
                className={`cursor-pointer flex-1 sm:flex-initial px-3.5 py-1.5 text-xs rounded-md transition-all flex items-center justify-center gap-1.5 ${
                  viewMode === "grid"
                    ? "bg-white text-primary shadow-sm font-bold border border-slate-300/60"
                    : "text-slate-700 hover:text-slate-900 font-semibold"
                }`}
                title="Tampilan Kartu Visual"
              >
                <Grid className="w-4 h-4 stroke-[2.2] shrink-0" />
                <span>Kartu</span>
              </button>
              <button
                type="button"
                onClick={() => handleToggleViewMode("table")}
                className={`cursor-pointer flex-1 sm:flex-initial px-3.5 py-1.5 text-xs rounded-md transition-all flex items-center justify-center gap-1.5 ${
                  viewMode === "table"
                    ? "bg-white text-primary shadow-sm font-bold border border-slate-300/60"
                    : "text-slate-700 hover:text-slate-900 font-semibold"
                }`}
                title="Tampilan Tabel Rapi"
              >
                <List className="w-4 h-4 stroke-[2.2] shrink-0" />
                <span>Tabel</span>
              </button>
            </div>

            {/* Action Buttons: Tambah Paket & Hapus Seluruh Data */}
            {(canManage || (userRole === "super admin" && pakets.length > 0)) && (
              <div className={`grid ${canManage && userRole === "super admin" && pakets.length > 0 ? "grid-cols-2" : "grid-cols-1"} gap-2 w-full sm:w-auto sm:flex sm:items-center`}>
                {canManage && (
                  <button
                    type="button"
                    onClick={handleOpenCreate}
                    className="cursor-pointer flex items-center justify-center gap-1.5 rounded-lg bg-primary px-3.5 py-2.5 text-xs sm:text-sm font-medium text-white shadow-sm transition-colors hover:bg-primary-hover whitespace-nowrap"
                  >
                    <Plus className="h-4 w-4 shrink-0" />
                    <span>Tambah Paket</span>
                  </button>
                )}

                {/* Hapus Seluruh Data - Khusus Super Admin */}
                {userRole === "super admin" && pakets.length > 0 && (
                  <button
                    type="button"
                    onClick={() => {
                      setDeleteAllConfirmation("");
                      setShowDeleteAllModal(true);
                    }}
                    title="Khusus Super Admin: Hapus seluruh data paket"
                    className="cursor-pointer flex items-center justify-center gap-1.5 rounded-lg bg-rose-600 px-3.5 py-2.5 text-xs sm:text-sm font-semibold text-white shadow-sm transition-all hover:bg-rose-700 active:scale-95 whitespace-nowrap"
                  >
                    <Trash2 className="h-4 w-4 shrink-0" />
                    <span>Hapus Seluruh Data</span>
                  </button>
                )}
              </div>
            )}
          </div>
        </div>

        {/* Content Area */}
        {loading ? (
          <div className="p-6">
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 animate-pulse">
              {[1, 2, 3, 4].map((n) => (
                <div key={n} className="rounded-xl border border-slate-200 p-4 space-y-3">
                  <div className="h-4 bg-slate-100 rounded w-3/4" />
                  <div className="h-3 bg-slate-100 rounded w-1/2" />
                  <div className="h-8 bg-slate-100 rounded-lg mt-4" />
                </div>
              ))}
            </div>
          </div>
        ) : filteredPakets.length === 0 ? (
          <div className="p-12 text-center">
            <div className="w-14 h-14 rounded-2xl bg-slate-100 text-slate-400 flex items-center justify-center mx-auto mb-3">
              <Boxes className="h-7 w-7" />
            </div>
            <h3 className="text-base font-bold text-slate-800">
              {search ? "Paket tidak ditemukan" : "Belum Ada Paket Bundling"}
            </h3>
            <p className="text-xs sm:text-sm text-slate-500 max-w-md mx-auto mt-1 mb-5">
              {search 
                ? `Tidak ada paket yang cocok dengan kata kunci "${search}".`
                : "Buat paket bundling peralatan pertama Anda untuk mempermudah peminjaman alat secara kolektif."}
            </p>
            {canManage && !search && (
              <button
                type="button"
                onClick={handleOpenCreate}
                className="cursor-pointer inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-primary text-white text-xs sm:text-sm font-medium hover:bg-primary-hover transition-colors shadow-sm"
              >
                <Plus className="h-4 w-4" />
                <span>Buat Paket Sekarang</span>
              </button>
            )}
          </div>
        ) : (
          <div>
            {/* Table / Grid Controls: Pagination Top */}
            <Pagination />

            {viewMode === "grid" ? (
              /* ========================================================================= */
              /* CARD VIEW DENGAN BADGE TEBAL SEPERTI BADGE KONDISI ASET */
              /* ========================================================================= */
              <div className="p-5 border-t border-slate-100">
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
                  {paginatedPakets.map((paket) => (
                    <div
                      key={paket.id}
                      onClick={() => handleOpenDetail(paket)}
                      className="cursor-pointer group relative bg-white rounded-xl border-2 border-slate-300 hover:border-primary hover:bg-slate-50/50 hover:shadow-sm transition-all p-5 flex flex-col justify-between"
                    >
                      <div>
                        {/* Header Badges: Border Tegas Seperti Badge Kondisi Aset */}
                        <div className="flex items-center justify-between gap-2 mb-3">
                          <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-semibold bg-blue-50 text-blue-700 border border-blue-500 shadow-2xs">
                            <Boxes className="w-3.5 h-3.5" />
                            <span>{paket.total_items || 0} Jenis Alat</span>
                          </span>
                          <span className="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-bold bg-amber-50 text-amber-700 border border-amber-500 shadow-2xs">
                            {paket.total_qty || 0} Unit
                          </span>
                        </div>

                        {/* Title & Description */}
                        <h3
                          className="font-bold text-slate-800 text-base leading-snug line-clamp-1 group-hover:text-primary transition-colors"
                          title={paket.nama_paket}
                        >
                          {paket.nama_paket}
                        </h3>
                        <p className="text-xs text-slate-500 line-clamp-2 mt-1.5 leading-relaxed min-h-[34px]">
                          {paket.deskripsi || "Tidak ada catatan khusus untuk paket bundling ini."}
                        </p>
                      </div>

                      {/* Footer: Detail Indicator & Actions */}
                      <div className="pt-3.5 mt-3.5 border-t border-slate-200 flex items-center justify-between">
                        <span className="text-xs text-slate-400 group-hover:text-primary transition-colors flex items-center gap-1 font-medium">
                          Detail isi <ArrowRight className="w-3 h-3" />
                        </span>

                        {canManage && (
                          <div className="flex items-center gap-1.5" onClick={(e) => e.stopPropagation()}>
                            <button
                              type="button"
                              onClick={() => handleOpenEdit(paket)}
                              className="cursor-pointer rounded-lg bg-amber-100 p-1.5 text-amber-600 transition-colors hover:bg-amber-600 hover:text-white"
                              title="Edit Paket"
                            >
                              <Pencil className="h-3.5 w-3.5" />
                            </button>
                            <button
                              type="button"
                              onClick={() => setShowDeleteModal(paket)}
                              className="cursor-pointer rounded-lg bg-rose-100 p-1.5 text-rose-600 transition-colors hover:bg-rose-600 hover:text-white"
                              title="Hapus Paket"
                            >
                              <Trash2 className="h-3.5 w-3.5" />
                            </button>
                          </div>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            ) : (
              /* ========================================================================= */
              /* TABLE VIEW: IDENTIK PERSIS DENGAN TABEL HALAMAN ASET / DAFTAR */
              /* ========================================================================= */
              <div className="overflow-x-auto border-t border-slate-100">
                <table className="w-full min-w-[760px] text-left text-sm table-fixed">
                  <thead>
                    <tr className="border-t border-t-slate-300 border-b border-b-slate-300">
                      <th className="w-[360px] sm:w-[450px] px-4 py-3 font-bold text-slate-700 text-center text-xs uppercase tracking-wider border-r border-slate-200">
                        Nama Paket & Keterangan
                      </th>
                      <th className="w-[160px] px-3 py-3 font-bold text-slate-700 text-center text-xs uppercase tracking-wider border-r border-slate-200">
                        Jumlah Jenis Alat
                      </th>
                      <th className="w-[140px] px-3 py-3 font-bold text-slate-700 text-center text-xs uppercase tracking-wider border-r border-slate-200">
                        Total Unit
                      </th>
                      <th className="w-[120px] px-3 py-3 font-bold text-slate-700 text-center text-xs uppercase tracking-wider">
                        Aksi
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    {paginatedPakets.map((paket, index) => (
                      <tr
                        key={paket.id}
                        className={`border-b border-slate-100 transition-colors ${
                          index % 2 === 0 ? "bg-slate-100" : "bg-white"
                        }`}
                      >
                        {/* Info Paket */}
                        <td
                          className="px-4 py-3 text-xs text-slate-600 hover:text-primary cursor-pointer border-r border-slate-200 align-middle"
                          onClick={() => handleOpenDetail(paket)}
                          title={paket.nama_paket}
                        >
                          <div className="font-semibold text-slate-800 text-sm hover:text-primary transition-colors truncate">
                            {paket.nama_paket}
                          </div>
                          <p className="text-xs text-slate-500 line-clamp-1 mt-0.5">
                            {paket.deskripsi || "Tanpa keterangan"}
                          </p>
                        </td>

                        {/* Jumlah Jenis Alat: Badge Style Identik dengan Kondisi Aset */}
                        <td className="px-3 py-3 text-center border-r border-slate-200 align-middle">
                          <span className="inline-block rounded-full border border-blue-500 bg-blue-50 px-2.5 py-1 text-xs font-semibold text-blue-700 shadow-2xs whitespace-nowrap">
                            {paket.total_items || 0} Jenis Alat
                          </span>
                        </td>

                        {/* Total Unit: Badge Style Identik dengan Kondisi Aset */}
                        <td className="px-3 py-3 text-center border-r border-slate-200 align-middle">
                          <span className="inline-block rounded-full border border-amber-500 bg-amber-50 px-2.5 py-1 text-xs font-bold text-amber-700 shadow-2xs whitespace-nowrap">
                            {paket.total_qty || 0} Unit
                          </span>
                        </td>

                        {/* Actions: Identik Persis dengan Halaman Aset */}
                        <td className="px-3 py-3 text-center align-middle" onClick={(e) => e.stopPropagation()}>
                          {canManage && (
                            <div className="flex items-center justify-center gap-1">
                              <button
                                type="button"
                                onClick={(e) => {
                                  e.stopPropagation();
                                  handleOpenEdit(paket);
                                }}
                                className="cursor-pointer rounded-lg bg-amber-100 p-1 text-amber-600 transition-colors hover:bg-amber-600 hover:text-white"
                                title="Edit"
                              >
                                <Pencil className="h-3.5 w-3.5" />
                              </button>
                              <button
                                type="button"
                                onClick={(e) => {
                                  e.stopPropagation();
                                  setShowDeleteModal(paket);
                                }}
                                className="cursor-pointer rounded-lg bg-rose-100 p-1 text-rose-600 transition-colors hover:bg-rose-600 hover:text-white"
                                title="Hapus"
                              >
                                <Trash2 className="h-3.5 w-3.5" />
                              </button>
                            </div>
                          )}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}

            {/* Pagination Bottom */}
            <div className="border-t border-slate-200">
              <Pagination />
            </div>
          </div>
        )}
      </div>

      {/* ========================================================================= */}
      {/* MODAL TAMBAH / EDIT PAKET (STYLE PERSIS ASET/AKSESORIS) */}
      {/* Tambah = Hijau (Emerald-500), Edit = Oranye/Amber (Amber-500) */}
      {/* ========================================================================= */}
      {typeof document !== "undefined" && showFormModal && createPortal(
        <div
          className="fixed inset-0 z-60 flex items-center justify-center bg-black/40 p-4 transition-opacity animate-in fade-in duration-300"
          onClick={() => setShowFormModal(false)}
        >
          <form
            onSubmit={handleSubmitForm}
            className={`max-h-[90vh] w-full max-w-2xl flex flex-col rounded-2xl bg-white shadow-xl animate-modal-in border-t-4 ${
              editingPaket ? "border-t-amber-500" : "border-t-emerald-500"
            }`}
            onClick={(e) => e.stopPropagation()}
          >
            {/* Modal Header: Konsisten Persis dengan Tambah/Edit Aset */}
            <div
              className={`flex items-center justify-between border-b border-slate-100 px-6 py-4 rounded-t-2xl shrink-0 ${
                editingPaket ? "bg-amber-50" : "bg-emerald-50"
              }`}
            >
              <h2
                className={`text-lg font-bold ${
                  editingPaket ? "text-amber-800" : "text-emerald-800"
                }`}
              >
                {editingPaket ? "Edit Paket" : "Tambah Paket Baru"}
              </h2>
              <button
                type="button"
                onClick={() => setShowFormModal(false)}
                className="cursor-pointer rounded-lg p-1.5 text-slate-400 transition-colors hover:bg-slate-100 hover:text-slate-600"
              >
                <X className="h-5 w-5" />
              </button>
            </div>

            {/* Modal Body */}
            <div className="overflow-y-auto custom-scrollbar flex-1 p-6 space-y-5">
              {/* Nama Paket */}
              <div>
                <label className="mb-1.5 block text-sm font-medium text-slate-700">
                  Nama Paket <span className="text-rose-500">*</span>
                </label>
                <input
                  type="text"
                  required
                  value={formData.nama_paket}
                  onChange={(e) => setFormData({ ...formData, nama_paket: e.target.value })}
                  placeholder="Masukkan nama paket bundling"
                  className="w-full rounded-lg border border-slate-200 px-3 py-2.5 text-sm text-slate-700 placeholder:text-slate-400 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary transition-colors hover:border-slate-300"
                />
              </div>

              {/* Deskripsi */}
              <div>
                <label className="mb-1.5 block text-sm font-medium text-slate-700">
                  Deskripsi / Keterangan Paket
                </label>
                <textarea
                  rows={2}
                  value={formData.deskripsi}
                  onChange={(e) => setFormData({ ...formData, deskripsi: e.target.value })}
                  placeholder="Keterangan singkat mengenai peruntukan atau kelengkapan paket..."
                  className="w-full rounded-lg border border-slate-200 px-3 py-2 text-sm text-slate-700 placeholder:text-slate-400 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary transition-colors hover:border-slate-300 resize-none"
                />
              </div>

              {/* Section Daftar Barang dalam Paket */}
              <div>
                <div className="flex items-center justify-between mb-3">
                  <h3 className="flex items-center gap-2 text-sm font-semibold text-slate-800 uppercase tracking-wide">
                    <Package className={`h-4 w-4 ${editingPaket ? "text-amber-500" : "text-emerald-500"}`} />
                    Daftar Peralatan Paket
                  </h3>
                  <button
                    type="button"
                    onClick={() => setShowItemPicker(true)}
                    className={`cursor-pointer inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors ${
                      editingPaket
                        ? "bg-amber-100 text-amber-700 hover:bg-amber-200"
                        : "bg-emerald-100 text-emerald-700 hover:bg-emerald-200"
                    }`}
                  >
                    <Plus className="h-3.5 w-3.5" />
                    <span>Pilih Peralatan</span>
                  </button>
                </div>

                {formData.items.length === 0 ? (
                  <div className="p-6 rounded-xl border border-dashed border-slate-200 bg-slate-50 text-center">
                    <Package className="h-7 w-7 text-slate-300 mx-auto mb-1.5" />
                    <p className="text-xs font-medium text-slate-600">Belum ada alat di dalam paket ini</p>
                    <p className="text-[11px] text-slate-400 mt-0.5">
                      Klik tombol &quot;Pilih Peralatan&quot; di atas untuk memilih aset atau aksesoris
                    </p>
                  </div>
                ) : (
                  <div className="space-y-2 border border-slate-200 rounded-xl p-2.5 bg-slate-50/50 max-h-60 overflow-y-auto custom-scrollbar">
                    {formData.items.map((it, idx) => (
                      <div
                        key={idx}
                        className="flex items-center justify-between gap-3 p-2.5 bg-white rounded-lg border border-slate-200 shadow-2xs"
                      >
                        <div className="flex items-center gap-2.5 min-w-0 flex-1">
                          <div className="w-9 h-9 rounded-lg bg-slate-100 flex items-center justify-center shrink-0 border border-slate-200 text-slate-500">
                            <Package className="h-4 w-4" />
                          </div>
                          <div className="min-w-0 flex-1">
                            <div className="flex items-center gap-1.5">
                              <span
                                className={`text-[10px] font-bold px-1.5 py-0.5 rounded ${
                                  it.tipe === "asset"
                                    ? "bg-blue-50 text-blue-700 border border-blue-200"
                                    : "bg-purple-50 text-purple-700 border border-purple-200"
                                }`}
                              >
                                {it.tipe === "asset" ? "Aset" : "Aksesoris"}
                              </span>
                              <p className="text-xs font-bold text-slate-800 truncate">{it.nama}</p>
                            </div>
                            <p className="text-[11px] text-slate-400">
                              Kode: {it.kode || "-"} • Stok: <span className="font-semibold text-slate-700">{it.stok} unit</span>
                            </p>
                          </div>
                        </div>

                        {/* Stepper Jumlah Terkunci Batas Stok */}
                        <div className="flex items-center gap-2">
                          <div className="flex items-center border border-slate-200 rounded-lg overflow-hidden bg-slate-50">
                            <button
                              type="button"
                              onClick={() => handleChangeItemQty(idx, -1)}
                              disabled={it.jumlah <= 1}
                              className="cursor-pointer px-2 py-1 text-slate-600 hover:bg-slate-200 text-xs font-bold transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
                            >
                              -
                            </button>
                            <span className="px-2.5 py-1 text-xs font-bold text-slate-800 bg-white min-w-[28px] text-center">
                              {it.jumlah}
                            </span>
                            <button
                              type="button"
                              onClick={() => handleChangeItemQty(idx, 1)}
                              disabled={it.jumlah >= it.stok}
                              className="cursor-pointer px-2 py-1 text-slate-600 hover:bg-slate-200 text-xs font-bold transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
                              title={it.jumlah >= it.stok ? `Maksimal stok tercapai (${it.stok} unit)` : "Tambah jumlah"}
                            >
                              +
                            </button>
                          </div>

                          <button
                            type="button"
                            onClick={() => handleRemoveItemFromPaket(idx)}
                            className="cursor-pointer rounded-lg bg-rose-100 p-1.5 text-rose-600 transition-colors hover:bg-rose-600 hover:text-white"
                            title="Hapus dari paket"
                          >
                            <Trash2 className="h-3.5 w-3.5" />
                          </button>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            </div>

            {/* Modal Footer: Identik dengan Aset/Aksesoris */}
            <div className="flex items-center justify-end gap-3 border-t border-slate-100 px-6 py-4 bg-white rounded-b-2xl shrink-0">
              <button
                type="button"
                onClick={() => setShowFormModal(false)}
                className="cursor-pointer rounded-lg border border-slate-200 px-4 py-2 text-sm font-medium text-slate-600 transition-colors hover:bg-slate-50"
              >
                Batal
              </button>
              <button
                type="submit"
                disabled={submitting}
                className={`cursor-pointer rounded-lg px-4 py-2 text-sm font-medium text-white shadow-sm transition-colors disabled:opacity-60 ${
                  editingPaket
                    ? "bg-amber-500 hover:bg-amber-600"
                    : "bg-emerald-500 hover:bg-emerald-600"
                }`}
              >
                {submitting ? "Menyimpan..." : editingPaket ? "Simpan Perubahan" : "Simpan Paket"}
              </button>
            </div>
          </form>
        </div>,
        document.body
      )}

      {/* ========================================================================= */}
      {/* ITEM PICKER SUB-MODAL */}
      {/* ========================================================================= */}
      {typeof document !== "undefined" && showItemPicker && createPortal(
        <div
          className="fixed inset-0 z-70 flex items-center justify-center p-4 bg-black/40 backdrop-blur-xs transition-opacity animate-in fade-in duration-300"
          onClick={() => setShowItemPicker(false)}
        >
          <div
            className="bg-white rounded-2xl w-full max-w-xl max-h-[85vh] flex flex-col shadow-2xl border border-slate-200 border-t-4 border-t-emerald-500 animate-modal-in overflow-hidden"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between px-5 py-3.5 border-b border-slate-100 bg-emerald-50 rounded-t-2xl">
              <h2 className="text-base font-bold text-emerald-800">Pilih Alat untuk Bundling Paket</h2>
              <button
                type="button"
                onClick={() => setShowItemPicker(false)}
                className="cursor-pointer p-1 rounded-lg text-slate-400 hover:text-slate-600 hover:bg-slate-100"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            {/* Filter & Search */}
            <div className="p-3.5 border-b border-slate-100 space-y-2.5 bg-white">
              <div className="relative">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-slate-400" />
                <input
                  type="text"
                  value={pickerSearch}
                  onChange={(e) => setPickerSearch(e.target.value)}
                  placeholder="Cari nama alat, kode, kategori, atau merek..."
                  className="w-full pl-9 pr-3 py-1.5 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:outline-none focus:ring-1 focus:ring-primary text-slate-700 placeholder:text-slate-400"
                />
              </div>

              {/* Dual Filter Controls: Tipe & Brand */}
              <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-2">
                {/* Filter Tipe: Segmented Buttons */}
                <div className="inline-flex items-center p-0.5 bg-slate-100 rounded-lg border border-slate-200/80 shrink-0">
                  {[
                    { id: "all", label: "Semua Tipe" },
                    { id: "asset", label: "Aset" },
                    { id: "aksesoris", label: "Aksesoris" },
                  ].map((tab) => (
                    <button
                      key={tab.id}
                      type="button"
                      onClick={() => setPickerTab(tab.id)}
                      className={`cursor-pointer px-2.5 py-1 text-xs font-semibold rounded-md transition-all ${
                        pickerTab === tab.id
                          ? "bg-white text-primary shadow-xs font-bold"
                          : "text-slate-600 hover:text-slate-900"
                      }`}
                    >
                      {tab.label}
                    </button>
                  ))}
                </div>

                {/* Filter Brand Dropdown */}
                <div className="shrink-0">
                  <select
                    value={pickerBrand}
                    onChange={(e) => setPickerBrand(e.target.value)}
                    className="cursor-pointer text-xs font-medium px-2.5 py-1 rounded-lg border border-slate-200 bg-white text-slate-700 focus:outline-none focus:ring-1 focus:ring-primary w-full sm:w-auto shadow-2xs"
                  >
                    <option value="semua">Semua Departemen</option>
                    <option value="Galeria Production">Galeria Production</option>
                    <option value="Galeria Studio">Galeria Studio</option>
                  </select>
                </div>
              </div>
            </div>

            {/* List Items */}
            <div className="flex-1 overflow-y-auto p-3.5 space-y-2 custom-scrollbar bg-slate-50/30">
              {filteredPickerItems.length === 0 ? (
                <div className="p-8 text-center text-slate-400 text-xs space-y-1">
                  <Package className="h-7 w-7 text-slate-300 mx-auto mb-1" />
                  <p className="font-semibold text-slate-600">Tidak ada alat yang cocok</p>
                  <p className="text-slate-400">Coba ubah kata kunci pencarian atau filter</p>
                </div>
              ) : (
                filteredPickerItems.map((item) => {
                  const existingItem = formData.items.find((it) => 
                    (item.asset_id && it.asset_id === item.asset_id) || 
                    (item.aksesoris_id && it.aksesoris_id === item.aksesoris_id)
                  );
                  const isAdded = !!existingItem;
                  const isOutOfStock = item.stok <= 0;
                  const maxStok = Math.max(1, parseInt(item.stok, 10) || 1);

                  return (
                    <div
                      key={`${item.tipe}-${item.asset_id || item.aksesoris_id}`}
                      className={`flex items-center justify-between p-3 rounded-xl border transition-all ${
                        isOutOfStock 
                          ? "bg-slate-50 border-slate-200 opacity-60" 
                          : isAdded
                          ? "bg-primary/5 border-primary/30 shadow-2xs"
                          : "bg-white border-slate-200 hover:border-slate-300 hover:shadow-2xs"
                      }`}
                    >
                      <div className="flex items-center gap-3 min-w-0 flex-1">
                        <div className="w-9 h-9 rounded-lg bg-slate-100 flex items-center justify-center shrink-0 border border-slate-200 text-slate-500">
                          <Package className="h-4 w-4" />
                        </div>
                        <div className="min-w-0 flex-1">
                          <div className="flex items-center gap-1.5 flex-wrap">
                            <span
                              className={`text-[10px] font-bold px-1.5 py-0.2 rounded ${
                                item.tipe === "asset"
                                  ? "bg-blue-50 text-blue-700 border border-blue-200"
                                  : "bg-purple-50 text-purple-700 border border-purple-200"
                              }`}
                            >
                              {item.tipe === "asset" ? "Aset" : "Aksesoris"}
                            </span>
                            {item.jenisAset && (
                              <span
                                className={`text-[10px] font-bold px-1.5 py-0.2 rounded ${
                                  item.jenisAset === "Galeria Production"
                                    ? "bg-amber-50 text-amber-700 border border-amber-200"
                                    : "bg-emerald-50 text-emerald-700 border border-emerald-200"
                                }`}
                              >
                                {item.jenisAset}
                              </span>
                            )}
                            <p className="text-xs font-bold text-slate-800 truncate">{item.nama}</p>
                          </div>
                          <p className="text-[11px] text-slate-400 mt-0.5">
                            {item.kategori || "-"} • Stok: <span className={`font-semibold ${isOutOfStock ? "text-rose-500 font-bold" : "text-slate-700"}`}>{item.stok} unit</span>
                            {item.merek && ` • ${item.merek}`}
                          </p>
                        </div>
                      </div>

                      {/* Action / Stepper Terkunci Stok */}
                      <div className="shrink-0 flex items-center gap-2">
                        {isOutOfStock ? (
                          <span className="px-2.5 py-1 text-[11px] font-semibold text-rose-600 bg-rose-50 border border-rose-200 rounded-lg">
                            Stok Habis
                          </span>
                        ) : isAdded ? (
                          <div className="flex items-center gap-1.5">
                            <div className="flex items-center border border-primary/30 rounded-lg overflow-hidden bg-white shadow-2xs">
                              <button
                                type="button"
                                onClick={() => {
                                  const idx = formData.items.findIndex(
                                    (it) =>
                                      (item.asset_id && it.asset_id === item.asset_id) ||
                                      (item.aksesoris_id && it.aksesoris_id === item.aksesoris_id)
                                  );
                                  if (idx >= 0) {
                                    if (formData.items[idx].jumlah <= 1) {
                                      handleRemoveItemFromPaket(idx);
                                    } else {
                                      handleChangeItemQty(idx, -1);
                                    }
                                  }
                                }}
                                className="cursor-pointer px-2 py-1 text-slate-600 hover:bg-slate-100 text-xs font-bold"
                              >
                                -
                              </button>
                              <span className="px-2 py-1 text-xs font-bold text-primary min-w-[24px] text-center">
                                {existingItem.jumlah}
                              </span>
                              <button
                                type="button"
                                disabled={existingItem.jumlah >= maxStok}
                                onClick={() => {
                                  const idx = formData.items.findIndex(
                                    (it) =>
                                      (item.asset_id && it.asset_id === item.asset_id) ||
                                      (item.aksesoris_id && it.aksesoris_id === item.aksesoris_id)
                                  );
                                  if (idx >= 0) handleChangeItemQty(idx, 1);
                                }}
                                className="cursor-pointer px-2 py-1 text-slate-600 hover:bg-slate-100 text-xs font-bold disabled:opacity-30 disabled:cursor-not-allowed"
                                title={existingItem.jumlah >= maxStok ? "Maksimal stok tercapai" : "Tambah"}
                              >
                                +
                              </button>
                            </div>
                            <button
                              type="button"
                              onClick={() => {
                                const idx = formData.items.findIndex(
                                  (it) =>
                                    (item.asset_id && it.asset_id === item.asset_id) ||
                                    (item.aksesoris_id && it.aksesoris_id === item.aksesoris_id)
                                );
                                if (idx >= 0) handleRemoveItemFromPaket(idx);
                              }}
                              className="cursor-pointer rounded-lg bg-rose-100 p-1.5 text-rose-600 transition-colors hover:bg-rose-600 hover:text-white"
                              title="Hapus dari paket"
                            >
                              <Trash2 className="w-3.5 h-3.5" />
                            </button>
                          </div>
                        ) : (
                          <button
                            type="button"
                            onClick={() => handleAddItemToPaket(item, 1)}
                            className="cursor-pointer px-3 py-1.5 text-xs font-semibold rounded-lg bg-emerald-500 text-white hover:bg-emerald-600 shadow-2xs transition-colors"
                          >
                            + Tambah
                          </button>
                        )}
                      </div>
                    </div>
                  );
                })
              )}
            </div>

            {/* Picker Footer */}
            <div className="p-3 border-t border-slate-100 bg-slate-50 flex items-center justify-between">
              <span className="text-xs text-slate-600">
                Terpilih: <b>{formData.items.length}</b> jenis alat ({formData.items.reduce((s, it) => s + it.jumlah, 0)} total unit)
              </span>
              <button
                type="button"
                onClick={() => setShowItemPicker(false)}
                className="cursor-pointer px-4 py-1.5 text-xs font-semibold text-white bg-emerald-500 rounded-lg hover:bg-emerald-600 transition-colors shadow-2xs"
              >
                Selesai
              </button>
            </div>
          </div>
        </div>,
        document.body
      )}

      {/* ========================================================================= */}
      {/* MODAL DETAIL / PRATINJAU ISI PAKET (STYLE IDENTIK DENGAN ASET/AKSESORIS) */}
      {/* ========================================================================= */}
      {typeof document !== "undefined" && showDetailModal && createPortal(
        <div
          className="fixed inset-0 z-60 flex items-center justify-center bg-black/40 p-4 transition-opacity animate-in fade-in duration-300"
          onClick={() => setShowDetailModal(null)}
        >
          <div
            className="max-h-[90vh] w-full max-w-xl flex flex-col rounded-2xl bg-white shadow-xl border-t-4 border-t-blue-500 animate-modal-in overflow-hidden"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between border-b border-slate-100 bg-blue-50 px-6 py-4 rounded-t-2xl shrink-0">
              <h2 className="text-lg font-bold text-blue-800">{showDetailModal.nama_paket}</h2>
              <button
                type="button"
                onClick={() => setShowDetailModal(null)}
                className="cursor-pointer rounded-lg p-1.5 text-slate-400 transition-colors hover:bg-slate-100 hover:text-slate-600"
              >
                <X className="h-5 w-5" />
              </button>
            </div>

            <div className="flex-1 overflow-y-auto p-6 space-y-4 custom-scrollbar">
              {showDetailModal.deskripsi && (
                <div className="p-3 bg-slate-50 rounded-xl border border-slate-200 text-xs text-slate-600 leading-relaxed">
                  {showDetailModal.deskripsi}
                </div>
              )}

              <div>
                <h4 className="text-xs font-bold uppercase tracking-wider text-slate-500 mb-2">
                  Daftar Peralatan ({showDetailModal.items?.length || 0} Jenis Alat):
                </h4>
                <div className="space-y-2">
                  {(showDetailModal.items || []).map((it, idx) => {
                    const readyUnitsCount = (it.units || []).filter(
                      (u) => u.status_pinjam === "Tersedia" && u.kondisi === "Siap Digunakan"
                    ).length;

                    return (
                      <div
                        key={idx}
                        className="flex items-center justify-between p-3 rounded-xl border border-slate-200 bg-white"
                      >
                        <div className="flex items-center gap-3">
                          <div className="w-9 h-9 rounded-lg bg-slate-100 shrink-0 flex items-center justify-center border border-slate-200 text-slate-500">
                            <Package className="h-4 w-4" />
                          </div>
                          <div>
                            <p className="text-xs sm:text-sm font-bold text-slate-800">{it.nama_item}</p>
                            <p className="text-[11px] text-slate-400">
                              Kode: {it.kode_item || "-"} • Kategori: {it.kategori || "-"}
                            </p>
                            {it.units?.length > 0 && (
                              <p className="text-[10px] text-emerald-600 font-semibold mt-0.5">
                                Siap di Gudang: {readyUnitsCount} dari {it.units.length} unit fisik
                              </p>
                            )}
                          </div>
                        </div>

                        <div className="text-right">
                          <span className="inline-block rounded-full border border-amber-500 bg-amber-50 px-2.5 py-1 text-xs font-bold text-amber-700 shadow-2xs">
                            {it.jumlah} Unit
                          </span>
                        </div>
                      </div>
                    );
                  })}
                </div>
              </div>
            </div>

            {/* Footer Detail: Tombol Tutup Biru Senada dengan Top Border */}
            <div className="flex items-center justify-end border-t border-slate-100 px-6 py-4 bg-white rounded-b-2xl shrink-0">
              <button
                type="button"
                onClick={() => setShowDetailModal(null)}
                className="cursor-pointer rounded-lg bg-blue-500 px-4 py-2 text-sm font-medium text-white transition-colors hover:bg-blue-600 shadow-sm"
              >
                Tutup
              </button>
            </div>
          </div>
        </div>,
        document.body
      )}

      {/* ========================================================================= */}
      {/* MODAL KONFIRMASI HAPUS TUNGGAL (STYLE TOP BORDER: border-t-4 border-t-rose-600) */}
      {/* ========================================================================= */}
      {typeof document !== "undefined" && showDeleteModal && createPortal(
        <div
          className="fixed inset-0 z-60 flex items-center justify-center bg-black/40 p-4 transition-opacity animate-in fade-in duration-300"
          onClick={() => setShowDeleteModal(null)}
        >
          <div
            className="w-full max-w-sm rounded-2xl bg-white p-6 shadow-xl animate-modal-in border-t-4 border-t-rose-600 text-center space-y-4"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="w-12 h-12 rounded-full bg-rose-100 text-rose-600 flex items-center justify-center mx-auto">
              <Trash2 className="h-6 w-6" />
            </div>
            <div>
              <h3 className="text-base font-bold text-slate-800">Hapus Paket Bundling?</h3>
              <p className="text-xs text-slate-500 mt-1">
                Apakah Anda yakin ingin menghapus paket <b>&quot;{showDeleteModal.nama_paket}&quot;</b>? Tindakan ini tidak dapat dibatalkan.
              </p>
            </div>
            <div className="flex items-center justify-end gap-3 pt-2">
              <button
                type="button"
                onClick={() => setShowDeleteModal(null)}
                className="cursor-pointer flex-1 rounded-lg border border-slate-200 px-4 py-2 text-sm font-medium text-slate-600 transition-colors hover:bg-slate-50"
              >
                Batal
              </button>
              <button
                type="button"
                onClick={handleDeleteConfirm}
                disabled={submitting}
                className="cursor-pointer flex-1 rounded-lg bg-rose-600 px-4 py-2 text-sm font-medium text-white shadow-sm transition-colors hover:bg-rose-700 disabled:opacity-60"
              >
                {submitting ? "Menghapus..." : "Ya, Hapus"}
              </button>
            </div>
          </div>
        </div>,
        document.body
      )}

      {/* ========================================================================= */}
      {/* MODAL HAPUS SELURUH DATA (SUPER ADMIN, border-t-4 border-t-rose-600) */}
      {/* ========================================================================= */}
      {typeof document !== "undefined" && showDeleteAllModal && createPortal(
        <div
          className="fixed inset-0 z-60 flex items-center justify-center bg-black/40 p-4 transition-opacity animate-in fade-in duration-300"
          onClick={() => setShowDeleteAllModal(false)}
        >
          <div
            className="w-full max-w-md rounded-2xl bg-white p-6 shadow-xl border-t-4 border-t-rose-600 animate-modal-in space-y-4"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center gap-3">
              <div className="p-3 rounded-xl bg-rose-100 text-rose-600 shrink-0">
                <AlertTriangle className="h-6 w-6" />
              </div>
              <div>
                <h3 className="text-base font-bold text-slate-800">Hapus Seluruh Paket Bundling</h3>
                <p className="text-xs text-slate-500">Tindakan berbahaya khusus Super Admin</p>
              </div>
            </div>

            <p className="text-xs text-slate-600 leading-relaxed bg-rose-50 p-3 rounded-xl border border-rose-200 text-rose-800">
              Semua data paket bundling peminjaman akan dihapus permanen, dan nomor ID tabel otomatis diatur kembali ke <b>1</b>.
            </p>

            <div>
              <label className="block text-xs font-semibold text-slate-600 mb-1.5">
                Ketik <span className="font-bold text-rose-600">HAPUS SEMUA</span> untuk konfirmasi:
              </label>
              <input
                type="text"
                value={deleteAllConfirmation}
                onChange={(e) => setDeleteAllConfirmation(e.target.value)}
                placeholder="HAPUS SEMUA"
                className="w-full px-3.5 py-2 text-sm bg-white border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-rose-500/20 focus:border-rose-500"
              />
            </div>

            <div className="flex items-center justify-end gap-3 pt-2">
              <button
                type="button"
                onClick={() => setShowDeleteAllModal(false)}
                className="cursor-pointer flex-1 rounded-lg border border-slate-200 px-4 py-2 text-sm font-medium text-slate-600 transition-colors hover:bg-slate-50"
              >
                Batal
              </button>
              <button
                type="button"
                onClick={handleDeleteAllConfirm}
                disabled={deleteAllLoading || deleteAllConfirmation.trim() !== "HAPUS SEMUA"}
                className="cursor-pointer flex-1 rounded-lg bg-rose-600 px-4 py-2 text-sm font-medium text-white shadow-sm transition-all hover:bg-rose-700 disabled:opacity-50"
              >
                {deleteAllLoading ? "Menghapus..." : "Konfirmasi Hapus"}
              </button>
            </div>
          </div>
        </div>,
        document.body
      )}
    </div>
  );
}
