create database minitest3;
use minitest3;
create table vattu(
id int auto_increment primary key,
ma_vat_tu varchar(20),
ten_vat_tu varchar(20),
don_vi varchar(20),
gia_tien int);
insert into vattu values(1,"@001", "Ti-vi", "unit", 150),
(2,"@002", "Tu-lanh", "unit", 300),
(3,"@003", "May-giat", "unit", 200),
(4,"@004", "Lo-vi-song", "unit", 80),
(5,"@005", "Dieu-hoa", "unit", 100);
create table tonkho(
id int auto_increment primary key,
soluongdau int,
tongnhap int,
tongxuat int,
vattu_id int,
foreign key (vattu_id) references vattu(id));
insert into tonkho values (1,20,200,200,1),
(2,10,150,150,2),
(3,15,170,170,3),
(4,40,250,250,4),
(5,30,190,190,5);
create table nhacungcap(
id int auto_increment primary key,
ma_ncc varchar(20),
ten_ncc varchar(50),
dc_ncc varchar(255),
sdt varchar(10));
insert into nhacungcap values (1,"SS", "Samsung", "hanquoc", "0123456789"),
(2,"HTC", "Hitachi", "nhatban", "0123456788"),
(3,"SN", "Sony", "nhatban", "0123456787");
create table dondathang(
id int auto_increment primary key,
ma_don varchar(20),
ngay_dh date,
ncc_id int,
foreign key(ncc_id) references nhacungcap(id));
insert into dondathang values (1,"DON01","2024-1-1",1),
(2,"DON02","2024-1-1",2),
(3,"DON03","2024-1-1",3);
create table phieunhap(
id int auto_increment primary key,
ma_pn varchar(20),
ngay_nhap date,
donhang_id int,
foreign key(donhang_id) references dondathang(id));
insert into phieunhap values (1,"PN01", "2024-1-2",1),
(2,"PN02", "2024-1-2",2),
(3,"PN03", "2024-1-2",3);
create table phieuxuat(
id int auto_increment primary key,
ma_px varchar(20),
ngay_xuat date,
ten_khach_hang varchar(50));
insert into phieuxuat values (1,"PX01","2024-1-3", "Le Viet Hung"),
(2,"PX02","2024-1-3", "Phan Quyet Thang"),
(3,"PX03","2024-1-3", "Nguyen Tuan Anh");
create table ctdonhang(
id int auto_increment primary key,
dh_id int,
vt_id int,
soluong int,
foreign key(dh_id) references dondathang(id),
foreign key(vt_id) references vattu(id));
insert into ctdonhang values(1,1,1,50),
(2,3,3,70),
(3,2,2,80);
insert into ctdonhang values(4,3,5,5),
(5,3,4,20),
(6,2,1,15);
create table ctphieunhap(
id int auto_increment primary key,
pn_id int,
vt_id int,
soluong int,
don_gia int,
ghi_chu varchar(255),
foreign key (pn_id) references phieunhap(id),
foreign key (vt_id) references vattu(id));
insert into ctphieunhap values (1,1,5,20,80,"done"),
(2,1,4,15,100,"done"),
(3,2,2,30,220,"done"),
(4,3,2,40,110,"creatting"),
(5,2,2,20,50,"creatting"),
(6,2,5,10,50,"creatting");
select * from ctphieunhap;
create table ctphieuxuat(
id int auto_increment primary key,
px_id int,
vt_id int,
soluong int,
don_gia int,
ghi_chu varchar(255),
foreign key (px_id) references phieuxuat(id),
foreign key (vt_id) references vattu(id));
insert into ctphieuxuat values (1,1,5,20,120,"done"),
(2,1,4,15,100,"done"),
(3,2,2,30,350,"done"),
(4,3,2,40,350,"creatting"),
(5,2,2,20,350,"creatting"),
(6,2,5,10,120,"creatting");
select * from ctphieuxuat;

-- Câu 1. Tạo view có tên vw_CTPNHAP bao gồm các thông tin sau: 
-- số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

create view vw_CTPNHAP as
select phieunhap.ma_pn, vattu.ma_vat_tu, ctphieunhap.soluong, ctphieunhap.don_gia, (ctphieunhap.soluong*ctphieunhap.don_gia) as thanh_tien_nhap
from ctphieunhap
left join phieunhap on ctphieunhap.pn_id = phieunhap.id
join vattu on ctphieunhap.vt_id = vattu.id;
drop view vw_CTPNHAP;
select * from vw_CTPNHAP;
