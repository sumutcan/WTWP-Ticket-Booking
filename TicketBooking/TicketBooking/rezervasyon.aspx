<%@ Page Title="" Language="C#" MasterPageFile="~/MasterUserPanel.master" AutoEventWireup="true" CodeBehind="rezervasyon.aspx.cs" Inherits="TicketBooking.WebForm1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlHata" runat="server" Visible="False" EnableViewState="False">
    <div runat="server" class="hata">
    <span id="spanHata" runat="server"></span>
    </div>
    </asp:Panel>
    <asp:Wizard ID="wizardRezervasyon" runat="server" Height="203px" Width="560px" 
        ActiveStepIndex="0" FinishCompleteButtonText="Bitir" 
        FinishPreviousButtonText="Önceki" StartNextButtonText="Rezervasyona Başla" 
        StepNextButtonText="Devam" StepPreviousButtonText="Önceki" 
        onfinishbuttonclick="wizardRezervasyon_FinishButtonClick" 
        onactivestepchanged="wizardRezervasyon_ActiveStepChanged" 
        onnextbuttonclick="wizardRezervasyon_NextButtonClick">
    <WizardSteps>
        <asp:WizardStep runat="server" StepType="Start" title="Başlangıç">
                   <asp:Label ID="Label2" runat="server" ForeColor="#FF9999" 
                Text="Rezervasyon işlemlerine başlamak için, butona tıklayınız."></asp:Label>
        </asp:WizardStep>

        <asp:WizardStep runat="server" Title="Film Seçimi">
                   <asp:Label ID="Label3" runat="server" ForeColor="#FF9999" 
                Text="Rezervasyon yapacağınız filmi seçiniz:"></asp:Label>
            <br />
            <asp:DropDownList ID="ddlFilmler" runat="server" Width="211px">
            </asp:DropDownList>
        </asp:WizardStep>

        <asp:WizardStep runat="server" title="Tarih Seçimi">
                   <table>
                   <tr>
                   <th>
                   <asp:Label ID="Label4" runat="server" ForeColor="#FF9999" 
                Text="Rezervasyon tarihi:"></asp:Label>
                </th>
                <td style="background-color:Yellow">
                <asp:TextBox BackColor="Wheat" runat="server" ID="txtTarih"></asp:TextBox>
                <act:CalendarExtender ID="calenderTarih" TargetControlID="txtTarih" runat="server" 
                       FirstDayOfWeek="Monday" TodaysDateFormat="d.MMMM.yyyy"></act:CalendarExtender>
                       </td>
                       </tr>
                       </table>

        </asp:WizardStep>
        <asp:WizardStep runat="server" Title="Seans Seçimi">
                    <asp:Label ID="Label6" runat="server" ForeColor="#FF9999" 
                Text="Rezervasyon için film seansını seçiniz:"></asp:Label>
            <br />
            <br />
            <asp:DropDownList ID="ddlSeanslar" runat="server" Width="207px">
            </asp:DropDownList>
        </asp:WizardStep>
        <asp:WizardStep runat="server" Title="Koltuk Seçimi">
                            <table>
                            <tr>
                            <th><asp:Label ID="Label1" runat="server" ForeColor="#FF9999" 
                Text="Salon seçiniz: "></asp:Label></th>
            
            <td>
            <asp:DropDownList ID="ddlSalonlar" runat="server" 
                    OnSelectedIndexChanged="ddlSalonlar_SelectedIndexChanged" 
                    AutoPostBack="True">
            </asp:DropDownList></td>
            </tr>
            <tr>
                   <th style="text-align:left">
                    <asp:Label ID="Label7" runat="server" ForeColor="#FF9999" 
                Text="Seçili salon için mevcut seansta boş olan koltuklar: "></asp:Label>
            </th>
            <td>
            <asp:UpdatePanel runat="server">
            <ContentTemplate>
            <asp:DropDownList ID="ddlBosKoltuklar" runat="server">
            </asp:DropDownList>
            </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddlSalonlar" EventName="SelectedIndexChanged" />
            </Triggers>
            </asp:UpdatePanel>
            </td>
                </tr>
            </table>
        </asp:WizardStep>
        <asp:WizardStep runat="server" Title="Ücretlendirme">
                    <asp:Label ID="Label8" runat="server" ForeColor="#FF9999" 
                Text="Bu gösterim için ödeyeceğiniz toplam ücret:___"></asp:Label>
            &nbsp;
            <asp:Label ID="lblUcret" runat="server" ForeColor="Lime" Text="Label"></asp:Label>
            <asp:Label ID="Label10" runat="server" ForeColor="#FF9999" Text="  __TL'dir. *"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label11" runat="server" 
                Text="* Gösterimlerin 3D olması, özel gösterim olması gibi özellikleri nedeniyle"></asp:Label>
            <br />
            <asp:Label ID="Label12" runat="server" 
                Text=" fiyatlar değişiklik gösterebilmektedir."></asp:Label>
        </asp:WizardStep>
        <asp:WizardStep runat="server" StepType="Finish" Title="Bilet Önizleme">
        
        <div id="biletAna">
            <div id="logo">
            <div id="logoUst">broadway</div>
            <div id ="logoAlt">sinemaları...</div>
            </div>
            <div id="barkod">
                <asp:Image ID="imgBarkod" runat="server" />
                
            </div>
            <div id="bilgiler">
            <table id="tabloBilgiler">
            <tr>
            <th>Ad Soyad:</th>
            <td><asp:Label runat="server" ID="lblAdSoyad">AdSoyad</asp:Label></td>
            </tr>
            <tr>
            <th>Film:</th>
            <td><asp:Label runat="server" ID="lblFilm">filmAdi</asp:Label></td>
            <th>Seans:</th>
            <td><asp:Label runat="server" ID="lblSeans">seans</asp:Label></td>
            </tr>
            <tr>
            <th>Salon:</th>
            <td><asp:Label runat="server" ID="lblSalon">salon</asp:Label></td>
            <th>Koltuk:</th>
            <td><asp:Label runat="server" ID="lblKoltuk">koltuk</asp:Label></td>
            <th>Ucret:</th>
            <td><asp:Label runat="server" ID="lblBiletUcret">ucret</asp:Label></td>
            </tr>
            </table>
            </div>

        </div>
        
        <div style="float:right; margin-top:5px; color:White;" class="btn">
            <a href="#" onclick=$('#biletAna').jqprint(); class="lnk">Yazdır</a> </div>
        </asp:WizardStep>
        <asp:WizardStep runat="server" StepType="Complete" Title="Rezervasyon Alındı.">
                    <asp:Label ID="Label14" runat="server" 
                Text="Rezervasyonunuz yapılmıştır." ForeColor="#FF9999"></asp:Label>
            <br />
            <asp:Label ID="Label15" runat="server" ForeColor="#FF9999" 
                Text=" Biletinize ait barkodun çıktısı ile veya gişede kimliğiniz ile biletlerinizi temin edebilirsiniz."></asp:Label>
        </asp:WizardStep>
    </WizardSteps>
        <SideBarTemplate>
        <asp:DataList ID="SideBarList" runat="server" OnItemDataBound="SideBarList_ItemDataBound">
          <ItemTemplate>
            <!-- Return false when linkbutton is clicked -->
             <asp:LinkButton  ID="SideBarButton" OnClientClick="return false" ForeColor="White" runat="server"></asp:LinkButton>
          </ItemTemplate>
          <SelectedItemStyle Font-Bold="true"/>
        </asp:DataList>
        </SideBarTemplate>
</asp:Wizard>
</asp:Content>
