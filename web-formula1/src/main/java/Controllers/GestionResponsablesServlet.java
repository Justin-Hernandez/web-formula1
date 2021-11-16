package Controllers;

import Models.ModeloDatos;
import Models.User;
import java.io.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.http.*;

public class GestionResponsablesServlet extends HttpServlet {

    private ModeloDatos modelo;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        modelo = new ModeloDatos();
        modelo.abrirConexion();
    }

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession s = req.getSession(true);
        
        if(req.getParameter("accion") != null)
        {
            String[] aux = req.getParameter("accion").split(";");
            
            String accion = aux[0];
            String usuario= aux[1];
            
            if(accion.equals("add"))
            {
                modelo.updateUserEquipo(usuario, "testEquipo");
            }else {
                modelo.updateUserEquipo(usuario, "null");
            }
        }

        User responsable = (User) req.getSession().getAttribute("usuario");
        ArrayList<User> listaUsers = modelo.getAllUsers();

        ArrayList<User> conEquipo = new ArrayList<>();
        ArrayList<User> sinEquipo = new ArrayList<>();

        for (User user : listaUsers) {
            
            if (user.getRol().equals("Responsable de Equipo")) 
            {
                //si no tiene equipo asociado
                if (user.getEquipo().equals("null")) 
                {
                    sinEquipo.add(user);
                } else if(responsable.getEquipo().equals(user.getEquipo())){
                    conEquipo.add(user);
                }
            }
        }

        s.setAttribute("sinEquipo", sinEquipo);
        s.setAttribute("conEquipo", conEquipo);

        res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionResponsables.jsp"));
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}
