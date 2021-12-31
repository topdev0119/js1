using H3C.iLab.Business;
using H3C.iLab.Business.MaterialApproval;
using H3C.iLab.Entity.MaterialApproval;
using H3C.iLab.UI.Web.AppCode;
using H3C.Webdp.AppComponent.DAO.Permission;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.SessionState;
using System.Configuration;

namespace H3C.iLab.UI.Web.MaterialApproval
{
    /// <summary>
    /// MaterialHandler 的摘要说明
    /// </summary>
    public class MaterialHandler : IHttpHandler, IRequiresSessionState
    {
        string method,key,Usercode,LogID,AllName;

        public void ProcessRequest(HttpContext context)
        {
            
            method = context.Request["method"];
            key = context.Request["key"];
            try {
                LogID = SiteSession.UserID;
                var userds = GetUsercodeByLogID();

                Usercode = userds.Tables[0].Rows[0][0].ToString();
                AllName = userds.Tables[0].Rows[0][1].ToString();
            }
            catch (Exception e)
            {
                context.Response.Redirect("../Login.aspx");
            }
            switch (method)
            {
                case "Test": context.Response.Write(Test(context)); break; 
                case "Test2": context.Response.Write(Test2(context)); break;
                case "GetItem": context.Response.Write(GetItem(context)); break;//获取项目code和name
                case "GetTotal": context.Response.Write(GetTotal(context)); break;//获取项目code和name
                case "UseRateDetail": context.Response.Write(UseRateDetail(context)); break;//获取项目code和name
                case "UseRateTotal": context.Response.Write(UseRateTotal(context)); break;//获取项目code和name
                case "GetCheckDetail": context.Response.Write(GetCheckDetail(context)); break;//获取项目code和name
                case "GetDeptInfo": context.Response.Write(GetDeptInfo(context)); break;//获取部门信息
                case "GetApproveInfo": context.Response.Write(GetApproveInfo(context)); break;//获取物资申请计划填写信息
                case "GetRecivePlace": context.Response.Write(GetRecivePlace(context)); break;//获取收货地点
                case "GetRecivePlace2": context.Response.Write(GetRecivePlace2(context)); break;//获取收货地点
                case "GetApproveStatus": context.Response.Write(GetApproveStatus(context)); break;//获取收货地点
                case "GetUserInfo": context.Response.Write(GetUserInfo(context)); break;//获取用户信息
                case "GetMaterialInfo": context.Response.Write(GetMaterialInfo(context)); break;//获取物料信息
                case "SaveMaterialApprove": context.Response.Write(SaveMaterialApprove(context)); break;//物料计划申请保存草稿
                case "SearchMaterialDrag": context.Response.Write(SearchMaterialDrag(context)); break;//物料计划申请查询草稿
                case "SubmitMaterialApprove": context.Response.Write(SubmitMaterialApprove(context)); break;//物料计划草稿提交
                case "ExportMaterialApprove": context.Response.Write(ExportMaterialApprove(context)); break;//草稿导入
                case "SearchMaterialReviewerCheck": context.Response.Write(SearchMaterialReviewerCheck(context)); break;//查询接口人待审核信息
                case "ReviewerCheck": context.Response.Write(ReviewerCheck(context)); break;//接口人审核
                case "ReviewerCheckSendEmail": context.Response.Write(ReviewerCheckSendEmail(context)); break;//接口人审核不合规发送邮催
                case "SearchMaterialillegal": context.Response.Write(SearchMaterialillegal(context)); break;//查询物料计划接口人审核不合规
                case "SearchMaterialPMCheck": context.Response.Write(SearchMaterialPMCheck(context)); break;//查询物料计划项目经理待审核
                case "GetPMcheckTotal": context.Response.Write(GetPMcheckTotal(context)); break;//查询待项目经理审核合计
                case "SaveMaterialAuditPM": context.Response.Write(SaveMaterialAuditPM(context)); break;//项目经理修改审核数量保存
                case "PMCheckSubmit": context.Response.Write(PMCheckSubmit(context)); break;//项目经理提交
                case "GetDeptCheckView": context.Response.Write(GetDeptCheckView(context)); break;//部门主管审核视图
                case "SearchMaterialDeptCheck": context.Response.Write(SearchMaterialDeptCheck(context)); break;//部门主管审核明细
                case "GetDeptcheckTotal": context.Response.Write(GetDeptcheckTotal(context)); break;//部门主管审核明细
                case "DeptManagerCheck": context.Response.Write(DeptManagerCheck(context)); break;//项目经理提交
                case "DeptManagerCheckPL": context.Response.Write(DeptManagerCheckPL(context)); break;//项目经理提交
                case "SearchMaterialPlanManagerCheck": context.Response.Write(SearchMaterialPlanManagerCheck(context)); break;//计划员审核视图
                case "GetPlanManagercheckTotal": context.Response.Write(GetPlanManagercheckTotal(context)); break;//计划员审核汇总
                case "SaveMaterialAuditPlanManager": context.Response.Write(SaveMaterialAuditPlanManager(context)); break;//计划员修改审核数量保存
                case "PlanManagerCheckSubmit": context.Response.Write(PlanManagerCheckSubmit(context)); break;//计划员提交
                case "SearchMaterialFinalCheck": context.Response.Write(SearchMaterialFinalCheck(context)); break;//计划员审核视图
                case "GetFinalcheckTotal": context.Response.Write(GetFinalcheckTotal(context)); break;//计划员审核汇总
                case "SaveMaterialAuditFinal": context.Response.Write(SaveMaterialAuditFinal(context)); break;//计划员修改审核数量保存
                case "FinalCheckSubmit": context.Response.Write(FinalCheckSubmit(context)); break;//计划员提交
                case "MaterialApproveSearch": context.Response.Write(MaterialApproveSearch(context)); break;//计划员提交
                case "GetDicInfo": context.Response.Write(GetDicInfo(context)); break;//查询字典信息
                case "SaveDic": context.Response.Write(SaveDic(context)); break;//保存字典信息
                case "GetDeptPROJECT": context.Response.Write(GetDeptPROJECT(context)); break;//查询项目部门设置
                case "GetDept2Code": context.Response.Write(GetDept2Code(context)); break;//查询二级部门所有
                case "SaveDeptPROJECT": context.Response.Write(SaveDeptPROJECT(context)); break;//设置项目部门
                case "GetDept2Cofig": context.Response.Write(GetDept2Cofig(context)); break;//查询部门设置
                case "SaveDeptConfig": context.Response.Write(SaveDeptConfig(context)); break;//设置部门主管以及其他配置
                case "GetReportmonthTable": context.Response.Write(GetReportmonthTable(context)); break;
                case "GetReportdeptTable": context.Response.Write(GetReportdeptTable(context)); break;
                case "MaterialArchived": context.Response.Write(MaterialArchived(context)); break;
                case "CreateIbmp": context.Response.Write(CreateIbmp(context)); break;//新建要货申请
                case "ExportDeptConfig": context.Response.Write(ExportDeptConfig(context)); break;//部门配置导入
                case "ReviewerCheckUnleagle": context.Response.Write(ReviewerCheckUnleagle(context)); break;//接口人不规范审核
                case "backlog": context.Response.Write(backlog(context)); break;//接口人不规范审核
                case "ShowDownLoad": context.Response.Write(ShowDownLoad(context)); break;//接口人不规范审核
                case "GetChuangKou": context.Response.Write(GetChuangKou(context)); break;//获取窗口期
                case "updatePerson": context.Response.Write(updatePerson(context)); break;//修改当前责任人
                case "GetAllcurrperson": context.Response.Write(GetAllcurrperson(context)); break;
                case "Getbacklog": context.Response.Write(Getbacklog(context)); break;//接口人不规范审核
                case "GetProcessCount": context.Response.Write(GetProcessCount(context)); break;//接口人不规范审核
                case "GetUpdateLog": context.Response.Write(GetUpdateLog(context)); break;//接口人不规范审核
                case "ActiveMaterialPlan": context.Response.Write(ActiveMaterialPlan(context)); break;//接口人不规范审核
                case "GetPMCheckDetail": context.Response.Write(GetPMCheckDetail(context)); break;//接口人不规范审核
                case "GetCheckDetailNew": context.Response.Write(GetCheckDetailNew(context)); break;//获取审核明细
            }
            

        }
        public string GetCheckDetailNew(HttpContext context)
        {
            string ID = context.Request["ID"];
            DataSet ds = new BMaterialApproval().GetCheckDetailNew(ID);
            return ToJson(ds, method);

        }
        public string GetPMCheckDetail(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            var ItemCode = context.Request["ItemCode"];
            var ProjectManager = context.Request["ProjectManager"];
            DataSet ds = new BMaterialApproval().GetPMCheckDetail(ItemCode, ProjectManager, Usercode, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string ActiveMaterialPlan(HttpContext context)
        {
            var ID = context.Request["ID"];
            return new BMaterialApproval().ActiveMaterialPlan(ID,Usercode);
        }
        public string GetUpdateLog(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().GetUpdateLog(Usercode, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string GetProcessCount(HttpContext context)
        {

            DataSet ds = new BMaterialApproval().GetProcessCount(Usercode);
            return ToJson_count(ds, method);
        }
        public string Getbacklog(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().Getbacklog(Usercode, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string GetAllcurrperson(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().GetAllcurrperson(pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string updatePerson(HttpContext context)
        {
            var Status = context.Request["Status"];
            var CurrPerson = context.Request["CurrPerson"];
            var NewPerson = context.Request["newPersons"];
            string urlname = "";
            if (Status == "10")
            {
                urlname = HttpUtility.UrlEncode(HttpUtility.UrlEncode("接口人审核"));
            }
            else if (Status == "20")
            {
                urlname = HttpUtility.UrlEncode(HttpUtility.UrlEncode("项目经理审核"));
            }
            else if (Status == "30")
            {
                urlname = HttpUtility.UrlEncode(HttpUtility.UrlEncode("部门主管审核"));
            }
            else if (Status == "40")
            {
                urlname = HttpUtility.UrlEncode(HttpUtility.UrlEncode("计划员汇总"));
            }
            else if (Status == "50")
            {
                urlname = HttpUtility.UrlEncode(HttpUtility.UrlEncode("综合审批"));
            }
            else
            {
                urlname = HttpUtility.UrlEncode(HttpUtility.UrlEncode("物料申请修改"));
            }
            return new BMaterialApproval().updatePerson(Status,CurrPerson,NewPerson,Usercode,urlname);
        }
        public string GetChuangKou(HttpContext context)
        {
            var ConstantKey = context.Request["ConstantKey"];
            return new BMaterialApproval().GetChuangKou(ConstantKey);
        }
        public string ShowDownLoad(HttpContext context)
        {
            return new BMaterialApproval().IsManager(Usercode) && new BMaterialApproval().IsReViewer(Usercode)?"1":"0";
        }
        public string backlog(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().backlog(Usercode, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string ReviewerCheckUnleagle(HttpContext context)
        {
            string ID = context.Request["ID"];
            string ReviewResult = HttpUtility.UrlDecode(context.Request["ReviewResult"]);
            int rel = new BMaterialApproval().ReviewerCheckUnleagle(ID, ReviewResult,Usercode);
            return rel.ToString();
        }
        public string ExportDeptConfig(HttpContext context)
        {
            var file = context.Request.Files["file"];
            string lastname = file.FileName;
            if (file.FileName.LastIndexOf("\\") > 0)
            {
                lastname = file.FileName.Substring(file.FileName.LastIndexOf("\\") + 1);
            }
            string fileName = DateTime.Now.ToString("MMddHHmmss") + Guid.NewGuid() + lastname;
            string fileNamePath = HttpRuntime.AppDomainAppPath.ToString() + "UpLoadFile\\" + fileName;
            file.SaveAs(fileNamePath);
            DataTable dt = NPOIExcelHelper.Read(fileNamePath);
            if (dt == null || dt.Rows.Count == 0)
            {
                return "Excel为空！";
            }
            var rel= new BMaterialApproval().ExportDeptConfig(ref dt, Usercode);
            if (rel == -1)
            {
                var path = NPOIExcelHelper.Write(dt);
                return "Excel有错误，点击下载<a href='../Temp/" + path + "'>错误信息.xlsx</a>";
            }
            else if (rel == 0)
            {
                return "导入失败！";
            }
            return "导入成功！";
        }
        public string CreateIbmp(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            List<IbmpMaterial> list = JsonConvert.DeserializeObject<List<IbmpMaterial>>(mydata);
            string ID = "";
            string resp= new BMaterialApproval().CreateIbmp(AllName, list,ref ID);
            IbmpResponse ibmpResponse = JsonConvert.DeserializeObject<IbmpResponse>(resp);
            if (ibmpResponse.Status == "1")
            {
                new BMaterialApproval().SubmitIbmp(ID, ibmpResponse.DocId);
                return ibmpResponse.url;
            }
            else
            {
                return "0";
            }
        }
        public string GetTotal(HttpContext context)
        {
            
            DataSet ds = new BMaterialApproval().GetTotal(Usercode);
            return ToJson(ds, method);

        }
        public string GetReportmonthTable(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().GetReportmonthTable(pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string GetReportdeptTable(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().GetReportdeptTable(pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string MaterialArchived(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().MaterialArchived(pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string SaveDeptConfig(HttpContext context)
        {
            var dept2code = context.Request["dept2code"];
            var dept2manager = context.Request["dept2manager"];
            var PlanMonth = context.Request["PlanMonth"];
            var ActureArrive = context.Request["ActureArrive"];
            var Onload = context.Request["Onload"];
            var YearBudget = context.Request["YearBudget"];
            return new BMaterialApproval().SaveDeptConfig(dept2code, dept2manager, PlanMonth, ActureArrive, Onload, YearBudget, Usercode);
        }
        public string SaveDeptPROJECT(HttpContext context)
        {
            string ItemCode = context.Request["ItemCode"];
            var dept2code = context.Request["dept2code"];
            var dept2manager = context.Request["dept2manager"];
            return new BMaterialApproval().SaveDeptPROJECT(ItemCode, dept2code, dept2manager, Usercode);
        }
        public string GetDept2Code(HttpContext context)
        {
            string key = context.Request["key"];
            DataSet ds = new BMaterialApproval().GetDept2Code(key);
            return ToJson(ds, method);

        }
        public string GetDept2Cofig(HttpContext context)
        {
            string key = context.Request["key"];
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().GetDept2Cofig(key, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string GetDeptPROJECT(HttpContext context)
        {
            string key = context.Request["key"];
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().GetDeptPROJECT(key, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string SaveDic(HttpContext context)
        {
            string RemoveID = context.Request["RemoveID"];
            string ConstantType = context.Request["ConstantType"];
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            List<DicInfo> list = JsonConvert.DeserializeObject<List<DicInfo>>(mydata);
            return new BMaterialApproval().SaveDic(list,RemoveID,ConstantType, Usercode);
        }
        public string GetDicInfo(HttpContext context)
        {
            string key = context.Request["key"];
            string ConstantType = context.Request["ConstantType"];
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().GetDicInfo(key, ConstantType, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string GetCheckDetail(HttpContext context)
        {
            string ID = context.Request["ID"];
            DataSet ds = new BMaterialApproval().GetCheckDetail(ID);
            return ToJson(ds, method);

        }
        public string UseRateDetail(HttpContext context)
        {
            string ID = context.Request["ID"];
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().UseRateDetail(ID, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string UseRateTotal(HttpContext context)
        {
            string ID = context.Request["ID"];
            DataSet ds = new BMaterialApproval().UseRateTotal(ID);
            return ToJson(ds, method);

        }
        public string MaterialApproveSearch(HttpContext context)
        {
            InPara para = new InPara();
            para.ApproveStatus= context.Request["ApproveStatus"];
            para.PlanCode = context.Request["PlanCode"];
            para.MaterialInfo = HttpUtility.UrlDecode(context.Request["MaterialInfo"]);
            para.ApplyUser = context.Request["ApplyUser"];
            para.ApproveMonth = context.Request["ApproveMonth"];
            para.MaterialName = HttpUtility.UrlDecode(context.Request["MaterialName"]);
            para.DeptCode = context.Request["DeptCode"];
            para.Deptlevel = context.Request["Deptlevel"];
            para.DeptCOACode = context.Request["DeptCOACode"];
            para.ItemCode = context.Request["ItemCode"];
            para.ReceiverPlace = context.Request["ReceiverPlace"];
            para.ApproveRel = HttpUtility.UrlDecode(context.Request["ApproveRel"]);

            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().MaterialApproveSearch(para,Usercode, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string FinalCheckSubmit(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            List<MaterialNOAuditPlanManager> list = JsonConvert.DeserializeObject<List<MaterialNOAuditPlanManager>>(mydata);
            string rel = "保存成功";
            if (list.Count > 0)
            {
                rel = new BMaterialApproval().SaveMaterialAuditFinal(list, Usercode);
            }
            if (rel == "保存成功")
            {
                DataTable dt = new BMaterialApproval().GetFinalCheckLess(Usercode);
                //Thread task = new Thread(() => );
                //task.Start();//审批数量小于需求数量，发送给使用人，抄送给申报人邮件通知
                SendEmailCheckLess(dt);
                return new BMaterialApproval().FinalCheckSubmit(Usercode);
            }
            else
            {
                return rel;
            }
        }
        public string SaveMaterialAuditFinal(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            List<MaterialNOAuditPlanManager> list = JsonConvert.DeserializeObject<List<MaterialNOAuditPlanManager>>(mydata);
            return new BMaterialApproval().SaveMaterialAuditFinal(list, Usercode);
        }
        public string GetFinalcheckTotal(HttpContext context)
        {
            DataSet ds = new BMaterialApproval().GetFinalcheckTotal(Usercode);
            return ToJson(ds, method);
        }
        public string SearchMaterialFinalCheck(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().SearchMaterialFinalCheck(Usercode, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string PlanManagerCheckSubmit(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            List<MaterialNOAuditPlanManager> list = JsonConvert.DeserializeObject<List<MaterialNOAuditPlanManager>>(mydata);
            string rel = "保存成功";
            if (list.Count > 0)
            {
                rel = new BMaterialApproval().SaveMaterialAuditPlanManager(list, Usercode);
            }
            if (rel == "保存成功")
            {
                DataTable dt = new BMaterialApproval().GetPlanManagerCheckLess(Usercode);
                //Thread task = new Thread(() => );
                //task.Start();//审批数量小于需求数量，发送给使用人，抄送给申报人邮件通知
                SendEmailCheckLess(dt);
                return new BMaterialApproval().PlanManagerCheckSubmit(Usercode);
            }
            else
            {
                return rel;
            }
        }
        public string SaveMaterialAuditPlanManager(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            List<MaterialNOAuditPlanManager> list = JsonConvert.DeserializeObject<List<MaterialNOAuditPlanManager>>(mydata);
            return new BMaterialApproval().SaveMaterialAuditPlanManager(list, Usercode);
        }
        public string GetPlanManagercheckTotal(HttpContext context)
        {
            DataSet ds = new BMaterialApproval().GetPlanManagercheckTotal(Usercode);
            return ToJson(ds, method);
        }
        public string SearchMaterialPlanManagerCheck(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().SearchMaterialPlanManagerCheck(Usercode, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string DeptManagerCheckPL(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            var Dept2ReviewResult = context.Request["Dept2ReviewResult"];
            var Dept2ManagerNote = context.Request["Dept2ManagerNote"];
            Dept2ReviewResult = HttpUtility.UrlDecode(Dept2ReviewResult);
            Dept2ManagerNote = HttpUtility.UrlDecode(Dept2ManagerNote);
            List<MaterialDeptCheck> list = JsonConvert.DeserializeObject<List<MaterialDeptCheck>>(mydata);
            return new BMaterialApproval().DeptManagerCheckPL(list, Dept2ReviewResult, Dept2ManagerNote, Usercode);
        }
        public string DeptManagerCheck(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            List<MaterialDeptCheck> list = JsonConvert.DeserializeObject<List<MaterialDeptCheck>>(mydata);
            return new BMaterialApproval().DeptManagerCheck(list, Usercode);
        }
        public string GetDeptcheckTotal(HttpContext context)
        {
            DataSet ds = new BMaterialApproval().GetDeptcheckTotal(Usercode);
            return ToJson(ds, method);
        }
        public string SearchMaterialDeptCheck(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            string ItemCode = context.Request["ItemCode"];
            DataSet ds = new BMaterialApproval().SearchMaterialDeptCheck(Usercode, ItemCode, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string GetDeptCheckView(HttpContext context)
        {
            DataSet ds = new BMaterialApproval().GetDeptCheckView(Usercode);
            return ToJson_count(ds, method);
        }
        public string PMCheckSubmit(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            List<MaterialNOAuditPM> list = JsonConvert.DeserializeObject<List<MaterialNOAuditPM>>(mydata);
            string rel = "保存成功";
            if (list.Count > 0)
            { 
                rel= new BMaterialApproval().SaveMaterialAuditPM(list, Usercode);
            }
            if (rel == "保存成功")
            {
                DataTable dt= new BMaterialApproval().GetPMCheckLess(Usercode);
                //Thread task = new Thread(() => SendEmailCheckLess(dt));
                //task.Start();//审批数量小于需求数量，发送给使用人，抄送给申报人邮件通知
                SendEmailCheckLess(dt);
                return new BMaterialApproval().PMCheckSubmit(Usercode);
            }
            else
            {
                return rel;
            }
        }
        public string SaveMaterialAuditPM(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            List<MaterialNOAuditPM> list = JsonConvert.DeserializeObject<List<MaterialNOAuditPM>>(mydata);
            return new BMaterialApproval().SaveMaterialAuditPM(list, Usercode);
        }
        public string GetPMcheckTotal(HttpContext context)
        {
            DataSet ds = new BMaterialApproval().GetPMcheckTotal(Usercode);
            return ToJson(ds, method);
        }
        public string SearchMaterialPMCheck(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().SearchMaterialPMCheck(Usercode, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string SearchMaterialillegal(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().SearchMaterialillegal(key, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string ReviewerCheckSendEmail(HttpContext context)
        {
             
            var dt= new BMaterialApproval().GetReviewerCheckSendEmail();
            //Thread task = new Thread(() =>SendEmailReviewerCheck(dt) );
            //task.Start();
            SendEmailReviewerCheck(dt);
            return "发送邮件成功！";
        }
        public string ReviewerCheck(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            List<MaterialReviewerCheck> list = JsonConvert.DeserializeObject<List<MaterialReviewerCheck>>(mydata);
            return new BMaterialApproval().ReviewerCheck(list, Usercode);
        }
        public string SearchMaterialReviewerCheck(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().SearchMaterialReviewerCheck(key, pageSize, pageIndex,Usercode);
            return ToJson_count(ds, method);
        }
        public string ExportMaterialApprove(HttpContext context)
        {
            try
            {
                var file = context.Request.Files["file"];
                string lastname = file.FileName;
                if (file.FileName.LastIndexOf("\\") > 0)
                {
                    lastname = file.FileName.Substring(file.FileName.LastIndexOf("\\") + 1);
                }
                string fileName = DateTime.Now.ToString("MMddHHmmss") + Guid.NewGuid() + lastname;
                string fileNamePath = HttpRuntime.AppDomainAppPath.ToString() + "UpLoadFile\\" + fileName;
                file.SaveAs(fileNamePath);
                DataTable dt = NPOIExcelHelper.Read(fileNamePath);
                if (dt == null || dt.Rows.Count == 0)
                {
                    return "Excel为空！";
                }
                var rel = new BMaterialApproval().ExportMaterialApprove(ref dt, Usercode, LogID);
                if (rel == -1)
                {
                    var path = NPOIExcelHelper.Write(dt);
                    return "Excel有错误，点击下载<a href='../Temp/" + path + "'>错误信息.xlsx</a>";
                }
                else if (rel == 0)
                {
                    return "导入失败！";
                }
                return "导入成功！";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        public string SubmitMaterialApprove(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            var dept2code = context.Request["Dept2Code"];
            var dept3code = context.Request["Dept3Code"];
            var DeptCOA = context.Request["DeptCOA"];
            var Reviewer = context.Request["Reviewer"];
            var PlanManager = context.Request["PlanManager"];
            var FinalReviewer = context.Request["FinalReviewer"];
            var PlanCode = context.Request["PlanCode"];
            var RemoveID = context.Request["RemoveID"];
            var Status = context.Request["Status"];
            List<MaterialApprovalPlanInfo> list = JsonConvert.DeserializeObject<List<MaterialApprovalPlanInfo>>(mydata);
            string rel = "保存草稿成功";
            if (list.Count > 0 || RemoveID != "")
            { 
                 rel=new BMaterialApproval().SaveMaterialApprove(list, dept2code, dept3code, DeptCOA, Reviewer, PlanManager, FinalReviewer, PlanCode, RemoveID, Usercode);
            }
            if (rel == "保存草稿成功")
            {
                return new BMaterialApproval().SubmitMaterialApprove(PlanCode, Usercode,Status);
            }
            else
            {
                return rel;
            }

        }
        public string SearchMaterialDrag(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().SearchMaterialDrag(key, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string SaveMaterialApprove(HttpContext context)
        {
            var aa = context.Request["data"];
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            var dept2code= context.Request["Dept2Code"];
            var dept3code = context.Request["Dept3Code"];
            var DeptCOA= context.Request["DeptCOA"];
            var Reviewer= context.Request["Reviewer"];
            var PlanManager = context.Request["PlanManager"];
            var FinalReviewer = context.Request["FinalReviewer"];
            var PlanCode= context.Request["PlanCode"]; 
             var RemoveID = context.Request["RemoveID"];
            List<MaterialApprovalPlanInfo> list = JsonConvert.DeserializeObject<List<MaterialApprovalPlanInfo>>(mydata);
            return new BMaterialApproval().SaveMaterialApprove(list,dept2code, dept3code, DeptCOA, Reviewer, PlanManager, FinalReviewer, PlanCode, RemoveID,Usercode);
        }
        public string GetMaterialInfo(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().GetMaterialInfo(key,pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string GetDeptInfo(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().GetDeptInfo(key, pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string GetUserInfo(HttpContext context)
        {

            DataSet ds = new BMaterialApproval().GetUserInfo(key);
            return ToJson(ds, method);
        }
        public string GetRecivePlace(HttpContext context)
        {

            DataSet ds = new BMaterialApproval().GetRecivePlace();
            return ToJson(ds, method);
        }
        public string GetRecivePlace2(HttpContext context)
        {

            DataSet ds = new BMaterialApproval().GetRecivePlace2();
            return ToJson(ds, method);
        }
        public string GetApproveStatus(HttpContext context)
        {

            DataSet ds = new BMaterialApproval().GetApproveStatus();
            return ToJson(ds, method);
        }
        public string GetApproveInfo(HttpContext context)
        {
            var obj = new BMaterialApproval().GetApproveInfo(LogID);
            return JsonConvert.SerializeObject(obj);
        }
        public string GetItem(HttpContext context)
        {

            DataSet ds = new BMaterialApproval().GetItem(key);
            return ToJson(ds, method);
        }
        public DataSet GetUsercodeByLogID()
        { 
        return new BMaterialApproval().GetUsercodeByLogID(LogID);
        }
        public string Test(HttpContext context)
        {
            int pageSize = int.Parse(context.Request["PageSize"]);
            int pageIndex = int.Parse(context.Request["PageIndex"]);
            DataSet ds = new BMaterialApproval().Test(pageSize, pageIndex);
            return ToJson_count(ds, method);
        }
        public string Test2(HttpContext context)
        {
            var mydata = HttpUtility.UrlDecode(context.Request["data"]);
            List<TestData> list = JsonConvert.DeserializeObject<List<TestData>>(mydata);
            return "123";
        }
        private void SendEmailReviewerCheck(DataTable dt)
        {

            string url = ConfigurationManager.AppSettings["myurl"].ToString() + "?TAB=MaterialApproval/MaterialApproveUpdate.aspx&PageTitle=" + HttpUtility.UrlEncode(HttpUtility.UrlEncode("物料申请修改"));
            var query = from t in dt.AsEnumerable()
                        group t by new { t1 = t.Field<string>("ApplyUser") } into m
                        select new { ApplyUser = m.Key.t1 };
            var listuser = query.ToList();
            if (listuser.Count > 0)
            {
                foreach (var user in listuser)
                {
                   
                    var drs = dt.Select("ApplyUser="+user.ApplyUser);
                    List<string> EmailTo = new List<string>();
                    DataTable EamilDt = dt.Clone();
                    object[] obj = new object[EamilDt.Columns.Count];
                    for (int k = 0; k < drs.Length; k++)
                    {
                        drs[k].ItemArray.CopyTo(obj, 0);
                        EamilDt.Rows.Add(obj);
                    }
                    EmailTo.Add(user.ApplyUser + "@h3c.com");
                    Dictionary<string, object> WebParas = new Dictionary<string, object>();
                    var manager = new BMaterialApproval().GetManager().Split(' ');
                    WebParas.Add("ManagerName", manager[0]);
                    WebParas.Add("ManagerCode", manager[1]);
                    WebParas.Add("url", url);
                    var att = new Dictionary<string, string>();
                    string DoMan = user.ApplyUser;

                    new BMaterialApproval().SendEmailReviewerCheck(EmailTo, null, att, EamilDt, WebParas, DoMan);
                    //EmailFun.SendEmailReviewerCheck(EmailTo, null, new Dictionary<string, string>(), EamilDt, WebParas, DoMan);
                   // StringBuilder strbody = new StringBuilder();
                    //string tables = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head>    <title>启动报告</title>    <style type=\"text/css\">        .tableblue        {            border-collapse: collapse;            border: 1px #BCD0E8 solid;            font-size: 10pt;             font-style: normal;            color: #777777;            width: 98%;            margin: 5,5,5,5;            padding-left: 5px;            padding-top: 5px;        }  .tableblue td {            padding-left: 2px;            padding-right: 2px;            border: 1px #BCD0E8 solid;            font-style: normal;            color: #000000;        }</style></head><body><div id=\"trackAffair\" style=\"margin: 5px 0px 0px 5px;\">[?content?]</div></body></html>";
                    //strbody.Append("<table class=\"tableblue\" ><tr><td>整机名称+系列</td><td>物料编码</td><td>物料描述</td><td>状态</td><td>用途</td><td>项目编码</td><td>使用人</td><td>到货地点</td><td>规范备注</td></tr>");
                    //foreach (var dr in drs)
                    //{
                    //    strbody.Append("<tr>");
                    //    strbody.Append("<td>"+dr["MaterialName"]+"</td>");
                    //    strbody.Append("<td>" + dr["MaterialCode"] + "</td>");
                    //    strbody.Append("<td>" + dr["MaterialInfo"] + "</td>");
                    //    strbody.Append("<td>" + dr["MaterialStauts"] + "</td>");
                    //    strbody.Append("<td>" + dr["Purpose"] + "</td>");
                    //    strbody.Append("<td>" + dr["ItemCode"] + "</td>");
                    //    strbody.Append("<td>" + dr["RequiredUser"] + "</td>");
                    //    strbody.Append("<td>" + dr["ReceiverPlace"] + "</td>");
                    //    strbody.Append("<td>" + dr["ReviewNote"] + "</td>");
                    //    strbody.Append("</tr>");
                    //}
                    //strbody.Append("</table>");
                    //string html= tables.Replace("[?content?]", strbody.ToString());
                    //EmailUtility.SendMail(user.ApplyUser + "@h3c.com", "", "您的物料申请电子流有不规范申请，请修改", html);
                }
            }
        }
        private void SendEmailCheckLess(DataTable dt)
        {
            //string url = ConfigurationManager.AppSettings["myurl"].ToString() + "?TAB=MaterialApproval/MaterialApproveUpdate.aspx&PageTitle=" + HttpUtility.UrlEncode(HttpUtility.UrlEncode("物料申请修改"));
            var query = from t in dt.AsEnumerable()
                        group t by new { t1 = t.Field<string>("ApplyUser"),t2=t.Field<string>("RequiredUserID") } into m
                        select new { ApplyUser = m.Key.t1, RequiredUserID= m.Key.t2 };
            var listuser = query.ToList();
            if (listuser.Count > 0)
            {
                foreach (var user in listuser)
                {
                    StringBuilder strbody = new StringBuilder();
                    var drs = dt.Select("ApplyUser=" + user.ApplyUser+ " and RequiredUserID=" + user.RequiredUserID);
                    List<string> EmailTo = new List<string>();
                    List<string> CC = new List<string>();
                    CC.Add(user.ApplyUser + "@h3c.com");
                    DataTable EamilDt = dt.Clone();
                    object[] obj = new object[EamilDt.Columns.Count];
                    for (int k = 0; k < drs.Length; k++)
                    {
                        drs[k].ItemArray.CopyTo(obj, 0);
                        EamilDt.Rows.Add(obj);
                    }
                    EmailTo.Add(user.RequiredUserID + "@h3c.com");
                    Dictionary<string, object> WebParas = new Dictionary<string, object>();
                    var manager = new BMaterialApproval().GetManager().Split(' ');
                    WebParas.Add("ManagerName", manager[0]);
                    WebParas.Add("ManagerCode", manager[1]);
                    //WebParas.Add("url", url);
                    var att = new Dictionary<string, string>();
                    string DoMan = user.ApplyUser;
                    new BMaterialApproval().SendEmailCheckLess(EmailTo, CC, att, EamilDt, WebParas, DoMan);

                    //string tables = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head>    <title>物料申请电子流</title>    <style type=\"text/css\">        .tableblue        {            border-collapse: collapse;            border: 1px #BCD0E8 solid;            font-size: 10pt;             font-style: normal;            color: #777777;            width: 98%;            margin: 5,5,5,5;            padding-left: 5px;            padding-top: 5px;        }  .tableblue td {            padding-left: 2px;            padding-right: 2px;            border: 1px #BCD0E8 solid;            font-style: normal;            color: #000000;        }</style></head><body><div id=\"trackAffair\" style=\"margin: 5px 0px 0px 5px;\">[?content?]</div></body></html>";
                    //strbody.Append("<table class=\"tableblue\" ><tr><td>整机名称+系列</td><td>物料编码</td><td>物料描述</td><td>状态</td><td>用途</td><td>项目编码</td><td>使用人</td><td>到货地点</td><td>申请数量</td><td>审核数量</td><td>备注</td></tr>");
                    //foreach (var dr in drs)
                    //{
                    //    strbody.Append("<tr>");
                    //    strbody.Append("<td>" + dr["MaterialName"] + "</td>");
                    //    strbody.Append("<td>" + dr["MaterialCode"] + "</td>");
                    //    strbody.Append("<td>" + dr["MaterialInfo"] + "</td>");
                    //    strbody.Append("<td>" + dr["MaterialStauts"] + "</td>");
                    //    strbody.Append("<td>" + dr["Purpose"] + "</td>");
                    //    strbody.Append("<td>" + dr["ItemCode"] + "</td>");
                    //    strbody.Append("<td>" + dr["RequiredUser"] + "</td>");
                    //    strbody.Append("<td>" + dr["ReceiverPlace"] + "</td>");
                    //    strbody.Append("<td>" + dr["Requireds"] + "</td>");
                    //    strbody.Append("<td>" + dr["RequiredsAudit"] + "</td>");
                    //    strbody.Append("<td>" + dr["Note"] + "</td>");
                    //    strbody.Append("</tr>");
                    //}
                    //strbody.Append("</table>");
                    //string html = tables.Replace("[?content?]", strbody.ToString());
                    //EmailUtility.SendMail(user.RequiredUserID + "@h3c.com", user.ApplyUser + "@h3c.com", "您的物料申请电子流有审核扣除，请知悉", html);
                }
            }
        }
        #region
        public string ToJson(DataSet ds, string Method="")
        {

            string datajson = ToJson(ds);
            datajson = datajson.Replace("Table", "data").Replace("System.Byte[]", "0");
            datajson = datajson.Substring(8, datajson.Length - 9);
            return datajson;

        }
        public string ToJson_count(DataSet ds, string Method = "")
        {

            int count = ds.Tables[0].Rows.Count== 0 ? 0 : int.Parse(ds.Tables[0].Rows[0]["row_count"].ToString());
            //int count = 1;
            string datajson = ToJson(ds);
            datajson = datajson.Replace("Table", "data").Replace("System.Byte[]", "0");
            datajson = "{\"total\":\"" + count + "\"," + datajson.Substring(1, datajson.Length - 1);
            return datajson;
             
        }
        public static string ToJson(DataSet dataSet)
        {
            string jsonString = "{";
            foreach (DataTable table in dataSet.Tables)
            {
                jsonString += "\"" + table.TableName + "\":" + ToJson(table) + ",";
            }
            jsonString = jsonString.TrimEnd(',');
            jsonString = jsonString.Replace("Table", "data").Replace("System.Byte[]", "0");
            return jsonString + "}";
        }
        public static string ToJson(DataTable dt)
        {
            StringBuilder jsonString = new StringBuilder();

            if (dt.Rows.Count == 0)
            {
                jsonString.Append("[{}]");
                return jsonString.ToString();
            }

            jsonString.Append("[");
            DataRowCollection drc = dt.Rows;
            for (int i = 0; i < drc.Count; i++)
            {
                jsonString.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string strKey = dt.Columns[j].ColumnName;
                    string strValue = drc[i][j].ToString();
                    Type type = dt.Columns[j].DataType;
                    jsonString.Append("\"" + strKey + "\":");
                    strValue = StringFormat(strValue, type);
                    if (j < dt.Columns.Count - 1)
                    {
                        jsonString.Append(strValue + ",");
                    }
                    else
                    {
                        jsonString.Append(strValue);
                    }
                }
                jsonString.Append("},");
            }
            jsonString.Remove(jsonString.Length - 1, 1);
            jsonString.Append("]");
            return jsonString.ToString();
        }
        private static string StringFormat(string str, Type type)
        {
            if (type == typeof(string))
            {
                str = String2Json(str);
                str = "\"" + str + "\"";
            }
            else if (type == typeof(DateTime))
            {
                if (str != "")
                {
                    str = "\"" + Convert.ToDateTime(str).ToString() + "\"";
                }
            }
            else if (type == typeof(bool))
            {
                str = str.ToLower();
            }

            if (str.Length == 0)
                str = "\"\"";

            return str;
        }
        private static string String2Json(String s)
        {
            System.Text.StringBuilder sb = new StringBuilder();
            for (int i = 0; i < s.Length; i++)
            {
                char c = s.ToCharArray()[i];

                switch (c)
                {
                    case '\"':
                        sb.Append("\\\""); break;
                    case '\\':
                        sb.Append("\\\\"); break;
                    case '/':
                        sb.Append("\\/"); break;
                    case '\b':
                        sb.Append("\\b"); break;
                    case '\f':
                        sb.Append("\\f"); break;
                    case '\n':
                        sb.Append("\\n"); break;
                    case '\r':
                        sb.Append("\\r"); break;
                    case '\t':
                        sb.Append("\\t"); break;
                    default:
                        sb.Append(c); break;
                }
            }
            return sb.ToString();
        }
        #endregion
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}