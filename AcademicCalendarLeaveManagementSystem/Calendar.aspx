<%@ Page Title="Academic Calendar" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Calendar.aspx.cs" Inherits="AcademicCalendarLeaveManagementSystem.Calendar" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Academic Calendar</h2>
    <div class="mb-2">
        <asp:Label ID="lblWelcome" runat="server" CssClass="fw-bold"></asp:Label>
        &nbsp;&nbsp;
        <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-sm btn-outline-secondary" OnClick="btnLogout_Click" />
    </div>

    <div class="row">
        <div class="col-md-6">
            <asp:Calendar ID="calAcademic" runat="server" OnSelectionChanged="calAcademic_SelectionChanged" OnDayRender="calAcademic_DayRender"></asp:Calendar>
        </div>
        <div class="col-md-6">
            <asp:Label ID="lblSelectedDate" runat="server"></asp:Label>
            <hr />
            <asp:Literal ID="litEvents" runat="server"></asp:Literal>
            <br />
            <asp:HyperLink ID="lnkLeave" runat="server" NavigateUrl="~/Leave.aspx" CssClass="btn btn-primary">Apply Leave</asp:HyperLink>
        </div>
    </div>
</asp:Content>
