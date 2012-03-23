<%@ Page Title="" Language="C#" MasterPageFile="~/MasterUserPanel.master" AutoEventWireup="true" CodeBehind="rezervasyon.aspx.cs" Inherits="TicketBooking.WebForm1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlHata" runat="server" Visible="False" EnableViewState="False">
    <div runat="server" class="hata">
    <span id="spanHata" runat="server"></span>
    </div>
    </asp:Panel>
    <asp:Wizard ID="wizardRezervasyon" runat="server" Height="172px" Width="560px" 
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
                <asp:TextBox BackColor="Wheat" runat="server" ID="txtTarih" Enabled="true" ReadOnly="false"></asp:TextBox>
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
        <asp:WizardStep runat="server" Title="Bilet Onayı">
                   <asp:Label ID="Label13" runat="server" ForeColor="#FF9999" 
                Text="Lütfen e-posta adresinize girilen doğrulama kodunu giriniz:"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="txtDogrulamaKodu" runat="server"></asp:TextBox>
        </asp:WizardStep>
        <asp:WizardStep runat="server" StepType="Finish" Title="Bilet Önizleme">
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
