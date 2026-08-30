using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AcademicCalendarLeaveManagementSystem
{
    public partial class Calendar : Page
    {
        protected System.Web.UI.WebControls.Calendar calAcademic;
        protected System.Web.UI.WebControls.Label lblWelcome;
        protected System.Web.UI.WebControls.Label lblSelectedDate;
        protected System.Web.UI.WebControls.Literal litEvents;

        // simple in-memory events
        private Dictionary<DateTime, string> Events => new Dictionary<DateTime, string>
        {
            { new DateTime(DateTime.Now.Year, 1, 26), "Republic Day" },
            { new DateTime(DateTime.Now.Year, 8, 15), "Independence Day" },
            { new DateTime(DateTime.Now.Year, 10, 2), "Gandhi Jayanti" },
            { new DateTime(DateTime.Now.Year, 12, 25), "Christmas" }
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblWelcome.Text = "Logged in as: " + Session["User"];
                // show events list
                litEvents.Text = "<h5>Academic Events / Holidays</h5><ul>";
                foreach (var kv in Events)
                {
                    litEvents.Text += $"<li>{kv.Key.ToString("dd MMM yyyy")}: {kv.Value}</li>";
                }
                litEvents.Text += "</ul>";
            }
        }

        protected void calAcademic_SelectionChanged(object sender, EventArgs e)
        {
            DateTime sel = calAcademic.SelectedDate;
            lblSelectedDate.Text = "Selected date: " + sel.ToLongDateString();
            if (Events.TryGetValue(sel.Date, out string ev))
            {
                lblSelectedDate.Text += " - " + ev;
            }
        }

        protected void calAcademic_DayRender(object sender, DayRenderEventArgs e)
        {
            if (Events.TryGetValue(e.Day.Date, out string ev))
            {
                // mark event days
                e.Cell.BackColor = System.Drawing.Color.LightGoldenrodYellow;
                // append event name
                e.Cell.Controls.Add(new Literal { Text = $"<br/><small class=\"text-muted\">{ev}</small>" });
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
