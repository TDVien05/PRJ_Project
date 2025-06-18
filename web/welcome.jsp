<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome - Bepbui</title>
        <style>
            * {
                overflow-x: hidden;

            }
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f5e8c7;
            }
            /* Header Part 1 */
            .header-part1 {
                background-color: #ffffff;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }


            .logo img{
                height: 100px;
            }
            .contact-info {
                display: flex;
                align-items: center;
            }
            .contact-info span {
                margin: 0 15px;
                color: #8b0000;
                font-weight: bold;
            }
            .contact-info .phone:before {
                content: url('/images/phone-icon-red.png');
                margin-right: 5px;
            }
            .contact-info .email:before {
                content: url('/images/envelope-icon-red.png');
                margin-right: 5px;
            }
            .search-cart-user {
                display: flex;
                align-items: center;
            }
            .search-cart-user input {
                padding: 5px;
                margin-right: 10px;
                border: 1px solid #d2b48c;
                border-radius: 5px;
            }
            .search-cart-user img {
                height: 20px;
                margin-left: 10px;
            }
            /* Header Part 2 */
            .header-part2 {
                background-color: #ffffff;
                padding: 10px 20px;
                display: flex;
                justify-content: space-around;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .header-part2 .category {
                text-align: center;
            }
            .header-part2 .category img {
                height: 50px;
                margin-bottom: 5px;
            }
            /* Body */
            .banner {
                width: 100%;
                height: auto;
            }

            .banner img {
                width: 100%;
                heigh: 100%;
            }
            .products {
                display: flex;
                justify-content: space-around;
                padding: 20px;
                flex-wrap: wrap;
            }
            .product-item {
                background-color: #ffffff;
                width: 200px;
                padding: 10px;
                margin: 10px;
                text-align: center;
                border: 1px solid #d2b48c;
                border-radius: 5px;
            }
            .product-item img {
                width: 100%;
                height: auto;
            }
            /* Footer */
            .footer {
                background-color: #ffffff;
                padding: 20px;
                text-align: center;
                margin-top: 20px;
                border-top: 1px dashed #ccc;
            }
            .footer-section {
                display: inline-block;
                margin: 0 20px;
                vertical-align: top;
            }
            .footer-section ul {
                list-style: none;
                padding: 0;
            }
            .footer-section ul li {
                margin: 5px 0;
                color: #4682b4;
            }
            .footer-section ul li a {
                color: #4682b4;
                text-decoration: none;
            }
            .footer-bottom {
                margin-top: 20px;
                color: #4682b4;
            }


        </style>
    </head>
    <body>
        <!-- Header Part 1 -->
        <div class="header-part1">
            <div class="logo">
                <a href="welcome.jsp">
                    <img src="images/bepbui-logo-removebg-preview.png" alt=""/>
                </a>

            </div>

            <div class="search-cart-user">
                <input type="text" placeholder="Nhập sản phẩm...">
                <a href="cart.jsp">
                    <img src="images/trolley.png" alt="Cart">
                </a>
                <a href="userDetails.jsp">
                    <img src="images/user.png" alt="User">
                </a>
            </div>
        </div>

        <!-- Header Part 2 -->
        <div class="header-part2">
            <div class="category">
                <a href="">
                    <div>
                        <img src="images/backpack-icon.png" alt="Backpacks">
                        <p>Backpacks</p>
                    </div>
                </a>
            </div>
            <div class="category">
                <a href="">
                    <div>
                        <img src="images/tote-bag.png" alt="Totes">
                        <p>Totes</p>
                    </div>
                </a>
            </div>
            <div class="category">
                <a href="">
                    <div>
                        <img src="images/wallet.png" alt="Wallets">
                        <p>Wallets</p>
                    </div>
                </a>
            </div>
        </div>

        <!-- Body -->
        <div class="banner">
            <img src="images/banner.png" alt="Banner">
        </div>
        <div class="products">
            <div class="product-item">
                <a href="">
                    <div>
                        <img src="images/products/214a4844_1_43588626f54c47c7bbcd361ae41ad024_master.jpg" alt="Product 1">
                        <p>Backpack A</p>
                        <p>$50</p>
                    </div>
                </a>
            </div>
            <div class="product-item">
                <img src="images/product2.jpg" alt="Product 2">
                <p>Tote B</p>
                <p>$30</p>
            </div>
            <div class="product-item">
                <img src="images/product3.jpg" alt="Product 3">
                <p>Wallet C</p>
                <p>$20</p>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <div class="footer-section">
                <h3>ABOUT US</h3>
            </div>
            <div class="footer-section">
                <h3>PHÁP LÝ & CÂU HỎI</h3>
                <ul>
                    <li>− Chính sách đổi trả</li>
                    <li>− Chính sách vận chuyển</li>
                    <li>− Chính sách thanh toán</li>
                    <li>− Điều khoản dịch vụ</li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>THÔNG TIN LIÊN HỆ</h3>
                <ul>
                    <li>− Điện thoại 0705.777.760</li>
                    <li>− Fax 0705.777.760</li>
                    <li>− Hộp thư bama.bags@gmail.com</li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>FANPAGE</h3>
            </div>
            <div class="footer-bottom">
                Copyright © 2025 BAMA.
            </div>
        </div>
    </body>
</html>