package Models;

/**
 *
 * @author Nasr
 */
public class Circuito {
    
    private int id;
    private String nombre; 
    private String ciudad;
    private String pais;
    private String trazado;
    private int numeroDeVueltas;
    private int longitud;
    private int curvasLentas;
    private int curvasMedia;
    private int curvasRapidas;
    
    //constructor
    public Circuito(
            int id, 
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
        this.id = id;
        this.nombre = nombre;
        this.ciudad = ciudad;
        this.pais = pais;
        this.trazado = trazado;
        this.numeroDeVueltas = numeroDeVueltas;
        this.longitud = longitud;
        this.curvasLentas = curvasLentas;
        this.curvasMedia = curvasMedia;
        this.curvasRapidas = curvasRapidas;
    }
    
    //gets
    public int getId() {
        return id;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public String getCiudad() {
        return ciudad;
    }
    
    public String getPais() {
        return pais;
    }
    
    public String getTrazado() {
        return trazado;
    }
    
    public int getNumeroDeVueltas() {
        return numeroDeVueltas;
    }
    
    public int getLongitud() {
        return longitud;
    }
    
    public int getCurvasLentas() {
        return curvasLentas;
    }
    
    public int getCurvasMedia() {
        return curvasMedia;
    }
    
    public int getCurvasRapidas() {
        return curvasRapidas;
    }
    
    //sets
    public void setId(int id){
        this.id = id;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }
    
    public void setPais(String pais) {
        this.pais = pais;
    }
    
    public void setTrazado(String trazado) {
        this.trazado = trazado;
    }
    
    public void setNumeroDeVueltas(int numeroDeVueltas) {
        this.numeroDeVueltas = numeroDeVueltas;
    }
    
    public void setLongitud(int longitud) {
        this.longitud = longitud;
    }
    
    public void setCurvasLentas(int curvasLentas) {
        this.curvasLentas = curvasLentas;
    }
    
    public void setCurvasMedia(int curvasMedia) {
        this.curvasMedia = curvasMedia;
    }
    
    public void setCurvasRapidas(int curvasRapidas) {
        this.curvasRapidas = curvasRapidas;
    }
}
