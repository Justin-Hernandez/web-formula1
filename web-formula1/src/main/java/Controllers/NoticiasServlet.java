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

        String accion = req.getParameter("accion");
        HttpSession s = req.getSession(true);
        if (accion != null) {
            switch (accion) {
                case "listar":
                    s.setAttribute("news", modelo.getAllNews());
                    // Llamada a la página jsp 
                    
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Noticias.jsp"));
                    break;
                case "eliminar":
                    eliminarNoticia(req, res);
                    break;
                default:
                    
                    break;
            }
        }

    }

    private void eliminarNoticia(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String titulo = req.getParameter("titulo");
        modelo.deleteNews(titulo);
        res.sendRedirect("/web-formula1/NoticiasServlet?accion=listar");
    }
    
    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}
