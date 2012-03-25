using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TicketBooking.Admin
{
    public partial class FilmYonetimi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtAfisURL_TextChanged(object sender, EventArgs e)
        {
            imgFilmAfisi.ImageUrl = "http://ia.media-imdb.com/images/M/MV5BMzg2NTc5OTUwOF5BMl5BanBnXkFtZTYwNDA1NDY2._V1._SY317_CR1,0,214,317_.jpg";
        }
    }
}