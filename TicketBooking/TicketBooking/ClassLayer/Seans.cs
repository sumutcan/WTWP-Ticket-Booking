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
        string h;

        public string H
        {
            get { return h; }
            set { h = value; }
        }
        string min;

        public string Min
        {
            get { return min; }
            set { min = value; }
        }

        public TimeSpan Saat
        {
            get { return saat; }
            set 
            { 
               saat = value;
               h = value.Hours.ToString("D2");
               min = value.Minutes.ToString("D2");
            }
        }
        Film film;

        
        

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
            salon = new Salon();
            film = new Film();
        }

        public void filmEkle(Film secilenFilm)
        {
            Film = secilenFilm;
        }
    }
}