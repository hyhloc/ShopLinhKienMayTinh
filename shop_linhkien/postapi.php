<?php
header('Content-Type: application/json');
include("database/ketnoi.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_GET['action']) && $_GET['action'] === 'add') {
    $postData = json_decode(file_get_contents("php://input"), true);

    $maNCC = $postData['MaNhaCungCap'];
    $maDM = $postData['MaDanhMuc'];
    $tenSP = $postData['TenSanPham'];
    $soLuong = $postData['SoLuong'];
    $moTa = $postData['Mota'];
    $giaBan = $postData['GiaBan'];
    $anh = $postData['Anh'];

    $sql = "INSERT INTO SanPham (MaNhaCungCap, MaDanhMuc, TenSanPham, SoLuong, Mota, GiaBan, Anh) 
            VALUES ('$maNCC', '$maDM', '$tenSP', '$soLuong', '$moTa', '$giaBan',  '$anh')";

    $result = mysqli_query($kn, $sql);

    if (!$result) {
        $errorMessage = mysqli_error($kn);
        error_log("SQL Error: $errorMessage");
        $response = array('status' => 'error', 'message' => 'Lỗi SQL: ' . $errorMessage);
        echo json_encode($response);
    } else {
        $response = array('status' => 'success', 'message' => 'Thêm sản phẩm thành công');
        echo json_encode($response);
    }
} else {
    $response = array('status' => 'error', 'message' => 'Yêu cầu không hợp lệ');
    echo json_encode($response);
}
?>
