using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TicketBooking.ClassLayer
{
    public class TicketGenerator
    {

        public Bilet biletOlustur(Rezervasyon yeniRezervasyon)
        {
            Bilet b = new Bilet();
            b.AdSoyad = yeniRezervasyon.Kullanici.ToString();
            b.RezervasyonID = yeniRezervasyon.Id;
            b.FilmAdi = yeniRezervasyon.Seans.Film.FilmAdiTR;
            b.Saat = yeniRezervasyon.Seans.Saat;
            b.SalonAdi = yeniRezervasyon.Seans.Salon.Ad;
            b.KoltukAdi = yeniRezervasyon.Koltuk.ToString();
            b.Ucret = yeniRezervasyon.Ucret;
            
            return b;

        }
    }
}
