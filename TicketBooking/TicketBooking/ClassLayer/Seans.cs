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
        

        TimeSpan saat;

        public TimeSpan Saat
        {
            get { return saat; }
            set { saat = value; }
        }
        Film film;
        private int p;
        
        

        public Film Film
        {
            get { return film; }
            set { film = value; }
        }



        public Seans(int id, TimeSpan saat)
        {
            // TODO: Complete member initialization
            this.id = id;
            this.saat = saat;
        }

        public Seans(int id, TimeSpan saat, Salon salon)
        {
            // TODO: Complete member initialization
            this.id = id;
            this.saat = saat;
            this.salon = salon;
        }

        public Seans(int id)
        {
            // TODO: Complete member initialization
            this.id = id;
        }

        public void filmEkle(Film secilenFilm)
        {
            Film = secilenFilm;
        }
    }
}