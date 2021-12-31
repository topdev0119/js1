<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="backlog2.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.backlog2" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="../AppContent/AppScript/boot.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <h3 style="text-align: center">资源计划电子流待办</h3>
        <div>
            <div>
            <table id="Material" class="tableblue" ondblclick="sendtocheck(this)" PageSize="20" pageprompt="mypager"  showpager=true  url="MaterialHandler.ashx?method=backlog">
                <tr>
                    <th id="index" width="40px" >序号</th>
                    <th id="StatusCN" width="80px">当前状态</th>
                    <th id="MaterialName" width="200px" >整机名称+系列</th>
                    <th id="RequiredUser" width="100px">申请使用人</th>
                    <th id="MaterialCode" width="80px" >物料编码</th>
                    <th id="MaterialInfo" width="300px" >物料描述</th>
                    <th id="MaterialStauts" width="40px" >状态</th>
                    <th id="PlanMonth" width="60px" >申请月份</th>
                    <th id="RequeirdNO" width="60px" >需求数量</th>
                    <th id="RequeirdNOAudit" width="80px" >评审后数量</th>
                    <th id="AuditNotPass" width="80px" >评审未通过</th>
                    <th id="Purpose" width="200px" >用途</th>
                    <th id="Price" width="100px" >单价</th>
                    <th id="MtotalMoney" width="100px" >申购金额</th>
                    <th id="MActualMoney" width="100px" >审批后金额</th>
                    <th id="dept2name" width="100px" >二级部门</th>
                    <th id="dept3name" width="100px" >三级部门</th>
                    <th id="ItemCode" width="100px">项目编码</th>
                   
                    <th id="ProjectManager" width="100px">项目经理</th>
                    <th id="ReceiverPlace" width="80px">到货地点</th>
                    <th id="Status"  class="hidden">Status</th>
                    <th id="ID"  class="hidden">key</th>
                    <th id="ApplyUser"  class="hidden">ApplyUser</th>
                </tr>
            </table>

        </div>
        <div class="pager" id="mypager"></div>
        </div>
    </form>
    <script>
        InitUI();
        load("Material");
        var usercode =<%=UserCode%>;
        function sendtocheck(obj) {
            var row = GetRow(obj);
           
            var status = row.Status;
            var ApplyUser = row.ApplyUser;
            
            if (status == "9") {
                parent.addTab("MaterialApproval/NewMaterial.aspx", "新建物料申请");
            }
            else if (status == "10") {
                parent.addTab("MaterialApproval/ReviewerCheck.aspx", "接口人审核");
            }
            else if (status == "20") {
                parent.addTab("MaterialApproval/ProjectManagerCheck.aspx", "项目经理审核");
            }
            else if (status == "30") {
                parent.addTab("MaterialApproval/DeptManagerCheck.aspx", "部门主管审核");
            }
            else if (status == "40") {
                parent.addTab("MaterialApproval/PlanManagerCheck.aspx", "计划员汇总");
            }
            else if (status == "50") {
                parent.addTab("MaterialApproval/FinalCheck.aspx", "综合审批");
            }
            else if (status == "8") {
                if (ApplyUser == usercode) {
                    parent.addTab("MaterialApproval/MaterialApproveUpdate.aspx", "物料申请修改");
                }
                else {
                    parent.addTab("MaterialApproval/ReviewerCheck.aspx", "接口人审核");
                }
                
            }
        }
    </script>
</body>
</html>
