<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="backlog.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.backlog" %>

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
            <table id="Material" class="tableblue" ondblclick="sendtocheck(this)" PageSize="20" pageprompt="mypager"  showpager=true  url="MaterialHandler.ashx?method=Getbacklog">
                <tr>
                    <th id="index" width="40px" >序号</th>
                    <th id="process" width="100px" >流程名称</th>
                    <th id="ConstantValue" width="100px" abbr="link">流程节点<a href="#" onclick="sendtocheck(this)"></a></th>
                    <th id="times"  width="100px">申请月份</th>
                    <%--<th id="ApplyUser"  width="100px">申请人</th>--%>
                    <th id="currperson" width="100px">当前处理人</th>
                    <th id="ID"  class="hidden">key</th>
                    <th id="Status"  class="hidden">Status</th>
                  <%--  <th id="ApplyUserID"  class="hidden">Status</th>--%>
                </tr>
            </table>

        </div>
        <div class="pager" id="mypager"></div>
        </div>
    </form>
    <script>
        InitUI();
        SendtoURL()
       
        var usercode =<%=UserCode%>;
        function SendtoURL() {
            Ajax("MaterialHandler.ashx?method=GetProcessCount",
                "get",
                "",
                function (text) {
                    if (text) {
                       
                        if (text.total == 1) {
                           
                            window.location.href = text.data[0].url;
                        } 
                        else 
                            load("Material");
                    }
                });
        }
        function sendtocheck(obj) {
           
            if (obj.id != "Material") {
                var index = GetTrIndex(obj);
                status = document.getElementById("MaterialStatus" + index).innerText;
            }
            else {
                var row = GetRow(obj);
                var status = row.Status;
            }
            
            
           
            
           // var ApplyUser = row.ApplyUser;
            
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
                parent.addTab("MaterialApproval/MaterialApproveUpdate.aspx", "物料申请修改");
                //if (ApplyUser == usercode) {
                    
                //}
                //else {
                //    parent.addTab("MaterialApproval/ReviewerCheck.aspx", "接口人审核");
                //}
                
            }
        }
    </script>
</body>
</html>
