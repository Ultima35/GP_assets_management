-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 02 Nov 2026 pada 04.53
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gp_asset_management`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `aksesoris`
--

CREATE TABLE `aksesoris` (
  `id` int(11) NOT NULL,
  `kode_aksesoris` varchar(50) NOT NULL,
  `nama_aksesoris` varchar(255) NOT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `merek` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `jumlah_unit` int(11) DEFAULT NULL,
  `jumlah_total` int(11) DEFAULT NULL,
  `harga_aset` bigint(20) DEFAULT NULL,
  `tipe_harga` enum('Per Unit','Per Paket') NOT NULL DEFAULT 'Per Unit',
  `tanggal_pembelian` date DEFAULT NULL,
  `kondisi` enum('Siap Digunakan','Maintenance','Rusak') DEFAULT 'Siap Digunakan',
  `lokasi` varchar(255) DEFAULT NULL,
  `jenis_aset` enum('Galeria Studio','Galeria Production') DEFAULT NULL,
  `gambar` varchar(500) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `aksesoris`
--

INSERT INTO `aksesoris` (`id`, `kode_aksesoris`, `nama_aksesoris`, `kategori`, `merek`, `model`, `jumlah_unit`, `jumlah_total`, `harga_aset`, `tipe_harga`, `tanggal_pembelian`, `kondisi`, `lokasi`, `jenis_aset`, `gambar`, `keterangan`, `user_id`, `created_at`, `updated_at`) VALUES
(101, 'ACC-GPRO-BAT-001', 'BATERAI SONY NP-FZ100', 'Baterai', 'Sony', 'NP-FZ100', 2, 4, 1100000, 'Per Unit', '2024-01-15', 'Siap Digunakan', 'KOTAK BATERAI 1', 'Galeria Production', NULL, 'Baterai cadangan kamera sony', 1, '2026-10-31 10:11:40', '2026-10-31 10:23:13'),
(102, 'ACC-GPRO-KAB-001', 'KABEL SET AUDIO XLR (ISI 10 PCS)', 'Kabel', 'Canare', 'L-2T2S', 4, 10, 1500000, 'Per Paket', '2024-03-01', 'Siap Digunakan', 'KOTAK AUDIO', 'Galeria Production', NULL, 'Paket 1 bundle isi 10 kabel', 1, '2026-10-31 10:11:40', '2026-10-31 10:23:41'),
(103, 'ACC-GPRO-BAT-002', 'BATERAI SONY NP-FZ100', 'Baterai', 'Sony', 'NP-FZ100', 2, 4, 1100000, 'Per Unit', '2024-02-10', 'Siap Digunakan', 'KOTAK BATERAI 1', 'Galeria Production', NULL, 'Baterai cadangan kamera sony', 1, '2026-10-31 10:11:40', '2026-10-31 10:23:48'),
(104, 'ACC-GPRO-KAB-002', 'KABEL SET AUDIO XLR (ISI 10 PCS)', 'Kabel', 'Canare', 'L-2T2S', 10, 10, 1500000, 'Per Paket', '2024-03-01', 'Siap Digunakan', 'KOTAK AUDIO', 'Galeria Production', NULL, 'Paket 1 bundle isi 10 kabel', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(105, 'ACC-GPRO-BAT-003', 'BATERAI CANON LP-E6NH', 'Baterai', 'Canon', 'LP-E6NH', 2, 4, 1350000, 'Per Unit', '2024-01-15', 'Siap Digunakan', 'KOTAK BATERAI 1', 'Galeria Production', NULL, 'Baterai kamera eos r series', 1, '2026-10-31 10:11:40', '2026-10-31 10:23:53'),
(106, 'ACC-GPRO-BAT-004', 'BATERAI SONY NP-FW50', 'Baterai', 'Sony', 'NP-FW50', 3, 3, 750000, 'Per Unit', '2023-11-20', 'Siap Digunakan', 'KOTAK BATERAI 2', 'Galeria Production', NULL, 'Cadangan bodi cadangan a6000 series', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(107, 'ACC-GPRO-CHA-001', 'CHARGER SONY BC-QZ1 DUAL', 'Charger', 'Sony', 'BC-QZ1', 2, 2, 950000, 'Per Unit', '2024-02-10', 'Siap Digunakan', 'RAK CHARGER', 'Galeria Production', NULL, 'Dual slot fast charging', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(108, 'ACC-GPRO-CHA-002', 'CHARGER CANON LC-E6E', 'Charger', 'Canon', 'LC-E6E', 2, 2, 650000, 'Per Unit', '2024-01-15', 'Siap Digunakan', 'RAK CHARGER', 'Galeria Production', NULL, 'Charger baterai lp-e6', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(109, 'ACC-GPRO-BAT-005', 'BATERAI V-MOUNT 99WH', 'Baterai', 'SmallRig', 'VB99 Pro', 2, 2, 2600000, 'Per Unit', '2024-04-12', 'Siap Digunakan', 'LEMARI DAYA', 'Galeria Production', NULL, 'Daya monitor dan continuous light', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(110, 'ACC-GPRO-AKS-001', 'V-MOUNT PLATE DUAL D-TAP', 'Aksesoris Daya', 'SmallRig', 'V-Lock Plate 2988', 2, 2, 850000, 'Per Unit', '2024-04-15', 'Siap Digunakan', 'KOTAK RIG', 'Galeria Production', NULL, 'Mounting baterai v-mount rig', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(111, 'ACC-GPRO-KAB-003', 'KABEL HDMI TO MICRO HDMI HIGH SPEED', 'Kabel', 'Ugreen', 'Ultra HD 4K', 4, 4, 125000, 'Per Unit', '2024-02-18', 'Siap Digunakan', 'KOTAK MONITOR', 'Galeria Production', NULL, 'Koneksi kamera ke monitor eksternal', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(112, 'ACC-GPRO-KAB-004', 'KABEL HDMI TO FULL HDMI 5M', 'Kabel', 'Vention', '4K 60Hz', 3, 3, 185000, 'Per Unit', '2024-03-05', 'Siap Digunakan', 'KOTAK VIDEOTRON', 'Galeria Production', NULL, 'Output switcher ke monitor/display', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(113, 'ACC-GPRO-KAB-005', 'KABEL SDI 10M BNC', 'Kabel', 'Canare', '3G/HD-SDI', 4, 4, 350000, 'Per Unit', '2024-03-10', 'Siap Digunakan', 'KOTAK KABEL BROADCAST', 'Galeria Production', NULL, 'Transmisi sinyal kamera broadcast', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(114, 'ACC-GPRO-KAB-006', 'KABEL SDI 20M BNC', 'Kabel', 'Canare', 'L-4.5CHD', 2, 2, 650000, 'Per Unit', '2024-03-10', 'Siap Digunakan', 'KOTAK KABEL BROADCAST', 'Galeria Production', NULL, 'Kabel tarikan panjang outdoor/venue', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(115, 'ACC-GPRO-KEL-001', 'KABEL ROLL STOPKONTAK 4 LUBANG 25M', 'Kelistrikan', 'Uticon', 'CR-2825', 3, 3, 280000, 'Per Unit', '2023-12-05', 'Siap Digunakan', 'RAK LISTRIK', 'Galeria Production', NULL, 'Kabel distribusi daya venue', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(116, 'ACC-GPRO-KEL-002', 'KABEL ROLL STOPKONTAK 4 LUBANG 50M', 'Kelistrikan', 'Uticon', 'Heavy Duty 50M', 2, 2, 520000, 'Per Unit', '2024-01-10', 'Siap Digunakan', 'RAK LISTRIK', 'Galeria Production', NULL, 'Distribusi daya jarak jauh outdoor', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(117, 'ACC-GPRO-KEL-003', 'KABEL SAMBUNGAN ARDE 10M', 'Kelistrikan', 'Broco', 'Extension HD 10M', 4, 4, 110000, 'Per Unit', '2024-02-01', 'Siap Digunakan', 'RAK LISTRIK', 'Galeria Production', NULL, 'Ekstensi daya lighting studio', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(118, 'ACC-GPRO-MED-001', 'SD CARD 128GB V60 EXTREME PRO', 'Media Simpan', 'SanDisk', 'SDXC UHS-II 128GB', 6, 6, 850000, 'Per Unit', '2024-02-12', 'Siap Digunakan', 'KOTAK KARTU MEMORI', 'Galeria Production', NULL, 'Perekaman video 4k all-intra', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(119, 'ACC-GPRO-MED-002', 'SD CARD 64GB EXTREME PRO', 'Media Simpan', 'SanDisk', 'SDXC UHS-I 64GB', 8, 8, 290000, 'Per Unit', '2023-10-18', 'Siap Digunakan', 'KOTAK KARTU MEMORI', 'Galeria Production', NULL, 'Penyimpanan foto portrait formal', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(120, 'ACC-GPRO-MED-003', 'CFEXPRESS TYPE A 160GB', 'Media Simpan', 'Sony', 'TOUGH CEA-G160T', 2, 2, 5200000, 'Per Unit', '2024-05-02', 'Siap Digunakan', 'KOTAK KARTU MEMORI', 'Galeria Production', NULL, 'Perekaman video frame rate tinggi', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(121, 'ACC-GPRO-AKS-002', 'CARD READER USB-C DUAL SLOT', 'Aksesoris Media', 'Kingston', 'Nucleum USB-C', 2, 2, 450000, 'Per Unit', '2024-02-15', 'Siap Digunakan', 'MEJA INGEST', 'Galeria Production', NULL, 'Ingest data cepat di lokasi', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(122, 'ACC-GPRO-MED-004', 'SSD EKSTERNAL PORTABLE 1TB', 'Media Simpan', 'SanDisk', 'Extreme Portable E61', 2, 2, 1650000, 'Per Unit', '2024-03-20', 'Siap Digunakan', 'TAS LAPTOP DIT', 'Galeria Production', NULL, 'Backup footage lapangan', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(123, 'ACC-GPRO-MED-005', 'SSD EKSTERNAL PORTABLE 2TB', 'Media Simpan', 'Samsung', 'T7 Shield 2TB', 2, 2, 2850000, 'Per Unit', '2024-06-11', 'Siap Digunakan', 'TAS LAPTOP DIT', 'Galeria Production', NULL, 'Master archive project on-the-go', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(124, 'ACC-GPRO-MON-001', 'MONITOR ON-CAMERA 5.5 INCH 4K', 'Monitor', 'Feelworld', 'F6 Plus V2', 2, 2, 2150000, 'Per Unit', '2024-03-12', 'Siap Digunakan', 'KOTAK MONITOR', 'Galeria Production', NULL, 'Preview framing & focus peaking', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(125, 'ACC-GPRO-AKS-003', 'SUNHOOD MONITOR 5.5 INCH', 'Aksesoris Monitor', 'Feelworld', 'SH-5.5', 2, 2, 120000, 'Per Unit', '2024-03-15', 'Siap Digunakan', 'KOTAK MONITOR', 'Galeria Production', NULL, 'Pelindung silau outdoor shoot', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(126, 'ACC-GPRO-RIG-001', 'MAGIC ARM 11 INCH SUPER CLAMP', 'Rigging', 'SmallRig', 'Crab Clamp Arm Kit', 4, 4, 380000, 'Per Unit', '2024-02-25', 'Siap Digunakan', 'KOTAK RIG', 'Galeria Production', NULL, 'Mounting monitor dan audio receiver', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(127, 'ACC-GPRO-AKS-004', 'QUICK RELEASE PLATE ARCA SWISS', 'Aksesoris Tripod', 'Sirui', 'TY-50X', 4, 4, 145000, 'Per Unit', '2024-01-20', 'Siap Digunakan', 'KOTAK TRIPOD', 'Galeria Production', NULL, 'Plate kamera ganti cepat', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(128, 'ACC-GPRO-AUD-001', 'WIRELESS MIC CLIP-ON DUAL TRANSMITTER', 'Audio', 'Hollyland', 'Lark Max Duo', 2, 2, 3900000, 'Per Unit', '2024-04-05', 'Siap Digunakan', 'KOTAK AUDIO', 'Galeria Production', NULL, 'Dokumentasi wawancara & event', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(129, 'ACC-GPRO-AUD-002', 'MIC SHOTGUN EKSTERNAL', 'Audio', 'Røde', 'VideoMic Pro+', 1, 1, 4200000, 'Per Unit', '2023-11-10', 'Siap Digunakan', 'KOTAK AUDIO', 'Galeria Production', NULL, 'Audio on-camera documentary', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(130, 'ACC-GPRO-AKS-005', 'WINDSHIELD DEADCAT MIC SHOTGUN', 'Aksesoris Audio', 'Røde', 'VMPR+ Deadcat', 1, 1, 450000, 'Per Unit', '2023-11-10', 'Siap Digunakan', 'KOTAK AUDIO', 'Galeria Production', NULL, 'Meredam derau angin outdoor', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(131, 'ACC-GPRO-AUD-003', 'HEADPHONE MONITORING STUDIO', 'Audio', 'Audio-Technica', 'ATH-M50x', 2, 2, 2100000, 'Per Unit', '2024-01-08', 'Siap Digunakan', 'MEJA AUDIO', 'Galeria Production', NULL, 'Monitoring vokal dan sound live', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(132, 'ACC-GPRO-LIG-001', 'STAND LIGHT AIR CUSHIONED 2.8M', 'Lighting Stand', 'Godox', '260CS', 6, 6, 450000, 'Per Unit', '2024-02-05', 'Siap Digunakan', 'RAK STAND LIGHTING', 'Galeria Production', NULL, 'Penyangga lampu continuous & flash', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(133, 'ACC-GPRO-GRI-001', 'C-STAND TURTLE BASE 3.3M WITH ARM', 'Grip', 'Kupo', 'CS-40M Master', 2, 2, 2300000, 'Per Unit', '2024-03-18', 'Siap Digunakan', 'RAK C-STAND', 'Galeria Production', NULL, 'Rigging berat dan overhead studio', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(134, 'ACC-GPRO-RIG-002', 'SANDBAG PEMBERAT STAND 5KG', 'Rigging', 'Jinbei', 'Double Wing Sandbag', 8, 8, 75000, 'Per Unit', '2024-02-10', 'Siap Digunakan', 'GUDANG BAWAH', 'Galeria Production', NULL, 'Penstabil tripod dan c-stand', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(135, 'ACC-GPRO-MOD-001', 'SOFTBOX OCTABOX BOWENS MOUNT 90CM', 'Modifier', 'Godox', 'SB-UE 90cm', 2, 2, 385000, 'Per Unit', '2024-01-22', 'Siap Digunakan', 'RAK SOFTBOX', 'Galeria Production', NULL, 'Diffuser portrait studio', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(136, 'ACC-GPRO-MOD-002', 'SOFTBOX LANTERN 65CM BOWENS MOUNT', 'Modifier', 'Aputure', 'Lantern 65', 1, 1, 1350000, 'Per Unit', '2024-04-18', 'Siap Digunakan', 'RAK SOFTBOX', 'Galeria Production', NULL, 'Penerangan ambient 360 derajat', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(137, 'ACC-GPRO-MOD-003', 'GRID HONEYCOMB SOFTBOX 90CM', 'Modifier', 'Godox', 'Grid 90cm', 2, 2, 160000, 'Per Unit', '2024-01-22', 'Siap Digunakan', 'RAK SOFTBOX', 'Galeria Production', NULL, 'Kontrol arah pendaran cahaya', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(138, 'ACC-GPRO-MOD-004', 'REFLECTOR 5-IN-1 FOLDABLE 110CM', 'Modifier', 'Godox', 'RFT-05 110cm', 2, 2, 195000, 'Per Unit', '2023-12-14', 'Siap Digunakan', 'LEMARI DIFFUSER', 'Galeria Production', NULL, 'Refleksi cahaya foto outdoor/indoor', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(139, 'ACC-GPRO-AKS-006', 'FLASH TRIGGER NIRKABEL TTL SONY', 'Aksesoris Lighting', 'Godox', 'XPro-S', 2, 2, 850000, 'Per Unit', '2024-02-14', 'Siap Digunakan', 'KOTAK LIGHTING', 'Galeria Production', NULL, 'Pemicu lampu flash nirkabel', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(140, 'ACC-GPRO-AKS-007', 'FLASH TRIGGER NIRKABEL TTL CANON', 'Aksesoris Lighting', 'Godox', 'XPro-C', 1, 1, 850000, 'Per Unit', '2024-02-14', 'Siap Digunakan', 'KOTAK LIGHTING', 'Galeria Production', NULL, 'Pemicu lampu flash nirkabel', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(141, 'ACC-GPRO-FIL-001', 'FILTER CPL 82MM SLIM', 'Filter Lensa', 'Hoya', 'HD Nano CPL 82mm', 2, 2, 1250000, 'Per Unit', '2024-03-25', 'Siap Digunakan', 'KOTAK FILTER', 'Galeria Production', NULL, 'Reduksi refleksi kaca & air', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(142, 'ACC-GPRO-FIL-002', 'FILTER VARIABLE ND2-ND400 82MM', 'Filter Lensa', 'Nisi', 'True Color ND-Vario', 2, 2, 1950000, 'Per Unit', '2024-03-25', 'Siap Digunakan', 'KOTAK FILTER', 'Galeria Production', NULL, 'Pengaturan exposure video terik', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(143, 'ACC-GPRO-AKS-008', 'STEP-UP RING FILTER SET (49-82MM)', 'Aksesoris Lensa', 'K&F Concept', 'Step-Up Kit 8 Ring', 2, 2, 220000, 'Per Paket', '2024-03-28', 'Siap Digunakan', 'KOTAK FILTER', 'Galeria Production', NULL, 'Adaptor filter berbagai diameter lensa', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(144, 'ACC-GPRO-AKS-009', 'LENS HOOD SONY FE 24-70MM', 'Aksesoris Lensa', 'Sony', 'ALC-SH168', 1, 1, 480000, 'Per Unit', '2023-10-05', 'Siap Digunakan', 'KOTAK LENSA', 'Galeria Production', NULL, 'Pelindung flare lensa zoom', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(145, 'ACC-GPRO-MAI-001', 'BLOWER PEMBERSIH SENSOR & LENSA', 'Maintenance', 'Giottos', 'Rocket Air Blower', 3, 3, 175000, 'Per Unit', '2024-01-10', 'Siap Digunakan', 'KOTAK CLEANING KIT', 'Galeria Production', NULL, 'Pembersih debu lensa tanpa sentuhan', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(146, 'ACC-GPRO-MAI-002', 'LENS CLEANING PEN & MICROFIBER', 'Maintenance', 'Lenspen', 'Original Cleaner Kit', 5, 5, 95000, 'Per Unit', '2024-01-10', 'Siap Digunakan', 'KOTAK CLEANING KIT', 'Galeria Production', NULL, 'Pembersih sidik jari elemen kaca', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(147, 'ACC-GPRO-MAI-003', 'SENSOR CLEANING SWAB FULL FRAME', 'Maintenance', 'VSGO', 'FF Sensor Swab 12pcs', 2, 2, 240000, 'Per Paket', '2024-04-02', 'Siap Digunakan', 'KOTAK CLEANING KIT', 'Galeria Production', NULL, 'Pembersihan basah sensor kamera', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(148, 'ACC-GPRO-RIG-003', 'BASEPLATE ARCA & ROD CLAMP 15MM', 'Rigging', 'SmallRig', 'Universal Baseplate 1798', 2, 2, 750000, 'Per Unit', '2024-04-20', 'Siap Digunakan', 'KOTAK RIG', 'Galeria Production', NULL, 'Dudukan rod follow focus & matte box', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(149, 'ACC-GPRO-RIG-004', 'CARBON FIBER ROD 15MM 20CM (PAIR)', 'Rigging', 'SmallRig', '15mm CF Rods 851', 2, 2, 280000, 'Per Paket', '2024-04-20', 'Siap Digunakan', 'KOTAK RIG', 'Galeria Production', NULL, 'Batang rig ringan penyangga fokus', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(150, 'ACC-GPRO-AKS-010', 'MINI FOLLOW FOCUS GEAR DRIVEN', 'Aksesoris Lensa', 'Tilta', 'Tiltaing Mini Follow Focus', 1, 1, 1450000, 'Per Unit', '2024-05-15', 'Siap Digunakan', 'KOTAK RIG', 'Galeria Production', NULL, 'Pengendali putaran fokus manual', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(151, 'ACC-GPRO-AKS-011', 'MATTE BOX RINGAN CARBON FIBER', 'Aksesoris Lensa', 'SmallRig', 'Mini Matte Box 3196', 1, 1, 1200000, 'Per Unit', '2024-05-15', 'Siap Digunakan', 'KOTAK RIG', 'Galeria Production', NULL, 'Penahan flare & slot filter kotak', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(152, 'ACC-GPRO-PRO-001', 'HEAVY-DUTY ROLLING HARD CASE', 'Proteksi & Transport', 'Vanguard', 'Supreme 53F Hard Case', 2, 2, 3400000, 'Per Unit', '2024-01-30', 'Siap Digunakan', 'GUDANG TRANSPORT', 'Galeria Production', NULL, 'Koper kedap cuaca mobile equipment', 1, '2026-10-31 10:11:40', '2026-10-31 10:11:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `aksesoris_units`
--

CREATE TABLE `aksesoris_units` (
  `id` int(11) NOT NULL,
  `aksesoris_id` int(11) NOT NULL,
  `kode_unit` varchar(60) NOT NULL,
  `nama_unit` varchar(255) DEFAULT NULL,
  `no_sn` varchar(100) DEFAULT NULL,
  `kondisi` enum('Siap Digunakan','Maintenance','Rusak') DEFAULT 'Siap Digunakan',
  `status_pinjam` enum('Tersedia','Dipinjam') DEFAULT 'Tersedia',
  `lokasi_unit` varchar(255) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `aksesoris_units`
--

INSERT INTO `aksesoris_units` (`id`, `aksesoris_id`, `kode_unit`, `nama_unit`, `no_sn`, `kondisi`, `status_pinjam`, `lokasi_unit`, `keterangan`, `created_at`, `updated_at`) VALUES
(157, 101, 'ACC-GPRO-BAT-001-01', 'BATERAI SONY NP-FZ100 #01', NULL, 'Maintenance', 'Dipinjam', 'KOTAK BATERAI 1', 'Baterai cadangan kamera sony', '2026-10-31 10:11:40', '2026-10-31 10:23:11'),
(158, 101, 'ACC-GPRO-BAT-001-02', 'BATERAI SONY NP-FZ100 #02', NULL, 'Maintenance', 'Tersedia', 'KOTAK BATERAI 1', 'Baterai cadangan kamera sony', '2026-10-31 10:11:40', '2026-10-31 10:23:13'),
(159, 101, 'ACC-GPRO-BAT-001-03', 'BATERAI SONY NP-FZ100 #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK BATERAI 1', 'Baterai cadangan kamera sony', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(160, 101, 'ACC-GPRO-BAT-001-04', 'BATERAI SONY NP-FZ100 #04', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK BATERAI 1', 'Baterai cadangan kamera sony', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(161, 102, 'ACC-GPRO-KAB-001-01', 'KABEL SET AUDIO XLR (ISI 10 PCS) #01', NULL, 'Maintenance', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:23:33'),
(162, 102, 'ACC-GPRO-KAB-001-02', 'KABEL SET AUDIO XLR (ISI 10 PCS) #02', NULL, 'Rusak', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:23:34'),
(163, 102, 'ACC-GPRO-KAB-001-03', 'KABEL SET AUDIO XLR (ISI 10 PCS) #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(164, 102, 'ACC-GPRO-KAB-001-04', 'KABEL SET AUDIO XLR (ISI 10 PCS) #04', NULL, 'Rusak', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:23:35'),
(165, 102, 'ACC-GPRO-KAB-001-05', 'KABEL SET AUDIO XLR (ISI 10 PCS) #05', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(166, 102, 'ACC-GPRO-KAB-001-06', 'KABEL SET AUDIO XLR (ISI 10 PCS) #06', NULL, 'Rusak', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:23:38'),
(167, 102, 'ACC-GPRO-KAB-001-07', 'KABEL SET AUDIO XLR (ISI 10 PCS) #07', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(168, 102, 'ACC-GPRO-KAB-001-08', 'KABEL SET AUDIO XLR (ISI 10 PCS) #08', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(169, 102, 'ACC-GPRO-KAB-001-09', 'KABEL SET AUDIO XLR (ISI 10 PCS) #09', NULL, 'Maintenance', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:23:39'),
(170, 102, 'ACC-GPRO-KAB-001-10', 'KABEL SET AUDIO XLR (ISI 10 PCS) #10', NULL, 'Rusak', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:23:41'),
(171, 103, 'ACC-GPRO-BAT-002-01', 'BATERAI SONY NP-FZ100 #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK BATERAI 1', 'Baterai cadangan kamera sony', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(172, 103, 'ACC-GPRO-BAT-002-02', 'BATERAI SONY NP-FZ100 #02', NULL, 'Rusak', 'Tersedia', 'KOTAK BATERAI 1', 'Baterai cadangan kamera sony', '2026-10-31 10:11:40', '2026-10-31 10:23:46'),
(173, 103, 'ACC-GPRO-BAT-002-03', 'BATERAI SONY NP-FZ100 #03', NULL, 'Maintenance', 'Tersedia', 'KOTAK BATERAI 1', 'Baterai cadangan kamera sony', '2026-10-31 10:11:40', '2026-10-31 10:23:48'),
(174, 103, 'ACC-GPRO-BAT-002-04', 'BATERAI SONY NP-FZ100 #04', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK BATERAI 1', 'Baterai cadangan kamera sony', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(175, 104, 'ACC-GPRO-KAB-002-01', 'KABEL SET AUDIO XLR (ISI 10 PCS) #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(176, 104, 'ACC-GPRO-KAB-002-02', 'KABEL SET AUDIO XLR (ISI 10 PCS) #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(177, 104, 'ACC-GPRO-KAB-002-03', 'KABEL SET AUDIO XLR (ISI 10 PCS) #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(178, 104, 'ACC-GPRO-KAB-002-04', 'KABEL SET AUDIO XLR (ISI 10 PCS) #04', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(179, 104, 'ACC-GPRO-KAB-002-05', 'KABEL SET AUDIO XLR (ISI 10 PCS) #05', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(180, 104, 'ACC-GPRO-KAB-002-06', 'KABEL SET AUDIO XLR (ISI 10 PCS) #06', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(181, 104, 'ACC-GPRO-KAB-002-07', 'KABEL SET AUDIO XLR (ISI 10 PCS) #07', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(182, 104, 'ACC-GPRO-KAB-002-08', 'KABEL SET AUDIO XLR (ISI 10 PCS) #08', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(183, 104, 'ACC-GPRO-KAB-002-09', 'KABEL SET AUDIO XLR (ISI 10 PCS) #09', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(184, 104, 'ACC-GPRO-KAB-002-10', 'KABEL SET AUDIO XLR (ISI 10 PCS) #10', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Paket 1 bundle isi 10 kabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(185, 105, 'ACC-GPRO-BAT-003-01', 'BATERAI CANON LP-E6NH #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK BATERAI 1', 'Baterai kamera eos r series', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(186, 105, 'ACC-GPRO-BAT-003-02', 'BATERAI CANON LP-E6NH #02', NULL, 'Maintenance', 'Tersedia', 'KOTAK BATERAI 1', 'Baterai kamera eos r series', '2026-10-31 10:11:40', '2026-10-31 10:23:51'),
(187, 105, 'ACC-GPRO-BAT-003-03', 'BATERAI CANON LP-E6NH #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK BATERAI 1', 'Baterai kamera eos r series', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(188, 105, 'ACC-GPRO-BAT-003-04', 'BATERAI CANON LP-E6NH #04', NULL, 'Rusak', 'Tersedia', 'KOTAK BATERAI 1', 'Baterai kamera eos r series', '2026-10-31 10:11:40', '2026-10-31 10:23:53'),
(189, 106, 'ACC-GPRO-BAT-004-01', 'BATERAI SONY NP-FW50 #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK BATERAI 2', 'Cadangan bodi cadangan a6000 series', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(190, 106, 'ACC-GPRO-BAT-004-02', 'BATERAI SONY NP-FW50 #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK BATERAI 2', 'Cadangan bodi cadangan a6000 series', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(191, 106, 'ACC-GPRO-BAT-004-03', 'BATERAI SONY NP-FW50 #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK BATERAI 2', 'Cadangan bodi cadangan a6000 series', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(192, 107, 'ACC-GPRO-CHA-001-01', 'CHARGER SONY BC-QZ1 DUAL #01', NULL, 'Siap Digunakan', 'Tersedia', 'RAK CHARGER', 'Dual slot fast charging', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(193, 107, 'ACC-GPRO-CHA-001-02', 'CHARGER SONY BC-QZ1 DUAL #02', NULL, 'Siap Digunakan', 'Tersedia', 'RAK CHARGER', 'Dual slot fast charging', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(194, 108, 'ACC-GPRO-CHA-002-01', 'CHARGER CANON LC-E6E #01', NULL, 'Siap Digunakan', 'Tersedia', 'RAK CHARGER', 'Charger baterai lp-e6', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(195, 108, 'ACC-GPRO-CHA-002-02', 'CHARGER CANON LC-E6E #02', NULL, 'Siap Digunakan', 'Tersedia', 'RAK CHARGER', 'Charger baterai lp-e6', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(196, 109, 'ACC-GPRO-BAT-005-01', 'BATERAI V-MOUNT 99WH #01', NULL, 'Siap Digunakan', 'Tersedia', 'LEMARI DAYA', 'Daya monitor dan continuous light', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(197, 109, 'ACC-GPRO-BAT-005-02', 'BATERAI V-MOUNT 99WH #02', NULL, 'Siap Digunakan', 'Tersedia', 'LEMARI DAYA', 'Daya monitor dan continuous light', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(198, 110, 'ACC-GPRO-AKS-001-01', 'V-MOUNT PLATE DUAL D-TAP #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Mounting baterai v-mount rig', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(199, 110, 'ACC-GPRO-AKS-001-02', 'V-MOUNT PLATE DUAL D-TAP #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Mounting baterai v-mount rig', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(200, 111, 'ACC-GPRO-KAB-003-01', 'KABEL HDMI TO MICRO HDMI HIGH SPEED #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK MONITOR', 'Koneksi kamera ke monitor eksternal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(201, 111, 'ACC-GPRO-KAB-003-02', 'KABEL HDMI TO MICRO HDMI HIGH SPEED #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK MONITOR', 'Koneksi kamera ke monitor eksternal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(202, 111, 'ACC-GPRO-KAB-003-03', 'KABEL HDMI TO MICRO HDMI HIGH SPEED #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK MONITOR', 'Koneksi kamera ke monitor eksternal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(203, 111, 'ACC-GPRO-KAB-003-04', 'KABEL HDMI TO MICRO HDMI HIGH SPEED #04', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK MONITOR', 'Koneksi kamera ke monitor eksternal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(204, 112, 'ACC-GPRO-KAB-004-01', 'KABEL HDMI TO FULL HDMI 5M #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK VIDEOTRON', 'Output switcher ke monitor/display', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(205, 112, 'ACC-GPRO-KAB-004-02', 'KABEL HDMI TO FULL HDMI 5M #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK VIDEOTRON', 'Output switcher ke monitor/display', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(206, 112, 'ACC-GPRO-KAB-004-03', 'KABEL HDMI TO FULL HDMI 5M #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK VIDEOTRON', 'Output switcher ke monitor/display', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(207, 113, 'ACC-GPRO-KAB-005-01', 'KABEL SDI 10M BNC #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KABEL BROADCAST', 'Transmisi sinyal kamera broadcast', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(208, 113, 'ACC-GPRO-KAB-005-02', 'KABEL SDI 10M BNC #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KABEL BROADCAST', 'Transmisi sinyal kamera broadcast', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(209, 113, 'ACC-GPRO-KAB-005-03', 'KABEL SDI 10M BNC #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KABEL BROADCAST', 'Transmisi sinyal kamera broadcast', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(210, 113, 'ACC-GPRO-KAB-005-04', 'KABEL SDI 10M BNC #04', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KABEL BROADCAST', 'Transmisi sinyal kamera broadcast', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(211, 114, 'ACC-GPRO-KAB-006-01', 'KABEL SDI 20M BNC #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KABEL BROADCAST', 'Kabel tarikan panjang outdoor/venue', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(212, 114, 'ACC-GPRO-KAB-006-02', 'KABEL SDI 20M BNC #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KABEL BROADCAST', 'Kabel tarikan panjang outdoor/venue', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(213, 115, 'ACC-GPRO-KEL-001-01', 'KABEL ROLL STOPKONTAK 4 LUBANG 25M #01', NULL, 'Siap Digunakan', 'Tersedia', 'RAK LISTRIK', 'Kabel distribusi daya venue', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(214, 115, 'ACC-GPRO-KEL-001-02', 'KABEL ROLL STOPKONTAK 4 LUBANG 25M #02', NULL, 'Siap Digunakan', 'Tersedia', 'RAK LISTRIK', 'Kabel distribusi daya venue', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(215, 115, 'ACC-GPRO-KEL-001-03', 'KABEL ROLL STOPKONTAK 4 LUBANG 25M #03', NULL, 'Siap Digunakan', 'Tersedia', 'RAK LISTRIK', 'Kabel distribusi daya venue', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(216, 116, 'ACC-GPRO-KEL-002-01', 'KABEL ROLL STOPKONTAK 4 LUBANG 50M #01', NULL, 'Siap Digunakan', 'Tersedia', 'RAK LISTRIK', 'Distribusi daya jarak jauh outdoor', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(217, 116, 'ACC-GPRO-KEL-002-02', 'KABEL ROLL STOPKONTAK 4 LUBANG 50M #02', NULL, 'Siap Digunakan', 'Tersedia', 'RAK LISTRIK', 'Distribusi daya jarak jauh outdoor', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(218, 117, 'ACC-GPRO-KEL-003-01', 'KABEL SAMBUNGAN ARDE 10M #01', NULL, 'Siap Digunakan', 'Tersedia', 'RAK LISTRIK', 'Ekstensi daya lighting studio', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(219, 117, 'ACC-GPRO-KEL-003-02', 'KABEL SAMBUNGAN ARDE 10M #02', NULL, 'Siap Digunakan', 'Tersedia', 'RAK LISTRIK', 'Ekstensi daya lighting studio', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(220, 117, 'ACC-GPRO-KEL-003-03', 'KABEL SAMBUNGAN ARDE 10M #03', NULL, 'Siap Digunakan', 'Tersedia', 'RAK LISTRIK', 'Ekstensi daya lighting studio', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(221, 117, 'ACC-GPRO-KEL-003-04', 'KABEL SAMBUNGAN ARDE 10M #04', NULL, 'Siap Digunakan', 'Tersedia', 'RAK LISTRIK', 'Ekstensi daya lighting studio', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(222, 118, 'ACC-GPRO-MED-001-01', 'SD CARD 128GB V60 EXTREME PRO #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Perekaman video 4k all-intra', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(223, 118, 'ACC-GPRO-MED-001-02', 'SD CARD 128GB V60 EXTREME PRO #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Perekaman video 4k all-intra', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(224, 118, 'ACC-GPRO-MED-001-03', 'SD CARD 128GB V60 EXTREME PRO #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Perekaman video 4k all-intra', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(225, 118, 'ACC-GPRO-MED-001-04', 'SD CARD 128GB V60 EXTREME PRO #04', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Perekaman video 4k all-intra', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(226, 118, 'ACC-GPRO-MED-001-05', 'SD CARD 128GB V60 EXTREME PRO #05', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Perekaman video 4k all-intra', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(227, 118, 'ACC-GPRO-MED-001-06', 'SD CARD 128GB V60 EXTREME PRO #06', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Perekaman video 4k all-intra', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(228, 119, 'ACC-GPRO-MED-002-01', 'SD CARD 64GB EXTREME PRO #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Penyimpanan foto portrait formal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(229, 119, 'ACC-GPRO-MED-002-02', 'SD CARD 64GB EXTREME PRO #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Penyimpanan foto portrait formal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(230, 119, 'ACC-GPRO-MED-002-03', 'SD CARD 64GB EXTREME PRO #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Penyimpanan foto portrait formal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(231, 119, 'ACC-GPRO-MED-002-04', 'SD CARD 64GB EXTREME PRO #04', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Penyimpanan foto portrait formal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(232, 119, 'ACC-GPRO-MED-002-05', 'SD CARD 64GB EXTREME PRO #05', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Penyimpanan foto portrait formal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(233, 119, 'ACC-GPRO-MED-002-06', 'SD CARD 64GB EXTREME PRO #06', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Penyimpanan foto portrait formal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(234, 119, 'ACC-GPRO-MED-002-07', 'SD CARD 64GB EXTREME PRO #07', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Penyimpanan foto portrait formal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(235, 119, 'ACC-GPRO-MED-002-08', 'SD CARD 64GB EXTREME PRO #08', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Penyimpanan foto portrait formal', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(236, 120, 'ACC-GPRO-MED-003-01', 'CFEXPRESS TYPE A 160GB #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Perekaman video frame rate tinggi', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(237, 120, 'ACC-GPRO-MED-003-02', 'CFEXPRESS TYPE A 160GB #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK KARTU MEMORI', 'Perekaman video frame rate tinggi', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(238, 121, 'ACC-GPRO-AKS-002-01', 'CARD READER USB-C DUAL SLOT #01', NULL, 'Siap Digunakan', 'Tersedia', 'MEJA INGEST', 'Ingest data cepat di lokasi', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(239, 121, 'ACC-GPRO-AKS-002-02', 'CARD READER USB-C DUAL SLOT #02', NULL, 'Siap Digunakan', 'Tersedia', 'MEJA INGEST', 'Ingest data cepat di lokasi', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(240, 122, 'ACC-GPRO-MED-004-01', 'SSD EKSTERNAL PORTABLE 1TB #01', NULL, 'Siap Digunakan', 'Tersedia', 'TAS LAPTOP DIT', 'Backup footage lapangan', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(241, 122, 'ACC-GPRO-MED-004-02', 'SSD EKSTERNAL PORTABLE 1TB #02', NULL, 'Siap Digunakan', 'Tersedia', 'TAS LAPTOP DIT', 'Backup footage lapangan', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(242, 123, 'ACC-GPRO-MED-005-01', 'SSD EKSTERNAL PORTABLE 2TB #01', NULL, 'Siap Digunakan', 'Tersedia', 'TAS LAPTOP DIT', 'Master archive project on-the-go', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(243, 123, 'ACC-GPRO-MED-005-02', 'SSD EKSTERNAL PORTABLE 2TB #02', NULL, 'Siap Digunakan', 'Tersedia', 'TAS LAPTOP DIT', 'Master archive project on-the-go', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(244, 124, 'ACC-GPRO-MON-001-01', 'MONITOR ON-CAMERA 5.5 INCH 4K #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK MONITOR', 'Preview framing & focus peaking', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(245, 124, 'ACC-GPRO-MON-001-02', 'MONITOR ON-CAMERA 5.5 INCH 4K #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK MONITOR', 'Preview framing & focus peaking', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(246, 125, 'ACC-GPRO-AKS-003-01', 'SUNHOOD MONITOR 5.5 INCH #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK MONITOR', 'Pelindung silau outdoor shoot', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(247, 125, 'ACC-GPRO-AKS-003-02', 'SUNHOOD MONITOR 5.5 INCH #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK MONITOR', 'Pelindung silau outdoor shoot', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(248, 126, 'ACC-GPRO-RIG-001-01', 'MAGIC ARM 11 INCH SUPER CLAMP #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Mounting monitor dan audio receiver', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(249, 126, 'ACC-GPRO-RIG-001-02', 'MAGIC ARM 11 INCH SUPER CLAMP #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Mounting monitor dan audio receiver', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(250, 126, 'ACC-GPRO-RIG-001-03', 'MAGIC ARM 11 INCH SUPER CLAMP #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Mounting monitor dan audio receiver', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(251, 126, 'ACC-GPRO-RIG-001-04', 'MAGIC ARM 11 INCH SUPER CLAMP #04', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Mounting monitor dan audio receiver', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(252, 127, 'ACC-GPRO-AKS-004-01', 'QUICK RELEASE PLATE ARCA SWISS #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK TRIPOD', 'Plate kamera ganti cepat', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(253, 127, 'ACC-GPRO-AKS-004-02', 'QUICK RELEASE PLATE ARCA SWISS #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK TRIPOD', 'Plate kamera ganti cepat', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(254, 127, 'ACC-GPRO-AKS-004-03', 'QUICK RELEASE PLATE ARCA SWISS #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK TRIPOD', 'Plate kamera ganti cepat', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(255, 127, 'ACC-GPRO-AKS-004-04', 'QUICK RELEASE PLATE ARCA SWISS #04', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK TRIPOD', 'Plate kamera ganti cepat', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(256, 128, 'ACC-GPRO-AUD-001-01', 'WIRELESS MIC CLIP-ON DUAL TRANSMITTER #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Dokumentasi wawancara & event', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(257, 128, 'ACC-GPRO-AUD-001-02', 'WIRELESS MIC CLIP-ON DUAL TRANSMITTER #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Dokumentasi wawancara & event', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(258, 129, 'ACC-GPRO-AUD-002-01', 'MIC SHOTGUN EKSTERNAL', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Audio on-camera documentary', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(259, 130, 'ACC-GPRO-AKS-005-01', 'WINDSHIELD DEADCAT MIC SHOTGUN', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK AUDIO', 'Meredam derau angin outdoor', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(260, 131, 'ACC-GPRO-AUD-003-01', 'HEADPHONE MONITORING STUDIO #01', NULL, 'Siap Digunakan', 'Tersedia', 'MEJA AUDIO', 'Monitoring vokal dan sound live', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(261, 131, 'ACC-GPRO-AUD-003-02', 'HEADPHONE MONITORING STUDIO #02', NULL, 'Siap Digunakan', 'Tersedia', 'MEJA AUDIO', 'Monitoring vokal dan sound live', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(262, 132, 'ACC-GPRO-LIG-001-01', 'STAND LIGHT AIR CUSHIONED 2.8M #01', NULL, 'Siap Digunakan', 'Tersedia', 'RAK STAND LIGHTING', 'Penyangga lampu continuous & flash', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(263, 132, 'ACC-GPRO-LIG-001-02', 'STAND LIGHT AIR CUSHIONED 2.8M #02', NULL, 'Siap Digunakan', 'Tersedia', 'RAK STAND LIGHTING', 'Penyangga lampu continuous & flash', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(264, 132, 'ACC-GPRO-LIG-001-03', 'STAND LIGHT AIR CUSHIONED 2.8M #03', NULL, 'Siap Digunakan', 'Tersedia', 'RAK STAND LIGHTING', 'Penyangga lampu continuous & flash', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(265, 132, 'ACC-GPRO-LIG-001-04', 'STAND LIGHT AIR CUSHIONED 2.8M #04', NULL, 'Siap Digunakan', 'Tersedia', 'RAK STAND LIGHTING', 'Penyangga lampu continuous & flash', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(266, 132, 'ACC-GPRO-LIG-001-05', 'STAND LIGHT AIR CUSHIONED 2.8M #05', NULL, 'Siap Digunakan', 'Tersedia', 'RAK STAND LIGHTING', 'Penyangga lampu continuous & flash', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(267, 132, 'ACC-GPRO-LIG-001-06', 'STAND LIGHT AIR CUSHIONED 2.8M #06', NULL, 'Siap Digunakan', 'Tersedia', 'RAK STAND LIGHTING', 'Penyangga lampu continuous & flash', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(268, 133, 'ACC-GPRO-GRI-001-01', 'C-STAND TURTLE BASE 3.3M WITH ARM #01', NULL, 'Siap Digunakan', 'Tersedia', 'RAK C-STAND', 'Rigging berat dan overhead studio', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(269, 133, 'ACC-GPRO-GRI-001-02', 'C-STAND TURTLE BASE 3.3M WITH ARM #02', NULL, 'Siap Digunakan', 'Tersedia', 'RAK C-STAND', 'Rigging berat dan overhead studio', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(270, 134, 'ACC-GPRO-RIG-002-01', 'SANDBAG PEMBERAT STAND 5KG #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG BAWAH', 'Penstabil tripod dan c-stand', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(271, 134, 'ACC-GPRO-RIG-002-02', 'SANDBAG PEMBERAT STAND 5KG #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG BAWAH', 'Penstabil tripod dan c-stand', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(272, 134, 'ACC-GPRO-RIG-002-03', 'SANDBAG PEMBERAT STAND 5KG #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG BAWAH', 'Penstabil tripod dan c-stand', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(273, 134, 'ACC-GPRO-RIG-002-04', 'SANDBAG PEMBERAT STAND 5KG #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG BAWAH', 'Penstabil tripod dan c-stand', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(274, 134, 'ACC-GPRO-RIG-002-05', 'SANDBAG PEMBERAT STAND 5KG #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG BAWAH', 'Penstabil tripod dan c-stand', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(275, 134, 'ACC-GPRO-RIG-002-06', 'SANDBAG PEMBERAT STAND 5KG #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG BAWAH', 'Penstabil tripod dan c-stand', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(276, 134, 'ACC-GPRO-RIG-002-07', 'SANDBAG PEMBERAT STAND 5KG #07', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG BAWAH', 'Penstabil tripod dan c-stand', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(277, 134, 'ACC-GPRO-RIG-002-08', 'SANDBAG PEMBERAT STAND 5KG #08', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG BAWAH', 'Penstabil tripod dan c-stand', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(278, 135, 'ACC-GPRO-MOD-001-01', 'SOFTBOX OCTABOX BOWENS MOUNT 90CM #01', NULL, 'Siap Digunakan', 'Tersedia', 'RAK SOFTBOX', 'Diffuser portrait studio', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(279, 135, 'ACC-GPRO-MOD-001-02', 'SOFTBOX OCTABOX BOWENS MOUNT 90CM #02', NULL, 'Siap Digunakan', 'Tersedia', 'RAK SOFTBOX', 'Diffuser portrait studio', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(280, 136, 'ACC-GPRO-MOD-002-01', 'SOFTBOX LANTERN 65CM BOWENS MOUNT', NULL, 'Siap Digunakan', 'Tersedia', 'RAK SOFTBOX', 'Penerangan ambient 360 derajat', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(281, 137, 'ACC-GPRO-MOD-003-01', 'GRID HONEYCOMB SOFTBOX 90CM #01', NULL, 'Siap Digunakan', 'Tersedia', 'RAK SOFTBOX', 'Kontrol arah pendaran cahaya', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(282, 137, 'ACC-GPRO-MOD-003-02', 'GRID HONEYCOMB SOFTBOX 90CM #02', NULL, 'Siap Digunakan', 'Tersedia', 'RAK SOFTBOX', 'Kontrol arah pendaran cahaya', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(283, 138, 'ACC-GPRO-MOD-004-01', 'REFLECTOR 5-IN-1 FOLDABLE 110CM #01', NULL, 'Siap Digunakan', 'Tersedia', 'LEMARI DIFFUSER', 'Refleksi cahaya foto outdoor/indoor', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(284, 138, 'ACC-GPRO-MOD-004-02', 'REFLECTOR 5-IN-1 FOLDABLE 110CM #02', NULL, 'Siap Digunakan', 'Tersedia', 'LEMARI DIFFUSER', 'Refleksi cahaya foto outdoor/indoor', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(285, 139, 'ACC-GPRO-AKS-006-01', 'FLASH TRIGGER NIRKABEL TTL SONY #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK LIGHTING', 'Pemicu lampu flash nirkabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(286, 139, 'ACC-GPRO-AKS-006-02', 'FLASH TRIGGER NIRKABEL TTL SONY #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK LIGHTING', 'Pemicu lampu flash nirkabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(287, 140, 'ACC-GPRO-AKS-007-01', 'FLASH TRIGGER NIRKABEL TTL CANON', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK LIGHTING', 'Pemicu lampu flash nirkabel', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(288, 141, 'ACC-GPRO-FIL-001-01', 'FILTER CPL 82MM SLIM #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK FILTER', 'Reduksi refleksi kaca & air', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(289, 141, 'ACC-GPRO-FIL-001-02', 'FILTER CPL 82MM SLIM #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK FILTER', 'Reduksi refleksi kaca & air', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(290, 142, 'ACC-GPRO-FIL-002-01', 'FILTER VARIABLE ND2-ND400 82MM #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK FILTER', 'Pengaturan exposure video terik', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(291, 142, 'ACC-GPRO-FIL-002-02', 'FILTER VARIABLE ND2-ND400 82MM #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK FILTER', 'Pengaturan exposure video terik', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(292, 143, 'ACC-GPRO-AKS-008-01', 'STEP-UP RING FILTER SET (49-82MM) #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK FILTER', 'Adaptor filter berbagai diameter lensa', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(293, 143, 'ACC-GPRO-AKS-008-02', 'STEP-UP RING FILTER SET (49-82MM) #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK FILTER', 'Adaptor filter berbagai diameter lensa', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(294, 144, 'ACC-GPRO-AKS-009-01', 'LENS HOOD SONY FE 24-70MM', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK LENSA', 'Pelindung flare lensa zoom', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(295, 145, 'ACC-GPRO-MAI-001-01', 'BLOWER PEMBERSIH SENSOR & LENSA #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK CLEANING KIT', 'Pembersih debu lensa tanpa sentuhan', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(296, 145, 'ACC-GPRO-MAI-001-02', 'BLOWER PEMBERSIH SENSOR & LENSA #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK CLEANING KIT', 'Pembersih debu lensa tanpa sentuhan', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(297, 145, 'ACC-GPRO-MAI-001-03', 'BLOWER PEMBERSIH SENSOR & LENSA #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK CLEANING KIT', 'Pembersih debu lensa tanpa sentuhan', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(298, 146, 'ACC-GPRO-MAI-002-01', 'LENS CLEANING PEN & MICROFIBER #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK CLEANING KIT', 'Pembersih sidik jari elemen kaca', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(299, 146, 'ACC-GPRO-MAI-002-02', 'LENS CLEANING PEN & MICROFIBER #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK CLEANING KIT', 'Pembersih sidik jari elemen kaca', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(300, 146, 'ACC-GPRO-MAI-002-03', 'LENS CLEANING PEN & MICROFIBER #03', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK CLEANING KIT', 'Pembersih sidik jari elemen kaca', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(301, 146, 'ACC-GPRO-MAI-002-04', 'LENS CLEANING PEN & MICROFIBER #04', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK CLEANING KIT', 'Pembersih sidik jari elemen kaca', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(302, 146, 'ACC-GPRO-MAI-002-05', 'LENS CLEANING PEN & MICROFIBER #05', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK CLEANING KIT', 'Pembersih sidik jari elemen kaca', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(303, 147, 'ACC-GPRO-MAI-003-01', 'SENSOR CLEANING SWAB FULL FRAME #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK CLEANING KIT', 'Pembersihan basah sensor kamera', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(304, 147, 'ACC-GPRO-MAI-003-02', 'SENSOR CLEANING SWAB FULL FRAME #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK CLEANING KIT', 'Pembersihan basah sensor kamera', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(305, 148, 'ACC-GPRO-RIG-003-01', 'BASEPLATE ARCA & ROD CLAMP 15MM #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Dudukan rod follow focus & matte box', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(306, 148, 'ACC-GPRO-RIG-003-02', 'BASEPLATE ARCA & ROD CLAMP 15MM #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Dudukan rod follow focus & matte box', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(307, 149, 'ACC-GPRO-RIG-004-01', 'CARBON FIBER ROD 15MM 20CM (PAIR) #01', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Batang rig ringan penyangga fokus', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(308, 149, 'ACC-GPRO-RIG-004-02', 'CARBON FIBER ROD 15MM 20CM (PAIR) #02', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Batang rig ringan penyangga fokus', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(309, 150, 'ACC-GPRO-AKS-010-01', 'MINI FOLLOW FOCUS GEAR DRIVEN', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Pengendali putaran fokus manual', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(310, 151, 'ACC-GPRO-AKS-011-01', 'MATTE BOX RINGAN CARBON FIBER', NULL, 'Siap Digunakan', 'Tersedia', 'KOTAK RIG', 'Penahan flare & slot filter kotak', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(311, 152, 'ACC-GPRO-PRO-001-01', 'HEAVY-DUTY ROLLING HARD CASE #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG TRANSPORT', 'Koper kedap cuaca mobile equipment', '2026-10-31 10:11:40', '2026-10-31 10:11:40'),
(312, 152, 'ACC-GPRO-PRO-001-02', 'HEAVY-DUTY ROLLING HARD CASE #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG TRANSPORT', 'Koper kedap cuaca mobile equipment', '2026-10-31 10:11:40', '2026-10-31 10:11:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `assets`
--

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `kode_aset` varchar(50) NOT NULL,
  `nama_aset` varchar(255) NOT NULL,
  `pengguna` varchar(150) DEFAULT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `merek` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `no_sn` varchar(100) DEFAULT NULL,
  `spesifikasi` text DEFAULT NULL,
  `lokasi_aset` varchar(255) DEFAULT NULL,
  `jenis_aset` enum('Galeria Studio','Galeria Production') DEFAULT NULL,
  `kondisi` enum('Siap Digunakan','Maintenance','Rusak') DEFAULT 'Siap Digunakan',
  `unit` varchar(100) DEFAULT NULL,
  `gambar` varchar(255) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `jumlah` int(11) DEFAULT NULL,
  `harga_aset` decimal(15,2) DEFAULT NULL,
  `tipe_harga` enum('Per Unit','Per Paket') NOT NULL DEFAULT 'Per Unit',
  `jumlah_total` int(11) DEFAULT NULL,
  `tanggal_pembelian` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `assets`
--

INSERT INTO `assets` (`id`, `kode_aset`, `nama_aset`, `pengguna`, `kategori`, `merek`, `model`, `no_sn`, `spesifikasi`, `lokasi_aset`, `jenis_aset`, `kondisi`, `unit`, `gambar`, `keterangan`, `created_at`, `updated_at`, `jumlah`, `harga_aset`, `tipe_harga`, `jumlah_total`, `tanggal_pembelian`, `user_id`) VALUES
(197, 'AST-GPRO-CAM-001', 'Sony alpha 7 iii body', NULL, 'Kamera', 'Sony', 'ILCE-7M3', 'SN-98765432', '24.2 mp, 4k hdr, full-frame', 'LEMARI KAMERA A', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Lengkap dengan strap & charger', '2026-10-31 10:11:24', '2026-10-31 10:24:03', 0, 25000000.00, 'Per Unit', 1, '2024-01-15', 1),
(198, 'AST-GPRO-VID-001', 'Videotron p3.9 indoor (1 box 6 kabinet)', NULL, 'Videotron', 'Absen', 'P3.9', NULL, '1 box isi 6 kabinet, harga 25 jt per paket box', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-10-31 10:11:24', '2026-10-31 10:24:14', 3, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(199, 'AST-GPRO-CAM-002', 'Sony fx3 cinema line', NULL, 'Kamera', 'Sony', 'ILME-FX3', 'SN-FX301982', '12.1 mp full-frame, cooling fan, xlr top handle', 'LEMARI KAMERA A', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk top handle xlr audio unit', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 58.00, 'Per Unit', 1, '2024-03-05', 1),
(200, 'AST-GPRO-CAM-003', 'Blackmagic pocket cinema 6k pro', NULL, 'Kamera', 'Blackmagic', 'BMPCC 6K Pro', 'SN-BM6K9021', 'Super 35 sensor, gen 5 color, built-in nd', 'LEMARI KAMERA B', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk cage smallrig & ssd holder', '2026-10-31 10:11:24', '2026-10-31 10:24:21', 0, 38.50, 'Per Unit', 1, '2023-11-12', 1),
(201, 'AST-GPRO-CAM-004', 'Canon eos r6 mark ii', NULL, 'Kamera', 'Canon', 'EOS R6 Mk II', 'SN-CN672109', '24.2 mp, 6k raw via hdmi, dual pixel af', 'LEMARI KAMERA B', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Include adapter ef-eos r', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 36.00, 'Per Unit', 1, '2024-04-18', 1),
(202, 'AST-GPRO-LEN-001', 'Lensa sony fe 24-70mm f/2.8 gm ii', NULL, 'Lensa', 'Sony', 'SEL2470GM2', 'SN-LNS88102', 'Standard zoom g master, filter 82mm', 'LEMARI LENSA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Lengkap hood & pouch', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 31.00, 'Per Unit', 1, '2024-01-15', 1),
(203, 'AST-GPRO-LEN-002', 'Lensa sony fe 70-200mm f/2.8 gm oss ii', NULL, 'Lensa', 'Sony', 'SEL70200GM2', 'SN-LNS99231', 'Telephoto zoom, optical steadyshot', 'LEMARI LENSA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk tripod collar mount', '2026-10-31 10:11:24', '2026-10-31 10:24:25', 0, 38.00, 'Per Unit', 1, '2024-02-01', 1),
(204, 'AST-GPRO-LEN-003', 'Lensa sony fe 16-35mm f/2.8 gm', NULL, 'Lensa', 'Sony', 'SEL1635GM', 'SN-LNS44012', 'Ultra wide zoom g master', 'LEMARI LENSA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Filter uv terpasang', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 26.50, 'Per Unit', 1, '2023-09-10', 1),
(205, 'AST-GPRO-LEN-004', 'Lensa sony fe 50mm f/1.2 gm', NULL, 'Lensa', 'Sony', 'SEL50F12GM', 'SN-LNS50123', 'Prime lens, aperture f/1.2, e-mount', 'LEMARI LENSA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Khusus beauty & low-light shoot', '2026-10-31 10:11:24', '2026-10-31 10:24:28', 0, 28.00, 'Per Unit', 1, '2024-05-14', 1),
(206, 'AST-GPRO-LEN-005', 'Lensa canon rf 24-70mm f/2.8l is usm', NULL, 'Lensa', 'Canon', 'RF 24-70 F2.8', 'SN-CNL89120', 'L-series zoom, is 5 stops', 'LEMARI LENSA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Lengkap hood ew-88e', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 34.50, 'Per Unit', 1, '2024-04-18', 1),
(207, 'AST-GPRO-STA-001', 'Gimbal dji rs 3 pro combo', NULL, 'Stabilizer', 'DJI', 'RS 3 Pro', 'SN-DJI77102', 'Carbon fiber arms, payload 4.5kg', 'RAK GRIP 1', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Lengkap lidar & focus motor', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 2, 14.50, 'Per Unit', 2, '2023-10-08', 1),
(208, 'AST-GPRO-STA-002', 'Gimbal dji rs 2', NULL, 'Stabilizer', 'DJI', 'RS 2', 'SN-DJI55190', 'Carbon fiber, payload 4.5kg', 'RAK GRIP 1', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Digunakan sebagai unit backup', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 9.50, 'Per Unit', 1, '2022-08-15', 1),
(209, 'AST-GPRO-GRI-001', 'Tripod video manfrotto 504hd', NULL, 'Grip & Support', 'Manfrotto', '504HD + 546GB', 'SN-MNF11029', 'Fluid video head, ground spreader, max 12kg', 'RAK GRIP 2', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Lengkap handle pan bar ganda', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 3, 12.00, 'Per Unit', 3, '2023-06-20', 1),
(210, 'AST-GPRO-GRI-002', 'Tripod e-image eg05a2', NULL, 'Grip & Support', 'E-Image', 'EG05A2', 'SN-EIM33401', '75mm bowl, dual stage aluminum legs', 'RAK GRIP 2', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Unit operasional liputan umum', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 2, 6.50, 'Per Unit', 2, '2023-07-11', 1),
(211, 'AST-GPRO-GRI-003', 'Slider kamera konova k5 120cm motorized', NULL, 'Grip & Support', 'Konova', 'K5 120cm', 'SN-KNV66712', '120cm carbon slider + smart motion controller', 'RAK GRIP 2', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk 2 baterai np-f970', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 8.50, 'Per Unit', 1, '2023-05-19', 1),
(212, 'AST-GPRO-DRO-001', 'Drone dji mavic 3 pro cine combo', NULL, 'Drone', 'DJI', 'Mavic 3 Pro Cine', 'SN-DJIM3PC01', 'Triple camera hasselblad, apple prores, 1tb ssd', 'LEMARI DRONE', 'Galeria Production', 'Siap Digunakan', NULL, NULL, '3 baterai, rc pro controller, nd filters', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 62.00, 'Per Unit', 1, '2024-03-01', 1),
(213, 'AST-GPRO-WIR-001', 'Wireless video hollyland cosmo c1', NULL, 'Wireless Video', 'Hollyland', 'Cosmo C1', 'SN-HLCC1908', 'Sdi & hdmi, jangkauan 300m, latensi 40ms', 'RAK WIRELESS', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Transmitter & receiver set', '2026-10-31 10:11:24', '2026-10-31 10:25:45', 1, 13.80, 'Per Unit', 2, '2023-12-05', 1),
(214, 'AST-GPRO-MON-001', 'Monitor sutradara atomos sumo 19se', NULL, 'Monitor', 'Atomos', 'Sumo 19SE', 'SN-ATM19002', '19\" hdr 1200nit, prores raw recorder', 'RAK MONITOR', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Hardcase flight case + c-stand mount', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 32.00, 'Per Unit', 1, '2024-01-22', 1),
(215, 'AST-GPRO-MON-002', 'Monitor on-camera feelworld lut7', NULL, 'Monitor', 'Feelworld', 'LUT7', 'SN-FW700192', '7\" 2200nit daylight viewable, 4k hdmi', 'RAK MONITOR', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Terpasang cage & sunhood', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 3, 3.50, 'Per Unit', 3, '2023-08-30', 1),
(216, 'AST-GPRO-AUD-001', 'Wireless mic sennheiser ew 100 g4', NULL, 'Audio', 'Sennheiser', 'EW 100 G4-ME2', 'SN-SNH44109', 'Uhf wireless system, omni me2 clip-on', 'LEMARI AUDIO', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Dilengkapi 8 pcs eneloop pro aa', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 4, 9.80, 'Per Unit', 4, '2023-04-12', 1),
(217, 'AST-GPRO-AUD-002', 'Wireless mic hollyland lark max duo', NULL, 'Audio', 'Hollyland', 'Lark Max', 'SN-HLM99812', '2 tx + 1 rx, 8gb internal recording, enc', 'LEMARI AUDIO', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Lengkap charging case & magnet mount', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 2, 4.20, 'Per Unit', 2, '2024-02-14', 1),
(218, 'AST-GPRO-AUD-003', 'Shotgun mic sennheiser mkh 416', NULL, 'Audio', 'Sennheiser', 'MKH 416-P48', 'SN-MKH41602', 'Supercardioid shotgun, phantom power 48v', 'LEMARI AUDIO', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk rycote blimp & windshield', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 2, 15.50, 'Per Unit', 2, '2023-03-10', 1),
(219, 'AST-GPRO-AUD-004', 'Audio field recorder zoom f8n pro', NULL, 'Audio', 'Zoom', 'F8n Pro', 'SN-ZF8N8819', '8-channel / 10-track, 32-bit float recording', 'LEMARI AUDIO', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Bag k-tek + hirose power cable', '2026-10-31 10:11:24', '2026-10-31 10:26:06', 0, 17.00, 'Per Unit', 1, '2023-09-02', 1),
(220, 'AST-GPRO-AUD-005', 'Boom pole rode boompole pro', NULL, 'Audio Support', 'Rode', 'Boompole Pro', 'SN-RDBP0012', 'Carbon fiber 3.0m, ultra lightweight', 'RAK GRIP 1', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk kabel internal xlr coiled', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 2, 3.60, 'Per Unit', 2, '2023-03-10', 1),
(221, 'AST-GPRO-AUD-006', 'Digital audio mixer behringer x32', NULL, 'Audio', 'Behringer', 'X32 Compact', 'SN-BX320912', '40-input, 25-bus, 16 midas preamps', 'RUANG AUDIO FOH', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk flight case roda', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 29.50, 'Per Unit', 1, '2023-01-20', 1),
(222, 'AST-GPRO-AUD-007', 'Digital snake stage box behringer s16', NULL, 'Audio', 'Behringer', 'S16', 'SN-BS168801', '16 remote-controllable midas mic preamps', 'RUANG AUDIO FOH', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Terhubung via kabel cat5e ethercon 50m', '2026-10-31 10:11:24', '2026-10-31 10:26:11', 1, 13.00, 'Per Unit', 2, '2023-01-20', 1),
(223, 'AST-GPRO-SOU-001', 'Active speaker yamaha dxr15 mkii', NULL, 'Sound System', 'Yamaha', 'DXR15mkII', 'SN-YMH15003', '15\" 2-way powered loudspeaker, 1100w', 'GUDANG AUDIO', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk cover pelindung & stand speaker', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 4, 14.50, 'Per Unit', 4, '2023-06-14', 1),
(224, 'AST-GPRO-SOU-002', 'Active subwoofer yamaha dxs18xlf', NULL, 'Sound System', 'Yamaha', 'DXS18XLF', 'SN-YMH18991', '18\" powered subwoofer, 1600w class-d, 136db', 'GUDANG AUDIO', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk roda castor heavy-duty', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 2, 26.00, 'Per Unit', 2, '2023-06-14', 1),
(225, 'AST-GPRO-LIG-001', 'Lampu studio aputure ls 600d pro', NULL, 'Lighting', 'Aputure', 'LS 600d Pro', 'SN-AP600D01', '600w daylight cob, v-mount, weatherproof', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Rolling hard case + standard reflector', '2026-10-31 10:11:24', '2026-10-31 10:26:01', 0, 29.00, 'Per Unit', 2, '2023-11-25', 1),
(226, 'AST-GPRO-LIG-002', 'Lampu studio aputure ls 300x bi-color', NULL, 'Lighting', 'Aputure', 'LS 300x', 'SN-AP300X11', '300w bi-color 2700k-6500k, bowens mount', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Pouch bag + control box', '2026-10-31 10:11:24', '2026-10-31 10:26:14', 1, 16.50, 'Per Unit', 2, '2023-05-18', 1),
(227, 'AST-GPRO-LIG-003', 'Lampu tube nanlite pavotube ii 30x 4-kit', NULL, 'Lighting', 'Nanlite', 'Pavotube II 30X', 'SN-NVT30X4K', 'Paket 4 unit tube rgbww 4ft, internal battery', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk padded bag & power adapter set', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 22.00, 'Per Paket', 1, '2024-01-10', 1),
(228, 'AST-GPRO-LIG-004', 'Softbox aputure light dome 150', NULL, 'Lighting Mod', 'Aputure', 'Light Dome 150', 'SN-APLD1501', '150cm octagonal softbox, honeycomb grid', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Bowens mount quick-setup', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 2, 3.80, 'Per Unit', 2, '2023-11-25', 1),
(229, 'AST-GPRO-LIG-005', 'Lantern softbox aputure lantern 90', NULL, 'Lighting Mod', 'Aputure', 'Lantern 90', 'SN-APLT9002', '90cm omnidirectional soft light, skirt 4-section', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Bowens mount', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 2, 2.10, 'Per Unit', 2, '2023-11-25', 1),
(230, 'AST-GPRO-GRI-004', 'C-stand kupo 40\" grip arm kit', NULL, 'Grip & Support', 'Kupo', 'CS-40MK', 'SN-KP400911', 'Master c-stand + turtle base + 40\" extension arm', 'RAK GRIP 2', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk sandbag 10kg', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 6, 2.90, 'Per Unit', 6, '2023-04-05', 1),
(231, 'AST-GPRO-LIG-006', 'Par led 54x3w rgbw outdoor', NULL, 'Lighting Event', 'StageLight', 'PAR543W', 'SN-PL540023', '54x3w led rgbw, dmx512, waterproof ip65', 'GUDANG STAGE', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 16, 1.10, 'Per Unit', 16, '2023-02-17', 1),
(232, 'AST-GPRO-LIG-007', 'Moving head beam 230w 7r', NULL, 'Lighting Event', 'NightSun', 'Beam 230', 'SN-MB23001', 'Lampu osram 7r, 14 warna + gobo, dmx', 'GUDANG STAGE', 'Galeria Production', 'Siap Digunakan', NULL, NULL, '2 flightcase (isi 2 moving head/box)', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 4, 4.80, 'Per Unit', 4, '2023-07-22', 1),
(233, 'AST-GPRO-LIG-008', 'Dmx lighting controller tiger touch ii', NULL, 'Lighting Event', 'Avolites Replica', 'TT2 Pro', 'SN-AVTT0911', '4 dmx output, layar sentuh 15.6\", titan os', 'RUANG CONTROL', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Flight case + cover anti debu', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 24.50, 'Per Unit', 1, '2023-08-01', 1),
(234, 'AST-GPRO-VID-002', 'Videotron p3.9 indoor (1 box 6 kabinet)', NULL, 'Videotron', 'Absen', 'P3.9', 'SN-VTN39001', '1 box isi 6 kabinet (500x500mm), die-cast alu', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Dihitung rp 4.166.667 / kabinet saat disewa', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 6, 25.00, 'Per Paket', 6, '2024-03-20', 1),
(235, 'AST-GPRO-VID-003', 'Videotron p3.9 indoor tambahan (1 box 6 kabinet)', NULL, 'Videotron', 'Absen', 'P3.9', 'SN-VTN39002', '1 box isi 6 kabinet (500x500mm), refresh 3840hz', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Seri batch display sama dengan aset #38', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 6, 25.00, 'Per Paket', 6, '2024-03-20', 1),
(236, 'AST-GPRO-VID-004', 'Video processor novastar vx4s', NULL, 'Videotron', 'NovaStar', 'VX4S', 'SN-NVX40019', 'All-in-one controller, 4 port ethernet, max 2.3m px', 'RUANG CONTROL', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Input hdmi/dvi/sdi/vga/cvbs', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 2, 11.50, 'Per Unit', 2, '2024-03-22', 1),
(237, 'AST-GPRO-BRO-001', 'Video switcher blackmagic atem mini extreme iso', NULL, 'Broadcast', 'Blackmagic', 'ATEM Mini Ext ISO', 'SN-BMATEM91', '8 hdmi in, 2 hdmi out, 5-stream recording engine', 'RUANG STREAMING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Hardcase pelican custom insert', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 19.50, 'Per Unit', 1, '2023-10-15', 1),
(238, 'AST-GPRO-BRO-002', 'Video switcher blackmagic atem 1 m/e constellation hd', NULL, 'Broadcast', 'Blackmagic', 'ATEM 1 M/E HD', 'SN-BM1ME001', '10 sdi in 3g-sdi, 6 sdi out, fairlight audio', 'RACK BROADCAST', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Terpasang di rackmount 1u', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 23.00, 'Per Unit', 1, '2024-02-28', 1),
(239, 'AST-GPRO-INT-001', 'Intercom wireless hollyland solidcom c1-6s', NULL, 'Intercom', 'Hollyland', 'Solidcom C1', 'SN-HLC16S02', 'Sistem full-duplex 1 master + 5 remote headset', 'LEMARI AUDIO', 'Galeria Production', 'Siap Digunakan', NULL, NULL, '12 baterai + multi-slot charger', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 21.00, 'Per Paket', 1, '2023-11-05', 1),
(240, 'AST-GPRO-BRO-003', 'Capture card elgato cam link 4k', NULL, 'Broadcast', 'Elgato', 'Cam Link 4K', 'SN-ELG00192', 'Usb 3.0 to hdmi 4k 30fps / 1080p 60fps', 'RUANG STREAMING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Include kabel ekstensi usb', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 4, 1.85, 'Per Unit', 4, '2023-05-10', 1),
(241, 'AST-GPRO-KOM-001', 'Laptop live streaming asus rog strix scar 16', NULL, 'Komputer/IT', 'ASUS', 'G634JZ', 'SN-ASROG8812', 'Intel i9-13980hx, 32gb ddr5, rtx 4080 12gb', 'RUANG STREAMING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Khusus vmix production & rendering', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 2, 42.00, 'Per Unit', 2, '2024-01-08', 1),
(242, 'AST-GPRO-KOM-002', 'Mobile workstation laptop lenovo thinkpad p16', NULL, 'Komputer/IT', 'Lenovo', 'P16 Gen 2', 'SN-LNVTP1601', 'Intel i7-13850hx, 64gb ram, rtx 3500 ada 12gb', 'RUANG EDITING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Khusus dit & on-site davinci color grading', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 39.00, 'Per Unit', 1, '2023-12-18', 1),
(243, 'AST-GPRO-AKS-001', 'Baterai v-mount smallrig vb99 pro mini', NULL, 'Aksesoris Daya', 'SmallRig', 'VB99 Pro', 'SN-SRVB9901', '99wh 14.8v, usb-c pd 100w, d-tap, oled display', 'LEMARI BATERAI', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Boleh masuk bagasi kabin pesawat', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 6, 2.75, 'Per Unit', 6, '2024-02-11', 1),
(244, 'AST-GPRO-PER-001', 'Kabel sdi belden 1694a drum 100 meter', NULL, 'Perkabelan', 'Belden', '1694A Drum', 'SN-BLD100M01', '3g/6g-sdi rg6 coaxial, neutrik bnc connector', 'GUDANG KABEL', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Reel gulungan kabel kabel heavy duty', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 4, 3.20, 'Per Unit', 4, '2023-06-01', 1),
(245, 'AST-GPRO-KEL-001', 'Box distribusi listrik (power distribution 3 phase)', NULL, 'Kelistrikan', 'Custom', 'PDU 32A 3 Phase', 'SN-PDU32A02', 'Input cee 32a 5-pin, output 12x schuko 16a + mcb', 'GUDANG STAGE', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Dilengkapi voltmeter digital & pilot lamp', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 2, 7.50, 'Per Unit', 2, '2023-04-15', 1),
(246, 'AST-GPRO-KEL-002', 'Genset silent inverter honda eu30is', NULL, 'Kelistrikan', 'Honda', 'EU30is', 'SN-HND30IS88', 'Output 3.0 kva / 2800 watt, pure sine wave, silent', 'GUDANG LUAR', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Khusus backup genset peralatan audio & kamera', '2026-10-31 10:11:24', '2026-10-31 10:11:24', 1, 28.50, 'Per Unit', 1, '2023-08-20', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `asset_units`
--

CREATE TABLE `asset_units` (
  `id` int(11) NOT NULL,
  `asset_id` int(11) NOT NULL,
  `kode_unit` varchar(60) NOT NULL,
  `nama_unit` varchar(255) DEFAULT NULL,
  `no_sn` varchar(100) DEFAULT NULL,
  `kondisi` enum('Siap Digunakan','Maintenance','Rusak') DEFAULT 'Siap Digunakan',
  `status_pinjam` enum('Tersedia','Dipinjam') DEFAULT 'Tersedia',
  `lokasi_unit` varchar(255) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `asset_units`
--

INSERT INTO `asset_units` (`id`, `asset_id`, `kode_unit`, `nama_unit`, `no_sn`, `kondisi`, `status_pinjam`, `lokasi_unit`, `keterangan`, `created_at`, `updated_at`) VALUES
(448, 197, 'AST-GPRO-CAM-001-01', 'Sony alpha 7 iii body', 'SN-98765432', 'Rusak', 'Tersedia', 'LEMARI KAMERA A', 'Lengkap dengan strap & charger', '2026-10-31 10:11:24', '2026-10-31 10:24:03'),
(449, 198, 'AST-GPRO-VID-001-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(450, 198, 'AST-GPRO-VID-001-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', NULL, 'Maintenance', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-10-31 10:11:24', '2026-10-31 10:24:12'),
(451, 198, 'AST-GPRO-VID-001-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', NULL, 'Rusak', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-10-31 10:11:24', '2026-10-31 10:24:14'),
(452, 198, 'AST-GPRO-VID-001-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', NULL, 'Rusak', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-10-31 10:11:24', '2026-10-31 10:24:13'),
(453, 198, 'AST-GPRO-VID-001-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(454, 198, 'AST-GPRO-VID-001-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(455, 199, 'AST-GPRO-CAM-002-01', 'Sony fx3 cinema line', 'SN-FX301982', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA A', 'Termasuk top handle xlr audio unit', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(456, 200, 'AST-GPRO-CAM-003-01', 'Blackmagic pocket cinema 6k pro', 'SN-BM6K9021', 'Maintenance', 'Tersedia', 'LEMARI KAMERA B', 'Termasuk cage smallrig & ssd holder', '2026-10-31 10:11:24', '2026-10-31 10:24:21'),
(457, 201, 'AST-GPRO-CAM-004-01', 'Canon eos r6 mark ii', 'SN-CN672109', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA B', 'Include adapter ef-eos r', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(458, 202, 'AST-GPRO-LEN-001-01', 'Lensa sony fe 24-70mm f/2.8 gm ii', 'SN-LNS88102', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA', 'Lengkap hood & pouch', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(459, 203, 'AST-GPRO-LEN-002-01', 'Lensa sony fe 70-200mm f/2.8 gm oss ii', 'SN-LNS99231', 'Maintenance', 'Tersedia', 'LEMARI LENSA', 'Termasuk tripod collar mount', '2026-10-31 10:11:24', '2026-10-31 10:24:25'),
(460, 204, 'AST-GPRO-LEN-003-01', 'Lensa sony fe 16-35mm f/2.8 gm', 'SN-LNS44012', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA', 'Filter uv terpasang', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(461, 205, 'AST-GPRO-LEN-004-01', 'Lensa sony fe 50mm f/1.2 gm', 'SN-LNS50123', 'Maintenance', 'Tersedia', 'LEMARI LENSA', 'Khusus beauty & low-light shoot', '2026-10-31 10:11:24', '2026-10-31 10:24:28'),
(462, 206, 'AST-GPRO-LEN-005-01', 'Lensa canon rf 24-70mm f/2.8l is usm', 'SN-CNL89120', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA', 'Lengkap hood ew-88e', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(463, 207, 'AST-GPRO-STA-001-01', 'Gimbal dji rs 3 pro combo #01', 'SN-DJI77102-01', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 1', 'Lengkap lidar & focus motor', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(464, 207, 'AST-GPRO-STA-001-02', 'Gimbal dji rs 3 pro combo #02', 'SN-DJI77102-02', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 1', 'Lengkap lidar & focus motor', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(465, 208, 'AST-GPRO-STA-002-01', 'Gimbal dji rs 2', 'SN-DJI55190', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 1', 'Digunakan sebagai unit backup', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(466, 209, 'AST-GPRO-GRI-001-01', 'Tripod video manfrotto 504hd #01', 'SN-MNF11029-01', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Lengkap handle pan bar ganda', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(467, 209, 'AST-GPRO-GRI-001-02', 'Tripod video manfrotto 504hd #02', 'SN-MNF11029-02', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Lengkap handle pan bar ganda', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(468, 209, 'AST-GPRO-GRI-001-03', 'Tripod video manfrotto 504hd #03', 'SN-MNF11029-03', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Lengkap handle pan bar ganda', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(469, 210, 'AST-GPRO-GRI-002-01', 'Tripod e-image eg05a2 #01', 'SN-EIM33401-01', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Unit operasional liputan umum', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(470, 210, 'AST-GPRO-GRI-002-02', 'Tripod e-image eg05a2 #02', 'SN-EIM33401-02', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Unit operasional liputan umum', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(471, 211, 'AST-GPRO-GRI-003-01', 'Slider kamera konova k5 120cm motorized', 'SN-KNV66712', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Termasuk 2 baterai np-f970', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(472, 212, 'AST-GPRO-DRO-001-01', 'Drone dji mavic 3 pro cine combo', 'SN-DJIM3PC01', 'Siap Digunakan', 'Tersedia', 'LEMARI DRONE', '3 baterai, rc pro controller, nd filters', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(473, 213, 'AST-GPRO-WIR-001-01', 'Wireless video hollyland cosmo c1 #01', 'SN-HLCC1908-01', 'Siap Digunakan', 'Tersedia', 'RAK WIRELESS', 'Transmitter & receiver set', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(474, 213, 'AST-GPRO-WIR-001-02', 'Wireless video hollyland cosmo c1 #02', 'SN-HLCC1908-02', 'Rusak', 'Tersedia', 'RAK WIRELESS', 'Transmitter & receiver set', '2026-10-31 10:11:24', '2026-10-31 10:25:45'),
(475, 214, 'AST-GPRO-MON-001-01', 'Monitor sutradara atomos sumo 19se', 'SN-ATM19002', 'Siap Digunakan', 'Tersedia', 'RAK MONITOR', 'Hardcase flight case + c-stand mount', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(476, 215, 'AST-GPRO-MON-002-01', 'Monitor on-camera feelworld lut7 #01', 'SN-FW700192-01', 'Siap Digunakan', 'Tersedia', 'RAK MONITOR', 'Terpasang cage & sunhood', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(477, 215, 'AST-GPRO-MON-002-02', 'Monitor on-camera feelworld lut7 #02', 'SN-FW700192-02', 'Siap Digunakan', 'Tersedia', 'RAK MONITOR', 'Terpasang cage & sunhood', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(478, 215, 'AST-GPRO-MON-002-03', 'Monitor on-camera feelworld lut7 #03', 'SN-FW700192-03', 'Siap Digunakan', 'Tersedia', 'RAK MONITOR', 'Terpasang cage & sunhood', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(479, 216, 'AST-GPRO-AUD-001-01', 'Wireless mic sennheiser ew 100 g4 #01', 'SN-SNH44109-01', 'Siap Digunakan', 'Tersedia', 'LEMARI AUDIO', 'Dilengkapi 8 pcs eneloop pro aa', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(480, 216, 'AST-GPRO-AUD-001-02', 'Wireless mic sennheiser ew 100 g4 #02', 'SN-SNH44109-02', 'Siap Digunakan', 'Tersedia', 'LEMARI AUDIO', 'Dilengkapi 8 pcs eneloop pro aa', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(481, 216, 'AST-GPRO-AUD-001-03', 'Wireless mic sennheiser ew 100 g4 #03', 'SN-SNH44109-03', 'Siap Digunakan', 'Tersedia', 'LEMARI AUDIO', 'Dilengkapi 8 pcs eneloop pro aa', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(482, 216, 'AST-GPRO-AUD-001-04', 'Wireless mic sennheiser ew 100 g4 #04', 'SN-SNH44109-04', 'Siap Digunakan', 'Tersedia', 'LEMARI AUDIO', 'Dilengkapi 8 pcs eneloop pro aa', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(483, 217, 'AST-GPRO-AUD-002-01', 'Wireless mic hollyland lark max duo #01', 'SN-HLM99812-01', 'Siap Digunakan', 'Tersedia', 'LEMARI AUDIO', 'Lengkap charging case & magnet mount', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(484, 217, 'AST-GPRO-AUD-002-02', 'Wireless mic hollyland lark max duo #02', 'SN-HLM99812-02', 'Siap Digunakan', 'Tersedia', 'LEMARI AUDIO', 'Lengkap charging case & magnet mount', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(485, 218, 'AST-GPRO-AUD-003-01', 'Shotgun mic sennheiser mkh 416 #01', 'SN-MKH41602-01', 'Siap Digunakan', 'Tersedia', 'LEMARI AUDIO', 'Termasuk rycote blimp & windshield', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(486, 218, 'AST-GPRO-AUD-003-02', 'Shotgun mic sennheiser mkh 416 #02', 'SN-MKH41602-02', 'Siap Digunakan', 'Tersedia', 'LEMARI AUDIO', 'Termasuk rycote blimp & windshield', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(487, 219, 'AST-GPRO-AUD-004-01', 'Audio field recorder zoom f8n pro', 'SN-ZF8N8819', 'Maintenance', 'Tersedia', 'LEMARI AUDIO', 'Bag k-tek + hirose power cable', '2026-10-31 10:11:24', '2026-10-31 10:26:06'),
(488, 220, 'AST-GPRO-AUD-005-01', 'Boom pole rode boompole pro #01', 'SN-RDBP0012-01', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 1', 'Termasuk kabel internal xlr coiled', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(489, 220, 'AST-GPRO-AUD-005-02', 'Boom pole rode boompole pro #02', 'SN-RDBP0012-02', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 1', 'Termasuk kabel internal xlr coiled', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(490, 221, 'AST-GPRO-AUD-006-01', 'Digital audio mixer behringer x32', 'SN-BX320912', 'Siap Digunakan', 'Tersedia', 'RUANG AUDIO FOH', 'Termasuk flight case roda', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(491, 222, 'AST-GPRO-AUD-007-01', 'Digital snake stage box behringer s16 #01', 'SN-BS168801-01', 'Siap Digunakan', 'Tersedia', 'RUANG AUDIO FOH', 'Terhubung via kabel cat5e ethercon 50m', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(492, 222, 'AST-GPRO-AUD-007-02', 'Digital snake stage box behringer s16 #02', 'SN-BS168801-02', 'Rusak', 'Tersedia', 'RUANG AUDIO FOH', 'Terhubung via kabel cat5e ethercon 50m', '2026-10-31 10:11:24', '2026-10-31 10:26:11'),
(493, 223, 'AST-GPRO-SOU-001-01', 'Active speaker yamaha dxr15 mkii #01', 'SN-YMH15003-01', 'Siap Digunakan', 'Tersedia', 'GUDANG AUDIO', 'Termasuk cover pelindung & stand speaker', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(494, 223, 'AST-GPRO-SOU-001-02', 'Active speaker yamaha dxr15 mkii #02', 'SN-YMH15003-02', 'Siap Digunakan', 'Tersedia', 'GUDANG AUDIO', 'Termasuk cover pelindung & stand speaker', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(495, 223, 'AST-GPRO-SOU-001-03', 'Active speaker yamaha dxr15 mkii #03', 'SN-YMH15003-03', 'Siap Digunakan', 'Tersedia', 'GUDANG AUDIO', 'Termasuk cover pelindung & stand speaker', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(496, 223, 'AST-GPRO-SOU-001-04', 'Active speaker yamaha dxr15 mkii #04', 'SN-YMH15003-04', 'Siap Digunakan', 'Tersedia', 'GUDANG AUDIO', 'Termasuk cover pelindung & stand speaker', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(497, 224, 'AST-GPRO-SOU-002-01', 'Active subwoofer yamaha dxs18xlf #01', 'SN-YMH18991-01', 'Siap Digunakan', 'Tersedia', 'GUDANG AUDIO', 'Termasuk roda castor heavy-duty', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(498, 224, 'AST-GPRO-SOU-002-02', 'Active subwoofer yamaha dxs18xlf #02', 'SN-YMH18991-02', 'Siap Digunakan', 'Tersedia', 'GUDANG AUDIO', 'Termasuk roda castor heavy-duty', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(499, 225, 'AST-GPRO-LIG-001-01', 'Lampu studio aputure ls 600d pro #01', 'SN-AP600D01-01', 'Rusak', 'Tersedia', 'GUDANG LIGHTING', 'Rolling hard case + standard reflector', '2026-10-31 10:11:24', '2026-10-31 10:26:01'),
(500, 225, 'AST-GPRO-LIG-001-02', 'Lampu studio aputure ls 600d pro #02', 'SN-AP600D01-02', 'Rusak', 'Tersedia', 'GUDANG LIGHTING', 'Rolling hard case + standard reflector', '2026-10-31 10:11:24', '2026-10-31 10:26:00'),
(501, 226, 'AST-GPRO-LIG-002-01', 'Lampu studio aputure ls 300x bi-color #01', 'SN-AP300X11-01', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Pouch bag + control box', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(502, 226, 'AST-GPRO-LIG-002-02', 'Lampu studio aputure ls 300x bi-color #02', 'SN-AP300X11-02', 'Rusak', 'Tersedia', 'GUDANG LIGHTING', 'Pouch bag + control box', '2026-10-31 10:11:24', '2026-10-31 10:26:14'),
(503, 227, 'AST-GPRO-LIG-003-01', 'Lampu tube nanlite pavotube ii 30x 4-kit', 'SN-NVT30X4K', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Termasuk padded bag & power adapter set', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(504, 228, 'AST-GPRO-LIG-004-01', 'Softbox aputure light dome 150 #01', 'SN-APLD1501-01', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Bowens mount quick-setup', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(505, 228, 'AST-GPRO-LIG-004-02', 'Softbox aputure light dome 150 #02', 'SN-APLD1501-02', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Bowens mount quick-setup', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(506, 229, 'AST-GPRO-LIG-005-01', 'Lantern softbox aputure lantern 90 #01', 'SN-APLT9002-01', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Bowens mount', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(507, 229, 'AST-GPRO-LIG-005-02', 'Lantern softbox aputure lantern 90 #02', 'SN-APLT9002-02', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Bowens mount', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(508, 230, 'AST-GPRO-GRI-004-01', 'C-stand kupo 40\" grip arm kit #01', 'SN-KP400911-01', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Termasuk sandbag 10kg', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(509, 230, 'AST-GPRO-GRI-004-02', 'C-stand kupo 40\" grip arm kit #02', 'SN-KP400911-02', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Termasuk sandbag 10kg', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(510, 230, 'AST-GPRO-GRI-004-03', 'C-stand kupo 40\" grip arm kit #03', 'SN-KP400911-03', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Termasuk sandbag 10kg', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(511, 230, 'AST-GPRO-GRI-004-04', 'C-stand kupo 40\" grip arm kit #04', 'SN-KP400911-04', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Termasuk sandbag 10kg', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(512, 230, 'AST-GPRO-GRI-004-05', 'C-stand kupo 40\" grip arm kit #05', 'SN-KP400911-05', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Termasuk sandbag 10kg', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(513, 230, 'AST-GPRO-GRI-004-06', 'C-stand kupo 40\" grip arm kit #06', 'SN-KP400911-06', 'Siap Digunakan', 'Tersedia', 'RAK GRIP 2', 'Termasuk sandbag 10kg', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(514, 231, 'AST-GPRO-LIG-006-01', 'Par led 54x3w rgbw outdoor #01', 'SN-PL540023-01', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(515, 231, 'AST-GPRO-LIG-006-02', 'Par led 54x3w rgbw outdoor #02', 'SN-PL540023-02', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(516, 231, 'AST-GPRO-LIG-006-03', 'Par led 54x3w rgbw outdoor #03', 'SN-PL540023-03', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(517, 231, 'AST-GPRO-LIG-006-04', 'Par led 54x3w rgbw outdoor #04', 'SN-PL540023-04', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(518, 231, 'AST-GPRO-LIG-006-05', 'Par led 54x3w rgbw outdoor #05', 'SN-PL540023-05', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(519, 231, 'AST-GPRO-LIG-006-06', 'Par led 54x3w rgbw outdoor #06', 'SN-PL540023-06', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(520, 231, 'AST-GPRO-LIG-006-07', 'Par led 54x3w rgbw outdoor #07', 'SN-PL540023-07', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(521, 231, 'AST-GPRO-LIG-006-08', 'Par led 54x3w rgbw outdoor #08', 'SN-PL540023-08', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(522, 231, 'AST-GPRO-LIG-006-09', 'Par led 54x3w rgbw outdoor #09', 'SN-PL540023-09', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(523, 231, 'AST-GPRO-LIG-006-10', 'Par led 54x3w rgbw outdoor #10', 'SN-PL540023-10', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(524, 231, 'AST-GPRO-LIG-006-11', 'Par led 54x3w rgbw outdoor #11', 'SN-PL540023-11', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(525, 231, 'AST-GPRO-LIG-006-12', 'Par led 54x3w rgbw outdoor #12', 'SN-PL540023-12', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(526, 231, 'AST-GPRO-LIG-006-13', 'Par led 54x3w rgbw outdoor #13', 'SN-PL540023-13', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(527, 231, 'AST-GPRO-LIG-006-14', 'Par led 54x3w rgbw outdoor #14', 'SN-PL540023-14', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(528, 231, 'AST-GPRO-LIG-006-15', 'Par led 54x3w rgbw outdoor #15', 'SN-PL540023-15', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(529, 231, 'AST-GPRO-LIG-006-16', 'Par led 54x3w rgbw outdoor #16', 'SN-PL540023-16', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Lengkap kabel daisy chain powercon', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(530, 232, 'AST-GPRO-LIG-007-01', 'Moving head beam 230w 7r #01', 'SN-MB23001-01', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', '2 flightcase (isi 2 moving head/box)', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(531, 232, 'AST-GPRO-LIG-007-02', 'Moving head beam 230w 7r #02', 'SN-MB23001-02', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', '2 flightcase (isi 2 moving head/box)', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(532, 232, 'AST-GPRO-LIG-007-03', 'Moving head beam 230w 7r #03', 'SN-MB23001-03', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', '2 flightcase (isi 2 moving head/box)', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(533, 232, 'AST-GPRO-LIG-007-04', 'Moving head beam 230w 7r #04', 'SN-MB23001-04', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', '2 flightcase (isi 2 moving head/box)', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(534, 233, 'AST-GPRO-LIG-008-01', 'Dmx lighting controller tiger touch ii', 'SN-AVTT0911', 'Siap Digunakan', 'Tersedia', 'RUANG CONTROL', 'Flight case + cover anti debu', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(535, 234, 'AST-GPRO-VID-002-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', 'SN-VTN39001-01', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Dihitung rp 4.166.667 / kabinet saat disewa', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(536, 234, 'AST-GPRO-VID-002-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', 'SN-VTN39001-02', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Dihitung rp 4.166.667 / kabinet saat disewa', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(537, 234, 'AST-GPRO-VID-002-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', 'SN-VTN39001-03', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Dihitung rp 4.166.667 / kabinet saat disewa', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(538, 234, 'AST-GPRO-VID-002-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', 'SN-VTN39001-04', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Dihitung rp 4.166.667 / kabinet saat disewa', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(539, 234, 'AST-GPRO-VID-002-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', 'SN-VTN39001-05', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Dihitung rp 4.166.667 / kabinet saat disewa', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(540, 234, 'AST-GPRO-VID-002-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', 'SN-VTN39001-06', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Dihitung rp 4.166.667 / kabinet saat disewa', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(541, 235, 'AST-GPRO-VID-003-01', 'Videotron p3.9 indoor tambahan (1 box 6 kabinet) #01', 'SN-VTN39002-01', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Seri batch display sama dengan aset #38', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(542, 235, 'AST-GPRO-VID-003-02', 'Videotron p3.9 indoor tambahan (1 box 6 kabinet) #02', 'SN-VTN39002-02', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Seri batch display sama dengan aset #38', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(543, 235, 'AST-GPRO-VID-003-03', 'Videotron p3.9 indoor tambahan (1 box 6 kabinet) #03', 'SN-VTN39002-03', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Seri batch display sama dengan aset #38', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(544, 235, 'AST-GPRO-VID-003-04', 'Videotron p3.9 indoor tambahan (1 box 6 kabinet) #04', 'SN-VTN39002-04', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Seri batch display sama dengan aset #38', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(545, 235, 'AST-GPRO-VID-003-05', 'Videotron p3.9 indoor tambahan (1 box 6 kabinet) #05', 'SN-VTN39002-05', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Seri batch display sama dengan aset #38', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(546, 235, 'AST-GPRO-VID-003-06', 'Videotron p3.9 indoor tambahan (1 box 6 kabinet) #06', 'SN-VTN39002-06', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Seri batch display sama dengan aset #38', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(547, 236, 'AST-GPRO-VID-004-01', 'Video processor novastar vx4s #01', 'SN-NVX40019-01', 'Siap Digunakan', 'Tersedia', 'RUANG CONTROL', 'Input hdmi/dvi/sdi/vga/cvbs', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(548, 236, 'AST-GPRO-VID-004-02', 'Video processor novastar vx4s #02', 'SN-NVX40019-02', 'Siap Digunakan', 'Tersedia', 'RUANG CONTROL', 'Input hdmi/dvi/sdi/vga/cvbs', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(549, 237, 'AST-GPRO-BRO-001-01', 'Video switcher blackmagic atem mini extreme iso', 'SN-BMATEM91', 'Siap Digunakan', 'Tersedia', 'RUANG STREAMING', 'Hardcase pelican custom insert', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(550, 238, 'AST-GPRO-BRO-002-01', 'Video switcher blackmagic atem 1 m/e constellation hd', 'SN-BM1ME001', 'Siap Digunakan', 'Tersedia', 'RACK BROADCAST', 'Terpasang di rackmount 1u', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(551, 239, 'AST-GPRO-INT-001-01', 'Intercom wireless hollyland solidcom c1-6s', 'SN-HLC16S02', 'Siap Digunakan', 'Tersedia', 'LEMARI AUDIO', '12 baterai + multi-slot charger', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(552, 240, 'AST-GPRO-BRO-003-01', 'Capture card elgato cam link 4k #01', 'SN-ELG00192-01', 'Siap Digunakan', 'Tersedia', 'RUANG STREAMING', 'Include kabel ekstensi usb', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(553, 240, 'AST-GPRO-BRO-003-02', 'Capture card elgato cam link 4k #02', 'SN-ELG00192-02', 'Siap Digunakan', 'Tersedia', 'RUANG STREAMING', 'Include kabel ekstensi usb', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(554, 240, 'AST-GPRO-BRO-003-03', 'Capture card elgato cam link 4k #03', 'SN-ELG00192-03', 'Siap Digunakan', 'Tersedia', 'RUANG STREAMING', 'Include kabel ekstensi usb', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(555, 240, 'AST-GPRO-BRO-003-04', 'Capture card elgato cam link 4k #04', 'SN-ELG00192-04', 'Siap Digunakan', 'Tersedia', 'RUANG STREAMING', 'Include kabel ekstensi usb', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(556, 241, 'AST-GPRO-KOM-001-01', 'Laptop live streaming asus rog strix scar 16 #01', 'SN-ASROG8812-01', 'Siap Digunakan', 'Tersedia', 'RUANG STREAMING', 'Khusus vmix production & rendering', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(557, 241, 'AST-GPRO-KOM-001-02', 'Laptop live streaming asus rog strix scar 16 #02', 'SN-ASROG8812-02', 'Siap Digunakan', 'Tersedia', 'RUANG STREAMING', 'Khusus vmix production & rendering', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(558, 242, 'AST-GPRO-KOM-002-01', 'Mobile workstation laptop lenovo thinkpad p16', 'SN-LNVTP1601', 'Siap Digunakan', 'Tersedia', 'RUANG EDITING', 'Khusus dit & on-site davinci color grading', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(559, 243, 'AST-GPRO-AKS-001-01', 'Baterai v-mount smallrig vb99 pro mini #01', 'SN-SRVB9901-01', 'Siap Digunakan', 'Tersedia', 'LEMARI BATERAI', 'Boleh masuk bagasi kabin pesawat', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(560, 243, 'AST-GPRO-AKS-001-02', 'Baterai v-mount smallrig vb99 pro mini #02', 'SN-SRVB9901-02', 'Siap Digunakan', 'Tersedia', 'LEMARI BATERAI', 'Boleh masuk bagasi kabin pesawat', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(561, 243, 'AST-GPRO-AKS-001-03', 'Baterai v-mount smallrig vb99 pro mini #03', 'SN-SRVB9901-03', 'Siap Digunakan', 'Tersedia', 'LEMARI BATERAI', 'Boleh masuk bagasi kabin pesawat', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(562, 243, 'AST-GPRO-AKS-001-04', 'Baterai v-mount smallrig vb99 pro mini #04', 'SN-SRVB9901-04', 'Siap Digunakan', 'Tersedia', 'LEMARI BATERAI', 'Boleh masuk bagasi kabin pesawat', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(563, 243, 'AST-GPRO-AKS-001-05', 'Baterai v-mount smallrig vb99 pro mini #05', 'SN-SRVB9901-05', 'Siap Digunakan', 'Tersedia', 'LEMARI BATERAI', 'Boleh masuk bagasi kabin pesawat', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(564, 243, 'AST-GPRO-AKS-001-06', 'Baterai v-mount smallrig vb99 pro mini #06', 'SN-SRVB9901-06', 'Siap Digunakan', 'Tersedia', 'LEMARI BATERAI', 'Boleh masuk bagasi kabin pesawat', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(565, 244, 'AST-GPRO-PER-001-01', 'Kabel sdi belden 1694a drum 100 meter #01', 'SN-BLD100M01-01', 'Siap Digunakan', 'Tersedia', 'GUDANG KABEL', 'Reel gulungan kabel kabel heavy duty', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(566, 244, 'AST-GPRO-PER-001-02', 'Kabel sdi belden 1694a drum 100 meter #02', 'SN-BLD100M01-02', 'Siap Digunakan', 'Tersedia', 'GUDANG KABEL', 'Reel gulungan kabel kabel heavy duty', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(567, 244, 'AST-GPRO-PER-001-03', 'Kabel sdi belden 1694a drum 100 meter #03', 'SN-BLD100M01-03', 'Siap Digunakan', 'Tersedia', 'GUDANG KABEL', 'Reel gulungan kabel kabel heavy duty', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(568, 244, 'AST-GPRO-PER-001-04', 'Kabel sdi belden 1694a drum 100 meter #04', 'SN-BLD100M01-04', 'Siap Digunakan', 'Tersedia', 'GUDANG KABEL', 'Reel gulungan kabel kabel heavy duty', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(569, 245, 'AST-GPRO-KEL-001-01', 'Box distribusi listrik (power distribution 3 phase) #01', 'SN-PDU32A02-01', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Dilengkapi voltmeter digital & pilot lamp', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(570, 245, 'AST-GPRO-KEL-001-02', 'Box distribusi listrik (power distribution 3 phase) #02', 'SN-PDU32A02-02', 'Siap Digunakan', 'Tersedia', 'GUDANG STAGE', 'Dilengkapi voltmeter digital & pilot lamp', '2026-10-31 10:11:24', '2026-10-31 10:11:24'),
(571, 246, 'AST-GPRO-KEL-002-01', 'Genset silent inverter honda eu30is', 'SN-HND30IS88', 'Siap Digunakan', 'Tersedia', 'GUDANG LUAR', 'Khusus backup genset peralatan audio & kamera', '2026-10-31 10:11:24', '2026-10-31 10:11:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `user_name`, `action`, `entity_type`, `entity_id`, `details`, `created_at`) VALUES
(1, 2, 'Admin', 'CREATE', 'Aset', NULL, 'Menambahkan aset: Sony A7C (GKM-CAM-001)', '2026-06-12 06:25:26'),
(2, 1, 'super admin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Baterai Kamera NP-FZ100 (GKM-BAT-001)', '2026-06-12 06:27:25'),
(3, 4, 'User', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-1) untuk Cahyo', '2026-06-12 06:28:55'),
(4, 3, 'Supervisor', 'UPDATE', 'Peminjaman', '1', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-1', '2026-06-12 06:29:27'),
(5, 4, 'User', 'UPDATE', 'Peminjaman', '1', 'Memperbarui peminjaman: GKM-PJM-1', '2026-06-12 06:30:52'),
(6, 3, 'Supervisor', 'UPDATE', 'Peminjaman', '1', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-1', '2026-06-12 06:31:39'),
(7, 4, 'User', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-2) untuk Cahyo', '2026-06-12 07:50:15'),
(8, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aset', NULL, 'Menambahkan aset: Video Processor Colorlight X4m (GKM-VPROC-001)', '2026-06-22 02:34:55'),
(9, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aset', '2', 'Memperbarui aset: Video Processor Colorlight X4m (GKM-VPROC-001)', '2026-06-22 02:36:22'),
(10, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Orbit (GKM-ORBIT-001)', '2026-06-22 07:14:20'),
(11, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aksesoris', '2', 'Memperbarui aksesoris: Orbit (GKM-ORBIT-001)', '2026-06-22 07:14:47'),
(12, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Matador  (GKM-STAND TV -001)', '2026-06-22 07:23:06'),
(13, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aksesoris', '3', 'Memperbarui aksesoris: Matador  (GKM-STAND TV -001)', '2026-06-22 07:25:15'),
(14, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aksesoris', '3', 'Memperbarui aksesoris: Matador  (GKM-STAND TV -001)', '2026-06-22 07:25:29'),
(15, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Stand Tv Warna putih  (GKM-STAND TV P-001)', '2026-06-22 07:28:45'),
(16, 6, 'Muhammad Hoirul Fanani', 'DELETE', 'Aksesoris', '2', 'Menghapus aksesoris: Orbit (GKM-ORBIT-001)', '2026-06-22 07:29:53'),
(17, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aset', NULL, 'Menambahkan aset: Orbit Besar  (GKM-UMUM-001)', '2026-06-22 07:36:11'),
(18, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aset', NULL, 'Menambahkan aset: Zoom Recorder Besar  (GKM-ZOOM-001)', '2026-06-22 08:14:33'),
(19, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aset', '4', 'Memperbarui aset: Zoom Recorder Besar  (GKM-ZOOM-001)', '2026-06-22 08:15:43'),
(20, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aset', NULL, 'Menambahkan aset: Zoom Recoder kecil 01 (GKM-ZOOM-002)', '2026-06-22 08:29:02'),
(21, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aset', '5', 'Memperbarui aset: Zoom Recoder kecil 01 (GKM-ZOOM-002)', '2026-06-22 08:29:43'),
(22, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aset', NULL, 'Menambahkan aset: Zoom Recorder kecil 02 (GKM-RECORDER-001)', '2026-06-22 08:34:54'),
(23, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aset', '6', 'Memperbarui aset: Zoom Recorder kecil 02 (GKM-RECORDER-001)', '2026-06-22 08:35:32'),
(24, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aset', NULL, 'Menambahkan aset: Zoom Recoder 03 (GKM-RECORDER-002)', '2026-06-22 08:40:34'),
(25, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aset', '7', 'Memperbarui aset: Zoom Recoder 03 (GKM-RECORDER-002)', '2026-06-22 08:42:52'),
(26, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aset', NULL, 'Menambahkan aset: Orbit kecil  (GKM-ORBIT -001)', '2026-06-22 08:54:10'),
(27, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aset', '8', 'Memperbarui aset: Orbit kecil  (GKM-ORBIT -001)', '2026-06-22 08:55:07'),
(28, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aset', '3', 'Memperbarui aset: Orbit Besar  (GKM-UMUM-001)', '2026-06-22 08:55:29'),
(29, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aset', '8', 'Memperbarui aset: Orbit kecil  (GKM-ORBIT -001)', '2026-06-22 08:55:41'),
(30, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aset', '8', 'Memperbarui aset: Orbit kecil  (GKM-ORBIT -001)', '2026-06-22 08:59:51'),
(31, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aset', NULL, 'Menambahkan aset: Video Switcher  (GKM-VIDEO SWIT-001)', '2026-06-22 09:05:13'),
(32, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aset', '5', 'Memperbarui aset: Zoom Recoder kecil 01 (GKM-ZOOM-002)', '2026-06-23 03:43:18'),
(33, 1, 'super admin', 'DELETE', 'Aksesoris', '1', 'Menghapus aksesoris: Baterai Kamera NP-FZ100 (GKM-BAT-001)', '2026-06-23 05:58:23'),
(34, 1, 'super admin', 'UPDATE', 'Peminjaman', '2', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-2', '2026-06-23 06:03:41'),
(35, 1, 'super admin', 'DELETE', 'Peminjaman', '2', 'Menghapus peminjaman: GKM-PJM-2', '2026-06-23 06:05:10'),
(36, 1, 'super admin', 'DELETE', 'Aset', '1', 'Menghapus aset: Sony A7C (GKM-CAM-001)', '2026-06-23 08:31:29'),
(37, 8, 'Mochammad Muhsin', 'UPDATE', 'Aset', '9', 'Memperbarui aset: Video Switcher  (GKM-VIDEO SWIT-001)', '2026-06-29 01:44:58'),
(38, 8, 'Mochammad Muhsin', 'CREATE', 'Aset', NULL, 'Menambahkan aset: Printer Narsis Booth (GKM-PRINT-001)', '2026-06-29 02:17:49'),
(39, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Kabel Ganset (GKM-KABEL-001)', '2026-06-29 07:10:50'),
(40, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aset', NULL, 'Menambahkan aset: Audio Interface (GKM-AUDIO INTE-001)', '2026-06-29 07:15:55'),
(41, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Hdmi To Hdmi (GKM-KABEL HDMI-001)', '2026-06-29 07:20:03'),
(42, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aksesoris', '6', 'Memperbarui aksesoris: Kabel Hdmi (GKM-KABEL HDMI-001)', '2026-06-29 07:21:02'),
(43, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Kabel Hdmi (GKM-KABEL HDMI-002)', '2026-06-29 07:23:25'),
(44, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aksesoris', '6', 'Memperbarui aksesoris: Kabel Hdmi (GKM-KABEL HDMI-001)', '2026-06-29 07:23:49'),
(45, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Kabel Hdmi  (GKM-KABEL HDMI-003)', '2026-06-29 07:26:26'),
(46, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Kabel usb (GKM-U-001)', '2026-06-29 07:28:29'),
(47, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Kabel usb  (GKM-U-002)', '2026-06-29 07:30:07'),
(48, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '5', 'Memperbarui aksesoris: Kabel Genset (GKM-KABEL-001)', '2026-06-29 10:26:31'),
(49, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '4', 'Memperbarui aksesoris: Stand Tv Warna putih  (GKM-STAND TV P-001)', '2026-06-29 10:26:56'),
(50, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aksesoris', '9', 'Memperbarui aksesoris: Kabel Usb B To Usb A (GKM-U-001)', '2026-07-01 07:50:36'),
(51, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aksesoris', '8', 'Memperbarui aksesoris: Kabel Hdmi  2M  (GKM-KABEL HDMI-003)', '2026-07-01 07:52:23'),
(52, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aksesoris', '7', 'Memperbarui aksesoris: Kabel Hdmi 1,5 M  (GKM-KABEL HDMI-002)', '2026-07-01 07:52:43'),
(53, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aksesoris', '8', 'Memperbarui aksesoris: Kabel Hdmi  2 M  (GKM-KABEL HDMI-003)', '2026-07-01 07:52:52'),
(54, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aksesoris', '6', 'Memperbarui aksesoris: Kabel Hdmi 1 M (GKM-KABEL HDMI-001)', '2026-07-01 07:53:02'),
(55, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Tripod Flash Takara  (GKM-STAND -001)', '2026-07-01 07:57:45'),
(56, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Stand NX200 Kuning Benro (GKM-STND-001)', '2026-07-01 08:04:48'),
(57, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: STAND FLASH No Brand (GKM-STAND -002)', '2026-07-01 08:17:07'),
(58, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Lensa Zeis 35 F1,4  (GKM-LENSA-001)', '2026-07-01 08:26:16'),
(59, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Lensa Samyang 35 F1,8 (GKM-LENSA-002)', '2026-07-01 08:28:07'),
(60, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Lensa Sony 85 F 1.8 (GKM-LENSA-003)', '2026-07-01 12:41:29'),
(61, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Lensa 18 F 2.8 (GKM-LENSA-004)', '2026-07-01 12:43:13'),
(62, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Lensa Samyang V-AF 35 F 1.9 (GKM-LENSA-005)', '2026-07-01 12:45:31'),
(63, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Lensa Sony 35 F 1.8 (GKM-LENSA-006)', '2026-07-01 12:47:45'),
(64, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Lensa Samyang 75 F 1.8   (GKM-LENSA-007)', '2026-07-01 12:51:23'),
(65, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Lensa Zeis 25 F 2 (GKM-LENSA-008)', '2026-07-01 12:53:51'),
(66, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Lensa Fish eye 7,5 F2.8 (GKM-LENSA-009)', '2026-07-01 12:56:35'),
(67, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: hardcase parled (GKM-HRC-001)', '2026-07-02 01:58:04'),
(68, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Hardcase Sound (GKM-HRC-002)', '2026-07-02 01:59:33'),
(69, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: Hardcase followspot (GKM-HRC-003)', '2026-07-02 02:02:34'),
(70, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '25', 'Memperbarui aksesoris: Hardcase followspot (GKM-HRC-003)', '2026-07-02 02:05:08'),
(71, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: harcase parled (GKM-HRC-004)', '2026-07-02 02:05:36'),
(72, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: hardcase tv 43\" (GKM-HRC-005)', '2026-07-02 02:09:03'),
(73, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: hardcase beam (GKM-HRC-006)', '2026-07-02 02:12:01'),
(74, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: hardcase tv 50\" (GKM-HRC-007)', '2026-07-02 02:12:55'),
(75, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: hardcase stop kontak (GKM-HRC-008)', '2026-07-02 02:15:10'),
(76, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: hardcase stop kontak (GKM-HRC-009)', '2026-07-02 02:15:21'),
(77, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: hardcase stop kontak (GKM-HRC-010)', '2026-07-02 02:15:36'),
(78, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: hardcase tv 65\" (GKM-HRC-011)', '2026-07-02 02:18:56'),
(79, 7, 'Mohamad Mahmudi', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: SD CARD - 06 - MM (GKM-C-64-001)', '2026-07-02 07:25:49'),
(80, 7, 'Mohamad Mahmudi', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: SD CARD - 07 - DYS (GKM-C-64-002)', '2026-07-02 07:45:21'),
(81, 7, 'Mohamad Mahmudi', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: SD CARD - 05 - AGF (GKM-C-64-003)', '2026-07-02 07:47:53'),
(82, 7, 'Mohamad Mahmudi', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: SD CARD - 10  (GKM-C-32-001)', '2026-07-02 07:53:04'),
(83, 7, 'Mohamad Mahmudi', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: SD CARD - 11  (GKM-C-32-002)', '2026-07-02 07:59:50'),
(84, 7, 'Mohamad Mahmudi', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: SD CARD - 12 (GKM-C-32-003)', '2026-07-02 08:01:39'),
(85, 7, 'Mohamad Mahmudi', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: SD CARD - 13  (GKM-C-32-004)', '2026-07-02 08:03:17'),
(86, 7, 'Mohamad Mahmudi', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: SD CARD - 14 (GKM-C-32-005)', '2026-07-02 08:05:14'),
(87, 7, 'Mohamad Mahmudi', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: SD CARD - 16 (GKM-C-64-004)', '2026-07-03 08:14:18'),
(88, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '25', 'Memperbarui aksesoris: Hardcase Fllowspot (GKM-HRC-003)', '2026-07-04 01:54:22'),
(89, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '33', 'Memperbarui aksesoris: hardcase tv 65\" (GKM-HRC-011)', '2026-07-04 01:56:16'),
(90, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '29', 'Memperbarui aksesoris: hardcase tv 50\" (GKM-HRC-007)', '2026-07-04 01:56:47'),
(91, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '27', 'Memperbarui aksesoris: hardcase tv 43\" (GKM-HRC-005)', '2026-07-04 01:57:01'),
(92, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '25', 'Memperbarui aksesoris: Hardcase Followspot (GKM-HRC-003)', '2026-07-04 01:57:15'),
(93, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '32', 'Memperbarui aksesoris: hardcase stop kontak (GKM-HRC-010)', '2026-07-04 01:57:58'),
(94, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '33', 'Memperbarui aksesoris: HARDCASE TV 65\" (GKM-HRC-011)', '2026-07-04 01:58:44'),
(95, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '30', 'Memperbarui aksesoris: HARDCASE STOP KONTAK (GKM-HRC-008)', '2026-07-04 01:59:10'),
(96, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '29', 'Memperbarui aksesoris: HARDCASE TV 50\" (GKM-HRC-007)', '2026-07-04 01:59:41'),
(97, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '28', 'Memperbarui aksesoris: HARDCASE BEAM (GKM-HRC-006)', '2026-07-04 01:59:55'),
(98, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '27', 'Memperbarui aksesoris: HARDCASE TV 43\" (GKM-HRC-005)', '2026-07-04 02:00:18'),
(99, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '26', 'Memperbarui aksesoris: HARDCASE PARLED (GKM-HRC-004)', '2026-07-04 02:00:36'),
(100, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '25', 'Memperbarui aksesoris: HARDCASE FOLLOWSPOT (GKM-HRC-003)', '2026-07-04 02:00:54'),
(101, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '24', 'Memperbarui aksesoris: HARDCASE SOUND HUPER (GKM-HRC-002)', '2026-07-04 02:04:09'),
(102, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '24', 'Memperbarui aksesoris: HARDCASE SOUND HUPER (GKM-HRC-002)', '2026-07-04 02:04:45'),
(103, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: STAND TRIPOD LIGHTING (GKM-STN-001)', '2026-07-04 02:37:05'),
(104, 8, 'Mochammad Muhsin', 'CREATE', 'Aset', NULL, 'Menambahkan aset: KABEL SNAKE 16 CHANNEL (GKM-KSN-001)', '2026-07-04 02:43:51'),
(105, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: KABEL LAN 100M (GKM-KBL-001)', '2026-07-04 04:14:52'),
(106, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '44', 'Memperbarui aksesoris: KABEL LAN 100M (GKM-KBL-001)', '2026-07-04 04:15:58'),
(107, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '44', 'Memperbarui aksesoris: KABEL LAN 100M (GKM-KBL-001)', '2026-07-04 04:17:05'),
(108, 8, 'Mochammad Muhsin', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: KABEL LAN 50 (GKM-KBL-002)', '2026-07-04 04:29:49'),
(109, 8, 'Mochammad Muhsin', 'UPDATE', 'Aksesoris', '45', 'Memperbarui aksesoris: KABEL LAN 50M (GKM-KBL-002)', '2026-07-04 04:30:00'),
(110, 6, 'Muhammad Hoirul Fanani', 'UPDATE', 'Aksesoris', '44', 'Memperbarui aksesoris: KABEL LAN 100M (GKM-KBL-001)', '2026-07-08 07:00:38'),
(111, 6, 'Muhammad Hoirul Fanani', 'CREATE', 'Aset', NULL, 'Menambahkan aset: MIC QA Electronic (GKM-MIC-001)', '2026-07-08 07:07:12'),
(112, 1, 'super admin', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-2) untuk Favian', '2026-09-14 07:25:51'),
(113, 1, 'super admin', 'UPDATE', 'Peminjaman', '3', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-2', '2026-09-14 07:27:07'),
(114, 1, 'super admin', 'UPDATE', 'Peminjaman', '3', 'Memperbarui peminjaman: GKM-PJM-2', '2026-09-14 07:27:35'),
(115, 1, 'super admin', 'UPDATE', 'Peminjaman', '3', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-2', '2026-09-14 07:27:46'),
(116, 4, 'User', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-3) untuk Dandi', '2026-09-14 07:33:41'),
(117, 1, 'super admin', 'UPDATE', 'Peminjaman', '4', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-3', '2026-09-14 07:33:57'),
(118, 1, 'super admin', 'UPDATE', 'Peminjaman', '4', 'Memperbarui peminjaman: GKM-PJM-3', '2026-09-15 07:57:27'),
(119, 1, 'super admin', 'DELETE', 'Peminjaman', '4', 'Menghapus peminjaman: GKM-PJM-3', '2026-09-16 02:28:39'),
(120, 1, 'super admin', 'DELETE', 'Peminjaman', '3', 'Menghapus peminjaman: GKM-PJM-2', '2026-09-16 02:28:41'),
(121, 1, 'super admin', 'DELETE', 'Peminjaman', '1', 'Menghapus peminjaman: GKM-PJM-1', '2026-09-16 02:28:43'),
(122, 17, 'Aditya Kurniawan', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-1) untuk Aditya Kurniawan', '2026-09-18 06:21:00'),
(123, 1, 'super admin', 'UPDATE', 'Peminjaman', '5', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-1', '2026-09-18 06:22:06'),
(124, 17, 'Aditya Kurniawan', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-2) untuk Aditya Kurniawan', '2026-09-18 06:26:18'),
(125, 17, 'Aditya Kurniawan', 'UPDATE', 'Peminjaman', '5', 'Memperbarui peminjaman: GKM-PJM-1', '2026-09-18 08:02:53'),
(126, 19, 'Citra Ayu', 'UPDATE', 'Peminjaman', '6', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-2', '2026-09-18 08:15:55'),
(127, 17, 'Aditya Kurniawan', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-3) untuk Aditya Kurniawan', '2026-09-22 04:21:31'),
(128, 17, 'Aditya Kurniawan', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-4) untuk Aditya Kurniawan', '2026-09-22 04:33:12'),
(129, 19, 'Citra Ayu', 'UPDATE', 'Peminjaman', '8', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-4', '2026-09-22 04:34:34'),
(130, 1, 'super admin', 'DELETE', 'Peminjaman', '8', 'Menghapus peminjaman: GKM-PJM-4', '2026-09-23 06:17:45'),
(131, 1, 'super admin', 'DELETE', 'Peminjaman', '7', 'Menghapus peminjaman: GKM-PJM-3', '2026-09-23 06:17:47'),
(132, 1, 'super admin', 'DELETE', 'Peminjaman', '6', 'Menghapus peminjaman: GKM-PJM-2', '2026-09-23 06:17:48'),
(133, 1, 'super admin', 'DELETE', 'Peminjaman', '5', 'Menghapus peminjaman: GKM-PJM-1', '2026-09-23 06:17:50'),
(134, 17, 'Aditya Kurniawan', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-1) untuk Aditya Kurniawan', '2026-09-23 06:30:47'),
(135, 18, 'Bayu Pratama', 'UPDATE', 'Peminjaman', '9', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-1', '2026-09-23 06:32:48'),
(136, 17, 'Aditya Kurniawan', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-2) untuk Aditya Kurniawan', '2026-09-23 06:39:40'),
(137, 21, 'Eko Prasetyo', 'UPDATE', 'Peminjaman', '10', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-2', '2026-09-23 06:42:50'),
(138, 18, 'Bayu Pratama', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-3) untuk Bayu Pratama', '2026-09-23 06:46:30'),
(139, 21, 'Eko Prasetyo', 'UPDATE', 'Peminjaman', '11', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-3', '2026-09-23 06:53:01'),
(140, 21, 'Eko Prasetyo', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-4) untuk Eko Prasetyo', '2026-09-23 07:08:34'),
(141, 19, 'Citra Ayu', 'UPDATE', 'Peminjaman', '12', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-4', '2026-09-23 07:09:56'),
(142, 17, 'Aditya Kurniawan', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-5) untuk Aditya Kurniawan', '2026-09-23 07:11:09'),
(143, 1, 'super admin', 'UPDATE', 'Peminjaman', '13', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-5', '2026-09-23 07:11:39'),
(144, 17, 'Aditya Kurniawan', 'UPDATE', 'Peminjaman', '13', 'Memperbarui peminjaman: GKM-PJM-5', '2026-09-23 07:19:44'),
(145, 17, 'Aditya Kurniawan', 'UPDATE', 'Peminjaman', '9', 'Memperbarui peminjaman: GKM-PJM-1', '2026-09-23 07:19:58'),
(146, 17, 'Aditya Kurniawan', 'UPDATE', 'Peminjaman', '10', 'Memperbarui peminjaman: GKM-PJM-2', '2026-09-23 07:20:18'),
(147, 21, 'Eko Prasetyo', 'UPDATE', 'Peminjaman', '9', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-1', '2026-09-23 07:20:57'),
(148, 1, 'super admin', 'UPDATE', 'Peminjaman', '10', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-2', '2026-09-23 07:21:08'),
(149, 1, 'super admin', 'UPDATE', 'Aksesoris', '41', 'Memperbarui aksesoris: SD CARD - 14 (AKS-STD-020)', '2026-09-26 04:33:12'),
(150, 1, 'super admin', 'UPDATE', 'Peminjaman', '13', 'Melakukan approve/verifikasi peminjaman: GKM-PJM-5', '2026-09-26 04:34:07'),
(151, 1, 'super admin', 'UPDATE', 'Aset', '13', 'Memperbarui aset: MIC QA Electronic (AST-PRO-006) (Mengubah: pengguna, keterangan, harga_aset, tanggal_pembelian)', '2026-09-26 04:35:38'),
(152, 1, 'super admin', 'UPDATE', 'Aksesoris', '45', 'Memperbarui aksesoris: KABEL LAN 50M (AKS-STD-022) (Mengubah: jumlah_unit, tanggal_pembelian)', '2026-09-26 04:36:13'),
(153, 17, 'Aditya Kurniawan', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-6) untuk Aditya Kurniawan', '2026-09-26 04:38:18'),
(154, 1, 'super admin', 'APPROVE PEMINJAMAN', 'Peminjaman', '14', 'Menyetujui peminjaman: GKM-PJM-6', '2026-09-26 04:39:01'),
(155, 17, 'Aditya Kurniawan', 'UPDATE', 'Peminjaman', '14', 'Memperbarui peminjaman: GKM-PJM-6 (Mengubah: Tanggal Pengembalian, Status, Bukti Pengembalian)', '2026-09-26 04:39:37'),
(156, 1, 'super admin', 'APPROVE PENGEMBALIAN', 'Peminjaman', '14', 'Memverifikasi pengembalian: GKM-PJM-6', '2026-09-26 04:40:01'),
(157, 1, 'super admin', 'UPDATE', 'Aksesoris', '44', 'Memperbarui jumlah unit pada KABEL LAN 100M (AKS-PRO-021)', '2026-09-26 05:02:31'),
(158, 1, 'super admin', 'UPDATE', 'Aset', '8', 'Memperbarui jenis aset pada Orbit kecil  (AST-STD-004)', '2026-09-26 05:03:25'),
(159, 1, 'super admin', 'UPDATE', 'Aksesoris', '38', 'Memperbarui nama aksesoris, kondisi pada SD CARD - 11 (AKS-PRO-018)', '2026-09-26 07:09:33'),
(160, 1, 'super admin', 'UPDATE', 'Aset', '7', 'Mengubah kondisi aset AST-PRO-003 menjadi: Maintenance', '2026-09-26 07:49:26'),
(161, 1, 'super admin', 'UPDATE', 'Aset', '9', 'Mengubah kondisi aset AST-PRO-004 menjadi: Rusak', '2026-09-26 07:49:32'),
(162, 1, 'Super Admin', 'UPDATE', 'Aksesoris', '40', 'Mengubah kondisi aksesoris AKS-PRO-019 menjadi: Maintenance', '2026-09-28 09:36:29'),
(163, 1, 'Super Admin', 'UPDATE', 'Aksesoris', '22', 'Mengubah kondisi aksesoris AKS-PRO-010 menjadi: Maintenance', '2026-09-28 09:36:37'),
(164, 1, 'Super Admin', 'UPDATE', 'Aksesoris', '22', 'Mengubah kondisi aksesoris AKS-PRO-010 menjadi: Rusak', '2026-09-28 09:36:41'),
(165, 1, 'Super Admin', 'UPDATE', 'Aksesoris', '11', 'Mengubah kondisi aksesoris AKS-STD-005 menjadi: Rusak', '2026-09-28 09:36:46'),
(166, 1, 'Super Admin', 'UPDATE', 'Aksesoris', '5', 'Mengubah kondisi aksesoris AKS-STD-002 menjadi: Maintenance', '2026-09-28 09:36:50'),
(167, 1, 'CEO Ultima', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: tes (ACC-GS-BAT-001)', '2026-09-29 08:28:24'),
(168, 1, 'CEO Ultima', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: tes2 (ACC-GPRO-KBL-001)', '2026-09-29 08:29:28'),
(169, 1, 'CEO Ultima', 'CREATE', 'Aset', NULL, 'Menambahkan aset: tes01 (AST-GS-GEN-001)', '2026-09-29 08:31:23'),
(170, 1, 'CEO Ultima', 'DELETE', 'Aksesoris', '47', 'Menghapus aksesoris: tes2 (ACC-GPRO-KBL-001)', '2026-09-29 08:32:22'),
(171, 1, 'CEO Ultima', 'DELETE', 'Aksesoris', '46', 'Menghapus aksesoris: tes (ACC-GS-BAT-001)', '2026-09-29 08:32:23'),
(172, 1, 'CEO Ultima', 'DELETE', 'Aksesoris', '26', 'Menghapus aksesoris: HARDCASE PARLED (AKS-PRO-012)', '2026-09-29 08:32:57'),
(173, 1, 'CEO Ultima', 'CREATE', 'Aksesoris', NULL, 'Menambahkan aksesoris: tes01 (ACC-GS-C-32-001)', '2026-10-02 11:57:25'),
(174, 1, 'CEO Ultima', 'DELETE', 'Aset', '8', 'Menghapus aset: Orbit kecil  (AST-STD-004)', '2026-10-03 06:16:29'),
(175, 1, 'CEO Ultima', 'DELETE', 'Aset', '7', 'Menghapus aset: Zoom Recoder 03 (AST-PRO-003)', '2026-10-03 06:16:33'),
(176, 1, 'CEO Ultima', 'DELETE', 'Aset', '9', 'Menghapus aset: Video Switcher  (AST-PRO-004)', '2026-10-03 06:16:37'),
(177, 20, 'Aurelia Karisma', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-7) untuk Aurelia Karisma', '2026-10-03 06:22:51'),
(178, 1, 'CEO Ultima', 'APPROVE PEMINJAMAN', 'Peminjaman', '15', 'Menyetujui peminjaman: GKM-PJM-7', '2026-10-03 06:23:19'),
(179, 1, 'CEO Ultima', 'UPDATE', 'Peminjaman', '15', 'Mengisi pengembalian GKM-PJM-7', '2026-10-03 06:23:33'),
(180, 1, 'CEO Ultima', 'APPROVE PENGEMBALIAN', 'Peminjaman', '15', 'Memverifikasi pengembalian: GKM-PJM-7', '2026-10-03 06:23:40'),
(181, 1, 'CEO Ultima', 'UPDATE', 'Peminjaman', '12', 'Mengisi pengembalian GKM-PJM-4', '2026-10-03 06:24:21'),
(182, 1, 'CEO Ultima', 'APPROVE PENGEMBALIAN', 'Peminjaman', '12', 'Memverifikasi pengembalian: GKM-PJM-4', '2026-10-03 06:24:26'),
(183, 1, 'CEO Ultima', 'DELETE', 'Peminjaman', '12', 'Menghapus peminjaman: GKM-PJM-4', '2026-10-03 06:24:29'),
(184, 1, 'CEO Ultima', 'UPDATE', 'Peminjaman', '11', 'Mengisi pengembalian GKM-PJM-3', '2026-10-03 06:25:07'),
(185, 1, 'CEO Ultima', 'APPROVE PENGEMBALIAN', 'Peminjaman', '11', 'Memverifikasi pengembalian: GKM-PJM-3', '2026-10-03 06:25:13'),
(186, 1, 'CEO Ultima', 'DELETE', 'Peminjaman', '11', 'Menghapus peminjaman: GKM-PJM-3', '2026-10-03 06:25:15'),
(187, 1, 'CEO Ultima', 'DELETE', 'Aksesoris', '48', 'Menghapus aksesoris: tes01 (ACC-GS-C-32-001)', '2026-10-20 06:22:56'),
(188, 1, 'CEO Ultima', 'DELETE', 'Aksesoris', '45', 'Menghapus aksesoris: KABEL LAN 50M (AKS-STD-022)', '2026-10-20 06:22:59'),
(189, 1, 'CEO Ultima', 'DELETE', 'Aksesoris', '44', 'Menghapus aksesoris: KABEL LAN 100M (AKS-PRO-021)', '2026-10-20 06:23:02'),
(190, 1, 'CEO Ultima', 'DELETE', 'Aksesoris', '43', 'Menghapus aksesoris: STAND TRIPOD LIGHTING (AKS-STD-021)', '2026-10-20 06:23:13'),
(191, 1, 'CEO Ultima', 'DELETE', 'Aksesoris', '3', 'Menghapus aksesoris: Matador  (AKS-STD-001)', '2026-10-20 06:26:20'),
(192, 1, 'CEO Ultima', 'UPDATE', 'Aset', '19', 'Mengubah kondisi aset AST-GS-GEN-001 menjadi: Rusak', '2026-10-22 09:07:06'),
(193, 1, 'CEO Ultima', 'DELETE', 'System', 'ALL', 'SUPER ADMIN menghapus seluruh data: Aset & Aksesoris', '2026-10-22 09:39:54'),
(194, 1, 'CEO Ultima', 'CREATE', 'Aset', '20', 'Import massal 44 aset dari file Excel', '2026-10-22 09:56:47'),
(195, 1, 'CEO Ultima', 'UPDATE', 'Aset', '20', 'Pemisahan (Split) aset AST-GPRO-VID-001: 3 unit dipindah ke kondisi \"Siap Digunakan\" (Kode baru: AST-GPRO-VID-001-P1), sisa 3 unit.', '2026-10-22 09:57:38'),
(196, 1, 'CEO Ultima', 'UPDATE', 'Aset', '64', 'Mengubah kondisi aset AST-GPRO-VID-001-P1 menjadi: Rusak', '2026-10-22 09:58:02'),
(197, 1, 'CEO Ultima', 'DELETE', 'System', 'ALL', 'SUPER ADMIN menghapus seluruh data: Aset & Aksesoris', '2026-10-22 10:11:58'),
(198, 1, 'CEO Ultima', 'DELETE', 'Peminjaman', '15', 'Menghapus peminjaman: GKM-PJM-7', '2026-10-23 07:21:08'),
(199, 1, 'CEO Ultima', 'DELETE', 'Peminjaman', '14', 'Menghapus peminjaman: GKM-PJM-6', '2026-10-23 07:21:10'),
(200, 1, 'CEO Ultima', 'DELETE', 'Peminjaman', '13', 'Menghapus peminjaman: GKM-PJM-5', '2026-10-23 07:21:11'),
(201, 1, 'CEO Ultima', 'DELETE', 'Peminjaman', '10', 'Menghapus peminjaman: GKM-PJM-2', '2026-10-23 07:21:13'),
(202, 1, 'CEO Ultima', 'DELETE', 'Peminjaman', '9', 'Menghapus peminjaman: GKM-PJM-1', '2026-10-23 07:21:15'),
(203, 1, 'CEO Ultima', 'CREATE', 'Aset', '65', 'Import massal 44 aset dari file Excel', '2026-10-23 07:21:35'),
(204, 1, 'CEO Ultima', 'CREATE', 'Aset', '109', 'Import massal 44 aset dari file Excel', '2026-10-23 07:35:34'),
(205, 1, 'CEO Ultima', 'DELETE', 'System', 'ALL', 'SUPER ADMIN menghapus seluruh data: Aset & Aksesoris', '2026-10-23 07:35:47'),
(206, 1, 'CEO Ultima', 'CREATE', 'Aset', '153', 'Import massal 44 aset dari file Excel', '2026-10-23 07:35:56'),
(207, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '299', 'Mengubah unit AST-GPRO-VID-001-01: kondisi menjadi Maintenance', '2026-10-23 10:23:37'),
(208, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '300', 'Mengubah unit AST-GPRO-VID-001-02: kondisi menjadi Maintenance', '2026-10-23 10:23:39'),
(209, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '301', 'Mengubah unit AST-GPRO-VID-001-03: kondisi menjadi Rusak', '2026-10-23 10:23:40'),
(210, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '302', 'Mengubah unit AST-GPRO-VID-001-04: kondisi menjadi Rusak', '2026-10-23 10:23:42'),
(211, 17, 'Aditya Kurniawan', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-1) untuk Aditya Kurniawan', '2026-10-31 07:04:02'),
(212, 18, 'Bayu Pratama', 'APPROVE PEMINJAMAN', 'Peminjaman', '16', 'Menyetujui peminjaman: GKM-PJM-1', '2026-10-31 07:20:07'),
(213, 17, 'Aditya Kurniawan', 'UPDATE', 'Peminjaman', '16', 'Mengisi pengembalian GKM-PJM-1', '2026-10-31 07:28:07'),
(214, 1, 'CEO Ultima', 'APPROVE PENGEMBALIAN', 'Peminjaman', '16', 'Memverifikasi pengembalian: GKM-PJM-1', '2026-10-31 07:28:36'),
(215, 1, 'CEO Ultima', 'DELETE', 'Peminjaman', '16', 'Menghapus peminjaman: GKM-PJM-1', '2026-10-31 08:43:50'),
(216, 1, 'CEO Ultima', 'CREATE', 'Aksesoris', '49', 'Import massal 52 aksesoris dari file Excel', '2026-10-31 09:12:40'),
(217, 17, 'Aditya Kurniawan', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-1) untuk Aditya Kurniawan', '2026-10-31 09:15:47'),
(218, 18, 'Bayu Pratama', 'APPROVE PEMINJAMAN', 'Peminjaman', '17', 'Menyetujui peminjaman: GKM-PJM-1', '2026-10-31 09:18:14'),
(219, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '1', 'Mengubah unit aksesoris ACC-GPRO-BAT-001-01: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 09:19:51'),
(220, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '2', 'Mengubah unit aksesoris ACC-GPRO-BAT-001-02: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 09:19:52'),
(221, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '3', 'Mengubah unit aksesoris ACC-GPRO-BAT-001-03: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 09:19:56'),
(222, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '6', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-02: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak Berat\"', '2026-10-31 09:20:17'),
(223, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '7', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-03: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak Berat\"', '2026-10-31 09:20:18'),
(224, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '8', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-04: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 09:20:20'),
(225, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '10', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-06: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak Berat\"', '2026-10-31 09:20:21'),
(226, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '9', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-05: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 09:20:24'),
(227, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '12', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-08: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 09:20:26'),
(228, 1, 'CEO Ultima', 'UPDATE', 'Peminjaman', '17', 'Mengisi pengembalian GKM-PJM-1', '2026-10-31 09:42:55'),
(229, 1, 'CEO Ultima', 'APPROVE PENGEMBALIAN', 'Peminjaman', '17', 'Memverifikasi pengembalian: GKM-PJM-1', '2026-10-31 09:43:15'),
(230, 1, 'CEO Ultima', 'DELETE', 'System', 'ALL', 'SUPER ADMIN menghapus seluruh data: Aset & Aksesoris', '2026-10-31 09:43:22'),
(231, 1, 'CEO Ultima', 'DELETE', 'Peminjaman', '17', 'Menghapus peminjaman: GKM-PJM-1', '2026-10-31 09:46:36'),
(232, 1, 'CEO Ultima', 'CREATE', 'Aset', '197', 'Import massal 50 aset dari file Excel', '2026-10-31 10:11:24'),
(233, 1, 'CEO Ultima', 'CREATE', 'Aksesoris', '101', 'Import massal 52 aksesoris dari file Excel', '2026-10-31 10:11:40'),
(234, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '157', 'Mengubah unit aksesoris ACC-GPRO-BAT-001-01: kondisi diubah dari \"Siap Digunakan\" menjadi \"Sedang Dipinjam\", status pinjam diubah dari \"Tersedia\" menjadi \"Dipinjam\"', '2026-10-31 10:12:51'),
(235, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '157', 'Mengubah unit aksesoris ACC-GPRO-BAT-001-01: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 10:23:11'),
(236, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '158', 'Mengubah unit aksesoris ACC-GPRO-BAT-001-02: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 10:23:13'),
(237, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '161', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-01: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 10:23:33'),
(238, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '162', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-02: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:23:34'),
(239, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '164', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-04: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:23:35'),
(240, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '166', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-06: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:23:38'),
(241, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '169', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-09: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 10:23:39'),
(242, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '170', 'Mengubah unit aksesoris ACC-GPRO-KAB-001-10: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:23:41'),
(243, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '172', 'Mengubah unit aksesoris ACC-GPRO-BAT-002-02: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:23:46'),
(244, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '173', 'Mengubah unit aksesoris ACC-GPRO-BAT-002-03: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 10:23:48'),
(245, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '186', 'Mengubah unit aksesoris ACC-GPRO-BAT-003-02: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 10:23:51'),
(246, 1, 'CEO Ultima', 'UPDATE', 'Aksesoris Unit', '188', 'Mengubah unit aksesoris ACC-GPRO-BAT-003-04: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:23:53'),
(247, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '448', 'Mengubah unit AST-GPRO-CAM-001-01: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:24:03'),
(248, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '450', 'Mengubah unit AST-GPRO-VID-001-02: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 10:24:12'),
(249, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '452', 'Mengubah unit AST-GPRO-VID-001-04: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:24:13'),
(250, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '451', 'Mengubah unit AST-GPRO-VID-001-03: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:24:14'),
(251, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '456', 'Mengubah unit AST-GPRO-CAM-003-01: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 10:24:21'),
(252, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '459', 'Mengubah unit AST-GPRO-LEN-002-01: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 10:24:25'),
(253, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '461', 'Mengubah unit AST-GPRO-LEN-004-01: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 10:24:28'),
(254, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '474', 'Mengubah unit AST-GPRO-WIR-001-02: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:25:45'),
(255, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '500', 'Mengubah unit AST-GPRO-LIG-001-02: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:26:00'),
(256, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '499', 'Mengubah unit AST-GPRO-LIG-001-01: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:26:01'),
(257, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '487', 'Mengubah unit AST-GPRO-AUD-004-01: kondisi diubah dari \"Siap Digunakan\" menjadi \"Maintenance\"', '2026-10-31 10:26:06'),
(258, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '492', 'Mengubah unit AST-GPRO-AUD-007-02: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:26:11'),
(259, 1, 'CEO Ultima', 'UPDATE', 'Aset Unit', '502', 'Mengubah unit AST-GPRO-LIG-002-02: kondisi diubah dari \"Siap Digunakan\" menjadi \"Rusak\"', '2026-10-31 10:26:14');

-- --------------------------------------------------------

--
-- Struktur dari tabel `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `tipe` enum('aset','aksesoris') NOT NULL DEFAULT 'aset',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `brands`
--

INSERT INTO `brands` (`id`, `nama`, `tipe`, `created_at`) VALUES
(1, 'Sony', 'aset', '2026-06-12 06:21:22'),
(3, 'Soni', 'aksesoris', '2026-06-12 06:26:44'),
(4, 'Colorlight', 'aset', '2026-06-22 02:30:37'),
(5, 'HUAWEI', 'aksesoris', '2026-06-22 07:12:03'),
(6, 'H4nPro', 'aset', '2026-06-22 08:10:34'),
(7, 'ZOOM', 'aset', '2026-06-22 08:31:59'),
(8, 'TELKOMSEL', 'aset', '2026-06-22 08:51:37'),
(9, 'FEELWORLD', 'aset', '2026-06-22 09:02:35'),
(10, 'Epson', 'aset', '2026-06-29 02:09:32'),
(11, 'Behringer', 'aset', '2026-06-29 07:13:14'),
(12, 'VENTION', 'aksesoris', '2026-06-29 07:18:00'),
(13, 'UGREEN', 'aksesoris', '2026-06-29 07:29:07'),
(14, 'TAKARA', 'aksesoris', '2026-07-01 07:56:39'),
(15, 'BENRO', 'aksesoris', '2026-07-01 08:03:58'),
(16, 'ZEIS', 'aksesoris', '2026-07-01 08:24:27'),
(17, 'SAMYANG', 'aksesoris', '2026-07-01 08:27:20'),
(24, 'SONY', 'aksesoris', '2026-07-01 12:40:33'),
(25, 'Non Merk', 'aksesoris', '2026-07-02 01:54:25'),
(26, 'Lunar', 'aksesoris', '2026-07-02 02:09:31'),
(27, 'QA electronic', 'aksesoris', '2026-07-02 02:22:07'),
(28, 'SANDISK', 'aksesoris', '2026-07-02 07:23:38'),
(29, 'QA', 'aset', '2026-07-08 07:03:25'),
(30, 'Absen', 'aset', '2026-11-02 03:41:00'),
(31, 'Blackmagic', 'aset', '2026-11-02 03:41:00'),
(32, 'Canon', 'aset', '2026-11-02 03:41:00'),
(33, 'DJI', 'aset', '2026-11-02 03:41:00'),
(34, 'Manfrotto', 'aset', '2026-11-02 03:41:00'),
(35, 'E-Image', 'aset', '2026-11-02 03:41:00'),
(36, 'Konova', 'aset', '2026-11-02 03:41:00'),
(37, 'Hollyland', 'aset', '2026-11-02 03:41:00'),
(38, 'Atomos', 'aset', '2026-11-02 03:41:00'),
(39, 'Sennheiser', 'aset', '2026-11-02 03:41:00'),
(40, 'Rode', 'aset', '2026-11-02 03:41:00'),
(41, 'Yamaha', 'aset', '2026-11-02 03:41:00'),
(42, 'Aputure', 'aset', '2026-11-02 03:41:00'),
(43, 'Nanlite', 'aset', '2026-11-02 03:41:00'),
(44, 'Kupo', 'aset', '2026-11-02 03:41:00'),
(45, 'StageLight', 'aset', '2026-11-02 03:41:00'),
(46, 'NightSun', 'aset', '2026-11-02 03:41:00'),
(47, 'Avolites Replica', 'aset', '2026-11-02 03:41:00'),
(48, 'NovaStar', 'aset', '2026-11-02 03:41:00'),
(49, 'Elgato', 'aset', '2026-11-02 03:41:00'),
(50, 'ASUS', 'aset', '2026-11-02 03:41:00'),
(51, 'Lenovo', 'aset', '2026-11-02 03:41:00'),
(52, 'SmallRig', 'aset', '2026-11-02 03:41:00'),
(53, 'Belden', 'aset', '2026-11-02 03:41:00'),
(54, 'Custom', 'aset', '2026-11-02 03:41:00'),
(55, 'Honda', 'aset', '2026-11-02 03:41:00'),
(56, 'Canare', 'aksesoris', '2026-11-02 03:41:00'),
(57, 'Canon', 'aksesoris', '2026-11-02 03:41:00'),
(58, 'SmallRig', 'aksesoris', '2026-11-02 03:41:00'),
(59, 'Uticon', 'aksesoris', '2026-11-02 03:41:00'),
(60, 'Broco', 'aksesoris', '2026-11-02 03:41:00'),
(61, 'Kingston', 'aksesoris', '2026-11-02 03:41:00'),
(62, 'Samsung', 'aksesoris', '2026-11-02 03:41:00'),
(63, 'Feelworld', 'aksesoris', '2026-11-02 03:41:00'),
(64, 'Sirui', 'aksesoris', '2026-11-02 03:41:00'),
(65, 'Hollyland', 'aksesoris', '2026-11-02 03:41:00'),
(66, 'Røde', 'aksesoris', '2026-11-02 03:41:00'),
(67, 'Audio-Technica', 'aksesoris', '2026-11-02 03:41:00'),
(68, 'Godox', 'aksesoris', '2026-11-02 03:41:00'),
(69, 'Kupo', 'aksesoris', '2026-11-02 03:41:00'),
(70, 'Jinbei', 'aksesoris', '2026-11-02 03:41:00'),
(71, 'Aputure', 'aksesoris', '2026-11-02 03:41:00'),
(72, 'Hoya', 'aksesoris', '2026-11-02 03:41:00'),
(73, 'Nisi', 'aksesoris', '2026-11-02 03:41:00'),
(74, 'K&F Concept', 'aksesoris', '2026-11-02 03:41:00'),
(75, 'Giottos', 'aksesoris', '2026-11-02 03:41:00'),
(76, 'Lenspen', 'aksesoris', '2026-11-02 03:41:00'),
(77, 'VSGO', 'aksesoris', '2026-11-02 03:41:00'),
(78, 'Tilta', 'aksesoris', '2026-11-02 03:41:00'),
(79, 'Vanguard', 'aksesoris', '2026-11-02 03:41:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `kode_singkat` varchar(10) NOT NULL,
  `tipe` enum('aset','aksesoris') NOT NULL DEFAULT 'aset',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`id`, `nama`, `kode_singkat`, `tipe`, `created_at`) VALUES
(1, 'Kamera', 'CAM', 'aset', '2026-06-12 06:21:14'),
(2, 'Baterai Kamera', 'BAT', 'aksesoris', '2026-06-12 06:25:47'),
(3, 'Video Processor', 'VPROC', 'aset', '2026-06-22 02:30:10'),
(4, 'ORBIT HUAWEI', 'ORBIT', 'aksesoris', '2026-06-22 07:11:52'),
(5, 'matador', 'STAND TV', 'aksesoris', '2026-06-22 07:20:37'),
(6, 'Stand Tv putih', 'STAND TV P', 'aksesoris', '2026-06-22 07:27:52'),
(7, 'ZOOM', 'ZOOM', 'aset', '2026-06-22 08:10:01'),
(8, 'Recorder Kecil', 'RECORDER', 'aset', '2026-06-22 08:32:29'),
(9, 'ORBIT', 'ORBIT', 'aset', '2026-06-22 08:51:27'),
(10, 'Switcher', 'VIDEO SWIT', 'aset', '2026-06-22 09:02:12'),
(11, 'Printer', 'PRINT', 'aset', '2026-06-29 02:09:00'),
(12, 'Kabel Genset', 'KABEL', 'aksesoris', '2026-06-29 07:09:48'),
(13, 'Audio Interface', 'AUDIO INTE', 'aset', '2026-06-29 07:12:58'),
(14, 'KABEL HDMI', 'KABEL HDMI', 'aksesoris', '2026-06-29 07:17:46'),
(15, 'Kabel usb', 'U', 'aksesoris', '2026-06-29 07:27:22'),
(16, 'STAND FLASH', 'STAND', 'aksesoris', '2026-07-01 07:56:16'),
(20, 'Stand kamera', 'STND', 'aksesoris', '2026-07-01 08:03:45'),
(21, 'LENSA', 'LENSA', 'aksesoris', '2026-07-01 08:24:16'),
(22, 'hardcase', 'HRC', 'aksesoris', '2026-07-02 01:51:14'),
(23, 'CARD 64', 'C-64', 'aksesoris', '2026-07-02 07:23:09'),
(24, 'CARD 32', 'C-32', 'aksesoris', '2026-07-02 07:51:54'),
(25, 'STAND TRIPOD', 'STN', 'aksesoris', '2026-07-04 02:34:50'),
(26, 'KABEL', 'KSN', 'aset', '2026-07-04 02:41:04'),
(31, 'KABEL LAN', 'KBL', 'aksesoris', '2026-07-04 04:12:53'),
(32, 'MIC', 'MIC', 'aset', '2026-07-08 07:03:17'),
(33, 'Videotron', 'VIDE', 'aset', '2026-11-02 03:41:00'),
(34, 'Lensa', 'LENS', 'aset', '2026-11-02 03:41:00'),
(35, 'Stabilizer', 'STAB', 'aset', '2026-11-02 03:41:00'),
(36, 'Grip & Support', 'GRSU', 'aset', '2026-11-02 03:41:00'),
(37, 'Drone', 'DRON', 'aset', '2026-11-02 03:41:00'),
(38, 'Wireless Video', 'WIVI', 'aset', '2026-11-02 03:41:00'),
(39, 'Monitor', 'MONI', 'aset', '2026-11-02 03:41:00'),
(40, 'Audio', 'AUDI', 'aset', '2026-11-02 03:41:00'),
(41, 'Audio Support', 'AUSU', 'aset', '2026-11-02 03:41:00'),
(42, 'Sound System', 'SOSY', 'aset', '2026-11-02 03:41:00'),
(43, 'Lighting', 'LIGH', 'aset', '2026-11-02 03:41:00'),
(44, 'Lighting Mod', 'LIMO', 'aset', '2026-11-02 03:41:00'),
(45, 'Lighting Event', 'LIEV', 'aset', '2026-11-02 03:41:00'),
(46, 'Broadcast', 'BROA', 'aset', '2026-11-02 03:41:00'),
(47, 'Intercom', 'INTE', 'aset', '2026-11-02 03:41:00'),
(48, 'Komputer/IT', 'KOMP', 'aset', '2026-11-02 03:41:00'),
(49, 'Aksesoris Daya', 'AKDA', 'aset', '2026-11-02 03:41:00'),
(50, 'Perkabelan', 'PERK', 'aset', '2026-11-02 03:41:00'),
(51, 'Kelistrikan', 'KELI', 'aset', '2026-11-02 03:41:00'),
(52, 'Baterai', 'BATE', 'aksesoris', '2026-11-02 03:41:00'),
(53, 'Kabel', 'KABE', 'aksesoris', '2026-11-02 03:41:00'),
(54, 'Charger', 'CHAR', 'aksesoris', '2026-11-02 03:41:00'),
(55, 'Aksesoris Daya', 'AKD1', 'aksesoris', '2026-11-02 03:41:00'),
(56, 'Kelistrikan', 'KEL1', 'aksesoris', '2026-11-02 03:41:00'),
(57, 'Media Simpan', 'MESI', 'aksesoris', '2026-11-02 03:41:00'),
(58, 'Aksesoris Media', 'AKME', 'aksesoris', '2026-11-02 03:41:00'),
(59, 'Monitor', 'MON1', 'aksesoris', '2026-11-02 03:41:00'),
(60, 'Aksesoris Monitor', 'AKMO', 'aksesoris', '2026-11-02 03:41:00'),
(61, 'Rigging', 'RIGG', 'aksesoris', '2026-11-02 03:41:00'),
(62, 'Aksesoris Tripod', 'AKTR', 'aksesoris', '2026-11-02 03:41:00'),
(63, 'Audio', 'AUD1', 'aksesoris', '2026-11-02 03:41:00'),
(64, 'Aksesoris Audio', 'AKAU', 'aksesoris', '2026-11-02 03:41:00'),
(65, 'Lighting Stand', 'LIST', 'aksesoris', '2026-11-02 03:41:00'),
(66, 'Grip', 'GRIP', 'aksesoris', '2026-11-02 03:41:00'),
(67, 'Modifier', 'MODI', 'aksesoris', '2026-11-02 03:41:00'),
(68, 'Aksesoris Lighting', 'AKLI', 'aksesoris', '2026-11-02 03:41:00'),
(69, 'Filter Lensa', 'FILE', 'aksesoris', '2026-11-02 03:41:00'),
(70, 'Aksesoris Lensa', 'AKLE', 'aksesoris', '2026-11-02 03:41:00'),
(71, 'Maintenance', 'MAIN', 'aksesoris', '2026-11-02 03:41:00'),
(72, 'Proteksi & Transport', 'PRTR', 'aksesoris', '2026-11-02 03:41:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `target_roles` varchar(255) NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `message`, `reference_id`, `target_roles`, `is_read`, `created_at`) VALUES
(1, 'peminjaman_baru', 'Cahyo membuat peminjaman baru (GKM-PJM-1)', NULL, 'super admin,admin,supervisor', 1, '2026-06-12 06:28:55'),
(2, 'stok_rendah_aset', 'Stok Sony A7C tersisa 0 unit', 1, 'super admin,admin', 1, '2026-06-12 06:28:55'),
(3, 'stok_rendah_aks', 'Stok Baterai Kamera NP-FZ100 tersisa 3 unit', 1, 'super admin,admin', 1, '2026-06-12 06:28:55'),
(4, 'approved', 'Peminjaman GKM-PJM-1 telah disetujui untuk dipinjam oleh Supervisor [Peminjam: Cahyo] [By: User]', 1, 'super admin,admin,supervisor,user', 1, '2026-06-12 06:29:27'),
(5, 'dikembalikan', 'Peminjaman GKM-PJM-1 menunggu verifikasi pengembalian dari Cahyo', 1, 'super admin,admin,supervisor', 1, '2026-06-12 06:30:52'),
(6, 'approved', 'Peminjaman GKM-PJM-1 telah diverifikasi pengembaliannya oleh Supervisor [Peminjam: Cahyo] [By: User]', 1, 'super admin,admin,supervisor,user', 1, '2026-06-12 06:31:39'),
(7, 'peminjaman_baru', 'Cahyo membuat peminjaman baru (GKM-PJM-2)', NULL, 'super admin,admin,supervisor', 1, '2026-06-12 07:50:15'),
(8, 'stok_rendah_aset', 'Stok Sony A7C tersisa 0 unit', 1, 'super admin,admin', 1, '2026-06-12 07:50:15'),
(9, 'approved', 'Peminjaman GKM-PJM-2 telah disetujui untuk dipinjam oleh super admin [Peminjam: Cahyo] [By: User]', 2, 'super admin,admin,supervisor,user', 1, '2026-06-23 06:03:41'),
(10, 'peminjaman_baru', 'Favian membuat peminjaman baru (GKM-PJM-2)', NULL, 'super admin,admin,supervisor', 1, '2026-09-14 07:25:51'),
(11, 'stok_rendah_aset', 'Stok MIC QA Electronic tersisa 0 unit', 13, 'super admin,admin', 1, '2026-09-14 07:25:51'),
(12, 'stok_rendah_aks', 'Stok KABEL LAN 50M tersisa 3 unit', 45, 'super admin,admin', 1, '2026-09-14 07:25:51'),
(13, 'approved', 'Peminjaman GKM-PJM-2 telah disetujui untuk dipinjam oleh super admin [Peminjam: Favian] [By: super admin]', 3, 'super admin,admin,supervisor,user', 1, '2026-09-14 07:27:07'),
(14, 'dikembalikan', 'Peminjaman GKM-PJM-2 menunggu verifikasi pengembalian dari Favian', 3, 'super admin,admin,supervisor', 1, '2026-09-14 07:27:34'),
(15, 'approved', 'Peminjaman GKM-PJM-2 telah diverifikasi pengembaliannya oleh super admin [Peminjam: Favian] [By: super admin]', 3, 'super admin,admin,supervisor,user', 1, '2026-09-14 07:27:46'),
(16, 'peminjaman_baru', 'Dandi membuat peminjaman baru (GKM-PJM-3)', NULL, 'super admin,admin,supervisor', 1, '2026-09-14 07:33:41'),
(17, 'stok_rendah_aset', 'Stok MIC QA Electronic tersisa 0 unit', 13, 'super admin,admin', 1, '2026-09-14 07:33:41'),
(18, 'approved', 'Peminjaman GKM-PJM-3 telah disetujui untuk dipinjam oleh super admin [Peminjam: Dandi] [By: User]', 4, 'super admin,admin,supervisor,user', 1, '2026-09-14 07:33:57'),
(19, 'dikembalikan', 'Peminjaman GKM-PJM-3 menunggu verifikasi pengembalian dari Dandi', 4, 'super admin,admin,supervisor', 1, '2026-09-15 07:57:27'),
(20, 'peminjaman_baru', 'Aditya Kurniawan membuat peminjaman baru (GKM-PJM-1)', NULL, 'super admin,admin,supervisor', 1, '2026-09-18 06:21:00'),
(21, 'stok_rendah_aset', 'Stok MIC QA Electronic tersisa 0 unit', 13, 'super admin,admin', 1, '2026-09-18 06:21:00'),
(22, 'stok_rendah_aset', 'Stok Audio Interface tersisa 0 unit', 11, 'super admin,admin', 1, '2026-09-18 06:21:00'),
(23, 'stok_rendah_aks', 'Stok Lensa Sony 35 F 1.8 tersisa 0 unit', 19, 'super admin,admin', 1, '2026-09-18 06:21:00'),
(24, 'stok_rendah_aks', 'Stok Lensa Sony 85 F 1.8 tersisa 0 unit', 16, 'super admin,admin', 1, '2026-09-18 06:21:00'),
(25, 'approved', 'Peminjaman GKM-PJM-1 telah disetujui untuk dipinjam oleh [object Object] [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 5, 'super admin,admin,supervisor,user', 1, '2026-09-18 06:22:06'),
(26, 'peminjaman_baru', 'Aditya Kurniawan membuat peminjaman baru (GKM-PJM-2)', NULL, 'super admin,admin,supervisor', 1, '2026-09-18 06:26:18'),
(27, 'stok_rendah_aks', 'Stok Kabel Hdmi  2 M  tersisa 0 unit', 8, 'super admin,admin', 1, '2026-09-18 06:26:18'),
(28, 'stok_rendah_aks', 'Stok Kabel Genset tersisa 0 unit', 5, 'super admin,admin', 1, '2026-09-18 06:26:18'),
(29, 'dikembalikan', 'Peminjaman GKM-PJM-1 menunggu verifikasi pengembalian dari Aditya Kurniawan', 5, 'super admin,admin,supervisor', 1, '2026-09-18 08:02:53'),
(30, 'approved', 'Peminjaman GKM-PJM-2 telah disetujui untuk dipinjam oleh Citra Ayu [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 6, 'super admin,admin,supervisor,user', 1, '2026-09-18 08:15:55'),
(31, 'peminjaman_baru', 'Aditya Kurniawan membuat peminjaman baru (GKM-PJM-3)', NULL, 'super admin,admin,supervisor', 1, '2026-09-22 04:21:31'),
(32, 'stok_rendah_aset', 'Stok Zoom Recorder kecil 02 tersisa 0 unit', 6, 'super admin,admin', 1, '2026-09-22 04:21:31'),
(33, 'stok_rendah_aks', 'Stok STAND TRIPOD LIGHTING tersisa 3 unit', 43, 'super admin,admin', 1, '2026-09-22 04:21:31'),
(34, 'peminjaman_baru', 'Aditya Kurniawan membuat peminjaman baru (GKM-PJM-4)', NULL, 'super admin,admin,supervisor', 1, '2026-09-22 04:33:11'),
(35, 'stok_rendah_aset', 'Stok KABEL SNAKE 16 CHANNEL tersisa 0 unit', 12, 'super admin,admin', 1, '2026-09-22 04:33:12'),
(36, 'stok_rendah_aks', 'Stok Lensa Zeis 25 F 2 tersisa 0 unit', 21, 'super admin,admin', 1, '2026-09-22 04:33:12'),
(37, 'approved', 'Peminjaman GKM-PJM-4 telah disetujui untuk dipinjam oleh Citra Ayu [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 8, 'super admin,admin,supervisor,user', 1, '2026-09-22 04:34:34'),
(38, 'peminjaman_baru', 'Aditya Kurniawan membuat peminjaman baru (GKM-PJM-1)', NULL, 'super admin,admin,supervisor', 1, '2026-09-23 06:30:47'),
(39, 'stok_rendah_aset', 'Stok Audio Interface tersisa 0 unit', 11, 'super admin,admin', 1, '2026-09-23 06:30:47'),
(40, 'stok_rendah_aks', 'Stok hardcase parled tersisa 1 unit', 23, 'super admin,admin', 1, '2026-09-23 06:30:47'),
(41, 'approved', 'Peminjaman GKM-PJM-1 telah disetujui untuk dipinjam oleh Bayu Pratama [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 9, 'super admin,admin,supervisor,user', 1, '2026-09-23 06:32:48'),
(42, 'peminjaman_baru', 'Aditya Kurniawan membuat peminjaman baru (GKM-PJM-2)', NULL, 'super admin,admin,supervisor', 1, '2026-09-23 06:39:40'),
(43, 'stok_rendah_aks', 'Stok HARDCASE SOUND HUPER tersisa 1 unit', 24, 'super admin,admin', 1, '2026-09-23 06:39:40'),
(44, 'approved', 'Peminjaman GKM-PJM-2 telah disetujui untuk dipinjam oleh Eko Prasetyo [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 10, 'super admin,admin,supervisor,user', 1, '2026-09-23 06:42:50'),
(45, 'peminjaman_baru', 'Bayu Pratama membuat peminjaman baru (GKM-PJM-3)', NULL, 'super admin,admin,supervisor', 1, '2026-09-23 06:46:30'),
(46, 'stok_rendah_aks', 'Stok Kabel Hdmi  2 M  tersisa 0 unit', 8, 'super admin,admin', 1, '2026-09-23 06:46:30'),
(47, 'stok_rendah_aks', 'Stok Kabel Hdmi 1,5 M  tersisa 1 unit', 7, 'super admin,admin', 1, '2026-09-23 06:46:30'),
(48, 'approved', 'Peminjaman GKM-PJM-3 telah disetujui untuk dipinjam oleh Eko Prasetyo [Peminjam: Bayu Pratama] [By: Bayu Pratama]', 11, 'super admin,admin,supervisor,user', 1, '2026-09-23 06:53:01'),
(49, 'peminjaman_baru', 'Eko Prasetyo membuat peminjaman baru (GKM-PJM-4)', NULL, 'super admin,admin,supervisor', 1, '2026-09-23 07:08:34'),
(50, 'stok_rendah_aks', 'Stok hardcase parled tersisa 0 unit', 23, 'super admin,admin', 1, '2026-09-23 07:08:34'),
(51, 'stok_rendah_aset', 'Stok Zoom Recoder kecil 01 tersisa 0 unit', 5, 'super admin,admin', 1, '2026-09-23 07:08:34'),
(52, 'approved', 'Peminjaman GKM-PJM-4 telah disetujui untuk dipinjam oleh Citra Ayu [Peminjam: Eko Prasetyo] [By: Eko Prasetyo]', 12, 'super admin,admin,supervisor,user', 1, '2026-09-23 07:09:56'),
(53, 'peminjaman_baru', 'Aditya Kurniawan membuat peminjaman baru (GKM-PJM-5)', NULL, 'super admin,admin,supervisor', 1, '2026-09-23 07:11:09'),
(54, 'stok_rendah_aks', 'Stok HARDCASE FOLLOWSPOT tersisa 0 unit', 25, 'super admin,admin', 1, '2026-09-23 07:11:09'),
(55, 'approved', 'Peminjaman GKM-PJM-5 telah disetujui untuk dipinjam oleh super admin [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 13, 'super admin,admin,supervisor,user', 1, '2026-09-23 07:11:39'),
(56, 'dikembalikan', 'Peminjaman GKM-PJM-5 menunggu verifikasi pengembalian dari Aditya Kurniawan', 13, 'super admin,admin,supervisor', 1, '2026-09-23 07:19:44'),
(57, 'dikembalikan', 'Peminjaman GKM-PJM-1 menunggu verifikasi pengembalian dari Aditya Kurniawan', 9, 'super admin,admin,supervisor', 1, '2026-09-23 07:19:58'),
(58, 'dikembalikan', 'Peminjaman GKM-PJM-2 menunggu verifikasi pengembalian dari Aditya Kurniawan', 10, 'super admin,admin,supervisor', 1, '2026-09-23 07:20:18'),
(59, 'approved', 'Peminjaman GKM-PJM-1 telah diverifikasi pengembaliannya oleh Eko Prasetyo [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 9, 'super admin,admin,supervisor,user', 1, '2026-09-23 07:20:57'),
(60, 'approved', 'Peminjaman GKM-PJM-2 telah diverifikasi pengembaliannya oleh super admin [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 10, 'super admin,admin,supervisor,user', 1, '2026-09-23 07:21:08'),
(61, 'approved', 'Peminjaman GKM-PJM-5 telah diverifikasi pengembaliannya oleh super admin [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 13, 'super admin,admin,supervisor,user', 1, '2026-09-26 04:34:07'),
(62, 'peminjaman_baru', 'Aditya Kurniawan membuat peminjaman baru (GKM-PJM-6)', NULL, 'super admin,admin,supervisor', 1, '2026-09-26 04:38:18'),
(63, 'stok_rendah_aks', 'Stok Lensa Samyang V-AF 35 F 1.9 tersisa 0 unit', 18, 'super admin,admin', 1, '2026-09-26 04:38:18'),
(64, 'stok_rendah_aset', 'Stok KABEL SNAKE 16 CHANNEL tersisa 0 unit', 12, 'super admin,admin', 1, '2026-09-26 04:38:18'),
(65, 'approved', 'Peminjaman GKM-PJM-6 telah disetujui untuk dipinjam oleh super admin [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 14, 'super admin,admin,supervisor,user', 1, '2026-09-26 04:39:01'),
(66, 'dikembalikan', 'Peminjaman GKM-PJM-6 menunggu verifikasi pengembalian dari Aditya Kurniawan', 14, 'super admin,admin,supervisor', 1, '2026-09-26 04:39:37'),
(67, 'approved', 'Peminjaman GKM-PJM-6 telah diverifikasi pengembaliannya oleh super admin [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 14, 'super admin,admin,supervisor,user', 1, '2026-09-26 04:40:01'),
(68, 'peminjaman_baru', 'Aurelia Karisma membuat peminjaman baru (GKM-PJM-7)', NULL, 'super admin,admin,supervisor', 0, '2026-10-03 06:22:51'),
(69, 'stok_rendah_aset', 'Stok tes01 tersisa 1 unit', 19, 'super admin,admin', 0, '2026-10-03 06:22:51'),
(70, 'stok_rendah_aks', 'Stok tes01 tersisa 1 unit', 48, 'super admin,admin', 0, '2026-10-03 06:22:51'),
(71, 'approved', 'Peminjaman GKM-PJM-7 telah disetujui untuk dipinjam oleh CEO Ultima [Peminjam: Aurelia Karisma] [By: Aurelia Karisma]', 15, 'super admin,admin,supervisor,user', 0, '2026-10-03 06:23:19'),
(72, 'dikembalikan', 'Peminjaman GKM-PJM-7 menunggu verifikasi pengembalian dari Aurelia Karisma', 15, 'super admin,admin,supervisor', 0, '2026-10-03 06:23:33'),
(73, 'approved', 'Peminjaman GKM-PJM-7 telah diverifikasi pengembaliannya oleh CEO Ultima [Peminjam: Aurelia Karisma] [By: Aurelia Karisma]', 15, 'super admin,admin,supervisor,user', 0, '2026-10-03 06:23:40'),
(74, 'dikembalikan', 'Peminjaman GKM-PJM-4 menunggu verifikasi pengembalian dari Eko Prasetyo', 12, 'super admin,admin,supervisor', 0, '2026-10-03 06:24:21'),
(75, 'approved', 'Peminjaman GKM-PJM-4 telah diverifikasi pengembaliannya oleh CEO Ultima [Peminjam: Eko Prasetyo] [By: Eko Prasetyo]', 12, 'super admin,admin,supervisor,user', 0, '2026-10-03 06:24:26'),
(76, 'dikembalikan', 'Peminjaman GKM-PJM-3 menunggu verifikasi pengembalian dari Bayu Pratama', 11, 'super admin,admin,supervisor', 0, '2026-10-03 06:25:07'),
(77, 'approved', 'Peminjaman GKM-PJM-3 telah diverifikasi pengembaliannya oleh CEO Ultima [Peminjam: Bayu Pratama] [By: Bayu Pratama]', 11, 'super admin,admin,supervisor,user', 0, '2026-10-03 06:25:13'),
(78, 'peminjaman_baru', 'Aditya Kurniawan membuat peminjaman baru (GKM-PJM-1)', NULL, 'super admin,admin,supervisor', 0, '2026-10-31 07:04:02'),
(79, 'stok_rendah_aset', 'Stok Videotron a - 50 x 100 ncled tersisa 0 unit', 153, 'super admin,admin', 0, '2026-10-31 07:04:02'),
(80, 'stok_rendah_aset', 'Stok Videotron b - 50 x 100 ncled tersisa 0 unit', 154, 'super admin,admin', 0, '2026-10-31 07:04:02'),
(81, 'stok_rendah_aset', 'Stok Videotron c - 50 x 100 ncled tersisa 0 unit', 155, 'super admin,admin', 0, '2026-10-31 07:04:02'),
(82, 'stok_rendah_aset', 'Stok Videotron d - 50 x 100 ncled tersisa 3 unit', 156, 'super admin,admin', 0, '2026-10-31 07:04:02'),
(83, 'stok_rendah_aset', 'Stok Kabel powercon listrik tiga tersisa 0 unit', 180, 'super admin,admin', 0, '2026-10-31 07:04:02'),
(84, 'stok_rendah_aset', 'Stok Kabel powercon listrik biasa tersisa 0 unit', 179, 'super admin,admin', 0, '2026-10-31 07:04:02'),
(85, 'stok_rendah_aset', 'Stok Kabel powercon 50cm tersisa 0 unit', 178, 'super admin,admin', 0, '2026-10-31 07:04:02'),
(86, 'stok_rendah_aset', 'Stok Kabel lan 100 meter tersisa 0 unit', 177, 'super admin,admin', 0, '2026-10-31 07:04:02'),
(87, 'stok_rendah_aset', 'Stok Kabel lan 50 meter tersisa 0 unit', 176, 'super admin,admin', 0, '2026-10-31 07:04:02'),
(88, 'stok_rendah_aset', 'Stok Kabel lan 30 meter tersisa 0 unit', 175, 'super admin,admin', 0, '2026-10-31 07:04:02'),
(89, 'stok_rendah_aset', 'Stok Kabel lan 50cm tersisa 0 unit', 174, 'super admin,admin', 0, '2026-10-31 07:04:02'),
(90, 'approved', 'Peminjaman GKM-PJM-1 telah disetujui untuk dipinjam oleh Bayu Pratama [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 16, 'super admin,admin,supervisor,user', 0, '2026-10-31 07:20:07'),
(91, 'dikembalikan', 'Peminjaman GKM-PJM-1 menunggu verifikasi pengembalian dari Aditya Kurniawan', 16, 'super admin,admin,supervisor', 0, '2026-10-31 07:28:07'),
(92, 'approved', 'Peminjaman GKM-PJM-1 telah diverifikasi pengembaliannya oleh CEO Ultima [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 16, 'super admin,admin,supervisor,user', 0, '2026-10-31 07:28:36'),
(93, 'peminjaman_baru', 'Aditya Kurniawan membuat peminjaman baru (GKM-PJM-1)', NULL, 'super admin,admin,supervisor', 0, '2026-10-31 09:15:47'),
(94, 'stok_rendah_aset', 'Stok Panel listrik led tersisa 0 unit', 196, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(95, 'stok_rendah_aset', 'Stok Galon air tersisa 0 unit', 195, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(96, 'stok_rendah_aset', 'Stok T besar tersisa 0 unit', 194, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(97, 'stok_rendah_aset', 'Stok T kecil tersisa 0 unit', 193, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(98, 'stok_rendah_aset', 'Stok Dudukan tersisa 0 unit', 192, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(99, 'stok_rendah_aset', 'Stok Penyangga tersisa 0 unit', 191, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(100, 'stok_rendah_aset', 'Stok Videotron a - 50 x 100 ncled tersisa 0 unit', 153, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(101, 'stok_rendah_aset', 'Stok Videotron f - 50 x 100 ncled tersisa 3 unit', 158, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(102, 'stok_rendah_aset', 'Stok Videotron j - 50 x 100 ncled tersisa 3 unit', 162, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(103, 'stok_rendah_aset', 'Stok Videotron n - 50 x 100 ncled tersisa 3 unit', 166, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(104, 'stok_rendah_aks', 'Stok MIC SHOTGUN EKSTERNAL tersisa 0 unit', 77, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(105, 'stok_rendah_aks', 'Stok WINDSHIELD DEADCAT MIC SHOTGUN tersisa 0 unit', 78, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(106, 'stok_rendah_aks', 'Stok HEADPHONE MONITORING STUDIO tersisa 1 unit', 79, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(107, 'stok_rendah_aks', 'Stok FLASH TRIGGER NIRKABEL TTL SONY tersisa 1 unit', 87, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(108, 'stok_rendah_aks', 'Stok STEP-UP RING FILTER SET (49-82MM) tersisa 0 unit', 91, 'super admin,admin', 0, '2026-10-31 09:15:47'),
(109, 'approved', 'Peminjaman GKM-PJM-1 telah disetujui untuk dipinjam oleh Bayu Pratama [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 17, 'super admin,admin,supervisor,user', 0, '2026-10-31 09:18:14'),
(110, 'dikembalikan', 'Peminjaman GKM-PJM-1 menunggu verifikasi pengembalian dari Aditya Kurniawan', 17, 'super admin,admin,supervisor', 0, '2026-10-31 09:42:55'),
(111, 'approved', 'Peminjaman GKM-PJM-1 telah diverifikasi pengembaliannya oleh CEO Ultima [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 17, 'super admin,admin,supervisor,user', 0, '2026-10-31 09:43:15');

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id` int(11) NOT NULL,
  `kode_pinjam` varchar(50) NOT NULL,
  `nama_peminjam` varchar(255) NOT NULL,
  `penerima_aset` varchar(255) DEFAULT NULL,
  `alasan_peminjaman` text DEFAULT NULL,
  `keperluan_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `tanggal_peminjaman` datetime NOT NULL,
  `tanggal_pengembalian` datetime DEFAULT NULL,
  `status` enum('Menunggu Persetujuan','Sedang Dipinjam','Menunggu Verifikasi','Peminjaman Selesai') DEFAULT 'Menunggu Persetujuan',
  `yang_menyerahkan` varchar(255) DEFAULT NULL,
  `approved_by` varchar(255) DEFAULT NULL,
  `return_approved_by` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bukti_peminjaman` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `bukti_pengembalian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman_items`
--

CREATE TABLE `peminjaman_items` (
  `id` int(11) NOT NULL,
  `peminjaman_id` int(11) NOT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `aksesoris_id` int(11) DEFAULT NULL,
  `aksesoris_unit_id` int(11) DEFAULT NULL,
  `jumlah` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pegawai`
--

CREATE TABLE `tbl_pegawai` (
  `id` int(11) NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `tempat_lahir` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nomor_hp` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_pegawai`
--

INSERT INTO `tbl_pegawai` (`id`, `nama_lengkap`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `email`, `nomor_hp`, `created_at`, `updated_at`) VALUES
(8, 'Budi Santoso', 'Jakarta', '1990-05-12', 'Jl. Merdeka No. 10, Jakarta Pusat', 'budi.santoso@email.com', '081234567001', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(9, 'Siti Aminah', 'Bandung', '1992-08-23', 'Jl. Asia Afrika No. 25, Bandung', 'siti.aminah@email.com', '081234567002', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(10, 'Andi Wijaya', 'Surabaya', '1988-01-15', 'Jl. Tunjungan No. 5, Surabaya', 'andi.wijaya@email.com', '081234567003', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(11, 'Dewi Lestari', 'Yogyakarta', '1995-03-30', 'Jl. Malioboro No. 12, Yogyakarta', 'dewi.lestari@email.com', '081234567004', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(12, 'Rudi Hartono', 'Medan', '1991-11-07', 'Jl. Gatot Subroto No. 8, Medan', 'rudi.hartono@email.com', '081234567005', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(13, 'Rina Marlina', 'Semarang', '1993-06-18', 'Jl. Pandanaran No. 20, Semarang', 'rina.marlina@email.com', '081234567006', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(14, 'Agus Setiawan', 'Makassar', '1989-09-25', 'Jl. Pettarani No. 3, Makassar', 'agus.setiawan@email.com', '081234567007', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(15, 'Fitri Handayani', 'Palembang', '1994-12-02', 'Jl. Sudirman No. 15, Palembang', 'fitri.handayani@email.com', '081234567008', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(17, 'Maya Sari', 'Balikpapan', '1996-04-21', 'Jl. Sudirman No. 30, Balikpapan', 'maya.sari@email.com', '081234567010', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(18, 'Hendra Gunawan', 'Pontianak', '1987-02-11', 'Jl. Gajah Mada No. 9, Pontianak', 'hendra.gunawan@email.com', '081234567011', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(19, 'Lina Kusuma', 'Manado', '1992-10-05', 'Jl. Sam Ratulangi No. 18, Manado', 'lina.kusuma@email.com', '081234567012', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(20, 'Bayu Pratama', 'Padang', '1991-01-27', 'Jl. Imam Bonjol No. 22, Padang', 'bayu.pratama@email.com', '081234567013', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(21, 'Nina Septiani', 'Pekanbaru', '1993-08-09', 'Jl. Jenderal Sudirman No. 11, Pekanbaru', 'nina.septiani@email.com', '081234567014', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(22, 'Fajar Nugroho', 'Bogor', '1988-05-19', 'Jl. Pajajaran No. 6, Bogor', 'fajar.nugroho@email.com', '081234567015', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(23, 'Indah Permata', 'Malang', '1995-11-23', 'Jl. Ijen No. 14, Malang', 'indah.permata@email.com', '081234567016', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(24, 'Yoga Prasetyo', 'Solo', '1990-03-08', 'Jl. Slamet Riyadi No. 17, Solo', 'yoga.prasetyo@email.com', '081234567017', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(25, 'Citra Ayu', 'Cirebon', '1994-07-30', 'Jl. Siliwangi No. 4, Cirebon', 'citra.ayu@email.com', '081234567018', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(26, 'Rizky Ramadhan', 'Tangerang', '1992-09-16', 'Jl. Jenderal Sudirman No. 28, Tangerang', 'rizky.ramadhan@email.com', '081234567019', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(27, 'Putri Wulandari', 'Bekasi', '1996-02-14', 'Jl. Ahmad Yani No. 13, Bekasi', 'putri.wulandari@email.com', '081234567020', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(28, 'Aditya Kurniawan', 'Depok', '1989-06-27', 'Jl. Margonda No. 21, Depok', 'aditya.kurniawan@email.com', '081234567021', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(29, 'Sari Dewi', 'Samarinda', '1993-10-11', 'Jl. Mulawarman No. 16, Samarinda', 'sari.dewi@email.com', '081234567022', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(30, 'Eko Prasetyo', 'Banjarmasin', '1991-04-03', 'Jl. A. Yani No. 19, Banjarmasin', 'eko.prasetyo@email.com', '081234567023', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(31, 'Wulan Sari', 'Mataram', '1995-12-29', 'Jl. Pejanggik No. 8, Mataram', 'wulan.sari@email.com', '081234567024', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(32, 'Taufik Hidayat', 'Kupang', '1987-08-17', 'Jl. El Tari No. 2, Kupang', 'taufik.hidayat@email.com', '081234567025', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(33, 'Ayu Lestari', 'Ambon', '1994-05-06', 'Jl. Pattimura No. 24, Ambon', 'ayu.lestari@email.com', '081234567026', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(34, 'Rendi Saputra', 'Jayapura', '1990-11-13', 'Jl. Yos Sudarso No. 27, Jayapura', 'rendi.saputra@email.com', '081234567027', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(35, 'Melati Kusuma', 'Batam', '1992-01-22', 'Jl. Engku Putri No. 10, Batam', 'melati.kusuma@email.com', '081234567028', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(36, 'Arif Budiman', 'Bandar Lampung', '1988-09-04', 'Jl. Raden Intan No. 12, Bandar Lampung', 'arif.budiman@email.com', '081234567029', '2026-09-16 04:51:04', '2026-09-16 04:51:04'),
(37, 'Nadia Safira', 'Jambi', '1996-06-15', 'Jl. Sultan Thaha No. 5, Jambi', 'nadia.safira@email.com', '081234567030', '2026-09-16 04:51:04', '2026-09-16 04:51:04');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `pegawai_id` int(11) DEFAULT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('super admin','admin','supervisor','user','guest') NOT NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `foto_profil` varchar(255) DEFAULT NULL,
  `nomor_hp` varchar(20) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `is_guest` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `pegawai_id`, `nama_lengkap`, `email`, `password`, `role`, `created_at`, `updated_at`, `foto_profil`, `nomor_hp`, `keterangan`, `is_guest`, `is_active`) VALUES
(1, 13, 'CEO Ultima', 'superadmin@galeria.com', '$2a$12$GZxcV0xlojxkuo5PxA1yw.WCFnXW724TCCFJLljkGzI08vs6sZ1h.', 'super admin', '2026-06-11 09:54:11', '2026-09-28 09:42:56', '/uploads/profiles/profile-1790477854271-789885295.webp', NULL, NULL, 0, 1),
(17, 28, 'Aditya Kurniawan', 'aditya.kurniawan@email.com', '$2b$10$xnzrV6GFVC5CacEysCA2mecPt0A5NimFZ3FJVVnsRz9LU2.yxyTRK', 'user', '2026-09-16 04:53:50', '2026-10-23 11:56:13', NULL, NULL, NULL, 0, 1),
(18, 20, 'Bayu Pratama', 'bayu.pratama@email.com', '$2b$10$LmLaT3DbyJcEN99aG8LJiePqHFChjWgtFBA1pveeeMnqvHGMrwFb6', 'supervisor', '2026-09-16 04:54:36', '2026-10-23 11:56:05', NULL, NULL, NULL, 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `aksesoris`
--
ALTER TABLE `aksesoris`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_aksesoris` (`kode_aksesoris`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `aksesoris_units`
--
ALTER TABLE `aksesoris_units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_unit` (`kode_unit`),
  ADD KEY `aksesoris_id` (`aksesoris_id`),
  ADD KEY `idx_kondisi` (`kondisi`),
  ADD KEY `idx_status_pinjam` (`status_pinjam`);

--
-- Indeks untuk tabel `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_aset` (`kode_aset`),
  ADD UNIQUE KEY `no_sn` (`no_sn`),
  ADD KEY `fk_asset_user` (`user_id`);

--
-- Indeks untuk tabel `asset_units`
--
ALTER TABLE `asset_units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_unit` (`kode_unit`),
  ADD KEY `asset_id` (`asset_id`),
  ADD KEY `idx_kondisi` (`kondisi`),
  ADD KEY `idx_status_pinjam` (`status_pinjam`);

--
-- Indeks untuk tabel `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_pinjam` (`kode_pinjam`),
  ADD KEY `fk_user_peminjaman` (`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indeks untuk tabel `peminjaman_items`
--
ALTER TABLE `peminjaman_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `peminjaman_id` (`peminjaman_id`),
  ADD KEY `asset_id` (`asset_id`),
  ADD KEY `unit_id` (`unit_id`),
  ADD KEY `fk_peminjaman_items_aksesoris` (`aksesoris_id`),
  ADD KEY `idx_asset_aksesoris` (`asset_id`,`aksesoris_id`),
  ADD KEY `fk_peminjaman_items_aksesoris_unit` (`aksesoris_unit_id`);

--
-- Indeks untuk tabel `tbl_pegawai`
--
ALTER TABLE `tbl_pegawai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_nama_email` (`nama_lengkap`,`email`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_users_pegawai` (`pegawai_id`),
  ADD KEY `idx_role_active` (`role`,`is_active`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `aksesoris`
--
ALTER TABLE `aksesoris`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT untuk tabel `aksesoris_units`
--
ALTER TABLE `aksesoris_units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=313;

--
-- AUTO_INCREMENT untuk tabel `assets`
--
ALTER TABLE `assets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT untuk tabel `asset_units`
--
ALTER TABLE `asset_units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=572;

--
-- AUTO_INCREMENT untuk tabel `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=260;

--
-- AUTO_INCREMENT untuk tabel `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT untuk tabel `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `peminjaman_items`
--
ALTER TABLE `peminjaman_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT untuk tabel `tbl_pegawai`
--
ALTER TABLE `tbl_pegawai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `aksesoris`
--
ALTER TABLE `aksesoris`
  ADD CONSTRAINT `aksesoris_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `aksesoris_units`
--
ALTER TABLE `aksesoris_units`
  ADD CONSTRAINT `fk_aksesoris_units_aksesoris` FOREIGN KEY (`aksesoris_id`) REFERENCES `aksesoris` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `assets`
--
ALTER TABLE `assets`
  ADD CONSTRAINT `fk_asset_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `asset_units`
--
ALTER TABLE `asset_units`
  ADD CONSTRAINT `fk_asset_units_asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `fk_user_peminjaman` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `peminjaman_items`
--
ALTER TABLE `peminjaman_items`
  ADD CONSTRAINT `fk_peminjaman_items_aksesoris` FOREIGN KEY (`aksesoris_id`) REFERENCES `aksesoris` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_peminjaman_items_aksesoris_unit` FOREIGN KEY (`aksesoris_unit_id`) REFERENCES `aksesoris_units` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_peminjaman_items_unit` FOREIGN KEY (`unit_id`) REFERENCES `asset_units` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `peminjaman_items_ibfk_1` FOREIGN KEY (`peminjaman_id`) REFERENCES `peminjaman` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `peminjaman_items_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`);

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_pegawai` FOREIGN KEY (`pegawai_id`) REFERENCES `tbl_pegawai` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
