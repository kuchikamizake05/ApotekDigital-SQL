-- 1. Buatlah database dengan nama tertentu yang sesuai dengan rancangan yang sudah dibuat
DROP DATABASE IF EXISTS apotek_digital;
CREATE DATABASE apotek_digital;

-- 2. Gunakan database tersebut untuk menyimpan tabel-tabel yang sesuai dengan schema logical yang sudah dibuat pada tugas sebelumnya
USE apotek_digital;

-- 3. Buatlah tabel-tabel secara lengkap dengan perintah DDL SQL yang sesuai dengan schema logical yang sudah dibuat pada tugas sebelumnya

-- Tabel pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    alamat TEXT,
    no_telepon VARCHAR(15),
    tanggal_lahir DATE,
    tanggal_daftar DATE NOT NULL
);

-- Tabel apoteker
CREATE TABLE apoteker (
    id_apoteker INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    no_sipa VARCHAR(50) UNIQUE NOT NULL,
    no_telepon VARCHAR(15),
    shift VARCHAR(20) DEFAULT 'Pagi'
);

-- Tabel kategori_obat
CREATE TABLE kategori_obat (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    golongan VARCHAR(30) NOT NULL
);

-- Tabel obat
CREATE TABLE obat (
    id_obat INT AUTO_INCREMENT PRIMARY KEY,
    id_kategori INT,
    nama_obat VARCHAR(150) NOT NULL,
    merek VARCHAR(100),
    harga_satuan DECIMAL(10,2) NOT NULL,
    stok INT DEFAULT 0,
    satuan VARCHAR(20) DEFAULT 'tablet',
    tanggal_kadaluarsa DATE NOT NULL,
    FOREIGN KEY (id_kategori) REFERENCES kategori_obat(id_kategori)
);

-- Tabel transaksi
CREATE TABLE transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT,
    id_apoteker INT,
    tanggal_transaksi DATETIME NOT NULL,
    total_harga DECIMAL(12,2) DEFAULT 0,
    metode_pembayaran VARCHAR(30) DEFAULT 'Tunai',
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan),
    FOREIGN KEY (id_apoteker) REFERENCES apoteker(id_apoteker)
);

-- Tabel detail_transaksi
CREATE TABLE detail_transaksi (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_transaksi INT,
    id_obat INT,
    jumlah INT NOT NULL,
    harga_satuan DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi),
    FOREIGN KEY (id_obat) REFERENCES obat(id_obat)
);

