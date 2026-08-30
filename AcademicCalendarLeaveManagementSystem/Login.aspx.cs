using System;
using System.Web;
using System.Web.UI;

namespace AcademicCalendarLeaveManagementSystem
{
    public partial class Login : Page
    {
        protected System.Web.UI.WebControls.TextBox txtUsername;
        protected System.Web.UI.WebControls.TextBox txtPassword;
        protected System.Web.UI.WebControls.CheckBox chkRemember;
        protected System.Web.UI.WebControls.Label lblMessage;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null)
            {
                Response.Redirect("Calendar.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // If cookie exists, prefill username
                HttpCookie c = Request.Cookies["ACLM_Username"];
                if (c != null && !string.IsNullOrEmpty(c.Value))
                {
                    txtUsername.Text = c.Value;
                    chkRemember.Checked = true;
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string user = (txtUsername?.Text ?? string.Empty).Trim();
            string pass = txtPassword?.Text ?? string.Empty;

            if (user == "admin" && pass == "1234")
            {
                Session["User"] = user;

                if (chkRemember != null && chkRemember.Checked)
                {
                    HttpCookie cookie = new HttpCookie("ACLM_Username", user);
                    cookie.Expires = DateTime.Now.AddDays(7);
                    Response.Cookies.Add(cookie);
                }
                else
                {
                    HttpCookie cookie = new HttpCookie("ACLM_Username", string.Empty);
                    cookie.Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies.Add(cookie);
                }

                Response.Redirect("Calendar.aspx");
                return;
            }

            if (lblMessage != null)
                lblMessage.Text = "Invalid username or password.";
        }
    }
}
