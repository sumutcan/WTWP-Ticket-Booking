<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TicketBooking.Admin.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <!-- Dashboard icons -->
            <div class="grid_7">
            	<a href="KullaniciYonetimi.aspx" class="dashboard-module">
                	<img src="Crystal_Clear_user.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/Crystal_Clear_write.gif" width="64" height="64" alt="edit" />
                	<span>Kullanıcılar</span>
                </a>
                
                <a href="FilmYonetimi.aspx" class="dashboard-module">
                	<img src="Crystal_Clear_file.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/Crystal_Clear_file.gif" width="64" height="64" alt="edit" />
                	<span>Filmler</span>
                </a>
                
                <a href="SalonYonetimi.aspx" class="dashboard-module">
                	<img src="Crystal_Clear_files.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/Crystal_Clear_files.gif" width="64" height="64" alt="edit" />
                	<span>Salonlar</span>
                </a>
                
                <a href="RezervasyonYonetimi.aspx" class="dashboard-module">
                	<img src="Crystal_Clear_calendar.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/Crystal_Clear_calendar.gif" width="64" height="64" alt="edit" />
                	<span>Rezervasyonlar</span>
                </a>
                
  
                <div style="clear: both"></div>
            </div> <!-- End .grid_7 -->
            
            <!-- Account overview -->
            <div class="grid_5">
                <div class="module">
                        <h2><span>Genel Görünüm</span></h2>
                        
                        <div class="module-body">
                        
                        	<p>
                                <strong>Kullanıcı: </strong><asp:Label ID="lblAdSoyad" runat="server" Text="Label"></asp:Label><br />
                                <strong>Sistemdeki toplam rezervasyon sayısı: </strong><asp:Label ID="lblToplamRezervasyon" runat="server" Text="Label"></asp:Label><br />
                                
                            </p>
                                <h4>Bugünün Son Rezervasyonları </h4>
                             
                         <div class="module-body">
                             <asp:ListView ID="lstBugununSonRezervasyonlari" runat="server">
                             <LayoutTemplate>
                                
                                <asp:PlaceHolder runat="server" id="itemPlaceHolder"></asp:PlaceHolder>
                                

                                
                             
                             </LayoutTemplate>
                             
                                <ItemSeparatorTemplate>
                                        <hr />
                                </ItemSeparatorTemplate>

                             <ItemTemplate>
                             <a href="" class="removable">images</a>
                             
                             </ItemTemplate>
                             </asp:ListView>

<%--                         <a href="" class="removable">images</a><br />
                         <a href="" class="removable">video</a><br />
                         <a href="" class="removable">audio</a><br />
                         <a href="" class="removable">documents</a><br />
                         <a href="" class="removable">apps</a><br />--%>
                         
                         
                     
                </div> <!-- module -->
                             
                             
                             


                        </div>
                </div>
                <div style="clear:both;"></div>
            </div> <!-- End .grid_5 -->
            
            <div style="clear:both;"></div>
</asp:Content>
