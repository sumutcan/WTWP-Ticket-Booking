using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.DataAccessLayer;

namespace TicketBooking.Admin
{
    public partial class RezervasyonYonetimi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
        private void lvDoldur()
        {
            lstRezervasyonlar.DataSource = RezervasyonDB.tumRezervasyonlariGetir();
            lstRezervasyonlar.DataBind();
        }
    }
}