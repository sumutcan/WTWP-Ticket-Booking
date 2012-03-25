USE [CINECLUP]
GO
/****** Object:  StoredProcedure [dbo].[BiletCek]    Script Date: 03/25/2012 17:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BiletCek]
@kullaniciID int

AS
BEGIN
	SET NOCOUNT ON
	select TOP (5) REZERVASYON.Rez_ID, 
	Salon_Adı,
	SEANS.Saat,
	Satır_No,
	Sutun_No,
	KULLANICI.Ad,
	KULLANICI.Soyad,
	Film_Adı,
	REZERVASYON.Ucret
	
	from REZERVASYON, FILM, SALON, SEANS, KULLANICI, KOLTUK
	where REZERVASYON.Kullanıcı_ID = @kullaniciID and
	REZERVASYON.SatildiMi = 0 and
	REZERVASYON.Koltuk_ID = KOLTUK.Koltuk_ID and
	REZERVASYON.Seans_ID = SEANS.Seans_ID and
	SEANS.Salon_ID = SALON.Salon_ID and
	SEANS.Film_ID = FILM.FilmID
	
	ORDER BY REZERVASYON.Rez_ID DESC
end
