/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

/**
 *
 * @author justi
 */
public class User {
    
    private String name;
    private String user;
    private String email;
    private String password;
    private String rol;

    public User(String name, String user, String email, String password, String rol) {
        this.name = name;
        this.user = user;
        this.email = email;
        this.password = password;
        this.rol = rol;
    }

    public String getName() {
        return name;
    }

    public String getUser() {
        return user;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getRol() {
        return rol;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRol(String role) {
        this.rol = role;
    }
    
    
}
