using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using TicketBooking.DataAccessLayer;
using TicketBooking.ClassLayer;

namespace TicketBooking
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ArrayList salonlar = SalonDB.tumSalonlariCek();

            for (int i = 0; i < salonlar.Count; i++)
            {
                if((salonlar[i] as Salon).Aciklama == null)
                    (salonlar[i] as Salon).Aciklama = " ";
            }

                Repeater1.DataSource = salonlar;
            Repeater1.DataBind();
        }
    }
}