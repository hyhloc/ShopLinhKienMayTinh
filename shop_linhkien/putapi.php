<?php
// putapi.php

// Kiểm tra xem có dữ liệu gửi từ Postman không
$putdata = fopen("php://input", "r");
$data = "";
while ($chunk = fread($putdata, 1024))
    $data .= $chunk;
fclose($putdata);

// Chuyển đổi dữ liệu JSON sang mảng PHP
$put_data = json_decode($data, true);

// Kiểm tra xem có mã sản phẩm được gửi từ Postman không
if (isset($put_data['txtMaSP'])) {
    $msp = $put_data['txtMaSP'];
    // Các bước thực hiện cập nhật trong CSDL
    include("database/ketnoi.php");

    if ($kn) { // Kiểm tra xem kết nối đã được thiết lập hay chưa

        // Lấy thông tin sản phẩm từ CSDL
        $sql_select = "SELECT * FROM SanPham WHERE MaSanPham='" . $msp . "'";
        $result_select = mysqli_query($kn, $sql_select);
        $row = mysqli_fetch_array($result_select);

        if ($row) {
            // Thực hiện cập nhật thông tin sản phẩm
            $newMaNCC = isset($put_data['ddMaNCC']) ? $put_data['ddMaNCC'] : $row['MaNhaCungCap'];
            $newMaDM = isset($put_data['ddMaDM']) ? $put_data['ddMaDM'] : $row['MaDanhMuc'];
            $newTenSP = isset($put_data['txtTenSP']) ? $put_data['txtTenSP'] : $row['TenSanPham'];
            $newSoLuong = isset($put_data['txtSoLuong']) ? $put_data['txtSoLuong'] : $row['SoLuong'];
            $newMoTa = isset($put_data['txtMoTa']) ? $put_data['txtMoTa'] : $row['Mota'];
            $newGiaBan = isset($put_data['txtGiaBan']) ? $put_data['txtGiaBan'] : $row['GiaBan'];
            $newAnh = isset($put_data['txtAnh']) ? $put_data['txtAnh'] : $row['Anh'];

            $sql_update = "UPDATE SanPham SET MaNhaCungCap='$newMaNCC', MaDanhMuc='$newMaDM', TenSanPham='$newTenSP', SoLuong='$newSoLuong', Mota='$newMoTa', GiaBan='$newGiaBan', Anh='$newAnh' WHERE MaSanPham='$msp'";
            $result_update = mysqli_query($kn, $sql_update);

            if ($result_update) {
                echo json_encode(array(
                    'status' => 'success',
                    'message' => 'Cập nhật thông tin sản phẩm thành công.',
                    'product_id' => $msp
                ), JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
            } else {
                echo json_encode(array(
                    'status' => 'error',
                    'message' => 'Không thể cập nhật thông tin sản phẩm.'
                ), JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
            }
        } else {
            echo json_encode(array('status' => 'error', 'message' => 'Không tìm thấy sản phẩm'));
        }
    } else {
        echo json_encode(array('status' => 'error', 'message' => 'Lỗi kết nối đến cơ sở dữ liệu'));
    }
} else {
    echo json_encode(array('status' => 'error', 'message' => 'Mã sản phẩm không được cung cấp'));
}
?>
