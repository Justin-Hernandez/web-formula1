package Controllers;

import Models.Equipo;
import Models.ModeloDatos;
import Models.Piloto;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import org.apache.commons.io.FilenameUtils;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@MultipartConfig
@WebServlet(name = "EquiposServlet", urlPatterns = {"/EquiposServlet"})
public class EquiposServlet extends HttpServlet {

    private String pathFiles = "";
    private File uploads = new File(pathFiles);
    private ModeloDatos modelo;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        modelo = new ModeloDatos();
        modelo.abrirConexion();
    }

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String accion = req.getParameter("accion");
        HttpSession s = req.getSession(true);
        if (accion != null) {
            switch (accion) {
                case "listar":
                    List<Equipo> equipos = modelo.getAllEquipos();
                    s.setAttribute("equipos", equipos);
                    
                    HashMap <Integer, List<Piloto>> map = new HashMap <Integer, List<Piloto>> ();
                    for(Equipo e : equipos){
                        List<Piloto> pilotosEquipo = modelo.findPilotosByIdEquipo(e.getId());
                        map.put(e.getId(), pilotosEquipo);
                    }
                    s.setAttribute("pilotos", map);
                    // Llamada a la página jsp 
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Equipos.jsp"));
                    break;
                default:
                    break;
            }
        }
        s.setAttribute("equipos", modelo.getAllEquipos());
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}
