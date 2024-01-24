CREATE TABLE `NguoiDungWeb` (
  `Email` VARCHAR(150) PRIMARY KEY,
  `TaiKhoan` VARCHAR(50),
  `MatKhau` VARCHAR(32),
  `TenDayDu` VARCHAR(32),
  `DiaChi` VARCHAR(255),
  `DienThoai` VARCHAR(20),
  `VaiTro` INT,
  `NgayTao` DATE DEFAULT CURRENT_TIMESTAMP,
  `TrangThai` VARCHAR(20)
);

CREATE TABLE `DonHang` (
  `MaDonHang` INT PRIMARY KEY AUTO_INCREMENT,
  `NgayLap` DATE DEFAULT CURRENT_TIMESTAMP,
  `Email` VARCHAR(150),
  `TongTien` Float
);

CREATE TABLE `ChiTietDonHang` (
  `MaChiTietDonHang` INT PRIMARY KEY AUTO_INCREMENT,
  `MaDonHang` INT,
  `MaSanPham` INT,
  `TongSoLuong` INT,
  `DonGia` Float,
  `ThanhTien` Float
);

CREATE TABLE `SanPham` (
  `MaSanPham` INT PRIMARY KEY AUTO_INCREMENT,
  `TenSanPham` VARCHAR(100),
  `Anh` VARCHAR(250),
  `SoLuong` INT,
  `MoTa` TEXT,
  `MaDanhMuc` VARCHAR(20),
  `MaNhaCungCap` VARCHAR(20),
  `GiaBan` INT
);

CREATE TABLE `NhaCungCap` (
  `MaNhaCungCap` VARCHAR(20) PRIMARY KEY,
  `TenNhaCungCap` VARCHAR(100),
  `DiaChi` VARCHAR(255),
  `DienThoai` VARCHAR(20)
);

CREATE TABLE `DanhMucSanPham` (
  `MaDanhMuc` VARCHAR(20) PRIMARY KEY,
  `TenDanhMuc` VARCHAR(50)
);

CREATE TABLE `GioHang` (
  `MaGioHang` INT PRIMARY KEY,
  `Email` VARCHAR(150)
);

CREATE TABLE `ChiTietGioHang` (
  `MaGioHang` INT,
  `MaSanPham` INT,
  `TongSoLuong` INT,
  `TongGiaTien` Float
);

ALTER TABLE `DonHang` ADD FOREIGN KEY (`Email`) REFERENCES `NguoiDungWeb` (`Email`);

ALTER TABLE `ChiTietDonHang` ADD FOREIGN KEY (`MaDonHang`) REFERENCES `DonHang` (`MaDonHang`);

ALTER TABLE `ChiTietDonHang` ADD FOREIGN KEY (`MaSanPham`) REFERENCES `SanPham` (`MaSanPham`);

ALTER TABLE `SanPham` ADD FOREIGN KEY (`MaDanhMuc`) REFERENCES `DanhMucSanPham` (`MaDanhMuc`);

ALTER TABLE `SanPham` ADD FOREIGN KEY (`MaNhaCungCap`) REFERENCES `NhaCungCap` (`MaNhaCungCap`);

ALTER TABLE `GioHang` ADD FOREIGN KEY (`Email`) REFERENCES `NguoiDungWeb` (`Email`);

ALTER TABLE `ChiTietGioHang` ADD FOREIGN KEY (`MaGioHang`) REFERENCES `GioHang` (`MaGioHang`);

ALTER TABLE `ChiTietGioHang` ADD FOREIGN KEY (`MaSanPham`) REFERENCES `SanPham` (`MaSanPham`);
