<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chào mừng - Bepbui</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f5e8c7 0%, #e8d5b7 100%);
                line-height: 1.6;
            }

            /* Header Part 1 */
            .header-part1 {
                background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 30px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                position: sticky;
                top: 0;
                z-index: 1000;
            }

            .logo {
                transition: transform 0.3s ease;
            }
            
            .logo:hover {
                transform: scale(1.05);
            }
            
            .logo img {
                height: 80px;
                width: auto;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                object-fit: contain;
                max-width: 100%;
            }

            .contact-info {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            
            .contact-info span {
                color: #8b0000;
                font-weight: 600;
                font-size: 14px;
                padding: 8px 12px;
                background: rgba(139, 0, 0, 0.1);
                border-radius: 20px;
                transition: all 0.3s ease;
            }
            
            .contact-info span:hover {
                background: rgba(139, 0, 0, 0.2);
                transform: translateY(-2px);
            }

            .search-cart-user {
                display: flex;
                align-items: center;
                gap: 15px;
            }
            
            .search-container {
                position: relative;
            }
            
            .search-container input {
                padding: 12px 40px 12px 15px;
                border: 2px solid #d2b48c;
                border-radius: 25px;
                width: 250px;
                font-size: 14px;
                transition: all 0.3s ease;
                background: white;
            }
            
            .search-container input:focus {
                outline: none;
                border-color: #8b0000;
                box-shadow: 0 0 10px rgba(139, 0, 0, 0.2);
                width: 300px;
            }
            
            .search-btn {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                background: #8b0000;
                border: none;
                border-radius: 50%;
                width: 30px;
                height: 30px;
                color: white;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            
            .search-btn:hover {
                background: #660000;
                transform: translateY(-50%) scale(1.1);
            }

            .icon-btn {
                position: relative;
                padding: 10px;
                border-radius: 50%;
                background: white;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                border: none;
                cursor: pointer;
            }
            
            .icon-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }
            
            .icon-btn img {
                height: 24px;
                width: 24px;
                object-fit: contain;
            }

            .cart-badge {
                position: absolute;
                top: -5px;
                right: -5px;
                background: #ff4757;
                color: white;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                font-size: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
            }

            /* Header Part 2 */
            .header-part2 {
                background: linear-gradient(135deg, #ffffff 0%, #f0f0f0 100%);
                padding: 20px;
                display: flex;
                justify-content: center;
                gap: 80px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }
            
            .category {
                text-align: center;
                transition: all 0.3s ease;
                padding: 15px;
                border-radius: 15px;
                cursor: pointer;
            }
            
            .category:hover {
                background: linear-gradient(135deg, #8b0000 0%, #a00000 100%);
                color: white;
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(139, 0, 0, 0.3);
            }
            
            .category img {
                height: 60px;
                width: 60px;
                margin-bottom: 10px;
                transition: all 0.3s ease;
                filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
                object-fit: contain;
                border-radius: 8px;
            }
            
            .category:hover img {
                filter: brightness(0) invert(1) drop-shadow(0 2px 4px rgba(255, 255, 255, 0.3));
                transform: scale(1.1);
            }
            
            .category p {
                font-weight: 600;
                font-size: 16px;
                margin: 0;
            }

            /* Banner */
            .banner {
                position: relative;
                margin: 20px 0;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            }

            .banner img {
                width: 100%;
                height: 400px;
                object-fit: cover;
                object-position: center;
                transition: transform 0.5s ease;
            }
            
            .banner:hover img {
                transform: scale(1.05);
            }
            
            .banner-overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(45deg, rgba(139, 0, 0, 0.7) 0%, rgba(0, 0, 0, 0.3) 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                transition: opacity 0.3s ease;
            }
            
            .banner:hover .banner-overlay {
                opacity: 1;
            }
            
            .banner-text {
                color: white;
                text-align: center;
                font-size: 28px;
                font-weight: bold;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            }

            /* Products */
            .products-section {
                padding: 40px 20px;
            }
            
            .section-title {
                text-align: center;
                font-size: 32px;
                font-weight: bold;
                color: #8b0000;
                margin-bottom: 40px;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
            }
            
            .products {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 30px;
                max-width: 1200px;
                margin: 0 auto;
            }
            
            .product-item {
                background: white;
                border-radius: 20px;
                padding: 20px;
                text-align: center;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                border: 2px solid transparent;
                position: relative;
                overflow: hidden;
            }
            
            .product-item::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
                transition: left 0.5s ease;
            }
            
            .product-item:hover::before {
                left: 100%;
            }
            
            .product-item:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 40px rgba(139, 0, 0, 0.2);
                border-color: #8b0000;
            }
            
            .product-item img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                object-position: center;
                border-radius: 15px;
                margin-bottom: 15px;
                transition: transform 0.3s ease;
                background-color: #f8f9fa;
            }
            
            .product-item:hover img {
                transform: scale(1.05);
            }
            
            .product-title {
                font-size: 18px;
                font-weight: bold;
                color: #333;
                margin-bottom: 8px;
            }
            
            .product-price {
                font-size: 20px;
                font-weight: bold;
                color: #8b0000;
                margin-bottom: 15px;
            }
            
            .add-to-cart {
                background: linear-gradient(135deg, #8b0000 0%, #a00000 100%);
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 25px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                width: 100%;
            }
            
            .add-to-cart:hover {
                background: linear-gradient(135deg, #660000 0%, #800000 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(139, 0, 0, 0.3);
            }

            /* Footer */
            .footer {
                background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
                color: white;
                padding: 40px 20px 20px;
                margin-top: 50px;
            }
            
            .footer-content {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 30px;
                max-width: 1200px;
                margin: 0 auto;
            }
            
            .footer-section h3 {
                margin-bottom: 20px;
                font-size: 18px;
                border-bottom: 2px solid #3498db;
                padding-bottom: 10px;
            }
            
            .footer-section ul {
                list-style: none;
            }
            
            .footer-section ul li {
                margin: 10px 0;
                transition: all 0.3s ease;
                padding: 5px 0;
            }
            
            .footer-section ul li:hover {
                color: #3498db;
                cursor: pointer;
                padding-left: 10px;
            }
            
            .footer-section ul li a {
                color: white;
                text-decoration: none;
                transition: color 0.3s ease;
            }
            
            .footer-section ul li a:hover {
                color: #3498db;
            }
            
            .footer-bottom {
                text-align: center;
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid #34495e;
                color: #bdc3c7;
            }

            /* Image loading fallback */
            img {
                max-width: 100%;
                height: auto;
            }

            /* Placeholder for missing images */
            .image-placeholder {
                background-color: #f0f0f0;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #666;
                font-size: 14px;
                border: 2px dashed #ccc;
                border-radius: 8px;
            }

            /* Login Modal Styles */
            .login-modal {
                display: none;
                position: fixed;
                z-index: 10000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.7);
                backdrop-filter: blur(5px);
            }

            .login-modal-content {
                background-color: white;
                margin: 10% auto;
                padding: 30px;
                border-radius: 15px;
                width: 90%;
                max-width: 400px;
                text-align: center;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
                animation: slideIn 0.3s ease;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-50px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .login-modal h3 {
                color: #8b0000;
                margin-bottom: 20px;
                font-size: 24px;
            }

            .login-modal p {
                color: #666;
                margin-bottom: 25px;
                font-size: 16px;
                line-height: 1.5;
            }

            .login-modal-buttons {
                display: flex;
                gap: 15px;
                justify-content: center;
            }

            .login-btn, .cancel-btn {
                padding: 12px 25px;
                border: none;
                border-radius: 25px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 14px;
            }

            .login-btn {
                background: linear-gradient(135deg, #8b0000 0%, #a00000 100%);
                color: white;
            }

            .login-btn:hover {
                background: linear-gradient(135deg, #660000 0%, #800000 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(139, 0, 0, 0.3);
            }

            .cancel-btn {
                background: #f0f0f0;
                color: #666;
            }

            .cancel-btn:hover {
                background: #e0e0e0;
                transform: translateY(-2px);
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .header-part1 {
                    flex-direction: column;
                    gap: 15px;
                    padding: 15px;
                }
                
                .contact-info {
                    flex-direction: column;
                    gap: 10px;
                }
                
                .header-part2 {
                    flex-direction: column;
                    gap: 20px;
                }
                
                .search-container input {
                    width: 200px;
                }
                
                .search-container input:focus {
                    width: 220px;
                }
                
                .products {
                    grid-template-columns: 1fr;
                }

                .banner img {
                    height: 250px;
                }

                .login-modal-buttons {
                    flex-direction: column;
                }
            }

            /* Animations */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .product-item {
                animation: fadeInUp 0.6s ease forwards;
            }
            
            .product-item:nth-child(2) { animation-delay: 0.1s; }
            .product-item:nth-child(3) { animation-delay: 0.2s; }
            .product-item:nth-child(4) { animation-delay: 0.3s; }

            /* Scroll to top button */
            .scroll-top {
                position: fixed;
                bottom: 30px;
                right: 30px;
                background: linear-gradient(135deg, #8b0000 0%, #a00000 100%);
                color: white;
                border: none;
                border-radius: 50%;
                width: 50px;
                height: 50px;
                font-size: 20px;
                cursor: pointer;
                box-shadow: 0 4px 15px rgba(139, 0, 0, 0.3);
                transition: all 0.3s ease;
                opacity: 0;
                visibility: hidden;
            }
            
            .scroll-top.visible {
                opacity: 1;
                visibility: visible;
            }
            
            .scroll-top:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 20px rgba(139, 0, 0, 0.4);
            }
        </style>
    </head>
    <body>
        <!-- Header Part 1 -->
        <div class="header-part1">
            <div class="logo">
                <a href="welcome.jsp">
                    <img src="images/bepbui-logo-removebg-preview.png" alt="Logo Bepbui" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex'"/>
                    <div class="image-placeholder" style="display:none; height:80px; width:120px;">Logo Bepbui</div>
                </a>
            </div>

            <div class="contact-info">
                <span class="phone">📞 0705.777.760</span>
                <span class="email">✉️ bama.bags@gmail.com</span>
            </div>

            <div class="search-cart-user">
                <div class="search-container">
                    <input type="text" placeholder="Tìm kiếm sản phẩm..." id="searchInput">
                    <button class="search-btn" onclick="searchProducts()">🔍</button>
                </div>
                <button class="icon-btn" onclick="toggleCart()">
                    <img src="images/trolley.png" alt="Giỏ hàng" onerror="this.innerHTML='🛒'">
                    <span class="cart-badge" id="cartCount">0</span>
                </button>
                <button class="icon-btn" onclick="toggleUser()">
                    <img src="images/user.png" alt="Người dùng" onerror="this.innerHTML='👤'">
                </button>
            </div>
        </div>

        <!-- Header Part 2 -->
        <div class="header-part2">
            <div class="category" onclick="filterProducts('backpack')">
                <img src="images/backpack-icon.png" alt="Balo" onerror="this.innerHTML='🎒'">
                <p>Balo</p>
            </div>
            <div class="category" onclick="filterProducts('tote')">
                <img src="images/tote-bag.png" alt="Túi Tote" onerror="this.innerHTML='👜'">
                <p>Túi Tote</p>
            </div>
            <div class="category" onclick="filterProducts('wallet')">
                <img src="images/wallet.png" alt="Ví" onerror="this.innerHTML='💳'">
                <p>Ví</p>
            </div>
        </div>

        <!-- Banner -->
        <div class="banner">
            <img src="images/banner.png" alt="Banner quảng cáo" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex'">
            <div class="image-placeholder" style="display:none; height:400px;">Banner Quảng Cáo</div>
            <div class="banner-overlay">
                <div class="banner-text">Khám phá bộ sưu tập mới của chúng tôi!</div>
            </div>
        </div>

        <!-- Products Section -->
        <div class="products-section">
            <h2 class="section-title">Sản Phẩm Phổ Biến</h2>
            <div class="products" id="productsContainer">
                <div class="product-item" data-category="backpack">
                    <img src="images/products/balo.jpg" alt="Balo A" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex'">
                    <div class="image-placeholder" style="display:none; height:200px;">Hình ảnh Balo</div>
                    <div class="product-title">Balo Cao Cấp A</div>
                    <div class="product-price">1.250.000 VNĐ</div>
                    <button class="add-to-cart" onclick="addToCart('Balo A', 1250000)">Thêm vào giỏ hàng</button>
                </div>
                <div class="product-item" data-category="tote">
                    <img src="images/products/tote.avif" alt="Túi Tote B" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex'">
                    <div class="image-placeholder" style="display:none; height:200px;">Hình ảnh Túi Tote</div>
                    <div class="product-title">Túi Tote Thanh Lịch B</div>
                    <div class="product-price">750.000 VNĐ</div>
                    <button class="add-to-cart" onclick="addToCart('Túi Tote B', 750000)">Thêm vào giỏ hàng</button>
                </div>
                <div class="product-item" data-category="wallet">
                    <img src="images/products/0.avif" alt="Ví C" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex'">
                    <div class="image-placeholder" style="display:none; height:200px;">Hình ảnh Ví</div>
                    <div class="product-title">Ví Da Sang Trọng C</div>
                    <div class="product-price">500.000 VNĐ</div>
                    <button class="add-to-cart" onclick="addToCart('Ví C', 500000)">Thêm vào giỏ hàng</button>
                </div>
            </div>
        </div>

        <!-- Login Modal -->
        <div id="loginModal" class="login-modal">
            <div class="login-modal-content">
                <h3>🔐 Yêu cầu đăng nhập</h3>
                <p>Bạn cần đăng nhập để sử dụng tính năng này. Vui lòng đăng nhập để tiếp tục mua sắm.</p>
                <div class="login-modal-buttons">
                    <button class="login-btn" onclick="redirectToLogin()">Đăng nhập ngay</button>
                    <button class="cancel-btn" onclick="closeLoginModal()">Hủy bỏ</button>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>GIỚI THIỆU VỀ CHÚNG TÔI</h3>
                    <p>Bepbui là điểm đến cho các sản phẩm túi xách chất lượng cao. Chúng tôi cung cấp bộ sưu tập độc đáo gồm balo, túi tote và ví da.</p>
                </div>
                <div class="footer-section">
                    <h3>CHÍNH SÁCH & HỖ TRỢ</h3>
                    <ul>
                        <li><a href="#">Chính sách đổi trả</a></li>
                        <li><a href="#">Chính sách vận chuyển</a></li>
                        <li><a href="#">Chính sách thanh toán</a></li>
                        <li><a href="#">Điều khoản dịch vụ</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3>THÔNG TIN LIÊN HỆ</h3>
                    <ul>
                        <li>📞 Điện thoại: 0705.777.760</li>
                        <li>📠 Fax: 0705.777.760</li>
                        <li>✉️ Email: bama.bags@gmail.com</li>
                        <li>📍 Địa chỉ: Thành phố Hồ Chí Minh</li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3>THEO DÕI CHÚNG TÔI</h3>
                    <ul>
                        <li><a href="#">📘 Facebook</a></li>
                        <li><a href="#">📷 Instagram</a></li>
                        <li><a href="#">🐦 Twitter</a></li>
                        <li><a href="#">💼 LinkedIn</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                Bản quyền © 2025 BAMA. Tất cả quyền được bảo lưu.
            </div>
        </div>

        <!-- Scroll to top button -->
        <button class="scroll-top" id="scrollTopBtn" onclick="scrollToTop()">↑</button>

        <script>
            let cart = [];
            let cartCount = 0;
            
            // Check if user is logged in 
            function isUserLoggedIn() {
                // Check session attribute from JSP
                <%
                    // Get user object from session
                    model.UserDTO userSession = (model.UserDTO) session.getAttribute("user");
                    String userIdSession = (String) session.getAttribute("userId");
                    String usernameSession = (String) session.getAttribute("username");
                %>
                
                // Check if user object exists in session
                <% if (userSession != null) { %>
                    return true;
                <% } else { %>
                    return false;
                <% } %>
            }

            // Show login modal
            function showLoginModal() {
                document.getElementById('loginModal').style.display = 'block';
                document.body.style.overflow = 'hidden'; // Prevent background scrolling
            }

            // Close login modal
            function closeLoginModal() {
                document.getElementById('loginModal').style.display = 'none';
                document.body.style.overflow = 'auto'; // Restore scrolling
            }

            // Redirect to login form
            function redirectToLogin() {
                window.location.href = '${pageContext.request.contextPath}/Authentication/loginForm.jsp';
            }

            // Check login before performing actions
            function checkLoginAndExecute(callback, ...args) {
                if (!isUserLoggedIn()) {
                    showLoginModal();
                    return false;
                } else {
                    callback(...args);
                    return true;
                }
            }

            // Modified add to cart function with login check
            function addToCart(productName, price) {
                checkLoginAndExecute(function(productName, price) {
                    cart.push({name: productName, price: price});
                    cartCount++;
                    document.getElementById('cartCount').textContent = cartCount;
                    
                    // Simple notification in Vietnamese
                    alert(`${productName} đã được thêm vào giỏ hàng!`);
                }, productName, price);
            }

            // Modified toggle cart with login check
            function toggleCart() {
                checkLoginAndExecute(function() {
                    if (cart.length === 0) {
                        alert('Giỏ hàng của bạn đang trống!');
                    } else {
                        let cartContent = 'Nội dung giỏ hàng:\n';
                        let total = 0;
                        cart.forEach(item => {
                            cartContent += `- ${item.name}: ${item.price.toLocaleString('vi-VN')} VNĐ\n`;
                            total += item.price;
                        });
                        cartContent += `\nTổng cộng: ${total.toLocaleString('vi-VN')} VNĐ`;
                        alert(cartContent);
                    }
                });
            }

            // Modified toggle user with login check
            function toggleUser() {
                checkLoginAndExecute(function() {
                    // Show user info if logged in
                    <% if (userSession != null) { %>
                        let userInfo = 'Thông tin người dùng:\n';
                        userInfo += 'Tên đăng nhập: <%= userSession.getUsername() %>\n';
                        userInfo += 'Email: <%= userSession.getEmail() %>\n';
                        userInfo += 'Địa chỉ: <%= userSession.getAddress() != null ? userSession.getAddress() : "Chưa cập nhật" %>\n';
                        userInfo += 'Vai trò: <%= "AD".equals(userSession.getRoleID()) ? "Quản trị viên" : "Khách hàng" %>';
                        
                        if (confirm(userInfo + '\n\nBạn có muốn đăng xuất không?')) {
                            window.location.href = '${pageContext.request.contextPath}/user-controller?action=logout';
                        }
                    <% } else { %>
                        alert('Tính năng người dùng sẽ sớm ra mắt!');
                    <% } %>
                });
            }

            // Search products (no login required)
            function searchProducts() {
                const searchTerm = document.getElementById('searchInput').value.toLowerCase();
                const products = document.querySelectorAll('.product-item');
                
                products.forEach(product => {
                    const productName = product.querySelector('.product-title').textContent.toLowerCase();
                    if (productName.includes(searchTerm) || searchTerm === '') {
                        product.style.display = 'block';
                    } else {
                        product.style.display = 'none';
                    }
                });
            }

            // Filter products by category (no login required)
            function filterProducts(category) {
                const products = document.querySelectorAll('.product-item');
                
                products.forEach(product => {
                    if (product.dataset.category === category) {
                        product.style.display = 'block';
                    } else {
                        product.style.display = 'none';
                    }
                });
            }

            // Scroll to top functionality
            window.addEventListener('scroll', () => {
                const scrollTopBtn = document.getElementById('scrollTopBtn');
                if (window.pageYOffset > 300) {
                    scrollTopBtn.classList.add('visible');
                } else {
                    scrollTopBtn.classList.remove('visible');
                }
            });

            function scrollToTop() {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            }

            // Search on Enter key
            document.getElementById('searchInput').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    searchProducts();
                }
            });

            // Reset filter to show all products
            function showAllProducts() {
                const products = document.querySelectorAll('.product-item');
                products.forEach(product => {
                    product.style.display = 'block';
                });
            }

            // Add click event to logo to show all products
            document.querySelector('.logo a').addEventListener('click', function(e) {
                e.preventDefault();
                showAllProducts();
                window.scrollTo({top: 0, behavior: 'smooth'});
            });

            // Close modal when clicking outside of it
            window.addEventListener('click', function(event) {
                const modal = document.getElementById('loginModal');
                if (event.target === modal) {
                    closeLoginModal();
                }
            });

            // Close modal with Escape key
            document.addEventListener('keydown', function(event) {
                if (event.key === 'Escape') {
                    closeLoginModal();
                }
            });

            // Initialize page
            document.addEventListener('DOMContentLoaded', function() {
                // Check if user is logged in on page load
                if (isUserLoggedIn()) {
                    console.log('User is logged in');
                    <% if (userSession != null) { %>
                        console.log('Welcome <%= userSession.getUsername() %>!');
                    <% } %>
                } else {
                    console.log('User is not logged in');
                }
            });
        </script>
    </body>
</html>