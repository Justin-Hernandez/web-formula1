/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.ModeloDatos;
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
public class VotacionesServlet extends HttpServlet {

    private ModeloDatos modeloDatos;

    @Override
    public void init() throws ServletException {
        modeloDatos = new ModeloDatos();
        modeloDatos.abrirConexion();
    }

    /**
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        HttpSession s = req.getSession(true);
        switch (accion) {
            case "votaciones":
                
                s.setAttribute("pilotos", modeloDatos.getAllPilotos());
                s.setAttribute("votaciones", modeloDatos.getAllVotaciones());
                res.sendRedirect("/web-formula1/Views/GestionVotaciones.jsp");
                break;
            case "crear_votacion":
                crearVotacion(req, res);
                s.setAttribute("pilotos", modeloDatos.getAllPilotos());
                s.setAttribute("votaciones", modeloDatos.getAllVotaciones());
                res.sendRedirect("/web-formula1/Views/GestionVotaciones.jsp");
                break;
            case "eliminar":
                //eliminarVotacion(req, res);
                s.setAttribute("votaciones", modeloDatos.getAllVotaciones());
                res.sendRedirect("/web-formula1/Views/GestionVotaciones.jsp");
                break;
            default:

                break;
        }

    }
    
    

    @Override
    public void destroy() {
        modeloDatos.cerrarConexion();
        super.destroy();
    }

    private void crearVotacion(HttpServletRequest req, HttpServletResponse res) {
        
        //modeloDatos.crearVotacion();
    }

}
