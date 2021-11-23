package Controllers;

import Models.ModeloDatos;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig
public class VotacionesServlet extends HttpServlet {
    
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
                    s.setAttribute("votaciones", modelo.getAllVotaciones());
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Votaciones.jsp"));
                    break;
                case "insertar":
                    //agregarVotacion(req, res);
                    s.setAttribute("votaciones", modelo.getAllVotaciones());
                    res.sendRedirect("/web-formula1/Views/GestionVotaciones.jsp");
                    break;
                case "eliminar":
                    //eliminarVotacion(req, res);
                    s.setAttribute("votaciones", modelo.getAllVotaciones());
                    res.sendRedirect("/web-formula1/Views/GestionVotaciones.jsp");
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