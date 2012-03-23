using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace TicketBooking.ClassLayer
{
    public class RezervasyonHandler
    {
        Rezervasyon yeniRezervasyon;
        Film secilenFilm;
        Seans secilenSeans;
        //DateTime secilenTarih;
        Salon secilenSalon;

        public RezervasyonHandler()
        {
            
        }


        public void rezervasyonYarat()
        {
            if (yeniRezervasyon == null)
                yeniRezervasyon = new Rezervasyon();
        }

        public void filmYarat(int filmID, string filmAdiTR)
        {
            if (secilenFilm == null)
                secilenFilm =  new Film(filmID,filmAdiTR);
        }
        public void tarihBelirle(DateTime seciliTarih)
        {
            yeniRezervasyon.RezervasyonTarihi = seciliTarih;
        }

        public void seansBelirle(int id, string saat)
        {
            yeniRezervasyon.Seans = new Seans(id,saat);
            yeniRezervasyon.Seans.filmEkle(secilenFilm);
        }

        public ArrayList salonBelirle(int id, string ad)
        {
            yeniRezervasyon.Seans.Salon = new Salon(id,ad);
            return yeniRezervasyon.Seans.Salon.bosKoltuklariGetir(yeniRezervasyon.Seans.Id);
        }
    }
}