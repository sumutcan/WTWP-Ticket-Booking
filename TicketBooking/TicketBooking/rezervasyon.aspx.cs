using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.ClassLayer;

namespace TicketBooking
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["LoggedUser"] == null)
                    throw new Exception("Bu işlem için önce giriş yapmalısınız.");
                else
                { 
                    
                }
            }
            catch (Exception ex)
            {
                pnlHata.Visible = true;
                spanHata.InnerHtml = ex.Message;
                wizardRezervasyon.Enabled = false;
            }
        }

        protected void wizardRezervasyon_FinishButtonClick(object sender, WizardNavigationEventArgs e)
        {
            Rezervasyon yeniRezarvasyon = new Rezervasyon();
            Seans yeniSeans = new Seans();

            yeniSeans.Tarih = DateTime.Parse("23.04.2011");
            yeniSeans.Saat = "15:00";
            yeniSeans.Film = new Film(1,"The Artist");
            yeniSeans.Salon = new Salon(1,"ad",50); 
            
            yeniRezarvasyon.Seans = yeniSeans;
            yeniRezarvasyon.Kullanici = Session["LoggedUser"] as Kullanici;
            yeniRezarvasyon.koltukEkle(new Koltuk(1, 'A', 5));
            yeniRezarvasyon.RezervasyonTarihi = DateTime.Now;
            yeniRezarvasyon.puanHesapla();

        }
    }
}