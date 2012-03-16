using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TicketBooking.ClassLayer
{
    public class FilmTuru
    {
        int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }
        string turAdi;

        public string TurAdi
        {
            get { return turAdi; }
            set { turAdi = value; }
        }
        
    }
}