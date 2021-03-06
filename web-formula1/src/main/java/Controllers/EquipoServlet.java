package Controllers;

import Models.Equipo;
import Models.ModeloDatos;
import Models.User;
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
@WebServlet(name = "EquipoServlet", urlPatterns = {"/EquipoServlet"})
public class EquipoServlet extends HttpServlet {
    
    private ModeloDatos modelo;
    
    private Equipo equipoNew;

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
        
        User usuario = (User) req.getSession().getAttribute("usuario");
        
        Equipo equipoUser = modelo.findEquipoByIdEquipo(usuario.getEquipo());
        s.setAttribute("equipoUser", equipoUser);
        
        s.setAttribute("mensaje", null);
        s.setAttribute("equipos", modelo.getAllEquipos());
        if (accion != null) {
            switch (accion) {
                case "insertar":
                    if (modelo.existsEquipoNombre(req.getParameter("nombre"))) {
                        s.setAttribute("mensaje", "Ya exite un equipo con este nombre");
                        res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionEquipo.jsp"));
                    } else {
                        addEquipo(req, res, usuario);
                        s.setAttribute("equipos", modelo.getAllEquipos());
                        //s.setAttribute("equipoUser", getEquipo());
                        s.setAttribute("equipo", getEquipo());
                        s.setAttribute("usuario", modelo.findUser(usuario.getUser()));
                        res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/ResponsableEquipoPanel.jsp"));
                    }
                    break;
                case "view":
                    Equipo e = viewEquipo(req, res);
                    s.setAttribute("equipoUser", e);
                    s.setAttribute("pilotos", modelo.findPilotosByIdEquipo(e.getId()));
                    s.setAttribute("coches", modelo.findCochesByIdEquipo(e.getId()));
                    s.setAttribute("responsables", modelo.findResponsablesMismoEquipo(e.getNombre()));
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionEquipo.jsp"));
                    break;
                default:
                    break;
            }
        }else{
           res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionEquipo.jsp"));
        }
    }

    
    
    private void addEquipo(HttpServletRequest req, HttpServletResponse res, User user) throws IOException, ServletException {
        
        
        //String e2 = req.getServletContext().getRealPath("src/main/webapp/store/img");
        //String pathFiles2 = Paths.get("src//main//webapp//store//img").toString();
        //String pathFiles = req.getServletContext().getRealPath("/store/img");

        String nombre = req.getParameter("nombre");
        String twitter = req.getParameter("twitter");
        Part part = req.getPart("file");
        
        String pathFiles = req.getContextPath();
        String pathFiles2 = req.getServletContext().getRealPath("/img");
        File uploads = new File(pathFiles2);
        
        String fotoFileName = guardarFoto(part, uploads);
        fotoFileName=fotoFileName.isEmpty()?null:fotoFileName;

        //String foto2 = guardarFoto(part, ue);
        /*/////NO BORRAAAAAAR
        String camino = getServletContext().getRealPath("/" + "file" + File.separator + part.getSubmittedFileName());
        //System.out.println(camino);*/
        

        //String foto = guardarFoto(part, uploads);
        Equipo equipo = new Equipo(nombre, pathFiles + "/img/" + fotoFileName,twitter);
        modelo.addEquipo(equipo, user);
        setEquipo(equipo);

        
    }
    
    private Equipo getEquipo(){
        return equipoNew;
    }
    
    private void setEquipo(Equipo equipo){
        this.equipoNew=equipo;
    }

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
    
    private Equipo viewEquipo(HttpServletRequest req, HttpServletResponse res){
        int idEquipo = Integer.parseInt(req.getParameter("id"));
        Equipo equipo = modelo.findEquipoById(idEquipo);
        return equipo;
        
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}
