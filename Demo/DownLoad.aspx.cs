using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using H3C.iLab.Business.MaterialApproval;
using H3C.iLab.Entity.MaterialApproval;
using H3C.iLab.UI.Web.AppCode;

namespace H3C.iLab.UI.Web.MaterialApproval
{
    public partial class DownLoad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string method = Request["method"];
            switch (method)
            {
                case "DownLoadDeptConfig": DownLoadDeptConfig(); break;
                case "DownLoadSearchMaterial": DownLoadSearchMaterial(); break;
            }
        }
        public void DownLoadDeptConfig()
        {
            DataSet ds = new BMaterialApproval().DownLoadDeptConfig();
            NPOIExcelHelper.DownLoad(ds.Tables[0]);
        }
        public void DownLoadSearchMaterial()
        {
            string key = Request["key"];
            InPara para = new InPara();
            para.ApproveStatus = Request["ApproveStatus"];
            para.PlanCode = Request["PlanCode"];
            para.MaterialInfo = Request["MaterialInfo"];
            para.ApplyUser = Request["ApplyUser"];
            para.ApproveMonth = Request["ApproveMonth"];
            para.MaterialName = Request["MaterialName"];
            para.DeptCode = Request["DeptCode"];
            para.Deptlevel = Request["Deptlevel"];
            para.DeptCOACode = Request["DeptCOACode"];
            para.ItemCode = Request["ItemCode"];
            para.ReceiverPlace = Request["ReceiverPlace"];
            para.ApproveRel = Request["ApproveRel"];
            DataSet ds = new BMaterialApproval().DownLoadSearchMaterial(para,SiteSession.UserCode);
            NPOIExcelHelper.DownLoad(ds.Tables[0]);
        }
    }
}