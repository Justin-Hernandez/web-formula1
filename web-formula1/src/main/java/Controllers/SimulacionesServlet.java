package Controllers;

import Models.Circuito;
import Models.Coche;
import Models.Equipo;
import Models.ModeloDatos;
import Models.User;
import java.io.*;
import java.text.DecimalFormat;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.http.*;

public class SimulacionesServlet extends HttpServlet {

    private ModeloDatos modelo;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        modelo = new ModeloDatos();
        modelo.abrirConexion();
    }

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession s = req.getSession(true);

        User responsable = (User) req.getSession().getAttribute("usuario");

        //todos los coches
        ArrayList<Coche> listaCoches = modelo.getAllCoches();
        ArrayList<Circuito> listaCircuitos = modelo.getAllCircuitos();
        ArrayList<Equipo> listaEquipos = modelo.getAllEquipos();

        //solo los coches del equipo del usuario con el que se ha inciado la sesión
        ArrayList<Coche> cochesEquipo = new ArrayList<Coche>();
        
        eliminarAtributos(s);

        for (Coche c : listaCoches) {
            Equipo equipoCoche = null;

            //recupera el equipo del coche
            for (Equipo e : listaEquipos) {
                if (e.getId() == c.getEquipo()) {
                    equipoCoche = e;
                }
            }

            //si el equipo al que esta asociado existe en la base de datos y es el mismo equipo 
            //que el responsable con el que se ha iniciado sesión
            if (req.getParameter("equipo") != null) {
                if (equipoCoche != null && equipoCoche.getNombre().equals(req.getParameter("equipo"))) {
                    cochesEquipo.add(c);
                }
            } else {
                if (equipoCoche != null && equipoCoche.getNombre().equals(responsable.getEquipo())) {
                    cochesEquipo.add(c);
                }
            }
        }

        if (req.getParameter("equipo") != null) {
            s.setAttribute("equipo", req.getParameter("equipo"));
        }

        //SECCION COMBUSTIBLE
        String idCircuitoCombustible = req.getParameter("circuitoCombustible");
        String idCocheCombustible = req.getParameter("cocheCombustible");

        if (idCircuitoCombustible != null && idCocheCombustible != null) {
            Coche coche = null;
            Circuito circuito = null;

            for (Coche c : listaCoches) {
                if (c.getId() == Integer.parseInt(idCocheCombustible)) {
                    coche = c;
                }
            }

            for (Circuito c : listaCircuitos) {
                if (c.getId() == Integer.parseInt(idCircuitoCombustible)) {
                    circuito = c;
                }
            }

            if (coche != null && circuito != null) {
                s.setAttribute("cocheCombustible", coche);
                s.setAttribute("circuitoCombustible", circuito);
                s.setAttribute("consumoVuelta", consumoPorVuelta(coche, circuito));
                s.setAttribute("consumoTotal", consumoTotal(coche, circuito));
            }
        }

        //SECCION ERS
        String idCircuitoErs = req.getParameter("circuitoErs");
        String idCocheErs = req.getParameter("cocheErs");
        String tipoConduccion = req.getParameter("conduccion");

        if (idCircuitoErs != null && idCocheErs != null && tipoConduccion != null) {
            Coche coche = null;
            Circuito circuito = null;

            for (Coche c : listaCoches) {
                if (c.getId() == Integer.parseInt(idCocheErs)) {
                    coche = c;
                }
            }

            for (Circuito c : listaCircuitos) {
                if (c.getId() == Integer.parseInt(idCircuitoErs)) {
                    circuito = c;
                }
            }

            if (coche != null && circuito != null) {
                s.setAttribute("cocheErs", coche);
                s.setAttribute("circuitoErs", circuito);
                s.setAttribute("tipoConduccion", tipoConduccion);

                String ersVuelta = ersVuelta(coche, circuito, tipoConduccion);

                s.setAttribute("gananciaVuelta", ersVuelta);
                s.setAttribute("vueltasNecesariasErs", vueltasNecesariasErs(ersVuelta, circuito));
            }
        }

        s.setAttribute("listaCoches", cochesEquipo);
        s.setAttribute("listaCircuitos", listaCircuitos);

        res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Simulaciones.jsp"));
    }

    public String consumoPorVuelta(Coche coche, Circuito circuito) {
        DecimalFormat format = new DecimalFormat("0.000");

        return format.format(((double) coche.getConsumo() / 100) * ((double) circuito.getLongitud() / 1000));
    }

    public String consumoTotal(Coche coche, Circuito circuito) {
        DecimalFormat format = new DecimalFormat("0.000");

        return format.format(((double) coche.getConsumo() / 100) * ((double) circuito.getLongitud() / 1000) * circuito.getNumeroDeVueltas());
    }

    public String ersVuelta(Coche coche, Circuito circuito, String tipo) {
        DecimalFormat format = new DecimalFormat("0.000");

        double ersVuelta = modificacionSegunTipo((double) circuito.getCurvasLentas() * coche.getErsCL(), tipo)
                + modificacionSegunTipo((double) circuito.getCurvasMedia() * coche.getErsCM(), tipo)
                + modificacionSegunTipo((double) circuito.getCurvasRapidas() * coche.getErsCR(), tipo);

        //límite reglamentario
        if (ersVuelta > 0.6) {
            ersVuelta = 0.6;
        }

        return format.format(ersVuelta);
    }

    public String vueltasNecesariasErs(String ersVuelta, Circuito circuito) {

        double ers = Double.parseDouble(ersVuelta.replace(',', '.'));

        return String.valueOf((int) Math.ceil(120 / ers));
    }

    public double modificacionSegunTipo(Double valor, String tipo) {
        double nuevoValor = valor;

        switch (tipo) {
            case "ahorrador":
                nuevoValor = nuevoValor + (0.05 * valor);
                break;
            case "normal":
                nuevoValor = nuevoValor - (0.25 * valor);
                break;
            case "deportivo":
                nuevoValor = nuevoValor - (0.60 * valor);
                break;
        }

        return nuevoValor;
    }
    
    public void eliminarAtributos(HttpSession session)
    {
        session.removeAttribute("cocheErs");
        session.removeAttribute("circuitoErs");
        session.removeAttribute("tipoConduccion");
        session.removeAttribute("gananciaVuelta");
        session.removeAttribute("vueltasNecesariasErs");
        
        session.removeAttribute("cocheCombustible");
        session.removeAttribute("circuitoCombustible");
        session.removeAttribute("consumoVuelta");
        session.removeAttribute("consumoTotal");
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}