/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;
import Models.ModeloDatos;
import Models.User;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
public class LoginServlet extends HttpServlet {

    private ModeloDatos modeloDatos;
    
    @Override
    public void init(ServletConfig cfg) throws ServletException{
       
        modeloDatos = new ModeloDatos();
        modeloDatos.abrirConexion();
    }
    
    @Override
    public void service(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
        
        String user = req.getParameter("user");
        String password = req.getParameter("password");
        
        User usuario = modeloDatos.userExists(user, password);
        
        if(usuario != null) {
            
            String rol = usuario.getRol();
            
            //si admin, redirecciona a la página del adimn
            if(rol.equals("admin")) {
                res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/AdminPanel.jsp"));
            
            //si gestor, redirecciona a la página de gestor
            }else if(rol.equals("gestor")) {
                
                res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/GestorPanel.jsp"));
            }            
        }else {
            //usuario no existe, enviar a página de error o algo
            //res.sendRedirect(user);
        }
    }
    
    @Override
    public void destroy(){
        modeloDatos.cerrarConexion();
        super.destroy();
    }
}
