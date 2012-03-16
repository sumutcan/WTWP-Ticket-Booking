using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace TicketBooking.ClassLayer
{
    public class Rezervasyon
    {

        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }
        
        Seans seans;

        public Seans Seans
        {
            get { return seans; }
            set { seans = value; }
        }
        DateTime rezervasyonTarihi;

        public DateTime RezervasyonTarihi
        {
            get { return rezervasyonTarihi; }
            set { rezervasyonTarihi = value; }
        }
        Kullanici kullanici;

        public Kullanici Kullanici
        {
            get { return kullanici; }
            set { kullanici = value; }
        }
        ArrayList koltuklar;

        public ArrayList Koltuklar
        {
            get { return koltuklar; }
            
        }

        public void koltukEkle (Koltuk k)
        {
            koltuklar.Add(k);
        }

    }
}