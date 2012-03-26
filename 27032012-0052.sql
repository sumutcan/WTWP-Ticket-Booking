USE [CINECLUP]
GO
/****** Object:  StoredProcedure [dbo].[FilmSil]    Script Date: 03/27/2012 00:53:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FilmSil] 
	@filmID int
AS
BEGIN
		SET NOCOUNT ON;
	
		if not exists (select * from FILM where @filmID = FilmID)
		begin 
		RAISERROR ('Aranan IDye sahip bir film bulunamadı.',12,1)
		end
		else begin
		delete from FILM where @filmID = FilmID
		end
END
GO
/****** Object:  StoredProcedure [dbo].[FilmGuncelle]    Script Date: 03/27/2012 00:53:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FilmGuncelle] 
	@filmID int,
	@filmAdi nvarchar(50),
	@yapimYili int,
	@a_d bit,
	@d3 bit,
	@eklemeTarihi date,
	@bitisTarihi date,
	@afisURL nvarchar(max),
	@geldiMi bit
AS
BEGIN
		SET NOCOUNT ON;
	
		if not exists (select * from FILM where @filmID = FilmID)
		begin 
		RAISERROR ('Aranan IDye sahip bir film bulunamadı.',12,1)
		end
		else begin
		update FILM set Film_Adı = @filmAdi,Yapım_Yılı = @yapimYili,A_D = @a_d,D3 = @d3,Ekleme_Tarihi = @eklemeTarihi,Bitis_Tarihi = @bitisTarihi,Afis_URL = @afisURL,GeldiMi = @geldiMi
		where @filmID = FilmID
		end
END
GO
/****** Object:  StoredProcedure [dbo].[FilmGeldi]    Script Date: 03/27/2012 00:53:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[FilmGeldi] 
	@filmID int
AS
BEGIN
		SET NOCOUNT ON;
	
		if not exists (select * from FILM where @filmID = FilmID)
		begin 
		RAISERROR ('Bu IDye sahip film bulunmamaktadır!',12,1)
		end
		else begin
		update FILM set GeldiMi = 'true' where @filmID = FilmID
		end
END
GO
/****** Object:  StoredProcedure [dbo].[FilmEkle]    Script Date: 03/27/2012 00:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FilmEkle] 
	@filmAdi nvarchar(50),
	@yapimYili int,
	@a_d bit,
	@d3 bit,
	@eklemeTarihi date,
	@bitisTarihi date,
	@afisURL nvarchar(max),
	@geldiMi bit
AS
BEGIN
		SET NOCOUNT ON;
	
		if exists (select * from FILM where @filmAdi = Film_Adı and @yapimYili = Yapım_Yılı)
		begin 
		RAISERROR ('Bu mail adresi ile kayıtlı başka bir kullanıcı bulunmaktadır!',12,1)
		end
		else begin
		insert into FILM values (@filmAdi,@yapimYili,@a_d,@d3,@eklemeTarihi,@bitisTarihi,@afisURL,@geldiMi)
		end
END
GO
/****** Object:  StoredProcedure [dbo].[FilmAra]    Script Date: 03/27/2012 00:53:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[FilmAra]
	@islem_turu int,
	@parametre nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	if(@islem_turu = 0)
	begin
		if not exists (select * from FILM where FILM.FilmID = CONVERT(int,@parametre))		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,12)
		end
		else begin
		select * from FILM where FILM.FilmID = CONVERT(int,@parametre)
		end
	end
	else if(@islem_turu = 1)
	begin
		if not exists (select * from FILM where FILM.Film_Adı like '%'+@parametre+'%')		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,12)
		end
		else begin
		select * from FILM where FILM.Film_Adı like '%'+@parametre+'%'
		end
	end
	else if(@islem_turu = 2)
	begin
		if not exists (select * from FILM where FILM.Yapım_Yılı = CONVERT(int,@parametre))		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,12)
		end
		else begin
		select * from FILM where FILM.Yapım_Yılı = CONVERT(int,@parametre)	
		end
	end
	else if(@islem_turu = 3)
	begin
		if not exists (select * from FILM where FILM.A_D = CONVERT(bit,@parametre) )		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,12)
		end
		else begin
		select * from FILM where FILM.A_D = CONVERT(bit,@parametre)
		end
	end
	else if(@islem_turu = 4)
	begin
		if not exists (select * from FILM where FILM.D3 = CONVERT(bit,@parametre) )		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,12)
		end
		else begin
		select * from FILM where FILM.D3 = CONVERT(bit,@parametre)
		end
	end
	else if(@islem_turu = 5)
	begin
		if not exists (select * from FILM where FILM.Ekleme_Tarihi = CONVERT(date,@parametre) )		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,12)
		end
		else begin
		select * from FILM where FILM.Ekleme_Tarihi = CONVERT(date,@parametre) 	
		end
	end
	else if(@islem_turu = 6)
	begin
		if not exists (select * from FILM where FILM.Bitis_Tarihi = CONVERT(date,@parametre) )		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,12)
		end
		else begin
		select * from FILM where FILM.Bitis_Tarihi = CONVERT(date,@parametre) 	
		end
	end
	else if(@islem_turu = 7)
	begin
		if not exists (select * from FILM where FILM.GeldiMi = CONVERT(bit,@parametre) )		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,12)
		end
		else begin
		select * from FILM where FILM.GeldiMi = CONVERT(bit,@parametre)
		end
	end
end
GO
/****** Object:  StoredProcedure [dbo].[KullaniciAraGenel]    Script Date: 03/27/2012 00:53:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KullaniciAraGenel]
	@parametre nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	begin
		select distinct * from KULLANICI where 
		KULLANICI.Eposta like '%' + @parametre +'%' or KULLANICI.Ad like '%' + @parametre +'%'
		or KULLANICI.Soyad like '%' + @parametre +'%'
	end
end
GO
/****** Object:  StoredProcedure [dbo].[KullaniciAra]    Script Date: 03/27/2012 00:53:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KullaniciAra]
	@islem_turu int,
	@parametre nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	if(@islem_turu = 0)
	begin
		if not exists (select * from KULLANICI where KULLANICI.Kullanici_ID = CONVERT(int,@parametre))		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,10)
		end
		else begin
		select distinct * from KULLANICI where KULLANICI.Kullanici_ID = CONVERT(int,@parametre) or KULLANICI.Kullanici_Tipi = CONVERT(int,@parametre)
		or KULLANICI.Eposta like '%' + @parametre +'%' or KULLANICI.Kayit_Tarihi = CONVERT(date,@parametre) or KULLANICI.Ad like '%' + @parametre +'%'
		or KULLANICI.Soyad like '%' + @parametre +'%'
		end
	end
	else if(@islem_turu = 1)
	begin
		if not exists (select * from KULLANICI where KULLANICI.Kullanici_Tipi = CONVERT(int,@parametre))		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,10)
		end
		else begin
		select * from KULLANICI where KULLANICI.Kullanici_Tipi = CONVERT(int,@parametre)
		end
	end
	else if(@islem_turu = 2)
	begin
		if not exists (select * from KULLANICI where KULLANICI.Eposta like '%' + @parametre +'%' )		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,10)
		end
		else begin
		select * from KULLANICI where KULLANICI.Eposta like '%' + @parametre +'%'		
		end
	end
	else if(@islem_turu = 3)
	begin
		if not exists (select * from KULLANICI where KULLANICI.Kayit_Tarihi = CONVERT(date,@parametre) )		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,10)
		end
		else begin
		select * from KULLANICI where KULLANICI.Kayit_Tarihi = CONVERT(date,@parametre)
		end
	end
	else if(@islem_turu = 4)
	begin
		if not exists (select * from KULLANICI where KULLANICI.Ad like '%' + @parametre +'%' )		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,10)
		end
		else begin
		select * from KULLANICI where KULLANICI.Ad like '%' + @parametre +'%' 
		end
	end
	else if(@islem_turu = 5)
	begin
		if not exists (select * from KULLANICI where KULLANICI.Soyad like '%' + @parametre +'%' )		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,10)
		end
		else begin
		select * from KULLANICI where KULLANICI.Soyad like '%' + @parametre +'%' 
		end
	end
end
GO
/****** Object:  StoredProcedure [dbo].[ToplamRezerveBiletSayisi]    Script Date: 03/27/2012 00:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[ToplamRezerveBiletSayisi]
AS
BEGIN
	SET NOCOUNT ON;
	Select COUNT(*)
	From REZERVASYON
	Where SatildiMi = 0
end
GO
/****** Object:  StoredProcedure [dbo].[SonBesRezervasyonuGetir]    Script Date: 03/27/2012 00:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[SonBesRezervasyonuGetir]
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
GO
/****** Object:  StoredProcedure [dbo].[RezervasyonSilID]    Script Date: 03/27/2012 00:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[RezervasyonSilID] 
	@rezID int
AS
BEGIN
	SET NOCOUNT ON;
	
		if not exists (select * from REZERVASYON where Rez_ID = @rezID)
		begin 
		RAISERROR ('Rezervasyon kaydi bulunmamaktadir.',10,1)
		end
		else begin
		Delete from REZERVASYON where Rez_ID = @rezID
		end
	
END
GO
