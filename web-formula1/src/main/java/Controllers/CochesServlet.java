package Controllers;

import Models.Equipo;
import Models.ModeloDatos;
import Models.User;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

/**
 *
 * @author Nasr
 */
@MultipartConfig
public class CochesServlet extends HttpServlet {

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
        User usuario = (User) req.getSession().getAttribute("usuario");
        Equipo equipoUser = modelo.findEquipoByIdEquipo(usuario.getEquipo());
        
        if (accion != null) {
            switch (accion) {
                case "listar":
                    //s.setAttribute("coches", modelo.getAllCoches());
                    s.setAttribute("coches", modelo.findCochesByIdEquipo(equipoUser.getId()));
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionCoches.jsp"));
                    break;
                case "insertar":
                    agregarCoche(req, res);
                    break;
                case "eliminar":
                    eliminarCoche(req, res);
                    s.setAttribute("coches", modelo.findCochesByIdEquipo(equipoUser.getId()));
                    //s.setAttribute("coches", modelo.getAllCoches());
                    res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionCoches.jsp"));
                    break;
                default:
                    break;
            }
        }
    }

    //agregar coche
    private void agregarCoche(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        String nombre = req.getParameter("nombre");
        String codigo = req.getParameter("codigo");
        float ersCL = Float.parseFloat(req.getParameter("ersCL"));
        float ersCM = Float.parseFloat(req.getParameter("ersCM"));
        float ersCR = Float.parseFloat(req.getParameter("ersCR"));
        float consumo = Float.parseFloat(req.getParameter("consumo"));
        
        User usuario = (User) req.getSession().getAttribute("usuario");
        Equipo equipoUser = modelo.findEquipoByIdEquipo(usuario.getEquipo());

        modelo.insertCoche(nombre, codigo, ersCL, ersCM, ersCR, consumo, equipoUser.getId());
        res.sendRedirect("/web-formula1/CochesServlet?accion=listar");
    }

    //eliminar coche
    private void eliminarCoche(HttpServletRequest req, HttpServletResponse res) {
           String codigo = req.getParameter("codigo");
           modelo.deleteCar(codigo);
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}
