using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.ClassLayer;

namespace TicketBooking
{
    public partial class KullaniciYonetimi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<Kullanici> list = new List<Kullanici>();
            Kullanici k = new Kullanici();
            k.Id=3;
            list.Add(k);

            lstKullanicilar.DataSource = list;
            lstKullanicilar.DataBind();
        }
    }
}