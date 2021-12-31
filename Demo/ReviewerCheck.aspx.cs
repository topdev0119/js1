using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using System.Web.SessionState;

namespace H3C.iLab.UI.Web.MaterialApproval
{
    public partial class ReviewerCheck : System.Web.UI.Page
    {
        public string UserCode;
        protected void Page_Load(object sender, EventArgs e)
        {
            UserCode = SiteSession.UserCode;
        }
    }
}