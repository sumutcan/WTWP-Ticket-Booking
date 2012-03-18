using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace TicketBooking.ClassLayer
{
    public class Kullanici
    {
        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        private string adSoyad;

        public string AdSoyad
        {
            get { return adSoyad; }
            set { adSoyad = value; }
        }
        private string eposta;

        public string Eposta
        {
            get { return eposta; }
            set { eposta = value; }
        }
        private string sifre;

        public string Sifre
        {
            get { return sifre; }
            set { sifre =  FormsAuthentication.HashPasswordForStoringInConfigFile(value,"md5"); }
        }

        private bool tip;

        public bool Tip
        {
            get { return tip; }
            set { tip = value; }
        }
        public Kullanici girisYap()
        { 
            //buraya veritabanından kontrol komutları gelecek
            //hata olursa exception fırlat

            this.AdSoyad = "Umutcan Şimşek";
            this.Tip = false;
            
            return this;
        }
        public void sifremiUnuttum(string eposta)
        {
            string yeniSifre = FormsAuthentication.HashPasswordForStoringInConfigFile(DateTime.Now.Ticks.ToString(),"md5").Substring(0,6);

            //yenisifreyi veritabanına yolla eposta ile beraber. şayet epostaya ait kullanıcı varsa güncelle. yoksa hata döndür.
            
            string mesaj = "Aldığımız bir duyuma göre şifrenizi unutmuşsunuz.<p>"+
                            "Yeni şifreniz: "+yeniSifre+"<p>"+
                            "Broadway Sinemaları";

            Misc.getInstance().mailgonder(eposta,"Yeni şifre",mesaj);
        }

 


    }
}