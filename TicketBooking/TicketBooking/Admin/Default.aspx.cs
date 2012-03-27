using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.ClassLayer;
using TicketBooking.DataAccessLayer;

namespace TicketBooking.Admin
{
    public partial class Default : System.Web.UI.Page
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
                    lblAdSoyad.Text = (Session["LoggedUser"] as Kullanici).Ad + " " + (Session["LoggedUser"] as Kullanici).Soyad;

                    lblToplamRezervasyon.Text = RezervasyonDB.toplamRezervasyonSayisi().ToString();

                    if (!IsPostBack)
                    {
                        if (Request.QueryString["ID"] != null)
                            if (Request.QueryString["Pid"] == "0")
                            {
                                RezervasyonDB.rezervasyonSilID(Convert.ToInt32(Request.QueryString["ID"]));
                            }
                    }

                    lvDoldur();
                }
            }
            catch { }
        }

        private void lvDoldur()
        {
            lstBugununSonRezervasyonlari.DataSource = RezervasyonDB.sonBesRezervasyonuGetir();
            lstBugununSonRezervasyonlari.DataBind();
        }
    }
}