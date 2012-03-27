using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.ClassLayer;
using TicketBooking.DataAccessLayer;
using System.Collections;
using System.Globalization;

namespace TicketBooking.Admin
{
    public partial class FilmYonetimi : System.Web.UI.Page
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
                        ddlAltyaziDublaj.Items.Clear();
                        ddlAltyaziDublaj.Items.Add(new ListItem("Dublaj", "true"));
                        ddlAltyaziDublaj.Items.Add(new ListItem("Altyazı", "false"));

                        if (Request.QueryString["ID"] != null)
                            if (Request.QueryString["Pid"] == "0")
                            {
                                FilmDB.filmSil(Convert.ToInt32(Request.QueryString["ID"]));
                            }
                            else if (Request.QueryString["Pid"] == "1")
                            {
                                ArrayList film = new ArrayList();
                                film = FilmDB.filmAraID(Convert.ToInt32(Request.QueryString["ID"]));
                                Film f = film[0] as Film;

                                txtFilmAdi.Text = f.FilmAdiEN;
                                calenderVizyonTarih.SelectedDate = f.VizyonTarihi;
                                calenderBitisTarih.SelectedDate = f.BitisTarihi;
                                txtAfisURL.Text = f.AfisURL.ToString();
                                txtYil.Text = f.YapimYili.ToString();

                                if (f.GetD3 == true)
                                    chk3D.Checked = true;

                                if (f.GeldiMi == true)
                                    chkGeldiMi.Checked = true;

                                if (f.AltDub == true)
                                    ddlAltyaziDublaj.SelectedIndex = 0;
                                else ddlAltyaziDublaj.SelectedIndex = 1;

                            }
                    }
                    lstFilmler.Items.Clear();
                    lstFilmler.DataSource = FilmDB.tumFilmleriCek();
                    lstFilmler.DataBind();
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void txtAfisURL_TextChanged(object sender, EventArgs e)
        {
            imgFilmAfisi.ImageUrl = txtAfisURL.Text;
        }

        protected void btnKullaniciKaydet_Click(object sender, EventArgs e)
        {
            if (txtFilmAdi.Text == "" || txtVizyonTarihi.Text == "" || txtBitisTarihi.Text == "" || txtAfisURL.Text == "")
            {
                Response.Write("<script>alert('Doldurulmamış alanlar mevcut.')</script>");
            }
            else
            {
                Film f = new Film();
                f.Id = Convert.ToInt32(Request.QueryString["ID"]);
                f.FilmAdiEN = txtFilmAdi.Text;
                f.FilmAdiTR = txtFilmAdi.Text;
                f.BitisTarihi = DateTime.Parse(txtBitisTarihi.Text, CultureInfo.CreateSpecificCulture("en-US"));
                f.VizyonTarihi = DateTime.Parse(txtVizyonTarihi.Text, CultureInfo.CreateSpecificCulture("en-US"));
                f.YapimYili = txtYil.Text;
                f.afisURL = txtAfisURL.Text;
                f.GetD3 = chk3D.Checked;
                f.GeldiMi = chkGeldiMi.Checked;
                ddlAltyaziDublaj.SelectedIndex = Convert.ToInt32(Session["SelectedIndex2"]);
                f.AltDub = Convert.ToBoolean(ddlAltyaziDublaj.SelectedItem.Value);

                if (Request.QueryString["Pid"] == "1")
                {
                    FilmDB.filmGuncelle(f);
                    Response.Redirect("FilmYonetimi.aspx");
                }
                else
                {
                    FilmDB.filmEkle(f);
                }

                lstFilmler.Items.Clear();
                lstFilmler.DataSource = FilmDB.tumFilmleriCek();
                lstFilmler.DataBind();
            }
        }

        protected void ddlAltyaziDublaj_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["SelectedIndex2"] = ddlAltyaziDublaj.SelectedIndex.ToString();
        }

        protected void btnAra_Click(object sender, EventArgs e)
        {
            if (txtArama.Text == "")
                Response.Redirect("FilmYonetimi.aspx");
            else
            {
                if (FilmDB.filmAraGenel(txtArama.Text) != null)
                {
                    lstFilmler.Items.Clear();
                    lstFilmler.DataSource = FilmDB.filmAraGenel(txtArama.Text);
                    lstFilmler.DataBind();
                }
            }
        }
    }
}