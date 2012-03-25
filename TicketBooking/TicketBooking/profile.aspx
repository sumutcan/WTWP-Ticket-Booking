<%@ Page Title="" Language="C#" MasterPageFile="~/MasterUserPanel.master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="TicketBooking.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div>
    <h2>Profil Bilgileri</h2>
    <br />

    <asp:Label ID="lblAd" runat="server" Text="Ad:   " ForeColor="#CCCCCC"></asp:Label>
    <br />
    <asp:TextBox ID="txtAd" runat="server" Width="240px"></asp:TextBox>

    <br />
    <asp:Label ID="lblSoyad" runat="server" Text="Soyad:   " ForeColor="#CCCCCC"></asp:Label>
    <br />
    <asp:TextBox ID="txtSoyad" runat="server"  Width="240px"></asp:TextBox>

    <br />

    <asp:Label ID="lblAd1" runat="server" Text="E-posta:   " ForeColor="#CCCCCC"></asp:Label>
    <br />
    <asp:TextBox ID="txtMail" runat="server"  Width="240px"></asp:TextBox>

    <br />

    <asp:Label ID="lblAd2" runat="server" Text="Şifre:   " ForeColor="#CCCCCC"></asp:Label>
    <br />
    <asp:TextBox ID="txtSifre" runat="server" TextMode="Password"  Width="240px"></asp:TextBox>

    <br />

    <asp:Label ID="lblAd3" runat="server" Text="Şifre(Tekrar):   " 
        ForeColor="#CCCCCC"></asp:Label>
    <br />
    <asp:TextBox ID="txtSifre2" runat="server" TextMode="Password"  Width="240px"></asp:TextBox>

    <br />

    <br />
    <br />
    <div>
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="#">Son rezervasyonları göster</asp:HyperLink>
        <br />
        <asp:ListView ID="ListView1" runat="server">
        </asp:ListView>
    </div>
    <br />
    <br />
    <div style="text-align: center">
        <asp:Button ID="btnCancel" runat="server" Text="İptal" 
            onclick="btnCancel_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnConfirm" runat="server" Text="Kaydet" 
            onclick="btnConfirm_Click" />
    </div>
</div>
</asp:Content>
