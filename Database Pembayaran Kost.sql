create database pemesanan_kost_049;
use pemesanan_kost_049;

create table pemilik_kost(
id_admin int primary key,
nama_admin varchar(20),
no_admin varchar(20),
email_admin varchar(20)
);
create table kamar_kost(
nama_kamar varchar(4) primary key,
kategori enum('vip','reguler'),
harga_bln int,
status_kamar enum('aktif','non aktif'),
id_admin int,
foreign key(id_admin) references pemilik_kost(id_admin)
);
create table costumers(
id_costumer int primary key,
nama_costumer varchar(20),
umur int,
jenis_kelamin enum('pria','wanita'),
status_cus enum('telah menikah','belum menikah'),
domisili varchar(100),
no_hp varchar(20),
email varchar(20)
);
create table sewa(
id_sewa int auto_increment primary key,
nama_kamar varchar(4),
foreign key(nama_kamar) references kamar_kost(nama_kamar),
id_costumer int,
foreign key(id_costumer) references costumers(id_costumer),
tgl_sewa date,
tgl_berakhir date,
metode_pembayaran enum('tunai','non tunai')
);
-- RECORD
insert into pemilik_kost values
('1','Ichwal','082293947428','ichwal@gmail.com'),
('2','Rifki','082293947421','Rifiki@gmail.com'),
('3','Alif','082293947422','Alif@gmail.com'),
('4','Ikhlas','082293947423','Ikhlas@gmail.com'),
('5','Aris','082293947424','Aris@gmail.com'),
('6','Irgi','082293947425','Irgi@gmail.com'),
('7','Amri','082293947426','Amri@gmail.com'),
('8','sirat','082293947427','Sirat@gmail.com'),
('9','zel','082293947428','zel@gmail.com'),
('10','irpang','082293947429','irpang@gmail.com');
desc kamar_kost;
INSERT INTO kamar_kost VALUES
('A01','reguler','700000','aktif','1'),
('A02','reguler','700000','aktif','1'),
('A03','reguler','700000','aktif','2'),
('A04','reguler','700000','aktif','2'),
('A05','reguler','700000','aktif','1'),
('B01','vip','1000000','aktif','1'),
('B02','vip','1000000','aktif','2'),
('B03','vip','1000000','aktif','2'),
('B04','vip','1000000','aktif','1'),
('B05','vip','1000000','aktif','2'),
('A06','reguler','700000','non aktif','1'),
('A07','reguler','700000','non aktif','1'),
('A08','reguler','700000','non aktif','2'),
('A09','reguler','700000','non aktif','2'),
('A10','reguler','700000','non aktif','1'),
('B06','vip','1000000','non aktif','1'),
('B07','vip','1000000','non aktif','2'),
('B08','vip','1000000','non aktif','2'),
('B09','vip','1000000','non aktif','1'),
('B10','vip','1000000','non aktif','2');

desc costumers;
insert into costumers values
(1, 'Patur', 19, 'pria', 'belum menikah', 'malili', '081122004400', 'a@gmail.com'),
(2, 'Bartok', 25, 'wanita', 'telah menikah', 'pangkep', '081122004411', 'b@gmail.com'),
(3, 'Dimas', 19, 'pria', 'belum menikah', 'pinrang', '081122004422', 'c@gmail.com'),
(4, 'Juma', 20, 'pria', 'belum menikah', 'enrekang', '081122004433', 'd@gmail.com'),
(5, 'Amri', 20, 'pria', 'belum menikah', 'makassar', '081122004444', 'e@gmail.com'),
(6, 'Afif', 19, 'pria', 'belum menikah', 'makassar', '081122004455', 'f@gmail.com'),
(7, 'Ibnu', 20, 'pria', 'belum menikah', 'makassar', '081122004455', 'g@gmail.com'),
(8, 'Alpin', 20, 'pria', 'telah menikah', 'sidrap', '081122004466', 'h@gmail.com'),
(9, 'Putra', 21, 'pria', 'belum menikah', 'wajo', '081122004477', 'i@gmail.com'),
(10, 'Ikram', 20, 'pria', 'belum menikah', 'kolaka', '081122004488', 'j@gmail.com');

INSERT INTO sewa (nama_kamar, id_costumer, tgl_sewa, tgl_berakhir, metode_pembayaran) VALUES
('A01', 1, '2024-01-01', '2024-01-31', 'tunai'),
('A02', 2, '2024-01-05', '2024-02-04', 'non tunai'),
('A03', 3, '2024-01-10', '2024-02-09', 'tunai'),
('A04', 4, '2024-01-15', '2024-02-14', 'non tunai'),
('A05', 5, '2024-01-20', '2024-02-19', 'tunai'),
('B01', 6, '2024-01-25', '2024-02-24', 'non tunai'),
('B02', 7, '2024-01-30', '2024-02-29', 'tunai'),
('B03', 8, '2024-02-01', '2024-03-02', 'non tunai'),
('B04', 9, '2024-02-05', '2024-03-06', 'tunai'),
('B05', 10, '2024-02-10', '2024-03-11', 'non tunai');
drop table sewa;
desc sewa;
/*
DELIMITER $$
CREATE PROCEDURE insert_sewa(
    IN p_id_kost INT,
    IN p_id_costumer INT,
    IN p_tgl_sewa DATE,
    IN p_metode_pembayaran ENUM('tunai', 'non tunai')
)
BEGIN
    DECLARE v_tgl_berakhir DATE;
    -- Hitung tanggal berakhir dengan menambahkan 29 hari ke tanggal sewa
    SET v_tgl_berakhir = DATE_ADD(p_tgl_sewa, INTERVAL 29 DAY);
    -- Insert data ke tabel sewa
    INSERT INTO sewa (id_kost, id_costumer, tgl_sewa, tgl_berakhir, metode_pembayaran)
    VALUES (p_id_kost, p_id_costumer, p_tgl_sewa, v_tgl_berakhir, p_metode_pembayaran);
    -- Update status kamar menjadi 'aktif'
    UPDATE kamar_kost
    SET status_kamar = 'aktif'
    WHERE id_kost = p_id_kost AND status_kamar = 'non aktif';
END$$
DELIMITER ;
----------------------------
DELIMITER //
CREATE PROCEDURE AddCostumer(
    IN p_nama_costumer VARCHAR(20),
    IN p_umur INT,
    IN p_jenis_kelamin ENUM('pria', 'wanita'),
    IN p_status_cus ENUM('telah menikah', 'belum menikah'),
    IN p_domisili VARCHAR(100),
    IN p_no_hp VARCHAR(20),
    IN p_email VARCHAR(20)
)
BEGIN
    -- Tambahkan record baru ke tabel costumers
    INSERT INTO costumers (
        id_costumer,
        nama_costumer,
        umur,
        jenis_kelamin,
        status_cus,
        domisili,
        no_hp,
        email
    )
    VALUES (
        (SELECT IFNULL(MAX(id_costumer), 0) + 1 FROM costumers), -- Generate ID otomatis
        p_nama_costumer,
        p_umur,
        p_jenis_kelamin,
        p_status_cus,
        p_domisili,
        p_no_hp,
        p_email
    );
END //
DELIMITER ;
*/

create view infoKostKosong as
select nama_kamar, kategori,harga_bln, status_kamar 
from kamar_kost where status_kamar='non aktif';
select *from infoKostKosong;

select costumers.nama_costumer,costumers.no_hp,
sewa.tgl_sewa,sewa.tgl_berakhir,kamar_kost.nama_kamar
from sewa join kamar_kost on kamar_kost.nama_kamar=sewa.nama_kamar
join costumers on costumers.id_costumer=sewa.id_costumer
where nama_kamar='A02';

CALL AddCostumer(
-- 'Nama Costumer',
--  umur,
-- 'pria',
-- 'belum menikah',
-- 'Makassar',
-- 'nomor telepon',
-- 'email@example.com'
);

call insert_sewa(
-- id_kost,
-- id_costumer,
-- 'tgl_sewa',
-- pembayaran'tunai/non tunai'
);



