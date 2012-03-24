USE [CINECLUP]
GO
/****** Object:  StoredProcedure [dbo].[RezervasyonEkle]    Script Date: 03/24/2012 22:59:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[RezervasyonEkle] 
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
