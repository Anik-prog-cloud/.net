using System;
using System.Web.UI;

namespace AcademicCalendarLeaveManagementSystem
{
    public partial class Leave : Page
    {
        protected System.Web.UI.WebControls.Label lblUserInfo;
        protected System.Web.UI.WebControls.TextBox txtFrom;
        protected System.Web.UI.WebControls.TextBox txtTo;
        protected System.Web.UI.WebControls.TextBox txtReason;
        protected System.Web.UI.WebControls.Label lblResult;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblUserInfo.Text = "Applying leave for: " + Session["User"];
            }
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            // Simple no-db simulation: just show confirmation
            lblResult.Text = "Leave applied successfully.";
        }
    }
}
