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
        TicketGenerator tGenerator;
        Bilet bilet;

        public Bilet Bilet
        {
            get { return bilet; }
            set { bilet = value; }
        }


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
            tGenerator = new TicketGenerator();
            
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

        public void seansOlustur()
        {
            yeniRezervasyon.Seans = secilenSeans;
            yeniRezervasyon.Seans.filmEkle(secilenFilm);
            yeniRezervasyon.Seans.Salon = secilenSalon;
        }

        public void salonBelirle(int id, string ad)
        {
            secilenSalon = new Salon(id,ad);
            
        }
        public ArrayList boskoltuklariGetir()
        {
            secilenSeans = new Seans(RezervasyonDB.tekSeansGetir(secilenFilm.Id,secilenSalon.Id));
            secilenSeans.Saat = secilenSaat;
         
            return secilenSalon.bosKoltuklariGetir(secilenSeans.Id,yeniRezervasyon.RezervasyonTarihi);
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
            return RezervasyonDB.saateGoreSalonGetir(saat,secilenFilm.Id);
        }

        public void koltukRezerveEt(int koltukID)
        {
            yeniRezervasyon.koltukEkle(new Koltuk(koltukID));
        }

        public string ucretBelirle()
        {
            yeniRezervasyon.ucretlendir();
            return yeniRezervasyon.Ucret.ToString();

        }

        public void biletOlustur()
        {
            bilet = tGenerator.biletOlustur(yeniRezervasyon);
        }

        public void rezervasyonuBitir(Kullanici kullanici)
        {
            yeniRezervasyon.Kullanici = kullanici;
            yeniRezervasyon.kaydet();
        }

        public Rezervasyon Rezervasyon { get { return yeniRezervasyon; } }

        public List<Bilet> sonBiletleriGetir(int kullaniciID)
        {
            return tGenerator.biletOlustur(kullaniciID);
        }
    }
}