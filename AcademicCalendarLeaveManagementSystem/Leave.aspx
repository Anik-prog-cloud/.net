<%@ Page Title="Apply Leave" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Leave.aspx.cs" Inherits="AcademicCalendarLeaveManagementSystem.Leave" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Apply Leave</h2>
    <asp:Label ID="lblUserInfo" runat="server" CssClass="fw-bold"></asp:Label>
    <hr />
    <div class="mb-3">
        <asp:Label ID="lblFrom" runat="server" Text="From:"></asp:Label>
        <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
    </div>
    <div class="mb-3">
        <asp:Label ID="lblTo" runat="server" Text="To:"></asp:Label>
        <asp:TextBox ID="txtTo" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
    </div>
    <div class="mb-3">
        <asp:Label ID="lblReason" runat="server" Text="Reason:"></asp:Label>
        <asp:TextBox ID="txtReason" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
    </div>
    <div>
        <asp:Button ID="btnApply" runat="server" CssClass="btn btn-primary" Text="Apply Leave" OnClick="btnApply_Click" />
    </div>
    <br />
    <asp:Label ID="lblResult" runat="server" CssClass="text-success"></asp:Label>
</asp:Content>
