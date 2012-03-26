using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.ClassLayer;
using TicketBooking.DataAccessLayer;
using System.Collections;

namespace TicketBooking
{
    public partial class KullaniciYonetimi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ddlYetki.Items.Add(new ListItem("Admin","true"));
            ddlYetki.Items.Add(new ListItem("Kullanici", "false"));
            if (!IsPostBack)
            {
                if (Request.QueryString["ID"] != null)
                    if (Request.QueryString["Pid"] == "0")
                    {
                        KullaniciDB.KullaniciSil(Convert.ToInt32(Request.QueryString["ID"]));
                    }
                    else if (Request.QueryString["Pid"] == "1")
                    {
                        ArrayList kullanici = new ArrayList();
                        kullanici = KullaniciDB.kullaniciAra(Convert.ToInt32(Request.QueryString["ID"]));
                        Kullanici k = kullanici[0] as Kullanici;

                        txtAd.Text = k.Ad;
                        txtSoyad.Text = k.Soyad;
                        txtEposta.Text = k.Eposta;
                        txtSifre.Text = null;
                        txtSifreTekrar.Text = null;

                        if (k.Tip == true)
                            ddlYetki.SelectedIndex = 0;
                        else ddlYetki.SelectedIndex = 1;
                    }
            }
            lstKullanicilar.Items.Clear();
            lstKullanicilar.DataSource = KullaniciDB.TumKullanicilariCek();
            lstKullanicilar.DataBind();
        }

        protected void btnKullaniciKaydet_Click(object sender, EventArgs e)
        {
            if (txtAd.Text == "" || txtSoyad.Text == "" || txtEposta.Text == "" || txtSifre.Text == "" || txtSifreTekrar.Text == "")
            {
                Response.Write("<script>alert('Doldurulmamış alanlar mevcut.')</script>");
            }
            else if (txtSifre.Text != txtSifreTekrar.Text)
            {
                Response.Write("<script>alert('Girilen şifreler eşleşmiyor.')</script>");
            }
            else
            {
                Kullanici k = new Kullanici();
                k.Id = Convert.ToInt32(Request.QueryString["ID"]);
                k.Ad = txtAd.Text;
                k.Soyad = txtSoyad.Text;
                k.Eposta = txtEposta.Text;
                k.Sifre = txtSifreTekrar.Text;
                k.Tip = Convert.ToBoolean(ddlYetki.SelectedItem.Value);
                KullaniciDB.KullaniciGuncelle(k.Id,k.Tip,k.Ad,k.Soyad,k.Eposta,k.Sifre);
            }
        }

        protected void btnAra_Click(object sender, EventArgs e)
        {
            if (txtArama.Text == "")
                Response.Write("<script>alert('Aranacak kelimeyi giriniz.')</script>");
            else
            {
                if (KullaniciDB.kullaniciAraGenel(txtArama.Text) != null)
                {
                    lstKullanicilar.Items.Clear();
                    lstKullanicilar.DataSource = KullaniciDB.kullaniciAraGenel(txtArama.Text);
                    lstKullanicilar.DataBind();
                }
            }
        }
    }
}