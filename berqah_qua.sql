CREATE DATABASE berqah_qua;
USE berqah_qua;
drop DATABASE berqah_qua;
-- DDL
-- Tabel: pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT(5) AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    no_telepon VARCHAR(15),
    alamat VARCHAR(255),
    keterangan ENUM('Rumahan','Warung'),
    deskripsi VARCHAR(255)
);


-- Tabel: produk
CREATE TABLE produk (
    id_produk INT(5) AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(100) NOT NULL,
    harga_warung DECIMAL(10,2),
    harga_rumah DECIMAL(10,2),
    stok INT(5)
);


-- Tabel: bahan_baku
CREATE TABLE bahan_baku (
    id_bahan INT(5) AUTO_INCREMENT PRIMARY KEY,
    nama_bahan VARCHAR(100) NOT NULL,
    stok INT(5),
    satuan VARCHAR(10)
);


-- Tabel: pesanan
CREATE TABLE pesanan (
    id_pesanan INT(5) AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT(5),
    tanggal DATE,
    total_harga DECIMAL(10,2),
    bayar DECIMAL(10,2),
    status_bayar ENUM('Lunas','Belum Lunas'),
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
        ON UPDATE CASCADE ON DELETE CASCADE
);


-- Tabel: detail_pesanan
CREATE TABLE detail_pesanan (
    id_detail INT(5) AUTO_INCREMENT PRIMARY KEY,
    id_pesanan INT(5),
    id_produk INT(5),
    jumlah INT(100),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_pesanan) REFERENCES pesanan(id_pesanan)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_produk) REFERENCES produk(id_produk)
        ON UPDATE CASCADE ON DELETE CASCADE
);


-- Tabel: pengeluaran
CREATE TABLE pengeluaran (
    id_pengeluaran INT(5) AUTO_INCREMENT PRIMARY KEY,
    tanggal_pengeluaran DATE,
    jenis_pengeluaran VARCHAR(100),
    jumlah INT(100),
    satuan VARCHAR(50),
    total_pengeluaran DECIMAL(10,5)
);


-- Tabel: detail_pengeluaran
CREATE TABLE detail_pengeluaran (
    id_detail_pengeluaran INT(5) AUTO_INCREMENT PRIMARY KEY,
    id_pengeluaran INT(5),
    id_bahan INT(5),
    FOREIGN KEY (id_pengeluaran) REFERENCES pengeluaran(id_pengeluaran)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_bahan) REFERENCES bahan_baku(id_bahan)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- DML
INSERT INTO pelanggan (nama_pelanggan, no_telepon, alamat, keterangan, deskripsi) VALUES
('Toko Berkah', 812345678, 'Jl. Pancasila No.16', 'Warung', 'Warung samping perempatan'),
('Ibu Aminah', 8191234567, 'Jl. Merdeka No.11', 'Rumahan', 'Rumah pagar hitam'),
('Bapak Joko', 8139876543, 'Jl. Sudirman No.45', 'Rumahan', 'Rumah dengan garasi luas'),
('Toko Sejahtera', 8201234567, 'Jl. Sultan Agung No.88', 'Warung', 'Toko dekat stasiun kereta');


-- select pelanggan
SELECT * FROM pelanggan;

-- insert produk 
INSERT INTO produk (nama_produk, harga_warung, harga_rumah, stok) VALUES
('Air Galon', 3000, 4000, 35);
-- select produk
SELECT * FROM produk;

-- insert bahan baku 
INSERT INTO bahan_baku (nama_bahan, stok, satuan) VALUES
('Tutup Galon', 500, 'pcs'),
('Tisu Galon', 475, 'pcs');
-- select bahan
SELECT * FROM bahan_baku;

-- insert pesanan   
INSERT INTO pesanan (id_pelanggan, tanggal, total_harga, bayar, status_bayar) VALUES
(33, '2025-10-10', 8000, 8000, 'Lunas'),
(34, '2025-12-23', 15000, 10000, 'Belum Lunas'),
(35, '2025-10-11', 3000, 0, 'Belum Lunas'),
(36, '2025-12-24', 20000, 20000, 'Lunas');

-- select pesanan
SELECT * FROM pesanan;

-- insert detail pesanan  
INSERT INTO detail_pesanan (id_pesanan, id_produk, jumlah, subtotal) VALUES
(1, 1, 2, 8000),
(2, 1, 5, 15000);
-- select detail pesanan
SELECT * FROM detail_pesanan;

-- insert pengeluaran  
INSERT INTO pengeluaran (tanggal_pengeluaran, jenis_pengeluaran, jumlah, satuan, total_pengeluaran) VALUES
('2025-09-02', 'Tisu', 5,'Pack', 50000),
('2025-07-12', 'Tutup', 2, 'Pack', 25000);
-- select pengeluaran
SELECT * FROM pengeluaran; 

-- insert detail pengeluaran 
INSERT INTO detail_pengeluaran (id_detail_pengeluaran, id_pengeluaran, id_bahan) VALUES
(1, 1),
(2, 2);
-- select detail pengeluaran
SELECT * FROM detail_pengeluaran;


-- control flow function
SELECT 
    id_pesanan,
    total_harga,
    bayar,
    CASE
        WHEN bayar >= total_harga THEN 'Lunas'
        WHEN bayar = 0 THEN 'Belum Bayar'
    END AS status_bayar
FROM pesanan;