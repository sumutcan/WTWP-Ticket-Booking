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
                film.FilmAdiEN = num.Current.Film_Adı;
                film.FilmAdiTR = num.Current.Film_Adı;
                film.YapimYili = num.Current.Yapım_Yılı.ToString();
                film.VizyonTarihi = num.Current.Ekleme_Tarihi;
                film.AfisURL = num.Current.Afis_URL;
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
                film.FilmAdiEN = num.Current.Film_Adı;
                film.FilmAdiTR = num.Current.Film_Adı;
                film.YapimYili = num.Current.Yapım_Yılı.ToString();
                film.VizyonTarihi = num.Current.Ekleme_Tarihi;
                film.AfisURL = num.Current.Afis_URL;
                tFilmler.Add(film);
            }

            return tFilmler;
        }

        public static Film gelecekProgramGetir()
        {
            GelecekProgramGetir_Result f = new DBConnection().ConnectDB.GelecekProgramGetir().First();
            return new Film(f.Film_Adı, f.Ekleme_Tarihi);
        }
    }
}