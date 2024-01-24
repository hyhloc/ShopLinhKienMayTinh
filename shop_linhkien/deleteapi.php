<?php
header('Content-Type: application/json');
include("database/ketnoi.php");

if ($_SERVER['REQUEST_METHOD'] === 'DELETE' && isset($_GET['action']) && $_GET['action'] === 'delete' && isset($_GET['msp'])) {
    // Giả sử bạn đang nhận dữ liệu qua yêu cầu GET
    $maSanPhamXoa = $_GET['msp'];

    // Kiểm tra xem có mã sản phẩm đó trong cơ sở dữ liệu không
    $kiemtra_sql = "SELECT * FROM SanPham WHERE MaSanPham = '$maSanPhamXoa'";
    $kiemtra_result = mysqli_query($kn, $kiemtra_sql);

    if (mysqli_num_rows($kiemtra_result) > 0) {
        // Mã sản phẩm tồn tại, thực hiện xóa
        $xoa_sql = "DELETE FROM SanPham WHERE MaSanPham = '$maSanPhamXoa'";
        $xoa_result = mysqli_query($kn, $xoa_sql);

        if (!$xoa_result) {
            // Có lỗi SQL khi xóa
            $response = array('status' => 'error', 'message' => 'Lỗi SQL khi xóa: ' . mysqli_error($kn));
            echo json_encode($response);
        } else {
            // Xóa thành công
            $response = array('status' => 'success', 'message' => 'Xóa sản phẩm thành công');
            echo json_encode($response);
        }
    } else {
        // Mã sản phẩm không tồn tại
        $response = array('status' => 'error', 'message' => 'Mã sản phẩm không tồn tại trong cơ sở dữ liệu');
        echo json_encode($response);
    }
} else {
    // Phương thức yêu cầu không hợp lệ, action không đúng, hoặc thiếu các tham số cần thiết
    $response = array('status' => 'error', 'message' => 'Yêu cầu không hợp lệ');
    echo json_encode($response);
}
?>
