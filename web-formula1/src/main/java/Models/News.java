package Models;

/**
 *
 * @author justi
 */
public class News {
    
    private int id;
    private String permalink;
    private String titulo;
    private byte[] img;
    private String texto;

    public News(int id, String permalink, String titulo, byte[] img, String texto) {
        this.id = id;
        this.permalink = permalink;
        this.titulo = titulo;
        this.img = img;
        this.texto = texto;
    }

    public String getPermalink() {
        return permalink;
    }

    public String getTitulo() {
        return titulo;
    }

    public byte[] getImg() {
        return img;
    }

    public String getTexto() {
        return texto;
    }
    
    public int getId() {
        return id;
    }

    public void setPermalink(String permalink) {
        this.permalink = permalink;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setImg(byte [] img) {
        this.img = img;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }
    
    public void setId(int id) {
        this.id = id;
    }
}
