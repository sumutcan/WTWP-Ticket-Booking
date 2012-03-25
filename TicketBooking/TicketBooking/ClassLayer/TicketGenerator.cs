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
            b.Tarih = yeniRezervasyon.RezervasyonTarihi.ToShortDateString();
            b.Ucret = yeniRezervasyon.Ucret;
            

            return b;

        }

        public List<Bilet> biletOlustur(int kullaniciID)
        {
            List<Bilet> biletler = new List<Bilet>();

            foreach (BiletCek_Result b in RezervasyonDB.biletleriGetir(kullaniciID))
            {
                Bilet bil = new Bilet();
                bil.AdSoyad = b.Ad + " " + b.Soyad;
                bil.FilmAdi = b.Film_Adı;
                bil.KoltukAdi = new Koltuk(0,Convert.ToChar(64+b.Satır_No),b.Sutun_No).ToString();
                bil.RezervasyonID = b.Rez_ID;
                bil.Saat = b.Saat;
                bil.SalonAdi = b.Salon_Adı;
                bil.Tarih = b.Tarih.ToShortDateString();
                bil.Ucret = b.Ucret;

                biletler.Add(bil);
                
            }
            
            return biletler;
        }
    }
}
