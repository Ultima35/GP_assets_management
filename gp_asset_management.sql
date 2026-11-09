-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 03 Nov 2026 pada 05.28
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
(1, 'AST-GPRO-KAME-001', 'Sony alpha 7 iii body', 'John Doe', 'Kamera', 'Sony', 'ILCE-7M3', 'SN-98765432', '24.2 mp, 4k hdr, full-frame', 'LEMARI KAMERA A', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Lengkap dengan strap & charger', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 25000000.00, 'Per Unit', 1, '2024-01-15', 1),
(2, 'AST-GPRO-VIDE-001', 'Videotron p3.9 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P3.9', 'SN-21341232', '1 box isi 6 kabinet, harga 25 jt per paket box', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 6, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(3, 'AST-GPRO-KAME-002', 'Sony alpha 7 iii body', 'John Doe', 'Kamera', 'Sony', 'ILCE-7M3', 'SN-12341234', '24.2 mp, 4k hdr, full-frame', 'LEMARI KAMERA A', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Lengkap strap & charger', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 25000000.00, 'Per Unit', 1, '2024-01-15', 1),
(4, 'AST-GPRO-KAME-003', 'Sony alpha 7 iv body', 'John Doe', 'Kamera', 'Sony', 'ILCE-7M4', 'SN-98765433', '33 mp, 4k 60p, full-frame', 'LEMARI KAMERA A', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:31:26', 1, 32000000.00, 'Per Unit', 1, '2024-02-10', 1),
(5, 'AST-GPRO-KAME-004', 'Canon eos r5 body', 'John Doe', 'Kamera', 'Canon', 'EOS R5', 'SN-98765434', '45 mp, 8k raw', 'LEMARI KAMERA B', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Termasuk battery grip', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 45000000.00, 'Per Unit', 1, '2024-02-15', 1),
(6, 'AST-GPRO-KAME-005', 'Canon eos r6 mark ii', 'John Doe', 'Kamera', 'Canon', 'EOS R6 II', 'SN-98765435', '24.2 mp, 4k 60p', 'LEMARI KAMERA B', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 35000000.00, 'Per Unit', 1, '2024-03-01', 1),
(7, 'AST-GPRO-KAME-006', 'Nikon z6 ii body', 'Jane Smith', 'Kamera', 'Nikon', 'Z6II', 'SN-98765436', '24.5 mp, 4k 30p', 'LEMARI KAMERA B', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 28000000.00, 'Per Unit', 1, '2024-03-05', 1),
(8, 'AST-GPRO-KAME-007', 'Panasonic lumix gh6', 'Jane Smith', 'Kamera', 'Panasonic', 'DC-GH6', 'SN-98765437', '25.2 mp, 5.7k', 'LEMARI KAMERA C', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Micro four thirds', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 30000000.00, 'Per Unit', 1, '2024-03-10', 1),
(9, 'AST-GPRO-KAME-008', 'Blackmagic pocket 6k pro', 'Jane Smith', 'Kamera', 'Blackmagic', 'BMPCC 6K Pro', 'SN-98765438', '6k super 35', 'LEMARI KAMERA C', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Ef mount', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 38000000.00, 'Per Unit', 1, '2024-03-15', 1),
(10, 'AST-GPRO-KAME-009', 'Sony fx3 cinema line', 'John Doe', 'Kamera', 'Sony', 'ILME-FX3', 'SN-98765439', '12.1 mp, 4k 120p', 'LEMARI KAMERA C', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Full-frame cinema', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 55000000.00, 'Per Unit', 1, '2024-03-20', 1),
(11, 'AST-GPRO-KAME-010', 'Sony fx30 cinema line', 'John Doe', 'Kamera', 'Sony', 'ILME-FX30', 'SN-98765440', '26 mp, 4k 120p', 'LEMARI KAMERA C', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Aps-c cinema', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 30000000.00, 'Per Unit', 1, '2024-03-25', 1),
(12, 'AST-GPRO-KAME-011', 'Canon eos c70', 'Jane Smith', 'Kamera', 'Canon', 'EOS C70', 'SN-98765441', '4k super 35', 'LEMARI KAMERA D', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Rf mount cinema', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 65000000.00, 'Per Unit', 1, '2024-04-01', 1),
(13, 'AST-GPRO-KAME-012', 'Sony alpha 7s iii', 'John Doe', 'Kamera', 'Sony', 'ILCE-7SM3', 'SN-98765442', '12.1 mp, 4k 120p', 'LEMARI KAMERA D', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Low-light king', '2026-11-03 03:13:46', '2026-11-03 03:31:26', 1, 42000000.00, 'Per Unit', 1, '2024-04-05', 1),
(14, 'AST-GPRO-KAME-013', 'Fujifilm x-t5 body', 'Jane Smith', 'Kamera', 'Fujifilm', 'X-T5', 'SN-98765443', '40 mp aps-c', 'LEMARI KAMERA D', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:31:26', 1, 26000000.00, 'Per Unit', 1, '2024-04-10', 1),
(15, 'AST-GPRO-KAME-014', 'Fujifilm x-h2s', 'Jane Smith', 'Kamera', 'Fujifilm', 'X-H2S', 'SN-98765444', '26 mp, 6k', 'LEMARI KAMERA D', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Stacked sensor', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 33000000.00, 'Per Unit', 1, '2024-04-15', 1),
(16, 'AST-GPRO-KAME-015', 'Panasonic lumix s5 ii', 'John Doe', 'Kamera', 'Panasonic', 'DC-S5M2', 'SN-98765445', '24 mp full-frame', 'LEMARI KAMERA E', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 27000000.00, 'Per Unit', 1, '2024-04-20', 1),
(17, 'AST-GPRO-KAME-016', 'Sony zv-e1', 'John Doe', 'Kamera', 'Sony', 'ZV-E1', 'SN-98765446', '12 mp full-frame', 'LEMARI KAMERA E', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Vlog camera', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 28000000.00, 'Per Unit', 1, '2024-04-25', 1),
(18, 'AST-GPRO-KAME-017', 'Canon eos r8', 'Jane Smith', 'Kamera', 'Canon', 'EOS R8', 'SN-98765447', '24.2 mp full-frame', 'LEMARI KAMERA E', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 22000000.00, 'Per Unit', 1, '2024-05-01', 1),
(19, 'AST-GPRO-KAME-018', 'Nikon z8 body', 'Jane Smith', 'Kamera', 'Nikon', 'Z8', 'SN-98765448', '45.7 mp, 8k', 'LEMARI KAMERA E', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 48000000.00, 'Per Unit', 1, '2024-05-05', 1),
(20, 'AST-GPRO-KAME-019', 'Sony alpha 1', 'John Doe', 'Kamera', 'Sony', 'ILCE-1', 'SN-98765449', '50 mp, 8k 30p', 'LEMARI KAMERA F', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Flagship', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 85000000.00, 'Per Unit', 1, '2024-05-10', 1),
(21, 'AST-GPRO-KAME-020', 'Canon eos r3', 'John Doe', 'Kamera', 'Canon', 'EOS R3', 'SN-98765450', '24 mp, 6k', 'LEMARI KAMERA F', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Eye control af', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 75000000.00, 'Per Unit', 1, '2024-05-15', 1),
(22, 'AST-GPRO-KAME-021', 'Panasonic lumix gh5 ii', 'Jane Smith', 'Kamera', 'Panasonic', 'DC-GH5M2', 'SN-98765451', '20.3 mp, 4k 60p', 'LEMARI KAMERA F', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Mft', '2026-11-03 03:13:46', '2026-11-03 03:31:26', 1, 22000000.00, 'Per Unit', 1, '2024-05-20', 1),
(23, 'AST-GPRO-KAME-022', 'Sony a6400 body', 'Jane Smith', 'Kamera', 'Sony', 'ILCE-6400', 'SN-98765452', '24.2 mp aps-c', 'LEMARI KAMERA F', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 12000000.00, 'Per Unit', 1, '2024-05-25', 1),
(24, 'AST-GPRO-KAME-023', 'Sony a6600 body', 'John Doe', 'Kamera', 'Sony', 'ILCE-6600', 'SN-98765453', '24.2 mp aps-c', 'LEMARI KAMERA G', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Ibis', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 16000000.00, 'Per Unit', 1, '2024-06-01', 1),
(25, 'AST-GPRO-KAME-024', 'Canon eos 90d', 'John Doe', 'Kamera', 'Canon', 'EOS 90D', 'SN-98765454', '32.5 mp aps-c', 'LEMARI KAMERA G', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Dslr', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 14000000.00, 'Per Unit', 1, '2024-06-05', 1),
(26, 'AST-GPRO-KAME-025', 'Nikon d850', 'Jane Smith', 'Kamera', 'Nikon', 'D850', 'SN-98765455', '45.7 mp fx', 'LEMARI KAMERA G', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Dslr', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 30000000.00, 'Per Unit', 1, '2024-06-10', 1),
(27, 'AST-GPRO-KAME-026', 'Blackmagic ursa mini pro 12k', 'Jane Smith', 'Kamera', 'Blackmagic', 'URSA 12K', 'SN-98765456', '12k super 35', 'LEMARI KAMERA H', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cinema', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 120000000.00, 'Per Unit', 1, '2024-06-15', 1),
(28, 'AST-GPRO-KAME-027', 'Red komodo 6k', 'John Doe', 'Kamera', 'RED', 'Komodo 6K', 'SN-98765457', '6k super 35', 'LEMARI KAMERA H', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cinema', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 150000000.00, 'Per Unit', 1, '2024-06-20', 1),
(29, 'AST-GPRO-KAME-028', 'Sony pxw-z190', 'John Doe', 'Kamera', 'Sony', 'PXW-Z190', 'SN-98765458', '4k 3g-sdi', 'LEMARI KAMERA H', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Camcorder', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 55000000.00, 'Per Unit', 1, '2024-06-25', 1),
(30, 'AST-GPRO-KAME-029', 'Panasonic ag-cx350', 'Jane Smith', 'Kamera', 'Panasonic', 'AG-CX350', 'SN-98765459', '4k 10-bit', 'LEMARI KAMERA H', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Camcorder', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 60000000.00, 'Per Unit', 1, '2024-07-01', 1),
(31, 'AST-GPRO-KAME-030', 'Canon xa75', 'Jane Smith', 'Kamera', 'Canon', 'XA75', 'SN-98765460', '4k uhd', 'LEMARI KAMERA I', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Camcorder', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 30000000.00, 'Per Unit', 1, '2024-07-05', 1),
(32, 'AST-GPRO-KAME-031', 'Sony hxr-nx80', 'John Doe', 'Kamera', 'Sony', 'HXR-NX80', 'SN-98765461', '4k hdr', 'LEMARI KAMERA I', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Camcorder', '2026-11-03 03:13:46', '2026-11-03 03:13:46', 1, 35000000.00, 'Per Unit', 1, '2024-07-10', 1),
(33, 'AST-GPRO-LENS-001', 'Sony fe 24-70mm f/2.8 gm ii', 'John Doe', 'Lensa', 'Sony', 'SEL2470GM2', 'SN-LENS0001', '24-70mm f/2.8', 'LEMARI LENSA A', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 28000000.00, 'Per Unit', 1, '2024-01-20', 1),
(34, 'AST-GPRO-LENS-002', 'Sony fe 70-200mm f/2.8 gm ii', 'John Doe', 'Lensa', 'Sony', 'SEL70200GM2', 'SN-LENS0002', '70-200mm f/2.8', 'LEMARI LENSA A', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 35000000.00, 'Per Unit', 1, '2024-01-25', 1),
(35, 'AST-GPRO-LENS-003', 'Sony fe 16-35mm f/2.8 gm', 'Jane Smith', 'Lensa', 'Sony', 'SEL1635GM', 'SN-LENS0003', '16-35mm f/2.8', 'LEMARI LENSA A', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 25000000.00, 'Per Unit', 1, '2024-02-01', 1),
(36, 'AST-GPRO-LENS-004', 'Sony fe 50mm f/1.2 gm', 'Jane Smith', 'Lensa', 'Sony', 'SEL50F12GM', 'SN-LENS0004', '50mm f/1.2', 'LEMARI LENSA A', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 26000000.00, 'Per Unit', 1, '2024-02-05', 1),
(37, 'AST-GPRO-LENS-005', 'Sony fe 85mm f/1.4 gm', 'John Doe', 'Lensa', 'Sony', 'SEL85F14GM', 'SN-LENS0005', '85mm f/1.4', 'LEMARI LENSA A', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 20000000.00, 'Per Unit', 1, '2024-02-10', 1),
(38, 'AST-GPRO-LENS-006', 'Sony fe 24-105mm f/4 g', 'John Doe', 'Lensa', 'Sony', 'SEL24105G', 'SN-LENS0006', '24-105mm f/4', 'LEMARI LENSA B', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 15000000.00, 'Per Unit', 1, '2024-02-15', 1),
(39, 'AST-GPRO-LENS-007', 'Sony fe 100-400mm gm', 'Jane Smith', 'Lensa', 'Sony', 'SEL100400GM', 'SN-LENS0007', '100-400mm f/4.5-5.6', 'LEMARI LENSA B', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 32000000.00, 'Per Unit', 1, '2024-02-20', 1),
(40, 'AST-GPRO-LENS-008', 'Canon rf 24-70mm f/2.8l', 'Jane Smith', 'Lensa', 'Canon', 'RF24-70F2.8', 'SN-LENS0008', '24-70mm f/2.8', 'LEMARI LENSA B', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 30000000.00, 'Per Unit', 1, '2024-02-25', 1),
(41, 'AST-GPRO-LENS-009', 'Canon rf 70-200mm f/2.8l', 'John Doe', 'Lensa', 'Canon', 'RF70-200F2.8', 'SN-LENS0009', '70-200mm f/2.8', 'LEMARI LENSA B', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 33000000.00, 'Per Unit', 1, '2024-03-01', 1),
(42, 'AST-GPRO-LENS-010', 'Canon rf 15-35mm f/2.8l', 'John Doe', 'Lensa', 'Canon', 'RF15-35F2.8', 'SN-LENS0010', '15-35mm f/2.8', 'LEMARI LENSA B', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 28000000.00, 'Per Unit', 1, '2024-03-05', 1),
(43, 'AST-GPRO-LENS-011', 'Canon rf 50mm f/1.2l', 'Jane Smith', 'Lensa', 'Canon', 'RF50F1.2', 'SN-LENS0011', '50mm f/1.2', 'LEMARI LENSA C', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 28000000.00, 'Per Unit', 1, '2024-03-10', 1),
(44, 'AST-GPRO-LENS-012', 'Canon rf 85mm f/1.2l', 'Jane Smith', 'Lensa', 'Canon', 'RF85F1.2', 'SN-LENS0012', '85mm f/1.2', 'LEMARI LENSA C', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 32000000.00, 'Per Unit', 1, '2024-03-15', 1),
(45, 'AST-GPRO-LENS-013', 'Canon rf 24-105mm f/4l', 'John Doe', 'Lensa', 'Canon', 'RF24-105F4', 'SN-LENS0013', '24-105mm f/4', 'LEMARI LENSA C', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 16000000.00, 'Per Unit', 1, '2024-03-20', 1),
(46, 'AST-GPRO-LENS-014', 'Nikon z 24-70mm f/2.8 s', 'John Doe', 'Lensa', 'Nikon', 'Z24-70F2.8', 'SN-LENS0014', '24-70mm f/2.8', 'LEMARI LENSA C', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Z mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 28000000.00, 'Per Unit', 1, '2024-03-25', 1),
(47, 'AST-GPRO-LENS-015', 'Nikon z 70-200mm f/2.8 s', 'Jane Smith', 'Lensa', 'Nikon', 'Z70-200F2.8', 'SN-LENS0015', '70-200mm f/2.8', 'LEMARI LENSA C', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Z mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 32000000.00, 'Per Unit', 1, '2024-04-01', 1),
(48, 'AST-GPRO-LENS-016', 'Nikon z 50mm f/1.2 s', 'Jane Smith', 'Lensa', 'Nikon', 'Z50F1.2', 'SN-LENS0016', '50mm f/1.2', 'LEMARI LENSA D', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Z mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 28000000.00, 'Per Unit', 1, '2024-04-05', 1),
(49, 'AST-GPRO-LENS-017', 'Panasonic 24-70mm f/2.8', 'John Doe', 'Lensa', 'Panasonic', 'S-E2470', 'SN-LENS0017', '24-70mm f/2.8', 'LEMARI LENSA D', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'L-mount', '2026-11-03 03:13:47', '2026-11-03 03:31:26', 1, 22000000.00, 'Per Unit', 1, '2024-04-10', 1),
(50, 'AST-GPRO-LENS-018', 'Panasonic 70-200mm f/2.8', 'John Doe', 'Lensa', 'Panasonic', 'S-E70200', 'SN-LENS0018', '70-200mm f/2.8', 'LEMARI LENSA D', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'L-mount', '2026-11-03 03:13:47', '2026-11-03 03:31:26', 1, 26000000.00, 'Per Unit', 1, '2024-04-15', 1),
(51, 'AST-GPRO-LENS-019', 'Sigma 18-35mm f/1.8 art', 'Jane Smith', 'Lensa', 'Sigma', '18-35F1.8', 'SN-LENS0019', '18-35mm f/1.8', 'LEMARI LENSA D', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Ef mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 12000000.00, 'Per Unit', 1, '2024-04-20', 1),
(52, 'AST-GPRO-LENS-020', 'Sigma 50mm f/1.4 art', 'Jane Smith', 'Lensa', 'Sigma', '50F1.4ART', 'SN-LENS0020', '50mm f/1.4', 'LEMARI LENSA D', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Ef mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 10000000.00, 'Per Unit', 1, '2024-04-25', 1),
(53, 'AST-GPRO-LENS-021', 'Sigma 24-70mm f/2.8 art', 'John Doe', 'Lensa', 'Sigma', '24-70F2.8ART', 'SN-LENS0021', '24-70mm f/2.8', 'LEMARI LENSA E', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 16000000.00, 'Per Unit', 1, '2024-05-01', 1),
(54, 'AST-GPRO-LENS-022', 'Tamron 28-75mm f/2.8 g2', 'John Doe', 'Lensa', 'Tamron', 'A063', 'SN-LENS0022', '28-75mm f/2.8', 'LEMARI LENSA E', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 13000000.00, 'Per Unit', 1, '2024-05-05', 1),
(55, 'AST-GPRO-LENS-023', 'Tamron 70-180mm f/2.8', 'Jane Smith', 'Lensa', 'Tamron', 'A056', 'SN-LENS0023', '70-180mm f/2.8', 'LEMARI LENSA E', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 15000000.00, 'Per Unit', 1, '2024-05-10', 1),
(56, 'AST-GPRO-LENS-024', 'Sony fe 90mm f/2.8 macro', 'Jane Smith', 'Lensa', 'Sony', 'SEL90M28G', 'SN-LENS0024', '90mm f/2.8 macro', 'LEMARI LENSA E', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 14000000.00, 'Per Unit', 1, '2024-05-15', 1),
(57, 'AST-GPRO-LENS-025', 'Canon rf 100mm f/2.8l macro', 'John Doe', 'Lensa', 'Canon', 'RF100F2.8', 'SN-LENS0025', '100mm f/2.8 macro', 'LEMARI LENSA E', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 18000000.00, 'Per Unit', 1, '2024-05-20', 1),
(58, 'AST-GPRO-LENS-026', 'Sony fe 12-24mm f/2.8 gm', 'John Doe', 'Lensa', 'Sony', 'SEL1224GM', 'SN-LENS0026', '12-24mm f/2.8', 'LEMARI LENSA F', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:31:26', 1, 30000000.00, 'Per Unit', 1, '2024-05-25', 1),
(59, 'AST-GPRO-LENS-027', 'Sony fe 35mm f/1.4 gm', 'Jane Smith', 'Lensa', 'Sony', 'SEL35F14GM', 'SN-LENS0027', '35mm f/1.4', 'LEMARI LENSA F', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 18000000.00, 'Per Unit', 1, '2024-06-01', 1),
(60, 'AST-GPRO-LENS-028', 'Canon rf 28-70mm f/2l', 'Jane Smith', 'Lensa', 'Canon', 'RF28-70F2', 'SN-LENS0028', '28-70mm f/2', 'LEMARI LENSA F', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 45000000.00, 'Per Unit', 1, '2024-06-05', 1),
(61, 'AST-GPRO-LENS-029', 'Nikon z 14-24mm f/2.8 s', 'John Doe', 'Lensa', 'Nikon', 'Z14-24F2.8', 'SN-LENS0029', '14-24mm f/2.8', 'LEMARI LENSA F', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Z mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 30000000.00, 'Per Unit', 1, '2024-06-10', 1),
(62, 'AST-GPRO-LENS-030', 'Sigma 150-600mm sports', 'John Doe', 'Lensa', 'Sigma', '150-600S', 'SN-LENS0030', '150-600mm f/5-6.3', 'LEMARI LENSA F', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Ef mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 20000000.00, 'Per Unit', 1, '2024-06-15', 1),
(63, 'AST-GPRO-VIDE-002', 'Videotron p3.9 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P3.9', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Harga per paket (otomatis rp 4.166.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(64, 'AST-GPRO-VIDE-003', 'Videotron p3.9 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P3.9', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(65, 'AST-GPRO-VIDE-004', 'Videotron p3.9 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P3.9', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(66, 'AST-GPRO-VIDE-005', 'Videotron p3.9 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P3.9', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(67, 'AST-GPRO-VIDE-006', 'Videotron p3.9 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P3.9', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(68, 'AST-GPRO-VIDE-007', 'Videotron p3.9 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P3.9', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(69, 'AST-GPRO-VIDE-008', 'Videotron p3.9 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P3.9', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #7', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(70, 'AST-GPRO-VIDE-009', 'Videotron p3.9 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P3.9', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #8', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(71, 'AST-GPRO-VIDE-010', 'Videotron p3.9 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P3.9', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #9', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(72, 'AST-GPRO-VIDE-011', 'Videotron p3.9 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P3.9', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #10', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 25000000.00, 'Per Paket', 6, '2024-03-20', 1),
(73, 'AST-GPRO-VIDE-012', 'Videotron p2.6 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P2.6', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Harga per paket (otomatis rp 5.833.333/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 35000000.00, 'Per Paket', 6, '2024-04-10', 1),
(74, 'AST-GPRO-VIDE-013', 'Videotron p2.6 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P2.6', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 35000000.00, 'Per Paket', 6, '2024-04-10', 1),
(75, 'AST-GPRO-VIDE-014', 'Videotron p2.6 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P2.6', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 35000000.00, 'Per Paket', 6, '2024-04-10', 1),
(76, 'AST-GPRO-VIDE-015', 'Videotron p2.6 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P2.6', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 35000000.00, 'Per Paket', 6, '2024-04-10', 1),
(77, 'AST-GPRO-VIDE-016', 'Videotron p2.6 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P2.6', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 35000000.00, 'Per Paket', 6, '2024-04-10', 1),
(78, 'AST-GPRO-VIDE-017', 'Videotron p2.6 indoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P2.6', NULL, '1 box isi 6 kabinet', 'GUDANG UTAMA', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 35000000.00, 'Per Paket', 6, '2024-04-10', 1),
(79, 'AST-GPRO-VIDE-018', 'Videotron p4.8 outdoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P4.8', NULL, '1 box isi 6 kabinet', 'GUDANG OUTDOOR', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Harga per paket (otomatis rp 3.666.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 22000000.00, 'Per Paket', 6, '2024-05-05', 1),
(80, 'AST-GPRO-VIDE-019', 'Videotron p4.8 outdoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P4.8', NULL, '1 box isi 6 kabinet', 'GUDANG OUTDOOR', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 22000000.00, 'Per Paket', 6, '2024-05-05', 1),
(81, 'AST-GPRO-VIDE-020', 'Videotron p4.8 outdoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P4.8', NULL, '1 box isi 6 kabinet', 'GUDANG OUTDOOR', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 22000000.00, 'Per Paket', 6, '2024-05-05', 1),
(82, 'AST-GPRO-VIDE-021', 'Videotron p4.8 outdoor (1 box 6 kabinet)', 'Jane Smith', 'Videotron', 'Absen', 'P4.8', NULL, '1 box isi 6 kabinet', 'GUDANG OUTDOOR', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 6, 22000000.00, 'Per Paket', 6, '2024-05-05', 1),
(83, 'AST-GPRO-LIGH-001', 'Aputure ls 600d pro', 'John Doe', 'Lighting', 'Aputure', 'LS600D', 'SN-LGT0001', '600w daylight', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 25000000.00, 'Per Unit', 1, '2024-01-10', 1),
(84, 'AST-GPRO-LIGH-002', 'Aputure ls 600x pro', 'John Doe', 'Lighting', 'Aputure', 'LS600X', 'SN-LGT0002', '600w bi-color', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:31:26', 1, 27000000.00, 'Per Unit', 1, '2024-01-15', 1),
(85, 'AST-GPRO-LIGH-003', 'Aputure 300d ii', 'Jane Smith', 'Lighting', 'Aputure', '300D2', 'SN-LGT0003', '300w daylight', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:31:26', 1, 12000000.00, 'Per Unit', 1, '2024-01-20', 1),
(86, 'AST-GPRO-LIGH-004', 'Aputure 300x', 'Jane Smith', 'Lighting', 'Aputure', '300X', 'SN-LGT0004', '300w bi-color', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 13000000.00, 'Per Unit', 1, '2024-01-25', 1),
(87, 'AST-GPRO-LIGH-005', 'Aputure 120d ii', 'John Doe', 'Lighting', 'Aputure', '120D2', 'SN-LGT0005', '120w daylight', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 8000000.00, 'Per Unit', 1, '2024-02-01', 1),
(88, 'AST-GPRO-LIGH-006', 'Aputure 120x', 'John Doe', 'Lighting', 'Aputure', '120X', 'SN-LGT0006', '120w bi-color', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:31:26', 1, 8500000.00, 'Per Unit', 1, '2024-02-05', 1),
(89, 'AST-GPRO-LIGH-007', 'Aputure nova p300c', 'Jane Smith', 'Lighting', 'Aputure', 'P300C', 'SN-LGT0007', '300w rgbww', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Panel', '2026-11-03 03:13:47', '2026-11-03 03:31:26', 1, 20000000.00, 'Per Unit', 1, '2024-02-10', 1),
(90, 'AST-GPRO-LIGH-008', 'Aputure nova p600c', 'Jane Smith', 'Lighting', 'Aputure', 'P600C', 'SN-LGT0008', '600w rgbww', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Panel', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 35000000.00, 'Per Unit', 1, '2024-02-15', 1),
(91, 'AST-GPRO-LIGH-009', 'Arri skypanel s60-c', 'John Doe', 'Lighting', 'ARRI', 'S60-C', 'SN-LGT0009', '60cm rgbw', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Panel', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 85000000.00, 'Per Unit', 1, '2024-02-20', 1),
(92, 'AST-GPRO-LIGH-010', 'Arri skypanel s120-c', 'John Doe', 'Lighting', 'ARRI', 'S120-C', 'SN-LGT0010', '120cm rgbw', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Panel', '2026-11-03 03:13:47', '2026-11-03 03:31:26', 1, 130000000.00, 'Per Unit', 1, '2024-02-25', 1),
(93, 'AST-GPRO-LIGH-011', 'Arri l7-c', 'Jane Smith', 'Lighting', 'ARRI', 'L7-C', 'SN-LGT0011', '350w fresnel', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Rgbw', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 45000000.00, 'Per Unit', 1, '2024-03-01', 1),
(94, 'AST-GPRO-LIGH-012', 'Godox sl300 iii', 'Jane Smith', 'Lighting', 'Godox', 'SL300III', 'SN-LGT0012', '300w daylight', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 5000000.00, 'Per Unit', 1, '2024-03-05', 1),
(95, 'AST-GPRO-LIGH-013', 'Godox sl200 iii', 'John Doe', 'Lighting', 'Godox', 'SL200III', 'SN-LGT0013', '200w daylight', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 3500000.00, 'Per Unit', 1, '2024-03-10', 1),
(96, 'AST-GPRO-LIGH-014', 'Godox ul150 ii', 'John Doe', 'Lighting', 'Godox', 'UL150II', 'SN-LGT0014', '150w silent', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:31:26', 1, 4500000.00, 'Per Unit', 1, '2024-03-15', 1),
(97, 'AST-GPRO-LIGH-015', 'Godox ml60', 'Jane Smith', 'Lighting', 'Godox', 'ML60', 'SN-LGT0015', '60w portable', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:31:26', 1, 2500000.00, 'Per Unit', 1, '2024-03-20', 1),
(98, 'AST-GPRO-LIGH-016', 'Nanlite forza 500', 'Jane Smith', 'Lighting', 'Nanlite', 'Forza500', 'SN-LGT0016', '500w daylight', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 15000000.00, 'Per Unit', 1, '2024-03-25', 1),
(99, 'AST-GPRO-LIGH-017', 'Nanlite forza 300', 'John Doe', 'Lighting', 'Nanlite', 'Forza300', 'SN-LGT0017', '300w daylight', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:31:26', 1, 9000000.00, 'Per Unit', 1, '2024-04-01', 1),
(100, 'AST-GPRO-LIGH-018', 'Nanlite forza 60', 'John Doe', 'Lighting', 'Nanlite', 'Forza60', 'SN-LGT0018', '60w daylight', 'GUDANG LIGHTING', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:13:47', 1, 3000000.00, 'Per Unit', 1, '2024-04-05', 1);

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
(1, 1, 'AST-GPRO-KAME-001-01', 'Sony alpha 7 iii body', 'SN-98765432', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA A', 'Lengkap dengan strap & charger', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(2, 2, 'AST-GPRO-VIDE-001-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', 'SN-21341232-01', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(3, 2, 'AST-GPRO-VIDE-001-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', 'SN-21341232-02', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(4, 2, 'AST-GPRO-VIDE-001-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', 'SN-21341232-03', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(5, 2, 'AST-GPRO-VIDE-001-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', 'SN-21341232-04', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(6, 2, 'AST-GPRO-VIDE-001-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', 'SN-21341232-05', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(7, 2, 'AST-GPRO-VIDE-001-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', 'SN-21341232-06', 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis dihitung rp 4.166.667 / kabinet saat dipinjam)', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(8, 3, 'AST-GPRO-KAME-002-01', 'Sony alpha 7 iii body', 'SN-12341234', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA A', 'Lengkap strap & charger', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(9, 4, 'AST-GPRO-KAME-003-01', 'Sony alpha 7 iv body', 'SN-98765433', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA A', 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:31:26'),
(10, 5, 'AST-GPRO-KAME-004-01', 'Canon eos r5 body', 'SN-98765434', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA B', 'Termasuk battery grip', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(11, 6, 'AST-GPRO-KAME-005-01', 'Canon eos r6 mark ii', 'SN-98765435', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA B', 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(12, 7, 'AST-GPRO-KAME-006-01', 'Nikon z6 ii body', 'SN-98765436', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA B', 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(13, 8, 'AST-GPRO-KAME-007-01', 'Panasonic lumix gh6', 'SN-98765437', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA C', 'Micro four thirds', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(14, 9, 'AST-GPRO-KAME-008-01', 'Blackmagic pocket 6k pro', 'SN-98765438', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA C', 'Ef mount', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(15, 10, 'AST-GPRO-KAME-009-01', 'Sony fx3 cinema line', 'SN-98765439', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA C', 'Full-frame cinema', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(16, 11, 'AST-GPRO-KAME-010-01', 'Sony fx30 cinema line', 'SN-98765440', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA C', 'Aps-c cinema', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(17, 12, 'AST-GPRO-KAME-011-01', 'Canon eos c70', 'SN-98765441', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA D', 'Rf mount cinema', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(18, 13, 'AST-GPRO-KAME-012-01', 'Sony alpha 7s iii', 'SN-98765442', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA D', 'Low-light king', '2026-11-03 03:13:46', '2026-11-03 03:31:26'),
(19, 14, 'AST-GPRO-KAME-013-01', 'Fujifilm x-t5 body', 'SN-98765443', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA D', 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:31:26'),
(20, 15, 'AST-GPRO-KAME-014-01', 'Fujifilm x-h2s', 'SN-98765444', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA D', 'Stacked sensor', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(21, 16, 'AST-GPRO-KAME-015-01', 'Panasonic lumix s5 ii', 'SN-98765445', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA E', 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(22, 17, 'AST-GPRO-KAME-016-01', 'Sony zv-e1', 'SN-98765446', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA E', 'Vlog camera', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(23, 18, 'AST-GPRO-KAME-017-01', 'Canon eos r8', 'SN-98765447', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA E', 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(24, 19, 'AST-GPRO-KAME-018-01', 'Nikon z8 body', 'SN-98765448', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA E', 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(25, 20, 'AST-GPRO-KAME-019-01', 'Sony alpha 1', 'SN-98765449', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA F', 'Flagship', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(26, 21, 'AST-GPRO-KAME-020-01', 'Canon eos r3', 'SN-98765450', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA F', 'Eye control af', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(27, 22, 'AST-GPRO-KAME-021-01', 'Panasonic lumix gh5 ii', 'SN-98765451', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA F', 'Mft', '2026-11-03 03:13:46', '2026-11-03 03:31:26'),
(28, 23, 'AST-GPRO-KAME-022-01', 'Sony a6400 body', 'SN-98765452', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA F', 'Body only', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(29, 24, 'AST-GPRO-KAME-023-01', 'Sony a6600 body', 'SN-98765453', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA G', 'Ibis', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(30, 25, 'AST-GPRO-KAME-024-01', 'Canon eos 90d', 'SN-98765454', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA G', 'Dslr', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(31, 26, 'AST-GPRO-KAME-025-01', 'Nikon d850', 'SN-98765455', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA G', 'Dslr', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(32, 27, 'AST-GPRO-KAME-026-01', 'Blackmagic ursa mini pro 12k', 'SN-98765456', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA H', 'Cinema', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(33, 28, 'AST-GPRO-KAME-027-01', 'Red komodo 6k', 'SN-98765457', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA H', 'Cinema', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(34, 29, 'AST-GPRO-KAME-028-01', 'Sony pxw-z190', 'SN-98765458', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA H', 'Camcorder', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(35, 30, 'AST-GPRO-KAME-029-01', 'Panasonic ag-cx350', 'SN-98765459', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA H', 'Camcorder', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(36, 31, 'AST-GPRO-KAME-030-01', 'Canon xa75', 'SN-98765460', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA I', 'Camcorder', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(37, 32, 'AST-GPRO-KAME-031-01', 'Sony hxr-nx80', 'SN-98765461', 'Siap Digunakan', 'Tersedia', 'LEMARI KAMERA I', 'Camcorder', '2026-11-03 03:13:46', '2026-11-03 03:13:46'),
(38, 33, 'AST-GPRO-LENS-001-01', 'Sony fe 24-70mm f/2.8 gm ii', 'SN-LENS0001', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA A', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(39, 34, 'AST-GPRO-LENS-002-01', 'Sony fe 70-200mm f/2.8 gm ii', 'SN-LENS0002', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA A', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(40, 35, 'AST-GPRO-LENS-003-01', 'Sony fe 16-35mm f/2.8 gm', 'SN-LENS0003', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA A', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(41, 36, 'AST-GPRO-LENS-004-01', 'Sony fe 50mm f/1.2 gm', 'SN-LENS0004', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA A', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(42, 37, 'AST-GPRO-LENS-005-01', 'Sony fe 85mm f/1.4 gm', 'SN-LENS0005', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA A', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(43, 38, 'AST-GPRO-LENS-006-01', 'Sony fe 24-105mm f/4 g', 'SN-LENS0006', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA B', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(44, 39, 'AST-GPRO-LENS-007-01', 'Sony fe 100-400mm gm', 'SN-LENS0007', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA B', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(45, 40, 'AST-GPRO-LENS-008-01', 'Canon rf 24-70mm f/2.8l', 'SN-LENS0008', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA B', 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(46, 41, 'AST-GPRO-LENS-009-01', 'Canon rf 70-200mm f/2.8l', 'SN-LENS0009', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA B', 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(47, 42, 'AST-GPRO-LENS-010-01', 'Canon rf 15-35mm f/2.8l', 'SN-LENS0010', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA B', 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(48, 43, 'AST-GPRO-LENS-011-01', 'Canon rf 50mm f/1.2l', 'SN-LENS0011', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA C', 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(49, 44, 'AST-GPRO-LENS-012-01', 'Canon rf 85mm f/1.2l', 'SN-LENS0012', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA C', 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(50, 45, 'AST-GPRO-LENS-013-01', 'Canon rf 24-105mm f/4l', 'SN-LENS0013', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA C', 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(51, 46, 'AST-GPRO-LENS-014-01', 'Nikon z 24-70mm f/2.8 s', 'SN-LENS0014', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA C', 'Z mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(52, 47, 'AST-GPRO-LENS-015-01', 'Nikon z 70-200mm f/2.8 s', 'SN-LENS0015', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA C', 'Z mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(53, 48, 'AST-GPRO-LENS-016-01', 'Nikon z 50mm f/1.2 s', 'SN-LENS0016', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA D', 'Z mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(54, 49, 'AST-GPRO-LENS-017-01', 'Panasonic 24-70mm f/2.8', 'SN-LENS0017', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA D', 'L-mount', '2026-11-03 03:13:47', '2026-11-03 03:31:26'),
(55, 50, 'AST-GPRO-LENS-018-01', 'Panasonic 70-200mm f/2.8', 'SN-LENS0018', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA D', 'L-mount', '2026-11-03 03:13:47', '2026-11-03 03:31:26'),
(56, 51, 'AST-GPRO-LENS-019-01', 'Sigma 18-35mm f/1.8 art', 'SN-LENS0019', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA D', 'Ef mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(57, 52, 'AST-GPRO-LENS-020-01', 'Sigma 50mm f/1.4 art', 'SN-LENS0020', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA D', 'Ef mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(58, 53, 'AST-GPRO-LENS-021-01', 'Sigma 24-70mm f/2.8 art', 'SN-LENS0021', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA E', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(59, 54, 'AST-GPRO-LENS-022-01', 'Tamron 28-75mm f/2.8 g2', 'SN-LENS0022', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA E', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(60, 55, 'AST-GPRO-LENS-023-01', 'Tamron 70-180mm f/2.8', 'SN-LENS0023', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA E', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(61, 56, 'AST-GPRO-LENS-024-01', 'Sony fe 90mm f/2.8 macro', 'SN-LENS0024', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA E', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(62, 57, 'AST-GPRO-LENS-025-01', 'Canon rf 100mm f/2.8l macro', 'SN-LENS0025', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA E', 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(63, 58, 'AST-GPRO-LENS-026-01', 'Sony fe 12-24mm f/2.8 gm', 'SN-LENS0026', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA F', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:31:26'),
(64, 59, 'AST-GPRO-LENS-027-01', 'Sony fe 35mm f/1.4 gm', 'SN-LENS0027', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA F', 'E-mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(65, 60, 'AST-GPRO-LENS-028-01', 'Canon rf 28-70mm f/2l', 'SN-LENS0028', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA F', 'Rf mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(66, 61, 'AST-GPRO-LENS-029-01', 'Nikon z 14-24mm f/2.8 s', 'SN-LENS0029', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA F', 'Z mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(67, 62, 'AST-GPRO-LENS-030-01', 'Sigma 150-600mm sports', 'SN-LENS0030', 'Siap Digunakan', 'Tersedia', 'LEMARI LENSA F', 'Ef mount', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(68, 63, 'AST-GPRO-VIDE-002-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 4.166.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(69, 63, 'AST-GPRO-VIDE-002-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 4.166.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(70, 63, 'AST-GPRO-VIDE-002-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 4.166.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(71, 63, 'AST-GPRO-VIDE-002-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 4.166.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(72, 63, 'AST-GPRO-VIDE-002-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 4.166.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(73, 63, 'AST-GPRO-VIDE-002-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 4.166.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(74, 64, 'AST-GPRO-VIDE-003-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(75, 64, 'AST-GPRO-VIDE-003-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(76, 64, 'AST-GPRO-VIDE-003-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(77, 64, 'AST-GPRO-VIDE-003-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(78, 64, 'AST-GPRO-VIDE-003-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(79, 64, 'AST-GPRO-VIDE-003-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(80, 65, 'AST-GPRO-VIDE-004-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(81, 65, 'AST-GPRO-VIDE-004-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(82, 65, 'AST-GPRO-VIDE-004-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(83, 65, 'AST-GPRO-VIDE-004-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(84, 65, 'AST-GPRO-VIDE-004-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(85, 65, 'AST-GPRO-VIDE-004-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(86, 66, 'AST-GPRO-VIDE-005-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(87, 66, 'AST-GPRO-VIDE-005-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(88, 66, 'AST-GPRO-VIDE-005-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(89, 66, 'AST-GPRO-VIDE-005-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(90, 66, 'AST-GPRO-VIDE-005-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(91, 66, 'AST-GPRO-VIDE-005-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(92, 67, 'AST-GPRO-VIDE-006-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(93, 67, 'AST-GPRO-VIDE-006-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(94, 67, 'AST-GPRO-VIDE-006-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(95, 67, 'AST-GPRO-VIDE-006-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(96, 67, 'AST-GPRO-VIDE-006-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(97, 67, 'AST-GPRO-VIDE-006-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(98, 68, 'AST-GPRO-VIDE-007-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(99, 68, 'AST-GPRO-VIDE-007-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(100, 68, 'AST-GPRO-VIDE-007-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(101, 68, 'AST-GPRO-VIDE-007-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(102, 68, 'AST-GPRO-VIDE-007-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(103, 68, 'AST-GPRO-VIDE-007-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(104, 69, 'AST-GPRO-VIDE-008-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #7', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(105, 69, 'AST-GPRO-VIDE-008-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #7', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(106, 69, 'AST-GPRO-VIDE-008-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #7', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(107, 69, 'AST-GPRO-VIDE-008-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #7', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(108, 69, 'AST-GPRO-VIDE-008-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #7', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(109, 69, 'AST-GPRO-VIDE-008-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #7', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(110, 70, 'AST-GPRO-VIDE-009-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #8', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(111, 70, 'AST-GPRO-VIDE-009-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #8', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(112, 70, 'AST-GPRO-VIDE-009-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #8', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(113, 70, 'AST-GPRO-VIDE-009-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #8', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(114, 70, 'AST-GPRO-VIDE-009-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #8', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(115, 70, 'AST-GPRO-VIDE-009-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #8', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(116, 71, 'AST-GPRO-VIDE-010-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #9', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(117, 71, 'AST-GPRO-VIDE-010-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #9', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(118, 71, 'AST-GPRO-VIDE-010-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #9', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(119, 71, 'AST-GPRO-VIDE-010-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #9', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(120, 71, 'AST-GPRO-VIDE-010-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #9', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(121, 71, 'AST-GPRO-VIDE-010-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #9', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(122, 72, 'AST-GPRO-VIDE-011-01', 'Videotron p3.9 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #10', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(123, 72, 'AST-GPRO-VIDE-011-02', 'Videotron p3.9 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #10', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(124, 72, 'AST-GPRO-VIDE-011-03', 'Videotron p3.9 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #10', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(125, 72, 'AST-GPRO-VIDE-011-04', 'Videotron p3.9 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #10', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(126, 72, 'AST-GPRO-VIDE-011-05', 'Videotron p3.9 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #10', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(127, 72, 'AST-GPRO-VIDE-011-06', 'Videotron p3.9 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #10', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(128, 73, 'AST-GPRO-VIDE-012-01', 'Videotron p2.6 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 5.833.333/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(129, 73, 'AST-GPRO-VIDE-012-02', 'Videotron p2.6 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 5.833.333/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(130, 73, 'AST-GPRO-VIDE-012-03', 'Videotron p2.6 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 5.833.333/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(131, 73, 'AST-GPRO-VIDE-012-04', 'Videotron p2.6 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 5.833.333/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(132, 73, 'AST-GPRO-VIDE-012-05', 'Videotron p2.6 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 5.833.333/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(133, 73, 'AST-GPRO-VIDE-012-06', 'Videotron p2.6 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Harga per paket (otomatis rp 5.833.333/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(134, 74, 'AST-GPRO-VIDE-013-01', 'Videotron p2.6 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(135, 74, 'AST-GPRO-VIDE-013-02', 'Videotron p2.6 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(136, 74, 'AST-GPRO-VIDE-013-03', 'Videotron p2.6 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(137, 74, 'AST-GPRO-VIDE-013-04', 'Videotron p2.6 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(138, 74, 'AST-GPRO-VIDE-013-05', 'Videotron p2.6 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(139, 74, 'AST-GPRO-VIDE-013-06', 'Videotron p2.6 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(140, 75, 'AST-GPRO-VIDE-014-01', 'Videotron p2.6 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(141, 75, 'AST-GPRO-VIDE-014-02', 'Videotron p2.6 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(142, 75, 'AST-GPRO-VIDE-014-03', 'Videotron p2.6 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(143, 75, 'AST-GPRO-VIDE-014-04', 'Videotron p2.6 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(144, 75, 'AST-GPRO-VIDE-014-05', 'Videotron p2.6 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(145, 75, 'AST-GPRO-VIDE-014-06', 'Videotron p2.6 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(146, 76, 'AST-GPRO-VIDE-015-01', 'Videotron p2.6 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(147, 76, 'AST-GPRO-VIDE-015-02', 'Videotron p2.6 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(148, 76, 'AST-GPRO-VIDE-015-03', 'Videotron p2.6 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(149, 76, 'AST-GPRO-VIDE-015-04', 'Videotron p2.6 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(150, 76, 'AST-GPRO-VIDE-015-05', 'Videotron p2.6 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(151, 76, 'AST-GPRO-VIDE-015-06', 'Videotron p2.6 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(152, 77, 'AST-GPRO-VIDE-016-01', 'Videotron p2.6 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(153, 77, 'AST-GPRO-VIDE-016-02', 'Videotron p2.6 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(154, 77, 'AST-GPRO-VIDE-016-03', 'Videotron p2.6 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(155, 77, 'AST-GPRO-VIDE-016-04', 'Videotron p2.6 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(156, 77, 'AST-GPRO-VIDE-016-05', 'Videotron p2.6 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(157, 77, 'AST-GPRO-VIDE-016-06', 'Videotron p2.6 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #5', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(158, 78, 'AST-GPRO-VIDE-017-01', 'Videotron p2.6 indoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(159, 78, 'AST-GPRO-VIDE-017-02', 'Videotron p2.6 indoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(160, 78, 'AST-GPRO-VIDE-017-03', 'Videotron p2.6 indoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(161, 78, 'AST-GPRO-VIDE-017-04', 'Videotron p2.6 indoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(162, 78, 'AST-GPRO-VIDE-017-05', 'Videotron p2.6 indoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(163, 78, 'AST-GPRO-VIDE-017-06', 'Videotron p2.6 indoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG UTAMA', 'Box #6', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(164, 79, 'AST-GPRO-VIDE-018-01', 'Videotron p4.8 outdoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Harga per paket (otomatis rp 3.666.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(165, 79, 'AST-GPRO-VIDE-018-02', 'Videotron p4.8 outdoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Harga per paket (otomatis rp 3.666.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(166, 79, 'AST-GPRO-VIDE-018-03', 'Videotron p4.8 outdoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Harga per paket (otomatis rp 3.666.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(167, 79, 'AST-GPRO-VIDE-018-04', 'Videotron p4.8 outdoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Harga per paket (otomatis rp 3.666.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(168, 79, 'AST-GPRO-VIDE-018-05', 'Videotron p4.8 outdoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Harga per paket (otomatis rp 3.666.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(169, 79, 'AST-GPRO-VIDE-018-06', 'Videotron p4.8 outdoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Harga per paket (otomatis rp 3.666.667/kabinet)', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(170, 80, 'AST-GPRO-VIDE-019-01', 'Videotron p4.8 outdoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(171, 80, 'AST-GPRO-VIDE-019-02', 'Videotron p4.8 outdoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(172, 80, 'AST-GPRO-VIDE-019-03', 'Videotron p4.8 outdoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(173, 80, 'AST-GPRO-VIDE-019-04', 'Videotron p4.8 outdoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(174, 80, 'AST-GPRO-VIDE-019-05', 'Videotron p4.8 outdoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(175, 80, 'AST-GPRO-VIDE-019-06', 'Videotron p4.8 outdoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #2', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(176, 81, 'AST-GPRO-VIDE-020-01', 'Videotron p4.8 outdoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(177, 81, 'AST-GPRO-VIDE-020-02', 'Videotron p4.8 outdoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(178, 81, 'AST-GPRO-VIDE-020-03', 'Videotron p4.8 outdoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(179, 81, 'AST-GPRO-VIDE-020-04', 'Videotron p4.8 outdoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(180, 81, 'AST-GPRO-VIDE-020-05', 'Videotron p4.8 outdoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(181, 81, 'AST-GPRO-VIDE-020-06', 'Videotron p4.8 outdoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #3', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(182, 82, 'AST-GPRO-VIDE-021-01', 'Videotron p4.8 outdoor (1 box 6 kabinet) #01', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(183, 82, 'AST-GPRO-VIDE-021-02', 'Videotron p4.8 outdoor (1 box 6 kabinet) #02', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(184, 82, 'AST-GPRO-VIDE-021-03', 'Videotron p4.8 outdoor (1 box 6 kabinet) #03', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(185, 82, 'AST-GPRO-VIDE-021-04', 'Videotron p4.8 outdoor (1 box 6 kabinet) #04', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(186, 82, 'AST-GPRO-VIDE-021-05', 'Videotron p4.8 outdoor (1 box 6 kabinet) #05', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(187, 82, 'AST-GPRO-VIDE-021-06', 'Videotron p4.8 outdoor (1 box 6 kabinet) #06', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG OUTDOOR', 'Box #4', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(188, 83, 'AST-GPRO-LIGH-001-01', 'Aputure ls 600d pro', 'SN-LGT0001', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(189, 84, 'AST-GPRO-LIGH-002-01', 'Aputure ls 600x pro', 'SN-LGT0002', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:31:26'),
(190, 85, 'AST-GPRO-LIGH-003-01', 'Aputure 300d ii', 'SN-LGT0003', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:31:26'),
(191, 86, 'AST-GPRO-LIGH-004-01', 'Aputure 300x', 'SN-LGT0004', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(192, 87, 'AST-GPRO-LIGH-005-01', 'Aputure 120d ii', 'SN-LGT0005', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(193, 88, 'AST-GPRO-LIGH-006-01', 'Aputure 120x', 'SN-LGT0006', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob light', '2026-11-03 03:13:47', '2026-11-03 03:31:26'),
(194, 89, 'AST-GPRO-LIGH-007-01', 'Aputure nova p300c', 'SN-LGT0007', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Panel', '2026-11-03 03:13:47', '2026-11-03 03:31:26'),
(195, 90, 'AST-GPRO-LIGH-008-01', 'Aputure nova p600c', 'SN-LGT0008', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Panel', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(196, 91, 'AST-GPRO-LIGH-009-01', 'Arri skypanel s60-c', 'SN-LGT0009', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Panel', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(197, 92, 'AST-GPRO-LIGH-010-01', 'Arri skypanel s120-c', 'SN-LGT0010', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Panel', '2026-11-03 03:13:47', '2026-11-03 03:31:26'),
(198, 93, 'AST-GPRO-LIGH-011-01', 'Arri l7-c', 'SN-LGT0011', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Rgbw', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(199, 94, 'AST-GPRO-LIGH-012-01', 'Godox sl300 iii', 'SN-LGT0012', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(200, 95, 'AST-GPRO-LIGH-013-01', 'Godox sl200 iii', 'SN-LGT0013', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(201, 96, 'AST-GPRO-LIGH-014-01', 'Godox ul150 ii', 'SN-LGT0014', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:31:26'),
(202, 97, 'AST-GPRO-LIGH-015-01', 'Godox ml60', 'SN-LGT0015', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:31:26'),
(203, 98, 'AST-GPRO-LIGH-016-01', 'Nanlite forza 500', 'SN-LGT0016', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:13:47'),
(204, 99, 'AST-GPRO-LIGH-017-01', 'Nanlite forza 300', 'SN-LGT0017', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:31:26'),
(205, 100, 'AST-GPRO-LIGH-018-01', 'Nanlite forza 60', 'SN-LGT0018', 'Siap Digunakan', 'Tersedia', 'GUDANG LIGHTING', 'Cob', '2026-11-03 03:13:47', '2026-11-03 03:13:47');

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
(1, 1, 'CEO Ultima', 'CREATE', 'Aset', '1', 'Import massal 100 aset dari file Excel', '2026-11-03 02:17:55'),
(2, 1, 'CEO Ultima', 'DELETE', 'System', 'ALL', 'SUPER ADMIN menghapus seluruh data: Aset & Aksesoris', '2026-11-03 03:13:30'),
(3, 1, 'CEO Ultima', 'CREATE', 'Aset', '1', 'Import massal 100 aset dari file Excel', '2026-11-03 03:13:47'),
(4, 22, 'Guest', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-1) untuk Guest', '2026-11-03 03:23:05'),
(5, 1, 'CEO Ultima', 'APPROVE PEMINJAMAN', 'Peminjaman', '1', 'Menyetujui peminjaman: GKM-PJM-1', '2026-11-03 03:31:01'),
(6, 1, 'CEO Ultima', 'UPDATE', 'Peminjaman', '1', 'Mengisi pengembalian GKM-PJM-1', '2026-11-03 03:31:13'),
(7, 1, 'CEO Ultima', 'APPROVE PENGEMBALIAN', 'Peminjaman', '1', 'Memverifikasi pengembalian: GKM-PJM-1', '2026-11-03 03:31:26'),
(8, 1, 'CEO Ultima', 'CREATE', 'Paket Peminjaman', '1', 'Membuat template paket: VIDEOTRON 4 X 3 (3 item)', '2026-11-03 04:23:09'),
(9, 1, 'CEO Ultima', 'UPDATE', 'Paket Peminjaman', '1', 'Memperbarui template paket: VIDEOTRON 4 X 3', '2026-11-03 04:23:26'),
(10, 1, 'CEO Ultima', 'UPDATE', 'Paket Peminjaman', '1', 'Memperbarui template paket: VIDEOTRON 4 X 3', '2026-11-03 04:24:57');

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
(1, 'Sony', 'aset', '2026-11-03 02:17:55'),
(2, 'Absen', 'aset', '2026-11-03 02:17:55'),
(3, 'Canon', 'aset', '2026-11-03 02:17:55'),
(4, 'Nikon', 'aset', '2026-11-03 02:17:55'),
(5, 'Panasonic', 'aset', '2026-11-03 02:17:55'),
(6, 'Blackmagic', 'aset', '2026-11-03 02:17:55'),
(7, 'Fujifilm', 'aset', '2026-11-03 02:17:55'),
(8, 'RED', 'aset', '2026-11-03 02:17:55'),
(9, 'Sigma', 'aset', '2026-11-03 02:17:55'),
(10, 'Tamron', 'aset', '2026-11-03 02:17:55'),
(11, 'Aputure', 'aset', '2026-11-03 02:17:55'),
(12, 'ARRI', 'aset', '2026-11-03 02:17:55'),
(13, 'Godox', 'aset', '2026-11-03 02:17:55'),
(14, 'Nanlite', 'aset', '2026-11-03 02:17:55');

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
(1, 'Kamera', 'KAME', 'aset', '2026-11-03 02:17:55'),
(2, 'Videotron', 'VIDE', 'aset', '2026-11-03 02:17:55'),
(3, 'Lensa', 'LENS', 'aset', '2026-11-03 02:17:55'),
(4, 'Lighting', 'LIGH', 'aset', '2026-11-03 02:17:55');

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
(111, 'approved', 'Peminjaman GKM-PJM-1 telah diverifikasi pengembaliannya oleh CEO Ultima [Peminjam: Aditya Kurniawan] [By: Aditya Kurniawan]', 17, 'super admin,admin,supervisor,user', 0, '2026-10-31 09:43:15'),
(112, 'peminjaman_baru', 'Guest membuat peminjaman baru (GKM-PJM-1)', NULL, 'super admin,admin,supervisor', 0, '2026-11-02 06:16:22'),
(113, 'stok_rendah_aset', 'Stok Aputure 120x tersisa 0 unit', 88, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(114, 'stok_rendah_aset', 'Stok Canon eos r6 mark ii tersisa 0 unit', 6, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(115, 'stok_rendah_aset', 'Stok Canon eos r8 tersisa 0 unit', 18, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(116, 'stok_rendah_aset', 'Stok Canon rf 24-105mm f/4l tersisa 0 unit', 45, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(117, 'stok_rendah_aset', 'Stok Canon rf 70-200mm f/2.8l tersisa 0 unit', 41, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(118, 'stok_rendah_aset', 'Stok Godox ml60 tersisa 0 unit', 97, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(119, 'stok_rendah_aset', 'Stok Godox sl300 iii tersisa 0 unit', 94, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(120, 'stok_rendah_aset', 'Stok Nikon z6 ii body tersisa 0 unit', 7, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(121, 'stok_rendah_aset', 'Stok Nikon z 70-200mm f/2.8 s tersisa 0 unit', 47, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(122, 'stok_rendah_aset', 'Stok Nikon z 50mm f/1.2 s tersisa 0 unit', 48, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(123, 'stok_rendah_aset', 'Stok Sigma 50mm f/1.4 art tersisa 0 unit', 52, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(124, 'stok_rendah_aset', 'Stok Sony a6400 body tersisa 0 unit', 23, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(125, 'stok_rendah_aset', 'Stok Sony alpha 7s iii tersisa 0 unit', 13, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(126, 'stok_rendah_aset', 'Stok Sony fe 100-400mm gm tersisa 0 unit', 39, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(127, 'stok_rendah_aset', 'Stok Sony fe 85mm f/1.4 gm tersisa 0 unit', 37, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(128, 'stok_rendah_aset', 'Stok Sony fe 70-200mm f/2.8 gm ii tersisa 0 unit', 34, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(129, 'stok_rendah_aset', 'Stok Sony fe 50mm f/1.2 gm tersisa 0 unit', 36, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(130, 'stok_rendah_aset', 'Stok Videotron p2.6 indoor (1 box 6 kabinet) tersisa 0 unit', 76, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(131, 'stok_rendah_aset', 'Stok Videotron p4.8 outdoor (1 box 6 kabinet) tersisa 1 unit', 81, 'super admin,admin', 0, '2026-11-02 06:16:22'),
(132, 'approved', 'Peminjaman GKM-PJM-1 telah disetujui untuk dipinjam oleh CEO Ultima [Peminjam: Guest] [By: Guest]', 1, 'super admin,admin,supervisor,user', 1, '2026-11-02 06:20:14'),
(133, 'dikembalikan', 'Peminjaman GKM-PJM-1 menunggu verifikasi pengembalian dari Guest', 1, 'super admin,admin,supervisor', 0, '2026-11-02 06:39:26'),
(134, 'approved', 'Peminjaman GKM-PJM-1 telah diverifikasi pengembaliannya oleh CEO Ultima [Peminjam: Guest] [By: Guest]', 1, 'super admin,admin,supervisor,user', 1, '2026-11-02 06:39:36'),
(135, 'peminjaman_baru', 'Guest membuat peminjaman baru (GKM-PJM-1)', NULL, 'super admin,admin,supervisor', 0, '2026-11-03 03:23:05'),
(136, 'stok_rendah_aset', 'Stok Aputure 120x tersisa 0 unit', 88, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(137, 'stok_rendah_aset', 'Stok Aputure 300d ii tersisa 0 unit', 85, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(138, 'stok_rendah_aset', 'Stok Aputure ls 600x pro tersisa 0 unit', 84, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(139, 'stok_rendah_aset', 'Stok Aputure nova p300c tersisa 0 unit', 89, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(140, 'stok_rendah_aset', 'Stok Arri skypanel s120-c tersisa 0 unit', 92, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(141, 'stok_rendah_aset', 'Stok Fujifilm x-t5 body tersisa 0 unit', 14, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(142, 'stok_rendah_aset', 'Stok Godox ml60 tersisa 0 unit', 97, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(143, 'stok_rendah_aset', 'Stok Nanlite forza 300 tersisa 0 unit', 99, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(144, 'stok_rendah_aset', 'Stok Godox ul150 ii tersisa 0 unit', 96, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(145, 'stok_rendah_aset', 'Stok Panasonic 70-200mm f/2.8 tersisa 0 unit', 50, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(146, 'stok_rendah_aset', 'Stok Panasonic lumix gh5 ii tersisa 0 unit', 22, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(147, 'stok_rendah_aset', 'Stok Panasonic 24-70mm f/2.8 tersisa 0 unit', 49, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(148, 'stok_rendah_aset', 'Stok Sony alpha 7s iii tersisa 0 unit', 13, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(149, 'stok_rendah_aset', 'Stok Sony alpha 7 iv body tersisa 0 unit', 4, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(150, 'stok_rendah_aset', 'Stok Sony fe 12-24mm f/2.8 gm tersisa 0 unit', 58, 'super admin,admin', 0, '2026-11-03 03:23:05'),
(151, 'approved', 'Peminjaman GKM-PJM-1 telah disetujui untuk dipinjam oleh CEO Ultima [Peminjam: Guest] [By: Guest]', 1, 'super admin,admin,supervisor,user', 0, '2026-11-03 03:31:01'),
(152, 'dikembalikan', 'Peminjaman GKM-PJM-1 menunggu verifikasi pengembalian dari Guest', 1, 'super admin,admin,supervisor', 0, '2026-11-03 03:31:13'),
(153, 'approved', 'Peminjaman GKM-PJM-1 telah diverifikasi pengembaliannya oleh CEO Ultima [Peminjam: Guest] [By: Guest]', 1, 'super admin,admin,supervisor,user', 0, '2026-11-03 03:31:26');

-- --------------------------------------------------------

--
-- Struktur dari tabel `paket_peminjaman`
--

CREATE TABLE `paket_peminjaman` (
  `id` int(11) NOT NULL,
  `nama_paket` varchar(150) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `gambar` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `paket_peminjaman`
--

INSERT INTO `paket_peminjaman` (`id`, `nama_paket`, `deskripsi`, `gambar`, `created_at`, `updated_at`) VALUES
(1, 'VIDEOTRON 4 X 3', 'VIDEO TRONE 19 PANEL\r\nBESI 2 METER\r\nPANGGUNG\r\nJURIGEN\r\nLIGHTNING\r\nSTROBO', '/uploads/paket-1793679806675-907328666.webp', '2026-11-03 04:23:09', '2026-11-03 04:24:57');

-- --------------------------------------------------------

--
-- Struktur dari tabel `paket_peminjaman_items`
--

CREATE TABLE `paket_peminjaman_items` (
  `id` int(11) NOT NULL,
  `paket_id` int(11) NOT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `aksesoris_id` int(11) DEFAULT NULL,
  `jumlah` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `paket_peminjaman_items`
--

INSERT INTO `paket_peminjaman_items` (`id`, `paket_id`, `asset_id`, `aksesoris_id`, `jumlah`) VALUES
(7, 1, 63, NULL, 1),
(8, 1, 64, NULL, 1),
(9, 1, 65, NULL, 1);

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
  `status` enum('Menunggu Persetujuan','Sedang Dipinjam','Menunggu Verifikasi','Peminjaman Selesai','Ditolak') DEFAULT 'Menunggu Persetujuan',
  `alasan_penolakan` text DEFAULT NULL,
  `rejected_by` varchar(255) DEFAULT NULL,
  `yang_menyerahkan` varchar(255) DEFAULT NULL,
  `approved_by` varchar(255) DEFAULT NULL,
  `return_approved_by` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bukti_peminjaman` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `bukti_pengembalian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`id`, `kode_pinjam`, `nama_peminjam`, `penerima_aset`, `alasan_peminjaman`, `keperluan_list`, `tanggal_peminjaman`, `tanggal_pengembalian`, `status`, `yang_menyerahkan`, `approved_by`, `return_approved_by`, `created_at`, `updated_at`, `bukti_peminjaman`, `bukti_pengembalian`, `user_id`) VALUES
(1, 'GKM-PJM-1', 'Guest', 'Bayu Pratama', 'Wedding', '[{\"keperluan\":\"Wedding\"},{\"keperluan\":\"Acara keluarga\"},{\"keperluan\":\"Hang out\"}]', '2026-11-03 10:23:05', '2026-11-03 10:31:13', 'Peminjaman Selesai', 'Ceo Ultima', 'CEO Ultima', 'CEO Ultima', '2026-11-03 03:23:05', '2026-11-03 03:31:26', '[\"/uploads/bukti_pinjam-1793676185787-887380747-0.webp\"]', '[\"/uploads/bukti_kembali-1793676673435-681352641-0.webp\"]', 22);

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

--
-- Dumping data untuk tabel `peminjaman_items`
--

INSERT INTO `peminjaman_items` (`id`, `peminjaman_id`, `asset_id`, `unit_id`, `aksesoris_id`, `aksesoris_unit_id`, `jumlah`) VALUES
(1, 1, 88, 193, NULL, NULL, 1),
(2, 1, 85, 190, NULL, NULL, 1),
(3, 1, 84, 189, NULL, NULL, 1),
(4, 1, 89, 194, NULL, NULL, 1),
(5, 1, 92, 197, NULL, NULL, 1),
(6, 1, 14, 19, NULL, NULL, 1),
(7, 1, 97, 202, NULL, NULL, 1),
(8, 1, 99, 204, NULL, NULL, 1),
(9, 1, 96, 201, NULL, NULL, 1),
(10, 1, 50, 55, NULL, NULL, 1),
(11, 1, 22, 27, NULL, NULL, 1),
(12, 1, 49, 54, NULL, NULL, 1),
(13, 1, 13, 18, NULL, NULL, 1),
(14, 1, 4, 9, NULL, NULL, 1),
(15, 1, 58, 63, NULL, NULL, 1);

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
(18, 20, 'Bayu Pratama', 'bayu.pratama@email.com', '$2b$10$LmLaT3DbyJcEN99aG8LJiePqHFChjWgtFBA1pveeeMnqvHGMrwFb6', 'supervisor', '2026-09-16 04:54:36', '2026-10-23 11:56:05', NULL, NULL, NULL, 0, 1),
(22, NULL, 'Guest', 'guest@guest.com', '$2b$10$e1YyPtGT2kXIuQDzTurJJuEm6cY9DDxhcZ7hgO1slu7/D8o0RzTQO', 'user', '2026-11-02 05:43:19', '2026-11-02 07:00:15', '/uploads/profiles/profile-1793602815383-599405031.webp', '01234234', 'Magang stikom', 0, 1);

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
-- Indeks untuk tabel `paket_peminjaman`
--
ALTER TABLE `paket_peminjaman`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `paket_peminjaman_items`
--
ALTER TABLE `paket_peminjaman_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paket_id` (`paket_id`),
  ADD KEY `asset_id` (`asset_id`),
  ADD KEY `aksesoris_id` (`aksesoris_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `aksesoris_units`
--
ALTER TABLE `aksesoris_units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `assets`
--
ALTER TABLE `assets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT untuk tabel `asset_units`
--
ALTER TABLE `asset_units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT untuk tabel `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT untuk tabel `paket_peminjaman`
--
ALTER TABLE `paket_peminjaman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `paket_peminjaman_items`
--
ALTER TABLE `paket_peminjaman_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `peminjaman_items`
--
ALTER TABLE `peminjaman_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `tbl_pegawai`
--
ALTER TABLE `tbl_pegawai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

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
-- Ketidakleluasaan untuk tabel `paket_peminjaman_items`
--
ALTER TABLE `paket_peminjaman_items`
  ADD CONSTRAINT `fk_paket_items_aksesoris` FOREIGN KEY (`aksesoris_id`) REFERENCES `aksesoris` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_paket_items_asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_paket_items_paket` FOREIGN KEY (`paket_id`) REFERENCES `paket_peminjaman` (`id`) ON DELETE CASCADE;

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
