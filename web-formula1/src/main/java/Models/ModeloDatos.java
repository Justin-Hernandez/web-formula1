/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

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

    public void abrirConexion() throws ClassNotFoundException {
        try {
            Class.forName(driver);
            conection = DriverManager.getConnection(url, user, password);
            if(conection != null){
                System.out.println("Conexión establecida correctamente " + conection);
            }
        } catch (SQLException e) {
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
    
}
