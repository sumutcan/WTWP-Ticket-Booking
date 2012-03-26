using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using DataLayer;
using TicketBooking.ClassLayer;

namespace TicketBooking.DataAccessLayer
{
    public class KullaniciDB
    {

        public static ArrayList TumKullanicilariCek()
        {
            DBConnection cn = new DBConnection();
            IEnumerator<KULLANICI> num = cn.ConnectDB.TumKullanicilariCek().GetEnumerator();

            ArrayList kullanicilar = new ArrayList();

            while (num.MoveNext())
            {
                Kullanici kullanici = new Kullanici();
                kullanici.Id = num.Current.Kullanici_ID;
                kullanici.Ad = num.Current.Ad;
                kullanici.Soyad = num.Current.Soyad;
                kullanici.Sifre = num.Current.Sifre;
                kullanici.Tip = num.Current.Kullanici_Tipi;
                kullanici.Eposta = num.Current.Eposta;
                kullanicilar.Add(kullanici);
            }

            return kullanicilar;
        }

        public static Kullanici GirisSorgula(string eposta, string sifre)
        {
            DBConnection cn = new DBConnection();
            IEnumerator<KULLANICI> num = cn.ConnectDB.KullaniciSorgula(eposta, sifre).GetEnumerator();

            ArrayList kullanicilar = new ArrayList();

            while (num.MoveNext())
            {
                Kullanici kullanici = new Kullanici();
                kullanici.Id = num.Current.Kullanici_ID;
                kullanici.Ad = num.Current.Ad;
                kullanici.Soyad = num.Current.Soyad;
                kullanici.Sifre = num.Current.Sifre;
                kullanici.Tip = num.Current.Kullanici_Tipi;
                kullanici.Eposta = num.Current.Eposta;
                kullanicilar.Add(kullanici);
            }

            if (kullanicilar.Count == 0)
                return null;

            Kullanici k = kullanicilar[0] as Kullanici;
            return k;
        }

        public static string KullaniciEkle(Kullanici k)
        {
            DBConnection cn = new DBConnection();

            try
            {
                cn.ConnectDB.KullaniciEkle(k.Tip, k.Eposta, k.Sifre, k.Ad, k.Soyad);
                cn.ConnectDB.SaveChanges();
            }
            catch (Exception e)
            {
                return e.Message.ToString();
            }

            return "Sisteme kaydınız yapılmıştır.";
        }

        public static string KullaniciSil(int kID)
        {
            DBConnection cn = new DBConnection();

            try
            {
                cn.ConnectDB.KullaniciSil(kID);
                cn.ConnectDB.SaveChanges();
            }
            catch (Exception e)
            {
                return e.Message.ToString();
            }

            return kID +" id'li kullanıcı sistemden tamamen silinmiştir.";
        }

        public static string KullaniciGuncelle(int kID,bool tip,string ad,string soyad,string eposta,string sifre)
        {
            DBConnection cn = new DBConnection();

            try
            {
                cn.ConnectDB.KullaniciGuncelle(kID, tip, ad, soyad, eposta, sifre);
                cn.ConnectDB.SaveChanges();
            }
            catch (Exception e)
            {
                return e.Message.ToString();
            }

            return "Güncelleme işlemi başarıyla gerçekleşti.";
        }

        public static ArrayList kullaniciAra(int id)
        {
            ArrayList kullanicilar = new ArrayList();
            try
            {
                DBConnection cn = new DBConnection();
                IEnumerator<KULLANICI> num = cn.ConnectDB.KullaniciAra(0, id.ToString()).GetEnumerator();

                

                while (num.MoveNext())
                {
                    Kullanici kullanici = new Kullanici();
                    kullanici.Id = num.Current.Kullanici_ID;
                    kullanici.Ad = num.Current.Ad;
                    kullanici.Soyad = num.Current.Soyad;
                    kullanici.Sifre = num.Current.Sifre;
                    kullanici.Tip = num.Current.Kullanici_Tipi;
                    kullanici.Eposta = num.Current.Eposta;
                    kullanicilar.Add(kullanici);
                }

                
            }
            catch 
            { 
                
            }
            return kullanicilar;
            
        }

        public static ArrayList kullaniciAraGenel(string s)
        {
            DBConnection cn = new DBConnection();
            IEnumerator<KULLANICI> num = cn.ConnectDB.KullaniciAraGenel(s).GetEnumerator();

            ArrayList kullanicilar = new ArrayList();
            try
            {
                while (num.MoveNext())
                {
                    Kullanici kullanici = new Kullanici();
                    kullanici.Id = num.Current.Kullanici_ID;
                    kullanici.Ad = num.Current.Ad;
                    kullanici.Soyad = num.Current.Soyad;
                    kullanici.Sifre = num.Current.Sifre;
                    kullanici.Tip = num.Current.Kullanici_Tipi;
                    kullanici.Eposta = num.Current.Eposta;
                    kullanicilar.Add(kullanici);
                }
            }
            catch (Exception ex)
            {

            }

            return kullanicilar;
        }


        public static void SifreSifirla(string eposta, string sifre)
        {
            DBConnection db = new DBConnection();
            db.ConnectDB.KullaniciSifreSifirla(eposta, sifre);
        }
    }
}