/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.sql.Connection;
import java.sql.DriverManager;
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
}
