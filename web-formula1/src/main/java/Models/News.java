package Models;

/**
 *
 * @author justi
 */
public class News {
    
    private String permalink;
    private String titulo;
    private String img;
    private String texto;

    public News(String permalink, String titulo, String img, String texto) {
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

    public String getImg() {
        return img;
    }

    public String getTexto() {
        return texto;
    }

    public void setPermalink(String permalink) {
        this.permalink = permalink;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }
}
