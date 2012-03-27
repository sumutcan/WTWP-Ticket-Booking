<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="KullaniciYonetimi.aspx.cs" Inherits="TicketBooking.KullaniciYonetimi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Kullanıcı Yönetimi</h2>
               <div class="module">
                     <h2><span>Arama</span></h2>
                        
                     <div class="module-body">
                         
                            <fieldset>
                                <asp:TextBox ID="txtArama" runat="server" CssClass="input-short"></asp:TextBox>&nbsp;&nbsp;<asp:Button
                                    ID="btnAra" runat="server" Text="Kullanıcı Ara" CssClass="submit-green" 
                                    onclick="btnAra_Click" />
                            </fieldset>
                     </div>
                </div> <!-- module -->
                <asp:Panel runat="server" ID="pnlBasarili" Visible="false" EnableViewState="false"><span class="notification n-success" runat="server" id="spanBasarili">Başarılı işlemde buranın innerhtmli değişecek</span></asp:Panel>
                <asp:Panel runat="server" ID="pnlHata" Visible="false" EnableViewState="false"><span class="notification n-error" runat="server" id="span1">Hatalı işlemde buranın innerhtmli değişecek</span></asp:Panel>
                <div class="module">
                <h2><span>Kullanıcılar</span></h2>
                 <div class="module-table-body">

                             <asp:ListView ID="lstKullanicilar" runat="server">
                             <LayoutTemplate>
                                <table id="myTable" class="tablesorter">
                                                      	<thead>
                                <tr>
                                    <th style="width:5%">ID</th>
                                    <th style="width:20%">Ad</th>
                                    <th style="width:21%">Soyad</th>
                                    <th style="width:13%">E-Posta</th>
                                    <th style="width:13%">Admin/User</th>
                                    
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
                                    <td class="align-center"><%#Eval("Id") %></td>
                                    <td><%#Eval("ad") %></td>
                                    <td><%#Eval("soyad") %></td>
                                    <td><%#Eval("eposta") %></td>
                                    <td><%#Eval("tip") %></td>
                                 
                                    <td>
                                        <a href='<%#Eval("Id","KullaniciYonetimi.aspx?ID={0}&Pid=1")%>'><img src="pencil.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/pencil.gif" width="16" height="16" alt="edit" /></a>
                                        <a href='<%#Eval("Id","KullaniciYonetimi.aspx?ID={0}&Pid=0")%>'><img src="bin.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/bin.gif" width="16" height="16" alt="delete" /></a>
                                    </td>
                                </tr>
                             
                             </ItemTemplate>
                             </asp:ListView>
                            </div>
                              </div>

           <div class="grid_12">
            
                <div class="module">
                     <h2><span>Kullanıcı Ekle/Guncelle</span></h2>
                        
                     <div class="module-body">
                     
                            
                            <p>
                                <label>Ad:</label>
                               <asp:TextBox ID="txtAd" CssClass="input-short" runat="server"></asp:TextBox>
                                
                            </p>
                            <p>
                                <label>Soyad:</label>
                               <asp:TextBox ID="txtSoyad" CssClass="input-short" runat="server"></asp:TextBox>
                                
                            </p>
                            <p>
                                <label>E-Posta:</label>
                               <asp:TextBox ID="txtEposta" CssClass="input-short" runat="server"></asp:TextBox>
                                
                            </p>
                            <p>
                                <label>Şifre:</label>
                               <asp:TextBox ID="txtSifre" CssClass="input-short" runat="server" TextMode="Password"></asp:TextBox>
                                
                            </p>
                            <p>
                                <label>Şifre(Tekrar):</label>
                               <asp:TextBox ID="txtSifreTekrar" CssClass="input-short" runat="server" TextMode="Password"></asp:TextBox>
                                
                            </p>                                                        
                            <p>
                                <label>Yetki:</label>
                                    <asp:DropDownList ID="ddlYetki" runat="server" CssClass="input-short" 
                                    AutoPostBack="True" onselectedindexchanged="ddlYetki_SelectedIndexChanged">
                                    </asp:DropDownList>

                            </p>
                            
                            
                            
                            <fieldset>
                                <asp:Button ID="btnKullaniciKaydet" CssClass="submit-green" runat="server" 
                                    Text="Kaydet" onclick="btnKullaniciKaydet_Click" /> 
                       
                            </fieldset>
                    
                     </div> <!-- End .module-body -->

                </div>  <!-- End .module -->
        		<div style="clear:both;"></div>
            </div> <!-- End .grid_12 -->
</asp:Content>
