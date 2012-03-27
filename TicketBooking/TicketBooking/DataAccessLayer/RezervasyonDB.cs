using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using TicketBooking.ClassLayer;
using DataLayer;
using System.Data.Objects;

namespace TicketBooking.DataAccessLayer
{
    public class RezervasyonDB
    {
        public static ArrayList bosKoltuklariGetir(int seansID, int salonID, DateTime secilenTarih)
        {
            ArrayList al = new ArrayList();

            foreach (KOLTUK koltuk in new DBConnection().ConnectDB.SeansaGoreBosKoltuklar(seansID,salonID,secilenTarih))
                al.Add(new Koltuk(koltuk.Koltuk_ID,Convert.ToChar(koltuk.Satır_No+64),koltuk.Sutun_No));
            return al;
        }
        public static Dictionary<int, Film> tumFilmleriGetir()
        {
            Dictionary<int, Film> dict = new Dictionary<int, Film>();
            foreach (FILM f in new DBConnection().ConnectDB.TumFilmleriCek())
                dict.Add(f.FilmID,new Film(f.FilmID,f.Film_Adı,f.D3,f.Ekleme_Tarihi,f.Bitis_Tarihi));

            return dict;
        }

        public static ObjectResult<FilminSeanslariniGoster_Result> filminSeanslariniGetir(int filmID)
        {
            return new DBConnection().ConnectDB.FilminSeanslariniGoster(filmID);
        }

        public static ArrayList saateGoreSalonGetir(TimeSpan saat, int filmID)
        {
            ArrayList al = new ArrayList();

            foreach (SALON salon in new DBConnection().ConnectDB.SaateGoreSalonlariGetir(saat,filmID))
                al.Add(new Salon(salon.Salon_ID,salon.Salon_Adı));
            
            return al;
        }

        public static int tekSeansGetir(int filmID, int salonID)
        {
            return Convert.ToInt32(new DBConnection().ConnectDB.TekSeansGetir(filmID,salonID).First());
        }

        public static int rezervasyonEkle(Rezervasyon rez)
        {
            return Convert.ToInt32 (new DBConnection().ConnectDB.RezervasyonEkle(rez.Kullanici.Id,rez.Seans.Id,rez.Koltuk.Id,rez.RezervasyonTarihi,rez.Ucret).First());
        }

        public static string salonAdiGetir(int salonID)
        {
            return new DBConnection().ConnectDB.TekSalonAdiGetir(salonID).First();
        }

        public static Koltuk tekKoltukGetir(int koltukID)
        {
            TekKoltukGetir_Result tekKoltuk = new DBConnection().ConnectDB.TekKoltukGetir(koltukID).First();
            
            return new Koltuk(koltukID,Convert.ToChar(tekKoltuk.Satır_No+64),tekKoltuk.Sutun_No);
        }

        public static ObjectResult<BiletCek_Result> biletleriGetir(int kullaniciID)
        {
            return new DBConnection().ConnectDB.BiletCek(kullaniciID);
        }

        public static int toplamRezervasyonSayisi()
        {
            return Convert.ToInt32( new DBConnection().ConnectDB.ToplamRezerveBiletSayisi().First());
        }

        public static ArrayList sonBesRezervasyonuGetir()
        {
            ArrayList al = new ArrayList();

            foreach (SonBesRezervasyonuGetir_Result sonBes in new DBConnection().ConnectDB.SonBesRezervasyonuGetir())
            {
                Bilet b1 = new Bilet();
                b1.AdSoyad = sonBes.Ad + " " + sonBes.Soyad;
                b1.FilmAdi = sonBes.Film_Adı;
                b1.KoltukAdi = Convert.ToChar(sonBes.Satır_No + 64).ToString() + sonBes.Sutun_No;
                b1.SalonAdi = sonBes.Salon_Adı;
                b1.Tarih = sonBes.Tarih.ToString().Substring(0, 10);
                b1.Saat = sonBes.Saat;
                b1.RezervasyonID = sonBes.Rez_ID;
                b1.Ucret = sonBes.Ucret;
                al.Add(b1);
            }

            return al;
        }

        public static void rezervasyonSilID(int rezID)
        {
            new DBConnection().ConnectDB.RezervasyonSilID(rezID);
        }

        public static object tumRezervasyonlariGetir()
        {
            ArrayList al = new ArrayList();

            foreach (TumRezervasyonlariGetir_Result sonBes in new DBConnection().ConnectDB.TumRezervasyonlariGetir())
            {
                Bilet b1 = new Bilet();
                b1.AdSoyad = sonBes.Ad + " " + sonBes.Soyad;
                b1.FilmAdi = sonBes.Film_Adı;
                b1.KoltukAdi = Convert.ToChar(sonBes.Satır_No + 64).ToString() + sonBes.Sutun_No;
                b1.SalonAdi = sonBes.Salon_Adı;
                b1.Tarih = sonBes.Tarih.ToString().Substring(0, 10);
                b1.Saat = sonBes.Saat;
                b1.RezervasyonID = sonBes.Rez_ID;
                b1.Ucret = sonBes.Ucret;
                al.Add(b1);
            }

            return al;
        }
    }
}