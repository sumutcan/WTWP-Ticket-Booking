using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.DataAccessLayer;
using System.Collections;
using TicketBooking.ClassLayer;

namespace TicketBooking
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ArrayList filmler = FilmDB.tumFilmleriCek();

                Repeater1.DataSource = filmler;
            Repeater1.DataBind();
        }
    }
}