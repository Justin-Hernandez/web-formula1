/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.ModeloDatos;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
        
        HttpSession session = request.getSession(true);
        String user = request.getParameter("user");
        String email = request.getParameter("email");
        if(!modeloDatos.existsUserNameOnly(user)){
            if(!modeloDatos.existsUserWithThisMail(email)){
                addUser(request, response);       
            }else{
                session.setAttribute("existe_correo", "Ya existe un usuario con ese correo");
                //System.out.println("Este correo ya existe en la BD");
                //response.sendRedirect("/web-formula1/Views/CrearCuenta.jsp");
            }
        }else{
            session.setAttribute("existe_usuario", "Ya existe un usuario con ese nombre de usuario");
            //System.out.println("ya existe un usuario con ese nombre en la base de datos");
            //response.sendRedirect("/web-formula1/Views/CrearCuenta.jsp");
        }
        
    }
    
    @Override
    public void destroy(){
        modeloDatos.cerrarConexion();
        super.destroy();
    }
    
   public void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       User user = new User(request.getParameter("name"), request.getParameter("user"), request.getParameter("email"), request.getParameter("password"), "");
       modeloDatos.addUser(user);
   }
}
