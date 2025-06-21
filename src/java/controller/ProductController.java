package controller;
import java.io.IOException;
import java.io.File;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.ProductDAO;
import model.ProductDTO;
import model.UserDAO;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 5,       // 5MB
    maxRequestSize = 1024 * 1024 * 10    // 10MB
)
public class ProductController extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    private static final String UPLOAD_DIR = "uploads";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String url = "";
        try {
            String action = request.getParameter("action");
            //---- Xu ly cac action cua User -----
            if (action.equals("addProduct")) {
                url = handleProductAdding(request, response);
            } else if (action.equals("searchProduct")) {
                url = handleProductSearching(request, response);
            }
        } catch (Exception e) {
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
    
    private String handleProductSearching(HttpServletRequest request, HttpServletResponse response) {
        String keyword = request.getParameter("searchKeyword");
        ProductDAO pdao = new ProductDAO();
        List<ProductDTO> list = pdao.getProductByName(keyword);
        request.setAttribute("list", list);
        request.setAttribute("keyword", keyword);

        return "ProductView/productManagementForm.jsp";
    }
    
    private String handleProductAdding(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // TODO: Implement product adding logic
        throw new UnsupportedOperationException("Not supported yet.");
    }
}