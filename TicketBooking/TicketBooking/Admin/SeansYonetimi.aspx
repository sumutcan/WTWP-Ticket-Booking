<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="SeansYonetimi.aspx.cs" Inherits="TicketBooking.Admin.SeansYonetimi" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Seans Yönetimi</h2>

                <asp:Panel runat="server" ID="pnlBasarili" Visible="false" EnableViewState="false"><span class="notification n-success" runat="server" id="spanBasarili">Başarılı işlemde buranın innerhtmli değişecek</span></asp:Panel>
                <asp:Panel runat="server" ID="pnlHata" Visible="false" EnableViewState="false"><span class="notification n-error" runat="server" id="span1">Hatalı işlemde buranın innerhtmli değişecek</span></asp:Panel>
                <div class="container_12">
                <div class="grid_6">
                <div class="module">
                <h2><span>Seanslar</span></h2>
                 <div class="module-table-body">

                             <asp:ListView ID="lstSeanslar" runat="server">
                             <LayoutTemplate>
                                 
                                <table id="myTable" class="tablesorter">
                                                      	<thead>
                                <tr>
                                    <th style="width:5%">ID</th>
                                    <th style="width:20%">Salon Adı</th>
                                    <th style="width:13%">Film Adı</th>
                                    <th style="width:13%">Saat</th>
                                    
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
                                    <td class="align-center"><%#Eval("Id") %></td>
                                    <td><a href=""><%#Eval("Salon.Ad") %></a></td>
                                    <td><%#Eval("Film.FilmAdiTR") %></td>
                                    <td><%#Eval("Saat") %></td>
                                    <td>
                                    	
                                        <a href='<%#Eval("Id","SeansYonetimi.aspx?ID={0}&Pid=1")%>'><img src="pencil.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/pencil.gif" width="16" height="16" alt="edit" /></a>
                                        <a href='<%#Eval("Id","SeansYonetimi.aspx?ID={0}&Pid=0")%>'><img src="bin.gif" tppabs="http://www.xooom.pl/work/magicadmin/images/bin.gif" width="16" height="16" alt="delete" /></a>
                                    </td>
                                </tr>
                             
                             </ItemTemplate>
                             </asp:ListView>
                            </div>

</div>
</div>
<div class="grid_6">
                                     
            
                <div class="module">
                     <h2><span>Seans Ekle/Guncelle</span></h2>
                        
                     <div class="module-body">
                            <p>
                                <label>Film:</label>
                               
                                <asp:DropDownList ID="ddlFilmler" runat="server">
                                </asp:DropDownList>
                            </p>
                                                        <p>
                                <label>Salon:</label>
                               
                                <asp:DropDownList ID="ddlSalonlar" runat="server">
                                </asp:DropDownList>
                            </p>

                            <p>
                            <label>Saat</label>
                            <asp:TextBox ID="txtSaat" CssClass="input-short" runat="server"></asp:TextBox>
                            <act:filteredtextboxextender runat="server" TargetControlID="txtSaat" 
                                    FilterType="Numbers"></act:filteredtextboxextender>
                                    :
                                                                <asp:TextBox ID="txtDakika" CssClass="input-short" runat="server"></asp:TextBox>
                            <act:filteredtextboxextender ID="Filteredtextboxextender1" runat="server" TargetControlID="txtDakika" 
                                    FilterType="Numbers"></act:filteredtextboxextender>
                            
                            </p>
                                                   
                            
                            <fieldset>
                                <asp:Button ID="btnSeansKaydet" CssClass="submit-green" runat="server" 
                                    Text="Kaydet" onclick="btnSeansKaydet_Click" /> 
                       
                            </fieldset>
                            <asp:HiddenField ID="guncelle" runat="server" />
                    
                     </div> <!-- End .module-body -->

                </div>  <!-- End .module -->
        		<div style="clear:both;"></div>
           
</div>
</div>
</asp:Content>
