<%@ Control Language="C#" AutoEventWireup="true" CodeFile="loginControl.ascx.cs" Inherits="loginControl" %>
<div style="border-width: thin; border-color: #C0C0C0; width: 150px; ">

    <asp:Label ID="Label1" runat="server" Text="E-posta: " Font-Bold="True" 
        Font-Names="Calibri" Font-Size="Small" ForeColor="#CCCCCC"></asp:Label>
    &nbsp;<center><asp:TextBox ID="TextBox1" runat="server" Width="130px"></asp:TextBox></center>
    <asp:Label ID="Label2" runat="server" Text="Şifre: " Font-Bold="True" 
        Font-Names="Calibri" Font-Size="Small" ForeColor="#CCCCCC"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <center><asp:TextBox ID="TextBox2" runat="server" 
        TextMode="Password" Width="130px"></asp:TextBox></center>
    <div style="text-align: right">
        <br />
    <asp:Button ID="button_submit" runat="server" Text="Giriş" Font-Bold="True" 
        Font-Names="Calibri" Font-Size="Small" Width="62px" />
        </div>
</div>

