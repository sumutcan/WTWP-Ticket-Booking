USE [CINECLUP]
GO
/****** Object:  StoredProcedure [dbo].[BugunRezervasyonListele]    Script Date: 03/25/2012 15:39:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GelecekProgramGetir]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP (1) Film_Adı,Ekleme_Tarihi FROM FILM WHERE Ekleme_Tarihi>GETDATE() ORDER BY Ekleme_Tarihi ASC
	
	
end
