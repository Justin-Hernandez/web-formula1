package Models;

/**
 *
 * @author laura
 */
public class Equipo {

    private int id;
    private String nombre;
    private String logo;
    private String twitter;

    public Equipo(int id, String nombre, String logo, String twitter) {
        this.id = id;
        this.nombre = nombre;
        this.logo = logo;
        this.twitter = twitter;
    }
    
    public Equipo(String nombre, String logo, String twitter) {
        this.nombre = nombre;
        this.logo = logo;
        this.twitter = twitter;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getTwitter() {
        return twitter;
    }

    public void setTwitter(String twitter) {
        this.twitter = twitter;
    }

    
    
}
