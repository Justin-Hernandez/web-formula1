package Controllers;

import Models.ModeloDatos;
import Models.Circuito;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Nasr
 */
@WebServlet(name = "CircuitoServlet", urlPatterns = {"/CircuitoServlet"})
public class CircuitoServlet extends HttpServlet {

    private ModeloDatos modelo;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        modelo = new ModeloDatos();
        modelo.abrirConexion();
    }

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession s = req.getSession(true);

        //id del circuito
        int id = Integer.parseInt(req.getParameter("id"));

        //recupera todos los circuitos de la bd
        ArrayList<Circuito> circuitos = modelo.getAllCircuitos();

        Circuito circuito = null;

        //encuentra el circuito con el id referenciado, si no lo encuentra entonces circuito = null
        for (Circuito c : circuitos) {
            if (c.getId() == id) {
                circuito = c;
            }
        }

        if (circuito != null) {
            s.setAttribute("circuito", circuito);
            //Llamada a Circuito.jsp con el circuito correspondiente
            res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Circuito.jsp"));
        } else {
            //Página de error el circuito no existe
        }
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}
