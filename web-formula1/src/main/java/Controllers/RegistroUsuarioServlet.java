/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.ModeloDatos;
import Models.User;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

/**
 *
 * @author DELL
 */
public class RegistroUsuarioServlet extends HttpServlet {

    private ModeloDatos modeloDatos;
    
    @Override
    public void init(){
    
        modeloDatos = new ModeloDatos();
        modeloDatos.abrirConexion();
    }
    
    
    @Override
    public void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String user = request.getParameter("user");
        String email = request.getParameter("email");
        if(!modeloDatos.existsUserNameOnly(user)){
            if(!modeloDatos.existsUserWithThisMail(email)){
                addUser(request, response);   
                request.setAttribute("confirmacion", "Espere la aprobación de un administrador");
                //response.sendRedirect("/web-formula1/Views/CrearCuenta.jsp");
            }else{
                request.setAttribute("existe_correo", "Ya existe un usuario con ese correo");
                //System.out.println("Este correo ya existe en la BD");
                //response.sendRedirect("/web-formula1/Views/CrearCuenta.jsp");
            }
        }else{
            request.setAttribute("existe_usuario", "Ya existe ese usuario en nuestra web");
            //System.out.println("ya existe un usuario con ese nombre en la base de datos");
            //response.sendRedirect("/web-formula1/Views/CrearCuenta.jsp");
        }
        //response.sendRedirect("/web-formula1/Views/CrearCuenta.jsp");
        //response.sendRedirect(response.encodeRedirectURL("/web-formula1/Views/CrearCuenta.jsp"));   
        request.getRequestDispatcher("/Views/CrearCuenta.jsp").forward(request, response);
    }
    
    @Override
    public void destroy(){
        modeloDatos.cerrarConexion();
        super.destroy();
    }
    
   public void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
       
       String prueba = hashAString(request.getParameter("password"));
       User user = new User(request.getParameter("name"), request.getParameter("user"), request.getParameter("email"), prueba, "null", "null");
       modeloDatos.addUser(user);
   }
   
   
       private String hashAString(String text) {
        String hash = null;

        MessageDigest md;
        try {
            md = MessageDigest.getInstance("MD5");
            md.update(text.getBytes());
            byte[] digest = md.digest();
            hash = DatatypeConverter
                    .printHexBinary(digest).toLowerCase();
            
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return hash;
    }
}
