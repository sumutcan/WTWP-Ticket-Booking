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
                    if (!IsPostBack)
                        Session["RezervasyonHandler"] = new RezervasyonHandler();
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

        protected void calenderTarih_SelectionChanged(object sender, EventArgs e)
        {
            lblSeciliTarih.Text = calenderTarih.SelectedDate.ToShortDateString();
        }

        protected void wizardRezervasyon_NextButtonClick(object sender, WizardNavigationEventArgs e)
        {

        }

        protected void wizardRezervasyon_ActiveStepChanged(object sender, EventArgs e)
        {
            RezervasyonHandler rHandler = Session["RezervasyonHandler"] as RezervasyonHandler;
            switch (wizardRezervasyon.ActiveStepIndex)
            { 
                case 0:
                    rHandler.rezervasyonYarat();
                    break;
                case 1:
                    rHandler.filmYarat(Convert.ToInt32(ddlFilmler.SelectedValue),ddlFilmler.SelectedItem.Text); 
                    break;
                case 2:
                    rHandler.tarihBelirle(calenderTarih.SelectedDate);
                    break;
                case 3:
                    rHandler.seansBelirle(Convert.ToInt32(ddlSeanslar.SelectedValue),ddlSeanslar.SelectedItem.Text);
                    break;
                case 4:
                    rHandler.salonBelirle(Convert.ToInt32(ddlSalonlar.SelectedValue),ddlSalonlar.SelectedItem.Text);
                    break;

            }

            Session["RezervasyonHandler"] = rHandler;
        }
    }
}