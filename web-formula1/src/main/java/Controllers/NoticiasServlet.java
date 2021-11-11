package Controllers;

import Models.ModeloDatos;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.apache.commons.io.FilenameUtils;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig
public class NoticiasServlet extends HttpServlet {

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
                    s.setAttribute("news", modelo.getAllNews());
                    // Llamada a la página jsp 

                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Noticias.jsp"));
                    break;
                case "insertar":
                    agregarNoticia(req, res);
                    s.setAttribute("news", modelo.getAllNews());
                    res.sendRedirect("/web-formula1/Views/GestionNoticias.jsp");
                    break;
                case "eliminar":
                    eliminarNoticia(req, res);
                    s.setAttribute("news", modelo.getAllNews());
                    res.sendRedirect("/web-formula1/Views/GestionNoticias.jsp");
                    break;
                default:

                    break;
            }
        }
    }

    private void agregarNoticia(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        String pathFiles = req.getServletContext().getRealPath("/store/img");

        File uploads = new File(pathFiles);
        
        
        String noticia = req.getParameter("textarea");
        String titulo = req.getParameter("title");
        Part part = req.getPart("file");

        /*/////NO BORRAAAAAAR
        String camino = getServletContext().getRealPath("/" + "file" + File.separator + part.getSubmittedFileName());
        System.out.println(camino);
        */

        String foto = guardarFoto(part, uploads);
        modelo.insertNews("permalink ejemplo", titulo, foto, noticia);
        
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

    private void eliminarNoticia(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String titulo = req.getParameter("titulo");
        modelo.deleteNews(titulo);
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}
