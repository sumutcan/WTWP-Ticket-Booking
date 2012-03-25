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
    }
}