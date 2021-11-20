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
import java.sql.Timestamp;
import java.util.LinkedList;

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
            ResultSet rs = stmt.executeQuery("SELECT * FROM news ORDER BY id DESC");

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
                u = new User(rs.getString("name"), rs.getString("user"), rs.getString("email"), rs.getString("password"), rs.getString("role"), rs.getString("equipo"));
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
        
        String nextId = "";
        
        //recupera la ultima noticia y obtén su id
        try {
            Statement stmt;
            
            stmt = conection.createStatement();
            String query = "SELECT * FROM news ORDER BY ID DESC LIMIT 1";
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()){
                nextId = String.valueOf(rs.getInt("id") + 1);
            }
            
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        
        //id de la nueva noticia a insertar
        permalink = permalink + nextId;
        
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

            while (rs.next()) {
                listaUsers.add(new User(rs.getString("name"), rs.getString("user"), rs.getString("email"), rs.getString("password"), rs.getString("role"), rs.getString("equipo")));
            }
        } catch (SQLException e) {
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

        } catch (SQLException e) {
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

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return actualizado;
    }
    
    public boolean updateUserEquipo(String user, String equipo) {
        
        boolean actualizado = true;
        PreparedStatement pstmt;

        try {
            pstmt = conection.prepareStatement("UPDATE users SET equipo=? WHERE user=?");

            pstmt.setString(1, equipo);
            pstmt.setString(2, user);

            //true si se ha actualizado correctamente, de lo contrario false
            actualizado = pstmt.execute();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return actualizado;
    }
    
    //devuelve todos los circuitos de la base de datos en un ArrayList
    public ArrayList<Circuito> getAllCircuitos() {

        ArrayList<Circuito> listaCircuitos = new ArrayList<>();
        Statement stmt;

        try {
            stmt = conection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM circuitos");
            while (rs.next()) {
                listaCircuitos.add(new Circuito(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("ciudad"),
                        rs.getString("pais"),
                        rs.getString("trazado"),
                        rs.getInt("numeroDeVueltas"),
                        rs.getInt("longitud"),
                        rs.getInt("curvasLentas"),
                        rs.getInt("curvasMedia"),
                        rs.getInt("curvasRapidas")
                ));
            }
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return listaCircuitos;
    }

    //inserta nuevo circuito
    public boolean insertCircuito(
            String nombre,
            String ciudad,
            String pais,
            String trazado,
            int numeroDeVueltas,
            int longitud,
            int curvasLentas,
            int curvasMedia,
            int curvasRapidas
    ) {
        boolean insertado = true;
        PreparedStatement pstmt;
        try {
            pstmt = conection.prepareStatement("INSERT INTO circuitos (nombre, ciudad, pais, trazado, numeroDeVueltas, longitud, curvasLentas, curvasMedia, curvasRapidas) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

            pstmt.setString(1, nombre);
            pstmt.setString(2, ciudad);
            pstmt.setString(3, pais);
            pstmt.setString(4, trazado);
            pstmt.setInt(5, numeroDeVueltas);
            pstmt.setInt(6, longitud);
            pstmt.setInt(7, curvasLentas);
            pstmt.setInt(8, curvasMedia);
            pstmt.setInt(9, curvasRapidas);

            //true si se ha insertado correctamente, de lo contrario false
            insertado = pstmt.execute();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return insertado;
    }

    //eliminar circuito existente
    public boolean deleteCircuito(String nombre) {

        boolean eliminado = true;
        PreparedStatement pstmt;

        try {
            pstmt = conection.prepareStatement("DELETE FROM circuitos WHERE nombre = ?");

            pstmt.setString(1, nombre);

            //true si se ha eliminado correctamente, de lo contrario false
            eliminado = pstmt.execute();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return eliminado;
    }

    //<<<<<<<<<<<<<<End Circuitos part>>>>>>>>>>>>>>
    //<<<<<<<<<<<<<<Coches part>>>>>>>>>>>>>>
    //devuelve todos los coches de la base de datos en un ArrayList
    public ArrayList<Coche> getAllCoches() {

        ArrayList<Coche> listaCoches = new ArrayList<>();
        Statement stmt;

        try {
            stmt = conection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM coches");
            while (rs.next()) {
                listaCoches.add(new Coche(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("codigo"),
                        rs.getFloat("ers_CL"),
                        rs.getFloat("ers_CM"),
                        rs.getFloat("ers_CR"),
                        rs.getFloat("consumo")
                ));
            }
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return listaCoches;
    }

    //inserta nuevo coche
    public boolean insertCoche(
            String nombre,
            String codigo,
            float ers_CL,
            float ers_CM,
            float ers_CR,
            float consumo
    ) {
        boolean insertado = true;
        PreparedStatement pstmt;
        try {
            pstmt = conection.prepareStatement("INSERT INTO coches (nombre, codigo, ers_CL, ers_CM, ers_CR, consumo) VALUES (?, ?, ?, ?, ?, ?)");

            pstmt.setString(1, nombre);
            pstmt.setString(2, codigo);
            pstmt.setFloat(3, ers_CL);
            pstmt.setFloat(4, ers_CM);
            pstmt.setFloat(5, ers_CR);
            pstmt.setFloat(6, consumo);

            //true si se ha insertado correctamente, de lo contrario false
            insertado = pstmt.execute();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return insertado;
    }

    //eliminar coche existente
    public boolean deleteCar(String codigo) {
        boolean eliminado = true;
        PreparedStatement pstmt;

        try {
            pstmt = conection.prepareStatement("DELETE FROM coches WHERE codigo = ?");

            pstmt.setString(1, codigo);

            //true si se ha eliminado correctamente, de lo contrario false
            eliminado = pstmt.execute();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return eliminado;
    }

    //<<<<<<<<<<<<<<End Coches part>>>>>>>>>>>>>>
    public boolean deletePilot(String siglas) {
        boolean eliminado = true;
        PreparedStatement pstmt;

        try {
            pstmt = conection.prepareStatement("DELETE FROM pilotos WHERE siglas = ?");

            pstmt.setString(1, siglas);

            //true si se ha eliminado correctamente, de lo contrario false
            eliminado = pstmt.execute();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return eliminado;
    }



    public boolean addEvent(String nombre_circuito, Timestamp timestamp) {
        boolean evento = false;
        PreparedStatement preparedStatement, preparedStatement2;
        String sql1 = "SELECT id from circuitos where nombre = ?";
        String sql2 = "INSERT INTO eventos (id_circuito, fecha_evento) VALUES (?, ?)";
        try {
            preparedStatement = conection.prepareStatement(sql1);
            preparedStatement.setString(1, nombre_circuito);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                preparedStatement2 = conection.prepareStatement(sql2);
                preparedStatement2.setInt(1, resultSet.getInt("id"));
                preparedStatement2.setTimestamp(2, timestamp);
                evento = preparedStatement2.execute();
            }
        } catch (Exception e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return evento;
    }

    public boolean checkIfExistEventOnDate(String nombre_circuito, Timestamp timestamp) {
        boolean exist = false;

        PreparedStatement preparedStatement;
        String sql = "select * from circuitos inner join "
                + "eventos on circuitos.id = eventos.id_circuito where nombre = ? and date(fecha_evento) = date(?)";
        try {
            preparedStatement = conection.prepareStatement(sql);
            preparedStatement.setString(1, nombre_circuito);
            preparedStatement.setTimestamp(2, timestamp);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                System.out.println("Existe ese evento");
                exist = true;
            }
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return exist;
    }

    public LinkedList<Evento> getAllEvents() {
        LinkedList<Evento> listaEventos = new LinkedList<>();

        Statement stmt;

        try {
            stmt = conection.createStatement();
            ResultSet rs = stmt.executeQuery("select * from circuitos inner join eventos on circuitos.id = eventos.id_circuito");

            while (rs.next()) {
                listaEventos.add(new Evento(rs.getString("nombre"), rs.getString("ciudad"), rs.getString("pais"), 
                        rs.getInt("numeroDevueltas"), rs.getInt("longitud"), rs.getInt("curvasLentas"), 
                        rs.getInt("curvasMedia"), rs.getInt("curvasRapidas"), rs.getTimestamp("fecha_evento")));
            }
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return listaEventos;
    }
    
    //eliminar coche existente
    //--method goes here--
    
    //<<<<<Pilotos>>>>>>
    //devuelve todos los pilotos de la base de datos en un ArrayList
    public ArrayList<Piloto> getAllPilotos() {
        
        ArrayList<Piloto> listaPilotos = new ArrayList<>();
        Statement stmt;
        
        try {
            stmt = conection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM pilotos");
            while(rs.next()) {
                listaPilotos.add(new Piloto(
                        rs.getInt("id"), 
                        rs.getString("nombre"), 
                        rs.getString("apellidos"), 
                        rs.getString("siglas"),
                        rs.getInt("dorsal"),
                        rs.getString("foto"),
                        rs.getString("pais"),
                        rs.getString("twitter")
                ));
            }
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return listaPilotos;
    }
    
    //inserta nuevo piloto
    public boolean insertPiloto(
        String nombre, 
        String apellidos,         
        String siglas,
        int dorsal,
        String foto,
        String pais,
        String twitter
    ) {       
        boolean insertado = true;
        PreparedStatement pstmt; 
        try {
            pstmt = conection.prepareStatement("INSERT INTO pilotos (nombre, apellidos, siglas, dorsal, foto, pais, twitter) VALUES (?, ?, ?, ?, ?, ?, ?)");
            
            pstmt.setString(1, nombre);
            pstmt.setString(2, apellidos);
            pstmt.setString(3, siglas);
            pstmt.setInt(4, dorsal);
            pstmt.setString(5, foto);
            pstmt.setString(6, pais);
            pstmt.setString(7, twitter);
            
            //true si se ha insertado correctamente, de lo contrario false
            insertado = pstmt.execute();
          
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }    
        return insertado;
    }
    
    //eliminar piloto existente
    //--method goes here--
    
}
