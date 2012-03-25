using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using TicketBooking.DataAccessLayer;

namespace TicketBooking
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ArrayList salonlar = SalonDB.tumSalonlariCek();

            Repeater1.DataSource = salonlar;
            Repeater1.DataBind();
        }
    }
}