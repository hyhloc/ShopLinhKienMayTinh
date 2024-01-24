-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3307
-- Generation Time: Dec 26, 2023 at 06:49 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shop_trangsuc`
--

-- --------------------------------------------------------

--
-- Table structure for table `chitietdonhang`
--

CREATE TABLE `chitietdonhang` (
  `MaChiTietDonHang` int(11) NOT NULL,
  `MaDonHang` int(11) DEFAULT NULL,
  `MaSanPham` int(11) DEFAULT NULL,
  `TongSoLuong` int(11) DEFAULT NULL,
  `DonGia` float DEFAULT NULL,
  `ThanhTien` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `chitietdonhang`
--

INSERT INTO `chitietdonhang` (`MaChiTietDonHang`, `MaDonHang`, `MaSanPham`, `TongSoLuong`, `DonGia`, `ThanhTien`) VALUES
(20, 26, 67, 1, 19000000, 19000000);

-- --------------------------------------------------------

--
-- Table structure for table `chitietgiohang`
--

CREATE TABLE `chitietgiohang` (
  `MaGioHang` int(11) DEFAULT NULL,
  `MaSanPham` int(11) DEFAULT NULL,
  `TongSoLuong` int(11) DEFAULT NULL,
  `TongGiaTien` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `chitietgiohang`
--
DELIMITER $$
CREATE TRIGGER `before_insert_chitietgiohang` BEFORE INSERT ON `chitietgiohang` FOR EACH ROW BEGIN
    DECLARE current_stock INT;
    DECLARE requested_quantity INT;

    -- Lấy số lượng sản phẩm hiện có
    SELECT `SoLuong` INTO current_stock
    FROM `sanpham`
    WHERE `MaSanPham` = NEW.`MaSanPham`;

    -- Lấy số lượng sản phẩm được thêm vào giỏ hàng
    SET requested_quantity = NEW.`TongSoLuong`;

    -- Kiểm tra xem số lượng tồn kho có đủ để thêm vào giỏ hàng hay không
    IF requested_quantity > current_stock THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không đủ số lượng tồn kho để thêm vào giỏ hàng.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `danhmucsanpham`
--

CREATE TABLE `danhmucsanpham` (
  `MaDanhMuc` varchar(20) NOT NULL,
  `TenDanhMuc` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `danhmucsanpham`
--

INSERT INTO `danhmucsanpham` (`MaDanhMuc`, `TenDanhMuc`) VALUES
('BT', 'Bông tai'),
('DCV', 'Dây chuyền'),
('LV', 'Lắc Tay'),
('MD', 'Mặt dây chuyền'),
('NV', 'Nhẫn'),
('VV', 'Vòng');

-- --------------------------------------------------------

--
-- Table structure for table `donhang`
--

CREATE TABLE `donhang` (
  `MaDonHang` int(11) NOT NULL,
  `NgayLap` date DEFAULT current_timestamp(),
  `Email` varchar(150) DEFAULT NULL,
  `TongTien` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `donhang`
--

INSERT INTO `donhang` (`MaDonHang`, `NgayLap`, `Email`, `TongTien`) VALUES
(26, '2023-12-26', 'ainhan@gmail.com', 19000000);

-- --------------------------------------------------------

--
-- Table structure for table `giohang`
--

CREATE TABLE `giohang` (
  `MaGioHang` int(11) NOT NULL,
  `Email` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nguoidungweb`
--

CREATE TABLE `nguoidungweb` (
  `Email` varchar(150) NOT NULL,
  `TaiKhoan` varchar(50) DEFAULT NULL,
  `MatKhau` varchar(32) DEFAULT NULL,
  `TenDayDu` varchar(32) DEFAULT NULL,
  `DiaChi` varchar(255) DEFAULT NULL,
  `DienThoai` varchar(20) DEFAULT NULL,
  `VaiTro` int(11) DEFAULT NULL,
  `NgayTao` date DEFAULT current_timestamp(),
  `TrangThai` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `nguoidungweb`
--

INSERT INTO `nguoidungweb` (`Email`, `TaiKhoan`, `MatKhau`, `TenDayDu`, `DiaChi`, `DienThoai`, `VaiTro`, `NgayTao`, `TrangThai`) VALUES
('ainhan@gmail.com', 'nhan', '202cb962ac59075b964b07152d234b70', 'ái nhân', 'trà vinh', '0978189707', 1, '2023-12-26', 'Hoạt động'),
('hloc2@gmail.com', 'adminloc', '202cb962ac59075b964b07152d234b70', 'Huỳnh Tấn Lộc', 'Trà Vinh', '0932331652', 0, '2023-12-26', 'Hoạt động');

-- --------------------------------------------------------

--
-- Table structure for table `nhacungcap`
--

CREATE TABLE `nhacungcap` (
  `MaNhaCungCap` varchar(20) NOT NULL,
  `TenNhaCungCap` varchar(100) DEFAULT NULL,
  `DiaChi` varchar(255) DEFAULT NULL,
  `DienThoai` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `nhacungcap`
--

INSERT INTO `nhacungcap` (`MaNhaCungCap`, `TenNhaCungCap`, `DiaChi`, `DienThoai`) VALUES
('DOJI', 'DOJI Jewelry', 'Việt Nam', '098712234'),
('PNJ', 'Phú Nhuận Jewelry', 'Việt Nam', '0123456789'),
('SJC', 'Sài Gòn Jewelry Company', 'Việt Nam', '0987654321');

-- --------------------------------------------------------

--
-- Table structure for table `sanpham`
--

CREATE TABLE `sanpham` (
  `MaSanPham` int(11) NOT NULL,
  `TenSanPham` varchar(100) DEFAULT NULL,
  `Anh` varchar(250) DEFAULT NULL,
  `SoLuong` int(11) DEFAULT NULL,
  `Mota` text DEFAULT NULL,
  `MaDanhMuc` varchar(20) DEFAULT NULL,
  `MaNhaCungCap` varchar(20) DEFAULT NULL,
  `GiaBan` int(11) DEFAULT NULL,
  `NguyenLieu` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sanpham`
--

INSERT INTO `sanpham` (`MaSanPham`, `TenSanPham`, `Anh`, `SoLuong`, `Mota`, `MaDanhMuc`, `MaNhaCungCap`, `GiaBan`, `NguyenLieu`) VALUES
(59, 'Nhẫn Vàng Trơn 24K', 'images/nhan-4.png', 2, 'Nhẫn vàng 24K trơn nhẹ nhàng, là biểu tượng của sự quý phái và thuần khiết, phản ánh vẻ đẹp tinh tế của chất liệu vàng cao cấp.', 'NV', 'PNJ', 4000000, 'vàng 24k'),
(60, 'Nhẫn Vàng 18K Kiểu Đơn Giản', 'images/nhan-1.png', 4, 'Một chiếc nhẫn vàng 18K với thiết kế đơn giản, tinh tế, là biểu tượng của sự thanh lịch và sang trọng', 'NV', 'DOJI', 2400000, 'vàng 18k'),
(61, 'Nhẫn Vàng 14K Đính Kim Cương', 'images/nhan-2.png', 7, 'Chiếc nhẫn vàng 14K với viên kim cương lấp lánh, là sự kết hợp hoàn hảo giữa vẻ đẹp truyền thống và sự quý phái.', 'NV', 'DOJI', 30000000, 'vàng 14k'),
(62, 'Nhẫn Vàng 18K đính đá Ruby ', 'images/nhan-3.png', 3, 'Chiếc nhẫn vàng 18K đính đá Ruby là một tác phẩm nghệ thuật tinh tế, tỏa sáng với sự quý phái và sang trọng', 'NV', 'DOJI', 12000000, 'vàng 18k'),
(63, 'Nhẫn Bạc 925 Đơn Giản', 'images/nhan-6.png', 3, 'Một chiếc nhẫn bạc 925 với thiết kế tinh tế và đơn giản, phù hợp cho những người ưa chuộng phong cách giản dị.', 'NV', 'DOJI', 620000, 'bạc 925'),
(64, 'Nhẫn Bạc PNJSilver 0000W060001', 'images/nhan-5.png', 7, 'Chiếc nhẫn Bạc PNJSilver mã 0000W060001 là một sản phẩm của thương hiệu uy tín, nổi tiếng với chất lượng và sự tinh tế trong thiết kế.', 'NV', 'DOJI', 540000, 'bạc 925'),
(65, 'Nhẫn Vàng trắng 10K đính đá ECZ PNJ XMXMW002392', 'images/nhan-7.png', 3, 'Chiếc nhẫn vàng trắng 10K đính đá ECZ của PNJ với mã sản phẩm XMXMW002392 là một sự kết hợp tinh tế giữa chất liệu quý phái và viên đá CZ lấp lánh', 'NV', 'DOJI', 9000000, 'vàng trắng 10k'),
(66, 'Dây chuyền vàng 14k', 'images/day-2.png', 42, 'Dây chuyền vàng 14K với hoa văn truyền thống, đơn giản nhưng đẹp mắt, là sự kết hợp hoàn hảo giữa truyền thống và hiện đại.', 'DCV', 'DOJI', 6000000, 'vàng 14k'),
(67, 'Dây chuyền vàng 24k', 'images/day-1.png', 31, 'Dây chuyền vàng 24K với hình ảnh của một con giáp, mang lại sự phong cách độc đáo và may mắn theo quan điểm phong thủy.', 'DCV', 'DOJI', 19000000, 'vàng 24k'),
(68, 'Dây Chuyền Vàng 18K', 'images/day-4.png', 11, 'Dây chuyền vàng 18K thiết kế mắt mèo, tinh tế và cá tính, là biểu tượng của sự may mắn và bảo vệ.', 'DCV', 'DOJI', 29000000, 'vàng 18k'),
(69, 'Dây Chuyền Bạc 925', 'images/day-3.png', 29, 'Dây chuyền bạc 925 với thiết kế đơn giản nhưng ý nghĩa, là lựa chọn phổ biến cho những người ưa chuộng sự tinh tế.', 'DCV', 'DOJI', 575000, 'bạc 925'),
(70, 'Dây chuyền nam 18k', 'images/day-6.png', 12, 'Dây chuyền vàng 18K thiết kế đơn giản, tinh tế và cá tính, là biểu tượng của sự may mắn và bảo vệ.', 'DCV', 'DOJI', 28000000, 'Vàng 18k'),
(72, 'Dây chuyền bạc 925 nam', 'images/day-7.png', 225, 'Dây chuyền bạc 925 , tạo nên sự quyến rũ và mạnh mẽ, là biểu tượng của sức mạnh.', 'DCV', 'DOJI', 900000, 'bạc 925'),
(73, 'Bông tai Vàng 14K đính đá CZ', 'images/tai-1.png', 9, 'Chiếc bông tai vàng 14K đính đá CZ là một biểu tượng của sự thanh lịch và quý phái. ', 'BT', 'DOJI', 6000000, 'vàng 14k'),
(74, 'Bông tai Bạc đính đá STYLE', 'images/tai-2.png', 18, 'Chiếc bông tai bạc đính đá STYLE là một biểu tượng của sự cá tính và phong cách hiện đại.', 'BT', 'DOJI', 695000, 'bạc 925'),
(75, 'Mặt dây chuyền Vàng trắng 14k', 'images/mat-day4.png', 6, 'Dây chuyền 10k là sự kết hợp hoàn hảo giữa vẻ đẹp và đẳng cấp. Với chất liệu vàng 10 karat, chiếc dây chuyền này là một biểu tượng của sự tinh tế và quý phái. Thiết kế 3 mặt của nó tạo ra một vẻ độc đáo và thu hút, làm nổi bật vẻ đẹp của người đeo. Đây không chỉ là một món trang sức, mà còn là một biểu tượng của phong cách và đẳng cấp.', 'MD', 'DOJI', 5000000, 'Vàng trắng 14k'),
(76, 'Mặt dây chuyền Vàng 14k đính ngọc trai', 'images/mat-day2.png', 10, 'Mặt dây chuyền vàng trắng 14k đính ngọc trai là một biểu tượng của sự quý phái và thanh lịch. Chiếc dây chuyền này không chỉ đơn thuần là một món trang sức, mà còn là một tác phẩm nghệ thuật kết hợp giữa vẻ đẹp tự nhiên của ngọc trai và sự sang trọng của vàng trắng 14 karat.', 'MD', 'SJC', 4000000, 'Vàng trắng 14k'),
(77, 'Mặt dây chuyền Vàng trắng 14k nữ ', 'images/mat-day5.png', 12, 'Những chiếc dây chuyền này không chỉ là một phần của trang sức, mà còn là biểu tượng của sự cá nhân và phong cách của bạn, chúng đều là điểm nhấn hoàn hảo để thể hiện vẻ đẹp riêng của bạn và tạo điểm nhấn cho bất kỳ trang phục nào.', 'MD', 'PNJ', 3000000, 'Vàng trắng 14k'),
(78, 'Mặt dây chuyền Vàng 10k đính đá', 'images/mat-day.png', 14, 'Mặt dây chuyền 10k là sự kết hợp hoàn hảo giữa vẻ đẹp và đẳng cấp. Với chất liệu vàng 10 karat,  là một biểu tượng của sự tinh tế và quý phái. Thiết kế 3 mặt của nó tạo ra một vẻ độc đáo và thu hút, làm nổi bật vẻ đẹp của người đeo. Đây không chỉ là một món trang sức, mà còn là một biểu tượng của phong cách và đẳng cấp.', 'MD', 'PNJ', 3000000, 'Vàng 10k'),
(79, 'Mặt dây chuyền 10k đính đá', 'images/mat-day1.png', 12, 'Mặt dây chuyền 10k đính đá là biểu tượng của sự quý phái và lấp lánh. Với chất liệu vàng 10 karat, nó mang đến vẻ sang trọng và đẳng cấp. Các viên đá được đính kỹ thuật tinh tế trên mặt dây chuyền tạo nên một ánh sáng rực rỡ, tôn lên vẻ đẹp riêng của bạn. Mặt dây chuyền này không chỉ là một món trang sức, mà còn là điểm nhấn hoàn hảo cho mọi bộ trang phục.', 'MD', 'SJC', 2500000, 'Vàng 10k'),
(80, 'Mặt dây chuyền 18k', 'images/mat-day3.png', 7, 'Mặt dây chuyền vàng 18k đính đá không chỉ là một phụ kiện thời trang, mà còn là biểu tượng của sự tinh tế và thanh lịch. Việc đính đá kỹ lưỡng trên mặt dây chuyền tạo nên một vẻ lấp lánh rực rỡ, làm nổi bật vẻ đẹp của bạn. Sự đẳng cấp và sáng tạo của nó làm cho mặt dây chuyền này trở thành sự lựa chọn hoàn hảo cho những người muốn tỏa sáng trong bất kỳ bữa tiệc hay sự kiện nào.', 'MD', 'PNJ', 2400000, 'Vàng 18k'),
(81, 'Lắc tay Vàng trắng Ý 18K', 'images/lac-tay1.png', 3, 'Khám phá thế giới của sự sang trọng với lắc tay vàng trắng Ý 18K. Chế tác từ chất liệu vàng 18 karat, sản phẩm này không chỉ là một món trang sức mà còn là biểu tượng của phong cách Ý tinh tế. Với thiết kế tinh xảo và chất lượng xuất sắc, lắc tay này là sự kết hợp hoàn hảo giữa vẻ đẹp và đẳng cấp, là điểm nhấn lý tưởng cho mọi dịp.', 'LV', 'PNJ', 15500000, 'Vàng trắng 18k'),
(82, 'Lắc tay Bạc đính đá STYLE', 'images/lac-tay2.png', 7, 'STYLE mang đến cho bạn lắc tay bạc đính đá độc đáo và phong cách. Với chiếc lắc tay này, bạn không chỉ thể hiện phong cách cá nhân mà còn nổi bật với sự lấp lánh của đá quý. Thiết kế tinh tế và chất liệu bạc chất lượng cao, lắc tay STYLE là sự kết hợp hoàn hảo giữa thời trang và nghệ thuật.\r\n\r\n', 'LV', 'DOJI', 950000, 'Bạc 925'),
(83, 'Lắc Tay Vàng 18K', 'images/lac-tay3.png', 8, 'Với lắc tay vàng 18K, bạn đưa vào bộ sưu tập của mình một biểu tượng của sự đẳng cấp và quyến rũ. Chất liệu vàng 18 karat tạo nên một vẻ ngoại hình sang trọng và lôi cuốn. Chiếc lắc tay này không chỉ là một món trang sức, mà còn là sự thể hiện của đẳng cấp và phong cách cá nhân.\r\n\r\n', 'LV', 'PNJ', 16000000, 'Vàng 18k'),
(84, 'Lắc Tay Vàng Trắng 10K Đính Đá ECZ', 'images/lac-tay4.png', 8, 'Lắc tay vàng trắng 10K đính đá ECZ là sự kết hợp tinh tế giữa vẻ lấp lánh của đá ECZ và sự sang trọng của vàng trắng 10 karat. Chiếc lắc tay này không chỉ là một phụ kiện thời trang mà còn là biểu tượng của sự quý phái và đẳng cấp.\r\n\r\n', 'LV', 'PNJ', 2400000, 'Vàng trắng 10k'),
(85, 'Lắc Tay Nam Bạc PNJSilver', 'images/lac-tay6.png', 9, 'PNJSilver mang đến cho quý ông lắc tay nam bạc với phong cách nam tính và cá tính. Chất liệu bạc cao cấp kết hợp với thiết kế độc đáo, chiếc lắc tay này là sự lựa chọn hoàn hảo cho những quý ông muốn thể hiện phong cách riêng biệt.', 'LV', 'PNJ', 960000, 'Bạc 950'),
(86, ' Lắc Tay Nam Kim Cương Vàng 14K', 'images/lac-tay5.png', 3, 'Lắc tay nam kim cương vàng 14K là biểu tượng của sự sang trọng và quý phái. Với kim cương lấp lánh, chiếc lắc tay này là điểm nhấn hoàn hảo để làm nổi bật phong cách lịch lãm và đẳng cấp của bạn.', 'LV', 'PNJ', 254000000, 'Vàng 14k'),
(87, 'Lắc Tay Nam Vàng 14K Đính Đá', 'images/lac-tay8.png', 12, 'Sự kết hợp hoàn hảo giữa vàng 14K và đá CZ tạo nên chiếc lắc tay nam vô cùng quyến rũ. Được chế tác cẩn thận, nó là biểu tượng của sự thanh lịch và cá tính nam tính.', 'LV', 'PNJ', 53000000, 'Vàng 14k'),
(88, ' Lắc Tay Nam Vàng 14K Đính Đá', 'images/lac-tay9.png', 7, 'Lắc tay nam vàng 14K đính đá là sự thể hiện của phong cách cao cấp và đẳng cấp. Thiết kế tinh tế và chất liệu vàng 14 karat tạo nên một mảnh nghệ thuật trang sức, làm nổi bật vẻ nam tính và sự sang trọng.', 'LV', 'PNJ', 58000000, 'Vàng 14k'),
(89, 'Bông Tai Vàng 14K Đính Đá', 'images/bong-tay1.png', 6, 'Bông tai vàng 14K đính đá là biểu tượng của sự lấp lánh và quyến rũ. Chất liệu vàng 14 karat tạo nên một nền tảng sang trọng, trong khi các viên đá đính kỹ thuật tinh tế thêm vào đó sự quý phái. Được chế tác với tâm huyết, bông tai này là điểm nhấn hoàn hảo để tôn lên vẻ đẹp tự tin và quyến rũ của phái đẹp.', 'BT', 'SJC', 4000000, 'Vàng 14k'),
(90, 'Bông Tai Vàng 18K PNJ Kim Bảo Như Ý', 'images/bong-tay2.png', 8, 'Bông tai vàng 18K PNJ kim bảo như ý không chỉ là một món trang sức mà còn là biểu tượng của sự tinh tế và may mắn. Với chất liệu vàng 18 karat và kim bảo tinh xảo, chiếc bông tai này không chỉ mang lại vẻ đẹp tinh khôi mà còn chứa đựng ý nghĩa về sự may mắn và thịnh vượng.', 'BT', 'SJC', 8000000, 'Vàng 18k'),
(91, 'Bông Tai Vàng Trắng 14K Đính Đá Topaz ', 'images/bong-tay3.png', 5, 'Bông tai vàng trắng 14K đính đá Topaz là sự kết hợp hoàn hảo giữa vẻ thanh lịch và nữ tính. Chất liệu vàng trắng tinh tế kết hợp với Topaz lấp lánh tạo nên một kiệt tác trang sức. Chiếc bông tai này không chỉ là điểm nhấn tuyệt vời cho bất kỳ trang phục nào mà còn là biểu tượng của sự thanh lịch và tinh tế.', 'BT', 'SJC', 17000000, 'Vàng trắng 14k'),
(92, ' Bông Tai Vàng 14K Đính Ngọc Trai Akoya', 'images/bong-tay4.png', 5, 'Bông tai vàng 14K đính ngọc trai Akoya là sự hòa quyện giữa sự quý phái và truyền thống. Ngọc trai Akoya tỏa sáng giữa lớp vàng 14 karat, tạo nên một vẻ đẹp tinh tế và truyền thống. Chiếc bông tai này là lựa chọn tuyệt vời cho những dịp quan trọng và là biểu tượng của sự quý phái và thuần khiết.', 'BT', 'SJC', 19000000, 'Vàng 14k'),
(93, 'Bông Tai Vàng 10K Đính Đá ECZ', 'images/bong-tay5.png', 6, 'Bông tai vàng 10K đính đá ECZ là sự kết hợp hoàn hảo giữa sự sang trọng và hiện đại. Với chất liệu vàng 10 karat và đá ECZ lấp lánh, chiếc bông tai này không chỉ thể hiện sự cá tính mà còn là biểu tượng của sự hiện đại và phong cách thời trang.', 'BT', 'SJC', 7000000, 'Vàng 10k'),
(94, ' Vòng Tay Vàng 10K Đính Đá ECZ DOJI Kim Bảo Như Ý', 'images/lac-tay3.png', 7, 'Với chất liệu vàng 10 karat và đá ECZ lấp lánh, vòng tay DOJI Kim Bảo Như Ý không chỉ là biểu tượng của sự quý phái mà còn thể hiện phong cách độc đáo. Được chế tác cẩn thận, chiếc vòng tay này là sự lựa chọn hoàn hảo để làm nổi bật đẳng cấp và cá tính của bạn.', 'VV', 'DOJI', 10000000, 'Vàng 10k'),
(95, 'Vòng Tay Vàng Trắng 10K Đính Đá ECZ SJC Kim Bảo Như Ý', 'images/vong2.png', 8, 'Vòng tay Vàng Trắng 10K đính đá ECZ SJC Kim Bảo Như Ý là sự kết hợp hoàn hảo giữa sự sang trọng và tinh tế. Chất liệu vàng trắng 10 karat tạo nên một nền tảng thanh lịch, trong khi đá ECZ lấp lánh thêm vẻ quý phái. Chiếc vòng tay này là điểm nhấn tuyệt vời cho bất kỳ bộ trang phục nào và là biểu tượng của sự thanh lịch và hiện đại.', 'VV', 'SJC', 12000000, 'Vàng trắng 10k'),
(96, 'Vòng Tay Bạc Đính Đá SJC Silver', 'images/vong3.png', 7, 'Vòng tay Bạc đính đá SJC Silver là sự hòa quyện giữa sự bền bỉ của bạc và vẻ nữ tính của đá quý. Thiết kế tinh tế và chất liệu bạc chất lượng cao tạo nên một chiếc vòng tay đẹp mắt và sang trọng. Là biểu tượng của sự kiên nhẫn và nữ tính, nó là điểm nhấn hoàn hảo cho phong cách thời trang của bạn.', 'VV', 'PNJ', 950000, 'Bạc 950'),
(97, 'Vòng tay Bạc đính đá PNJ Silver ', 'images/vong4.png', 9, 'Vòng tay Bạc đính đá PNJSilver mang đến sự tinh tế và cổ điển. Chất liệu bạc và đá quý được kết hợp một cách hài hòa, tạo nên một chiếc vòng tay trang sức đẹp mắt và truyền thống. Là biểu tượng của sự tinh tế và thanh lịch, nó là sự kết hợp hoàn hảo giữa thời trang và nghệ thuật.', 'VV', 'PNJ', 2000000, 'Bạc 950'),
(98, 'Vòng Tay Vàng Trắng 10K Đính Đá ECZ PNJ', 'images/vong5.png', 7, 'Vòng tay Bạc đính đá PNJSilver là sự kết hợp hoàn hảo giữa sự quý phái và đẳng cấp. Chất liệu bạc chất lượng cao và viên đá quý được chế tác cẩn thận tạo nên một chiếc vòng tay tinh tế và sang trọng. Được thiết kế để nổi bật, nó là biểu tượng của sự đẳng cấp và phong cách cá nhân.', 'VV', 'PNJ', 7000000, 'Vàng trắng 10k'),
(99, 'Vòng Tay Bạc Đính Đá PNJSilver', 'images/vong6.png', 7, 'Vòng tay Bạc đính đá PNJSilver là sự quyến rũ và thu hút. Được chế tác với đá quý lấp lánh, chiếc vòng tay này chứa đựng vẻ quyến rũ và sức hút đặc biệt. Thiết kế tinh tế của nó làm cho nó trở thành một phụ kiện trang sức không thể thiếu cho những dịp quan trọng.', 'VV', 'PNJ', 1500000, 'Bạc 950');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD PRIMARY KEY (`MaChiTietDonHang`),
  ADD KEY `MaSanPham` (`MaSanPham`),
  ADD KEY `chitietdonhang_ibfk_1` (`MaDonHang`);

--
-- Indexes for table `chitietgiohang`
--
ALTER TABLE `chitietgiohang`
  ADD KEY `MaGioHang` (`MaGioHang`),
  ADD KEY `chitietgiohang_ibfk_2` (`MaSanPham`);

--
-- Indexes for table `danhmucsanpham`
--
ALTER TABLE `danhmucsanpham`
  ADD PRIMARY KEY (`MaDanhMuc`);

--
-- Indexes for table `donhang`
--
ALTER TABLE `donhang`
  ADD PRIMARY KEY (`MaDonHang`),
  ADD KEY `Email` (`Email`);

--
-- Indexes for table `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`MaGioHang`),
  ADD KEY `Email` (`Email`);

--
-- Indexes for table `nguoidungweb`
--
ALTER TABLE `nguoidungweb`
  ADD PRIMARY KEY (`Email`);

--
-- Indexes for table `nhacungcap`
--
ALTER TABLE `nhacungcap`
  ADD PRIMARY KEY (`MaNhaCungCap`);

--
-- Indexes for table `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`MaSanPham`),
  ADD KEY `MaDanhMuc` (`MaDanhMuc`),
  ADD KEY `MaNhaCungCap` (`MaNhaCungCap`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  MODIFY `MaChiTietDonHang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `donhang`
--
ALTER TABLE `donhang`
  MODIFY `MaDonHang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `MaSanPham` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD CONSTRAINT `chitietdonhang_ibfk_1` FOREIGN KEY (`MaDonHang`) REFERENCES `donhang` (`MaDonHang`) ON DELETE CASCADE,
  ADD CONSTRAINT `chitietdonhang_ibfk_2` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`);

--
-- Constraints for table `chitietgiohang`
--
ALTER TABLE `chitietgiohang`
  ADD CONSTRAINT `chitietgiohang_ibfk_1` FOREIGN KEY (`MaGioHang`) REFERENCES `giohang` (`MaGioHang`),
  ADD CONSTRAINT `chitietgiohang_ibfk_2` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`) ON DELETE NO ACTION;

--
-- Constraints for table `donhang`
--
ALTER TABLE `donhang`
  ADD CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`Email`) REFERENCES `nguoidungweb` (`Email`);

--
-- Constraints for table `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `giohang_ibfk_1` FOREIGN KEY (`Email`) REFERENCES `nguoidungweb` (`Email`);

--
-- Constraints for table `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`MaDanhMuc`) REFERENCES `danhmucsanpham` (`MaDanhMuc`),
  ADD CONSTRAINT `sanpham_ibfk_2` FOREIGN KEY (`MaNhaCungCap`) REFERENCES `nhacungcap` (`MaNhaCungCap`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
