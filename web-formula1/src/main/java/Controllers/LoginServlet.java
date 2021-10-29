/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;
import Models.ModeloDatos;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
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
    
    public void init(ServletConfig cfg) throws ServletException{
        
        modeloDatos = new ModeloDatos();
        
        try {
            modeloDatos.abrirConexion();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    public void service(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
        //terminar de implementar acorde a la peticion que se reciba
        res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/AdminPanel.jsp"));
    }
    
    public void destroy(){
        modeloDatos.cerrarConexion();
        super.destroy();
    }

}
