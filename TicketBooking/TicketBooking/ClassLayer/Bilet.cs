using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TicketBooking.ClassLayer
{
    public class Bilet
    {


        public string AdSoyad { get { return adSoyad; } set { adSoyad = value ;} }

        public int RezervasyonID { get { return rezervasyonID; } set { rezervasyonID = value; } }

        public string FilmAdi { get { return filmAdi; } set { filmAdi = value; } }

        public TimeSpan Saat { get { return saat; } set { saat = value; } }

        public string SalonAdi { get { return salonAdi; } set { salonAdi = value; } }

        public string KoltukAdi { get { return koltukAdi; } set { koltukAdi = value; } }

        public double Ucret { get { return ucret; } set { ucret = value; } }

        public string Tarih { get { return tarih; } set { tarih = value; } }

        string adSoyad;
        int rezervasyonID;
        string filmAdi;
        TimeSpan saat;
        string salonAdi;
        string koltukAdi;
        double ucret;
        string tarih;

        
    }
}
