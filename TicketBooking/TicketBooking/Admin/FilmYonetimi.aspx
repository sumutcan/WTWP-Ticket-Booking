<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="FilmYonetimi.aspx.cs" Inherits="TicketBooking.Admin.FilmYonetimi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h2>Film Yönetimi</h2>
               <div class="module">
                     <h2><span>Arama</span></h2>
                        
                     <div class="module-body">
                         
                            <fieldset>
                                <asp:TextBox ID="txtArama" runat="server" CssClass="input-short"></asp:TextBox>&nbsp;&nbsp;<asp:Button
                                    ID="btnAra" runat="server" Text="Film Ara" CssClass="submit-green" />
                            </fieldset>
                     </div>
                </div> <!-- module -->
                <asp:Panel runat="server" ID="pnlBasarili" Visible="false" EnableViewState="false"><span class="notification n-success" runat="server" id="spanBasarili">Başarılı işlemde buranın innerhtmli değişecek</span></asp:Panel>
                <asp:Panel runat="server" ID="pnlHata" Visible="false" EnableViewState="false"><span class="notification n-error" runat="server" id="span1">Hatalı işlemde buranın innerhtmli değişecek</span></asp:Panel>
                <div class="module">
                <h2><span>Filmler</span></h2>
                 <div class="module-table-body">

                             <asp:ListView ID="lstFilmler" runat="server">
                             <LayoutTemplate>
                                <table id="myTable" class="tablesorter">
                                                      	<thead>
                                <tr>
                                    <th style="width:5%">ID</th>
                                    <th style="width:20%">Ad</th>
                                    <th style="width:21%">Vizyon Tarihi</th>
                                    <th style="width:13%">Bitiş Tarihi</th>
                                    <th style="width:13%">Altyazı/Dublaj</th>
                                    <th style="width:13%">3D</th>
                                    
                                    <th style="width:15%"></th>
                                </tr>
                            </thead>
                              <tbody>
                                <asp:PlaceHolder runat="server" id="itemPlaceHolder"></asp:PlaceHolder>
                               </tbody>
                               </table>
                             </LayoutTemplate>
                               

                                <ItemSeparatorTemplate>
                                        <hr />
                                </ItemSeparatorTemplate>

                             <ItemTemplate>
                                                            <tr>
                                    <td class="align-center">1</td>
                                    <td><a href="">Don Quixote</a></td>
                                    <td>Cervantes</td>
                                    <td>adventure</td>
                                    <td>992</td>
                                    <td>992</td>
                                    <td>
                                    	<input type="checkbox" />
                                        <a href=""><img src="pencil.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/pencil.gif" width="16" height="16" alt="edit" /></a>
                                        <a href=""><img src="bin.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/bin.gif" width="16" height="16" alt="delete" /></a>
                                    </td>
                                </tr>
                             
                             </ItemTemplate>
                             </asp:ListView>
                            </div>
                              </div>
</asp:Content>
