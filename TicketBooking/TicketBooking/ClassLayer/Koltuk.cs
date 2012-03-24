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
        private int koltukID;

        public Koltuk(int id, char x, int y)
        {
            // TODO: Complete member initialization
            this.id = id;
            this.x = x;
            this.y = y;
        }

        public Koltuk(int koltukID)
        {
            // TODO: Complete member initialization
            this.koltukID = koltukID;
        }

        public int Y
        {
            get { return y; }
            set { y = value; }
        }

        public override string ToString()
        {
            return X + Y.ToString();
        }


    }
}
