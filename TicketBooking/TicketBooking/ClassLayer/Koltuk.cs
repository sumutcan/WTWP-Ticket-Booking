using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TicketBooking.ClassLayer
{
    public class Koltuk
    {
        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        private char x;

        public char X
        {
            get { return x; }
            set { x = value; }
        }
        private int y;
        private int p;
        private char p_2;
        private int p_3;

        public Koltuk(int id, char x, int y)
        {
            // TODO: Complete member initialization
            this.id = id;
            this.x = x;
            this.y = y;
        }

        public int Y
        {
            get { return y; }
            set { y = value; }
        }


    }
}
