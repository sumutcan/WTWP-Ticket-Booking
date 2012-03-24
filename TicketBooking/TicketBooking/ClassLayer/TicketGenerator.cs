using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TicketBooking.DataAccessLayer;

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
            b.SalonAdi = RezervasyonDB.salonAdiGetir(yeniRezervasyon.Seans.Salon.Id);
            b.KoltukAdi = RezervasyonDB.tekKoltukGetir(yeniRezervasyon.Koltuk.Id).ToString();
            b.Ucret = yeniRezervasyon.Ucret;
            

            return b;

        }
    }
}
