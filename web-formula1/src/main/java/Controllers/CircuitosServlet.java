package Controllers;

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

/**
 *
 * @author Nasr
 */

@MultipartConfig
@WebServlet(name = "CircuitosServlet", urlPatterns = {"/CircuitosServlet"})
public class CircuitosServlet extends HttpServlet {

  private String pathFiles = "/Users/macbook/Documents/GitHub/web-formula1/web-formula1/src/main/webapp/img";
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
                    s.setAttribute("circuitos", modelo.getAllCircuitos());
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionCircuitos.jsp"));
                    break;
                case "insertar":
                    agregarCircuito(req, res);
                    break;
                case "eliminar":
                    eliminarCircuito(req, res);
                    //res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionCircuitos.jsp"));
                    break;
                default:
                    break;
            }
        }
    }

    //agregar circuito
    private void agregarCircuito(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        String nombre = req.getParameter("nombre");
        String ciudad = req.getParameter("ciudad");
        String pais = req.getParameter("pais");
        Part part = req.getPart("file");
        String trazado = guardarFoto(part, uploads);
        int numeroDeVueltas = Integer.parseInt(req.getParameter("numeroDeVueltas"));
        int longitud = Integer.parseInt(req.getParameter("longitud"));
        int curvasLentas = Integer.parseInt(req.getParameter("curvasLentas"));
        int curvasMedia = Integer.parseInt(req.getParameter("curvasMedia"));
        int curvasRapidas = Integer.parseInt(req.getParameter("curvasRapidas"));
        
        modelo.insertCircuito(nombre, ciudad, pais, trazado, numeroDeVueltas, longitud, curvasLentas, curvasMedia, curvasRapidas);
        res.sendRedirect("/web-formula1/CircuitosServlet?accion=listar");
    }
    
    //eliminar circuito
    private void eliminarCircuito(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String nombre = req.getParameter("nombre");
        modelo.deleteCircuito(nombre);
        res.sendRedirect("/web-formula1/CircuitosServlet?accion=listar");
    }

    //guardar fotos
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
