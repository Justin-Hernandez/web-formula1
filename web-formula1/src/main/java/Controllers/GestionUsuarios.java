package Controllers;

import Models.ModeloDatos;
import Models.User;
import java.io.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.http.*;

public class GestionUsuarios extends HttpServlet {

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
            
            if(accion.equals("aprobar") && req.getParameter("rol") != null)
            {
                modelo.updateUserRol(usuario, req.getParameter("rol"));
            }else {
                modelo.deleteUser(usuario);
            }
        }
        
        ArrayList<User> listaUsers = modelo.getAllUsers();
        
        ArrayList<User> conRol = new ArrayList<>();
        ArrayList<User> sinRol = new ArrayList<>();
        
        for(User user: listaUsers)
        {
            //si no tiene rol es un usuario que se debe validar
            if(user.getRol().equals("null"))
            {
                sinRol.add(user);
            }else
            {
                conRol.add(user);
            }
        }
        
        s.setAttribute("sinRol", sinRol);
        s.setAttribute("conRol", conRol);
        
        res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestionUsuarios.jsp"));        
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}