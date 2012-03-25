using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using TicketBooking.DataAccessLayer;

namespace TicketBooking.ClassLayer
{
    public class Salon
    {
        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }
        private int kapasite;

        public int Kapasite
        {
            get { return kapasite; }
            set { kapasite = value; }
        }
        private string ad;

        public string Ad
        {
            get { return ad; }
            set { ad = value; }
        }

        private string aciklama;


        public string Aciklama
        {
            get { return aciklama; }
            set { aciklama = value; }
        }


        private ArrayList bosKoltuklar;

        public ArrayList BosKoltuklar
        {
            get { return bosKoltuklar; }
            
        }

        public void bosKoltukEkle(Koltuk koltuk)
        {
            bosKoltuklar.Add(koltuk);
        }

        private Koltuk seciliKoltuk;

        public Koltuk SeciliKoltuk
        {
            get { return seciliKoltuk; }
            set { seciliKoltuk = value; }
        }


        public Salon(int id, string ad, int kapasite)
        {
            // TODO: Complete member initialization
            this.id = id;
            this.ad = ad;
            this.kapasite = kapasite;
        }

        public Salon(int id, string ad)
        {
            // TODO: Complete member initialization
            this.id = id;
            this.ad = ad;
        }

        public Salon()
        {
        }


        public ArrayList bosKoltuklariGetir(int seansID)
        {
            return RezervasyonDB.bosKoltuklariGetir(seansID, this.id);
        }

        public string eklenmeTarihi;

        public string EklenmeTarihi
        {
            get { return eklenmeTarihi; }
            set { eklenmeTarihi = value; }
        }
    }
}