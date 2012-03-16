using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
            set { sifre = value; }
        }

    }
}