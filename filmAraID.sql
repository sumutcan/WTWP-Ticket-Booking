USE [CINECLUP]
GO
/****** Object:  StoredProcedure [dbo].[FilmAra]    Script Date: 03/27/2012 03:33:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[FilmAraID]
	@filmID int
AS
BEGIN
	SET NOCOUNT ON;
		select * from FILM where FILM.FilmID = @filmID
end
