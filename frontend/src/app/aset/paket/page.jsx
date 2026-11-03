"use client";

import { useState, useEffect, useCallback, useMemo } from "react";
import { createPortal } from "react-dom";
import Image from "next/image";
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
  Cpu, 
  AlertTriangle, 
  Eye, 
  Image as ImageIcon, 
  Sparkles,
  Layers,
  Info
} from "lucide-react";

export default function PaketPage() {
  const [pakets, setPakets] = useState([]);
  const [loading, setLoading] = useState(true);
  const [userRole, setUserRole] = useState("user");
  const [mounted, setMounted] = useState(false);
  const [toast, setToast] = useState(null);
  const [search, setSearch] = useState("");

  // Inventory source for item picker
  const [availableItems, setAvailableItems] = useState([]);
  const [loadingInventory, setLoadingInventory] = useState(false);

  // Modals state
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
    gambarFile: null,
    gambarPreview: null,
    items: [], // [{ id, asset_id, aksesoris_id, nama, kode, tipe, stok, jumlah, gambar }]
  });

  // Picker item search within form modal
  const [pickerSearch, setPickerSearch] = useState("");
  const [pickerTab, setPickerTab] = useState("all"); // "all", "asset", "aksesoris"
  const [pickerBrand, setPickerBrand] = useState("semua"); // "semua", "Galeria Studio", "Galeria Production"
  const [showItemPicker, setShowItemPicker] = useState(false);

  const BACKEND_URL = process.env.NEXT_PUBLIC_BACKEND_URL || "http://localhost:5000";

  const showToast = (message, type = "success") => {
    setToast({ message, type });
    setTimeout(() => setToast(null), 3500);
  };

  useEffect(() => {
    setMounted(true);
    const ctx = getUserContext();
    if (ctx) setUserRole(ctx.role || "user");
  }, []);

  // Fetch all packages
  const fetchPakets = useCallback(async () => {
    try {
      setLoading(true);
      const data = await getAllPaket();
      setPakets(data || []);
    } catch (err) {
      console.error("Error fetching paket:", err);
      showToast("Gagal memuat data paket", "error");
    } finally {
      setLoading(false);
    }
  }, []);

  // Fetch available inventory (assets & aksesoris) for item picker
  const fetchInventory = useCallback(async () => {
    try {
      setLoadingInventory(true);
      const [assets, aksesoris] = await Promise.all([
        getAllAssets(),
        getAllAksesoris(),
      ]);

      const assetList = (assets || [])
        .filter((a) => a.kondisi !== "Dijual")
        .map((a) => ({
          id: a.id,
          asset_id: a.id,
          aksesoris_id: null,
          nama: a.namaAset,
          kode: a.kodeAset,
          kategori: a.kategori,
          merek: a.merek,
          jenisAset: a.jenisAset || a.jenis_aset || "",
          tipe: "asset",
          stok: a.jumlah || 0,
          gambar: a.gambar,
        }));

      const aksesorisList = (aksesoris || [])
        .filter((ak) => ak.kondisi !== "Dijual")
        .map((ak) => ({
          id: ak.id,
          asset_id: null,
          aksesoris_id: ak.id,
          nama: ak.namaAksesoris,
          kode: ak.kodeAksesoris,
          kategori: ak.kategori,
          merek: ak.merek,
          jenisAset: ak.jenisAset || ak.jenis_aset || "",
          tipe: "aksesoris",
          stok: ak.jumlahUnit || ak.jumlah_unit || 0,
          gambar: ak.gambar,
        }));

      setAvailableItems([...assetList, ...aksesorisList]);
    } catch (err) {
      console.error("Error fetching inventory:", err);
    } finally {
      setLoadingInventory(false);
    }
  }, []);

  useEffect(() => {
    fetchPakets();
    fetchInventory();
  }, [fetchPakets, fetchInventory]);

  // Open Create Modal
  const handleOpenCreate = () => {
    setEditingPaket(null);
    setFormData({
      nama_paket: "",
      deskripsi: "",
      gambarFile: null,
      gambarPreview: null,
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
        gambarFile: null,
        gambarPreview: detail.gambar ? `${BACKEND_URL}${detail.gambar}` : null,
        items: (detail.items || []).map((it) => ({
          asset_id: it.asset_id,
          aksesoris_id: it.aksesoris_id,
          nama: it.nama_item,
          kode: it.kode_item,
          tipe: it.tipe,
          stok: it.stok,
          jumlah: it.jumlah || 1,
          gambar: it.gambar_item,
        })),
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

  // Handle Form Submit (Create or Update)
  const handleSubmitForm = async (e) => {
    e.preventDefault();
    if (!formData.nama_paket.trim()) {
      showToast("Nama paket wajib diisi!", "error");
      return;
    }
    if (formData.items.length === 0) {
      showToast("Minimal pilih 1 barang untuk paket ini!", "error");
      return;
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
        await updatePaket(editingPaket.id, payload, formData.gambarFile);
        showToast("Template paket berhasil diperbarui!", "success");
      } else {
        await createPaket(payload, formData.gambarFile);
        showToast("Template paket baru berhasil dibuat!", "success");
      }

      setShowFormModal(false);
      fetchPakets();
    } catch (err) {
      console.error("Error submit paket:", err);
      showToast(err.response?.data?.message || "Gagal menyimpan template paket", "error");
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
      showToast("Template paket berhasil dihapus!", "success");
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
      showToast(res.message || "Seluruh template paket berhasil dihapus!", "success");
      setShowDeleteAllModal(false);
      setDeleteAllConfirmation("");
      fetchPakets();
    } catch (err) {
      showToast(err.response?.data?.message || "Gagal menghapus seluruh paket", "error");
    } finally {
      setDeleteAllLoading(false);
    }
  };

  // Add Item to Form's Package Items
  const handleAddItemToPaket = (item) => {
    const isAlreadyAdded = formData.items.some((it) => 
      (item.asset_id && it.asset_id === item.asset_id) || 
      (item.aksesoris_id && it.aksesoris_id === item.aksesoris_id)
    );

    if (isAlreadyAdded) {
      showToast(`${item.nama} sudah ada di dalam daftar paket`, "info");
      return;
    }

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
          stok: item.stok,
          jumlah: 1,
          gambar: item.gambar,
        },
      ],
    }));
    showToast(`${item.nama} ditambahkan ke paket`, "success");
  };

  // Remove Item from Form's Package Items
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
      const newQty = Math.max(1, (parseInt(updated[index].jumlah, 10) || 1) + delta);
      updated[index] = { ...updated[index], jumlah: newQty };
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

  const canManage = ["super admin", "admin"].includes(userRole);

  if (!mounted) return null;

  return (
    <div className="min-h-screen bg-slate-50/50 p-4 sm:p-6 lg:p-8 space-y-6">
      {/* Toast Notification */}
      {toast && (
        <div className="fixed top-5 right-5 z-60 animate-in fade-in slide-in-from-top-4 duration-300">
          <div
            className={`flex items-center gap-3 px-4 py-3 rounded-xl shadow-lg border text-sm font-medium ${
              toast.type === "success"
                ? "bg-emerald-50 border-emerald-200 text-emerald-800"
                : toast.type === "error"
                ? "bg-rose-50 border-rose-200 text-rose-800"
                : "bg-blue-50 border-blue-200 text-blue-800"
            }`}
          >
            {toast.type === "success" && <Check className="h-4 w-4 text-emerald-600 shrink-0" />}
            {toast.type === "error" && <AlertTriangle className="h-4 w-4 text-rose-600 shrink-0" />}
            {toast.type === "info" && <Info className="h-4 w-4 text-blue-600 shrink-0" />}
            <span>{toast.message}</span>
          </div>
        </div>
      )}

      {/* Header Page */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 bg-white p-5 sm:p-6 rounded-2xl border border-slate-200 shadow-sm">
        <div>
          <div className="flex items-center gap-2.5">
            <div className="p-2.5 rounded-xl bg-orange-50 text-orange-600 ring-1 ring-orange-500/10">
              <Boxes className="h-6 w-6" />
            </div>
            <div>
              <h1 className="text-xl sm:text-2xl font-bold text-slate-800">Template Paket Peminjaman</h1>
              <p className="text-xs sm:text-sm text-slate-500 mt-0.5">
                Kelola paket bundling aset & aksesoris untuk input peminjaman kilat
              </p>
            </div>
          </div>
        </div>

        {canManage && (
          <div className="flex items-center gap-2.5">
            {userRole === "super admin" && pakets.length > 0 && (
              <button
                onClick={() => {
                  setDeleteAllConfirmation("");
                  setShowDeleteAllModal(true);
                }}
                className="cursor-pointer inline-flex items-center gap-2 px-3.5 py-2.5 rounded-xl border border-rose-200 bg-rose-50/50 text-rose-600 text-xs sm:text-sm font-semibold hover:bg-rose-100 hover:border-rose-300 transition-all shadow-xs"
                title="Hapus seluruh template paket"
              >
                <Trash2 className="h-4 w-4" />
                <span className="hidden sm:inline">Hapus Seluruh Data</span>
              </button>
            )}

            <button
              onClick={handleOpenCreate}
              className="cursor-pointer inline-flex items-center gap-2 px-4 py-2.5 rounded-xl bg-primary text-white text-xs sm:text-sm font-semibold hover:bg-primary/90 transition-all shadow-md shadow-primary/20 active:scale-98"
            >
              <Plus className="h-4 w-4" />
              <span>Tambah Paket Baru</span>
            </button>
          </div>
        )}
      </div>

      {/* Search & Stats Bar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
        <div className="relative flex-1 max-w-md">
          <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400" />
          <input
            type="text"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Cari nama atau deskripsi paket..."
            className="w-full pl-10 pr-4 py-2 text-xs sm:text-sm bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all shadow-xs"
          />
          {search && (
            <button
              onClick={() => setSearch("")}
              className="cursor-pointer absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
            >
              <X className="h-3.5 w-3.5" />
            </button>
          )}
        </div>

        <div className="flex items-center gap-2">
          <div className="px-3 py-1.5 rounded-lg bg-white border border-slate-200 text-xs font-medium text-slate-600 shadow-xs">
            Total: <span className="font-bold text-slate-800">{pakets.length} Paket</span>
          </div>
        </div>
      </div>

      {/* Package Grid List */}
      {loading ? (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
          {[1, 2, 3, 4].map((n) => (
            <div key={n} className="bg-white rounded-2xl border border-slate-200 p-4 animate-pulse space-y-4">
              <div className="w-full h-40 bg-slate-100 rounded-xl" />
              <div className="h-5 bg-slate-100 rounded w-3/4" />
              <div className="h-4 bg-slate-100 rounded w-1/2" />
              <div className="h-10 bg-slate-100 rounded-xl" />
            </div>
          ))}
        </div>
      ) : filteredPakets.length === 0 ? (
        <div className="bg-white rounded-2xl border border-slate-200 p-12 text-center shadow-xs">
          <div className="inline-flex p-4 rounded-full bg-slate-100 text-slate-400 mb-3">
            <Boxes className="h-8 w-8" />
          </div>
          <h3 className="text-base font-bold text-slate-800">
            {search ? "Paket tidak ditemukan" : "Belum Ada Template Paket"}
          </h3>
          <p className="text-xs sm:text-sm text-slate-500 max-w-sm mx-auto mt-1 mb-5">
            {search 
              ? `Tidak ada paket yang cocok dengan kata kunci "${search}"`
              : "Buat template paket bundling pertama Anda agar mempermudah peminjaman alat di masa depan."}
          </p>
          {canManage && !search && (
            <button
              onClick={handleOpenCreate}
              className="cursor-pointer inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-primary text-white text-xs sm:text-sm font-semibold hover:bg-primary/90 transition-all"
            >
              <Plus className="h-4 w-4" />
              <span>Buat Paket Sekarang</span>
            </button>
          )}
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
          {filteredPakets.map((paket) => (
            <div
              key={paket.id}
              className="group bg-white rounded-2xl border border-slate-200 hover:border-primary/40 hover:shadow-md transition-all duration-300 flex flex-col overflow-hidden shadow-xs"
            >
              {/* Image Preview / Banner */}
              <div className="relative w-full h-44 bg-slate-100 overflow-hidden border-b border-slate-100">
                {paket.gambar ? (
                  <Image
                    src={`${BACKEND_URL}${paket.gambar}`}
                    alt={paket.nama_paket}
                    fill
                    className="object-cover group-hover:scale-105 transition-transform duration-500"
                    unoptimized
                  />
                ) : (
                  <div className="w-full h-full flex flex-col items-center justify-center bg-gradient-to-br from-slate-50 to-orange-50/40 text-slate-300 group-hover:text-primary/60 transition-colors">
                    <Boxes className="h-12 w-12 stroke-[1.2]" />
                    <span className="text-[11px] font-medium text-slate-400 mt-1">Tanpa Foto</span>
                  </div>
                )}

                {/* Badge Total Items */}
                <div className="absolute top-3 left-3 bg-slate-900/80 backdrop-blur-md text-white text-[11px] font-semibold px-2.5 py-1 rounded-lg flex items-center gap-1.5 shadow-sm">
                  <Layers className="h-3 w-3 text-orange-400" />
                  <span>{paket.total_items || 0} Macam Barang ({paket.total_qty || 0} Unit)</span>
                </div>
              </div>

              {/* Content */}
              <div className="p-4 flex-1 flex flex-col justify-between">
                <div>
                  <h3 className="font-bold text-slate-800 text-base leading-snug line-clamp-1 group-hover:text-primary transition-colors">
                    {paket.nama_paket}
                  </h3>
                  <p className="text-xs text-slate-500 line-clamp-2 mt-1 min-h-[32px]">
                    {paket.deskripsi || "Tidak ada deskripsi tambahan untuk paket ini."}
                  </p>
                </div>

                {/* Footer Actions */}
                <div className="pt-4 mt-3 border-t border-slate-100 flex items-center gap-2">
                  <button
                    onClick={() => handleOpenDetail(paket)}
                    className="cursor-pointer flex-1 inline-flex items-center justify-center gap-1.5 py-2 px-3 rounded-xl border border-slate-200 bg-slate-50/70 text-slate-700 text-xs font-semibold hover:bg-slate-100 transition-colors"
                  >
                    <Eye className="h-3.5 w-3.5" />
                    <span>Lihat Isi</span>
                  </button>

                  {canManage && (
                    <>
                      <button
                        onClick={() => handleOpenEdit(paket)}
                        className="cursor-pointer p-2 rounded-xl border border-slate-200 text-slate-600 hover:text-primary hover:border-primary/30 hover:bg-orange-50/50 transition-colors"
                        title="Edit Paket"
                      >
                        <Pencil className="h-3.5 w-3.5" />
                      </button>
                      <button
                        onClick={() => setShowDeleteModal(paket)}
                        className="cursor-pointer p-2 rounded-xl border border-rose-200 text-rose-600 hover:bg-rose-50 transition-colors"
                        title="Hapus Paket"
                      >
                        <Trash2 className="h-3.5 w-3.5" />
                      </button>
                    </>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* ========================================================================= */}
      {/* MODAL TAMBAH / EDIT PAKET */}
      {/* ========================================================================= */}
      {showFormModal && (
        <div className="fixed inset-0 z-60 flex items-center justify-center p-4 bg-slate-900/50 backdrop-blur-xs animate-in fade-in duration-200">
          <div className="bg-white rounded-2xl w-full max-w-2xl max-h-[90vh] flex flex-col shadow-2xl border border-slate-200 overflow-hidden">
            {/* Modal Header */}
            <div className="flex items-center justify-between px-6 py-4 border-b border-slate-200 bg-slate-50/50">
              <div className="flex items-center gap-2.5">
                <div className="p-2 rounded-xl bg-orange-100 text-orange-600">
                  <Boxes className="h-5 w-5" />
                </div>
                <div>
                  <h2 className="text-base sm:text-lg font-bold text-slate-800">
                    {editingPaket ? "Edit Template Paket" : "Buat Template Paket Baru"}
                  </h2>
                  <p className="text-xs text-slate-500">
                    Tentukan daftar barang dan jumlah default untuk paket peminjaman ini
                  </p>
                </div>
              </div>
              <button
                onClick={() => setShowFormModal(false)}
                className="cursor-pointer p-1.5 rounded-lg text-slate-400 hover:text-slate-600 hover:bg-slate-100 transition-colors"
              >
                <X className="h-5 w-5" />
              </button>
            </div>

            {/* Modal Body Form */}
            <form onSubmit={handleSubmitForm} className="flex-1 overflow-y-auto p-6 space-y-5 custom-scrollbar">
              {/* Nama Paket */}
              <div>
                <label className="block text-xs font-bold uppercase tracking-wider text-slate-600 mb-1.5">
                  Nama Template Paket <span className="text-rose-500">*</span>
                </label>
                <input
                  type="text"
                  required
                  value={formData.nama_paket}
                  onChange={(e) => setFormData({ ...formData, nama_paket: e.target.value })}
                  placeholder="Contoh: Paket Videotron 4x9 P3.9 Outdoor"
                  className="w-full px-3.5 py-2.5 text-sm bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all"
                />
              </div>

              {/* Deskripsi */}
              <div>
                <label className="block text-xs font-bold uppercase tracking-wider text-slate-600 mb-1.5">
                  Deskripsi / Catatan Paket (Opsional)
                </label>
                <textarea
                  rows={2}
                  value={formData.deskripsi}
                  onChange={(e) => setFormData({ ...formData, deskripsi: e.target.value })}
                  placeholder="Keterangan singkat mengenai peruntukan atau kelengkapan paket..."
                  className="w-full px-3.5 py-2 text-sm bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all resize-none"
                />
              </div>

              {/* Foto Paket */}
              <div>
                <label className="block text-xs font-bold uppercase tracking-wider text-slate-600 mb-1.5">
                  Foto Representasi Paket (Opsional)
                </label>
                <div className="flex items-center gap-4">
                  <div className="relative w-24 h-24 rounded-xl border-2 border-dashed border-slate-300 bg-slate-50 overflow-hidden flex items-center justify-center shrink-0">
                    {formData.gambarPreview ? (
                      <Image
                        src={formData.gambarPreview}
                        alt="Preview"
                        fill
                        className="object-cover"
                        unoptimized
                      />
                    ) : (
                      <ImageIcon className="h-8 w-8 text-slate-300" />
                    )}
                  </div>
                  <div className="flex-1 space-y-1.5">
                    <input
                      type="file"
                      accept="image/*"
                      id="paket-image-input"
                      className="hidden"
                      onChange={(e) => {
                        const file = e.target.files?.[0];
                        if (file) {
                          setFormData({
                            ...formData,
                            gambarFile: file,
                            gambarPreview: URL.createObjectURL(file),
                          });
                        }
                      }}
                    />
                    <label
                      htmlFor="paket-image-input"
                      className="cursor-pointer inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg border border-slate-300 bg-white text-xs font-medium text-slate-700 hover:bg-slate-50 transition-colors shadow-xs"
                    >
                      <ImageIcon className="h-3.5 w-3.5" />
                      <span>{formData.gambarPreview ? "Ganti Foto" : "Pilih Foto"}</span>
                    </label>
                    <p className="text-[11px] text-slate-400">JPG, PNG, HEIC atau WebP (Maks. 5MB)</p>
                  </div>
                </div>
              </div>

              {/* Section Daftar Barang dalam Paket */}
              <div className="pt-3 border-t border-slate-200">
                <div className="flex items-center justify-between mb-3">
                  <div>
                    <h3 className="text-sm font-bold text-slate-800">Daftar Barang dalam Paket</h3>
                    <p className="text-xs text-slate-500">Pilih alat dan tentukan kuantitas yang dibutuhkan</p>
                  </div>
                  <button
                    type="button"
                    onClick={() => setShowItemPicker(true)}
                    className="cursor-pointer inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-orange-50 border border-orange-200 text-orange-700 text-xs font-semibold hover:bg-orange-100 transition-colors"
                  >
                    <Plus className="h-3.5 w-3.5" />
                    <span>Tambah Barang</span>
                  </button>
                </div>

                {formData.items.length === 0 ? (
                  <div className="p-6 rounded-xl border border-dashed border-slate-200 bg-slate-50 text-center">
                    <Package className="h-7 w-7 text-slate-300 mx-auto mb-1.5" />
                    <p className="text-xs font-medium text-slate-600">Belum ada barang di dalam paket ini</p>
                    <p className="text-[11px] text-slate-400 mt-0.5">
                      Klik tombol &quot;Tambah Barang&quot; di atas untuk memilih aset atau aksesoris
                    </p>
                  </div>
                ) : (
                  <div className="space-y-2 border border-slate-200 rounded-xl p-2 bg-slate-50/50 max-h-60 overflow-y-auto custom-scrollbar">
                    {formData.items.map((it, idx) => (
                      <div
                        key={idx}
                        className="flex items-center justify-between gap-3 p-2.5 bg-white rounded-lg border border-slate-200 shadow-2xs"
                      >
                        <div className="flex items-center gap-2.5 min-w-0 flex-1">
                          <div className="w-9 h-9 rounded-lg bg-slate-100 relative overflow-hidden shrink-0 flex items-center justify-center">
                            {it.gambar ? (
                              <Image
                                src={`${BACKEND_URL}${it.gambar}`}
                                alt={it.nama}
                                fill
                                className="object-cover"
                                unoptimized
                              />
                            ) : (
                              <Package className="h-4 w-4 text-slate-400" />
                            )}
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
                              Kode: {it.kode || "-"} • Stok: <span className="font-semibold text-slate-600">{it.stok}</span>
                            </p>
                          </div>
                        </div>

                        {/* Stepper Jumlah */}
                        <div className="flex items-center gap-2">
                          <div className="flex items-center border border-slate-200 rounded-lg overflow-hidden bg-slate-50">
                            <button
                              type="button"
                              onClick={() => handleChangeItemQty(idx, -1)}
                              className="cursor-pointer px-2 py-1 text-slate-600 hover:bg-slate-200 text-xs font-bold transition-colors"
                            >
                              -
                            </button>
                            <span className="px-2.5 py-1 text-xs font-bold text-slate-800 bg-white min-w-[28px] text-center">
                              {it.jumlah}
                            </span>
                            <button
                              type="button"
                              onClick={() => handleChangeItemQty(idx, 1)}
                              className="cursor-pointer px-2 py-1 text-slate-600 hover:bg-slate-200 text-xs font-bold transition-colors"
                            >
                              +
                            </button>
                          </div>

                          <button
                            type="button"
                            onClick={() => handleRemoveItemFromPaket(idx)}
                            className="cursor-pointer p-1.5 rounded-lg text-rose-500 hover:bg-rose-50 transition-colors"
                            title="Hapus dari paket"
                          >
                            <Trash2 className="h-4 w-4" />
                          </button>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>

              {/* Modal Footer */}
              <div className="pt-4 border-t border-slate-200 flex items-center justify-end gap-2.5">
                <button
                  type="button"
                  onClick={() => setShowFormModal(false)}
                  className="cursor-pointer px-4 py-2 text-xs sm:text-sm font-semibold text-slate-600 border border-slate-200 rounded-xl hover:bg-slate-50 transition-colors"
                >
                  Batal
                </button>
                <button
                  type="submit"
                  disabled={submitting}
                  className="cursor-pointer px-5 py-2 text-xs sm:text-sm font-semibold text-white bg-primary rounded-xl hover:bg-primary/90 transition-all shadow-md shadow-primary/20 disabled:opacity-60"
                >
                  {submitting ? "Menyimpan..." : editingPaket ? "Simpan Perubahan" : "Buat Paket"}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* ========================================================================= */}
      {/* ITEM PICKER SUB-MODAL */}
      {/* ========================================================================= */}
      {showItemPicker && (
        <div className="fixed inset-0 z-70 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-xs animate-in fade-in duration-200">
          <div className="bg-white rounded-2xl w-full max-w-lg max-h-[85vh] flex flex-col shadow-2xl border border-slate-200 overflow-hidden">
            <div className="flex items-center justify-between px-5 py-3.5 border-b border-slate-200 bg-slate-50/70">
              <h3 className="text-sm font-bold text-slate-800">Pilih Barang untuk Ditambahkan</h3>
              <button
                onClick={() => setShowItemPicker(false)}
                className="cursor-pointer p-1 rounded-lg text-slate-400 hover:text-slate-600 hover:bg-slate-100"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            {/* Filter & Search */}
            <div className="p-3.5 border-b border-slate-100 space-y-2.5">
              <div className="relative">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-slate-400" />
                <input
                  type="text"
                  value={pickerSearch}
                  onChange={(e) => setPickerSearch(e.target.value)}
                  placeholder="Cari nama, kode, kategori, atau merek..."
                  className="w-full pl-9 pr-3 py-1.5 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:outline-none focus:ring-1 focus:ring-primary"
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
                    <option value="semua">Semua Brand</option>
                    <option value="Galeria Production">Galeria Production</option>
                    <option value="Galeria Studio">Galeria Studio</option>
                  </select>
                </div>
              </div>
            </div>

            {/* List Items */}
            <div className="flex-1 overflow-y-auto p-3.5 space-y-2 custom-scrollbar">
              {filteredPickerItems.length === 0 ? (
                <div className="p-8 text-center text-slate-400 text-xs space-y-1">
                  <Package className="h-7 w-7 text-slate-300 mx-auto mb-1" />
                  <p className="font-semibold text-slate-600">Tidak ada barang yang cocok</p>
                  <p className="text-[11px] text-slate-400">
                    Coba ubah kata kunci atau ubah filter Tipe dan Brand di atas.
                  </p>
                </div>
              ) : (
                filteredPickerItems.map((item) => {
                  const isAdded = formData.items.some(
                    (it) =>
                      (item.asset_id && it.asset_id === item.asset_id) ||
                      (item.aksesoris_id && it.aksesoris_id === item.aksesoris_id)
                  );

                  return (
                    <div
                      key={`${item.tipe}-${item.id}`}
                      className="flex items-center justify-between p-2.5 rounded-xl border border-slate-200 hover:border-slate-300 bg-white transition-colors gap-2"
                    >
                      <div className="flex items-center gap-2.5 min-w-0 flex-1">
                        <div className="w-10 h-10 rounded-lg bg-slate-100 relative overflow-hidden shrink-0 flex items-center justify-center border border-slate-100">
                          {item.gambar ? (
                            <Image
                              src={`${BACKEND_URL}${item.gambar}`}
                              alt={item.nama}
                              fill
                              className="object-cover"
                              unoptimized
                            />
                          ) : (
                            <Package className="h-5 w-5 text-slate-400" />
                          )}
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
                            {item.kategori || "-"} • Stok: <span className="font-semibold text-slate-600">{item.stok}</span>
                            {item.merek && ` • ${item.merek}`}
                          </p>
                        </div>
                      </div>

                      <button
                        type="button"
                        disabled={isAdded}
                        onClick={() => handleAddItemToPaket(item)}
                        className={`cursor-pointer px-3 py-1.5 text-xs font-semibold rounded-lg transition-colors shrink-0 ${
                          isAdded
                            ? "bg-slate-100 text-slate-400 cursor-not-allowed"
                            : "bg-primary text-white hover:bg-primary/90 shadow-2xs"
                        }`}
                      >
                        {isAdded ? "Sudah Ada" : "+ Tambah"}
                      </button>
                    </div>
                  );
                })
              )}
            </div>

            <div className="p-3 border-t border-slate-200 bg-slate-50 flex justify-end">
              <button
                type="button"
                onClick={() => setShowItemPicker(false)}
                className="cursor-pointer px-4 py-1.5 text-xs font-semibold text-slate-700 bg-white border border-slate-200 rounded-lg hover:bg-slate-100"
              >
                Selesai
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ========================================================================= */}
      {/* MODAL DETAIL / PREVIEW PAKET */}
      {/* ========================================================================= */}
      {showDetailModal && (
        <div className="fixed inset-0 z-60 flex items-center justify-center p-4 bg-slate-900/50 backdrop-blur-xs animate-in fade-in duration-200">
          <div className="bg-white rounded-2xl w-full max-w-xl max-h-[85vh] flex flex-col shadow-2xl border border-slate-200 overflow-hidden">
            <div className="flex items-center justify-between px-6 py-4 border-b border-slate-200 bg-slate-50/50">
              <div className="flex items-center gap-2.5">
                <div className="p-2 rounded-xl bg-orange-100 text-orange-600">
                  <Boxes className="h-5 w-5" />
                </div>
                <div>
                  <h3 className="text-base font-bold text-slate-800">{showDetailModal.nama_paket}</h3>
                  <p className="text-xs text-slate-500">Detail isi template paket peminjaman</p>
                </div>
              </div>
              <button
                onClick={() => setShowDetailModal(null)}
                className="cursor-pointer p-1.5 rounded-lg text-slate-400 hover:text-slate-600 hover:bg-slate-100"
              >
                <X className="h-5 w-5" />
              </button>
            </div>

            <div className="flex-1 overflow-y-auto p-6 space-y-4 custom-scrollbar">
              {showDetailModal.gambar && (
                <div className="relative w-full h-44 rounded-xl overflow-hidden border border-slate-200">
                  <Image
                    src={`${BACKEND_URL}${showDetailModal.gambar}`}
                    alt={showDetailModal.nama_paket}
                    fill
                    className="object-cover"
                    unoptimized
                  />
                </div>
              )}

              {showDetailModal.deskripsi && (
                <div className="p-3 bg-slate-50 rounded-xl border border-slate-200 text-xs text-slate-600 leading-relaxed">
                  {showDetailModal.deskripsi}
                </div>
              )}

              <div>
                <h4 className="text-xs font-bold uppercase tracking-wider text-slate-500 mb-2">
                  Daftar Isi Paket ({showDetailModal.items?.length || 0} Barang):
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
                          <div className="w-10 h-10 rounded-lg bg-slate-100 relative overflow-hidden shrink-0 flex items-center justify-center">
                            {it.gambar_item ? (
                              <Image
                                src={`${BACKEND_URL}${it.gambar_item}`}
                                alt={it.nama_item}
                                fill
                                className="object-cover"
                                unoptimized
                              />
                            ) : (
                              <Package className="h-5 w-5 text-slate-400" />
                            )}
                          </div>
                          <div>
                            <p className="text-xs sm:text-sm font-bold text-slate-800">{it.nama_item}</p>
                            <p className="text-[11px] text-slate-400">
                              Kode: {it.kode_item || "-"} • Kategori: {it.kategori || "-"}
                            </p>
                            {it.units?.length > 0 && (
                              <p className="text-[10px] text-emerald-600 font-medium">
                                Siap Digunakan: {readyUnitsCount} dari {it.units.length} unit
                              </p>
                            )}
                          </div>
                        </div>

                        <div className="text-right">
                          <span className="inline-flex items-center px-2.5 py-1 rounded-lg bg-orange-50 border border-orange-200 text-orange-700 text-xs font-bold">
                            {it.jumlah} Unit
                          </span>
                        </div>
                      </div>
                    );
                  })}
                </div>
              </div>
            </div>

            <div className="p-4 border-t border-slate-200 bg-slate-50 flex justify-end">
              <button
                onClick={() => setShowDetailModal(null)}
                className="cursor-pointer px-4 py-2 text-xs sm:text-sm font-semibold text-slate-700 bg-white border border-slate-200 rounded-xl hover:bg-slate-100 transition-colors"
              >
                Tutup
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ========================================================================= */}
      {/* MODAL DELETE CONFIRM TUNGGAL */}
      {/* ========================================================================= */}
      {showDeleteModal && (
        <div className="fixed inset-0 z-60 flex items-center justify-center p-4 bg-slate-900/50 backdrop-blur-xs animate-in fade-in duration-200">
          <div className="bg-white rounded-2xl w-full max-w-sm p-6 shadow-2xl border border-slate-200 text-center space-y-4">
            <div className="w-12 h-12 rounded-full bg-rose-100 text-rose-600 flex items-center justify-center mx-auto">
              <Trash2 className="h-6 w-6" />
            </div>
            <div>
              <h3 className="text-base font-bold text-slate-800">Hapus Template Paket?</h3>
              <p className="text-xs text-slate-500 mt-1">
                Apakah Anda yakin ingin menghapus paket <b>&quot;{showDeleteModal.nama_paket}&quot;</b>? Tindakan ini tidak dapat dibatalkan.
              </p>
            </div>
            <div className="flex items-center gap-2 pt-2">
              <button
                onClick={() => setShowDeleteModal(null)}
                className="cursor-pointer flex-1 py-2 text-xs sm:text-sm font-semibold text-slate-600 border border-slate-200 rounded-xl hover:bg-slate-50"
              >
                Batal
              </button>
              <button
                onClick={handleDeleteConfirm}
                disabled={submitting}
                className="cursor-pointer flex-1 py-2 text-xs sm:text-sm font-semibold text-white bg-rose-600 rounded-xl hover:bg-rose-700 disabled:opacity-60"
              >
                {submitting ? "Menghapus..." : "Ya, Hapus"}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ========================================================================= */}
      {/* MODAL HAPUS SELURUH DATA (SUPER ADMIN) */}
      {/* ========================================================================= */}
      {showDeleteAllModal && (
        <div className="fixed inset-0 z-60 flex items-center justify-center p-4 bg-slate-900/50 backdrop-blur-xs animate-in fade-in duration-200">
          <div className="bg-white rounded-2xl w-full max-w-md p-6 shadow-2xl border border-slate-200 space-y-4">
            <div className="flex items-center gap-3">
              <div className="p-3 rounded-xl bg-rose-100 text-rose-600 shrink-0">
                <AlertTriangle className="h-6 w-6" />
              </div>
              <div>
                <h3 className="text-base font-bold text-slate-800">Hapus Seluruh Template Paket</h3>
                <p className="text-xs text-slate-500">Tindakan berbahaya khusus Super Admin</p>
              </div>
            </div>

            <p className="text-xs text-slate-600 leading-relaxed bg-rose-50 p-3 rounded-xl border border-rose-200 text-rose-800">
              Semua template paket peminjaman akan dihapus permanen, dan ID tabel otomatis akan diatur kembali ke <b>1</b>.
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

            <div className="flex items-center gap-2 pt-2">
              <button
                onClick={() => setShowDeleteAllModal(false)}
                className="cursor-pointer flex-1 py-2 text-xs sm:text-sm font-semibold text-slate-600 border border-slate-200 rounded-xl hover:bg-slate-50"
              >
                Batal
              </button>
              <button
                onClick={handleDeleteAllConfirm}
                disabled={deleteAllLoading || deleteAllConfirmation.trim() !== "HAPUS SEMUA"}
                className="cursor-pointer flex-1 py-2 text-xs sm:text-sm font-semibold text-white bg-rose-600 rounded-xl hover:bg-rose-700 disabled:opacity-50 transition-all"
              >
                {deleteAllLoading ? "Menghapus..." : "Konfirmasi Hapus"}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
