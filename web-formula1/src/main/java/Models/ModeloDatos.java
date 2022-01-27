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
    static String url = "jdbc:mysql://0.tcp.ngrok.io:16496/formula1";
    static String user = "root";
    static String password = "root";

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
            
            stmt.close();
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
            
            stmt.close();

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
            
            preparedStatement.close();
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
            
            preparedStatement.close();
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return existe;
    }

    public void addUser(User user) {
        PreparedStatement preparedStatement;

        try {
            String query = "INSERT INTO users (name, user, email, password, role, equipo) VALUES (?, ?, ?, ?, ?, ?)";
            preparedStatement = conection.prepareStatement(query);
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getUser());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setString(5, user.getRol());
            preparedStatement.setString(6, user.getEquipo());

            preparedStatement.execute();
            
            preparedStatement.close();

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

            while (rs.next()) {
                nextId = String.valueOf(rs.getInt("id") + 1);
            }
            
            stmt.close();
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
            
            pstmt.close();
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
            
            pstmt.close();

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
            
            stmt.close();
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
            
            pstmt.close();
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
            
            pstmt.close();

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
            
            pstmt.close();

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
            
            stmt.close();
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
            
            pstmt.close();

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
            
            pstmt.close();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return eliminado;
    }

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
                        rs.getFloat("consumo"),
                        rs.getInt("equipo")
                ));
            }
            
            stmt.close();
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
            float consumo, int idequipo
    ) {
        boolean insertado = true;
        PreparedStatement pstmt;
        try {
            pstmt = conection.prepareStatement("INSERT INTO coches (nombre, codigo, ers_CL, ers_CM, ers_CR, consumo, equipo) VALUES (?, ?, ?, ?, ?, ?, ?)");

            pstmt.setString(1, nombre);
            pstmt.setString(2, codigo);
            pstmt.setFloat(3, ers_CL);
            pstmt.setFloat(4, ers_CM);
            pstmt.setFloat(5, ers_CR);
            pstmt.setFloat(6, consumo);
            pstmt.setInt(7, idequipo);

            //true si se ha insertado correctamente, de lo contrario false
            insertado = pstmt.execute();
            
            pstmt.close();
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
            
            pstmt.close();
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
            
            pstmt.close();
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
            
            preparedStatement.close();
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
            
            preparedStatement.close();
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
            
            stmt.close();
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
            while (rs.next()) {
                listaPilotos.add(new Piloto(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("apellidos"),
                        rs.getString("siglas"),
                        rs.getInt("dorsal"),
                        rs.getString("foto"),
                        rs.getString("pais"),
                        rs.getString("twitter"),
                        rs.getString("equipoV")
                ));
            }
            
            stmt.close();
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
            String twitter, 
            int equipo,
            String equipoV
    ) {
        boolean insertado = true;
        PreparedStatement pstmt;
        try {
            pstmt = conection.prepareStatement("INSERT INTO pilotos (nombre, apellidos, siglas, dorsal, foto, pais, twitter, equipo, equipoV) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

            pstmt.setString(1, nombre);
            pstmt.setString(2, apellidos);
            pstmt.setString(3, siglas);
            pstmt.setInt(4, dorsal);
            pstmt.setString(5, foto);
            pstmt.setString(6, pais);
            pstmt.setString(7, twitter);
            pstmt.setInt(8, equipo);
            pstmt.setString(9, equipoV);

            //true si se ha insertado correctamente, de lo contrario false
            insertado = pstmt.execute();
            
            pstmt.close();
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return insertado;
    }

    //recupera todos los equipos de la base de datos
    public ArrayList<Equipo> getAllEquipos() {

        ArrayList<Equipo> listaEquipos = new ArrayList<>();
        Statement stmt;

        try {
            stmt = conection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM equipos");

            while (rs.next()) {
                String ruta = rs.getString("logo");
                String logo = null;
                if (ruta != null && !ruta.isEmpty()) {
                    String sustituir = ruta.replace('\\', '/');
                    //Separo la ruta en partes delimitadas por el caracter /
                    String[] parts = sustituir.split("/");
                    //Obtengo lo que quiero mostrar en el textview
                    logo = "../img/" + parts[parts.length - 1];
                }
                Equipo e =new Equipo(rs.getInt("id"), rs.getString("nombre"), logo, rs.getString("twitter"));
                listaEquipos.add(e);
            }
            
            stmt.close();
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return listaEquipos;
    }

    public void addEquipo(Equipo equipo, User user) {
        PreparedStatement preparedStatement;

        try {
            String query = "INSERT INTO equipos (nombre, logo, twitter) VALUES (?, ?, ?)";
            preparedStatement = conection.prepareStatement(query);
            preparedStatement.setString(1, equipo.getNombre());
            preparedStatement.setString(2, equipo.getLogo());
            preparedStatement.setString(3, equipo.getTwitter());

            preparedStatement.execute();
            updateUserEquipo(user.getUser(), equipo.getNombre());
            
            preparedStatement.close();
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
    }

    public Equipo findEquipoByIdEquipo(String equipo) {

        Equipo u = null;
        Statement stmt;

        try {
            stmt = conection.createStatement();
            String query = "SELECT * FROM equipos WHERE nombre='" + equipo + "'";
            ResultSet rs = stmt.executeQuery(query);

            //si existe crea instancia de User
            while (rs.next()) {
                String ruta = rs.getString("logo");
                String logo = null;
                if (ruta != null && !ruta.isEmpty()) {
                    String sustituir = ruta.replace('\\', '/');
                    //Separo la ruta en partes delimitadas por el caracter /
                    String[] parts = sustituir.split("/");
                    //Obtengo lo que quiero mostrar en el textview
                    logo = "../img/" + parts[parts.length - 1];
                }

                u = new Equipo(Integer.parseInt(rs.getString("id")), rs.getString("nombre"), logo, rs.getString("twitter"));
            }
            
            stmt.close();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return u;
    }

    public Equipo findEquipoById(int id) {

        Equipo u = null;
        Statement stmt;

        try {
            stmt = conection.createStatement();
            String query = "SELECT * FROM equipos WHERE id='" + id + "'";
            ResultSet rs = stmt.executeQuery(query);

            //si existe crea instancia de User
            while (rs.next()) {
                String ruta = rs.getString("logo");
                String logo = null;
                if (ruta != null && !ruta.isEmpty()) {
                    String sustituir = ruta.replace('\\', '/');
                    //Separo la ruta en partes delimitadas por el caracter /
                    String[] parts = sustituir.split("/");
                    //Obtengo lo que quiero mostrar en el textview
                    logo = "../img/" + parts[parts.length - 1];
                }
                u = new Equipo(Integer.parseInt(rs.getString("id")), rs.getString("nombre"), logo, rs.getString("twitter"));
            }
            
            stmt.close();
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return u;
    }

    //si el usuario existe devuelve una instancia de User con sus datos, si no existe devuelve null
    public User findUser(String user) {

        User u = null;
        Statement stmt;

        try {
            stmt = conection.createStatement();
            String query = "SELECT * FROM users WHERE user='" + user + "' ";
            ResultSet rs = stmt.executeQuery(query);

            //si existe crea instancia de User
            while (rs.next()) {
                u = new User(rs.getString("name"), rs.getString("user"), rs.getString("email"), rs.getString("password"), rs.getString("role"), rs.getString("equipo"));
            }
            
            stmt.close();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return u;
    }

    public boolean existsEquipoNombre(String nombre) {
        boolean existe = false;
        PreparedStatement preparedStatement;

        try {
            String query = "SELECT * FROM equipos WHERE nombre = ?";
            preparedStatement = conection.prepareStatement(query);
            preparedStatement.setString(1, nombre);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet != null) {
                if (resultSet.next()) {
                    existe = true;
                }
            }
            
            preparedStatement.close();
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return existe;
    }

    public ArrayList<Piloto> findPilotosByIdEquipo(int equipo) {

        ArrayList<Piloto> pilotos = new ArrayList<>();
        Statement stmt;

        try {
            stmt = conection.createStatement();
            String query = "SELECT * FROM pilotos WHERE equipo='" + equipo + "'";
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                pilotos.add(new Piloto(rs.getInt("id"), rs.getString("nombre"),
                        rs.getString("apellidos"), rs.getString("siglas"),
                        rs.getInt("dorsal"), rs.getString("foto"),
                        rs.getString("pais"), rs.getString("twitter")
                ));
            }
            
            stmt.close();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return pilotos;
    }

    public ArrayList<Coche> findCochesByIdEquipo(int equipo) {

        ArrayList<Coche> coches = new ArrayList<>();;
        Statement stmt;

        try {
            stmt = conection.createStatement();
            String query = "SELECT * FROM coches WHERE equipo='" + equipo + "'";
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                coches.add(new Coche(rs.getString("nombre"), rs.getString("codigo")));
            }
            
            stmt.close();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return coches;
    }

    public ArrayList<User> findResponsablesMismoEquipo(String equipo) {
        ArrayList<User> responsables = new ArrayList<>();;
        Statement stmt;

        try {
            stmt = conection.createStatement();

            String query = "SELECT * FROM users WHERE equipo='" + equipo + "'";
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                responsables.add(new User(rs.getString("name"), rs.getString("user"), rs.getString("email"),
                        rs.getString("password"), rs.getString("role"), rs.getString("equipo")));
            }
            
            stmt.close();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return responsables;
    }

    //<<<<<Votaciones>>>>>
    public ArrayList<Votacion> getAllVotaciones() {

        ArrayList<Votacion> listaVotaciones = new ArrayList<>();
        Statement stmt;

        try {
            stmt = conection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM votaciones");

            while (rs.next()) {
                listaVotaciones.add(new Votacion(
                        rs.getInt("id_votaciones"),
                        rs.getString("permalink"),
                        rs.getString("titulo"),
                        rs.getString("descripcion"),
                        rs.getTimestamp("fecha_limite")
                ));
            }
            
            stmt.close();
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return listaVotaciones;
    }

    public void crearVotacion(String permalink, String titulo, String descripcion, Timestamp fecha, String[] siglas) {

        String idPermalink = "";
        int idUltimaVotacion = 0;
        String sql1 = "INSERT INTO pilotos_votaciones (id_votaciones, id_pilotos) VALUES (?, ?)";
        String sql2 = "SELECT id_votaciones FROM votaciones ORDER BY id_votaciones DESC LIMIT 1";
        String sql3 = "INSERT INTO votaciones (permalink, titulo, descripcion, fecha_limite) VALUES (?, ?, ?, ?)";
        String sql4 = "SELECT id FROM pilotos WHERE siglas = ?";
        String sql5 = "UPDATE votaciones SET permalink = ?, titulo = ?, descripcion = ?, fecha_limite = ? where id_votaciones = ? ";

        try {
            /*
            PreparedStatement preparedStatement = conection.prepareStatement(sql2);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                idPermalink = String.valueOf(resultSet.getInt("id_votaciones") + 1);
            }*/

            PreparedStatement preparedStatement = conection.prepareStatement(sql3);
            preparedStatement.setString(1, permalink + idPermalink);
            preparedStatement.setString(2, titulo);
            preparedStatement.setString(3, descripcion);
            preparedStatement.setTimestamp(4, fecha);
            preparedStatement.execute();

            PreparedStatement preparedStatement2 = conection.prepareStatement(sql2);
            ResultSet resultSet1 = preparedStatement2.executeQuery();
            while (resultSet1.next()) {
                idUltimaVotacion = resultSet1.getInt("id_votaciones");
            }

            PreparedStatement preparedStatement5 = conection.prepareStatement(sql5);
            preparedStatement5.setString(1, permalink + String.valueOf(idUltimaVotacion));
            preparedStatement5.setString(2, titulo);
            preparedStatement5.setString(3, descripcion);
            preparedStatement5.setTimestamp(4, fecha);
            preparedStatement5.setInt(5, idUltimaVotacion);
            preparedStatement5.execute();

            PreparedStatement preparedStatement3 = conection.prepareStatement(sql1);
            PreparedStatement preparedStatement4 = conection.prepareStatement(sql4);
            preparedStatement3 = conection.prepareStatement(sql1);
            for (int i = 0; i < siglas.length; i++) {
                preparedStatement4.setString(1, siglas[i]);
                ResultSet resultSet2 = preparedStatement4.executeQuery();
                while (resultSet2.next()) {
                    Integer idPiloto = resultSet2.getInt("id");
                    preparedStatement3.setInt(1, idUltimaVotacion);
                    preparedStatement3.setInt(2, idPiloto);
                    preparedStatement3.execute();
                }
            }
            
            preparedStatement.close();
            preparedStatement2.close();
            preparedStatement3.close();
            preparedStatement4.close();
            preparedStatement5.close();

        } catch (SQLException ex) {
            System.out.println("SQL ERROR: " + ex.toString());
        }

    }

    public ArrayList<Piloto> getAllPilotosByIdVotation(int idVotacion) {
        ArrayList<Piloto> listaPilotos = new ArrayList<>();
        String sql = "select id_pilotos, pilotos.nombre, apellidos, siglas, dorsal, foto, pais, pilotos.twitter, "
                + "equipos.nombre as equipo from pilotos_votaciones inner join votaciones on pilotos_votaciones.id_votaciones "
                + "= votaciones.id_votaciones inner join pilotos on pilotos_votaciones.id_pilotos = pilotos.id inner join equipos "
                + "on pilotos.equipo = equipos.id where pilotos_votaciones.id_votaciones = ?";

        try {
            PreparedStatement preparedStatement = conection.prepareStatement(sql);
            preparedStatement.setInt(1, idVotacion);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                listaPilotos.add(new Piloto(resultSet.getInt("id_pilotos"), resultSet.getString("nombre"),
                        resultSet.getString("apellidos"), resultSet.getString("siglas"), resultSet.getInt("dorsal"),
                        resultSet.getString("foto"), resultSet.getString("pais"), resultSet.getString("twitter"), resultSet.getString("equipo")));
            }
            
            preparedStatement.close();
        } catch (SQLException ex) {
            System.out.println("SQL ERROR: " + ex.toString());
        }

        return listaPilotos;

    }

    public boolean checkMailOnDeterminedVotation(String correo, int id_votacion) {
        boolean exist = false;

        String sql = "select * from votantes inner join votantes_votaciones_pilotos "
                + "on votantes.id_votante = votantes_votaciones_pilotos.id_votante "
                + "where correo = ? and id_votaciones = ?";

        try {
            PreparedStatement preparedStatement = conection.prepareStatement(sql);
            preparedStatement.setString(1, correo);
            preparedStatement.setInt(2, id_votacion);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                exist = true;
            }
            
            preparedStatement.close();
        } catch (SQLException ex) {
            System.out.println("SQL ERROR: " + ex.toString());
        }

        return exist;
    }

    public void adicionarVotacion(String nombre, String correo, int id_piloto, int id_votacion) {
        int id_votante = 0;
        String sql1 = "INSERT INTO votantes (nombre, correo) VALUES (?, ?)";
        String sql2 = "SELECT id_votante from votantes where correo = ?";
        String sql3 = "INSERT INTO votantes_votaciones_pilotos (id_votaciones, id_votante, id_pilotos) VALUES (?, ?, ?)";

        try {
            if (!existeVotanteConEseCorreo(correo)) {
                PreparedStatement preparedStatement = conection.prepareStatement(sql1);
                preparedStatement.setString(1, nombre);
                preparedStatement.setString(2, correo);
                preparedStatement.execute();
            }

            PreparedStatement preparedStatement1 = conection.prepareStatement(sql2);
            preparedStatement1.setString(1, correo);
            ResultSet resultSet = preparedStatement1.executeQuery();
            while (resultSet.next()) {
                id_votante = resultSet.getInt("id_votante");
            }

            PreparedStatement preparedStatement2 = conection.prepareStatement(sql3);
            preparedStatement2.setInt(1, id_votacion);
            preparedStatement2.setInt(2, id_votante);
            preparedStatement2.setInt(3, id_piloto);
            preparedStatement2.execute();
            
            preparedStatement1.close();
            preparedStatement2.close();

        } catch (SQLException ex) {
            System.out.println("SQL ERROR: " + ex.toString());
        }

    }

    public boolean existeVotanteConEseCorreo(String correo) {
        boolean exist = false;
        String sql = "SELECT * FROM votantes where correo = ?";
        try {
            PreparedStatement preparedStatement = conection.prepareStatement(sql);
            preparedStatement.setString(1, correo);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                exist = true;
            }
            
            preparedStatement.close();
        } catch (SQLException ex) {
            System.out.println("SQL ERROR: " + ex.toString());
        }
        return exist;
    }

    public ArrayList<Integer> cantidadVotosDePilotos(Votacion v) {
        ArrayList<Integer> votos = new ArrayList<>();
        String sql = "select count(id_votante) as cantidad_votantes "
                + "from votantes_votaciones_pilotos where id_votaciones = ? and id_pilotos = ?";
        try {
            PreparedStatement preparedStatement = conection.prepareStatement(sql);
            preparedStatement.setInt(1, v.getId());
            for (int i = 0; i < v.getListaPilotos().size(); i++) {
                preparedStatement.setInt(2, v.getListaPilotos().get(i).getId());
                ResultSet resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    votos.add(resultSet.getInt("cantidad_votantes"));
                }
            }
            
            preparedStatement.close();
        } catch (SQLException ex) {
            System.out.println("SQL ERROR: " + ex.toString());
        }
        return votos;

    }
    
    public boolean deleteVotacion(String titulo) {
        boolean eliminado = true;
        PreparedStatement pstmt;

        try {
            pstmt = conection.prepareStatement("DELETE FROM votaciones WHERE titulo = ?");

            pstmt.setString(1, titulo);

            //true si se ha eliminado correctamente, de lo contrario false
            eliminado = pstmt.execute();
            
            pstmt.close();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }
        return eliminado;
    }
    
    
    //lista con los ids de los pilotos que participan en una votacion 
    public ArrayList<Integer> getAllPilotosById() {

        ArrayList<Integer> listaP = new ArrayList<>();
        Statement stmt;

        try {
            stmt = conection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM pilotos_votaciones");

            while (rs.next()) {
                listaP.add(
                        rs.getInt("id_pilotos")                                                                                                
                );
            }
            
            stmt.close();
        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.toString());
        }

        return listaP;
    }
    
}
