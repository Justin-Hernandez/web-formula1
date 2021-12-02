/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.ModeloDatos;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
public class CalendarioServlet extends HttpServlet {

    private ModeloDatos modeloDatos;

    @Override
    public void init() throws ServletException {
        modeloDatos = new ModeloDatos();
        modeloDatos.abrirConexion();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String accion = req.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "listar_eventos":
                //Accion de listar en el calendario  
                    req.setAttribute("lista_eventos", modeloDatos.getAllEvents());
                    req.getRequestDispatcher("/Views/Calendario.jsp").forward(req, resp);
                    //resp.sendRedirect("/web-formula1/Views/Calendario.jsp");
                    break;
                case "adicionar_evento":
                    if (!checkIfExistEventOnDate(req, resp)) {
                        addEvent(req, resp);
                        req.setAttribute("adicionado", req.getParameter("nombre"));
                        //resp.sendRedirect("/web-formula1/Views/GestionCircuitos.jsp");
                    }else{
                        req.setAttribute("existe", "Ya existe un evento ese día en el calendario");
                        //resp.sendRedirect("/web-formula1/Views/GestionCircuitos.jsp");
                    }  
                    req.getRequestDispatcher("/Views/GestionCircuitos.jsp").forward(req, resp);
                    break;
            }
        }
        

    }

    public void addEvent(HttpServletRequest req, HttpServletResponse res) throws IOException {

        try {
            String nombre_circuito = req.getParameter("nombre");
            String dateTimeISO = req.getParameter("dateEvent");   //2021-11-18T23:58
            String date = dateTimeISO.substring(0, 10);
            String time = dateTimeISO.substring(11, 16);

            Date d = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date + " " + time);
            Timestamp timestamp = new Timestamp(d.getTime());
            modeloDatos.addEvent(nombre_circuito, timestamp);
        } catch (ParseException e) {
            System.out.println("Parse ERROR: " + e.toString());
        }
    }

    public boolean checkIfExistEventOnDate(HttpServletRequest req, HttpServletResponse res) {
        boolean exist = false;
        try {
            String nombre_circuito = req.getParameter("nombre");
            String dateTimeISO = req.getParameter("dateEvent");   //2021-11-18T23:58
            String date = dateTimeISO.substring(0, 10);
            String time = dateTimeISO.substring(11, 16);

            Date d = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date + " " + time);
            Timestamp timestamp = new Timestamp(d.getTime());
            exist = modeloDatos.checkIfExistEventOnDate(nombre_circuito, timestamp);
        } catch (ParseException e) {
            System.out.println("Parse ERROR: " + e.toString());
        }
        return exist;
    }

    @Override
    public void destroy() {
        modeloDatos.cerrarConexion();
        super.destroy();
    }

}
