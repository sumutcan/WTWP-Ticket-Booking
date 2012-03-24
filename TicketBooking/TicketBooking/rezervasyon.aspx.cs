using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.ClassLayer;
using System.Collections;

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
                    if (!IsPostBack)
                    {
                        Session["RezervasyonHandler"] = new RezervasyonHandler();
                    }
                        
                    
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

        }

        //protected void calenderTarih_SelectionChanged(object sender, EventArgs e)
        //{
        //    lblSeciliTarih.Text = calenderTarih.SelectedDate.ToShortDateString();
        //}

        protected void wizardRezervasyon_NextButtonClick(object sender, WizardNavigationEventArgs e)
        {


            try
            {
                if (Session["RezervasyonHandler"] != null)
                {
                    RezervasyonHandler rHandler = Session["RezervasyonHandler"] as RezervasyonHandler;

                    //tum filmleri cek
                    Dictionary<int, Film> tumFilmler = rHandler.tumFilmleriGetir();
                    ddlFilmler.Items.Clear();
                    foreach (int k in tumFilmler.Keys)
                    {
                        ddlFilmler.Items.Add(new ListItem(tumFilmler[k].FilmAdiTR, tumFilmler[k].Id.ToString()));
                    }
                    
                    //filminTumSeanslarınıCek
                    switch (wizardRezervasyon.ActiveStepIndex)
                    {
                        case 0:
                            rHandler.rezervasyonYarat();
                            break;
                        case 1:
                            rHandler.filmYarat(Convert.ToInt32(ddlFilmler.SelectedValue));
                            calenderTarih.StartDate = rHandler.SecilenFilm.VizyonTarihi;
                            calenderTarih.EndDate = rHandler.SecilenFilm.BitisTarihi;
                            calenderTarih.SelectedDate = DateTime.Now;
                            break;
                        case 2:
                            
                            if (calenderTarih.SelectedDate < rHandler.SecilenFilm.VizyonTarihi || calenderTarih.SelectedDate > rHandler.SecilenFilm.BitisTarihi)
                            {
                                e.Cancel = true;
                                throw new Exception("Seçtiğiniz tarihte film gösterimde değil.");
                            }

                            rHandler.tarihBelirle(Convert.ToDateTime(calenderTarih.SelectedDate));
                            
                            //filmin seanslarini cek

                            ArrayList tumSaatler = rHandler.SecilenFilm.tumSaatleriGetir();
                            
                            ddlSeanslar.Items.Clear();
                            foreach (TimeSpan saat in tumSaatler)
                                ddlSeanslar.Items.Add(saat.ToString());

                            break;
                        case 3:
                            rHandler.saatBelirle(TimeSpan.Parse(ddlSeanslar.SelectedItem.Text));
                            ddlBosKoltuklar.Items.Clear();
                            
                            ddlSalonlar.Items.Clear();
                            //en üste boş kayıt ekle
                            ddlSalonlar.Items.Add("Salon Seçiniz");
                            foreach (Salon s in rHandler.saateGoreSalonGetir(rHandler.SecilenSaat))
                                ddlSalonlar.Items.Add(new ListItem(s.Ad,s.Id.ToString()));

                            break;
                        case 4:
                            rHandler.seansOlustur();
                            rHandler.koltukRezerveEt(Convert.ToInt32(ddlBosKoltuklar.SelectedValue));
                            break;
                        
                    }

                    Session["RezervasyonHandler"] = rHandler;
                }
            }
            catch (Exception ex)
            {
                pnlHata.Visible = true;
                spanHata.InnerHtml = ex.Message;
                
            }
        }

        protected void wizardRezervasyon_ActiveStepChanged(object sender, EventArgs e)
        {
            
        }

        protected void ddlSalonlar_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlBosKoltuklar.Items.Clear();
            if (ddlSalonlar.SelectedIndex != 0)
            {

                RezervasyonHandler rHandler = Session["RezervasyonHandler"] as RezervasyonHandler;

                rHandler.salonBelirle(Convert.ToInt32(ddlSalonlar.SelectedValue), ddlSalonlar.SelectedItem.Text);

                ArrayList bosKoltuklar = rHandler.boskoltuklariGetir();
                
                if (bosKoltuklar != null)
                {
                    foreach (Koltuk k in bosKoltuklar)
                        ddlBosKoltuklar.Items.Add(new ListItem(k.ToString(), k.Id.ToString()));
                }
            }

        }

        protected void SideBarList_ItemDataBound(object sender, EventArgs e)
        { 
        
        }       
    }
}