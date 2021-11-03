package Controllers;

import Models.ModeloDatos;
import Models.News;
import java.io.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.http.*;

public class NoticiaServlet extends HttpServlet {

    private ModeloDatos modelo;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        modelo = new ModeloDatos();
        modelo.abrirConexion();
    }

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession s = req.getSession(true);  
        
        //id de la noticia como parámetro en el permalink
        int id = Integer.parseInt(req.getParameter("id"));
        
        //recupera todas las noticias de la base de datos
        ArrayList<News> noticias = modelo.getAllNews();
        
        News noticia = null;
        
        //encuentra la noticia con el id referenciado en la query, si no lo encuentra entonces noticia = null
        for (News n: noticias) {
            if(n.getId() == id) {
                noticia = n;
            }
        }
        
        if(noticia != null) {
            
            s.setAttribute("noticia", noticia);
            
            //Llamada a noticia.jsp con la noticia correspondiente
            res.sendRedirect(res.encodeRedirectURL("/web-formula1/Views/Noticia.jsp"));
        }else {
            //Página de error esa noticia no existe
        }
    }

    @Override
    public void destroy() {
        modelo.cerrarConexion();
        super.destroy();
    }
}