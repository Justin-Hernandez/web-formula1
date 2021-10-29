package Controllers;

import Models.ModeloDatos;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class NoticiasServlet extends HttpServlet {

    private ModeloDatos modelo;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        modelo = new ModeloDatos();
        modelo.abrirConexion();
    }

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        
        HttpSession s = req.getSession(true);       
        
        s.setAttribute("news", modelo.getAllNews());
        
        // Llamada a la página jsp 
        res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Noticias.jsp"));
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}