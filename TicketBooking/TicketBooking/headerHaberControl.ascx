<%@ Control Language="C#" AutoEventWireup="true" Inherits="headerHaberControl" Codebehind="headerHaberControl.ascx.cs" %>

<div>
<marquee direction="vertical">
    <h3>
    <asp:Label ID="Label2" runat="server" Text="Gelecek Program: "></asp:Label>
    <asp:Label ID="Label1" runat="server" Text="Film: "></asp:Label>
    <asp:Label ID="film" runat="server" Text="#film"></asp:Label>
    <asp:Label ID="paraf" runat="server" Text="-|-"></asp:Label>
    <asp:Label ID="Label3" runat="server" Text="Tarih: "></asp:Label>
    <asp:Label ID="tarih" runat="server" Text="#tarih"></asp:Label>

    </h3>
</marquee>
    </div>