using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using TicketBooking.DataAccessLayer;

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

        private string ad;

        public string Ad
        {
            get { return ad; }
            set { ad = value; }
        }

        private string soyad;

        public string Soyad
        {
            get { return soyad; }
            set { soyad = value; }
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
            return KullaniciDB.GirisSorgula(this.eposta, this.sifre);
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

        public string Kaydol()
        {
            return KullaniciDB.KullaniciEkle(this);
        }
 


    }
}