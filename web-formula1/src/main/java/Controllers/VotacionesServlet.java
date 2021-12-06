/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.ModeloDatos;
import Models.Piloto;
import Models.Votacion;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String accion = req.getParameter("accion");
        HttpSession s = req.getSession(true);
        switch (accion) {
            case "listar":
                s.setAttribute("votaciones", modeloDatos.getAllVotaciones());
                res.sendRedirect("/web-formula1/Views/Votaciones.jsp");
                break;
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
                eliminarVotacion(req, res);
                s.setAttribute("votaciones", modeloDatos.getAllVotaciones());
                res.sendRedirect("/web-formula1/Views/GestionVotaciones.jsp");
                break;
            default:

                break;
        }
                                                                                
    }

    private void crearVotacion(HttpServletRequest req, HttpServletResponse res) {
        String titulo = req.getParameter("titulo");
        String descripcion = req.getParameter("descripcion");
        String dateTimeISO = req.getParameter("fecha");   //2021-11-18T23:58
        /**
         * *******PARA EL MANEJO DEL TIMESTAMP*************************
         */
        Timestamp fecha = null;
        try {
            String date = dateTimeISO.substring(0, 10);
            String time = dateTimeISO.substring(11, 16);
            Date d = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date + " " + time);
            fecha = new Timestamp(d.getTime());
        } catch (ParseException e) {
            System.out.println("Parse ERROR: " + e.toString());
        }

        String siglas[] = req.getParameterValues("siglas");

        modeloDatos.crearVotacion("http://localhost:8080/web-formula1/VotacionServlet?id=", titulo, descripcion, fecha, siglas);
    }

    //eliminar votacion
    private void eliminarVotacion(HttpServletRequest req, HttpServletResponse res) {
        String titulo = req.getParameter("titulo");
        modeloDatos.deleteVotacion(titulo);
    }
    
    

    @Override
    public void destroy() {
        modeloDatos.cerrarConexion();
        super.destroy();
    }
}
