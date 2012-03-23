using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TicketBooking.ClassLayer
{
    public class Seans
    {

        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }
        
        Salon salon;

        public Salon Salon
        {
            get { return salon; }
            set { salon = value; }
        }
        

        string saat;

        public string Saat
        {
            get { return saat; }
            set { saat = value; }
        }
        Film film;

        public Film Film
        {
            get { return film; }
            set { film = value; }
        }



        public Seans(int id, string saat)
        {
            // TODO: Complete member initialization
            this.id = id;
            this.saat = saat;
        }

        public void filmEkle(Film secilenFilm)
        {
            Film = secilenFilm;
        }
    }
}