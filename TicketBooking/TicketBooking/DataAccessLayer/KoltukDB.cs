using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TicketBooking.ClassLayer;
using DataLayer;

namespace TicketBooking.DataAccessLayer
{
    public class KoltukDB
    {
        public static void koltukEkle(Koltuk k)
        {
            new DBConnection().ConnectDB.KoltukEkle(k.SalonID, k.X, k.Y, false);
        }
    }
}