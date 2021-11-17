package Controllers;

import Models.Equipo;
import Models.ModeloDatos;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.apache.commons.io.FilenameUtils;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@MultipartConfig
@WebServlet(name = "EquiposServlet", urlPatterns = {"/EquiposServlet"})
public class EquiposServelt extends HttpServlet {

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

        
        String accion = req.getParameter("accion");
        HttpSession s = req.getSession(true);
        if (accion != null) {
            switch (accion) {
                case "listar":
                    s.setAttribute("equipos", modelo.getAllEquipos());
                    // Llamada a la página jsp 
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionEquipos.jsp"));
                    break;
                case "insertar":
                    addEquipo(req, res);
                    s.setAttribute("equipos", modelo.getAllEquipos());
                    res.sendRedirect("/web-formula1/Views/GestionEquipos.jsp");
                    break;
                case "eliminar":
                    //TODO PENDIENTE IMPLEMENTACION
                    break;
                default:
                    break;
            }
        }
        s.setAttribute("equipos", modelo.getAllEquipos());
    }

    private void addEquipo(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        String pathFiles = req.getServletContext().getRealPath("/store/img");

        File uploads = new File(pathFiles);
        
        
        String nombre = req.getParameter("nombre");
        String twitter = req.getParameter("twitter");
        Part part = req.getPart("logo");

        /*/////NO BORRAAAAAAR
        String camino = getServletContext().getRealPath("/" + "file" + File.separator + part.getSubmittedFileName());
        System.out.println(camino);
        */

        String foto = guardarFoto(part, uploads);
        Equipo equipo = new Equipo(nombre,foto,twitter);
        modelo.addEquipo(equipo);
        
    }

    private String guardarFoto(Part part, File pathUploads) throws IOException {
        String absolutePath = "";

        Path path = Paths.get(part.getSubmittedFileName());
        String fileName = path.getFileName().toString();
        InputStream inputStream = part.getInputStream();
        if (inputStream != null) {
            File file = new File(pathUploads, fileName);
            if (!file.exists()) {
                Files.copy(inputStream, file.toPath());
                absolutePath = file.getAbsolutePath();
            } else {
                String nombreSolamente = FilenameUtils.removeExtension(fileName);
                String extension = FilenameUtils.getExtension(fileName);
                String fileNameModificado = nombreSolamente + "-" + Math.random() + "." + extension;
                File tmp = new File(pathUploads, fileNameModificado);
                Files.copy(inputStream, tmp.toPath());
                absolutePath = tmp.getAbsolutePath();
            }
        }
        return absolutePath;
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}
