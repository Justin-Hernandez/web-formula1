package Controllers;

import Models.ModeloDatos;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Nasr
 */
@MultipartConfig
public class PilotosServlet extends HttpServlet {

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
                    s.setAttribute("pilotos", modelo.getAllPilotos());
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionPilotos.jsp"));
                    break;
                case "insertar":
                    agregarPiloto(req, res);
                    break;
                case "eliminar":
                    eliminarPiloto(req, res);
                    s.setAttribute("pilotos", modelo.getAllPilotos());
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionPilotos.jsp"));
                    break;
                default:
                    break;
            }
        }
    }

    //agregar coche
    private void agregarPiloto(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        String nombre = req.getParameter("nombre");
        String apellidos = req.getParameter("apellidos");
        String siglas = req.getParameter("siglas");
        int dorsal = Integer.parseInt(req.getParameter("dorsal"));
        Part part = req.getPart("file");
        String foto = guardarFoto(part, uploads);
        String pais = req.getParameter("pais");
        String twitter = req.getParameter("twitter");

        modelo.insertPiloto(nombre, apellidos, siglas, dorsal, foto, pais, twitter);
        res.sendRedirect("/web-formula1/PilotosServlet?accion=listar");
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

    //eliminar piloto
    private void eliminarPiloto(HttpServletRequest req, HttpServletResponse res) {
        String siglas = req.getParameter("siglas");
        modelo.deletePilot(siglas);
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}
