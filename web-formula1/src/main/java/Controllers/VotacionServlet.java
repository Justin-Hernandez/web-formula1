/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.ModeloDatos;
import Models.Votacion;
import java.io.IOException;
import java.sql.Timestamp;
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
public class VotacionServlet extends HttpServlet {

    private ModeloDatos modeloDatos;

    @Override
    public void init() throws ServletException {
        modeloDatos = new ModeloDatos();
        modeloDatos.abrirConexion();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession s = req.getSession(true);
        int idVotacion = Integer.parseInt(req.getParameter("id"));

        ArrayList<Votacion> votaciones = modeloDatos.getAllVotaciones();
        Votacion votacion = null;
        for (Votacion v : votaciones) {
            if (v.getId() == idVotacion) {
                votacion = new Votacion(idVotacion, v.getPermalink(),
                        v.getTitulo(), v.getDescripcion(), v.getFechaLimite(), modeloDatos.getAllPilotosByIdVotation(idVotacion));
            }
        }
        if (votacion != null) {
            Date date = new Date();
            Timestamp timestamp = new Timestamp(date.getTime());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");;

            Timestamp fecha_limite = votacion.getFechaLimite();
            Timestamp fecha_ahora = Timestamp.valueOf(sdf.format(timestamp));
            if (fecha_ahora.after(fecha_limite)) {
                s.setAttribute("votacion", votacion);
                s.setAttribute("votos", cantidadVotosDePilotos(votacion));
                res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/VotacionExpirada.jsp"));
            } else {
                s.setAttribute("votacion", votacion);
                res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Votacion.jsp"));
            }
        }

    }

    public ArrayList<Integer> cantidadVotosDePilotos(Votacion v){
        return modeloDatos.cantidadVotosDePilotos(v);
    }
    
    @Override
    public void destroy() {
        modeloDatos.cerrarConexion();
        super.destroy();
    }

}
