/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.ModeloDatos;
import Models.Votacion;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
public class VotarServlet extends HttpServlet {

    private ModeloDatos modeloDatos;

    @Override
    public void init() throws ServletException {
        modeloDatos = new ModeloDatos();
        modeloDatos.abrirConexion();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        
        HttpSession s = req.getSession(true);
        Votacion votacion = (Votacion) s.getAttribute("votacion");
        
        String correo = req.getParameter("correo");
        
        if(modeloDatos.checkMailOnDeterminedVotation(correo, votacion.getId())){
            s.setAttribute("votacion", votacion);
            s.setAttribute("existe_votacion", "Solo se admite una votación por encuesta !!!");
            res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Votacion.jsp"));
        }else{
            votar(req, res, votacion.getId());
            s.setAttribute("votacion", votacion);
            s.setAttribute("votacion_creada", "Se ha votado correctamente !!!");
            res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Votacion.jsp"));
        }
    }

    public void votar(HttpServletRequest req, HttpServletResponse res, int id_votacion){
        int id_piloto = Integer.parseInt(req.getParameter("piloto"));
        String correo = req.getParameter("correo");
        String nombre = req.getParameter("nombre");
        modeloDatos.adicionarVotacion(nombre, correo, id_piloto, id_votacion);
    }
    
    @Override
    public void destroy() {
        modeloDatos.cerrarConexion();
        super.destroy();
    }
}