using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.ClassLayer;

public partial class loginControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoggedUser"] == null)
            multiviewLoginControl.ActiveViewIndex = 0;
        else
            multiviewLoginControl.ActiveViewIndex = 1;
    }

    protected void btnGirisYap_Click(object sender, EventArgs e)
    {
        Kullanici k = new Kullanici();
        k.Eposta = txtEPosta.Text;
        k.Sifre = txtSifre.Text;
        Session["LoggedUser"] = k.girisYap();

        multiviewLoginControl.ActiveViewIndex = 1;

        lblAdSoyad.Text = (Session["LoggedUser"] as Kullanici).AdSoyad;
        Response.Redirect("~/Default.aspx", false);

    }

    protected void lnkCikisYap_Click(object sender, EventArgs e)
    {
        Session["LoggedUser"] = null;
        multiviewLoginControl.ActiveViewIndex = 0;
        Response.Redirect("~/Default.aspx",false);
    }
}