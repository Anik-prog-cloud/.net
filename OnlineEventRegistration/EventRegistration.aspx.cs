using System;
using System.Web.UI;

namespace OnlineEventRegistration
{
    public partial class EventRegistration : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void cvTerms_ServerValidate(
            object source,
            System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = chkTerms.Checked;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = txtName.Text;
                string email = txtEmail.Text;
                string mobile = txtMobile.Text;
                string eventName = ddlEvent.SelectedValue;
                string gender = rblGender.SelectedValue;
                string participants = txtParticipants.Text;
                string date = txtDate.Text;
                string address = txtAddress.Text;

                lblMessage.Text =
                    "<br/><br/>Registration Successful!<br/><br/>" +
                    "Name: " + name + "<br/>" +
                    "Email: " + email + "<br/>" +
                    "Mobile: " + mobile + "<br/>" +
                    "Event: " + eventName + "<br/>" +
                    "Gender: " + gender + "<br/>" +
                    "Participants: " + participants + "<br/>" +
                    "Event Date: " + date + "<br/>" +
                    "Address: " + address;
            }
            else
            {
                lblMessage.Text = "";
            }
        }
    }
}