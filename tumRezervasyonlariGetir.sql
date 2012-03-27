USE [CINECLUP]
GO
/****** Object:  StoredProcedure [dbo].[SonBesRezervasyonuGetir]    Script Date: 03/27/2012 02:23:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[TumRezervasyonlariGetir]
AS
BEGIN
	SET NOCOUNT ON
	select REZERVASYON.Rez_ID, 
	Salon_Adı,
	SEANS.Saat,
	Satır_No,
	Sutun_No,
	KULLANICI.Ad,
	KULLANICI.Soyad,
	Film_Adı,
	REZERVASYON.Ucret,
	REZERVASYON.Tarih

	from REZERVASYON, FILM, SALON, SEANS, KULLANICI, KOLTUK
	where
	REZERVASYON.SatildiMi = 0 and
	REZERVASYON.Koltuk_ID = KOLTUK.Koltuk_ID and
	REZERVASYON.Seans_ID = SEANS.Seans_ID and
	SEANS.Salon_ID = SALON.Salon_ID and
	SEANS.Film_ID = FILM.FilmID and
	REZERVASYON.Kullanıcı_ID = KULLANICI.Kullanici_ID

	ORDER BY REZERVASYON.Rez_ID DESC
end
