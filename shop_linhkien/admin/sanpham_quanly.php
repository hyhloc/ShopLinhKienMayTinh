<?php
    session_start();
    include("header_ad.php");
?>


<body>
<div class="wrapper wrapper-content animated fadeInRight">
        <!-- ... Code hiện tại của bạn ... -->

        <?php
            if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['btnThemSP'])) {
                // Xử lý dữ liệu từ biểu mẫu và thêm vào CSDL
                // ... (Như trong ví dụ trước)

                // Gửi POST request đến API để thêm sản phẩm mới
                $apiUrl = "http://localhost/shop_bantrangsuc/postapi.php?action=add";
                $postData = array(
                    'MaNhaCungCap' => $maNCC,
                    'MaDanhMuc' => $maDM,
                    'TenSanPham' => $tenSP,
                    'SoLuong' => $soLuong,
                    'Mota' => $moTa,
                    'GiaBan' => $giaBan,
                    'NguyenLieu' => $nguyenLieu
                );

                $options = array(
                    'http' => array(
                        'header' => "Content-type: application/x-www-form-urlencoded\r\n",
                        'method' => 'POST',
                        'content' => http_build_query($postData)
                    )
                );

                $context = stream_context_create($options);
                $result = file_get_contents($apiUrl, false, $context);

                // Xử lý kết quả từ API (có thể hiển thị thông báo cho người dùng)
            }

            if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['action']) && $_GET['action'] === 'delete' && isset($_GET['msp'])) {
                $maSanPhamXoa = $_GET['msp'];

                // Gửi DELETE request đến API để xóa sản phẩm
                $apiUrl = "http://localhost/shop_bantrangsuc/deleteapi.php?action=delete&msp=$maSanPhamXoa";
                $result = file_get_contents($apiUrl);

                // Xử lý kết quả từ API (có thể hiển thị thông báo cho người dùng)
            }
        ?>
<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title fw-bolder">
                        <h2>QUẢN LÝ SẢN PHẨM</h2>
                    </div>
                    <div class="ibox-content">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover dataTables-example">
                                <thead>
                                    <tr>
                                        <th>MÃ NHÀ CUNG CẤP</th>
                                        <th>MÃ DANH MỤC</th>
                                        <th>MÃ SẢN PHẨM</th>
                                        <th>TÊN SẢN PHẨM</th>
                                        <th>ẢNH</th>
                                        <th>SỐ LƯỢNG</th>
                                        <th>MÔ TẢ</th>
                                        <th>GIÁ BÁN</th>
                                        <th>NGUYÊN LIỆU</th>
                                        <th colspan="2"></th>
                                    </tr>
                                </thead>

                                <?php
                                    include ("../database/ketnoi.php");
                                    $sql="SELECT * FROM SanPham";
                                    $kq=mysqli_query($kn,$sql);
                                    while($row=mysqli_fetch_array($kq))
                                    {
                                        echo ("<tbody>");
                                            echo ("<tr>"); $masp=$row["MaSanPham"];
                                                echo ("<td>".$row["MaNhaCungCap"]."</td>");
                                                echo ("<td>".$row["MaDanhMuc"]."</td>");
                                                echo ("<td>".$row["MaSanPham"]."</td>");
                                                echo ("<td>".$row["TenSanPham"]."</td>");
                                                echo ("<td>".$row["Anh"]."</td>");
                                                echo ("<td>".$row["SoLuong"]."</td>");
                                                echo ("<td>".$row["Mota"]."</td>");
                                                echo ("<td>".$row["GiaBan"]."</td>");
                                                echo ("<td><a class='btn btn-warning btn-block' href='suasanpham.php?msp=$masp'>Sửa sản phẩm</a></td>");
                                                echo ("<td><a class='btn btn-danger btn-block' href='../control/xoasanpham_xuly.php?msp=$masp'>Xóa sản phẩm</a></td>");
                                            echo ("</tr>");
                                    }
                                ?>
                                    <tr>
                                        <td colspan="9"></td>
                                        <td colspan="1">
                                            <button class="btn btn-primary btn-block" href='' data-toggle="modal" data-target="#modalThemSP">Thêm sản phẩm</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            
                            <div class="modal" id="modalThemSP">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <!-- Modal Header -->
                                        <div class="modal-header">
                                            <h2 class="modal-title text-success font-weight-bolder text-center">THÊM SẢN PHẨM</h2>
                                        </div>
                                                        
                                        <!-- Modal body -->
                                        <div class="modal-body">
                                            <form action="../control/themsanpham_xuly.php" method="post" enctype="multipart/form-data">
                                                <div class="form-group">
                                                    <label for="ddMaNCC">Tên nhà cung cấp: </label>                           
                                                    <select name="ddMaNCC" id="ddMaNCC" class="form-control" required>
                                                        <?php
                                                            include ("../database/ketnoi.php");
                                                            $sql2="SELECT * FROM NhaCungCap";
                                                            $kq2=mysqli_query($kn,$sql2);
                                                            while ($row2 = mysqli_fetch_assoc($kq2)) {
                                                            echo "<option value='" . $row2['MaNhaCungCap'] . "'>" . $row2['TenNhaCungCap'] . "</option>";
                                                            }
                                                        ?>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ddMaDM">Tên danh mục: </label>
                                                    <select name="ddMaDM" id="ddMaDM" class="form-control" required>
                                                        <?php
                                                            include ("../database/ketnoi.php");
                                                            $sql3="SELECT * FROM DanhMucSanPham";
                                                            $kq3=mysqli_query($kn,$sql3);
                                                            while ($row3 = mysqli_fetch_assoc($kq3)) {
                                                            echo "<option value='" . $row3['MaDanhMuc'] . "'>" . $row3['TenDanhMuc'] . "</option>";
                                                            }
                                                        ?>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="txtTenSP">Tên sản phẩm: </label>
                                                    <input type="text" class="form-control" name="txtTenSP" id="txtTenSP" autocomplete="off" placeholder="Nhập tên sản phẩm" required>
                                                </div>

                                                <div class="form-group">
                                                    <label for="file">Ảnh: </label>
                                                    <div class="form-group">
                                                        <!-- <label for="file">Chọn file:</label> -->
                                                        <input type="file" class="form-control" name="file" id="file">
                                                    </div>
                                                    <!-- <input type="txtAnh" class="form-control" name="txtAnh" id="txtAnh" autocomplete="off" required> -->
                                                </div>

                                                <div class="form-group">
                                                    <label for="txtSoLuong">Số lượng: </label>
                                                    <input type="text" class="form-control" name="txtSoLuong" id="txtSoLuong" autocomplete="off" placeholder="Nhập số lượng" required>
                                                </div>

                                                <div class="form-group">
                                                    <label for="txtMoTa">Mô tả: </label>
                                                    <textarea style="height: 150px;" class="form-control" name="txtMoTa" id="txtMoTa" autocomplete="off" placeholder="Nhập mô tả"></textarea>

                                                </div>

                                                <div class="form-group">
                                                    <label for="txtGiaBan">Giá bán: </label>
                                                    <input type="text" class="form-control" name="txtGiaBan" id="txtGiaBan" autocomplete="off" placeholder="Nhập giá bán" required>
                                                </div>
                                                
                                                                        
                                                <!-- Modal footer -->
                                                <div class="modal-footer">
                                                    <input type="submit" class="btn btn-success" name="btnThemSP" value="Thêm" required>
                                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Đóng</button>
                                                </div>
                                            </form>
                                        </div>		
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>


<?php
    include("footer_ad.php")
?>