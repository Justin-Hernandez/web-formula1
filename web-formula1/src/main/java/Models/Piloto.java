package Models;

/**
 *
 * @author Nasr
 */
public class Piloto {
    private int id;
    private String nombre;
    private String apellidos;
    private String siglas;
    private int dorsal;
    private String foto;
    private String pais;
    private String twitter;
    private int equipo;
    
    //constructor
    public Piloto(
            int id,
            String nombre, 
            String apellidos,
            String siglas,
            int dorsal,
            String foto,
            String pais,
            String twitter
    ) {
        this.id = id;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.siglas = siglas;
        this.dorsal = dorsal;
        this.foto = foto;
        this.pais = pais;
        this.twitter = twitter;
    }

    public Piloto(String nombre, String apellidos) {
        this.nombre = nombre;
        this.apellidos = apellidos;
    }

    public Piloto(int id, String nombre, String apellidos, String siglas, int dorsal, String foto, String pais, String twitter, int equipo) {
        this.id = id;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.siglas = siglas;
        this.dorsal = dorsal;
        this.foto = foto;
        this.pais = pais;
        this.twitter = twitter;
        this.equipo = equipo;
    }
    
    
    
    //gets
    public int getId() {
        return id;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public String getApellidos() {
        return apellidos;
    }
    
    public String getSiglas() {
        return siglas;
    }
    
    public int getDorsal() {
        return dorsal;
    }
    
    public String getFoto() {
        return foto;
    }
    
    public String getPais() {
        return pais;
    }
    
    public String getTwitter() {
        return twitter;
    }
    
    //sets
    public void setId(int id){
        this.id = id;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }
    
    public void setSiglas(String siglas) {
        this.siglas = siglas;
    }
    
    public void setDorsal(int dorsal) {
        this.dorsal = dorsal;
    }
    
    public void setFoto(String foto) {
        this.foto = foto;
    }
    
    public void setPais(String pais) {
        this.pais = pais;
    }
    
    public void setTwitter(String twitter) {
        this.twitter = twitter;
    }

    public int getEquipo() {
        return equipo;
    }

    public void setEquipo(int equipo) {
        this.equipo = equipo;
    }
    
    
}
