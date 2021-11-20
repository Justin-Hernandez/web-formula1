/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.sql.Timestamp;



/**
 *
 * @author DELL
 */
public class Evento {

    private String nombre;
    private String ciudad;
    private String pais;
    private int numeroDeVueltas;
    private int longitud;
    private int curvasLentas;
    private int curvasMedia;
    private int curvasRapidas;
    private Timestamp fechaEvento;

    public Evento(String nombre, String ciudad, String pais, 
            int numeroDeVueltas, int longitud, int curvasLentas, 
            int curvasMedia, int curvasRapidas, 
            Timestamp timestamp) {
        this.nombre = nombre;
        this.ciudad = ciudad;
        this.pais = pais;
        this.numeroDeVueltas = numeroDeVueltas;
        this.longitud = longitud;
        this.curvasLentas = curvasLentas;
        this.curvasMedia = curvasMedia;
        this.curvasRapidas = curvasRapidas;
        this.fechaEvento = timestamp;
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

    public Timestamp getFechaEvento() {
        return fechaEvento;
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

    public void setFechaEvento(Timestamp fechaEvento) {
        this.fechaEvento = fechaEvento;
    }
    
    
    
    
    
}
