<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckDetail.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.fm.CheckDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="../../AppContent/AppScript/boot.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <span style="padding-left:1%;font-size:14px;font-weight:700">物料计划审批电子流</span>
        <span class="right">
            当前状态：<span id="Status"></span>&nbsp;&nbsp;&nbsp;&nbsp;
            申请人：<span id="ApplyUser"></span>&nbsp;&nbsp;&nbsp;&nbsp;
            电子流编号：<span id="PlanCode"></span>&nbsp;&nbsp;&nbsp;&nbsp;
            申请时间：<span id="ApplyTime"></span>
        </span>
        <div id="MaterialPlan" >
            <div class="arrow" dropdown="MaterialPlanTable" drop="true"><span class="arrow-font">申请列表</span></div>
            <div id="MaterialPlanTable" class="arrow-list">
                <table class="tableList">
                    <tr>
                        <td class="FristTd">整机名称+系列</td>
                        <td id="MaterialName" colspan="3"></td>
                         <td class="FristTd">物料描述</td>
                        <td id="MaterialInfo" colspan="3"></td>
                    </tr>
                    <tr>
                        <td class="FristTd">物料编码</td>
                        <td id="MaterialCode"></td>
                        <td class="FristTd">二级部门</td>
                        <td id="dept2name"></td>
                        <td class="FristTd">三级部门</td>
                        <td id="dept3name"></td>
                        <td class="FristTd">申请使用人</td>
                        <td id="RequiredUser"></td>
                    </tr>
                    <tr>
                        <td class="FristTd">申请数量</td>
                        <td id="RequeirdNO"></td>
                        <td class="FristTd">单价</td>
                        <td id="Price"></td>
                        <td class="FristTd">项目编码</td>
                        <td id="ItemCode"></td>
                        <td class="FristTd">项目经理</td>
                        <td id="ProjectManager"></td>
                    </tr>
                    <tr>
                        
                        <td class="FristTd">用途</td>
                        <td id="Purpose" colspan="3"></td> 
                        <td class="FristTd">到货地点</td>
                        <td id="ReceiverPlace" colspan="3"></td>
                    </tr>
                    <tr>
                        <td class="FristTd">备注</td>
                        <td id="MaterialNote" colspan="7"></td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="ReviewCheck" style="display:none">
            <div class="arrow" dropdown="ReviewCheckTable"><span class="arrow-font">接口人审核（<span id="Reviewer"></span>）</span></div>
            <div id="ReviewCheckTable" class="arrow-list">
                <table class="tableList">
                    <tr>
                        <td class="FristTd">审批结果</td>
                        <td id="ReviewResult" colspan="3"></td>  
                    </tr>
                    <tr>
                        <td class="FristTd">审批意见</td>
                        <td id="ReviewNote" colspan="3"></td>  
                    </tr>
                    <tr>
                        <td class="FristTd">审批人</td>
                        <td id="Reviewer2" ></td>   
                        <td class="FristTd">审批时间</td>
                        <td id="ReviewTime"></td>  
                    </tr>
                </table>
            </div>
        </div>
        <div id="PMCheck" style="display:none">
            <div class="arrow" dropdown="PMCheckTable"><span class="arrow-font">项目经理审核（<span id="ProjectManager2"></span>）</span></div>
            <div id="PMCheckTable" class="arrow-list">
                <table class="tableList">
                    <tr>
                        <td class="FristTd">同意申购数量</td>
                        <td id="PMCheckNO" colspan="3"></td>  
                    </tr>
                    <tr>
                        <td class="FristTd">审批意见</td>
                        <td id="PMCheckNote" colspan="3"></td>  
                    </tr>
                    <tr>
                        <td class="FristTd">审批人</td>
                        <td id="ProjectManager3" ></td>   
                        <td class="FristTd">审批时间</td>
                        <td id="PMCheckTime"></td>  
                    </tr>
                </table>
            </div>
        </div>
        <div id="DeptManagerCheck" style="display:none">
            <div class="arrow" dropdown="DeptManagerCheckTable"><span class="arrow-font">部门主管审核（<span id="Dept2Manager"></span>）</span></div>
            <div id="DeptManagerCheckTable" class="arrow-list">
                <table class="tableList">
                    <tr>
                        <td class="FristTd">审批结果</td>
                        <td id="Dept2ReviewResult" colspan="3"></td>  
                    </tr>
                    <tr>
                        <td class="FristTd">审批意见</td>
                        <td id="Dept2ManagerNote" colspan="3"></td>  
                    </tr>
                    <tr>
                        <td class="FristTd">审批人</td>
                        <td id="Dept2Manager2" ></td>   
                        <td class="FristTd">审批时间</td>
                        <td id="Dept2ManagerTime"></td>  
                    </tr>
                </table>
            </div>
        </div>
        <div id="PlanManagerCheck" style="display:none">
            <div class="arrow" dropdown="PlanManagerCheckTable"><span class="arrow-font">计划员审核（<span id="PlanManager"></span>）</span></div>
            <div id="PlanManagerCheckTable" class="arrow-list">
                <table class="tableList">
                    <tr>
                        <td class="FristTd">同意申购数量</td>
                        <td id="PlanManagerCheckNO" colspan="3"></td>  
                    </tr>
                    <tr>
                        <td class="FristTd">审批意见</td>
                        <td id="PlanManagerNote" colspan="3"></td>  
                    </tr>
                    <tr>
                        <td class="FristTd">审批人</td>
                        <td id="PlanManager2" ></td>   
                        <td class="FristTd">审批时间</td>
                        <td id="PlanManagerTime"></td>  
                    </tr>
                </table>
            </div>
        </div>
        <div id="FinalReviewerCheck" style="display:none">
            <div class="arrow" dropdown="FinalReviewerCheckTable"><span class="arrow-font">计划员审核（<span id="FinalReviewer"></span>）</span></div>
            <div id="FinalReviewerCheckTable" class="arrow-list">
                <table class="tableList">
                    <tr>
                        <td class="FristTd">同意申购数量</td>
                        <td id="FinalReviewerCheckNO" colspan="3"></td>  
                    </tr>
                    <tr>
                        <td class="FristTd">审批意见</td>
                        <td id="FinalReviewNote" colspan="3"></td>  
                    </tr>
                    <tr>
                        <td class="FristTd">审批人</td>
                        <td id="FinalReviewer2" ></td>   
                        <td class="FristTd">审批时间</td>
                        <td id="FinalReviewTime"></td>  
                    </tr>
                </table>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        InitUI();
        var ID = getQueryString("ID");
        SearchDetail();
        function SearchDetail() {
            var key = { "ID": ID };
            Ajax("../MaterialHandler.ashx?method=GetCheckDetailNew",
                "get",
                key,
                function (data) {
                    if (data) {
                        dt = data[0];
                        var Status = dt.Status;
                        document.getElementById("Status").innerText = dt.StatusCN;
                        document.getElementById("ApplyUser").innerText = dt.ApplyUser;
                        document.getElementById("PlanCode").innerText = dt.PlanCode;
                        document.getElementById("ApplyTime").innerText = dt.ApplyTime;
                        document.getElementById("MaterialName").innerText = dt.MaterialName;
                        document.getElementById("MaterialInfo").innerText = dt.MaterialInfo;
                        document.getElementById("MaterialCode").innerText = dt.MaterialCode;
                        document.getElementById("dept2name").innerText = dt.dept2code;
                        document.getElementById("dept3name").innerText = dt.dept3code;
                        document.getElementById("RequiredUser").innerText = dt.RequiredUser;
                        document.getElementById("RequeirdNO").innerText = dt.RequeirdNO;
                        document.getElementById("Price").innerText = dt.Price;
                        document.getElementById("ItemCode").innerText = dt.ItemCode;
                        document.getElementById("ProjectManager").innerText = dt.ProjectManager;
                        document.getElementById("ProjectManager2").innerText = dt.ProjectManager;
                        document.getElementById("ProjectManager3").innerText = dt.ProjectManager;
                        document.getElementById("Purpose").innerText = dt.Purpose;
                        document.getElementById("ReceiverPlace").innerText = dt.ReceiverPlace;
                        document.getElementById("MaterialNote").innerText = dt.MaterialNote;

                        document.getElementById("Reviewer").innerText = dt.Reviewer;
                        document.getElementById("Reviewer2").innerText = dt.Reviewer;
                        document.getElementById("ReviewResult").innerText = dt.ReviewResult;
                        document.getElementById("ReviewNote").innerText = dt.ReviewNote;
                        document.getElementById("ReviewTime").innerText = dt.ReviewTime;

                        document.getElementById("PMCheckNO").innerText = dt.PMCheckNO;
                        document.getElementById("PMCheckNote").innerText = dt.PMCheckNote;
                        document.getElementById("PMCheckTime").innerText = dt.PMCheckTime;

                        document.getElementById("Dept2Manager").innerText = dt.Dept2Manager;
                        document.getElementById("Dept2Manager2").innerText = dt.Dept2Manager;
                        document.getElementById("Dept2ReviewResult").innerText = dt.Dept2ReviewResult;
                        document.getElementById("Dept2ManagerNote").innerText = dt.Dept2ManagerNote;
                        document.getElementById("Dept2ManagerTime").innerText = dt.Dept2ManagerTime;

                        document.getElementById("PlanManager").innerText = dt.PlanManager;
                        document.getElementById("PlanManager2").innerText = dt.PlanManager;
                        document.getElementById("PlanManagerCheckNO").innerText = dt.PlanManagerCheckNO;
                        document.getElementById("PlanManagerNote").innerText = dt.PlanManagerNote;
                        document.getElementById("PlanManagerTime").innerText = dt.PlanManagerTime;

                        document.getElementById("FinalReviewer").innerText = dt.FinalReviewer;
                        document.getElementById("FinalReviewer2").innerText = dt.FinalReviewer;
                        document.getElementById("FinalReviewerCheckNO").innerText = dt.FinalReviewerCheckNO;
                        document.getElementById("FinalReviewNote").innerText = dt.FinalReviewNote;
                        document.getElementById("FinalReviewTime").innerText = dt.FinalReviewTime;
                        if (Status > 10) {
                            document.getElementById("ReviewCheck").style.display = "";
                        }
                        if (Status > 20) {
                            document.getElementById("PMCheck").style.display = "";
                        }
                        if (Status > 30) {
                            document.getElementById("DeptManagerCheck").style.display = "";
                        }
                        if (Status > 40) {
                            document.getElementById("PlanManagerCheck").style.display = "";
                        }
                        if (Status > 50) {
                            document.getElementById("FinalReviewerCheck").style.display = "";
                        }
                    }
                     
                })
        }
       
    </script>
</body>
</html>
