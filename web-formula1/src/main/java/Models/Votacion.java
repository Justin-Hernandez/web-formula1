package Models;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author macbook
 */
public class Votacion {

    private int id;
    private String permalink;
    private String titulo;
    private String descripcion;
    private Timestamp fechaLimite;
    private ArrayList<Piloto> listaPilotos;
    
    //constructor
    public Votacion(
            int id,
            String permalink,
            String titulo,
            String descripcion,
            Timestamp fechaLimite,
            ArrayList<Piloto> listaPilotos
    ) {
        this.id = id;
        this.permalink = permalink;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.fechaLimite = fechaLimite;
        this.listaPilotos = listaPilotos;
    }
    
    //Aditional constructors
    public Votacion(
            int id,
            String permalink,
            String titulo,
            String descripcion,
            Timestamp fechaLimite
    ) {
        this.id = id;
        this.permalink = permalink;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.fechaLimite = fechaLimite;
    }
    
    public Votacion(
            int id,
            String permalink,
            String titulo,
            String descripcion
    ) {
        this.id = id;
        this.permalink = permalink;
        this.titulo = titulo;
        this.descripcion = descripcion;
    }
     
   //setters
    public void setId(int id) {
        this.id = id;
    }

    public void setPermalink(String permalink) {
        this.permalink = permalink;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setFichaLimite(Timestamp fechaLimite) {
        this.fechaLimite = fechaLimite;
    }

    public void setListaPilotos(ArrayList<Piloto> listaPilotos) {
        this.listaPilotos = listaPilotos;
    }
    
    //getters
    public int getId() {
        return id;
    }

    public String getPermalink() {
        return permalink;
    }
    
    public String getTitulo() {
        return titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public Timestamp getFechaLimite() {
        return fechaLimite;
    }

    public ArrayList<Piloto> getListaPilotos() {
        return listaPilotos;
    }
    
}
