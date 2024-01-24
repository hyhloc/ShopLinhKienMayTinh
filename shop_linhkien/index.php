<?php
    include("header.php");
    include("database/ketnoi.php");
?>
<!-- <style>
    .card-link{
        /* display: block; */
        width: 100%;
        text-decoration: none;
        color: inherit;
        border: none;
    }
</style> -->
        <!-- Section-->
        <section class="py-5" style="background-color:#d3d8da">
            <div class="container px-4 px-lg-5 mt-5" style="background-color:#d3d8da">
                <div class="jumbotron text-center " style="background-color:#d3d8da">
                <h2 style="font-family: 'Kaushan Script', cursive;">CÁC SẢN PHẨM Ở CỬA HÀNG</h2>
                </div>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <?php
                        $sql = "SELECT * FROM SanPham";
                        $bang = $kn -> query($sql);

                        if ($bang->num_rows > 0) {
                            while ($tam = $bang->fetch_assoc()) {
                                // Format giá sản phẩm với dấu chấm sau ba số
                                $formattedPrice = number_format($tam['GiaBan'], 0, ',', '.');
                        
                                echo ('<div class="col mb-5">
                                            <div class="card h-100 myClass" data-product-id="'.$tam['TenSanPham'].'" style="border-radius: 15px;">
                                                <img class="card-img-top" src="'.$tam['Anh'].'" alt="..." />
                                                <div class="card-body p-1">	
                                                </div>
                                                <div class="card-footer p-1 pt-0 border-top-0 bg-transparent">
                                                    <div class="text-center">
                                                        <h5 class="fw-bolder">'.$tam['TenSanPham'].'</h5>
                                                    </div>
                                                    <div class="text-center">
                                                        Hiện còn: 
                                                        '.$tam['SoLuong'].'
                                                    </div>
                                                    <div class="text-center fw-bolder">
                                                        '.$formattedPrice.'VNĐ
                                                    </div>
                                                    <hr>
                                                    <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="xemchitietsp.php?TenSP='.$tam["TenSanPham"].'">Xem chi tiết</a></div>
                                                </div>
                                            </div>
                                        </div>');
                            }
                        }
                        
                    ?>
                    <script>
                        $(document).ready(function () {
                            $(".myClass").on("click", function() {
                                var TenSP = $(this).data("product-id");
                                window.location.href = "xemchitietsp.php?TenSP=" + TenSP;
                            });
                        });
                    </script>               
                </div>
            </div>
        </section>


<?php
    include("footer.php");
?>