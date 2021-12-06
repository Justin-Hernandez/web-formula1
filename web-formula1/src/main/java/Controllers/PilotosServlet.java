package Controllers;

import Models.Equipo;
import Models.ModeloDatos;
import Models.User;
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
                    User usuario = (User) req.getSession().getAttribute("usuario");
                    Equipo equipoUser = modelo.findEquipoByIdEquipo(usuario.getEquipo());
                    //s.setAttribute("pilotos", modelo.findPilotosByIdEquipo(equipoUser.getId()));
                    s.setAttribute("listaP", modelo.getAllPilotosById());
                    s.setAttribute("pilotos", modelo.getAllPilotos());
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionPilotos.jsp"));
                    break;
                case "insertar":
                    agregarPiloto(req, res);
                    break;
                case "eliminar":
                    eliminarPiloto(req, res);
                    s.setAttribute("listaP", modelo.getAllPilotosById());
                    s.setAttribute("pilotos", modelo.getAllPilotos());
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionPilotos.jsp"));
                    break;
                default:
                    break;
            }
        }
    }

    //agregar piloto
    private void agregarPiloto(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        String nombre = req.getParameter("nombre");
        String apellidos = req.getParameter("apellidos");
        String siglas = req.getParameter("siglas");
        int dorsal = Integer.parseInt(req.getParameter("dorsal"));
        Part part = req.getPart("file");
        
        String pais = req.getParameter("pais");
        String twitter = req.getParameter("twitter");
        String equipoV = req.getParameter("equipoV");

        User usuario = (User) req.getSession().getAttribute("usuario");
        Equipo equipoUser = modelo.findEquipoByIdEquipo(usuario.getEquipo());

        String pathFiles = req.getContextPath();
        String pathFiles2 = req.getServletContext().getRealPath("/img");
        
        File uploads = new File(pathFiles2);
        
        String fotoFileName = guardarFoto(part, uploads);
        
        modelo.insertPiloto(nombre, apellidos, siglas, dorsal, pathFiles + "/img/" + fotoFileName, pais, twitter, equipoUser.getId(), equipoV);

        res.sendRedirect("/web-formula1/PilotosServlet?accion=listar");
    }

    //guardar fotos
    private String guardarFoto(Part part, File pathUploads) throws IOException {
        String modifiedName = "";
        Path path = Paths.get(part.getSubmittedFileName());
        String fileName = path.getFileName().toString();
        InputStream inputStream = part.getInputStream();
        if (inputStream != null) {
            File file = new File(pathUploads, fileName);
            if (!file.exists()) {
                Files.copy(inputStream, file.toPath());
                modifiedName = fileName;

            } else {
                String nombreSolamente = FilenameUtils.removeExtension(fileName);
                String extension = FilenameUtils.getExtension(fileName);
                String fileNameModificado = nombreSolamente + "-" + Math.random() + "." + extension;
                File tmp = new File(pathUploads, fileNameModificado);
                Files.copy(inputStream, tmp.toPath());
                modifiedName = fileNameModificado;
            }
        }
        return modifiedName;
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
