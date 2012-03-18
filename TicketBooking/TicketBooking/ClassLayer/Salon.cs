using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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

        public Salon(int id, string ad, int kapasite)
        {
            // TODO: Complete member initialization
            this.id = id;
            this.ad = ad;
            this.kapasite = kapasite;
        }
    }
}