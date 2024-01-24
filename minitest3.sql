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
(5,"@005", "Dieu-hoa", "bo", 100);
select * from vattu;
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
(2,1,4,5,100,"done"),
(3,2,2,10,350,"done"),
(4,3,2,15,350,"creatting"),
(5,2,2,20,350,"creatting"),
(6,2,5,8,120,"creatting");
select * from ctphieuxuat;

-- Câu 1. Tạo view có tên vw_CTPNHAP bao gồm các thông tin sau: 
-- số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

create view vw_CTPNHAP as
select phieunhap.ma_pn, vattu.ma_vat_tu, ctphieunhap.soluong, ctphieunhap.don_gia, (ctphieunhap.soluong*ctphieunhap.don_gia) as thanh_tien_nhap
from ctphieunhap
left join phieunhap on ctphieunhap.pn_id = phieunhap.id
join vattu on ctphieunhap.vt_id = vattu.id;
select * from vw_CTPNHAP;

-- Câu 2. Tạo view có tên vw_CTPNHAP_VT bao gồm các thông tin sau: 
-- số phiếu nhập hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

create view vw_CTPNHAP_VT as
select phieunhap.ma_pn, vattu.ma_vat_tu,vattu.ten_vat_tu, ctphieunhap.soluong, ctphieunhap.don_gia, (ctphieunhap.soluong*ctphieunhap.don_gia) as thanh_tien_nhap
from ctphieunhap
left join phieunhap on ctphieunhap.pn_id = phieunhap.id
join vattu on ctphieunhap.vt_id = vattu.id;
select * from vw_CTPNHAP_VT;

-- Câu 3. Tạo view có tên vw_CTPNHAP_VT_PN bao gồm các thông tin sau: 
-- số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

create view vw_CTPNHAP_VT_PN as
select phieunhap.ma_pn, phieunhap.ngay_nhap, dondathang.ma_don, vattu.ma_vat_tu, vattu.ten_vat_tu,ctphieunhap.soluong, ctphieunhap.don_gia,(ctphieunhap.soluong*ctphieunhap.don_gia) as thanh_tien_nhap
from ctphieunhap
join phieunhap on ctphieunhap.pn_id = phieunhap.id
join dondathang on phieunhap.donhang_id = dondathang.id
join vattu on ctphieunhap.vt_id = vattu.id;
select * from vw_CTPNHAP_VT_PN;

-- Câu 4. Tạo view có tên vw_CTPNHAP_VT_PN_DH bao gồm các thông tin sau: 
-- số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng, mã nhà cung cấp, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
create view vw_CTPNHAP_VT_PN_DH as
select phieunhap.ma_pn, phieunhap.ngay_nhap, dondathang.ma_don,nhacungcap.ma_ncc, vattu.ma_vat_tu, vattu.ten_vat_tu,ctphieunhap.soluong, ctphieunhap.don_gia,(ctphieunhap.soluong*ctphieunhap.don_gia) as thanh_tien_nhap
from ctphieunhap
join phieunhap on ctphieunhap.pn_id = phieunhap.id
join dondathang on phieunhap.donhang_id = dondathang.id
join vattu on ctphieunhap.vt_id = vattu.id
join nhacungcap on dondathang.ncc_id = nhacungcap.id;
select * from vw_CTPNHAP_VT_PN_DH;

-- Câu 5. Tạo view có tên vw_CTPNHAP_loc  bao gồm các thông tin sau: 
-- số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập. Và chỉ liệt kê các chi tiết nhập có số lượng nhập > 5.

create view  vw_CTPNHAP_loc as
select phieunhap.ma_pn, vattu.ma_vat_tu, ctphieunhap.soluong, ctphieunhap.don_gia
from ctphieunhap
join phieunhap on ctphieunhap.pn_id = phieunhap.id
join dondathang on phieunhap.donhang_id = dondathang.id
join vattu on ctphieunhap.vt_id = vattu.id;
select * from vw_CTPNHAP_loc;
select ma_vat_tu, soluong from vw_CTPNHAP_loc where soluong>5;

-- Câu 6. Tạo view có tên vw_CTPNHAP_VT_loc bao gồm các thông tin sau: 
-- số phiếu nhập hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập. Và chỉ liệt kê các chi tiết nhập vật tư có đơn vị tính là Bộ.

create view  vw_CTPNHAP_VT_loc as
select phieunhap.ma_pn, vattu.ma_vat_tu,vattu.ten_vat_tu, ctphieunhap.soluong,vattu.don_vi, ctphieunhap.don_gia,(ctphieunhap.soluong*ctphieunhap.don_gia) as thanh_tien_nhap
from ctphieunhap
join phieunhap on ctphieunhap.pn_id = phieunhap.id
join dondathang on phieunhap.donhang_id = dondathang.id
join vattu on ctphieunhap.vt_id = vattu.id;
select ten_vat_tu, don_vi from vw_CTPNHAP_VT_loc where don_vi = "bo" group by ten_vat_tu;

-- Câu 7. Tạo view có tên vw_CTPXUAT bao gồm các thông tin sau: 
-- số phiếu xuất hàng, mã vật tư, số lượng xuất, đơn giá xuất, thành tiền xuất.

create view vw_CTPXUAT as
select phieuxuat.ma_px, vattu.ma_vat_tu, ctphieuxuat.soluong,ctphieuxuat.don_gia as gia_xuat, (ctphieuxuat.soluong*ctphieuxuat.don_gia) as thanh_tien
from ctphieuxuat
join vattu on ctphieuxuat.vt_id = vattu.id
join phieuxuat on ctphieuxuat.px_id = phieuxuat.id;
select * from vw_CTPXUAT;

-- Câu 8. Tạo view có tên vw_CTPXUAT_VT bao gồm các thông tin sau: 
-- số phiếu xuất hàng, mã vật tư, tên vật tư, số lượng xuất, đơn giá xuất.
create view vw_CTPXUAT_VT as
select phieuxuat.ma_px, vattu.ma_vat_tu,vattu.ten_vat_tu, ctphieuxuat.soluong,ctphieuxuat.don_gia as gia_xuat
from ctphieuxuat
join vattu on ctphieuxuat.vt_id = vattu.id
join phieuxuat on ctphieuxuat.px_id = phieuxuat.id;
select * from vw_CTPXUAT_VT;

-- Câu 9. Tạo view có tên vw_CTPXUAT_VT_PX bao gồm các thông tin sau: 
-- số phiếu xuất hàng, tên khách hàng, mã vật tư, tên vật tư, số lượng xuất, đơn giá xuất.
create view vw_CTPXUAT_VT_PX as
select phieuxuat.ma_px,phieuxuat.ten_khach_hang, vattu.ma_vat_tu,vattu.ten_vat_tu, ctphieuxuat.soluong,ctphieuxuat.don_gia as gia_xuat
from ctphieuxuat
join vattu on ctphieuxuat.vt_id = vattu.id
join phieuxuat on ctphieuxuat.px_id = phieuxuat.id;
select * from vw_CTPXUAT_VT_PX;
-- ----------------------------------------------------------
-- Câu 1. Tạo Stored procedure (SP) cho biết tổng số lượng cuối của vật tư với mã vật tư là tham số vào.
DELIMITER //
CREATE PROCEDURE soluong(in ma_vt int, out tongsoluongcuoi int)
begin 
set tongsoluongcuoi = (select (sum(ctphieunhap.soluong)-sum(ctphieuxuat.soluong)) as soluong
from tonkho
join vattu on tonkho.vattu_id = vattu.id
join ctphieuxuat on ctphieuxuat.vt_id = vattu.id
join ctphieunhap on ctphieunhap.vt_id = vattu.id where vattu.id = ma_vt group by vattu.id);
END //
DELIMITER ;
call soluong(2, @tongsoluongcuoi);
select @tongsoluongcuoi;




