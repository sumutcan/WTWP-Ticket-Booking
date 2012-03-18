<%@ Page Title="" Language="C#" MasterPageFile="~/MasterUserPanel.master" AutoEventWireup="true" CodeBehind="rezervasyon.aspx.cs" Inherits="TicketBooking.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlHata" runat="server" Visible="False">
    <div runat="server" class="hata">
    <span id="spanHata" runat="server"></span>
    </div>
    </asp:Panel>
    <asp:Wizard ID="wizardRezervasyon" runat="server" Height="172px" Width="560px" 
        ActiveStepIndex="0" FinishCompleteButtonText="Bitir" 
        FinishPreviousButtonText="Önceki" StartNextButtonText="Rezervasyona Başla" 
        StepNextButtonText="Devam" StepPreviousButtonText="Önceki" 
        onfinishbuttonclick="wizardRezervasyon_FinishButtonClick">
    <WizardSteps>
        <asp:WizardStep runat="server" StepType="Start" title="Başlangıç">
        </asp:WizardStep>

        <asp:WizardStep runat="server" Title="Film Seçimi">
        </asp:WizardStep>
        <asp:WizardStep runat="server" title="Tarih Seçimi">
        </asp:WizardStep>
        <asp:WizardStep runat="server" Title="Seans Seçimi">
        </asp:WizardStep>
        <asp:WizardStep runat="server" Title="Koltuk Seçimi">
        </asp:WizardStep>
        <asp:WizardStep runat="server" Title="Ücretlendirme">
        </asp:WizardStep>
        <asp:WizardStep runat="server" Title="Bilet Onayı">
        </asp:WizardStep>
        <asp:WizardStep runat="server" StepType="Finish" Title="Bilet Önizleme">
        </asp:WizardStep>
        <asp:WizardStep runat="server" StepType="Complete" Title="Rezervasyon Alındı.">
            <asp:Label ID="Label1" runat="server" 
                Text="Rezervasyonunuz yapılmıştır. Biletinize ait barkodun çıktısı ile veya gişede kimliğiniz ile biletlerinizi temin edebilirsiniz."></asp:Label>
        </asp:WizardStep>
    </WizardSteps>
</asp:Wizard>
</asp:Content>
