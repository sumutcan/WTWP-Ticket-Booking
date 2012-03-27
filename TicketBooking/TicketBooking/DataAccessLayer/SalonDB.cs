using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using DataLayer;
using TicketBooking.ClassLayer;

namespace TicketBooking.DataAccessLayer
{
    public class SalonDB
    {
        public static ArrayList tumSalonlariCek()
        {
            DBConnection cn = new DBConnection();
            IEnumerator<SALON> num = cn.ConnectDB.TumSalonlariCek().GetEnumerator();

            ArrayList tSalonlar = new ArrayList();

            while (num.MoveNext())
            {
                Salon salon = new Salon();
                salon.Id = num.Current.Salon_ID;
                salon.Ad = num.Current.Salon_Adı;
                salon.Kapasite = num.Current.Kapasite;
                salon.Aciklama = num.Current.Açıklama;
                salon.EklenmeTarihi = num.Current.Eklenme_Tarihi.ToString();
                tSalonlar.Add(salon);
            }

            return tSalonlar;
        }

        public static void salonSil(int salonID)
        {
            try
            {
                DBConnection cn = new DBConnection();
                cn.ConnectDB.SalonSil(salonID);
            }
            catch { }
        }

        public static ArrayList salonAraID(int salonID)
        {
                DBConnection cn = new DBConnection();
                IEnumerator<SALON> num = cn.ConnectDB.SalonAra(0,salonID.ToString()).GetEnumerator();

                ArrayList aSalonlar = new ArrayList();
                try
            {
                while (num.MoveNext())
                {
                    Salon salon = new Salon();
                    salon.Id = num.Current.Salon_ID;
                    salon.Ad = num.Current.Salon_Adı;
                    salon.Kapasite = num.Current.Kapasite;
                    salon.Aciklama = num.Current.Açıklama;
                    salon.EklenmeTarihi = num.Current.Eklenme_Tarihi.ToString();
                    aSalonlar.Add(salon);
                }
            }
            catch { }

                return aSalonlar;
        }

        public static void salonGuncelle(Salon s)
        {
            ArrayList al = new ArrayList();
            al = salonAraID(s.Id);
            s.Kapasite = (al[0] as Salon).Kapasite;
            new DBConnection().ConnectDB.SalonGuncelle(s.Id,s.Ad,s.Kapasite,s.Aciklama);
        }

        public static int salonEkle(Salon s)
        {
            return Convert.ToInt32(new DBConnection().ConnectDB.SalonEkle(s.Ad, s.Kapasite, s.Aciklama).First());
        }
    }
}