using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.ClassLayer;
using TicketBooking.DataAccessLayer;

namespace TicketBooking
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedUser"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                if (!IsPostBack)
                degerAta();
            }

            RezervasyonHandler rHandler = new RezervasyonHandler();
            List<Bilet> sonBiletler = rHandler.sonBiletleriGetir((Session["LoggedUser"] as Kullanici).Id);
            
        }

        public void degerAta()
        {
            Kullanici k = Session["LoggedUser"] as Kullanici;

            txtAd.Text = k.Ad;
            txtSoyad.Text = k.Soyad;
            txtMail.Text = k.Eposta;
            txtSifre.Text = "";
            txtSifre2.Text = "";
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (txtAd.Text == "" || txtSoyad.Text == "" || txtMail.Text == "" || txtSifre.Text == "" || txtSifre2.Text == "")
            {
                Response.Write("<script>alert('Doldurulmamış alanlar mevcut.')</script>");
            }
            else if (txtSifre.Text != txtSifre2.Text)
            {
                Response.Write("<script>alert('Girmiş olduğunuz şifreler eşleşmiyor.')</script>");
            }
            else
            {
                Kullanici k = Session["LoggedUser"] as Kullanici;
                k.Ad = txtAd.Text;
                k.Soyad = txtSoyad.Text;
                k.Eposta = txtMail.Text;
                k.Sifre = txtSifre2.Text;
                Session["LoggedUser"] = k;

                Response.Write("<script>alert('"+ KullaniciDB.KullaniciGuncelle(k.Id,k.Tip,k.Ad,k.Soyad,k.Eposta,k.Sifre) +"')</script>");

                Response.Redirect("Default.aspx");
                

            }
        }


    }
}