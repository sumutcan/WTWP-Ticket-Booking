USE [CINECLUP]
GO
/****** Object:  Table [dbo].[FILM]    Script Date: 03/21/2012 23:38:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FILM](
	[FilmID] [int] IDENTITY(1,1) NOT NULL,
	[Film_Adı] [nvarchar](50) NOT NULL,
	[Yapım_Yılı] [int] NOT NULL,
	[A_D] [bit] NOT NULL,
	[D3] [bit] NOT NULL,
	[Ekleme_Tarihi] [date] NOT NULL,
	[Bitis_Tarihi] [date] NOT NULL,
	[Afis_URL] [nvarchar](max) NOT NULL,
	[GeldiMi] [bit] NOT NULL,
 CONSTRAINT [PK_FILM_1] PRIMARY KEY CLUSTERED 
(
	[FilmID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KULLANICI]    Script Date: 03/21/2012 23:38:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KULLANICI](
	[Kullanici_ID] [int] IDENTITY(1,1) NOT NULL,
	[Kullanici_Tipi] [bit] NOT NULL,
	[Eposta] [nvarchar](50) NOT NULL,
	[Sifre] [nvarchar](max) NOT NULL,
	[Kayit_Tarihi] [date] NOT NULL,
	[Ad] [varchar](25) NOT NULL,
	[Soyad] [varchar](25) NOT NULL,
	[Puan] [int] NOT NULL,
 CONSTRAINT [PK_KULLANICI_1] PRIMARY KEY CLUSTERED 
(
	[Kullanici_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[YORUM]    Script Date: 03/21/2012 23:38:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YORUM](
	[Yorum_ID] [int] IDENTITY(1,1) NOT NULL,
	[Kullanici_ID] [int] NOT NULL,
	[Film_ID] [int] NOT NULL,
	[Yorum] [text] NOT NULL,
	[Tarih] [date] NOT NULL,
	[Saat] [time](7) NOT NULL,
 CONSTRAINT [PK_YORUM] PRIMARY KEY CLUSTERED 
(
	[Yorum_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALON]    Script Date: 03/21/2012 23:38:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SALON](
	[Salon_ID] [int] IDENTITY(1,1) NOT NULL,
	[Salon_Adı] [varchar](25) NOT NULL,
	[Kapasite] [int] NOT NULL,
	[Eklenme_Tarihi] [date] NOT NULL,
	[Açıklama] [text] NULL,
 CONSTRAINT [PK_SALON_1] PRIMARY KEY CLUSTERED 
(
	[Salon_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[KullaniciSil]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  StoredProcedure [dbo].[KullaniciPuaniArttir]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  StoredProcedure [dbo].[KullaniciGuncelle]    Script Date: 03/21/2012 23:38:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[KullaniciGuncelle]
	@K_ID int,
	@tip int,
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
		update KULLANICI set Kullanici_Tipi = @tip, Eposta = @mail, Sifre = @sifre where Kullanici_ID = @K_ID
		end
end
GO
/****** Object:  StoredProcedure [dbo].[KullaniciEkle]    Script Date: 03/21/2012 23:38:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KullaniciEkle] 
	@K_tipi int,
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
/****** Object:  StoredProcedure [dbo].[KullaniciAra]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  Table [dbo].[SEANS]    Script Date: 03/21/2012 23:38:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SEANS](
	[Seans_ID] [int] IDENTITY(1,1) NOT NULL,
	[Film_ID] [int] NOT NULL,
	[Salon_ID] [int] NOT NULL,
	[Saat] [time](7) NOT NULL,
 CONSTRAINT [PK_SEANS_1] PRIMARY KEY CLUSTERED 
(
	[Seans_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KOLTUK]    Script Date: 03/21/2012 23:38:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KOLTUK](
	[Koltuk_ID] [int] IDENTITY(1,1) NOT NULL,
	[Salon_ID] [int] NOT NULL,
	[Satır_No] [int] NOT NULL,
	[Sutun_No] [int] NOT NULL,
	[LoveSeat] [bit] NOT NULL,
 CONSTRAINT [PK_KOLTUK] PRIMARY KEY CLUSTERED 
(
	[Koltuk_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REZERVASYON]    Script Date: 03/21/2012 23:38:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REZERVASYON](
	[Rez_ID] [int] IDENTITY(1,1) NOT NULL,
	[Kullanıcı_ID] [int] NOT NULL,
	[Seans_ID] [int] NOT NULL,
	[Koltuk_ID] [int] NOT NULL,
	[Tarih] [date] NOT NULL,
	[SatildiMi] [bit] NOT NULL,
 CONSTRAINT [PK_REZERVASYON_1] PRIMARY KEY CLUSTERED 
(
	[Rez_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[FilminSeanslariniGoster]    Script Date: 03/21/2012 23:38:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FilminSeanslariniGoster]
	@Film_ID int
AS
BEGIN
	SET NOCOUNT ON;
	select SEANS.*,SALON.Salon_Adı
	from SEANS,SALON
	where SEANS.Film_ID = @Film_ID and SEANS.Salon_ID = SALON.Salon_ID
end
GO
/****** Object:  StoredProcedure [dbo].[BugunRezervasyonListele]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  StoredProcedure [dbo].[ToplamSatilanBiletSayisi]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  StoredProcedure [dbo].[ToplamRezerveBiletSayisi]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  StoredProcedure [dbo].[TekParametreRezervasyonSil]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  StoredProcedure [dbo].[SeansaGoreToplamSatilanBiletSayisi]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  StoredProcedure [dbo].[SeansaGoreToplamRezerveBiletSayisi]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  StoredProcedure [dbo].[SeansaGoreBosKoltuklar]    Script Date: 03/21/2012 23:38:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeansaGoreBosKoltuklar]
	@Seans_ID int
AS
BEGIN
	SET NOCOUNT ON;
	
	select *
	from KOLTUK
	where KOLTUK.Koltuk_ID in
	(
		select KOLTUK.Koltuk_ID
		from KOLTUK
		where (select Salon_ID from SEANS where @Seans_ID = SEANS.Seans_ID) = KOLTUK.Salon_ID 
		except(
			Select Koltuk_ID
			From REZERVASYON
			Where Seans_ID = @Seans_ID)
	)
end
GO
/****** Object:  StoredProcedure [dbo].[RezervasyonSil]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  StoredProcedure [dbo].[RezervasyonGuncelle]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  StoredProcedure [dbo].[RezervasyonEkle]    Script Date: 03/21/2012 23:38:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RezervasyonEkle] 
	@Kullanici_ID int,
	@Seans_ID int,
	@Koltuk_ID int,
	@Tarih date
AS
BEGIN
	SET NOCOUNT ON;
	if exists (select * from REZERVASYON where Seans_ID=@Seans_ID AND Koltuk_ID = @Koltuk_ID)
	begin
	RAISERROR ('Bu koltuk daha once baska bir kullanici tarafindan rezerve edilmis.',10,1)
	end else
	begin
	insert into REZERVASYON values (@Kullanici_ID,@Seans_ID,@Koltuk_ID,@Tarih,0)
	end
END
GO
/****** Object:  StoredProcedure [dbo].[RezervasyonAra]    Script Date: 03/21/2012 23:38:44 ******/
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
/****** Object:  ForeignKey [FK_KOLTUK_SALON]    Script Date: 03/21/2012 23:38:45 ******/
ALTER TABLE [dbo].[KOLTUK]  WITH CHECK ADD  CONSTRAINT [FK_KOLTUK_SALON] FOREIGN KEY([Salon_ID])
REFERENCES [dbo].[SALON] ([Salon_ID])
GO
ALTER TABLE [dbo].[KOLTUK] CHECK CONSTRAINT [FK_KOLTUK_SALON]
GO
/****** Object:  ForeignKey [FK_REZERVASYON_KOLTUK]    Script Date: 03/21/2012 23:38:45 ******/
ALTER TABLE [dbo].[REZERVASYON]  WITH CHECK ADD  CONSTRAINT [FK_REZERVASYON_KOLTUK] FOREIGN KEY([Koltuk_ID])
REFERENCES [dbo].[KOLTUK] ([Koltuk_ID])
GO
ALTER TABLE [dbo].[REZERVASYON] CHECK CONSTRAINT [FK_REZERVASYON_KOLTUK]
GO
/****** Object:  ForeignKey [FK_REZERVASYON_KULLANICI]    Script Date: 03/21/2012 23:38:45 ******/
ALTER TABLE [dbo].[REZERVASYON]  WITH CHECK ADD  CONSTRAINT [FK_REZERVASYON_KULLANICI] FOREIGN KEY([Kullanıcı_ID])
REFERENCES [dbo].[KULLANICI] ([Kullanici_ID])
GO
ALTER TABLE [dbo].[REZERVASYON] CHECK CONSTRAINT [FK_REZERVASYON_KULLANICI]
GO
/****** Object:  ForeignKey [FK_REZERVASYON_SEANS]    Script Date: 03/21/2012 23:38:45 ******/
ALTER TABLE [dbo].[REZERVASYON]  WITH CHECK ADD  CONSTRAINT [FK_REZERVASYON_SEANS] FOREIGN KEY([Seans_ID])
REFERENCES [dbo].[SEANS] ([Seans_ID])
GO
ALTER TABLE [dbo].[REZERVASYON] CHECK CONSTRAINT [FK_REZERVASYON_SEANS]
GO
/****** Object:  ForeignKey [FK_SEANS_FILM]    Script Date: 03/21/2012 23:38:45 ******/
ALTER TABLE [dbo].[SEANS]  WITH CHECK ADD  CONSTRAINT [FK_SEANS_FILM] FOREIGN KEY([Film_ID])
REFERENCES [dbo].[FILM] ([FilmID])
GO
ALTER TABLE [dbo].[SEANS] CHECK CONSTRAINT [FK_SEANS_FILM]
GO
