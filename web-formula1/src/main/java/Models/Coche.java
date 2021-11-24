package Models;

/**
 *
 * @author Nasr
 */

public class Coche {
    private int id;
    private String nombre;
    private String codigo;
    private float ersCL;
    private float ersCM;
    private float ersCR;
    private float consumo;
    private int equipo;
    
    //constructor
    public Coche (
            int id, 
            String nombre, 
            String codigo, 
            float ersCL, 
            float ersCM, 
            float ersCR,
            float consumo
    ) {
        this.id = id;
        this.nombre = nombre;
        this.codigo = codigo;
        this.ersCL = ersCL;
        this.ersCM = ersCM;
        this.ersCR = ersCR;
        this.consumo = consumo;
    }

    public Coche(String nombre, String codigo) {
        this.nombre = nombre;
        this.codigo = codigo;
    }

    public Coche(int id, String nombre, String codigo, float ersCL, float ersCM, float ersCR, float consumo, int equipo) {
        this.id = id;
        this.nombre = nombre;
        this.codigo = codigo;
        this.ersCL = ersCL;
        this.ersCM = ersCM;
        this.ersCR = ersCR;
        this.consumo = consumo;
        this.equipo = equipo;
    }
    
    
    
    //gets
    public int getId() {
        return id;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public String getCodigo() {
        return codigo;
    }

    public float getErsCL() {
        return ersCL;
    }

    public float getErsCM() {
        return ersCM;
    }

    public float getErsCR() {
        return ersCR;
    }
    
    public float getConsumo() {
        return consumo;
    }

    //sets
    public void setId(int id){
        this.id = id;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void setCodigo(String codigo){
        this.codigo = codigo;
    }
    
    public void setErsCL(float ersCL){
        this.ersCL = ersCL;
    }
    
    public void setErsCM(float ersCM){
        this.ersCM = ersCM;
    }
    
    public void setErsCR(float ersCR){
        this.ersCR = ersCR;
    }
    
    public void setConsumo(float consumo){
        this.consumo = consumo;
    }

    public int getEquipo() {
        return equipo;
    }

    public void setEquipo(int equipo) {
        this.equipo = equipo;
    }
    
    
    
}