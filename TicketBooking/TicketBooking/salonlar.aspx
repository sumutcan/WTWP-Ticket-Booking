<%@ Page Title="" Language="C#" MasterPageFile="~/MasterUserPanel.master" AutoEventWireup="true" CodeBehind="salonlar.aspx.cs" Inherits="TicketBooking.WebForm4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <asp:Repeater ID="Repeater1" runat="server">
    <HeaderTemplate>
    <h2>Salonlar</h2>
    </HeaderTemplate>
    <ItemTemplate>

    <div style=" border-style: ridge; border-width: thin; width: 100%; display: block; height: 120px;">

        <div style="width: 150px; float:left; text-align: center;">
            <asp:Image ID="Image1" runat="server" Height="120px" 
                ImageUrl="http://www.catifirmasi.net/images/sinema-salonu-ses-izolasyonu/sinema-salonu-ses-izolasyonlari.jpg" 
                Width="150px" />
        </div>
        <br />
        <div style=" width: 65%; float:right">
            <asp:Label ID="Label1" runat="server" Text="Salon Adı: " ForeColor="#CCCCCC"></asp:Label>
            <asp:Label ID="lblSalonAdi" runat="server" Text=<%#Eval("Ad").ToString() %> ForeColor="#FF855C"></asp:Label>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Kapasite: " ForeColor="#CCCCCC"></asp:Label>
            <asp:Label ID="lblKapasite" runat="server" Text=<%#Eval("Kapasite").ToString() %> ForeColor="#FF855C"></asp:Label>
            <br />
            <asp:Label ID="Label5" runat="server" Text="Eklenme Tarihi: " ForeColor="#CCCCCC"></asp:Label>
            <asp:Label ID="lblEkTarih" runat="server" Text=<%#Eval("EklenmeTarihi").ToString() %> ForeColor="#FF855C"></asp:Label>
            <br />
            <asp:Label ID="Label7" runat="server" Text="Açıklama:" ForeColor="#CCCCCC"></asp:Label>
            <br />
            <asp:Label ID="lblAciklama" runat="server" Text=<%#Eval("Aciklama").ToString() %> ForeColor="#FF855C"></asp:Label>
        </div>

        </div>
        <br /> <br />
    </ItemTemplate>
    </asp:Repeater>


</asp:Content>
