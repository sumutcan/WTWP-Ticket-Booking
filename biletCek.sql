USE [CINECLUP]
GO
/****** Object:  StoredProcedure [dbo].[GelecekFilmleriCek]    Script Date: 03/25/2012 04:45:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BiletCek]
@kullaniciID int

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
	REZERVASYON.Ucret
	
	from REZERVASYON, FILM, SALON, SEANS, KULLANICI, KOLTUK
	where REZERVASYON.Kullanıcı_ID = @kullaniciID and
	REZERVASYON.SatildiMi = 0 and
	REZERVASYON.Koltuk_ID = KOLTUK.Koltuk_ID and
	REZERVASYON.Seans_ID = SEANS.Seans_ID and
	SEANS.Salon_ID = SALON.Salon_ID and
	SEANS.Film_ID = FILM.FilmID
	
end
