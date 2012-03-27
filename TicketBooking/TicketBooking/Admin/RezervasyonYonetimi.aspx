<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="RezervasyonYonetimi.aspx.cs" Inherits="TicketBooking.Admin.RezervasyonYonetimi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Rezervasyon Yönetimi</h2>
               <div class="module">
                     <h2><span>Arama</span></h2>
                        
                     <div class="module-body">
                         
                            <fieldset>
                                <asp:TextBox ID="txtArama" runat="server" CssClass="input-short"></asp:TextBox>&nbsp;&nbsp;<asp:Button
                                    ID="btnAra" runat="server" Text="Rezervasyon Ara" CssClass="submit-green" />
                            </fieldset>
                     </div>
                </div> <!-- module -->
                <asp:Panel runat="server" ID="pnlBasarili" Visible="false" EnableViewState="false"><span class="notification n-success" runat="server" id="spanBasarili">Başarılı işlemde buranın innerhtmli değişecek</span></asp:Panel>
                <asp:Panel runat="server" ID="pnlHata" Visible="false" EnableViewState="false"><span class="notification n-error" runat="server" id="span1">Hatalı işlemde buranın innerhtmli değişecek</span></asp:Panel>
                <div class="module">
                <h2><span>Rezervasyonlar</span></h2>
                 <div class="module-table-body">

                             <asp:ListView ID="lstRezervasyonlar" runat="server">
                             <LayoutTemplate>
                                <table id="myTable" class="tablesorter">
                                                      	<thead>
                                <tr>
                                    <th style="width:5%">ID</th>
                                    <th style="width:20%">Ad Soyad</th>
                                    <th style="width:13%">Film Adı</th>
                                    <th style="width:13%">Salon</th>
                                    <th style="width:13%">Koltuk</th>
                                    <th style="width:13%">Tarih</th>
                                    <th style="width:5%">Saat</th>
                                    
                                    <th style="width:15%"></th>
                                </tr>
                            </thead>
                              <tbody>
                                <asp:PlaceHolder runat="server" id="itemPlaceHolder"></asp:PlaceHolder>
                               </tbody>
                               </table>
                             </LayoutTemplate>
                               

                                <ItemSeparatorTemplate>
                                        
                                </ItemSeparatorTemplate>

                             <ItemTemplate>
                                                            <tr>
                                    <td class="align-center"><%#Eval("RezervasyonID") %></td>
                                    <td><%#Eval("AdSoyad") %></a></td>
                                    <td><%#Eval("FilmAdi") %></td>
                                    <td><%#Eval("SalonAdi") %></td>
                                    <td><%#Eval("KoltukAdi") %></td>
                                    <td><%#Eval("Tarih") %></td>
                                    <td><%#Eval("Saat") %></td>
                                 
                                    <td>
                                        <a href='<%#Eval("RezervasyonID","RezervasyonYonetimi.aspx?ID={0}&Pid=0")%>'><img src="bin.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/bin.gif" width="16" height="16" alt="delete" /></a>
                                    </td>
                                </tr>
                             
                             </ItemTemplate>
                             </asp:ListView>
                            </div>

</div>
</asp:Content>
