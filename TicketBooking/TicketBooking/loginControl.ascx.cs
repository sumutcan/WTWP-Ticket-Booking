using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.ClassLayer;

public partial class loginControl : System.Web.UI.UserControl
{
    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Session["tema"] != null)
        {
            switch (Session["tema"].ToString())
            {
                case "Maroon":
                    Page.Theme = "Maroon";
                    break;
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoggedUser"] == null)
            multiviewLoginControl.ActiveViewIndex = Convert.ToInt32(Session["loginViewState"]);
        else
        {
            lblAdSoyad.Text = (Session["LoggedUser"] as Kullanici).Ad + " " + (Session["LoggedUser"] as Kullanici).Soyad;
            multiviewLoginControl.ActiveViewIndex = Convert.ToInt32(Session["loginViewState"]);

            if ((Session["LoggedUser"] as Kullanici).Tip)
                hlnkAdmin.Visible = true;
        }
    }

    protected void btnGirisYap_Click(object sender, EventArgs e)
    {
        try
        {
            Kullanici k = new Kullanici();
            k.Eposta = txtEPosta.Text;
            k.Sifre = txtSifre.Text;
            Session["LoggedUser"] = k.girisYap();

            if (Session["LoggedUser"] == null)
            {
                Response.Write("<script>alert('Giriş başarısız ! \n Kullanıcı adı veya parola yanlış.')</script>");
            }
            else
                Session["loginViewState"] = 1;
            Response.Redirect(Request.Url.ToString(), false);
        }
        catch (Exception ex) {
            pnlHata.Visible = true;
            spanHata.InnerHtml = ex.Message;
        }
    }


    public void basaDon()
    {
        Session["LoggedUser"] = null;
        Session["loginViewState"] = 0;
        Response.Redirect("~/Default.aspx", false);
    }

    protected void lnkCikisYap_Click(object sender, EventArgs e)
    {
        basaDon();
    }

    protected void lnkSifremiUnuttum0_Click(object sender, EventArgs e)
    {
        Session["loginViewState"] = 3;
        Response.Redirect("~/Default.aspx", false);
    }

    protected void lnkSifremiUnuttum_Click(object sender, EventArgs e)
    {
        Session["loginViewState"] = 2;
        Response.Redirect("~/Default.aspx", false);
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {

            if (txtPass.Text != txtPassTekrar.Text)
                throw new Exception("Girilen şifreler birbirini tutmuyor.");

            Kullanici yeni = new Kullanici();

            yeni.Ad = txtAd.Text;
            yeni.Soyad = txtSoyad.Text;
            yeni.Eposta = txtMail.Text;
            yeni.Sifre = txtPass.Text;
            yeni.Tip = false;

            Response.Write("<script>alert('" + yeni.Kaydol() + "')</script>");

            basaDon();
        }
        catch (Exception ex)
        {
            pnlHata.Visible = true;
            spanHata.InnerHtml = ex.Message;
        }
    }

    protected void lnkProfil_Click(object sender, EventArgs e)
    {
        Response.Redirect("profile.aspx");
    }
}