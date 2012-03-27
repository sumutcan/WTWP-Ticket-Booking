using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicketBooking.ClassLayer;
using TicketBooking.DataAccessLayer;
using System.Collections;

namespace TicketBooking.Admin
{
    public partial class SalonYonetimi : System.Web.UI.Page
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
                else
                {
                    if (!IsPostBack)
                    {

                        if (Request.QueryString["ID"] != null)
                            if (Request.QueryString["Pid"] == "0")
                            {
                                SalonDB.salonSil(Convert.ToInt32(Request.QueryString["ID"]));
                            }
                            else if (Request.QueryString["Pid"] == "1")
                            {
                                ArrayList salon = new ArrayList();
                                salon = SalonDB.salonAraID(Convert.ToInt32(Request.QueryString["ID"]));
                                Salon s = salon[0] as Salon;

                                txtFilmAdi.Text = s.Ad;
                                txtSatirSayisi.Enabled = false;
                                txtSutunSayisi.Enabled = false;
                                txtAciklama.Text = s.Aciklama;
                            }
                    }
                    lstSalonlar.Items.Clear();
                    lstSalonlar.DataSource = SalonDB.tumSalonlariCek();
                    lstSalonlar.DataBind();
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnSalonKaydet_Click(object sender, EventArgs e)
        {
            if (txtFilmAdi.Text == "")
            {
                Response.Write("<script>alert('Film adini doldurunuz!')</script>");
            }
            else
            {
                Salon s = new Salon();
                s.Id = Convert.ToInt32(Request.QueryString["ID"]);
                s.Ad = txtFilmAdi.Text;
                s.Aciklama = txtAciklama.Text + " ";

                if (Request.QueryString["Pid"] == "1")
                {
                    SalonDB.salonGuncelle(s);
                    Response.Redirect("SalonYonetimi.aspx");
                }
                else
                {
                    int satir = Convert.ToInt32(txtSatirSayisi.Text);
                    int sutun = Convert.ToInt32(txtSutunSayisi.Text);
                    s.Kapasite = satir * sutun;
                    int id = SalonDB.salonEkle(s);

                    for(int i=0;i<satir;i++)
                        for(int j=0;j<sutun;j++)
                        {
                            Koltuk k = new Koltuk(0,id,Convert.ToChar(i),j);
                            KoltukDB.koltukEkle(k);
                        }
                    
                }

                lstSalonlar.Items.Clear();
                lstSalonlar.DataSource = SalonDB.tumSalonlariCek();
                lstSalonlar.DataBind();
            }
        }
    }
}