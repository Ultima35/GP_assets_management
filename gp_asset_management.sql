-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 31 Okt 2026 pada 08.14
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
(153, 'AST-GPRO-VID-001', 'Videotron a - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: a1, a2, a3, a4, a5, a6', '2026-10-23 07:35:56', '2026-10-31 07:04:02', 0, 25000000.00, 'Per Paket', 6, NULL, 1),
(154, 'AST-GPRO-VID-002', 'Videotron b - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: b1, b2, b3, b4, b5, b6', '2026-10-23 07:35:56', '2026-10-31 07:04:02', 0, 25000000.00, 'Per Paket', 6, NULL, 1),
(155, 'AST-GPRO-VID-003', 'Videotron c - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: c1, c2, c3, c4, c5, c6', '2026-10-23 07:35:56', '2026-10-31 07:04:02', 0, 25000000.00, 'Per Paket', 6, NULL, 1),
(156, 'AST-GPRO-VID-004', 'Videotron d - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: d1, d2, d3, d4, d5, d6', '2026-10-23 07:35:56', '2026-10-31 07:04:02', 3, 25000000.00, 'Per Paket', 6, NULL, 1),
(157, 'AST-GPRO-VID-005', 'Videotron e - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: e1, e2, e3, e4, e5, e6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(158, 'AST-GPRO-VID-006', 'Videotron f - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: f1, f2, f3, f4, f5, f6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(159, 'AST-GPRO-VID-007', 'Videotron g - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: g1, g2, g3, g4, g5, g6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(160, 'AST-GPRO-VID-008', 'Videotron h - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: h1, h2, h3, h4, h5, h6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(161, 'AST-GPRO-VID-009', 'Videotron i - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: i1, i2, i3, i4, i5, i6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(162, 'AST-GPRO-VID-010', 'Videotron j - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: j1, j2, j3, j4, j5, j6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(163, 'AST-GPRO-VID-011', 'Videotron k - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: k1, k2, k3, k4, k5, k6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(164, 'AST-GPRO-VID-012', 'Videotron l - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: l1, l2, l3, l4, l5, l6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(165, 'AST-GPRO-VID-013', 'Videotron m - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: m1, m2, m3, m4, m5, m6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(166, 'AST-GPRO-VID-014', 'Videotron n - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: n1, n2, n3, n4, n5, n6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(167, 'AST-GPRO-VID-015', 'Videotron o - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: o1, o2, o3, o4, o5, o6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(168, 'AST-GPRO-VID-016', 'Videotron p - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: p1, p2, p3, p4, p5, p6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(169, 'AST-GPRO-VID-017', 'Videotron q - 50 x 100 ncled', 'Mushsin', 'Videotron', 'NCLED', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: q1, q2, q3, q4, q5, q6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(170, 'AST-GPRO-VID-018', 'Videotron r - 50 x 50 gkgd', 'Mushsin', 'Videotron', 'GKGD', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: r1, r2, r3, r4, r5, r6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(171, 'AST-GPRO-VID-019', 'Videotron s - 50 x 50 gkgd', 'Mushsin', 'Videotron', 'GKGD', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: s1, s2, s3, s4, s5, s6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(172, 'AST-GPRO-VID-020', 'Videotron t - 50 x 50 gkgd', 'Mushsin', 'Videotron', 'GKGD', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: t1, t2, t3, t4, t5, t6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(173, 'AST-GPRO-VID-021', 'Videotron u - 50 x 50 gkgd', 'Mushsin', 'Videotron', 'GKGD', NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, 'Berisi 6 kabinet: u1, u2, u3, u4, u5, u6', '2026-10-23 07:35:56', '2026-10-23 07:35:56', 6, 25000000.00, 'Per Paket', 6, NULL, 1),
(174, 'AST-GPRO-VID-022', 'Kabel lan 50cm', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02', 0, 0.00, 'Per Unit', 1, NULL, 1),
(175, 'AST-GPRO-VID-023', 'Kabel lan 30 meter', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02', 0, 0.00, 'Per Unit', 1, NULL, 1),
(176, 'AST-GPRO-VID-024', 'Kabel lan 50 meter', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02', 0, 0.00, 'Per Unit', 1, NULL, 1),
(177, 'AST-GPRO-VID-025', 'Kabel lan 100 meter', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02', 0, 0.00, 'Per Unit', 1, NULL, 1),
(178, 'AST-GPRO-VID-026', 'Kabel powercon 50cm', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02', 0, 0.00, 'Per Unit', 1, NULL, 1),
(179, 'AST-GPRO-VID-027', 'Kabel powercon listrik biasa', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02', 0, 0.00, 'Per Unit', 1, NULL, 1),
(180, 'AST-GPRO-VID-028', 'Kabel powercon listrik tiga', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02', 0, 0.00, 'Per Unit', 1, NULL, 1),
(181, 'AST-GPRO-VID-029', 'Prosecessor vx 10', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(182, 'AST-GPRO-VID-030', 'Processor x2m', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(183, 'AST-GPRO-VID-031', 'Processor x4', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(184, 'AST-GPRO-VID-032', 'Rangka besi 180', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(185, 'AST-GPRO-VID-033', 'Rabgka besi 150', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(186, 'AST-GPRO-VID-034', 'Rangka besi 100', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(187, 'AST-GPRO-VID-035', 'Rangka besi 50', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(188, 'AST-GPRO-VID-036', 'Besi dasar 200', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(189, 'AST-GPRO-VID-037', 'Besi dasar 100', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(190, 'AST-GPRO-VID-038', 'Penyambung', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(191, 'AST-GPRO-VID-039', 'Penyangga', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(192, 'AST-GPRO-VID-040', 'Dudukan', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(193, 'AST-GPRO-VID-041', 'T kecil', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(194, 'AST-GPRO-VID-042', 'T besar', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(195, 'AST-GPRO-VID-043', 'Galon air', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1),
(196, 'AST-GPRO-VID-044', 'Panel listrik led', 'Mushsin', 'Videotron', NULL, NULL, NULL, NULL, 'GUDANG', 'Galeria Production', 'Siap Digunakan', NULL, NULL, NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56', 1, 0.00, 'Per Unit', 1, NULL, 1);

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
(299, 153, 'AST-GPRO-VID-001-01', 'A1', NULL, 'Maintenance', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: a1, a2, a3, a4, a5, a6', '2026-10-23 07:35:56', '2026-10-23 10:23:37'),
(300, 153, 'AST-GPRO-VID-001-02', 'A2', NULL, 'Maintenance', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: a1, a2, a3, a4, a5, a6', '2026-10-23 07:35:56', '2026-10-23 10:23:39'),
(301, 153, 'AST-GPRO-VID-001-03', 'A3', NULL, 'Rusak', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: a1, a2, a3, a4, a5, a6', '2026-10-23 07:35:56', '2026-10-23 10:23:40'),
(302, 153, 'AST-GPRO-VID-001-04', 'A4', NULL, 'Rusak', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: a1, a2, a3, a4, a5, a6', '2026-10-23 07:35:56', '2026-10-23 10:23:42'),
(303, 153, 'AST-GPRO-VID-001-05', 'A5', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: a1, a2, a3, a4, a5, a6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(304, 153, 'AST-GPRO-VID-001-06', 'A6', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: a1, a2, a3, a4, a5, a6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(305, 154, 'AST-GPRO-VID-002-01', 'B1', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: b1, b2, b3, b4, b5, b6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(306, 154, 'AST-GPRO-VID-002-02', 'B2', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: b1, b2, b3, b4, b5, b6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(307, 154, 'AST-GPRO-VID-002-03', 'B3', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: b1, b2, b3, b4, b5, b6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(308, 154, 'AST-GPRO-VID-002-04', 'B4', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: b1, b2, b3, b4, b5, b6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(309, 154, 'AST-GPRO-VID-002-05', 'B5', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: b1, b2, b3, b4, b5, b6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(310, 154, 'AST-GPRO-VID-002-06', 'B6', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: b1, b2, b3, b4, b5, b6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(311, 155, 'AST-GPRO-VID-003-01', 'C1', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: c1, c2, c3, c4, c5, c6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(312, 155, 'AST-GPRO-VID-003-02', 'C2', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: c1, c2, c3, c4, c5, c6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(313, 155, 'AST-GPRO-VID-003-03', 'C3', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: c1, c2, c3, c4, c5, c6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(314, 155, 'AST-GPRO-VID-003-04', 'C4', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: c1, c2, c3, c4, c5, c6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(315, 155, 'AST-GPRO-VID-003-05', 'C5', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: c1, c2, c3, c4, c5, c6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(316, 155, 'AST-GPRO-VID-003-06', 'C6', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: c1, c2, c3, c4, c5, c6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(317, 156, 'AST-GPRO-VID-004-01', 'D1', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: d1, d2, d3, d4, d5, d6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(318, 156, 'AST-GPRO-VID-004-02', 'D2', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: d1, d2, d3, d4, d5, d6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(319, 156, 'AST-GPRO-VID-004-03', 'D3', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', 'Berisi 6 kabinet: d1, d2, d3, d4, d5, d6', '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(320, 156, 'AST-GPRO-VID-004-04', 'D4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: d1, d2, d3, d4, d5, d6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(321, 156, 'AST-GPRO-VID-004-05', 'D5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: d1, d2, d3, d4, d5, d6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(322, 156, 'AST-GPRO-VID-004-06', 'D6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: d1, d2, d3, d4, d5, d6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(323, 157, 'AST-GPRO-VID-005-01', 'E1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: e1, e2, e3, e4, e5, e6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(324, 157, 'AST-GPRO-VID-005-02', 'E2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: e1, e2, e3, e4, e5, e6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(325, 157, 'AST-GPRO-VID-005-03', 'E3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: e1, e2, e3, e4, e5, e6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(326, 157, 'AST-GPRO-VID-005-04', 'E4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: e1, e2, e3, e4, e5, e6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(327, 157, 'AST-GPRO-VID-005-05', 'E5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: e1, e2, e3, e4, e5, e6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(328, 157, 'AST-GPRO-VID-005-06', 'E6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: e1, e2, e3, e4, e5, e6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(329, 158, 'AST-GPRO-VID-006-01', 'F1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: f1, f2, f3, f4, f5, f6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(330, 158, 'AST-GPRO-VID-006-02', 'F2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: f1, f2, f3, f4, f5, f6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(331, 158, 'AST-GPRO-VID-006-03', 'F3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: f1, f2, f3, f4, f5, f6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(332, 158, 'AST-GPRO-VID-006-04', 'F4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: f1, f2, f3, f4, f5, f6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(333, 158, 'AST-GPRO-VID-006-05', 'F5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: f1, f2, f3, f4, f5, f6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(334, 158, 'AST-GPRO-VID-006-06', 'F6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: f1, f2, f3, f4, f5, f6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(335, 159, 'AST-GPRO-VID-007-01', 'G1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: g1, g2, g3, g4, g5, g6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(336, 159, 'AST-GPRO-VID-007-02', 'G2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: g1, g2, g3, g4, g5, g6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(337, 159, 'AST-GPRO-VID-007-03', 'G3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: g1, g2, g3, g4, g5, g6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(338, 159, 'AST-GPRO-VID-007-04', 'G4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: g1, g2, g3, g4, g5, g6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(339, 159, 'AST-GPRO-VID-007-05', 'G5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: g1, g2, g3, g4, g5, g6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(340, 159, 'AST-GPRO-VID-007-06', 'G6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: g1, g2, g3, g4, g5, g6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(341, 160, 'AST-GPRO-VID-008-01', 'H1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: h1, h2, h3, h4, h5, h6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(342, 160, 'AST-GPRO-VID-008-02', 'H2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: h1, h2, h3, h4, h5, h6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(343, 160, 'AST-GPRO-VID-008-03', 'H3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: h1, h2, h3, h4, h5, h6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(344, 160, 'AST-GPRO-VID-008-04', 'H4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: h1, h2, h3, h4, h5, h6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(345, 160, 'AST-GPRO-VID-008-05', 'H5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: h1, h2, h3, h4, h5, h6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(346, 160, 'AST-GPRO-VID-008-06', 'H6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: h1, h2, h3, h4, h5, h6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(347, 161, 'AST-GPRO-VID-009-01', 'I1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: i1, i2, i3, i4, i5, i6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(348, 161, 'AST-GPRO-VID-009-02', 'I2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: i1, i2, i3, i4, i5, i6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(349, 161, 'AST-GPRO-VID-009-03', 'I3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: i1, i2, i3, i4, i5, i6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(350, 161, 'AST-GPRO-VID-009-04', 'I4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: i1, i2, i3, i4, i5, i6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(351, 161, 'AST-GPRO-VID-009-05', 'I5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: i1, i2, i3, i4, i5, i6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(352, 161, 'AST-GPRO-VID-009-06', 'I6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: i1, i2, i3, i4, i5, i6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(353, 162, 'AST-GPRO-VID-010-01', 'J1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: j1, j2, j3, j4, j5, j6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(354, 162, 'AST-GPRO-VID-010-02', 'J2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: j1, j2, j3, j4, j5, j6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(355, 162, 'AST-GPRO-VID-010-03', 'J3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: j1, j2, j3, j4, j5, j6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(356, 162, 'AST-GPRO-VID-010-04', 'J4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: j1, j2, j3, j4, j5, j6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(357, 162, 'AST-GPRO-VID-010-05', 'J5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: j1, j2, j3, j4, j5, j6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(358, 162, 'AST-GPRO-VID-010-06', 'J6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: j1, j2, j3, j4, j5, j6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(359, 163, 'AST-GPRO-VID-011-01', 'K1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: k1, k2, k3, k4, k5, k6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(360, 163, 'AST-GPRO-VID-011-02', 'K2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: k1, k2, k3, k4, k5, k6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(361, 163, 'AST-GPRO-VID-011-03', 'K3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: k1, k2, k3, k4, k5, k6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(362, 163, 'AST-GPRO-VID-011-04', 'K4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: k1, k2, k3, k4, k5, k6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(363, 163, 'AST-GPRO-VID-011-05', 'K5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: k1, k2, k3, k4, k5, k6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(364, 163, 'AST-GPRO-VID-011-06', 'K6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: k1, k2, k3, k4, k5, k6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(365, 164, 'AST-GPRO-VID-012-01', 'L1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: l1, l2, l3, l4, l5, l6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(366, 164, 'AST-GPRO-VID-012-02', 'L2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: l1, l2, l3, l4, l5, l6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(367, 164, 'AST-GPRO-VID-012-03', 'L3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: l1, l2, l3, l4, l5, l6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(368, 164, 'AST-GPRO-VID-012-04', 'L4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: l1, l2, l3, l4, l5, l6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(369, 164, 'AST-GPRO-VID-012-05', 'L5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: l1, l2, l3, l4, l5, l6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(370, 164, 'AST-GPRO-VID-012-06', 'L6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: l1, l2, l3, l4, l5, l6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(371, 165, 'AST-GPRO-VID-013-01', 'M1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: m1, m2, m3, m4, m5, m6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(372, 165, 'AST-GPRO-VID-013-02', 'M2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: m1, m2, m3, m4, m5, m6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(373, 165, 'AST-GPRO-VID-013-03', 'M3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: m1, m2, m3, m4, m5, m6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(374, 165, 'AST-GPRO-VID-013-04', 'M4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: m1, m2, m3, m4, m5, m6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(375, 165, 'AST-GPRO-VID-013-05', 'M5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: m1, m2, m3, m4, m5, m6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(376, 165, 'AST-GPRO-VID-013-06', 'M6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: m1, m2, m3, m4, m5, m6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(377, 166, 'AST-GPRO-VID-014-01', 'N1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: n1, n2, n3, n4, n5, n6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(378, 166, 'AST-GPRO-VID-014-02', 'N2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: n1, n2, n3, n4, n5, n6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(379, 166, 'AST-GPRO-VID-014-03', 'N3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: n1, n2, n3, n4, n5, n6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(380, 166, 'AST-GPRO-VID-014-04', 'N4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: n1, n2, n3, n4, n5, n6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(381, 166, 'AST-GPRO-VID-014-05', 'N5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: n1, n2, n3, n4, n5, n6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(382, 166, 'AST-GPRO-VID-014-06', 'N6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: n1, n2, n3, n4, n5, n6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(383, 167, 'AST-GPRO-VID-015-01', 'O1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: o1, o2, o3, o4, o5, o6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(384, 167, 'AST-GPRO-VID-015-02', 'O2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: o1, o2, o3, o4, o5, o6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(385, 167, 'AST-GPRO-VID-015-03', 'O3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: o1, o2, o3, o4, o5, o6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(386, 167, 'AST-GPRO-VID-015-04', 'O4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: o1, o2, o3, o4, o5, o6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(387, 167, 'AST-GPRO-VID-015-05', 'O5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: o1, o2, o3, o4, o5, o6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(388, 167, 'AST-GPRO-VID-015-06', 'O6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: o1, o2, o3, o4, o5, o6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(389, 168, 'AST-GPRO-VID-016-01', 'P1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: p1, p2, p3, p4, p5, p6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(390, 168, 'AST-GPRO-VID-016-02', 'P2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: p1, p2, p3, p4, p5, p6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(391, 168, 'AST-GPRO-VID-016-03', 'P3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: p1, p2, p3, p4, p5, p6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(392, 168, 'AST-GPRO-VID-016-04', 'P4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: p1, p2, p3, p4, p5, p6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(393, 168, 'AST-GPRO-VID-016-05', 'P5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: p1, p2, p3, p4, p5, p6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(394, 168, 'AST-GPRO-VID-016-06', 'P6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: p1, p2, p3, p4, p5, p6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(395, 169, 'AST-GPRO-VID-017-01', 'Q1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: q1, q2, q3, q4, q5, q6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(396, 169, 'AST-GPRO-VID-017-02', 'Q2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: q1, q2, q3, q4, q5, q6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(397, 169, 'AST-GPRO-VID-017-03', 'Q3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: q1, q2, q3, q4, q5, q6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(398, 169, 'AST-GPRO-VID-017-04', 'Q4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: q1, q2, q3, q4, q5, q6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(399, 169, 'AST-GPRO-VID-017-05', 'Q5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: q1, q2, q3, q4, q5, q6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(400, 169, 'AST-GPRO-VID-017-06', 'Q6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: q1, q2, q3, q4, q5, q6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(401, 170, 'AST-GPRO-VID-018-01', 'R1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: r1, r2, r3, r4, r5, r6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(402, 170, 'AST-GPRO-VID-018-02', 'R2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: r1, r2, r3, r4, r5, r6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(403, 170, 'AST-GPRO-VID-018-03', 'R3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: r1, r2, r3, r4, r5, r6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(404, 170, 'AST-GPRO-VID-018-04', 'R4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: r1, r2, r3, r4, r5, r6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(405, 170, 'AST-GPRO-VID-018-05', 'R5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: r1, r2, r3, r4, r5, r6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(406, 170, 'AST-GPRO-VID-018-06', 'R6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: r1, r2, r3, r4, r5, r6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(407, 171, 'AST-GPRO-VID-019-01', 'S1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: s1, s2, s3, s4, s5, s6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(408, 171, 'AST-GPRO-VID-019-02', 'S2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: s1, s2, s3, s4, s5, s6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(409, 171, 'AST-GPRO-VID-019-03', 'S3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: s1, s2, s3, s4, s5, s6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(410, 171, 'AST-GPRO-VID-019-04', 'S4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: s1, s2, s3, s4, s5, s6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(411, 171, 'AST-GPRO-VID-019-05', 'S5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: s1, s2, s3, s4, s5, s6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(412, 171, 'AST-GPRO-VID-019-06', 'S6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: s1, s2, s3, s4, s5, s6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(413, 172, 'AST-GPRO-VID-020-01', 'T1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: t1, t2, t3, t4, t5, t6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(414, 172, 'AST-GPRO-VID-020-02', 'T2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: t1, t2, t3, t4, t5, t6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(415, 172, 'AST-GPRO-VID-020-03', 'T3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: t1, t2, t3, t4, t5, t6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(416, 172, 'AST-GPRO-VID-020-04', 'T4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: t1, t2, t3, t4, t5, t6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(417, 172, 'AST-GPRO-VID-020-05', 'T5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: t1, t2, t3, t4, t5, t6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(418, 172, 'AST-GPRO-VID-020-06', 'T6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: t1, t2, t3, t4, t5, t6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(419, 173, 'AST-GPRO-VID-021-01', 'U1', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: u1, u2, u3, u4, u5, u6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(420, 173, 'AST-GPRO-VID-021-02', 'U2', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: u1, u2, u3, u4, u5, u6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(421, 173, 'AST-GPRO-VID-021-03', 'U3', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: u1, u2, u3, u4, u5, u6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(422, 173, 'AST-GPRO-VID-021-04', 'U4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: u1, u2, u3, u4, u5, u6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(423, 173, 'AST-GPRO-VID-021-05', 'U5', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: u1, u2, u3, u4, u5, u6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(424, 173, 'AST-GPRO-VID-021-06', 'U6', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', 'Berisi 6 kabinet: u1, u2, u3, u4, u5, u6', '2026-10-23 07:35:56', '2026-10-23 09:49:01'),
(425, 174, 'AST-GPRO-VID-022-01', 'Kabel lan 50cm', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(426, 175, 'AST-GPRO-VID-023-01', 'Kabel lan 30 meter', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(427, 176, 'AST-GPRO-VID-024-01', 'Kabel lan 50 meter', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(428, 177, 'AST-GPRO-VID-025-01', 'Kabel lan 100 meter', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(429, 178, 'AST-GPRO-VID-026-01', 'Kabel powercon 50cm', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(430, 179, 'AST-GPRO-VID-027-01', 'Kabel powercon listrik biasa', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(431, 180, 'AST-GPRO-VID-028-01', 'Kabel powercon listrik tiga', NULL, 'Siap Digunakan', 'Dipinjam', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-31 07:04:02'),
(432, 181, 'AST-GPRO-VID-029-01', 'Prosecessor vx 10', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(433, 182, 'AST-GPRO-VID-030-01', 'Processor x2m', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(434, 183, 'AST-GPRO-VID-031-01', 'Processor x4', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(435, 184, 'AST-GPRO-VID-032-01', 'Rangka besi 180', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(436, 185, 'AST-GPRO-VID-033-01', 'Rabgka besi 150', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(437, 186, 'AST-GPRO-VID-034-01', 'Rangka besi 100', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(438, 187, 'AST-GPRO-VID-035-01', 'Rangka besi 50', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(439, 188, 'AST-GPRO-VID-036-01', 'Besi dasar 200', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(440, 189, 'AST-GPRO-VID-037-01', 'Besi dasar 100', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(441, 190, 'AST-GPRO-VID-038-01', 'Penyambung', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(442, 191, 'AST-GPRO-VID-039-01', 'Penyangga', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(443, 192, 'AST-GPRO-VID-040-01', 'Dudukan', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(444, 193, 'AST-GPRO-VID-041-01', 'T kecil', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(445, 194, 'AST-GPRO-VID-042-01', 'T besar', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(446, 195, 'AST-GPRO-VID-043-01', 'Galon air', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56'),
(447, 196, 'AST-GPRO-VID-044-01', 'Panel listrik led', NULL, 'Siap Digunakan', 'Tersedia', 'GUDANG', NULL, '2026-10-23 07:35:56', '2026-10-23 07:35:56');

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
(211, 17, 'Aditya Kurniawan', 'CREATE', 'Peminjaman', NULL, 'Membuat peminjaman baru (GKM-PJM-1) untuk Aditya Kurniawan', '2026-10-31 07:04:02');

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
(11, 'Behringer ', 'aset', '2026-06-29 07:13:14'),
(12, 'VENTION ', 'aksesoris', '2026-06-29 07:18:00'),
(13, 'UGREEN', 'aksesoris', '2026-06-29 07:29:07'),
(14, 'TAKARA', 'aksesoris', '2026-07-01 07:56:39'),
(15, 'BENRO', 'aksesoris', '2026-07-01 08:03:58'),
(16, 'ZEIS', 'aksesoris', '2026-07-01 08:24:27'),
(17, 'SAMYANG', 'aksesoris', '2026-07-01 08:27:20'),
(24, 'SONY ', 'aksesoris', '2026-07-01 12:40:33'),
(25, 'Non Merk', 'aksesoris', '2026-07-02 01:54:25'),
(26, 'Lunar', 'aksesoris', '2026-07-02 02:09:31'),
(27, 'QA electronic', 'aksesoris', '2026-07-02 02:22:07'),
(28, 'SANDISK', 'aksesoris', '2026-07-02 07:23:38'),
(29, 'QA ', 'aset', '2026-07-08 07:03:25');

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
(3, 'Video Processor ', 'VPROC', 'aset', '2026-06-22 02:30:10'),
(4, 'ORBIT HUAWEI ', 'ORBIT', 'aksesoris', '2026-06-22 07:11:52'),
(5, 'matador ', 'STAND TV ', 'aksesoris', '2026-06-22 07:20:37'),
(6, 'Stand Tv putih ', 'STAND TV P', 'aksesoris', '2026-06-22 07:27:52'),
(7, 'ZOOM ', 'ZOOM', 'aset', '2026-06-22 08:10:01'),
(8, 'Recorder Kecil', 'RECORDER', 'aset', '2026-06-22 08:32:29'),
(9, 'ORBIT', 'ORBIT ', 'aset', '2026-06-22 08:51:27'),
(10, 'Switcher ', 'VIDEO SWIT', 'aset', '2026-06-22 09:02:12'),
(11, 'Printer', 'PRINT', 'aset', '2026-06-29 02:09:00'),
(12, 'Kabel Genset', 'KABEL', 'aksesoris', '2026-06-29 07:09:48'),
(13, 'Audio Interface', 'AUDIO INTE', 'aset', '2026-06-29 07:12:58'),
(14, 'KABEL HDMI', 'KABEL HDMI', 'aksesoris', '2026-06-29 07:17:46'),
(15, 'Kabel usb', 'U', 'aksesoris', '2026-06-29 07:27:22'),
(16, 'STAND FLASH ', 'STAND ', 'aksesoris', '2026-07-01 07:56:16'),
(20, 'Stand kamera', 'STND', 'aksesoris', '2026-07-01 08:03:45'),
(21, 'LENSA ', 'LENSA', 'aksesoris', '2026-07-01 08:24:16'),
(22, 'hardcase', 'HRC', 'aksesoris', '2026-07-02 01:51:14'),
(23, 'CARD 64', 'C-64', 'aksesoris', '2026-07-02 07:23:09'),
(24, 'CARD 32', 'C-32', 'aksesoris', '2026-07-02 07:51:54'),
(25, 'STAND TRIPOD', 'STN', 'aksesoris', '2026-07-04 02:34:50'),
(26, 'KABEL', 'KSN', 'aset', '2026-07-04 02:41:04'),
(31, 'KABEL LAN', 'KBL', 'aksesoris', '2026-07-04 04:12:53'),
(32, 'MIC', 'MIC', 'aset', '2026-07-08 07:03:17');

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
(89, 'stok_rendah_aset', 'Stok Kabel lan 50cm tersisa 0 unit', 174, 'super admin,admin', 0, '2026-10-31 07:04:02');

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

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`id`, `kode_pinjam`, `nama_peminjam`, `penerima_aset`, `alasan_peminjaman`, `keperluan_list`, `tanggal_peminjaman`, `tanggal_pengembalian`, `status`, `yang_menyerahkan`, `approved_by`, `return_approved_by`, `created_at`, `updated_at`, `bukti_peminjaman`, `bukti_pengembalian`, `user_id`) VALUES
(16, 'GKM-PJM-1', 'Aditya Kurniawan', NULL, 'Wedding', '[{\"keperluan\":\"Wedding\"}]', '2026-11-01 14:03:58', NULL, 'Menunggu Persetujuan', NULL, NULL, NULL, '2026-10-31 07:04:02', '2026-10-31 07:04:02', '[\"/uploads/bukti_pinjam-1793430242695-426470549-0.webp\",\"/uploads/bukti_pinjam-1793430242699-164397085-1.webp\",\"/uploads/bukti_pinjam-1793430242699-838679262-2.webp\",\"/uploads/bukti_pinjam-1793430242700-849974888-3.webp\",\"/uploads/bukti_pinjam-1793430242700-85816634-4.webp\"]', NULL, 17);

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

INSERT INTO `peminjaman_items` (`id`, `peminjaman_id`, `asset_id`, `unit_id`, `aksesoris_id`, `aksesoris_unit_id`, `jiumlah`) VALUES
(29, 16, 153, 303, NULL, NULL, 1),
(30, 16, 153, 304, NULL, NULL, 1),
(31, 16, 154, 305, NULL, NULL, 1),
(32, 16, 154, 306, NULL, NULL, 1),
(33, 16, 154, 307, NULL, NULL, 1),
(34, 16, 154, 308, NULL, NULL, 1),
(35, 16, 154, 309, NULL, NULL, 1),
(36, 16, 154, 310, NULL, NULL, 1),
(37, 16, 155, 311, NULL, NULL, 1),
(38, 16, 155, 312, NULL, NULL, 1),
(39, 16, 155, 313, NULL, NULL, 1),
(40, 16, 155, 314, NULL, NULL, 1),
(41, 16, 155, 315, NULL, NULL, 1),
(42, 16, 155, 316, NULL, NULL, 1),
(43, 16, 156, 317, NULL, NULL, 1),
(44, 16, 156, 318, NULL, NULL, 1),
(45, 16, 156, 319, NULL, NULL, 1),
(46, 16, 180, 431, NULL, NULL, 1),
(47, 16, 179, 430, NULL, NULL, 1),
(48, 16, 178, 429, NULL, NULL, 1),
(49, 16, 177, 428, NULL, NULL, 1),
(50, 16, 176, 427, NULL, NULL, 1),
(51, 16, 175, 426, NULL, NULL, 1),
(52, 16, 174, 425, NULL, NULL, 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT untuk tabel `aksesoris_units`
--
ALTER TABLE `aksesoris_units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `assets`
--
ALTER TABLE `assets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=197;

--
-- AUTO_INCREMENT untuk tabel `asset_units`
--
ALTER TABLE `asset_units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=448;

--
-- AUTO_INCREMENT untuk tabel `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT untuk tabel `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `peminjaman_items`
--
ALTER TABLE `peminjaman_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

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
E CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
