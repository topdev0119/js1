using H3C.iLab.Business.MaterialApproval;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace H3C.iLab.UI.Web.MaterialApproval
{
    public partial class SendEamil : System.Web.UI.Page
    {
        Dictionary<string, object> WebParas = new Dictionary<string, object>();

        Dictionary<string, string> att = new Dictionary<string, string>();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["RoleIDS"] = "";
            Session["RoleName"] = "";
            Session["RoleNames"] = "";
            Session["cultureName"] = "zh-cn";
            var manager = new BMaterialApproval().GetManager().Split(' ');
            WebParas.Add("ManagerName", manager[0]);
            WebParas.Add("ManagerCode", manager[1]);
            var today = DateTime.Now.Day;
            //获取时间窗口
            var ds = new BMaterialApproval().GetEmailDay();
            var dr1 = ds.Tables[0].Select("ConstantKey='接口人审核'")[0]["ConstantValue"].ToString().Split('-');
            var dr2 = ds.Tables[0].Select("ConstantKey='项目经理审核'")[0]["ConstantValue"].ToString().Split('-');
            var dr3 = ds.Tables[0].Select("ConstantKey='部门主管审核'")[0]["ConstantValue"].ToString().Split('-');
            var dr4 = ds.Tables[0].Select("ConstantKey='计划员汇总'")[0]["ConstantValue"].ToString().Split('-');
            var dr5 = ds.Tables[0].Select("ConstantKey='综合审批'")[0]["ConstantValue"].ToString().Split('-');
            if (int.Parse(dr1[0]) <= today && today <= int.Parse(dr1[1]))//接口人审核邮催
            {
                //不规则邮催
                var dt = new BMaterialApproval().GetReviewerCheckSendEmail();
                SendEmailReviewerCheck(dt);
                //未审核邮催
                var dt2  = new BMaterialApproval().GetReviewerCheckSendEmailUnCheck();
                SendEmailReviewerUnCheck(dt2);
            }
            if (int.Parse(dr2[0]) <= today && today <= int.Parse(dr2[1]))//项目经理审核邮催
            {
                var dt = new BMaterialApproval().GetProjectManagerUnCheck();
                SendEmailProjectManagerUnCheck(dt);
            }
            if (int.Parse(dr3[0]) <= today && today <= int.Parse(dr3[1]))//部门主管审核邮催
            {
                var dt = new BMaterialApproval().GetDeptManagerUnCheck();
                SendEmailDeptManagerUnCheck(dt);
            }
            if (int.Parse(dr4[0]) <= today && today <= int.Parse(dr4[1]))//计划员审核邮催
            {
                var dt = new BMaterialApproval().GetPlanManagerUnCheck();
                SendEmailPlanManagerUnCheck(dt);
            }
            if (int.Parse(dr5[0]) <= today && today <= int.Parse(dr5[1]))//计划员审核邮催
            {
                var dt = new BMaterialApproval().GetFinalCheckUnCheck();
                SendEmailFinalCheckUnCheck(dt);
            }
            Response.Write("发送邮件完成！");
        }
        private void SendEmailFinalCheckUnCheck(DataTable dt)
        {
            string url = ConfigurationManager.AppSettings["myurl"].ToString() + "?TAB=MaterialApproval/FinalCheck.aspx&PageTitle=" + HttpUtility.UrlEncode(HttpUtility.UrlEncode("综合审批"));
            WebParas.Remove("url");
            WebParas.Add("url", url);
            var query = from t in dt.AsEnumerable()
                        group t by new { t1 = t.Field<string>("FinalReviewer") } into m
                        select new { FinalReviewer = m.Key.t1 };
            var listuser = query.ToList();

            if (listuser.Count > 0)
            {
                foreach (var user in listuser)
                {

                    var drs = dt.Select("FinalReviewer=" + user.FinalReviewer);
                    List<string> EmailTo = new List<string>();
                    DataTable EamilDt = dt.Clone();
                    object[] obj = new object[EamilDt.Columns.Count];
                    for (int k = 0; k < drs.Length; k++)
                    {
                        drs[k].ItemArray.CopyTo(obj, 0);
                        EamilDt.Rows.Add(obj);
                    }
                    EmailTo.Add(user.FinalReviewer + "@h3c.com");

                    string DoMan = user.FinalReviewer;

                    new BMaterialApproval().SendEmailEveryNight("ReviewerUnCheck", EmailTo, null, att, EamilDt, WebParas, DoMan);
                }
            }
        }
        private void SendEmailPlanManagerUnCheck(DataTable dt)
        {
            string url = ConfigurationManager.AppSettings["myurl"].ToString() + "?TAB=MaterialApproval/PlanManagerCheck.aspx&PageTitle=" + HttpUtility.UrlEncode(HttpUtility.UrlEncode("计划员汇总"));
            WebParas.Remove("url");
            WebParas.Add("url", url);
            var query = from t in dt.AsEnumerable()
                        group t by new { t1 = t.Field<string>("PlanManager") } into m
                        select new { PlanManager = m.Key.t1 };
            var listuser = query.ToList();

            if (listuser.Count > 0)
            {
                foreach (var user in listuser)
                {

                    var drs = dt.Select("PlanManager=" + user.PlanManager);
                    List<string> EmailTo = new List<string>();
                    DataTable EamilDt = dt.Clone();
                    object[] obj = new object[EamilDt.Columns.Count];
                    for (int k = 0; k < drs.Length; k++)
                    {
                        drs[k].ItemArray.CopyTo(obj, 0);
                        EamilDt.Rows.Add(obj);
                    }
                    EmailTo.Add(user.PlanManager + "@h3c.com");

                    string DoMan = user.PlanManager;

                    new BMaterialApproval().SendEmailEveryNight("ReviewerUnCheck", EmailTo, null, att, EamilDt, WebParas, DoMan);
                }
            }
        }
        private void SendEmailDeptManagerUnCheck(DataTable dt)
        {
            string url = ConfigurationManager.AppSettings["myurl"].ToString() + "?TAB=MaterialApproval/DeptManagerCheck.aspx&PageTitle=" + HttpUtility.UrlEncode(HttpUtility.UrlEncode("部门主管审核"));
            WebParas.Remove("url");
            WebParas.Add("url", url);
            var query = from t in dt.AsEnumerable()
                        group t by new { t1 = t.Field<string>("Dept2Manager") } into m
                        select new { Dept2Manager = m.Key.t1 };
            var listuser = query.ToList();

            if (listuser.Count > 0)
            {
                foreach (var user in listuser)
                {

                    var drs = dt.Select("Dept2Manager=" + user.Dept2Manager);
                    List<string> EmailTo = new List<string>();
                    DataTable EamilDt = dt.Clone();
                    object[] obj = new object[EamilDt.Columns.Count];
                    for (int k = 0; k < drs.Length; k++)
                    {
                        drs[k].ItemArray.CopyTo(obj, 0);
                        EamilDt.Rows.Add(obj);
                    }
                    EmailTo.Add(user.Dept2Manager + "@h3c.com");

                    string DoMan = user.Dept2Manager;

                    new BMaterialApproval().SendEmailEveryNight("DeptManagerUnCheck", EmailTo, null, att, EamilDt, WebParas, DoMan);
                }
            }
        }
        private void SendEmailProjectManagerUnCheck(DataTable dt)
        {
            string url = ConfigurationManager.AppSettings["myurl"].ToString() + "?TAB=MaterialApproval/ProjectManagerCheck.aspx&PageTitle=" + HttpUtility.UrlEncode(HttpUtility.UrlEncode("项目经理审核"));
            WebParas.Remove("url");
            WebParas.Add("url", url);
            var query = from t in dt.AsEnumerable()
                        group t by new { t1 = t.Field<string>("ProjectManager") } into m
                        select new { ProjectManager = m.Key.t1 };
            var listuser = query.ToList();

            if (listuser.Count > 0)
            {
                foreach (var user in listuser)
                {

                    var drs = dt.Select("ProjectManager=" + user.ProjectManager);
                    List<string> EmailTo = new List<string>();
                    DataTable EamilDt = dt.Clone();
                    object[] obj = new object[EamilDt.Columns.Count];
                    for (int k = 0; k < drs.Length; k++)
                    {
                        drs[k].ItemArray.CopyTo(obj, 0);
                        EamilDt.Rows.Add(obj);
                    }
                    EmailTo.Add(user.ProjectManager + "@h3c.com");

                    string DoMan = user.ProjectManager;

                    new BMaterialApproval().SendEmailEveryNight("ReviewerUnCheck", EmailTo, null, att, EamilDt, WebParas, DoMan);
                }
            }
        }
        private void SendEmailReviewerUnCheck(DataTable dt)
        {
            string url = ConfigurationManager.AppSettings["myurl"].ToString() + "?TAB=MaterialApproval/ProjectManagerCheck.aspx&PageTitle=" + HttpUtility.UrlEncode(HttpUtility.UrlEncode("接口人审核"));
            WebParas.Remove("url");
            WebParas.Add("url", url);
            var query = from t in dt.AsEnumerable()
                        group t by new { t1 = t.Field<string>("Reviewer") } into m
                        select new { Reviewer = m.Key.t1 };
            var listuser = query.ToList();

            if (listuser.Count > 0)
            {
                foreach (var user in listuser)
                {

                    var drs = dt.Select("Reviewer=" + user.Reviewer);
                    List<string> EmailTo = new List<string>();
                    DataTable EamilDt = dt.Clone();
                    object[] obj = new object[EamilDt.Columns.Count];
                    for (int k = 0; k < drs.Length; k++)
                    {
                        drs[k].ItemArray.CopyTo(obj, 0);
                        EamilDt.Rows.Add(obj);
                    }
                    EmailTo.Add(user.Reviewer + "@h3c.com");

                    string DoMan = user.Reviewer;

                    new BMaterialApproval().SendEmailEveryNight("ReviewerUnCheck", EmailTo, null, att, EamilDt, WebParas, DoMan);
                }
            }
        }
        private void SendEmailReviewerCheck(DataTable dt)
        {

            var query = from t in dt.AsEnumerable()
                        group t by new { t1 = t.Field<string>("ApplyUser") } into m
                        select new { ApplyUser = m.Key.t1 };
            var listuser = query.ToList();
           
            if (listuser.Count > 0)
            {
                foreach (var user in listuser)
                {

                    var drs = dt.Select("ApplyUser=" + user.ApplyUser);
                    List<string> EmailTo = new List<string>();
                    DataTable EamilDt = dt.Clone();
                    object[] obj = new object[EamilDt.Columns.Count];
                    for (int k = 0; k < drs.Length; k++)
                    {
                        drs[k].ItemArray.CopyTo(obj, 0);
                        EamilDt.Rows.Add(obj);
                    }
                    EmailTo.Add(user.ApplyUser + "@h3c.com");
                   
                    string DoMan = user.ApplyUser;

                    new BMaterialApproval().SendEmailReviewerCheck(EmailTo, null, att, EamilDt, WebParas, DoMan);
                }
            }
        }
    }
}