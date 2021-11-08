package Controllers;

import Models.ModeloDatos;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Nasr
 */

@WebServlet("/RegistroCircuito")
@MultipartConfig(maxFileSize = 16177216)
public class RegistroCircuito extends HttpServlet {
    
    private String pathFiles = "C:\\Users\\DELL\\Documents\\NetBeansProjects\\web-formula1\\web-formula1\\src\\main\\webapp\\store\\img\\";
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
                    //System.out.println(modelo.getAllCircuitos().get(0).getNombre());
                    // Llamada a la página jsp 
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionCircuitos.jsp"));
                    break;
                case "insertar":
                    agregarCircuito(req, res);
                    s.setAttribute("circuitos", modelo.getAllCircuitos());
                    break;
                case "eliminar":
                    eliminarCircuito(req, res);
                    s.setAttribute("circuitos", modelo.getAllCircuitos());
                    break;
                default:
                    break;
            }
        }

    }

    private void agregarCircuito(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
  
        
        String nombre = req.getParameter("nombre");
        String ciudad = req.getParameter("ciudad");
        String pais = req.getParameter("pais");
        String trazado = req.getParameter("trazado");
        int numeroDeVueltas = Integer.parseInt(req.getParameter("numeroDeVueltas"));
        int longitud = Integer.parseInt(req.getParameter("longitud"));
        int curvasLentas = Integer.parseInt(req.getParameter("curvasLentas"));
        int curvasMedia = Integer.parseInt(req.getParameter("curvasMedia"));
        int curvasRapidas = Integer.parseInt(req.getParameter("curvasRapidas"));
        
        modelo.insertCircuito(nombre, ciudad, pais, trazado, numeroDeVueltas, longitud, curvasLentas, curvasMedia, curvasRapidas);
        res.sendRedirect("/web-formula1/Views/GestionCircuitos.jsp");
    }

    private void eliminarCircuito(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String nombre = req.getParameter("nombre");
        modelo.deleteCircuito(nombre);
        res.sendRedirect("/web-formula1/RegistroCircuito?accion=listar");
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
