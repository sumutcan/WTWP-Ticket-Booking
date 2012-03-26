using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.ClassLayer;

namespace TicketBooking.Admin
{
    public partial class AdminPanel : System.Web.UI.MasterPage
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
            }
            catch { }
        }
    }
}