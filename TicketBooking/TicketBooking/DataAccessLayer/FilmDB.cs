using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using DataLayer;
using TicketBooking.ClassLayer;
using System.Data.Objects;

namespace TicketBooking.DataAccessLayer
{
    public class FilmDB
    {

        public static ArrayList vizyondakiFilmleriCek()
        {
            DBConnection cn = new DBConnection();
            IEnumerator<FILM> num = cn.ConnectDB.VizyondakiFilmleriCek().GetEnumerator();

            ArrayList vFilmler = new ArrayList();

            while (num.MoveNext())
            {
                Film film = new Film();
                film.FilmAdiEN = num.Current.Film_Adı;
                film.FilmAdiTR = num.Current.Film_Adı;
                film.YapimYili = num.Current.Yapım_Yılı.ToString();
                film.VizyonTarihi = num.Current.Ekleme_Tarihi;
                film.AfisURL = num.Current.Afis_URL;
                film.BitisTarihi = num.Current.Bitis_Tarihi;
                film.AltDub = num.Current.A_D;
                film.GetD3 = num.Current.D3;
                film.GeldiMi = num.Current.GeldiMi;
                vFilmler.Add(film);
            }

            return vFilmler;
        }

        public static ArrayList gelecekFilmleriCek()
        {
            DBConnection cn = new DBConnection();
            IEnumerator<FILM> num = cn.ConnectDB.GelecekFilmleriCek().GetEnumerator();

            ArrayList gFilmler = new ArrayList();

            while (num.MoveNext())
            {
                Film film = new Film();
                film.Id = num.Current.FilmID;
                film.FilmAdiEN = num.Current.Film_Adı;
                film.FilmAdiTR = num.Current.Film_Adı;
                film.YapimYili = num.Current.Yapım_Yılı.ToString();
                film.VizyonTarihi = num.Current.Ekleme_Tarihi;
                film.AfisURL = num.Current.Afis_URL;
                film.BitisTarihi = num.Current.Bitis_Tarihi;
                film.AltDub = num.Current.A_D;
                film.GetD3 = num.Current.D3;
                film.GeldiMi = num.Current.GeldiMi;
                gFilmler.Add(film);
            }

            return gFilmler;
        }

        public static ArrayList tumFilmleriCek()
        {
            DBConnection cn = new DBConnection();
            IEnumerator<FILM> num = cn.ConnectDB.TumFilmleriCek().GetEnumerator();

            ArrayList tFilmler = new ArrayList();

            while (num.MoveNext())
            {
                Film film = new Film();
                film.Id = num.Current.FilmID;
                film.FilmAdiEN = num.Current.Film_Adı;
                film.FilmAdiTR = num.Current.Film_Adı;
                film.YapimYili = num.Current.Yapım_Yılı.ToString();
                film.VizyonTarihi = num.Current.Ekleme_Tarihi;
                film.AfisURL = num.Current.Afis_URL;
                film.BitisTarihi = num.Current.Bitis_Tarihi;
                film.AltDub = num.Current.A_D;
                film.GetD3 = num.Current.D3;
                film.GeldiMi = num.Current.GeldiMi;
                tFilmler.Add(film);
            }

            return tFilmler;
        }

        public static Film gelecekProgramGetir()
        {
            GelecekProgramGetir_Result f = new DBConnection().ConnectDB.GelecekProgramGetir().First();
            return new Film(f.Film_Adı, f.Ekleme_Tarihi);
        }

        public static void filmEkle(Film film)
        {
            DBConnection cn = new DBConnection();

            try
            {
                cn.ConnectDB.FilmEkle(film.FilmAdiEN, Convert.ToInt32(film.YapimYili), film.AltDub, film.GetD3, film.VizyonTarihi, film.BitisTarihi, film.AfisURL, film.GeldiMi);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void filmSil(int filmID)
        {
            DBConnection cn = new DBConnection();

            try
            {
                cn.ConnectDB.FilmSil(filmID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void filmGuncelle(Film film)
        {
            DBConnection cn = new DBConnection();

            try
            {
                cn.ConnectDB.FilmGuncelle(film.Id,film.FilmAdiEN, Convert.ToInt32(film.YapimYili), film.AltDub, film.GetD3, film.VizyonTarihi, film.BitisTarihi, film.AfisURL, film.GeldiMi);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void filmGeldi(int filmID)
        {
            DBConnection cn = new DBConnection();

            try
            {
                cn.ConnectDB.FilmGeldi(filmID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static ArrayList filmAra(int kriter,string veri)
        {
            DBConnection cn = new DBConnection();
            IEnumerator<FILM> num = cn.ConnectDB.FilmAra(kriter,veri).GetEnumerator();

            ArrayList aramaSonuclari = new ArrayList();

            while (num.MoveNext())
            {
                Film film = new Film();
                film.Id = num.Current.FilmID;
                film.FilmAdiEN = num.Current.Film_Adı;
                film.FilmAdiTR = num.Current.Film_Adı;
                film.YapimYili = num.Current.Yapım_Yılı.ToString();
                film.VizyonTarihi = num.Current.Ekleme_Tarihi;
                film.AfisURL = num.Current.Afis_URL;
                film.BitisTarihi = num.Current.Bitis_Tarihi;
                film.AltDub = num.Current.A_D;
                film.GetD3 = num.Current.D3;
                film.GeldiMi = num.Current.GeldiMi;
                aramaSonuclari.Add(film);
            }

            return aramaSonuclari;
        }

        public static ArrayList filmAraID(int filmID)
        {
            DBConnection cn = new DBConnection();
            IEnumerator<FILM> num = cn.ConnectDB.FilmAraID(filmID).GetEnumerator();

            ArrayList aramaSonuclari = new ArrayList();

            while (num.MoveNext())
            {
                Film film = new Film();
                film.Id = num.Current.FilmID;
                film.FilmAdiEN = num.Current.Film_Adı;
                film.FilmAdiTR = num.Current.Film_Adı;
                film.YapimYili = num.Current.Yapım_Yılı.ToString();
                film.VizyonTarihi = num.Current.Ekleme_Tarihi;
                film.AfisURL = num.Current.Afis_URL;
                film.BitisTarihi = num.Current.Bitis_Tarihi;
                film.AltDub = num.Current.A_D;
                film.GetD3 = num.Current.D3;
                film.GeldiMi = num.Current.GeldiMi;
                aramaSonuclari.Add(film);
            }

            return aramaSonuclari;
        }

        public static ArrayList filmAraGenel(string filmAdi)
        {
            DBConnection cn = new DBConnection();
            IEnumerator<FILM> num = cn.ConnectDB.FilmAraGenel(filmAdi).GetEnumerator();

            ArrayList aramaSonuclari = new ArrayList();

            while (num.MoveNext())
            {
                Film film = new Film();
                film.Id = num.Current.FilmID;
                film.FilmAdiEN = num.Current.Film_Adı;
                film.FilmAdiTR = num.Current.Film_Adı;
                film.YapimYili = num.Current.Yapım_Yılı.ToString();
                film.VizyonTarihi = num.Current.Ekleme_Tarihi;
                film.AfisURL = num.Current.Afis_URL;
                film.BitisTarihi = num.Current.Bitis_Tarihi;
                film.AltDub = num.Current.A_D;
                film.GetD3 = num.Current.D3;
                film.GeldiMi = num.Current.GeldiMi;
                aramaSonuclari.Add(film);
            }

            return aramaSonuclari;
        }
    }
}