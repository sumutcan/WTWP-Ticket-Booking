using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.DataAccessLayer;
using TicketBooking.ClassLayer;

namespace TicketBooking.Admin
{
    public partial class SeansYonetimi : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Session["SalonID"] = ddlSalonlar.SelectedValue;
                Session["FilmID"] = ddlFilmler.SelectedValue;
                ddlFilmler.Items.Clear();
                Dictionary<int, Film> dict = RezervasyonDB.tumFilmleriGetir();
                foreach (int k in dict.Keys)
                    ddlFilmler.Items.Add(new ListItem(dict[k].FilmAdiTR, dict[k].Id.ToString()));

                ddlSalonlar.Items.Clear();
                foreach (Salon s in SalonDB.tumSalonlariCek())
                    ddlSalonlar.Items.Add(new ListItem(s.Ad, s.Id.ToString()));

                

                if (!IsPostBack)
                {
                    if (Request.QueryString["ID"] != null)
                        if (Request.QueryString["Pid"] == "0")
                        {
                            SeansDB.seansSil(Convert.ToInt32(Request.QueryString["ID"]));
                            pnlBasarili.Visible = true;
                            spanBasarili.InnerText = "Seans silindi.";
                        }
                        else if (Request.QueryString["Pid"] == "1")
                        {
                            guncelle.Value = "1";
                            Seans seans = SeansDB.tekSeansCek(Convert.ToInt32(Request.QueryString["ID"]));
                            ddlFilmler.SelectedValue = seans.Film.Id.ToString();
                            ddlSalonlar.SelectedValue = seans.Salon.Id.ToString();
                            txtSaat.Text = seans.H;
                            txtDakika.Text = seans.Min;

                        }
                }
                
                lstSeanslar.DataSource = SeansDB.tumSeanslariCek();
                lstSeanslar.DataBind();
            }
            catch (Exception ex)
            {
                pnlHata.Visible = true;
                span1.InnerText = ex.Message;
            }


        }

        protected void btnSeansKaydet_Click(object sender, EventArgs e)
        {
            try
            {
                Seans s = new Seans(Convert.ToInt32(Request.QueryString["ID"]));

                s.Film.Id = Convert.ToInt32(Session["FilmID"].ToString());
                s.Salon.Id = Convert.ToInt32(Session["SalonID"].ToString());
                s.Saat = TimeSpan.Parse(txtSaat.Text+":"+txtDakika.Text);


                if (guncelle.Value=="1")
                {
                    SeansDB.seansGuncelle(s);
                    
                    pnlBasarili.Visible = true;
                    spanBasarili.InnerHtml = "Seans başarıyla güncellendi.";
                    guncelle.Value = "0";

                    txtDakika.Text = string.Empty;
                    txtSaat.Text = string.Empty;
                    ddlSalonlar.SelectedIndex = 0;
                    ddlFilmler.SelectedIndex = 0;
                }
                else
                {
                    SeansDB.seansEkle(s);
                    pnlBasarili.Visible = true;
                    spanBasarili.InnerHtml = "Seans başarıyla eklendi.";

                    txtDakika.Text = string.Empty;
                    txtSaat.Text = string.Empty;
                    ddlSalonlar.SelectedIndex = 0;
                    ddlFilmler.SelectedIndex = 0;

                }

                lstSeanslar.DataSource = SeansDB.tumSeanslariCek();
                lstSeanslar.DataBind();
            }
            catch (Exception ex)
            {
                pnlHata.Visible = true;
                span1.InnerText = ex.Message;
            }
        }
    }
}