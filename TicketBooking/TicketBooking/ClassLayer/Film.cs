using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using TicketBooking.DataAccessLayer;

namespace TicketBooking.ClassLayer
{
    public class Film
    {
        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }


        private string filmAdiTR;

        public string FilmAdiTR
        {
            get { return filmAdiTR; }
            set { filmAdiTR = value; }
        }
        private string filmAdiEN;

        public string FilmAdiEN
        {
            get { return filmAdiEN; }
            set { filmAdiEN = value; }
        }
        private FilmTuru tur;

        public FilmTuru Tur
        {
            get { return tur; }
            set { tur = value; }
        }
        private string yapimYili;

        public string YapimYili
        {
            get { return yapimYili; }
            set { yapimYili = value; }
        }
        private string ulke;

        public string Ulke
        {
            get { return ulke; }
            set { ulke = value; }
        }
        private string ozet;

        public string Ozet
        {
            get { return ozet; }
            set { ozet = value; }
        }
        private ArrayList oyuncular;

        public ArrayList Oyuncular
        {
            get { return oyuncular; }
        }

        public void  oyuncuEkle(string oyuncu)
        {
            oyuncular.Add(oyuncu);
        }

        private DateTime vizyonTarihi;


        private DateTime bitisTarihi;

        public DateTime BitisTarihi
        {
            get { return bitisTarihi; }
            set { bitisTarihi = value; }
        }

        public Film(int Id, string filmAdiTR)
        {
            // TODO: Complete member initialization
            this.FilmAdiTR = filmAdiTR;
            this.Id = Id;
        }

        public Film(int id, string ad, DateTime vizyonTarihi, DateTime bitisTarihi)
        {
            // TODO: Complete member initialization
            this.id = id;
            this.filmAdiTR = ad;
            this.vizyonTarihi = vizyonTarihi;
            this.bitisTarihi = bitisTarihi;
        }

        

        public Dictionary<int, Seans> tumSeanslariGetir()
        {
            Dictionary<int, Seans> tumSeanslar = new Dictionary<int, Seans>();

            foreach (FilminSeanslariniGoster_Result fsg in RezervasyonDB.filminSeanslariniGetir(this.id))
                tumSeanslar.Add(fsg.Seans_ID,new Seans(fsg.Seans_ID,fsg.Saat,new Salon(fsg.Salon_ID,fsg.Salon_Adı)));
            return tumSeanslar;
        }

        public DateTime VizyonTarihi
        {
            get { return vizyonTarihi; }
            set { vizyonTarihi = value; }
        }
    }
}