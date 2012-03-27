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
            try
            {
                if (Session["LoggedUser"] == null)
                {
                    Response.Redirect("../Default.aspx");
                }
                else if ((Session["LoggedUser"] as Kullanici).Tip == false)
                {
                    Response.Redirect("../Default.aspx");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        ddlYetki.Items.Clear();
                        ddlYetki.Items.Add(new ListItem("Admin", "true"));
                        ddlYetki.Items.Add(new ListItem("Kullanici", "false"));

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
                                Session["UserPass"] = k.Sifre;

                                if (k.Tip == true)
                                    ddlYetki.SelectedIndex = 0;
                                else ddlYetki.SelectedIndex = 1;
                            }
                    }
                    lstKullanicilar.Items.Clear();
                    lstKullanicilar.DataSource = KullaniciDB.TumKullanicilariCek();
                    lstKullanicilar.DataBind();
                }
            }
            catch { }
            
        }

        protected void btnKullaniciKaydet_Click(object sender, EventArgs e)
        {
            if (txtAd.Text == "" || txtSoyad.Text == "" || txtEposta.Text == "")
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
                ddlYetki.SelectedIndex = Convert.ToInt32(Session["SelectedIndex"]);
                k.Tip = Convert.ToBoolean(ddlYetki.SelectedItem.Value);

                if (Request.QueryString["Pid"] == "1")
                {
                    if (txtSifre.Text == "")
                        k.Sifre = Session["UserPass"].ToString();
                    else
                        k.Sifre = txtSifreTekrar.Text;

                        KullaniciDB.KullaniciGuncelle(k.Id, k.Tip, k.Ad, k.Soyad, k.Eposta, k.Sifre);
                        Response.Redirect("KullaniciYonetimi.aspx");
                    pnlBasarili.Visible = true;
                    spanBasarili.InnerHtml = "Kullanıcı başarıyla güncellendi.";
                }
                else
                {
                    if (txtSifre.Text == "")
                        Response.Write("<script>alert('Şifre alanlari doldurulmamış.')</script>");
                    else
                    {
                        k.Sifre = txtSifreTekrar.Text;
                        KullaniciDB.KullaniciEkle(k);
                    pnlBasarili.Visible = true;
                    spanBasarili.InnerHtml = "Kullanıcı başarıyla eklendi.";

                    }
                }

                lstKullanicilar.Items.Clear();
                lstKullanicilar.DataSource = KullaniciDB.kullaniciAraGenel(txtArama.Text);
                lstKullanicilar.DataBind();
            }
        }

        protected void btnAra_Click(object sender, EventArgs e)
        {
            if (txtArama.Text == "")
                Response.Redirect("KullaniciYonetimi.aspx");
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

        protected void ddlYetki_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["SelectedIndex"] = ddlYetki.SelectedIndex.ToString();
        }
    }
}