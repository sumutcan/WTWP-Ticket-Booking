using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using TicketBooking.DataAccessLayer;

namespace TicketBooking.ClassLayer
{
    public class RezervasyonHandler
    {
        Rezervasyon yeniRezervasyon;
        Film secilenFilm;
        TimeSpan secilenSaat;

        public TimeSpan SecilenSaat
        {
            get { return secilenSaat; }
            set { secilenSaat = value; }
        }

        public Film SecilenFilm
        {
            get { return secilenFilm; }
          
        }
        Seans secilenSeans;
        //DateTime secilenTarih;
        Salon secilenSalon;
        Dictionary<int,Film> tumFilmler;

        public RezervasyonHandler()
        {
            tumFilmler = RezervasyonDB.tumFilmleriGetir();
            
        }


        public void rezervasyonYarat()
        {
            if (yeniRezervasyon == null)
                yeniRezervasyon = new Rezervasyon();
        }

        public void filmYarat(int filmID)
        {
            if (tumFilmler.ContainsKey(filmID))
                secilenFilm = tumFilmler[filmID];
        }
        public void tarihBelirle(DateTime seciliTarih)
        {
            yeniRezervasyon.RezervasyonTarihi = seciliTarih;
        }

        public void seansBelirle(int id,TimeSpan saat)
        {
            yeniRezervasyon.Seans = new Seans(id,saat);
            yeniRezervasyon.Seans.filmEkle(secilenFilm);
        }

        public void salonBelirle(int id, string ad)
        {
            yeniRezervasyon.Seans.Salon = new Salon(id,ad);
            
        }
        public ArrayList boskoltuklariGetir()
        {
            return yeniRezervasyon.Seans.Salon.bosKoltuklariGetir(yeniRezervasyon.Seans.Id);
        }
        public Dictionary<int,Film> tumFilmleriGetir()
        {
            return tumFilmler;
        }
        public void saatBelirle(TimeSpan saat)
        {
            secilenSaat = saat;
        }


        public ArrayList saateGoreSalonGetir(TimeSpan saat)
        {
            return RezervasyonDB.saateGoreSalonGetir(saat);
        }
    }
}