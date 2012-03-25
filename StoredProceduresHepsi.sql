USE [CINECLUP]
GO
/****** Object:  StoredProcedure [dbo].[KullaniciSorgula]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[KullaniciSorgula]
	@mail varchar(max),
	@sifre nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
		select * from KULLANICI where @mail = Eposta and @sifre = Sifre
end
GO
/****** Object:  StoredProcedure [dbo].[KullaniciSil]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KullaniciSil]
	@K_ID int
AS
BEGIN
	SET NOCOUNT ON;
		if not exists (select * from KULLANICI where Kullanici_ID = @K_ID)
		begin 
		RAISERROR ('KULLANICI kaydi bulunmamaktadir.',10,1)
		end
		else begin
		Delete from KULLANICI where Kullanici_ID = @K_ID
		end
END
GO
/****** Object:  StoredProcedure [dbo].[KullaniciPuaniArttir]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[KullaniciPuaniArttir]
	@K_ID int,
	@artis int
AS
BEGIN
	SET NOCOUNT ON;
		if not exists (select * from KULLANICI where KULLANICI.Kullanici_ID = @K_ID)		
		begin
		raiserror('Kullanıcı bulunamadı.',1,10)
		end
		else begin
		update KULLANICI set Puan = Puan + @artis where Kullanici_ID = @K_ID
		end
end
GO
/****** Object:  StoredProcedure [dbo].[KullaniciGuncelle]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KullaniciGuncelle]
	@K_ID int,
	@tip bit,
	@Ad nvarchar(max),
	@Soyad nvarchar(max),
	@mail nvarchar(50),
	@sifre nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
		if not exists (select * from KULLANICI where KULLANICI.Kullanici_ID = @K_ID)		
		begin
		raiserror('Arama kriterlerine uyan bir kullanıcı bulunamadı.',1,10)
		end
		else begin
		update KULLANICI set Kullanici_Tipi = @tip,Ad = @Ad, Soyad = @Soyad, Eposta = @mail, Sifre = @sifre where Kullanici_ID = @K_ID
		end
end
GO
/****** Object:  StoredProcedure [dbo].[KullaniciEkle]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KullaniciEkle] 
	@K_tipi bit,
	@E_posta nvarchar(50),
	@Sifre nvarchar(max),
	@K_adi varchar(25),
	@K_soyadi varchar(25)
AS
BEGIN
		SET NOCOUNT ON;
	
		if exists (select * from KULLANICI where @E_posta = Eposta)
		begin 
		RAISERROR ('Bu mail adresi ile kayıtlı başka bir kullanıcı bulunmaktadır!',10,1)
		end
		else begin
		insert into KULLANICI values (@K_tipi,@E_posta,@Sifre,GETDATE(),@K_adi,@K_soyadi,0)
		end
END
GO
/****** Object:  StoredProcedure [dbo].[KullaniciAra]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[KullaniciAra]
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
		select * from KULLANICI where KULLANICI.Kullanici_ID = CONVERT(int,@parametre)
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
/****** Object:  StoredProcedure [dbo].[FilmGuncelle]    Script Date: 03/26/2012 00:53:36 ******/
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
/****** Object:  StoredProcedure [dbo].[FilmEkle]    Script Date: 03/26/2012 00:53:36 ******/
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
/****** Object:  StoredProcedure [dbo].[FilmAra]    Script Date: 03/26/2012 00:53:36 ******/
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
/****** Object:  StoredProcedure [dbo].[TekSalonAdiGetir]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TekSalonAdiGetir]
	@salonID int
AS
BEGIN
	SET NOCOUNT ON;
	select Salon_Adı
	from SALON
	where Salon_ID = @salonID

end
GO
/****** Object:  StoredProcedure [dbo].[VizyondakiFilmleriCek]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VizyondakiFilmleriCek]

AS
BEGIN
	SET NOCOUNT ON
	select *
	from FILM
	where GeldiMi = 'True' and Bitis_Tarihi > CONVERT(date,GETDATE())
end
GO
/****** Object:  StoredProcedure [dbo].[TumSalonlariCek]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[TumSalonlariCek]

AS
BEGIN
	SET NOCOUNT ON
	select *
	from SALON
end
GO
/****** Object:  StoredProcedure [dbo].[TumKullanicilariCek]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[TumKullanicilariCek]

AS
BEGIN
	SET NOCOUNT ON;
	select *
	from KULLANICI
end
GO
/****** Object:  StoredProcedure [dbo].[TumFilmleriCek]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TumFilmleriCek]

AS
BEGIN
	SET NOCOUNT ON
	select *
	from FILM
end
GO
/****** Object:  StoredProcedure [dbo].[SalonSil]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SalonSil] 
	@salonID int
AS
BEGIN
		SET NOCOUNT ON;
	
		if not exists (select * from SALON where @salonID = Salon_ID)
		begin 
		RAISERROR ('Bu IDye sahip bir salon bulunamadı.	',12,1)
		end
		else begin
		delete from SALON where @salonID = Salon_ID
		end
END
GO
/****** Object:  StoredProcedure [dbo].[SalonGuncelle]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SalonGuncelle] 
	@salonID int,
	@salonAdi nvarchar(25),
	@kapasite int,
	@aciklama nvarchar(max)
AS
BEGIN
		SET NOCOUNT ON;
	
		if not exists (select * from SALON where @salonID = Salon_ID)
		begin 
		RAISERROR ('Bu IDye sahip bir salon bulunamadı.	',12,1)
		end
		else begin
		update SALON set Salon_Adı = @salonAdi,Kapasite = @kapasite,Eklenme_Tarihi = CONVERT(date,GETDATE()),Açıklama = @aciklama
		end
END
GO
/****** Object:  StoredProcedure [dbo].[SalonEkle]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SalonEkle] 
	@salonAdi nvarchar(25),
	@kapasite int,
	@aciklama nvarchar(max)
AS
BEGIN
		SET NOCOUNT ON;
	
		if exists (select * from SALON where @salonAdi = Salon_Adı)
		begin 
		RAISERROR ('Bu isimde bir salon zaten var.',12,1)
		end
		else begin
		insert into SALON values (@salonAdi,@kapasite,CONVERT(date,GETDATE()),@aciklama)
		end
END
GO
/****** Object:  StoredProcedure [dbo].[SalonAra]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SalonAra] 
	@islemID int,
	@parametre varchar(max)
AS
BEGIN
		SET NOCOUNT ON;
	if(@islemID = 0)
	begin
		if not exists (select * from SALON where Salon_ID = CONVERT(int,@parametre))
		begin 
		RAISERROR ('Bu IDye sahip bir salon bulunamadı.	',12,1)
		end
		else begin
		select * from SALON where Salon_ID = CONVERT(int,@parametre)
		end
	end
	else if(@islemID = 1)
	begin
		if not exists (select * from SALON where Salon_Adı like '%'+@parametre+'%')
		begin 
		RAISERROR ('Bu kelimeyi içeren isme sahip bir salon bulunamadı.	',12,1)
		end
		else begin
		select * from SALON where Salon_Adı like '%'+@parametre+'%'
		end
	end
	else if(@islemID = 2)
	begin
		if not exists (select * from SALON where Kapasite = CONVERT(int,@parametre))
		begin 
		RAISERROR ('Bu kapasiteye sahip bir salon bulunamadı.',12,1)
		end
		else begin
		select * from SALON where Kapasite = CONVERT(int,@parametre)
		end
	end
	else if(@islemID = 3)
	begin
		if not exists (select * from SALON where Eklenme_Tarihi > CONVERT(date,@parametre))
		begin 
		RAISERROR ('Bu tarihten sonra eklenmiş bir salon bulunamadı.',12,1)
		end
		else begin
		select * from SALON where Eklenme_Tarihi > CONVERT(date,@parametre)
		end
	end
	else if(@islemID = 4)
	begin
		if not exists (select * from SALON where Eklenme_Tarihi < CONVERT(date,@parametre))
		begin 
		RAISERROR ('Bu tarihten önce eklenmiş bir salon bulunamadı.',12,1)
		end
		else begin
		select * from SALON where Eklenme_Tarihi < CONVERT(date,@parametre)
		end
	end
	else if(@islemID = 5)
	begin
		if not exists (select * from SALON where Eklenme_Tarihi = CONVERT(date,@parametre))
		begin 
		RAISERROR ('Bu tarihte eklenmiş bir salon bulunamadı.',12,1)
		end
		else begin
		select * from SALON where Eklenme_Tarihi = CONVERT(date,@parametre)
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[GelecekProgramGetir]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

create PROCEDURE [dbo].[GelecekProgramGetir]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP (1) Film_Adı,Ekleme_Tarihi FROM FILM WHERE Ekleme_Tarihi>GETDATE() ORDER BY Ekleme_Tarihi ASC


end
GO
/****** Object:  StoredProcedure [dbo].[GelecekFilmleriCek]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GelecekFilmleriCek]

AS
BEGIN
	SET NOCOUNT ON
	select *
	from FILM
	where GeldiMi = 'False' and Ekleme_Tarihi > CONVERT(date,GETDATE())
end
GO
/****** Object:  StoredProcedure [dbo].[FilmSil]    Script Date: 03/26/2012 00:53:36 ******/
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
/****** Object:  StoredProcedure [dbo].[KoltukSil]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KoltukSil] 
	@koltukID int
AS
BEGIN
		SET NOCOUNT ON;
	
		if not exists (select * from KOLTUK where @koltukID = Koltuk_ID)
		begin 
		RAISERROR ('Girilen IDye ait bir koltuk bulunamadı.',12,1)
		end
		else begin
		delete from KOLTUK where Koltuk_ID = @koltukID
		end
END
GO
/****** Object:  StoredProcedure [dbo].[KoltukGuncelle]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KoltukGuncelle] 
	@koltukID int,
	@salonID int,
	@satirNo int,
	@sutunNo int,
	@loveSeat bit
AS
BEGIN
		SET NOCOUNT ON;
	
		if not exists (select * from KOLTUK where @koltukID = Koltuk_ID)
		begin 
		RAISERROR ('Girilen IDye ait bir koltuk bulunamadı.',12,1)
		end
		else begin
		update KOLTUK set Salon_ID = @salonID,Satır_No = @satirNo,Sutun_No = @sutunNo,LoveSeat = @loveSeat
		end
END
GO
/****** Object:  StoredProcedure [dbo].[KoltukEkle]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KoltukEkle] 
	@salonID int,
	@satirNo int,
	@sutunNo int,
	@loveSeat bit
AS
BEGIN
		SET NOCOUNT ON;
	
		if not exists (select * from SALON where @salonID = Salon_ID)
		begin 
		RAISERROR ('Olmayan bir salona koltuk eklemeye çalışıyorsunuz.',12,1)
		end
		else begin
		insert into KOLTUK values (@salonID,@satirNo,@sutunNo,@loveSeat)
		end
END
GO
/****** Object:  StoredProcedure [dbo].[KoltukAra]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KoltukAra] 
	@islemID int,
	@parametre int,
	@parametre2 int
AS
BEGIN
		SET NOCOUNT ON;
	if(@islemID = 0)
	begin
		if not exists (select * from KOLTUK where @parametre = Koltuk_ID)
		begin 
		RAISERROR ('Girilen IDye ait bir koltuk bulunamadı.',12,1)
		end
		else begin
		select * from KOLTUK where Koltuk_ID = @parametre
		end
	end
	else if (@islemID = 1)
	begin
		if not exists (select * from KOLTUK where @parametre = Salon_ID)
		begin 
		RAISERROR ('Böyle bir salon veya salona kayıtlı bir koltuk bulunamadı.',12,1)
		end
		else begin
		select * from KOLTUK where Salon_ID = @parametre
		end
	end
	else if (@islemID = 2)
	begin
		if not exists (select * from KOLTUK where @parametre = Satır_No or @parametre2 = Sutun_No)
		begin 
		RAISERROR ('Girilen koordinatta bir koltuk bulunamadı.',12,1)
		end
		else begin
		select * from KOLTUK where Satır_No = @parametre and Sutun_No = @parametre2
		end
	end
	else if (@islemID = 3)
	begin
		if not exists (select * from KOLTUK where LoveSeat = CONVERT(bit,@parametre))
		begin 
		RAISERROR ('LoveSeat türünde koltuk bulunamadı.',12,1)
		end
		else begin
		select * from KOLTUK where LoveSeat = CONVERT(bit,@parametre)
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[FilminSeanslariniGoster]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FilminSeanslariniGoster]
	@Film_ID int
AS
BEGIN
	SET NOCOUNT ON;
	select DISTINCT Saat
	from SEANS
	where SEANS.Film_ID = @Film_ID 

end
GO
/****** Object:  StoredProcedure [dbo].[SaateGoreSalonlariGetir]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[SaateGoreSalonlariGetir]
	@saat time,
	@filmID int
AS
BEGIN
	SET NOCOUNT ON;
	select SALON.*
	from SEANS,SALON
	where SEANS.Saat = @saat  and SEANS.Salon_ID = SALON.Salon_ID and SEANS.Film_ID = @filmID

end
GO
/****** Object:  StoredProcedure [dbo].[TekKoltukGetir]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[TekKoltukGetir]
	@koltukID int
AS
BEGIN
	SET NOCOUNT ON;
	select KOLTUK.Satır_No, KOLTUK.Sutun_No
	from KOLTUK
	where Koltuk_ID = @koltukID

end
GO
/****** Object:  StoredProcedure [dbo].[SeansSil]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SeansSil] 
	@seansID int
AS
BEGIN
		SET NOCOUNT ON;
	
		if not exists (select * from SEANS where @seansID = Seans_ID)
		begin  
		RAISERROR ('Islem basarisiz! Lutfen secili seansin IDsini kontrol ediniz.',12,1)
		end
		else
		begin
		delete from SEANS where @seansID = Seans_ID
		end
END
GO
/****** Object:  StoredProcedure [dbo].[SeansGuncelle]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeansGuncelle] 
	@seansID int,
	@filmID int,
	@salonID int,
	@saat time(7)
AS
BEGIN
		SET NOCOUNT ON;
	
		if not exists (select * from SEANS where @seansID = Seans_ID)
		begin  
		RAISERROR ('Islem basarisiz! Lutfen secili seansin IDsini kontrol ediniz.',12,1)
		end
		else if exists (((select SEANS.* from FILM,SALON,SEANS where @filmID = FILM.FilmID and @salonID = SALON.Salon_ID and @saat =SEANS.Saat) except (select * from SEANS where @seansID = Seans_ID)))
		begin
		RAISERROR ('Islem basarisiz! Lutfen guncellenecek degerlerin tekilligini kontrol ediniz.',12,1)
		end
		else
		begin
		update SEANS set Film_ID = @filmID,Salon_ID = @salonID,Saat = @saat
		end
END
GO
/****** Object:  StoredProcedure [dbo].[SeansEkle]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeansEkle] 
	@filmID int,
	@salonID int,
	@saat time(7)
AS
BEGIN
		SET NOCOUNT ON;
	
		if exists (select SEANS.* from FILM,SALON,SEANS where @filmID = FILM.FilmID and @salonID = SALON.Salon_ID and @saat =SEANS.Saat)
		begin 
		RAISERROR ('Bu seans ile aynı özelliklere sahip başka bir seans bulunmaktadır!',12,1)
		end
		else begin
		insert into SEANS values (@filmID,@salonID,@saat)
		end
END
GO
/****** Object:  StoredProcedure [dbo].[SeansAra]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeansAra] 
	@islemID int,
	@parametre varchar(max)
AS
BEGIN
		SET NOCOUNT ON;
	if(@islemID = 0)
	begin
		if not exists (select * from SEANS where Seans_ID = CONVERT(int,@parametre ))
		begin  
		RAISERROR ('Sonuc bulunamadi.',12,1)
		end
		else
		begin
		select * from SEANS where Seans_ID = CONVERT(int,@parametre )
		end
	end
	if(@islemID = 1)
	begin
		if not exists (select * from SEANS where Film_ID = CONVERT(int,@parametre ))
		begin  
		RAISERROR ('Sonuc bulunamadi.',12,1)
		end
		else
		begin
		select * from SEANS where Film_ID = CONVERT(int,@parametre )
		end
	end
	if(@islemID = 2)
	begin
		if not exists (select * from SEANS where Salon_ID = CONVERT(int,@parametre ))
		begin  
		RAISERROR ('Sonuc bulunamadi.',12,1)
		end
		else
		begin
		select * from SEANS where Salon_ID = CONVERT(int,@parametre )
		end
	end
	if(@islemID = 3)
	begin
		if not exists (select * from SEANS where Saat = CONVERT(time(7),@parametre ))
		begin  
		RAISERROR ('Sonuc bulunamadi.',12,1)
		end
		else
		begin
		select * from SEANS where Saat = CONVERT(time(7),@parametre )
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[TekSeansGetir]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TekSeansGetir]
	@Film_ID int,
	@salonID int
AS
BEGIN
	SET NOCOUNT ON;
	select Seans_ID
	from SEANS
	where SEANS.Film_ID = @Film_ID and Salon_ID = @salonID

end
GO
/****** Object:  StoredProcedure [dbo].[ToplamSatilanBiletSayisi]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[ToplamSatilanBiletSayisi]
AS
BEGIN
	SET NOCOUNT ON;
	Select COUNT(*)
	From REZERVASYON
	Where SatildiMi = 1
end
GO
/****** Object:  StoredProcedure [dbo].[ToplamRezerveBiletSayisi]    Script Date: 03/26/2012 00:53:36 ******/
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
/****** Object:  StoredProcedure [dbo].[TekParametreRezervasyonSil]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TekParametreRezervasyonSil] 
	@islem_ID int,
	@nesne_ID int
AS
BEGIN
	SET NOCOUNT ON;
	
	if(@islem_ID = 0)
	begin
		if not exists (select * from REZERVASYON where Rez_ID = @nesne_ID)
		begin 
		RAISERROR ('Rezervasyon kaydi bulunmamaktadir.',10,1)
		end
		else begin
		Delete from REZERVASYON where Rez_ID = @nesne_ID
		end
	end
	else if (@islem_ID = 1)
	begin
		if not exists (select * from REZERVASYON where Kullanıcı_ID = @nesne_ID)
		begin 
		RAISERROR ('Rezervasyon kaydi bulunmamaktadir.',10,1)
		end
		else begin
		Delete from REZERVASYON where Kullanıcı_ID = @nesne_ID
		end
	end
	else if (@islem_ID = 2)
	begin
		if not exists (select * from REZERVASYON where Seans_ID = @nesne_ID)
		begin 
		RAISERROR ('Rezervasyon kaydi bulunmamaktadir.',10,1)
		end
		else begin
		Delete from REZERVASYON where Seans_ID = @nesne_ID
		end
	end
	else if (@islem_ID = 3)
	begin
		if not exists (select * from REZERVASYON where Koltuk_ID = @nesne_ID)
		begin 
		RAISERROR ('Rezervasyon kaydi bulunmamaktadir.',10,1)
		end
		else begin
		Delete from REZERVASYON where Koltuk_ID = @nesne_ID
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[SeansaGoreToplamSatilanBiletSayisi]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SeansaGoreToplamSatilanBiletSayisi]
	@Seans_ID int
AS
BEGIN
	SET NOCOUNT ON;
	Select COUNT(*)
	From REZERVASYON
	Where Seans_ID = @Seans_ID and SatildiMi = 1
end
GO
/****** Object:  StoredProcedure [dbo].[SeansaGoreToplamRezerveBiletSayisi]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SeansaGoreToplamRezerveBiletSayisi]
	@Seans_ID int
AS
BEGIN
	SET NOCOUNT ON;
	Select COUNT(*)
	From REZERVASYON
	Where Seans_ID = @Seans_ID and SatildiMi = 0
end
GO
/****** Object:  StoredProcedure [dbo].[SeansaGoreBosKoltuklar]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeansaGoreBosKoltuklar]
	@Seans_ID int,
	@salonID int,
	@secilenTarih date
AS
BEGIN
	SET NOCOUNT ON;

	select *
	from KOLTUK
	where KOLTUK.Koltuk_ID in
	(
		select KOLTUK.Koltuk_ID
		from KOLTUK
		where @salonID = KOLTUK.Salon_ID 
		except(
			Select Koltuk_ID
			From REZERVASYON
			Where Seans_ID = @Seans_ID and REZERVASYON.Tarih = @secilenTarih)
	)
end
GO
/****** Object:  StoredProcedure [dbo].[RezervasyonSil]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RezervasyonSil] 
	@Kullanici_ID int,
	@Seans_ID int,
	@Koltuk_ID int
AS
BEGIN
	SET NOCOUNT ON;
	
		if not exists (select * from REZERVASYON where Kullanıcı_ID = @Kullanici_ID and Seans_ID = @Seans_ID and Koltuk_ID=@Koltuk_ID)
		begin 
		RAISERROR ('Rezervasyon kaydi bulunmamaktadir.',10,1)
		end
		else begin
		Delete from REZERVASYON where Kullanıcı_ID = @Kullanici_ID and Seans_ID = @Seans_ID and Koltuk_ID=@Koltuk_ID
		end
	
END
GO
/****** Object:  StoredProcedure [dbo].[RezervasyonGuncelle]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RezervasyonGuncelle] 
	@Rez_ID int,
	@Kullanici_ID int,
	@Seans_ID int,
	@Koltuk_ID int
AS
BEGIN
		SET NOCOUNT ON;
	
		if not exists (select * from REZERVASYON where Rez_ID = @Rez_ID)
		begin 
		RAISERROR ('Rezervasyon kaydi bulunmamaktadir.',10,1)
		end
		else begin
		Update REZERVASYON set Kullanıcı_ID = @Kullanici_ID, Seans_ID = @Seans_ID, Koltuk_ID=@Koltuk_ID, Tarih = GETDATE() where Rez_ID = @Rez_ID
		end
END
GO
/****** Object:  StoredProcedure [dbo].[RezervasyonEkle]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[RezervasyonEkle] 
	@Kullanici_ID int,
	@Seans_ID int,
	@Koltuk_ID int,
	@Tarih date,
	@ucret float
AS
BEGIN
	SET NOCOUNT ON;
	if exists (select * from REZERVASYON where Seans_ID=@Seans_ID AND Koltuk_ID = @Koltuk_ID)
	begin
	RAISERROR ('Bu koltuk daha once baska bir kullanici tarafindan rezerve edilmis.',10,1)
	end else
	begin
	insert into REZERVASYON values (@Kullanici_ID,@Seans_ID,@Koltuk_ID,@Tarih,0,@ucret)

	select @@IDENTITY as 'EklenenRezervasyonID'

	end
END
GO
/****** Object:  StoredProcedure [dbo].[RezervasyonAra]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RezervasyonAra]
	@islem int,
	@parametre_ID int,
	@parametre_Text nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	if (@islem = 0)
	select * from REZERVASYON where Rez_ID = @parametre_ID
	else if (@islem = 1)
	select * from REZERVASYON where Kullanıcı_ID = @parametre_ID
	else if (@islem = 2)
	select * from REZERVASYON where Seans_ID = @parametre_ID
	else if (@islem = 3)
	select * from REZERVASYON where Koltuk_ID = @parametre_ID
	else if (@islem = 4)
	select * from REZERVASYON where Tarih like '%@parametre_Text%'
END
GO
/****** Object:  StoredProcedure [dbo].[BugunRezervasyonListele]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugunRezervasyonListele]
AS
BEGIN
	SET NOCOUNT ON;
	if not exists (select * from REZERVASYON where Tarih = Convert(date, GETDATE()))
	begin
	raiserror('Bugün için yapılmış herhangi bir rezervasyon yok.',1,10)
	end
	else 
	begin
	select * from REZERVASYON where Tarih = Convert(date, GETDATE())
	end
end
GO
/****** Object:  StoredProcedure [dbo].[BiletCek]    Script Date: 03/26/2012 00:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[BiletCek]
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
	REZERVASYON.Ucret,
	REZERVASYON.Tarih

	from REZERVASYON, FILM, SALON, SEANS, KULLANICI, KOLTUK
	where REZERVASYON.Kullanıcı_ID = @kullaniciID and
	REZERVASYON.SatildiMi = 0 and
	REZERVASYON.Koltuk_ID = KOLTUK.Koltuk_ID and
	REZERVASYON.Seans_ID = SEANS.Seans_ID and
	SEANS.Salon_ID = SALON.Salon_ID and
	SEANS.Film_ID = FILM.FilmID and
	REZERVASYON.Kullanıcı_ID = KULLANICI.Kullanici_ID

	ORDER BY REZERVASYON.Rez_ID DESC
end
GO
