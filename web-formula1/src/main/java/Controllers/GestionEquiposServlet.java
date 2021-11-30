package Controllers;

import Models.ModeloDatos;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@MultipartConfig
@WebServlet(name = "GestionEquiposServlet", urlPatterns = {"/GestionEquiposServlet"})
public class GestionEquiposServlet extends HttpServlet {

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
                    s.setAttribute("equipos", modelo.getAllEquipos());
                    // Llamada a la página jsp 
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionEquipos.jsp"));
                    break;
                default:
                    break;
            }
        }
    }


    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}
