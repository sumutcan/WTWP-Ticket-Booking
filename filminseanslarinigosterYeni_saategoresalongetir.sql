USE [CINECLUP]
GO
/****** Object:  StoredProcedure [dbo].[SaateGoreSalonlariGetir]    Script Date: 03/24/2012 00:33:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SaateGoreSalonlariGetir]
	@saat time
AS
BEGIN
	SET NOCOUNT ON;
	select SALON.*
	from SEANS,SALON
	where SEANS.Saat = @saat  and SEANS.Salon_ID = SALON.Salon_ID

end
GO
/****** Object:  StoredProcedure [dbo].[FilminSeanslariniGoster]    Script Date: 03/24/2012 00:33:38 ******/
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
