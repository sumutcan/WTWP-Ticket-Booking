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
        private int no;

        public int No
        {
            get { return no; }
            set { no = value; }
        }
        

    }
}