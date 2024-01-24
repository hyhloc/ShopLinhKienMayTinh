<?php
    include("database/ketnoi.php");

    header('Content-Type: application/json');

    $response = array();

    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        if (isset($_GET['MaSP'])) {
            $masanpham = $_GET['MaSP'];

            $sql = "SELECT * FROM SanPham WHERE MaSanPham = '$masanpham'";
            $result = mysqli_query($kn, $sql);

            if ($result->num_rows > 0) {
                while ($row = $result->fetch_assoc()) {
                    $formattedPrice = number_format($row['GiaBan'], 0, ',', '.');

                    $product = array(
                        'MaSanPham' => $row['MaSanPham'],
                        'TenSanPham' => $row['TenSanPham'],
                        'Mota' => $row['Mota'],
                        'GiaBan' => $formattedPrice . ' VNĐ',
                        'SoLuong' => $row['SoLuong'],
                        'Anh' => $row['Anh']
                    );

                    $response['success'] = true;
                    $response['product'] = $product;
                }
            } else {
                $response['success'] = false;
                $response['message'] = 'Sản phẩm không tồn tại';
            }
        } else {
            $response['success'] = false;
            $response['message'] = 'Thiếu mã sản phẩm';
        }
    } else {
        $response['success'] = false;
        $response['message'] = 'Phương thức không hỗ trợ';
    }

    echo json_encode($response);
?>
