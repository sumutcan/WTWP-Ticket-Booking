<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="FilmYonetimi.aspx.cs" Inherits="TicketBooking.Admin.FilmYonetimi" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Film Yönetimi</h2>
               <div class="module">
                     <h2><span>Arama</span></h2>
                        
                     <div class="module-body">
                         
                            <fieldset>
                                <asp:TextBox ID="txtArama" runat="server" CssClass="input-short"></asp:TextBox>&nbsp;&nbsp;<asp:Button
                                    ID="btnAra" runat="server" Text="Film Ara" CssClass="submit-green" 
                                    onclick="btnAra_Click" />
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
                                    <th style="width:13%">Yapım Yılı</th>
                                    <th style="width:13%">Vizyon Tarihi</th>
                                    <th style="width:13%">Bitiş Tarihi</th>
                                    <th style="width:13%">Altyazı/Dublaj</th>
                                    <th style="width:5%">3D</th>
                                    
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
                                    <td class="align-center"><%#Eval("id") %></td>
                                    <td><%#Eval("FilmAdiEN")%></a></td>
                                    <td><%#Eval("YapimYili")%></td>
                                    <td><%#Eval("VizyonTarihi")%></td>
                                    <td><%#Eval("BitisTarihi")%></td>
                                    <td><%#Eval("AltDub")%></td>
                                    <td><%#Eval("GetD3")%></td>
                                    <td>
                                        <a href='<%#Eval("id","FilmYonetimi.aspx?ID={0}&Pid=1")%>'><img src="pencil.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/pencil.gif" width="16" height="16" alt="edit" /></a>
                                        <a href='<%#Eval("id","FilmYonetimi.aspx?ID={0}&Pid=0")%>'><img src="bin.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/bin.gif" width="16" height="16" alt="delete" /></a>
                                    </td>
                                </tr>
                             
                             </ItemTemplate>
                             </asp:ListView>
                            </div>
                              </div>
                              <div class="container_12">
                                         <div class="grid_7">
            
                <div class="module">
                     <h2><span>Film Ekle/Guncelle</span></h2>
                        
                     <div class="module-body">
                     
                            
                            <p>
                                <label>Film Adı:</label>
                               <asp:TextBox ID="txtFilmAdi" CssClass="input-medium" runat="server"></asp:TextBox>
                                
                            </p>
                            <p>
                                <label>Vizyon Tarihi:</label>
                               <asp:TextBox ID="txtVizyonTarihi" CssClass="input-short" runat="server"></asp:TextBox>
                                              <act:CalendarExtender ID="calenderVizyonTarih" TargetControlID="txtVizyonTarihi" runat="server" 
                       FirstDayOfWeek="Monday" TodaysDateFormat="d.MMMM.yyyy"></act:CalendarExtender>
                                
                            </p>
                            <p>
                                <label>Bitiş Tarihi:</label>
                               <asp:TextBox ID="txtBitisTarihi" CssClass="input-short" runat="server"></asp:TextBox>
                                              <act:CalendarExtender ID="calenderBitisTarih" TargetControlID="txtBitisTarihi" runat="server" 
                       FirstDayOfWeek="Monday" TodaysDateFormat="d.MMMM.yyyy"></act:CalendarExtender>
                                
                            </p>
                            <p>
                               
                                    <asp:CheckBox ID="chk3D" Text="3D?" runat="server" />
                                    
                                </p>
                            <p>
                               
                                    <asp:CheckBox ID="chkGeldiMi" Text="Geldi Mi?" runat="server" />
                                    
                                </p>
  
                            
                            
                            <p>
                                <label>Afiş URL:</label>
                               <asp:TextBox ID="txtAfisURL" CssClass="input-long" runat="server" 
                                    AutoPostBack="True" ontextchanged="txtAfisURL_TextChanged"></asp:TextBox>
                                
                            </p>

                            
                            <p>
                                <label>Yapım Yılı:</label>
                               <asp:TextBox ID="txtYil" CssClass="input-long" runat="server" 
                                    ></asp:TextBox>
                                
                            </p>
                                                   
                            <p>
                                <label>Altyazı/Dublaj:</label>
                                    <asp:DropDownList ID="ddlAltyaziDublaj" runat="server" 
                                    CssClass="input-short" AutoPostBack="True" 
                                    onselectedindexchanged="ddlAltyaziDublaj_SelectedIndexChanged">
                                    </asp:DropDownList>

                            </p>
                            
                            
                            
                            <fieldset>
                                <asp:Button ID="btnKullaniciKaydet" CssClass="submit-green" runat="server" 
                                    Text="Kaydet" onclick="btnKullaniciKaydet_Click" /> 
                       
                            </fieldset>
                    
                     </div> <!-- End .module-body -->

                </div>  <!-- End .module -->
        		<div style="clear:both;"></div>
            </div> <!-- End .grid_7 -->
            <div class="grid_5">
            <div class="module">
            <h2><span>Film Afişi</span></h2>
            <div class="module-body">

            <center>
            <asp:UpdatePanel ID="updatepanelafis" runat="server">
            <ContentTemplate>
            <asp:Image runat="server" ID="imgFilmAfisi" ImageUrl=""/>
            </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="txtAfisURL" EventName="TextChanged" />
            </Triggers>
            </asp:UpdatePanel>
            </center>
            
            </div>
            
            </div>
            </div>
            </div>
</asp:Content>
