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
        bool ekle_guncelle;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                ddlFilmler.Items.Clear();
                Dictionary<int, Film> dict = RezervasyonDB.tumFilmleriGetir();
                foreach (int k in dict.Keys)
                    ddlFilmler.Items.Add(new ListItem(dict[k].FilmAdiTR, dict[k].Id.ToString()));

                ddlSalonlar.Items.Clear();
                foreach (Salon s in SalonDB.tumSalonlariCek())
                    ddlSalonlar.Items.Add(new ListItem(s.Ad, s.Id.ToString()));

                ekle_guncelle = false;

                if (!IsPostBack)
                {
                    if (Request.QueryString["ID"] != null)
                        if (Request.QueryString["Pid"] == "0")
                        {
                            SeansDB.seansSil(Convert.ToInt32(Request.QueryString["ID"]));
                        }
                        else if (Request.QueryString["Pid"] == "1")
                        {
                            ekle_guncelle = true;
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

        }
    }
}