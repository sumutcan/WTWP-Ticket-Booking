using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using TicketBooking.DataAccessLayer;
using TicketBooking.ClassLayer;

public partial class MasterUserPanel : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        vizyondakilerDoldur();
        gelecekDoldur();
    }

    public void vizyondakilerDoldur()
    {
        ArrayList vizyondakiler = new ArrayList();
        vizyondakiler = FilmDB.vizyondakiFilmleriCek();

        Image1.ImageUrl = (vizyondakiler[0] as Film).AfisURL;
        Image2.ImageUrl = (vizyondakiler[1] as Film).AfisURL;
        Image3.ImageUrl = (vizyondakiler[2] as Film).AfisURL;
        Image4.ImageUrl = (vizyondakiler[3] as Film).AfisURL;
    }

    public void gelecekDoldur()
    {
        ArrayList gelecek = new ArrayList();
        gelecek = FilmDB.gelecekFilmleriCek();

        Image5.ImageUrl = (gelecek[0] as Film).AfisURL;
        Image6.ImageUrl = (gelecek[1] as Film).AfisURL;
        Image7.ImageUrl = (gelecek[2] as Film).AfisURL;
        Image8.ImageUrl = (gelecek[3] as Film).AfisURL;
    }
}
