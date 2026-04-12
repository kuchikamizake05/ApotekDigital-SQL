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

-- 4. Isilah masing-masing tabel dengan 6 baris data memanfaatkan perintah DML SQL

-- Menyisipkan data pelanggan
INSERT INTO pelanggan (nama, alamat, no_telepon, tanggal_lahir, tanggal_daftar) VALUES
('Budi Santoso', 'Jl. Merdeka No. 1, Jakarta', '081234567890', '1990-05-15', '2023-01-10'),
('Siti Aminah', 'Jl. Sudirman No. 2, Bandung', '081298765432', '1985-08-20', '2023-02-15'),
('Andi Wijaya', 'Jl. Thamrin No. 3, Surabaya', '085612345678', '1992-11-10', '2023-03-20'),
('Dewi Lestari', 'Jl. Gatot Subroto No. 4, Medan', '081345678901', '1988-04-25', '2023-04-05'),
('Rudi Hermawan', 'Jl. Diponegoro No. 5, Semarang', '081987654321', '1995-12-30', '2023-05-12'),
('Rina Marlina', 'Jl. Pahlawan No. 6, Yogyakarta', '087812349876', '1998-02-14', '2023-06-18');

-- Menyisipkan data apoteker
INSERT INTO apoteker (nama, no_sipa, no_telepon, shift) VALUES
('Apt. Cahaya, S.Farm', 'SIPA-001/2020', '081122334455', 'Pagi'),
('Apt. Surya, S.Farm', 'SIPA-002/2021', '082233445566', 'Siang'),
('Apt. Bintang, S.Farm', 'SIPA-003/2019', '083344556677', 'Malam'),
('Apt. Bulan, S.Farm', 'SIPA-004/2022', '084455667788', 'Pagi'),
('Apt. Mega, S.Farm', 'SIPA-005/2018', '085566778899', 'Siang'),
('Apt. Awan, S.Farm', 'SIPA-006/2023', '086677889900', 'Malam');

-- Menyisipkan data kategori_obat
INSERT INTO kategori_obat (nama_kategori, deskripsi, golongan) VALUES
('Antibiotik', 'Obat untuk mengatasi infeksi bakteri', 'Keras'),
('Analgesik', 'Obat pereda nyeri', 'Bebas Terbatas'),
('Vitamin', 'Suplemen penambah daya tahan tubuh', 'Bebas'),
('Antihistamin', 'Obat untuk meredakan alergi', 'Bebas Terbatas'),
('Antiseptik', 'Cairan pembersih luka luaran', 'Bebas'),
('Obat Batuk', 'Obat untuk meredakan batuk berdahak', 'Bebas');
