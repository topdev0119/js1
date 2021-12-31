using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace H3C.iLab.UI.Web.MaterialApproval
{
    public partial class MaterialSearch : System.Web.UI.Page
    {
        public string ibmpurl = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            ibmpurl = ConfigurationManager.AppSettings["ibmpurl"].ToString();
        }
    }
}