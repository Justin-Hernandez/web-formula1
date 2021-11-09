package Controllers;

import Models.ModeloDatos;
import Models.Circuitos;
import java.io.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.http.*;

public class CircuitoServlet extends HttpServlet {

    private ModeloDatos modelo;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        modelo = new ModeloDatos();
        modelo.abrirConexion();
    }

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession s = req.getSession(true);  
        
        //id del circuito
        int id = Integer.parseInt(req.getParameter("id"));
        
        //recupera todos los circuitos de la base de datos
        ArrayList<Circuitos> circuitos = modelo.getAllCircuitos();
        
        Circuitos circuito = null;
        
        //encuentra el circuito con el id referenciado en la query, si no lo encuentra entonces circuito = null
        for (Circuitos c: circuitos) {
            if(c.getId() == id) {
                circuito = c;
            }
        }
        
        if(circuito != null) {
            
            s.setAttribute("circuito", circuito);
            
            //Llamada a noticia.jsp con la noticia correspondiente
            res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Circuito.jsp"));
        }else {
            //Página de error esa noticia no existe
        }
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}