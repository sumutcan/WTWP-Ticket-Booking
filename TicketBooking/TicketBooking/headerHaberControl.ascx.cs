using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.DataAccessLayer;
using TicketBooking.ClassLayer;

public partial class headerHaberControl : System.Web.UI.UserControl
{
    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Session["tema"] != null)
        {
            switch (Session["tema"].ToString())
            {
                case "Maroon":
                    Page.Theme = "Maroon";
                    break;
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Film gelecekProgram = FilmDB.gelecekProgramGetir();
        film.Text = gelecekProgram.FilmAdiTR;
        tarih.Text = gelecekProgram.VizyonTarihi.ToShortDateString();

    }
}