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
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

/**
 *
 * @author DELL
 */
public class LoginServlet extends HttpServlet {

    private ModeloDatos modeloDatos;

    @Override
    public void init(ServletConfig cfg) throws ServletException {

        modeloDatos = new ModeloDatos();
        modeloDatos.abrirConexion();
    }

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession session = req.getSession(true);

        String user = req.getParameter("user");
        String password = req.getParameter("password");

        User usuario = modeloDatos.userExists(user, hashAString(password));

        if (usuario != null) {

            session.setAttribute("usuario", usuario);
            String rol = usuario.getRol();
            
            session.setAttribute("rol", rol);
            
            //si admin, redirecciona a la página del adimn
            if (rol.equals("Administrador") || rol.equals("Responsable de Equipo")) {
                
                res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/AdminPanel.jsp"));

                //si gestor, redirecciona a la página de gestor
            } else if (rol.equals("Responsable de Equipo")) {
                
                session.setAttribute("equipo", usuario.getEquipo());
                res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/ResponsableEquipoPanel.jsp"));
            }
        } else {
            //usuario no existe, enviar a página de error o algo
            //res.sendRedirect(user);
        }
    }

    @Override
    public void destroy() {
        modeloDatos.cerrarConexion();
        super.destroy();
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
