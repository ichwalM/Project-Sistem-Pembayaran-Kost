create database pemesanan_kost_049;
use pemesanan_kost_049;
drop database pemesanan_kost_049;
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
id_costumer int auto_increment primary key,
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



----------------------------
desc costumers;
CREATE PROCEDURE AddCostumer(
    IN p_nama_costumer VARCHAR(20),
    IN p_umur INT,
    IN p_jenis_kelamin ENUM('pria', 'wanita'),
    IN p_status_cus ENUM('telah menikah', 'belum menikah'),
    IN p_domisili VARCHAR(100),
    IN p_no_hp VARCHAR(20),
    IN p_email VARCHAR(20)
)
insert into costumers(nama_costumer, umur, jenis_kelamin, status_cus, domisili, no_hp, email)
values (p_nama_costumer, p_umur, p_jenis_kelamin, p_status_cus, p_domisili, p_no_hp, p_email);
CALL AddCostumer(
    'John Doe', 25, 'pria', 'belum menikah', 
    'Makassar', '081122334455', 'john.doe@gmail.com'
);
/*
DELIMITER $$
CREATE PROCEDURE addSewa(
    IN p_nama_kamar VARCHAR(4),
    IN p_id_costumer INT,
    IN p_tgl_sewa DATE,
    IN p_metode_pembayaran ENUM('tunai', 'non tunai')
)
BEGIN 
	DECLARE p_tgl_berakhir DATE;
	SET p_tgl_berakhir = DATE_ADD(p_tgl_sewa,INTERVAL 30 DAY);
	INSERT INTO sewa (nama_kamar, id_costumer, tgl_sewa, tgl_berakhir, metode_pembayaran)
    values(p_nama_kamar, p_id_costumer, p_tgl_sewa, p_tgl_berakhir, p_metode_pembayaran);
END$$
DELIMITER ;
*/
/*
DELIMITER $$
create trigger updateStatusKamar
after insert on sewa
for each row
BEGIN
	update kamar_kost set status_kamar='non aktif'
	where nama_kamar=NEW.nama_kamar;
END$$
DELIMITER ;
*/
show triggers;
DESC sewa;
CALL addSewa('B03', 11, '2024-11-25', 'tunai');
/*
DELIMITER //
create function hitumTotalBiaya(
f_nama_kamar varchar(4),
f_total_bln int)
returns int,
returns varhcar
begin 
	declare f_harga_bln int;
    declare f_total_biaya int;
    select harga_bln into f_harga_bln
    from kamar_kost
    where nama_kamar=f_nama_kamar;
    set f_total_biaya = f_harga_bln * f_total_bln;
    return f_total_biaya;
end //
DELIMITER ;
*/
select sum(harga_bln)as setoranBln from kamar_kost;
select nama_costumer from costumers order by nama_costumer desc;
SELECT 
    kategori, 
    SUM(harga_bln) AS total_penghasilan
FROM 
    kamar_kost
WHERE 
    nama_kamar IN (SELECT nama_kamar FROM sewa)
GROUP BY 
    kategori;

