<%@ Page Title="" Language="C#" MasterPageFile="~/MasterUserPanel.master" AutoEventWireup="true" CodeBehind="filmler.aspx.cs" Inherits="TicketBooking.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Filmler</h2>
    <div style="text-align: center">
        <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
        <asp:HyperLink ID="hlnkFilmAdUrl" runat="server" NavigateUrl=<%#Eval("bilgiURL").ToString()%>><%#Eval("FilmAdiEN").ToString()%></asp:HyperLink>
        <br />
        <br />
        <asp:Image ID="imgAfis" runat="server" Height="280px" Width="210px" ImageUrl=<%#Eval("afisURL").ToString()%>/>
        <br />
        <br />
        <br />
        </ItemTemplate>
        </asp:Repeater>
        
    
    
    </div>

</asp:Content>
