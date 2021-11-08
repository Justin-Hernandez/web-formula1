/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

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

    public void abrirConexion() {
        try {
            Class.forName(driver);
            conection = DriverManager.getConnection(url, user, password);
            if (conection != null) {
                System.out.println("Conexión establecida correctamente " + conection);
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error de SQL " + e.getMessage());
        }
    }

    public void cerrarConexion() {
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

            while (rs.next()) {
                listaNews.add(new News(rs.getInt("id"), rs.getString("permalink"), rs.getString("title"), rs.getString("image"), rs.getString("text")));
            }
        } catch (SQLException e) {
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
            String query = "SELECT * FROM users WHERE user='" + user + "' and password='" + password + "'";
            ResultSet rs = stmt.executeQuery(query);

            //si existe crea instancia de User
            while (rs.next()) {
                u = new User(rs.getString("name"), rs.getString("user"), rs.getString("email"), rs.getString("password"), rs.getString("role"));
            }

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return u;
    }

    public boolean existsUserNameOnly(String username) {
        boolean existe = false;
        PreparedStatement preparedStatement;

        try {
            String query = "SELECT * FROM users WHERE user = ?";
            preparedStatement = conection.prepareStatement(query);
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet != null) {
                if (resultSet.next()) {
                    existe = true;
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return existe;
    }
    
        public boolean existsUserWithThisMail(String email) {
        boolean existe = false;
        PreparedStatement preparedStatement;

        try {
            String query = "SELECT * FROM users WHERE email = ?";
            preparedStatement = conection.prepareStatement(query);
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet != null) {
                if (resultSet.next()) {
                    existe = true;
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return existe;
    }

    public void addUser(User user) {
        PreparedStatement preparedStatement;
        
        try {
            String query = "INSERT INTO users (name, user, email, password, role) VALUES (?, ?, ?, ?, ?)";
            preparedStatement = conection.prepareStatement(query);
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getUser());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setString(5, user.getRol());

            preparedStatement.execute();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
    }

    //inserta nueva noticia
    public boolean insertNews(String permalink, String titulo, String imagen, String texto) {

        boolean insertado = true;
        PreparedStatement pstmt;

        try {
            pstmt = conection.prepareStatement("INSERT INTO news (permalink, title, image, text) VALUES (?, ?, ?, ?)");

            pstmt.setString(1, permalink);
            pstmt.setString(2, titulo);
            pstmt.setString(3, imagen);
            pstmt.setString(4, texto);

            //true si se ha insertado correctamente, de lo contrario false
            insertado = pstmt.execute();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return insertado;
    }

    //elimina noticia existente
    public boolean deleteNews(String titulo) {

        boolean eliminado = true;
        PreparedStatement pstmt;

        try {
            pstmt = conection.prepareStatement("DELETE FROM news WHERE title = ?");

            pstmt.setString(1, titulo);

            //true si se ha eliminado correctamente, de lo contrario false
            eliminado = pstmt.execute();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return eliminado;
    }
    
    //recupera todos los usuarios de la base de datos
    public ArrayList<User> getAllUsers() {
        
        ArrayList<User> listaUsers = new ArrayList<>();
        Statement stmt;
        
        try {
            stmt = conection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users");
            
            while(rs.next()) {
                listaUsers.add(new User(rs.getString("name"), rs.getString("user"), rs.getString("email"), rs.getString("password"), rs.getString("role")));
            }
        }catch (SQLException e){
            System.out.println("SQL ERROR: " + e.toString());
        }
        
        return listaUsers;
    }
    
    public boolean deleteUser(String user) {
        
        boolean eliminado = true;
        PreparedStatement pstmt;
        
        try {
            pstmt = conection.prepareStatement("DELETE FROM users WHERE user = ?");
            
            pstmt.setString(1, user);
            
            //true si se ha eliminado correctamente, de lo contrario false
            eliminado = pstmt.execute();
            
        }catch (SQLException e){
            System.out.println("SQL ERROR: " + e.toString());
        }    
        
        return eliminado;
    }
    
    public boolean updateUserRol(String user, String rol) {
        
        boolean actualizado = true;
        PreparedStatement pstmt;
        
        try {
            pstmt = conection.prepareStatement("UPDATE users SET role=? WHERE user=?");
            
            pstmt.setString(1, rol);
            pstmt.setString(2, user);
            
            //true si se ha actualizado correctamente, de lo contrario false
            actualizado = pstmt.execute();
            
        }catch (SQLException e){
            System.out.println("SQL ERROR: " + e.toString());
        }    
        
        return actualizado;
    }
}
