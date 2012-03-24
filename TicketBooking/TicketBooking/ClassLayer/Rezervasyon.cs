using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using TicketBooking.DataAccessLayer;

namespace TicketBooking.ClassLayer
{
    public class Rezervasyon
    {

        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }
        
        Seans seans;

        public Seans Seans
        {
            get { return seans; }
            set { seans = value; }
        }
        DateTime rezervasyonTarihi;

        public DateTime RezervasyonTarihi
        {
            get { return rezervasyonTarihi; }
            set { rezervasyonTarihi = value; }
        }
        Kullanici kullanici;

        public Kullanici Kullanici
        {
            get { return kullanici; }
            set { kullanici = value; }
        }

        private int puan;

        public int Puan
        {
            get { return puan; }
        }

        public void puanHesapla()
        {
            puan = 10;
        }

        private Koltuk seciliKoltuk;
        private double ucret;

        public Koltuk Koltuk
        {
            get { return seciliKoltuk; }
            set { seciliKoltuk = value; }
        }

       



        public void koltukEkle (Koltuk k)
        {
            seciliKoltuk = k;
        }


        public void ucretlendir()
        {
            this.ucret = 10.0;

            if (seans.Film.GetD3)
                ucret += 3.0;

        }

        public double Ucret { get { return ucret; } }

        public void kaydet()
        {
            RezervasyonDB.rezervasyonEkle(this);
        }
    }
}