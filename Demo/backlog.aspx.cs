using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace H3C.iLab.UI.Web.MaterialApproval
{
    public partial class backlog : System.Web.UI.Page
    {
        protected static string UserCode;
        protected void Page_Load(object sender, EventArgs e)
        {
            UserCode = SiteSession.UserCode;
        }
    }
}