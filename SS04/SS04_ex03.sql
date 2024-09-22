use ex03;
-- Hiển thị tất cả vật tự dựa vào phiếu xuất có số lượng lớn hơn 10
select * from MaVatTu 
join PhieuXuatChiTiet on PhieuXuatChiTiet.maVT = MaVatTu.maVT
where PhieuXuatChiTiet.soLuongXuat >=10;
-- Hiển thị tất cả vật tư mua vào ngày 12/2/2023
select * from MaVatTu 
join PhieuNhapChiTiet on PhieuNhapChiTiet.maVT = MaVatTu.maVT
join PhieuNhap on PhieuNhap.soPN = PhieuNhapChiTiet.soPN
where PhieuNhap.ngayNhap = '2023-02-12';
-- Hiển thị tất cả vật tư được nhập vào với đơn giá lớn hơn 1.200.000
select * from MaVatTu 
join PhieuNhapChiTiet on PhieuNhapChiTiet.maVT = MaVatTu.maVT
where PhieuNhapChiTiet.donGiaNhap >120;
-- Hiển thị tất cả vật tư được dựa vào phiếu xuất có số lượng lớn hơn 5
select * from MaVatTu 
join PhieuXuatChiTiet on PhieuXuatChiTiet.maVT = MaVatTu.maVT
where PhieuXuatChiTiet.soLuongXuat >=5;
-- Hiển thị tất cả nhà cung cấp ở long biên có SoDienThoai bắt đầu với 09
select * from NhaCungCap
where diaChi = 'HN'
and soDienThoai like '09%';