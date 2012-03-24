using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TicketBooking
{
    public partial class BarkodOlustur : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             
            if (Request.QueryString["ID"] != null)
            {
                string ID = Request.QueryString["ID"];

                Response.ContentType = "image/jpeg";


                BarcodeLib.Barcode.DoEncode(BarcodeLib.TYPE.CODE128, "5", false, 140, 47).Save(Response.OutputStream,System.Drawing.Imaging.ImageFormat.Jpeg);
            }
            
        }
    }
}