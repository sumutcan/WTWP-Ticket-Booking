<%@ Control Language="C#" AutoEventWireup="true" Inherits="loginControl" Codebehind="loginControl.ascx.cs" %>
<div style="border-width: thin; border-color: #C0C0C0; width: 189px; ">
    <asp:MultiView ID="multiviewLoginControl" runat="server" ActiveViewIndex="0">
    <asp:View ID="viewLogin" runat="server">
        <asp:Label ID="Label1" runat="server" Text="E-posta: " Font-Bold="True" 
        Font-Names="Calibri" Font-Size="Small" ForeColor="#CCCCCC"></asp:Label>
    &nbsp;<center><asp:TextBox ID="txtEPosta" runat="server" Width="130px"></asp:TextBox></center>
    <asp:Label ID="Label2" runat="server" Text="Şifre: " Font-Bold="True" 
        Font-Names="Calibri" Font-Size="Small" ForeColor="#CCCCCC"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <center>
        <asp:TextBox ID="txtSifre" runat="server" 
        TextMode="Password" Width="130px"></asp:TextBox></center>
    <div style="text-align: right">
        <br />
        <div style="float:left; margin-bottom:0px;"><asp:LinkButton ID="lnkSifremiUnuttum" CssClass="lnk" runat="server">Şifremi Unuttum</asp:LinkButton></div>
    <asp:Button ID="btnGirisYap" runat="server" Text="Giriş" CssClass="btn" 
            Width="62px" onclick="btnGirisYap_Click" />
        </div>
    </asp:View>
        <asp:View ID="viewHosgeldin" runat="server">
        Hoşgeldin,   <asp:Label ID="lblAdSoyad" runat="server" Text="adSoyad"></asp:Label>
        <div style="margin-top:5px;">
            <div style="float:left;"><asp:LinkButton CssClass="lnk" ID="lnkProfil" runat="server">Profil</asp:LinkButton></div>
            
            <div style="float:right;"><asp:LinkButton CssClass="lnk" ID="lnkCikisYap" 
                    runat="server" onclick="lnkCikisYap_Click">Çıkış Yap</asp:LinkButton></div>
            
        </div>
    </asp:View>
      
        <asp:View ID="viewSifremiUnuttum" runat="server">
        <div>
        <div style="float:left; color:White; font-weight:bold; font-family:Calibri">E-posta:</div>
        <div><asp:TextBox runat="server" ID="txtEpostaSifremiUnuttum"></asp:TextBox></div>
        <div style="float:right; margin-right:60px;"><asp:Button ID="btnSifreGonder" CssClass="btn" runat="server" Text="Şifre Gönder" /></div>
            
        </div>
        
    </asp:View>
    </asp:MultiView>

</div>

