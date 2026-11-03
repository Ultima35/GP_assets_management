"use client";

import { useState, useEffect, useCallback, useRef } from "react";
import { createPortal } from "react-dom";
import Image from "next/image";
import { useRouter, useParams } from "next/navigation";
import {
  getPeminjamanById,
  getItemsWithPricing,
  updatePengajuan,
} from "../../../../lib/peminjamanService";
import { getAllAssets } from "../../../../lib/assetService";
import { getAllAksesoris } from "../../../../lib/aksesorisService";
import { getAllPaket, getPaketById } from "../../../../lib/paketService";
import { getActivePegawai } from "../../../../lib/pegawaiService";
import { getUserContext } from "../../../../lib/authService";
import { toCapitalEachWord, toSentenceCase } from "../../../../lib/stringUtils";
import {
  ChevronLeft,
  FileText,
  Package,
  Plus,
  X,
  Check,
  AlertTriangle,
  Camera,
  Trash2,
  Grid,
  List,
  Search,
  Layers,
  Minus,
  Info,
  Upload,
  Boxes,
  Sparkles,
} from "lucide-react";

const getBackendURL = () => {
  if (process.env.NEXT_PUBLIC_API_URL) {
    return process.env.NEXT_PUBLIC_API_URL.replace(/\/api$/, "");
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

const parseBuktiImages = (data) => {
  if (!data) return [];
  if (Array.isArray(data)) return data;
  if (typeof data === "string") {
    try {
      return JSON.parse(data);
    } catch {
      return [];
    }
  }
  return [];
};

function ItemThumbnail({
  src,
  alt,
  width = 150,
  height = 150,
  className = "w-full h-full object-cover",
  iconSize = "w-8 h-8",
}) {
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

export default function EditPengajuanPage() {
  const router = useRouter();
  const params = useParams();
  const peminjamanId = params.id;

  // User & Auth State
  const [userRole, setUserRole] = useState("");
  const [userId, setUserId] = useState(null);
  const [userName, setUserName] = useState("");

  // Existing Data State
  const [existingData, setExistingData] = useState(null);
  const [isLoaded, setIsLoaded] = useState(false);

  // Form Data State
  const [kodePinjam, setKodePinjam] = useState("");
  const [namaPeminjam, setNamaPeminjam] = useState("");
  const [tanggalPeminjaman, setTanggalPeminjaman] = useState("");
  const [keperluanList, setKeperluanList] = useState([{ keperluan: "" }]);
  const [items, setItems] = useState([]);
  const [existingBukti, setExistingBukti] = useState([]);
  const [newBuktiFiles, setNewBuktiFiles] = useState([]);
  const [newBuktiPreviews, setNewBuktiPreviews] = useState([]);

  // Catalog State
  const [pegawaiList, setPegawaiList] = useState([]);
  const [allItems, setAllItems] = useState([]);

  // UI State
  const [submitting, setSubmitting] = useState(false);
  const [toast, setToast] = useState(null);
  const [viewMode, setViewMode] = useState("list");
  const [itemSearch, setItemSearch] = useState("");
  const [itemFilter, setItemFilter] = useState("semua"); // "semua" | "asset" | "aksesoris"
  const [brandFilter, setBrandFilter] = useState("semua"); // "semua" | "Galeria Studio" | "Galeria Production"
  const [detailModalItem, setDetailModalItem] = useState(null);
  const [modalSelectedUnitIds, setModalSelectedUnitIds] = useState([]);
  const [modalJumlah, setModalJumlah] = useState(1);
  const [isDragging, setIsDragging] = useState(false);
  const fileInputRef = useRef(null);
  const cameraInputRef = useRef(null);

  // Template Paket State
  const [showPaketModal, setShowPaketModal] = useState(false);
  const [paketList, setPaketList] = useState([]);
  const [loadingPaket, setLoadingPaket] = useState(false);
  const [applyingPaketId, setApplyingPaketId] = useState(null);
  const [paketSearch, setPaketSearch] = useState("");
  const [paketWarnings, setPaketWarnings] = useState([]);

  const showToast = (message, type = "success") => setToast({ message, type });

  // Initialize user
  useEffect(() => {
    const ctx = getUserContext();
    if (ctx) {
      setUserRole(ctx.role || "");
      setUserId(ctx.id);
      setUserName(ctx.namaLengkap || "");
    }
  }, []);

  // Toast timer
  useEffect(() => {
    if (toast) {
      const timer = setTimeout(() => setToast(null), 4000);
      return () => clearTimeout(timer);
    }
  }, [toast]);

  // Load Data
  const loadData = useCallback(async () => {
    try {
      setIsLoaded(false);
      const [peminjaman, rawItems, assets, aksesoris, pegawai] = await Promise.all([
        getPeminjamanById(peminjamanId),
        getItemsWithPricing(peminjamanId),
        getAllAssets(),
        getAllAksesoris(),
        getActivePegawai(),
      ]);

      if (!peminjaman) {
        showToast("Data peminjaman tidak ditemukan", "error");
        router.push("/aset/peminjaman");
        return;
      }

      if (peminjaman.status !== "Menunggu Persetujuan" && peminjaman.status !== "Ditolak") {
        showToast(
          `Pengajuan tidak dapat diedit karena statusnya "${peminjaman.status}". Hanya status "Menunggu Persetujuan" atau "Ditolak" yang dapat diedit.`,
          "error"
        );
        router.push("/aset/peminjaman");
        return;
      }

      setExistingData(peminjaman);
      setKodePinjam(peminjaman.kodePinjam);
      setNamaPeminjam(peminjaman.namaPeminjam || "");

      if (peminjaman.tanggalPeminjaman) {
        const d = new Date(peminjaman.tanggalPeminjaman);
        const yyyy = d.getFullYear();
        const mm = String(d.getMonth() + 1).padStart(2, "0");
        const dd = String(d.getDate()).padStart(2, "0");
        setTanggalPeminjaman(`${yyyy}-${mm}-${dd}`);
      }

      if (peminjaman.keperluanList && peminjaman.keperluanList.length > 0) {
        setKeperluanList(
          peminjaman.keperluanList.map((k) =>
            typeof k === "string" ? { keperluan: k } : k
          )
        );
      } else if (peminjaman.alasanPeminjaman) {
        setKeperluanList([{ keperluan: peminjaman.alasanPeminjaman }]);
      } else {
        setKeperluanList([{ keperluan: "" }]);
      }

      setExistingBukti(parseBuktiImages(peminjaman.buktiPeminjaman));
      setPegawaiList(pegawai || []);

      // Build catalog list
      const combined = [
        ...(assets || [])
          .filter((a) => a.kondisi !== "Dijual")
          .map((a) => {
            const tipeHarga = a.tipeHarga || "Per Unit";
            const jumlahTotal = Number(a.jumlahTotal || a.jumlah || 1);
            const hargaUnit =
              tipeHarga === "Per Paket" && jumlahTotal > 0
                ? Math.round((Number(a.hargaAset) || 0) / jumlahTotal)
                : Number(a.hargaAset) || 0;

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
        ...(aksesoris || [])
          .filter((ak) => ak.kondisi !== "Dijual")
          .map((ak) => {
            const tipeHarga = ak.tipeHarga || "Per Unit";
            const jumlahTotal = Number(ak.jumlahTotal || ak.jumlahUnit || 1);
            const hargaUnit =
              tipeHarga === "Per Paket" && jumlahTotal > 0
                ? Math.round((Number(ak.hargaAset) || 0) / jumlahTotal)
                : Number(ak.hargaAset) || 0;

            return {
              id: ak.id,
              nama: ak.namaAset || ak.namaAksesoris,
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

      // Reconstruct selected items
      const groupedMap = new Map();
      (rawItems || []).forEach((it) => {
        const isAsset = !!it.asset_id;
        const itemId = isAsset ? it.asset_id : it.aksesoris_id;
        const groupKey = `${isAsset ? "asset" : "aksesoris"}_${itemId}`;

        if (!groupedMap.has(groupKey)) {
          const catalogItem = combined.find(
            (c) => c.tipe === (isAsset ? "asset" : "aksesoris") && c.id === itemId
          );

          groupedMap.set(groupKey, {
            id: itemId,
            nama: it.nama_aset,
            kode: it.kode_aset,
            tipe: isAsset ? "asset" : "aksesoris",
            gambar: catalogItem?.gambar || null,
            harga: it.harga_aset || catalogItem?.harga || 0,
            tipeHarga: it.tipe_harga || catalogItem?.tipeHarga || "Per Unit",
            hargaAsetOriginal: it.harga_aset_original || catalogItem?.hargaAsetOriginal || 0,
            jumlahTotal: it.jumlah_total || catalogItem?.jumlahTotal || 1,
            stok: catalogItem?.stok ?? (it.stok_tersedia || 0),
            jumlah: 0,
            kategori: it.kategori || catalogItem?.kategori,
            merek: it.merek || catalogItem?.merek,
            jenisAset: catalogItem?.jenisAset || "Aset Utama",
            kondisi: catalogItem?.kondisi || "Siap Digunakan",
            hasUnits: (catalogItem?.units || []).length > 0 || !!it.unit_id || !!it.aksesoris_unit_id,
            units: catalogItem?.units || [],
            unitIds: [],
          });
        }

        const currentGroup = groupedMap.get(groupKey);
        currentGroup.jumlah += Number(it.jumlah) || 1;

        const uId = it.unit_id || it.aksesoris_unit_id;
        if (uId) {
          currentGroup.unitIds.push(uId);
        }
      });

      setItems(Array.from(groupedMap.values()));
    } catch (err) {
      console.error("Error loading peminjaman data for edit:", err);
      showToast("Gagal memuat data pengajuan", "error");
    } finally {
      setIsLoaded(true);
    }
  }, [peminjamanId, router]);

  useEffect(() => {
    loadData();
  }, [loadData]);

  // Keperluan list handlers
  const addKeperluan = () => {
    setKeperluanList([...keperluanList, { keperluan: "" }]);
  };

  const removeKeperluan = (index) => {
    if (keperluanList.length === 1) return;
    setKeperluanList(keperluanList.filter((_, i) => i !== index));
  };

  const updateKeperluan = (index, field, value) => {
    const updated = [...keperluanList];
    updated[index][field] = value;
    setKeperluanList(updated);
  };

  // File handling
  const processFiles = (files) => {
    if (!files || files.length === 0) return;
    const validTypes = ["image/jpeg", "image/jpg", "image/png", "image/heic", "image/heif", "image/webp"];
    const validExts = [".jpg", ".jpeg", ".png", ".heic", ".heif", ".webp"];
    let filesToAdd = [];

    for (let file of files) {
      const ext = "." + (file.name.split(".").pop() || "").toLowerCase();
      if (!validTypes.includes(file.type) && !validExts.includes(ext)) {
        showToast("Format file harus JPG, JPEG, PNG, HEIC, atau WebP", "error");
        return;
      }
      filesToAdd.push(file);
    }

    const totalCount = existingBukti.length + newBuktiFiles.length + filesToAdd.length;
    if (totalCount > 5) {
      showToast("Maksimal 5 gambar bukti", "error");
      return;
    }

    const updated = [...newBuktiFiles, ...filesToAdd];
    setNewBuktiFiles(updated);
    setNewBuktiPreviews(updated.map((f) => URL.createObjectURL(f)));
  };

  const handleFileChange = (e) => {
    const files = Array.from(e.target.files || []);
    processFiles(files);
    e.target.value = "";
  };

  const handleDrop = (e) => {
    e.preventDefault();
    e.stopPropagation();
    setIsDragging(false);
    if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
      processFiles(Array.from(e.dataTransfer.files));
    }
  };

  const removeExistingBukti = (index) => {
    setExistingBukti(existingBukti.filter((_, i) => i !== index));
  };

  const removeNewBukti = (index) => {
    const updated = newBuktiFiles.filter((_, i) => i !== index);
    setNewBuktiFiles(updated);
    setNewBuktiPreviews(updated.map((f) => URL.createObjectURL(f)));
  };

  // Helper unit stats
  const getItemUnitStats = (item) => {
    const units = item.units || [];
    const total = units.length;
    const ready = units.filter((u) => u.status_pinjam === "Tersedia" && u.kondisi === "Siap Digunakan").length;
    const dipinjam = units.filter((u) => u.status_pinjam === "Dipinjam" || u.kondisi === "Sedang Dipinjam").length;
    const maintenance = units.filter((u) => u.kondisi === "Maintenance").length;
    const rusak = units.filter((u) => u.kondisi === "Rusak").length;
    const rusakBerat = units.filter((u) => u.kondisi === "Rusak Berat").length;
    const hasUnits = total > 0;
    const isAvailable = hasUnits ? ready > 0 : item.stok > 0;

    return { total, ready, dipinjam, maintenance, rusak, rusakBerat, hasUnits, isAvailable };
  };

  // Modal detail item
  const openDetailModal = (item) => {
    setDetailModalItem(item);
    const existing = items.find((it) => it.id === item.id && it.tipe === item.tipe);
    if (item.units && item.units.length > 0) {
      if (existing && existing.unitIds?.length > 0) {
        setModalSelectedUnitIds(existing.unitIds);
      } else {
        const available = item.units
          .filter((u) => u.status_pinjam === "Tersedia" && u.kondisi === "Siap Digunakan")
          .map((u) => u.id);
        setModalSelectedUnitIds(available.length > 0 ? [available[0]] : []);
      }
    } else {
      setModalJumlah(existing ? existing.jumlah : 1);
    }
  };

  const handleItemClick = (item) => {
    const stats = getItemUnitStats(item);
    const isSelected = items.some((it) => it.id === item.id && it.tipe === item.tipe);

    if (isSelected) {
      openDetailModal(item);
      return;
    }

    if (!stats.isAvailable) {
      showToast(`Item "${item.nama}" sedang tidak tersedia`, "error");
      return;
    }

    if (stats.hasUnits || item.stok > 1) {
      openDetailModal(item);
    } else {
      const newItem = {
        id: item.id,
        nama: item.nama,
        gambar: item.gambar,
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
      showToast(`${item.nama} ditambahkan ke daftar peminjaman`);
    }
  };

  const toggleModalUnit = (unitId, isUnavailable) => {
    if (isUnavailable) return;
    if (modalSelectedUnitIds.includes(unitId)) {
      setModalSelectedUnitIds(modalSelectedUnitIds.filter((id) => id !== unitId));
    } else {
      setModalSelectedUnitIds([...modalSelectedUnitIds, unitId]);
    }
  };

  const handleSaveModal = () => {
    if (!detailModalItem) return;

    const existingIndex = items.findIndex(
      (it) => it.id === detailModalItem.id && it.tipe === detailModalItem.tipe
    );

    if (detailModalItem.units && detailModalItem.units.length > 0) {
      if (modalSelectedUnitIds.length === 0) {
        showToast("Pilih minimal 1 unit", "error");
        return;
      }

      const newItem = {
        id: detailModalItem.id,
        nama: detailModalItem.nama,
        gambar: detailModalItem.gambar,
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
      };

      if (existingIndex >= 0) {
        const updated = [...items];
        updated[existingIndex] = newItem;
        setItems(updated);
        showToast(`Unit ${detailModalItem.nama} diperbarui (${modalSelectedUnitIds.length} unit)`);
      } else {
        setItems([...items, newItem]);
        showToast(`${detailModalItem.nama} ditambahkan (${modalSelectedUnitIds.length} unit)`);
      }
    } else {
      const qty = Math.max(1, Math.min(modalJumlah, detailModalItem.stok || 1));
      const newItem = {
        id: detailModalItem.id,
        nama: detailModalItem.nama,
        gambar: detailModalItem.gambar,
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
        showToast(`Jumlah ${detailModalItem.nama} diperbarui (${qty} unit)`);
      } else {
        setItems([...items, newItem]);
        showToast(`${detailModalItem.nama} ditambahkan (${qty} unit)`);
      }
    }

    setDetailModalItem(null);
    setModalSelectedUnitIds([]);
  };

  const removeItemFromList = (index) => {
    setItems(items.filter((_, i) => i !== index));
  };

  const updateItemJumlah = (index, value) => {
    const updated = [...items];
    const val = isNaN(value) ? 1 : Math.max(1, Math.min(value, updated[index].stok));
    updated[index].jumlah = val;
    setItems(updated);
  };

  // Template Paket Handlers
  const handleOpenPaketModal = async () => {
    setShowPaketModal(true);
    if (paketList.length === 0) {
      try {
        setLoadingPaket(true);
        const data = await getAllPaket();
        setPaketList(data || []);
      } catch (err) {
        showToast("Gagal memuat template paket", "error");
      } finally {
        setLoadingPaket(false);
      }
    }
  };

  const handleApplyPaket = async (paketId) => {
    try {
      setApplyingPaketId(paketId);
      const detail = await getPaketById(paketId);
      if (!detail || !detail.items || detail.items.length === 0) {
        showToast("Paket ini tidak memiliki item", "error");
        return;
      }

      const warnings = [];
      const newItemsToAdd = [];

      for (const pItem of detail.items) {
        const isAsset = pItem.item_type === "asset";
        const catalogItem = allItems.find(
          (c) => c.tipe === (isAsset ? "asset" : "aksesoris") && c.id === pItem.item_id
        );

        if (!catalogItem) {
          warnings.push(`Barang "${pItem.nama_item}" tidak ditemukan di database.`);
          continue;
        }

        const requestedQty = Number(pItem.jumlah) || 1;
        const hasUnits = catalogItem.units && catalogItem.units.length > 0;

        if (hasUnits) {
          const readyUnits = catalogItem.units.filter(
            (u) => u.status_pinjam === "Tersedia" && u.kondisi === "Siap Digunakan"
          );

          if (readyUnits.length < requestedQty) {
            warnings.push(
              `"${catalogItem.nama}": hanya ${readyUnits.length} dari ${requestedQty} unit yang siap digunakan & tersedia.`
            );
          }

          const pickedUnits = readyUnits.slice(0, requestedQty);
          if (pickedUnits.length > 0) {
            newItemsToAdd.push({
              id: catalogItem.id,
              nama: catalogItem.nama,
              gambar: catalogItem.gambar,
              kode: catalogItem.kode,
              tipe: catalogItem.tipe,
              harga: catalogItem.harga,
              tipeHarga: catalogItem.tipeHarga,
              hargaAsetOriginal: catalogItem.hargaAsetOriginal,
              jumlahTotal: catalogItem.jumlahTotal,
              stok: catalogItem.stok,
              jumlah: pickedUnits.length,
              kategori: catalogItem.kategori,
              merek: catalogItem.merek,
              jenisAset: catalogItem.jenisAset,
              kondisi: catalogItem.kondisi,
              hasUnits: true,
              units: catalogItem.units,
              unitIds: pickedUnits.map((u) => u.id),
            });
          }
        } else {
          const availableStock = catalogItem.stok || 0;
          if (availableStock < requestedQty) {
            warnings.push(
              `"${catalogItem.nama}": stok tersisa ${availableStock} dari ${requestedQty} yang dibutuhkan.`
            );
          }

          const actualQty = Math.min(requestedQty, availableStock);
          if (actualQty > 0) {
            newItemsToAdd.push({
              id: catalogItem.id,
              nama: catalogItem.nama,
              gambar: catalogItem.gambar,
              kode: catalogItem.kode,
              tipe: catalogItem.tipe,
              harga: catalogItem.harga,
              tipeHarga: catalogItem.tipeHarga,
              hargaAsetOriginal: catalogItem.hargaAsetOriginal,
              jumlahTotal: catalogItem.jumlahTotal,
              stok: catalogItem.stok,
              jumlah: actualQty,
              kategori: catalogItem.kategori,
              merek: catalogItem.merek,
              jenisAset: catalogItem.jenisAset,
              kondisi: catalogItem.kondisi,
              hasUnits: false,
            });
          }
        }
      }

      setItems((prevItems) => {
        const itemMap = new Map();
        prevItems.forEach((it) => itemMap.set(`${it.tipe}_${it.id}`, { ...it }));

        newItemsToAdd.forEach((newItem) => {
          const key = `${newItem.tipe}_${newItem.id}`;
          if (itemMap.has(key)) {
            const existing = itemMap.get(key);
            if (existing.hasUnits) {
              const combinedUnitIds = Array.from(new Set([...existing.unitIds, ...newItem.unitIds]));
              existing.unitIds = combinedUnitIds;
              existing.jumlah = combinedUnitIds.length;
            } else {
              existing.jumlah += newItem.jumlah;
            }
          } else {
            itemMap.set(key, newItem);
          }
        });

        return Array.from(itemMap.values());
      });

      if (warnings.length > 0) {
        setPaketWarnings(warnings);
        showToast("Template paket diterapkan dengan beberapa penyesuaian stok.", "error");
      } else {
        setPaketWarnings([]);
        showToast(`Template paket "${detail.nama_paket}" berhasil diterapkan!`);
      }

      setShowPaketModal(false);
    } catch (err) {
      console.error("Error applying package:", err);
      showToast(err.message || "Gagal menerapkan template paket", "error");
    } finally {
      setApplyingPaketId(null);
    }
  };

  // Price calculations
  const getItemSubtotal = (item) => {
    const qty = Number(item.jumlah) || 1;
    if (item.tipeHarga === "Per Paket" && (item.jumlahTotal || 1) > 0) {
      if (qty === Number(item.jumlahTotal || 1)) {
        return Number(item.hargaAsetOriginal) || 0;
      }
      return Math.round(((Number(item.hargaAsetOriginal) || 0) * qty) / Number(item.jumlahTotal || 1));
    }
    return (Number(item.harga) || 0) * qty;
  };

  const calculateTotal = () => {
    return items.reduce((total, item) => total + getItemSubtotal(item), 0);
  };

  // Submit Handler
  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!namaPeminjam.trim()) {
      showToast("Nama peminjam wajib diisi", "error");
      return;
    }
    if (!tanggalPeminjaman) {
      showToast("Tanggal peminjaman wajib diisi", "error");
      return;
    }
    if (items.length === 0) {
      showToast("Pilih minimal 1 item untuk dipinjam", "error");
      return;
    }

    try {
      setSubmitting(true);

      const now = new Date();
      const hours = String(now.getHours()).padStart(2, "0");
      const minutes = String(now.getMinutes()).padStart(2, "0");
      const seconds = String(now.getSeconds()).padStart(2, "0");
      const dateTimeStr = `${tanggalPeminjaman} ${hours}:${minutes}:${seconds}`;

      const formattedKeperluanList = keperluanList
        .filter((k) => k.keperluan?.trim())
        .map((k) => ({ ...k, keperluan: toSentenceCase(k.keperluan.trim()) }));

      await updatePengajuan(
        peminjamanId,
        {
          namaPeminjam: toCapitalEachWord(namaPeminjam.trim()),
          tanggalPeminjaman: dateTimeStr,
          alasanPeminjaman: formattedKeperluanList[0]?.keperluan || "",
          keperluanList: formattedKeperluanList,
          existingBukti: existingBukti,
          items: items.map((item) => ({
            [item.tipe === "asset" ? "assetId" : "aksesorisId"]: item.id,
            jumlah: parseInt(item.jumlah) || 0,
            unitIds: item.unitIds || undefined,
          })),
        },
        newBuktiFiles
      );

      showToast("Pengajuan peminjaman berhasil diperbarui dan diajukan ulang!");
      setTimeout(() => {
        router.push("/aset/peminjaman");
      }, 1500);
    } catch (err) {
      console.error("Error updating revision:", err);
      showToast(err.response?.data?.message || err.message || "Gagal memperbarui pengajuan", "error");
    } finally {
      setSubmitting(false);
    }
  };

  // Badge helpers
  const getKondisiBadge = (kondisi, isList = false) => {
    const base = isList ? "text-[10px] sm:text-xs" : "text-xs";
    const badges = {
      "Siap Digunakan": `bg-emerald-100 text-emerald-800 ${base}`,
      "Rusak": `bg-rose-100 text-rose-800 ${base}`,
      "Rusak Berat": `bg-rose-200 text-rose-900 ${base}`,
      "Maintenance": `bg-amber-100 text-amber-800 ${base}`,
    };
    return badges[kondisi] || `bg-slate-100 text-slate-800 ${base}`;
  };

  const renderBrandBadge = (jenisAset, isSmall = false) => {
    const baseClass = isSmall
      ? "text-[9px] sm:text-[10px] px-1.5 py-0.5 rounded-full font-bold uppercase tracking-wider"
      : "text-[10px] sm:text-xs px-2 py-0.5 rounded-full font-bold uppercase tracking-wider";
    if (jenisAset === "Galeria Studio") {
      return <span className={`${baseClass} bg-amber-100 text-amber-700 border border-amber-200`}>Studio</span>;
    }
    if (jenisAset === "Galeria Production") {
      return <span className={`${baseClass} bg-teal-100 text-teal-700 border border-teal-200`}>Production</span>;
    }
    return null;
  };

  // Filter Catalog
  const filteredItems = allItems.filter((item) => {
    const matchSearch =
      itemSearch === "" ||
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

  if (!isLoaded) {
    return (
      <div className="flex items-center justify-center py-20">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-slate-600">Memuat data pengajuan...</p>
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
            onClick={() => router.push("/aset/peminjaman")}
            className="cursor-pointer p-2 bg-primary rounded-lg transition hover:bg-primary-hover text-white"
            title="Kembali"
          >
            <ChevronLeft className="w-5 h-5" />
          </button>
          <div>
            <h1 className="text-2xl font-bold text-slate-900">Edit &amp; Revisi Peminjaman Alat</h1>
            <p className="text-sm text-slate-500">
              Kode: {kodePinjam} &bull; Status:{" "}
              <span
                className={`inline-block px-2 py-0.5 rounded text-xs font-bold ${
                  existingData?.status === "Ditolak"
                    ? "bg-rose-100 text-rose-700"
                    : "bg-amber-100 text-amber-700"
                }`}
              >
                {existingData?.status}
              </span>
            </p>
          </div>
        </div>
      </div>

      {/* Banner Khusus jika Ditolak */}
      {existingData?.status === "Ditolak" && (
        <div className="mb-6 rounded-xl border-2 border-rose-300 bg-rose-50/90 p-4 sm:p-5 shadow-sm">
          <div className="flex items-start gap-3.5">
            <div className="p-2.5 bg-rose-100 text-rose-600 rounded-xl shrink-0 mt-0.5">
              <AlertTriangle className="h-5 w-5 sm:h-6 sm:w-6" />
            </div>
            <div className="space-y-1.5 flex-1">
              <h3 className="text-sm sm:text-base font-bold text-rose-900">
                Pengajuan Peminjaman Ini Ditolak
              </h3>
              <p className="text-xs text-rose-700">
                <span className="font-semibold">Ditolak oleh:</span> {existingData?.rejectedBy || "Admin"}
              </p>
              <div className="p-3 bg-white/90 rounded-lg border border-rose-200">
                <p className="text-[11px] font-bold text-rose-800 uppercase tracking-wide mb-0.5">
                  Catatan / Alasan Penolakan:
                </p>
                <p className="text-xs sm:text-sm text-slate-800 font-medium whitespace-pre-wrap">
                  {existingData?.alasanPenolakan || "Tidak ada catatan alasan penolakan."}
                </p>
              </div>
              <p className="text-xs text-slate-600 pt-0.5">
                Silakan lakukan perbaikan pada barang, tanggal, atau keperluan di bawah ini, lalu simpan untuk mengajukan ulang permohonan ke admin.
              </p>
            </div>
          </div>
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-6">
        {/* Section 1: Data Peminjam & Keperluan */}
        <div className="bg-white rounded-lg shadow-sm border border-slate-200 border-t-4 border-t-primary p-4 sm:p-6">
          <h2 className="text-lg font-semibold text-slate-900 mb-4 flex items-center gap-2">
            <FileText className="w-5 h-5" />
            Informasi Peminjaman
          </h2>

          <div className="grid md:grid-cols-2 gap-4">
            {/* Nama Peminjam */}
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-2">
                Nama Peminjam *
              </label>
              <p className="mb-2 -mt-1 text-xs text-slate-400 italic">↳ Nama orang yang meminjam alat</p>
              {["super admin", "admin"].includes(userRole.toLowerCase()) ? (
                <select
                  value={namaPeminjam}
                  onChange={(e) => setNamaPeminjam(e.target.value)}
                  className="w-full rounded-lg border border-slate-300 px-3 py-2 text-slate-900 bg-white focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none"
                  required
                >
                  <option value="">-- Pilih Pegawai --</option>
                  {pegawaiList.map((p) => (
                    <option key={p.id} value={p.nama_lengkap}>
                      {p.nama_lengkap} ({p.jabatan || "Pegawai"})
                    </option>
                  ))}
                </select>
              ) : (
                <input
                  type="text"
                  placeholder="Masukkan nama peminjam"
                  value={namaPeminjam}
                  readOnly
                  className="w-full rounded-lg border border-slate-300 px-3 py-2 text-slate-900 bg-slate-50 cursor-not-allowed text-slate-500 focus:outline-none"
                  required
                />
              )}
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
                className="w-full rounded-lg border border-slate-300 px-3 py-2 text-slate-900 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none"
                required
              />
            </div>
          </div>

          <hr className="my-6 border-slate-200" />

          {/* Keperluan Peminjaman */}
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
        <div className="bg-white rounded-lg shadow-sm border border-slate-200 border-t-4 border-t-primary p-4 sm:p-6">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 mb-3">
            <div className="flex items-center gap-2 min-w-0">
              <Package className="w-5 h-5 text-primary shrink-0" />
              <h2 className="text-base sm:text-lg font-semibold text-slate-900 truncate">
                Pilih Item
              </h2>
              <span className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold bg-primary/10 text-primary shrink-0">
                {items.length} terpilih
              </span>
            </div>

            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={handleOpenPaketModal}
                className="cursor-pointer inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-orange-50 border border-orange-200 text-orange-700 hover:bg-orange-100 text-xs sm:text-sm font-semibold transition-all shadow-xs"
                title="Pilih barang cepat menggunakan template paket"
              >
                <Boxes className="w-4 h-4 text-orange-600" />
                <span>Gunakan Template Paket</span>
              </button>

              <div className="inline-flex items-center p-1 bg-slate-100 rounded-lg border border-slate-200/80 shrink-0">
                <button
                  type="button"
                  onClick={() => setViewMode("list")}
                  className={`cursor-pointer px-2.5 sm:px-3 py-1 text-xs sm:text-sm font-medium rounded-md transition-all flex items-center gap-1.5 ${
                    viewMode === "list"
                      ? "bg-white text-primary shadow-xs font-semibold"
                      : "text-slate-600 hover:text-slate-900"
                  }`}
                  title="Tampilan List"
                >
                  <List className="w-3.5 h-3.5 sm:w-4 sm:h-4" />
                  <span>List</span>
                </button>
                <button
                  type="button"
                  onClick={() => setViewMode("grid")}
                  className={`cursor-pointer px-2.5 sm:px-3 py-1 text-xs sm:text-sm font-medium rounded-md transition-all flex items-center gap-1.5 ${
                    viewMode === "grid"
                      ? "bg-white text-primary shadow-xs font-semibold"
                      : "text-slate-600 hover:text-slate-900"
                  }`}
                  title="Tampilan Grid"
                >
                  <Grid className="w-3.5 h-3.5 sm:w-4 sm:h-4" />
                  <span>Grid</span>
                </button>
              </div>
            </div>
          </div>

          {/* Controls Row */}
          <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-2.5 sm:gap-3 mb-4">
            <div className="relative flex-1">
              <Search className="absolute left-3 top-2.5 h-4 w-4 text-slate-400" />
              <input
                type="text"
                placeholder="Cari nama, kode, kategori..."
                value={itemSearch}
                onChange={(e) => setItemSearch(e.target.value)}
                className="w-full rounded-lg border border-slate-300 py-2 pl-9 pr-8 text-xs sm:text-sm text-slate-900 placeholder:text-slate-400 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none bg-white transition-colors"
              />
              {itemSearch && (
                <button
                  type="button"
                  onClick={() => setItemSearch("")}
                  className="cursor-pointer absolute right-2.5 top-2.5 text-slate-400 hover:text-slate-600 p-0.5"
                  title="Hapus pencarian"
                >
                  <X className="w-3.5 h-3.5" />
                </button>
              )}
            </div>

            <div className="grid grid-cols-2 gap-2 sm:flex sm:items-center sm:gap-2.5 shrink-0">
              <select
                value={itemFilter}
                onChange={(e) => setItemFilter(e.target.value)}
                className="cursor-pointer rounded-lg border border-slate-300 px-3 py-2 text-xs sm:text-sm text-slate-900 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none bg-white w-full sm:w-auto"
              >
                <option value="semua">Semua Tipe</option>
                <option value="asset">Aset</option>
                <option value="aksesoris">Aksesoris</option>
              </select>
              <select
                value={brandFilter}
                onChange={(e) => setBrandFilter(e.target.value)}
                className="cursor-pointer rounded-lg border border-slate-300 px-3 py-2 text-xs sm:text-sm text-slate-900 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none bg-white w-full sm:w-auto"
              >
                <option value="semua">Semua Brand</option>
                <option value="Galeria Studio">Galeria Studio</option>
                <option value="Galeria Production">Galeria Production</option>
              </select>
            </div>
          </div>

          {/* Paket Warnings Banner */}
          {paketWarnings.length > 0 && (
            <div className="mb-4 p-3.5 rounded-xl bg-amber-50 border border-amber-200 text-amber-900 text-xs sm:text-sm space-y-1.5 animate-in fade-in duration-200">
              <div className="flex items-center justify-between font-bold text-amber-800">
                <div className="flex items-center gap-2">
                  <AlertTriangle className="w-4 h-4 text-amber-600 shrink-0" />
                  <span>Catatan Ketersediaan Paket:</span>
                </div>
                <button
                  type="button"
                  onClick={() => setPaketWarnings([])}
                  className="cursor-pointer p-0.5 text-amber-600 hover:text-amber-800"
                >
                  <X className="w-4 h-4" />
                </button>
              </div>
              <ul className="list-disc list-inside space-y-0.5 text-amber-700 pl-1 text-xs">
                {paketWarnings.map((w, idx) => (
                  <li key={idx}>{w}</li>
                ))}
              </ul>
              <p className="text-[11px] text-amber-600 pt-1 italic">
                * Unit yang sehat/tersedia telah otomatis dimasukkan. Anda dapat mencari item pengganti secara manual di daftar bawah jika diperlukan.
              </p>
            </div>
          )}

          {/* Grid View */}
          {viewMode === "grid" && (
            <div className="grid grid-cols-1 min-[520px]:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3 sm:gap-4 mb-4 max-h-[460px] overflow-y-auto pr-1">
              {filteredItems.map((item) => {
                const stats = getItemUnitStats(item);
                const isSelected = items.some((it) => it.id === item.id && it.tipe === item.tipe);
                const selectedItem = items.find((it) => it.id === item.id && it.tipe === item.tipe);
                const isDisabled = !stats.isAvailable && !isSelected;

                return (
                  <div
                    key={`${item.tipe}-${item.id}`}
                    onClick={() => handleItemClick(item)}
                    className={`p-3 sm:p-3.5 rounded-xl border-2 transition-all flex flex-col justify-between select-none ${
                      isSelected
                        ? "border-primary bg-blue-50/70 shadow-xs"
                        : isDisabled
                        ? "border-slate-200 bg-slate-50/50 opacity-60 cursor-not-allowed"
                        : "border-slate-200 hover:border-primary hover:bg-slate-50 cursor-pointer hover:shadow-xs active:scale-[0.99]"
                    }`}
                  >
                    <div>
                      <div className="mb-2.5 h-36 sm:h-40 bg-slate-100 rounded-lg overflow-hidden flex items-center justify-center relative">
                        <ItemThumbnail
                          src={item.gambar}
                          alt={item.nama}
                          width={160}
                          height={160}
                          className="w-full h-full object-cover"
                          iconSize="w-8 h-8"
                        />
                        {isSelected && (
                          <div className="absolute top-2 right-2 bg-primary text-white p-1 rounded-full shadow-md">
                            <Check className="w-3.5 h-3.5 stroke-[3]" />
                          </div>
                        )}
                      </div>

                      <div className="flex items-center gap-1.5 flex-wrap mb-1.5">
                        {renderBrandBadge(item.jenisAset, true)}
                        <span
                          className={`text-[10px] px-2 py-0.5 rounded-full font-semibold border ${
                            item.tipe === "asset"
                              ? "bg-blue-100 text-blue-700 border-blue-200"
                              : "bg-purple-100 text-purple-700 border-purple-200"
                          }`}
                        >
                          {item.tipe === "asset" ? "Aset" : "Aksesoris"}
                        </span>
                        {item.kondisi && (
                          <span
                            className={`text-[10px] px-2 py-0.5 rounded-full font-semibold border ${getKondisiBadge(
                              item.kondisi,
                              true
                            )}`}
                          >
                            {item.kondisi}
                          </span>
                        )}
                      </div>

                      <h3 className="font-semibold text-slate-900 text-xs sm:text-sm line-clamp-2 leading-snug mb-1">
                        {item.nama}
                      </h3>
                      <p className="text-[11px] text-slate-500 font-mono truncate">{item.kode}</p>
                    </div>

                    <div className="mt-3 pt-2.5 border-t border-slate-200/80">
                      <div className="flex items-center justify-between text-xs">
                        <span className="text-slate-500 text-[11px]">Stok:</span>
                        <span className="font-bold text-slate-800 text-[11px]">
                          {stats.hasUnits ? `${stats.ready} Siap (${stats.total} Unit)` : `${item.stok} Tersedia`}
                        </span>
                      </div>
                      {isSelected && (
                        <div className="mt-1.5 flex items-center justify-between text-xs font-semibold text-primary bg-primary/10 px-2 py-1 rounded-md">
                          <span>Dipilih:</span>
                          <span>{selectedItem?.jumlah || 1} Unit</span>
                        </div>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          )}

          {/* List View */}
          {viewMode === "list" && (
            <div className="space-y-2 mb-4 max-h-[460px] overflow-y-auto pr-1">
              {filteredItems.map((item) => {
                const stats = getItemUnitStats(item);
                const isSelected = items.some((it) => it.id === item.id && it.tipe === item.tipe);
                const selectedItem = items.find((it) => it.id === item.id && it.tipe === item.tipe);
                const isDisabled = !stats.isAvailable && !isSelected;

                return (
                  <div
                    key={`${item.tipe}-${item.id}`}
                    onClick={() => handleItemClick(item)}
                    className={`p-3 rounded-xl border-2 transition-all flex items-center justify-between gap-3 select-none ${
                      isSelected
                        ? "border-primary bg-blue-50/70 shadow-xs"
                        : isDisabled
                        ? "border-slate-200 bg-slate-50/50 opacity-60 cursor-not-allowed"
                        : "border-slate-200 hover:border-primary hover:bg-slate-50 cursor-pointer"
                    }`}
                  >
                    <div className="flex items-center gap-3 min-w-0">
                      <div className="w-12 h-12 rounded-lg bg-slate-100 border border-slate-200 overflow-hidden shrink-0 flex items-center justify-center">
                        <ItemThumbnail
                          src={item.gambar}
                          alt={item.nama}
                          width={48}
                          height={48}
                          className="w-full h-full object-cover"
                          iconSize="w-6 h-6"
                        />
                      </div>

                      <div className="min-w-0">
                        <div className="flex items-center gap-1.5 flex-wrap mb-0.5">
                          {renderBrandBadge(item.jenisAset, true)}
                          <span
                            className={`text-[10px] px-2 py-0.5 rounded-full font-semibold border ${
                              item.tipe === "asset"
                                ? "bg-blue-100 text-blue-700 border-blue-200"
                                : "bg-purple-100 text-purple-700 border-purple-200"
                            }`}
                          >
                            {item.tipe === "asset" ? "Aset" : "Aksesoris"}
                          </span>
                        </div>
                        <h4 className="text-xs sm:text-sm font-semibold text-slate-900 truncate">
                          {item.nama}
                        </h4>
                        <p className="text-[11px] text-slate-500 font-mono truncate">
                          {item.kode} &bull; Stok:{" "}
                          <span className="font-bold text-slate-700">
                            {stats.hasUnits ? `${stats.ready} Siap` : `${item.stok}`}
                          </span>
                        </p>
                      </div>
                    </div>

                    <div className="shrink-0 flex items-center gap-2">
                      {isSelected ? (
                        <div className="flex items-center gap-1.5 px-3 py-1.5 bg-primary text-white rounded-lg text-xs font-semibold shadow-xs">
                          <Check className="w-3.5 h-3.5 stroke-[3]" />
                          <span>{selectedItem?.jumlah || 1} Unit</span>
                        </div>
                      ) : (
                        <button
                          type="button"
                          disabled={isDisabled}
                          className="cursor-pointer px-3 py-1.5 rounded-lg border border-slate-300 text-xs font-semibold text-slate-700 hover:bg-slate-100 transition disabled:opacity-40"
                        >
                          Pilih
                        </button>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          )}

          {filteredItems.length === 0 && (
            <div className="text-center py-8 text-slate-400">
              <Package className="w-10 h-10 mx-auto mb-2 opacity-50" />
              <p className="text-sm">Tidak ada item yang cocok dengan pencarian</p>
            </div>
          )}
        </div>

        {/* Section 3: Selected Items */}
        {items.length > 0 && (
          <div className="bg-white rounded-lg shadow-sm border border-slate-200 border-t-4 border-t-primary p-4 sm:p-6">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-base sm:text-lg font-semibold text-slate-900 flex items-center gap-2">
                <Package className="w-5 h-5 text-primary" />
                Item Terpilih ({items.length})
              </h3>
              <span className="text-xs text-slate-500 hidden sm:inline">
                Total {items.reduce((s, it) => s + (it.jumlah || 1), 0)} unit alat
              </span>
            </div>

            <div className="space-y-3 max-h-[380px] overflow-y-auto pr-1">
              {items.map((item, idx) => {
                const itemGambar =
                  item.gambar || allItems.find((it) => it.id === item.id && it.tipe === item.tipe)?.gambar;
                const subtotal = getItemSubtotal(item);

                return (
                  <div
                    key={`${item.tipe}-${item.id}-${idx}`}
                    className="p-3 sm:p-3.5 rounded-xl border-2 border-slate-200 bg-white hover:border-slate-300 transition-all shadow-xs flex flex-col gap-3"
                  >
                    <div className="flex items-start gap-3 min-w-0">
                      <div className="w-12 h-12 sm:w-14 sm:h-14 rounded-lg bg-slate-100 border border-slate-200 overflow-hidden shrink-0 flex items-center justify-center">
                        <ItemThumbnail
                          src={itemGambar}
                          alt={item.nama}
                          width={56}
                          height={56}
                          className="w-full h-full object-cover"
                          iconSize="w-6 h-6"
                        />
                      </div>

                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-1.5 flex-wrap mb-1">
                          {renderBrandBadge(item.jenisAset, true)}
                          <span
                            className={`text-[10px] sm:text-xs px-2 py-0.5 rounded-full font-semibold border ${
                              item.tipe === "asset"
                                ? "bg-blue-100 text-blue-700 border-blue-200"
                                : "bg-purple-100 text-purple-700 border-purple-200"
                            }`}
                          >
                            {item.tipe === "asset" ? "Aset" : "Aksesoris"}
                          </span>
                          {item.kondisi && (
                            <span
                              className={`text-[10px] sm:text-xs px-2 py-0.5 rounded-full font-semibold border ${getKondisiBadge(
                                item.kondisi,
                                true
                              )}`}
                            >
                              {item.kondisi}
                            </span>
                          )}
                        </div>

                        <p className="font-semibold text-slate-900 text-sm truncate" title={item.nama}>
                          {item.nama}
                        </p>
                        <p className="text-xs text-slate-500 truncate mt-0.5">
                          {item.kode} &bull; Stok: {item.stok}
                        </p>

                        {/* Unit Chips or Setting Links */}
                        {item.hasUnits && (
                          <div className="flex flex-wrap items-center gap-1.5 mt-2">
                            <span className="text-[11px] text-slate-500 font-semibold">Unit:</span>
                            {(item.units || [])
                              .filter((u) => item.unitIds?.includes(u.id))
                              .map((u) => (
                                <span
                                  key={u.id}
                                  className="text-xs px-2 py-0.5 bg-blue-50 text-blue-700 font-bold rounded-md border border-blue-200"
                                >
                                  {u.nama_unit || u.kode_unit}
                                </span>
                              ))}
                            <button
                              type="button"
                              onClick={() => {
                                const orig =
                                  allItems.find((it) => it.id === item.id && it.tipe === item.tipe) || item;
                                openDetailModal(orig);
                              }}
                              className="cursor-pointer text-xs px-2 py-0.5 rounded bg-blue-50 hover:bg-blue-100 text-primary font-semibold transition"
                            >
                              Ubah Unit
                            </button>
                          </div>
                        )}

                        {!item.hasUnits && item.stok > 1 && (
                          <div className="mt-2">
                            <button
                              type="button"
                              onClick={() => {
                                const orig =
                                  allItems.find((it) => it.id === item.id && it.tipe === item.tipe) || item;
                                openDetailModal(orig);
                              }}
                              className="cursor-pointer text-xs px-2.5 py-1 rounded bg-slate-100 hover:bg-slate-200 text-slate-700 font-semibold transition inline-flex items-center gap-1"
                            >
                              Atur Jumlah
                            </button>
                          </div>
                        )}
                      </div>
                    </div>

                    <div className="flex items-center justify-between border-t border-slate-100 pt-2.5 mt-1">
                      <div className="flex flex-col">
                        {item.harga > 0 ? (
                          <>
                            <span className="text-xs font-bold text-emerald-600 sm:text-sm">
                              Rp {subtotal.toLocaleString("id-ID")}
                            </span>
                            <span className="text-[10px] text-slate-400">
                              {item.tipeHarga === "Per Paket" ? "~ " : "@ "}Rp{" "}
                              {(item.harga || 0).toLocaleString("id-ID")} / unit
                              {item.tipeHarga === "Per Paket" &&
                                ` (Paket: Rp ${Number(item.hargaAsetOriginal || 0).toLocaleString("id-ID")})`}
                            </span>
                          </>
                        ) : (
                          <span className="text-xs text-slate-400 italic">Tanpa biaya</span>
                        )}
                      </div>

                      <div className="flex items-center gap-2.5 sm:gap-3">
                        {item.hasUnits ? (
                          <div className="flex items-center gap-1.5 bg-blue-50 px-3 py-1.5 rounded-lg border border-blue-200">
                            <span className="text-xs font-bold text-blue-800">{item.jumlah} Unit</span>
                          </div>
                        ) : (
                          <div className="flex items-center gap-1 bg-slate-50 px-2 py-1 rounded-lg border border-slate-200">
                            <label className="text-xs text-slate-600 font-medium mr-1">Jml:</label>
                            <input
                              type="number"
                              min="1"
                              max={item.stok}
                              value={item.jumlah}
                              onChange={(e) => updateItemJumlah(idx, parseInt(e.target.value))}
                              className="w-12 sm:w-14 text-center rounded bg-white border border-slate-300 py-0.5 text-xs sm:text-sm font-semibold text-slate-900 focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none"
                            />
                          </div>
                        )}

                        <button
                          type="button"
                          onClick={() => removeItemFromList(idx)}
                          className="cursor-pointer p-1.5 sm:p-2 text-rose-600 hover:bg-rose-50 hover:text-rose-700 rounded-lg transition"
                          title="Hapus Item"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>

            {items.some((it) => it.harga > 0) && (
              <div className="mt-5 p-4 rounded-xl bg-gradient-to-r from-emerald-50/80 to-slate-50 border border-emerald-200/60 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                <div>
                  <span className="text-xs font-semibold uppercase tracking-wider text-emerald-800">
                    Total Nilai Aset yang Dipinjam
                  </span>
                  <p className="text-xs text-slate-500 mt-0.5">
                    Peminjam bertanggung jawab penuh atas keutuhan dan kondisi aset di atas
                  </p>
                </div>
                <div className="text-left sm:text-right shrink-0">
                  <span className="text-2xl font-extrabold text-emerald-600 tracking-tight">
                    Rp {calculateTotal().toLocaleString("id-ID")}
                  </span>
                </div>
              </div>
            )}
          </div>
        )}

        {/* Section 4: Bukti Peminjaman */}
        <div className="bg-white rounded-lg shadow-sm border border-slate-200 border-t-4 border-t-primary p-4 sm:p-6">
          <h2 className="text-lg font-semibold text-slate-900 mb-4 flex items-center gap-2">
            <Camera className="w-5 h-5" />
            Bukti Peminjaman ({existingBukti.length + newBuktiFiles.length}/5)
          </h2>

          <div className="space-y-4">
            <div
              onDragEnter={(e) => {
                e.preventDefault();
                e.stopPropagation();
                setIsDragging(true);
              }}
              onDragOver={(e) => {
                e.preventDefault();
                e.stopPropagation();
                setIsDragging(true);
              }}
              onDragLeave={(e) => {
                e.preventDefault();
                e.stopPropagation();
                setIsDragging(false);
              }}
              onDrop={handleDrop}
              className={`border-2 border-dashed rounded-xl p-5 text-center transition-all ${
                isDragging
                  ? "border-primary bg-primary/5 ring-4 ring-primary/10 scale-[1.01]"
                  : "border-slate-300 bg-slate-50 hover:border-slate-400"
              }`}
            >
              {/* Desktop */}
              <div className="hidden sm:block">
                <div
                  onClick={() => fileInputRef.current?.click()}
                  className="cursor-pointer group flex flex-col items-center justify-center p-3"
                >
                  <div
                    className={`w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-2.5 shadow-sm border transition-all ${
                      isDragging
                        ? "bg-primary text-white scale-110"
                        : "bg-white text-primary border-slate-100 group-hover:scale-110"
                    }`}
                  >
                    <Upload className="w-6 h-6" />
                  </div>
                  <p className="text-sm font-bold text-slate-800 mb-0.5">
                    {isDragging ? "Lepaskan file foto di sini..." : "Tarik & Lepas Foto di Sini, atau"}
                  </p>
                  <p className="text-xs text-slate-400 mb-3">PNG, JPG, HEIC, WebP (Maks. 5 file)</p>
                  <button
                    type="button"
                    onClick={(e) => {
                      e.stopPropagation();
                      fileInputRef.current?.click();
                    }}
                    className="cursor-pointer inline-flex items-center gap-2 px-4 py-2 bg-white border border-slate-200 shadow-xs rounded-xl hover:border-primary hover:text-primary transition-all text-xs font-semibold text-slate-700 active:scale-95"
                  >
                    <Upload className="h-3.5 w-3.5 text-primary" />
                    Pilih File dari Komputer
                  </button>
                </div>
              </div>

              {/* Mobile */}
              <div className="block sm:hidden">
                <div className="bg-white w-11 h-11 rounded-full flex items-center justify-center mx-auto mb-2 shadow-sm border border-slate-100">
                  <Camera className="w-5 h-5 text-primary" />
                </div>
                <p className="text-xs font-bold text-slate-700 mb-0.5">Upload Bukti Peminjaman</p>
                <p className="text-[11px] text-slate-500 mb-3">Maks. 5 file (PNG, JPG, HEIC, WebP)</p>

                <div className="flex flex-col gap-2">
                  <button
                    type="button"
                    onClick={() => cameraInputRef.current?.click()}
                    className="cursor-pointer w-full py-2 bg-primary text-white text-xs font-semibold rounded-lg hover:bg-primary-hover transition flex items-center justify-center gap-2 shadow-xs"
                  >
                    <Camera className="w-4 h-4" />
                    Ambil Foto Kamera
                  </button>
                  <button
                    type="button"
                    onClick={() => fileInputRef.current?.click()}
                    className="cursor-pointer w-full py-2 bg-white border border-slate-300 text-slate-700 text-xs font-semibold rounded-lg hover:bg-slate-50 transition flex items-center justify-center gap-2"
                  >
                    <Upload className="w-4 h-4" />
                    Pilih dari Galeri
                  </button>
                </div>
              </div>
            </div>

            <input
              ref={fileInputRef}
              type="file"
              accept="image/*"
              multiple
              onChange={handleFileChange}
              className="hidden"
            />
            <input
              ref={cameraInputRef}
              type="file"
              accept="image/*"
              capture="environment"
              onChange={handleFileChange}
              className="hidden"
            />

            {/* Previews (Existing + New) */}
            {(existingBukti.length > 0 || newBuktiPreviews.length > 0) && (
              <div className="grid grid-cols-2 sm:grid-cols-4 md:grid-cols-5 gap-3">
                {/* Existing */}
                {existingBukti.map((path, idx) => (
                  <div
                    key={`exist-${idx}`}
                    className="relative group rounded-xl overflow-hidden border border-slate-200 aspect-square bg-slate-100"
                  >
                    <img
                      src={`${BACKEND_URL}${path}`}
                      alt={`Bukti ${idx + 1}`}
                      className="w-full h-full object-cover"
                    />
                    <button
                      type="button"
                      onClick={() => removeExistingBukti(idx)}
                      className="cursor-pointer absolute top-1.5 right-1.5 p-1 bg-black/60 rounded-full text-white hover:bg-rose-600 transition"
                      title="Hapus foto"
                    >
                      <X className="h-3.5 w-3.5" />
                    </button>
                    <span className="absolute bottom-1.5 left-1.5 px-1.5 py-0.5 bg-black/60 rounded text-[9px] text-white">
                      Tersimpan
                    </span>
                  </div>
                ))}

                {/* New */}
                {newBuktiPreviews.map((url, idx) => (
                  <div
                    key={`new-${idx}`}
                    className="relative group rounded-xl overflow-hidden border border-emerald-300 aspect-square bg-emerald-50"
                  >
                    <img
                      src={url}
                      alt={`Foto Baru ${idx + 1}`}
                      className="w-full h-full object-cover"
                    />
                    <button
                      type="button"
                      onClick={() => removeNewBukti(idx)}
                      className="cursor-pointer absolute top-1.5 right-1.5 p-1 bg-black/60 rounded-full text-white hover:bg-rose-600 transition"
                      title="Hapus foto baru"
                    >
                      <X className="h-3.5 w-3.5" />
                    </button>
                    <span className="absolute bottom-1.5 left-1.5 px-1.5 py-0.5 bg-emerald-600 rounded text-[9px] text-white font-bold">
                      Baru
                    </span>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>

        {/* Action Buttons */}
        <div className="flex items-center justify-end gap-3 pt-2">
          <button
            type="button"
            onClick={() => router.push("/aset/peminjaman")}
            className="cursor-pointer px-5 py-2.5 rounded-lg border border-slate-300 text-sm font-semibold text-slate-700 hover:bg-slate-50 transition"
          >
            Batal
          </button>
          <button
            type="submit"
            disabled={submitting}
            className="cursor-pointer px-6 py-2.5 rounded-lg bg-primary text-white text-sm font-semibold hover:bg-primary-hover disabled:opacity-60 transition shadow-sm flex items-center gap-2"
          >
            {submitting ? (
              <>
                <div className="h-4 w-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                <span>Menyimpan...</span>
              </>
            ) : (
              <>
                <Check className="w-4 h-4" />
                <span>Perbarui &amp; Ajukan Ulang</span>
              </>
            )}
          </button>
        </div>
      </form>

      {/* Modal Detail / Unit Selection (Portal) */}
      {typeof document !== "undefined" &&
        detailModalItem &&
        createPortal(
          <div
            className="fixed inset-0 z-60 flex items-center justify-center p-3 sm:p-4 bg-slate-900/50 backdrop-blur-xs animate-in fade-in duration-200"
            onClick={() => setDetailModalItem(null)}
          >
            <div
              className="bg-white rounded-2xl w-full max-w-lg max-h-[90vh] flex flex-col shadow-2xl border border-slate-200 overflow-hidden"
              onClick={(e) => e.stopPropagation()}
            >
              {/* Header */}
              <div className="flex items-center justify-between p-4 sm:p-5 border-b border-slate-200 bg-slate-50/70 shrink-0">
                <div className="flex items-center gap-3 min-w-0">
                  <div className="w-12 h-12 rounded-xl bg-slate-100 border border-slate-200 overflow-hidden shrink-0 flex items-center justify-center">
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
                      <span
                        className={`text-[10px] px-2 py-0.5 rounded-full font-semibold ${
                          detailModalItem.tipe === "asset"
                            ? "bg-blue-100 text-blue-700"
                            : "bg-purple-100 text-purple-700"
                        }`}
                      >
                        {detailModalItem.tipe === "asset" ? "Aset" : "Aksesoris"}
                      </span>
                      <span
                        className={`text-[10px] px-2 py-0.5 rounded-full font-semibold ${getKondisiBadge(
                          detailModalItem.kondisi,
                          false
                        )}`}
                      >
                        {detailModalItem.kondisi}
                      </span>
                    </div>
                    <h3 className="text-sm sm:text-base font-bold text-slate-900 truncate mt-0.5">
                      {detailModalItem.nama}
                    </h3>
                    <p className="text-xs text-slate-500 truncate">
                      {detailModalItem.kode} &bull; {detailModalItem.kategori} &bull; {detailModalItem.merek}
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

              {/* Body */}
              <div className="p-4 sm:p-6 overflow-y-auto flex-1 space-y-4">
                <div className="grid grid-cols-2 sm:grid-cols-3 gap-2.5 sm:gap-3 p-3 bg-slate-50 rounded-xl border border-slate-200 text-xs">
                  <div>
                    <span className="text-slate-500 block">Stok Tersedia</span>
                    <span className="text-sm font-bold text-slate-900">
                      {detailModalItem.units && detailModalItem.units.length > 0
                        ? `${detailModalItem.units.filter((u) => u.status_pinjam === "Tersedia" && u.kondisi === "Siap Digunakan").length} Unit`
                        : `${detailModalItem.stok} Unit`}
                    </span>
                  </div>
                  <div>
                    <span className="text-slate-500 block">Kondisi Alat</span>
                    <span className="text-sm font-bold text-emerald-600">{detailModalItem.kondisi}</span>
                  </div>
                  {detailModalItem.harga > 0 && (
                    <div className="col-span-2 sm:col-span-1">
                      <span className="text-slate-500 block">Harga / Unit</span>
                      <span className="text-sm font-bold text-emerald-600">
                        Rp {detailModalItem.harga.toLocaleString("id-ID")}
                      </span>
                    </div>
                  )}
                </div>

                {detailModalItem.units && detailModalItem.units.length > 0 ? (
                  <div>
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
                          {stats.rusak > 0 && (
                            <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-red-100 text-red-800 font-medium text-[11px]">
                              <span className="w-1.5 h-1.5 rounded-full bg-red-500"></span>
                              {stats.rusak} Rusak
                            </span>
                          )}
                        </div>
                      );
                    })()}

                    <div className="flex flex-col min-[420px]:flex-row min-[420px]:items-center justify-between gap-2 mb-3 pb-2 border-b border-slate-100">
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

                    <div className="space-y-2 max-h-72 overflow-y-auto pr-1">
                      {(detailModalItem.units || []).map((u) => {
                        const isDipinjam = u.status_pinjam === "Dipinjam";
                        const isRusak = u.kondisi === "Rusak" || u.kondisi === "Rusak Berat";
                        const isMaintenance = u.kondisi === "Maintenance";
                        // If it's already selected in the existing revision, allow keeping it
                        const isCurrentSelected = modalSelectedUnitIds.includes(u.id);
                        const isUnavailable = (isDipinjam || isRusak || isMaintenance) && !isCurrentSelected;

                        let statusLabel = "Siap Digunakan";
                        let statusBadgeClass = "bg-emerald-100 text-emerald-800 border-emerald-200";
                        if (isDipinjam || u.kondisi === "Sedang Dipinjam") {
                          statusLabel = "Sedang Dipinjam";
                          statusBadgeClass = "bg-blue-100 text-blue-800 border-blue-200";
                        } else if (isRusak) {
                          statusLabel = "Rusak";
                          statusBadgeClass = "bg-red-100 text-red-800 border-red-200";
                        } else if (isMaintenance) {
                          statusLabel = "Maintenance";
                          statusBadgeClass = "bg-amber-100 text-amber-800 border-amber-200";
                        }

                        return (
                          <div
                            key={u.id}
                            onClick={() => toggleModalUnit(u.id, isUnavailable)}
                            className={`relative px-3.5 py-2.5 sm:px-4 sm:py-3 rounded-xl border transition-all flex items-center justify-between gap-2.5 sm:gap-3 select-none ${
                              isUnavailable
                                ? "bg-slate-100/80 border-slate-200 opacity-60 cursor-not-allowed"
                                : isCurrentSelected
                                ? "bg-blue-50/70 border-primary ring-1 ring-primary shadow-xs cursor-pointer"
                                : "bg-white border-slate-200 hover:border-primary/50 hover:bg-slate-50 cursor-pointer"
                            }`}
                          >
                            <div className="flex items-center gap-3 min-w-0">
                              {isCurrentSelected ? (
                                <div className="w-5 h-5 rounded-md bg-primary text-white flex items-center justify-center shrink-0 shadow-xs">
                                  <Check className="w-3.5 h-3.5 stroke-[3]" />
                                </div>
                              ) : (
                                <div
                                  className={`w-5 h-5 rounded-md border shrink-0 ${
                                    isUnavailable ? "border-slate-300 bg-slate-200" : "border-slate-300 bg-white"
                                  }`}
                                />
                              )}

                              <div className="min-w-0">
                                <p
                                  className={`text-sm font-semibold truncate ${
                                    isCurrentSelected ? "text-primary" : isUnavailable ? "text-slate-500" : "text-slate-800"
                                  }`}
                                >
                                  {u.nama_unit || u.kode_unit}
                                </p>
                                <p className="text-xs text-slate-500 font-mono">{u.kode_unit}</p>
                              </div>
                            </div>

                            <div className="shrink-0 flex items-center gap-2">
                              <span className={`px-2 sm:px-2.5 py-0.5 sm:py-1 rounded-full text-[10px] sm:text-[11px] font-semibold border ${statusBadgeClass}`}>
                                {statusLabel}
                              </span>
                            </div>
                          </div>
                        );
                      })}
                    </div>
                  </div>
                ) : (
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

                {/* Price box */}
                {detailModalItem.harga > 0 && (() => {
                  const count =
                    detailModalItem.units && detailModalItem.units.length > 0
                      ? modalSelectedUnitIds.length
                      : modalJumlah;
                  const modalSubtotal =
                    detailModalItem.tipeHarga === "Per Paket" && (detailModalItem.jumlahTotal || 1) > 0
                      ? count === Number(detailModalItem.jumlahTotal || 1)
                        ? Number(detailModalItem.hargaAsetOriginal) || 0
                        : Math.round(
                            ((Number(detailModalItem.hargaAsetOriginal) || 0) * count) /
                              Number(detailModalItem.jumlahTotal || 1)
                          )
                      : (Number(detailModalItem.harga) || 0) * count;

                  return (
                    <div className="mt-4 p-3 bg-slate-50 rounded-xl border border-slate-200 flex items-center justify-between text-xs">
                      <div>
                        <span className="text-slate-500 block">Estimasi Nilai ({count} unit):</span>
                        <span className="text-[11px] text-slate-400">
                          {detailModalItem.tipeHarga === "Per Paket" ? "~ " : "@ "}Rp{" "}
                          {detailModalItem.harga.toLocaleString("id-ID")} / unit
                        </span>
                      </div>
                      <span className="text-base font-bold text-emerald-600">
                        Rp {modalSubtotal.toLocaleString("id-ID")}
                      </span>
                    </div>
                  );
                })()}
              </div>

              {/* Footer */}
              <div className="px-4 py-3 sm:px-6 sm:py-4 border-t border-slate-200 bg-slate-50 flex items-center justify-end gap-2.5 sm:gap-3 shrink-0">
                <button
                  type="button"
                  onClick={() => setDetailModalItem(null)}
                  className="cursor-pointer px-4 py-2 text-xs sm:text-sm font-semibold rounded-lg border border-slate-300 text-slate-700 hover:bg-slate-200 transition"
                >
                  Batal
                </button>
                <button
                  type="button"
                  disabled={
                    detailModalItem.units && detailModalItem.units.length > 0
                      ? modalSelectedUnitIds.length === 0
                      : modalJumlah <= 0
                  }
                  onClick={handleSaveModal}
                  className="cursor-pointer px-5 py-2 text-xs sm:text-sm font-semibold rounded-lg bg-primary text-white hover:bg-primary-hover disabled:opacity-50 disabled:cursor-not-allowed transition flex items-center gap-1.5"
                >
                  <Check className="w-4 h-4" />
                  Simpan (
                  {detailModalItem.units && detailModalItem.units.length > 0
                    ? modalSelectedUnitIds.length
                    : modalJumlah}{" "}
                  Unit)
                </button>
              </div>
            </div>
          </div>,
          document.body
        )}

      {/* Modal Pilihan Template Paket (Portal) */}
      {typeof document !== "undefined" &&
        showPaketModal &&
        createPortal(
          <div className="fixed inset-0 z-60 flex items-center justify-center p-4 bg-slate-900/50 backdrop-blur-xs animate-in fade-in duration-200">
            <div className="bg-white rounded-2xl w-full max-w-2xl max-h-[85vh] flex flex-col shadow-2xl border border-slate-200 overflow-hidden">
              <div className="flex items-center justify-between px-6 py-4 border-b border-slate-200 bg-slate-50/70">
                <div className="flex items-center gap-2.5">
                  <div className="p-2 rounded-xl bg-orange-100 text-orange-600">
                    <Boxes className="h-5 w-5" />
                  </div>
                  <div>
                    <h3 className="text-base font-bold text-slate-800">Pilih Template Paket</h3>
                    <p className="text-xs text-slate-500">
                      Otomatis memasukkan barang paket dengan saringan unit sehat/tersedia
                    </p>
                  </div>
                </div>
                <button
                  type="button"
                  onClick={() => setShowPaketModal(false)}
                  className="cursor-pointer p-1.5 rounded-lg text-slate-400 hover:text-slate-600 hover:bg-slate-100"
                >
                  <X className="h-5 w-5" />
                </button>
              </div>

              <div className="p-4 border-b border-slate-100 bg-white">
                <div className="relative">
                  <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400" />
                  <input
                    type="text"
                    value={paketSearch}
                    onChange={(e) => setPaketSearch(e.target.value)}
                    placeholder="Cari nama atau deskripsi paket..."
                    className="w-full pl-10 pr-4 py-2 text-xs sm:text-sm bg-slate-50 border border-slate-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-primary"
                  />
                </div>
              </div>

              <div className="flex-1 overflow-y-auto p-4 sm:p-6 space-y-4 custom-scrollbar">
                {loadingPaket ? (
                  <div className="py-12 text-center text-slate-400 text-sm">
                    Memuat daftar template paket...
                  </div>
                ) : paketList.length === 0 ? (
                  <div className="py-12 text-center space-y-2">
                    <Boxes className="h-10 w-10 text-slate-300 mx-auto" />
                    <p className="text-sm font-semibold text-slate-700">Belum Ada Template Paket</p>
                  </div>
                ) : (
                  <div className="space-y-3">
                    {paketList
                      .filter((p) => {
                        if (!paketSearch.trim()) return true;
                        const q = paketSearch.toLowerCase();
                        return (
                          p.nama_paket?.toLowerCase().includes(q) ||
                          p.deskripsi?.toLowerCase().includes(q)
                        );
                      })
                      .map((paket) => (
                        <div
                          key={paket.id}
                          className="p-4 rounded-xl border border-slate-200 hover:border-orange-300 hover:bg-orange-50/20 bg-white transition-all shadow-xs flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4"
                        >
                          <div className="flex items-center gap-3.5 min-w-0 flex-1">
                            <div className="relative w-16 h-16 rounded-xl bg-slate-100 overflow-hidden shrink-0 border border-slate-200 flex items-center justify-center">
                              {paket.gambar ? (
                                <Image
                                  src={`${BACKEND_URL}${paket.gambar}`}
                                  alt={paket.nama_paket}
                                  fill
                                  className="object-cover"
                                  unoptimized
                                />
                              ) : (
                                <Boxes className="h-7 w-7 text-slate-300" />
                              )}
                            </div>
                            <div className="min-w-0 flex-1">
                              <h4 className="text-sm font-bold text-slate-800 truncate">
                                {paket.nama_paket}
                              </h4>
                              <p className="text-xs text-slate-500 line-clamp-1 mt-0.5">
                                {paket.deskripsi || "Tanpa deskripsi"}
                              </p>
                              <div className="flex items-center gap-2 mt-1.5">
                                <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-orange-700 bg-orange-100/70 px-2 py-0.5 rounded-md">
                                  <Layers className="w-3 h-3" />
                                  {paket.total_items || 0} Macam Barang ({paket.total_qty || 0} Unit)
                                </span>
                              </div>
                            </div>
                          </div>

                          <div className="flex items-center gap-2 w-full sm:w-auto justify-end shrink-0">
                            <button
                              type="button"
                              disabled={applyingPaketId === paket.id}
                              onClick={() => handleApplyPaket(paket.id)}
                              className="cursor-pointer flex-1 sm:flex-initial inline-flex items-center justify-center gap-1.5 px-4 py-2 rounded-xl bg-primary text-white text-xs font-semibold hover:bg-primary/90 transition-all shadow-xs disabled:opacity-60"
                            >
                              <Sparkles className="w-3.5 h-3.5" />
                              <span>{applyingPaketId === paket.id ? "Menerapkan..." : "Terapkan Paket"}</span>
                            </button>
                          </div>
                        </div>
                      ))}
                  </div>
                )}
              </div>

              <div className="p-4 border-t border-slate-200 bg-slate-50/70 flex justify-end">
                <button
                  type="button"
                  onClick={() => setShowPaketModal(false)}
                  className="cursor-pointer px-4 py-2 text-xs font-semibold text-slate-700 bg-white border border-slate-200 rounded-xl hover:bg-slate-100 transition-colors"
                >
                  Tutup
                </button>
              </div>
            </div>
          </div>,
          document.body
        )}

      {/* Toast Notification (Portal) */}
      {typeof document !== "undefined" &&
        toast &&
        createPortal(
          <div
            className={`fixed top-20 right-6 z-[9999] flex items-center gap-2 rounded-xl px-5 py-3 shadow-lg text-sm font-medium text-white transition-all animate-[slideIn_0.3s_ease] ${
              toast.type === "error"
                ? "bg-rose-500"
                : toast.type === "info"
                ? "bg-blue-500"
                : "bg-emerald-500"
            }`}
          >
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
