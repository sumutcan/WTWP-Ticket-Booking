using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

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

        public DateTime VizyonTarihi
        {
            get { return vizyonTarihi; }
            set { vizyonTarihi = value; }
        }
    }
}