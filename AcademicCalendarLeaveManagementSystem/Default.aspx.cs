using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AcademicCalendarLeaveManagementSystem
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect default home to Login page for the practical
            Response.Redirect("Login.aspx");
        }
    }
}