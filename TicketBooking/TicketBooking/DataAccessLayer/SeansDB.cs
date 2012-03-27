using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DataLayer;
using System.Collections;
using TicketBooking.ClassLayer;

namespace TicketBooking.DataAccessLayer
{
    public class SeansDB
    {
        public static void seansSil(int ID)
        {
            DBConnection db = new DBConnection();
            db.ConnectDB.SeansSil(ID);
            db.ConnectDB.SaveChanges();
        }

        public static ArrayList tumSeanslariCek()
        {
            ArrayList al = new ArrayList();
            foreach(TumSeanslariCek_Result seans in new DBConnection().ConnectDB.TumSeanslariCek())
            {
                Seans s = new Seans(seans.Seans_ID);
                
                s.Film.FilmAdiTR = seans.Film_Adı;
                s.Salon.Ad = seans.Salon_Adı;
                s.Saat = seans.Saat;
                
                al.Add(s);
            }
            return al;
        }

        public static Seans tekSeansCek(int seansID)
        {
            TekSeansCek_Result seans = new DBConnection().ConnectDB.TekSeansCek(seansID).First();
            Seans s = new Seans(seansID);
            s.Film.Id = seans.FilmID;
            s.Salon.Id = seans.Salon_ID;
            s.Saat = seans.Saat;

            return s;
        }
    }
}