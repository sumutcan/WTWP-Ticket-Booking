<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="SalonYonetimi.aspx.cs" Inherits="TicketBooking.Admin.SalonYonetimi" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <h2>Salon Yönetimi</h2>
               <div class="module">
                     <h2><span>Arama</span></h2>
                        
                     <div class="module-body">
                         
                            <fieldset>
                                <asp:TextBox ID="txtArama" runat="server" CssClass="input-short"></asp:TextBox>&nbsp;&nbsp;<asp:Button
                                    ID="btnAra" runat="server" Text="Salon Ara" CssClass="submit-green" />
                            </fieldset>
                     </div>
                </div> <!-- module -->
                <asp:Panel runat="server" ID="pnlBasarili" Visible="false" EnableViewState="false"><span class="notification n-success" runat="server" id="spanBasarili">Başarılı işlemde buranın innerhtmli değişecek</span></asp:Panel>
                <asp:Panel runat="server" ID="pnlHata" Visible="false" EnableViewState="false"><span class="notification n-error" runat="server" id="span1">Hatalı işlemde buranın innerhtmli değişecek</span></asp:Panel>
                <div class="module">
                <h2><span>Salonlar</span></h2>
                 <div class="module-table-body">

                             <asp:ListView ID="lstSalonlar" runat="server">
                             <LayoutTemplate>
                                <table id="myTable" class="tablesorter">
                                                      	<thead>
                                <tr>
                                    <th style="width:5%">ID</th>
                                    <th style="width:20%">Salon Adı</th>
                                    <th style="width:13%">Kapasite</th>
                                    <th style="width:13%">Eklenme Tarihi</th>
                                    <th style="width:13%">Açıklama</th>

                                    
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
                                    <td>992</td>
                                    <td>Cervantes</td>
                                    <td>adventure</td>

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
                              <div class="container_12">
                                         <div class="grid_7">
            
                <div class="module">
                     <h2><span>Salon Ekle/Guncelle</span></h2>
                        
                     <div class="module-body">
                     
                            
                            <p>
                                <label>Salon Adı:</label>
                               <asp:TextBox ID="txtFilmAdi" CssClass="input-medium" runat="server"></asp:TextBox>
                                
                            </p>
                            <p>
                            <label>Satır Sayısı</label>
                            <asp:TextBox ID="txtSatirSayisi" CssClass="input-short" runat="server"></asp:TextBox>
                            <act:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtSatirSayisi" FilterType="Numbers"></act:FilteredTextBoxExtender>
                            </p>

                            <p>
                            <label>Sütun Sayısı</label>
                            <asp:TextBox ID="txtSutunSayisi" CssClass="input-short" runat="server"></asp:TextBox>
                            <act:FilteredTextBoxExtender runat="server" TargetControlID="txtSutunSayisi" FilterType="Numbers"></act:FilteredTextBoxExtender>
                            
                            </p>

                             <p>
                            <label>Açıklama</label>
                            <asp:TextBox ID="txtAciklama" CssClass="input-medium" runat="server" TextMode="MultiLine"></asp:TextBox>
                            
                            
                            </p>                                                      
                            
                            <fieldset>
                                <asp:Button ID="btnSalonKaydet" CssClass="submit-green" runat="server" Text="Kaydet" /> 
                       
                            </fieldset>
                    
                     </div> <!-- End .module-body -->

                </div>  <!-- End .module -->
        		<div style="clear:both;"></div>
            </div> <!-- End .grid_7 -->

            </div>

</asp:Content>
