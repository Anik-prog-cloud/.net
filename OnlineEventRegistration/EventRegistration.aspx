<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="EventRegistration.aspx.cs"
    Inherits="OnlineEventRegistration.EventRegistration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Event Registration Portal</title>

    <style>
        body {
            font-family: Arial;
            background-color: #f2f2f2;
        }

        .container {
            width: 600px;
            margin: 30px auto;
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px gray;
        }

        h1 {
            text-align: center;
        }

        .row {
            margin-bottom: 15px;
        }

        .label {
            display: inline-block;
            width: 170px;
            font-weight: bold;
        }

        .input {
            width: 300px;
            padding: 7px;
        }

        .error {
            color: red;
            margin-left: 10px;
        }

        .success {
            color: green;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
        }

        .btn {
            padding: 10px 25px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

<div class="container">

    <h1>Online Event Registration</h1>

    <asp:ValidationSummary
        ID="ValidationSummary1"
        runat="server"
        ForeColor="Red"
        HeaderText="Please correct the following errors:" />

    <!-- Name -->
    <div class="row">
        <asp:Label
            ID="lblName"
            runat="server"
            Text="Participant Name:"
            CssClass="label">
        </asp:Label>

        <asp:TextBox
            ID="txtName"
            runat="server"
            CssClass="input">
        </asp:TextBox>

        <asp:RequiredFieldValidator
            ID="rfvName"
            runat="server"
            ControlToValidate="txtName"
            ErrorMessage="Participant name is required."
            Text="*"
            CssClass="error">
        </asp:RequiredFieldValidator>
    </div>


    <!-- Email -->
    <div class="row">
        <asp:Label
            ID="lblEmail"
            runat="server"
            Text="Email:"
            CssClass="label">
        </asp:Label>

        <asp:TextBox
            ID="txtEmail"
            runat="server"
            CssClass="input">
        </asp:TextBox>

        <asp:RequiredFieldValidator
            ID="rfvEmail"
            runat="server"
            ControlToValidate="txtEmail"
            ErrorMessage="Email is required."
            Text="*"
            CssClass="error">
        </asp:RequiredFieldValidator>

        <asp:RegularExpressionValidator
            ID="revEmail"
            runat="server"
            ControlToValidate="txtEmail"
            ErrorMessage="Enter a valid email address."
            Text="*"
            CssClass="error"
            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$">
        </asp:RegularExpressionValidator>
    </div>


    <!-- Mobile -->
    <div class="row">
        <asp:Label
            ID="lblMobile"
            runat="server"
            Text="Mobile Number:"
            CssClass="label">
        </asp:Label>

        <asp:TextBox
            ID="txtMobile"
            runat="server"
            CssClass="input">
        </asp:TextBox>

        <asp:RequiredFieldValidator
            ID="rfvMobile"
            runat="server"
            ControlToValidate="txtMobile"
            ErrorMessage="Mobile number is required."
            Text="*"
            CssClass="error">
        </asp:RequiredFieldValidator>

        <asp:RegularExpressionValidator
            ID="revMobile"
            runat="server"
            ControlToValidate="txtMobile"
            ErrorMessage="Enter a valid 10-digit mobile number."
            Text="*"
            CssClass="error"
            ValidationExpression="^[0-9]{10}$">
        </asp:RegularExpressionValidator>
    </div>


    <!-- Event -->
    <div class="row">
        <asp:Label
            ID="lblEvent"
            runat="server"
            Text="Select Event:"
            CssClass="label">
        </asp:Label>

        <asp:DropDownList
            ID="ddlEvent"
            runat="server"
            CssClass="input">

            <asp:ListItem Text="-- Select Event --" Value="">
            </asp:ListItem>

            <asp:ListItem Text="Technical Workshop"
                Value="Technical Workshop">
            </asp:ListItem>

            <asp:ListItem Text="Coding Competition"
                Value="Coding Competition">
            </asp:ListItem>

            <asp:ListItem Text="Web Development Seminar"
                Value="Web Development Seminar">
            </asp:ListItem>

            <asp:ListItem Text="AI &amp; Machine Learning"
                Value="AI & Machine Learning">
            </asp:ListItem>

        </asp:DropDownList>

        <asp:RequiredFieldValidator
            ID="rfvEvent"
            runat="server"
            ControlToValidate="ddlEvent"
            InitialValue=""
            ErrorMessage="Please select an event."
            Text="*"
            CssClass="error">
        </asp:RequiredFieldValidator>
    </div>


    <!-- Gender -->
    <div class="row">
        <asp:Label
            ID="lblGender"
            runat="server"
            Text="Gender:"
            CssClass="label">
        </asp:Label>

        <asp:RadioButtonList
            ID="rblGender"
            runat="server"
            RepeatDirection="Horizontal">

            <asp:ListItem>Male</asp:ListItem>
            <asp:ListItem>Female</asp:ListItem>
            <asp:ListItem>Other</asp:ListItem>

        </asp:RadioButtonList>

        <asp:RequiredFieldValidator
            ID="rfvGender"
            runat="server"
            ControlToValidate="rblGender"
            ErrorMessage="Please select gender."
            Text="*"
            CssClass="error">
        </asp:RequiredFieldValidator>
    </div>


    <!-- Number of Participants -->
    <div class="row">
        <asp:Label
            ID="lblParticipants"
            runat="server"
            Text="Participants:"
            CssClass="label">
        </asp:Label>

        <asp:TextBox
            ID="txtParticipants"
            runat="server"
            CssClass="input">
        </asp:TextBox>

        <asp:RequiredFieldValidator
            ID="rfvParticipants"
            runat="server"
            ControlToValidate="txtParticipants"
            ErrorMessage="Enter number of participants."
            Text="*"
            CssClass="error">
        </asp:RequiredFieldValidator>

        <asp:RangeValidator
            ID="rangeParticipants"
            runat="server"
            ControlToValidate="txtParticipants"
            MinimumValue="1"
            MaximumValue="10"
            Type="Integer"
            ErrorMessage="Participants must be between 1 and 10."
            Text="*"
            CssClass="error">
        </asp:RangeValidator>
    </div>


    <!-- Event Date -->
    <div class="row">
        <asp:Label
            ID="lblDate"
            runat="server"
            Text="Event Date:"
            CssClass="label">
        </asp:Label>

        <asp:TextBox
            ID="txtDate"
            runat="server"
            TextMode="Date"
            CssClass="input">
        </asp:TextBox>

        <asp:RequiredFieldValidator
            ID="rfvDate"
            runat="server"
            ControlToValidate="txtDate"
            ErrorMessage="Please select event date."
            Text="*"
            CssClass="error">
        </asp:RequiredFieldValidator>
    </div>


    <!-- Address -->
    <div class="row">
        <asp:Label
            ID="lblAddress"
            runat="server"
            Text="Address:"
            CssClass="label">
        </asp:Label>

        <asp:TextBox
            ID="txtAddress"
            runat="server"
            TextMode="MultiLine"
            Rows="3"
            CssClass="input">
        </asp:TextBox>

        <asp:RequiredFieldValidator
            ID="rfvAddress"
            runat="server"
            ControlToValidate="txtAddress"
            ErrorMessage="Address is required."
            Text="*"
            CssClass="error">
        </asp:RequiredFieldValidator>
    </div>


    <!-- Terms -->
    <div class="row">

        <asp:CheckBox
            ID="chkTerms"
            runat="server"
            Text=" I agree to the Terms and Conditions" />

        <asp:CustomValidator
            ID="cvTerms"
            runat="server"
            ErrorMessage="You must accept the Terms and Conditions."
            Text="*"
            CssClass="error"
            OnServerValidate="cvTerms_ServerValidate">
        </asp:CustomValidator>

    </div>


    <!-- Register Button -->
    <div class="row" style="text-align:center">

        <asp:Button
            ID="btnRegister"
            runat="server"
            Text="Register"
            CssClass="btn"
            OnClick="btnRegister_Click" />

    </div>


    <!-- Result -->
    <asp:Label
        ID="lblMessage"
        runat="server"
        CssClass="success">
    </asp:Label>

</div>

</form>
</body>
</html>