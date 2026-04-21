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

-- Menyisipkan data obat
INSERT INTO obat (id_kategori, nama_obat, merek, harga_satuan, stok, satuan, tanggal_kadaluarsa) VALUES
(1, 'Amoxicillin 500mg', 'Amoxsan', 5000.00, 100, 'strip', '2025-10-12'),
(2, 'Paracetamol 500mg', 'Panadol', 2000.00, 200, 'strip', '2026-01-15'),
(3, 'Vitamin C 1000mg', 'Enervon-C', 3000.00, 150, 'botol', '2024-12-20'),
(4, 'Cetirizine 10mg', 'Incidal', 4000.00, 80, 'strip', '2025-05-30'),
(5, 'Povidone Iodine', 'Betadine', 15000.00, 50, 'botol', '2027-08-10'),
(6, 'Sirup Obat Batuk', 'Woods', 18000.00, 60, 'botol', '2025-03-22');

-- Menyisipkan data transaksi
INSERT INTO transaksi (id_pelanggan, id_apoteker, tanggal_transaksi, total_harga, metode_pembayaran) VALUES
(1, 1, '2023-11-01 08:30:00', 10000.00, 'Tunai'),
(2, 2, '2023-11-02 14:15:00', 6000.00, 'QRIS'),
(3, 3, '2023-11-03 20:45:00', 15000.00, 'Transfer'),
(4, 4, '2023-11-04 09:00:00', 20000.00, 'Tunai'),
(5, 5, '2023-11-05 13:20:00', 15000.00, 'QRIS'),
(6, 6, '2023-11-06 21:10:00', 36000.00, 'Transfer');

-- Menyisipkan data detail_transaksi
INSERT INTO detail_transaksi (id_transaksi, id_obat, jumlah, harga_satuan, subtotal) VALUES
(1, 1, 2, 5000.00, 10000.00),
(2, 2, 3, 2000.00, 6000.00),
(3, 3, 5, 3000.00, 15000.00),
(4, 4, 5, 4000.00, 20000.00),
(5, 5, 1, 15000.00, 15000.00),
(6, 6, 2, 18000.00, 36000.00);


-- 5. Hapuslah dengan memanfaatkan perintah DML SQL satu baris data pada tiap tabel dengan perintah penghapusan yang beda-beda. Misal penghapusan tabel pertama tanpa pengkondisian, tabel selanjutnya penghapusan dengan berbagai macam pengkondisian yang beda-beda.

-- Menghapus data detail_transaksi tanpa kondisi spesifik (dibatasi limit 1 baris)
DELETE FROM detail_transaksi ORDER BY id_detail DESC LIMIT 1;

-- Menghapus baris transaksi dengan kondisi ID
DELETE FROM transaksi WHERE id_transaksi = 6;

-- Menghapus baris obat menggunakan subquery
DELETE FROM obat WHERE id_obat = (SELECT * FROM (SELECT MAX(id_obat) FROM obat) AS subq);

-- Menghapus baris kategori_obat dengan operator perbandingan
DELETE FROM kategori_obat WHERE id_kategori >= 6 ORDER BY id_kategori ASC LIMIT 1;

-- Menghapus data apoteker dengan pencocokan string
DELETE FROM apoteker WHERE no_sipa = 'SIPA-006/2023';

-- Menghapus data pelanggan dengan kondisi logika AND
DELETE FROM pelanggan WHERE nama = 'Rina Marlina' AND no_telepon = '087812349876';


-- 6. Ubahlah memanfaatkan perintah DML SQL satu baris data pada masing-masing tabel. Misal pengubahan baris tabel pertama tanpa pengkondisian, tabel selanjutnya pengubahan dengan berbagai macam pengkondisian yang beda-beda.

-- Mengubah baris pada detail_transaksi tanpa kondisi khusus
UPDATE detail_transaksi 
SET harga_satuan = harga_satuan + 500, subtotal = jumlah * (harga_satuan + 500) 
ORDER BY id_detail ASC LIMIT 1;

-- Mengubah transaksi dengan kondisi berdasarkan ID
UPDATE transaksi SET total_harga = 11000.00 WHERE id_transaksi = 1;

-- Mengubah baris obat dengan kondisi string LIKE
UPDATE obat SET stok = stok + 15 WHERE nama_obat LIKE '%Amoxicillin%';

-- Mengubah kategori_obat dengan operator perbandingan
UPDATE kategori_obat SET deskripsi = 'Obat anti bakteri wajib dengan resep dokter' WHERE id_kategori <= 1 LIMIT 1;

-- Mengubah data apoteker menggunakan logika AND
UPDATE apoteker SET shift = 'Siang' WHERE id_apoteker = 1 AND nama = 'Apt. Cahaya, S.Farm';

-- Mengubah data pelanggan menggunakan subquery
UPDATE pelanggan SET alamat = 'Jl. Perjuangan Baru No. 1, Jakarta' WHERE id_pelanggan = (SELECT * FROM (SELECT MIN(id_pelanggan) FROM pelanggan) AS tmp);


-- 7. Lakukan query memanfaatkan perintah DQL SQL yang melibatkan 1 tabel yang berbeda-beda dengan Query biasa, query dengan distict, query dengan sorting, query dengan memanfaatkan pengkondisian menggunakan berbagai operator, query dengan memanfaatkan grouping, query dengan memanfaatkan grouping dan having, serta berbagai macam query dengan memanfaatkan aggregat function dan grouping serta having

-- Menampilkan data obat (Query biasa)
SELECT nama_obat, merek, harga_satuan FROM obat;

-- Menampilkan variasi shift apoteker (Query dengan distinct)
SELECT DISTINCT shift FROM apoteker;

-- Menampilkan data pelanggan berurutan (Query dengan sorting)
SELECT * FROM pelanggan ORDER BY tanggal_daftar DESC;

-- Menggunakan berbagai variasi operator perbandingan dan kondisi
SELECT * FROM apoteker WHERE shift = 'Pagi';                                                -- Operator =
SELECT * FROM kategori_obat WHERE golongan <> 'Keras';                                      -- Operator <>
SELECT * FROM detail_transaksi WHERE jumlah > 2;                                            -- Operator >
SELECT * FROM obat WHERE stok < 100;                                                        -- Operator <
SELECT * FROM transaksi WHERE total_harga >= 15000;                                         -- Operator >=
SELECT * FROM obat WHERE harga_satuan <= 5000;                                              -- Operator <=
SELECT nama, alamat FROM pelanggan WHERE alamat LIKE '%Jakarta%';                           -- Kondisi LIKE
SELECT * FROM transaksi WHERE tanggal_transaksi BETWEEN '2023-11-02 00:00:00' AND '2023-11-04 23:59:59'; -- Kondisi BETWEEN
SELECT * FROM kategori_obat WHERE golongan IN ('Bebas', 'Bebas Terbatas');                  -- Kondisi IN
SELECT * FROM pelanggan WHERE no_telepon IS NOT NULL;                                       -- Kondisi IS NOT NULL
SELECT * FROM transaksi WHERE tanggal_transaksi >= '2023-11-01' AND NOT metode_pembayaran = 'QRIS'; -- Logika keamanan AND/NOT

-- Menampilkan jumlah apoteker per shift (Query dengan grouping)
SELECT shift, COUNT(*) AS jumlah_apoteker FROM apoteker GROUP BY shift;

-- Menampilkan rekap pendapatan lebih dari 10000 (Query grouping dan having)
SELECT metode_pembayaran, SUM(total_harga) AS rekap_pendapatan FROM transaksi GROUP BY metode_pembayaran HAVING rekap_pendapatan > 10000;

-- Menampilkan fungsi statistik data obat (Query aggregate functions)
SELECT COUNT(id_obat) AS total_jenis, MIN(harga_satuan) AS termurah, MAX(harga_satuan) AS termahal, AVG(stok) AS rerata_stok FROM obat;

