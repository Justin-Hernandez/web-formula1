/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
public class ModeloDatos {
    
    static String driver = "com.mysql.jdbc.Driver";
    static String url = "jdbc:mysql://sql11.freesqldatabase.com:3306/sql11446947";
    static String user = "sql11446947";
    static String password = "pSLHMf2Dy9";
    
    protected Connection conection;

    public void abrirConexion(){
        try {
            Class.forName(driver);
            conection = DriverManager.getConnection(url, user, password);
            if(conection != null){
                System.out.println("Conexión establecida correctamente " + conection);
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error de SQL " + e.getMessage());
        }   
    }
    
    public void cerrarConexion(){
        try {
            conection.close();
            System.out.println("Conexión Cerrada " + conection);
        } catch (SQLException e) {
            System.out.println("Error de SQL " + e.getMessage());
        }
    }
    
    //devuelve todas las noticias de la abse de datos en un ArrayList
    public ArrayList<News> getAllNews() {
        
        ArrayList<News> listaNews = new ArrayList<>();
        Statement stmt;
        
        try {
            stmt = conection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM news");
            
            while(rs.next()) {
                listaNews.add(new News(rs.getString("permalink"), rs.getString("title"), rs.getBytes("image"), rs.getString("text")));
            }
        }catch (SQLException e){
            System.out.println("SQL ERROR: " + e.toString());
        }
        
        return listaNews;
    }
    
    //si el usuario existe devuelve una instancia de User con sus datos, si no existe devuelve null
    public User userExists(String user, String password) {
        
        User u = null;
        Statement stmt;
        
        try {
            stmt = conection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE user='" + user + "' and password='" + password + "'");
            
            //si existe crea instancia de User
            while(rs.next()) {
                u = new User(rs.getString("name"), rs.getString(user), rs.getString("email"), rs.getString("password"), rs.getString("role"));
            }
            
        }catch (SQLException e){
            System.out.println("SQL ERROR: " + e.toString());
        }
        
        return u;
    }
    
    //inserta nueva noticia
    public boolean insertNews(String permalink, String titulo, Blob imagen, String texto) {
        
        boolean insertado = true;
        PreparedStatement pstmt;
        
        try {
            pstmt = conection.prepareStatement("INSERT INTO news (permalink, title, image, text) VALUES (?, ?, ?, ?)");
            
            pstmt.setString(1, permalink);
            pstmt.setString(2, titulo);
            pstmt.setBlob(3, imagen);
            pstmt.setString(4, texto);
            
            //true si se ha insertado correctamente, de lo contrario false
            insertado = pstmt.execute();
            
        }catch (SQLException e){
            System.out.println("SQL ERROR: " + e.toString());
        }
        
        return insertado;
    }
    
    //elimina noticia existente
    public boolean deleteNews(String titulo) {
        
        boolean eliminado = true;
        PreparedStatement pstmt;
        
        try {
            pstmt = conection.prepareStatement("DELETE FROM news WHERE titulo = ?");
            
            pstmt.setString(1, titulo);
            
            //true si se ha eliminado correctamente, de lo contrario false
            eliminado = pstmt.execute();
            
        }catch (SQLException e){
            System.out.println("SQL ERROR: " + e.toString());
        }        
        
        return eliminado;
    }
}
