<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AcademicCalendarLeaveManagementSystem.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h2>Login</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
            <div class="mb-3">
                <asp:Label ID="lblUser" runat="server" Text="Username:" AssociatedControlID="txtUsername"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="mb-3">
                <asp:Label ID="lblPass" runat="server" Text="Password:" AssociatedControlID="txtPassword"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
            <div class="form-check mb-3">
                <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                <asp:Label ID="lblRemember" runat="server" Text=" Remember Username" CssClass="form-check-label" AssociatedControlID="chkRemember"></asp:Label>
            </div>
            <div>
                <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary" Text="Login" OnClick="btnLogin_Click" />
            </div>
        </div>
    </div>
</asp:Content>
