<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PMCheckDetail.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.fm.PMCheckDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <script src="../../AppContent/AppScript/boot.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table id="Material" class="tableblue" PageSize="10" showpager=true  url="../MaterialHandler.ashx?method=GetPMCheckDetail">
            <tr>
                <th id="MaterialCode" width="80px">物料编码</th>
                <th id="MaterialName" width="200px">整机名称+系列</th>
                <th id="PMCheckResult" width="60px">是否同意</th>
                <th id="PMCheckNote" width="100px">审批意见</th>
            </tr>
           </table>
        </div>
    </form>
    <script type="text/javascript">
        InitUI();
        var ItemCode = getQueryString("ItemCode");
        var ProjectManager = getQueryString("ProjectManager");
        SearchDetail();
        function SearchDetail() {
            var key = { "ItemCode": ItemCode, "ProjectManager": ProjectManager };
            load("Material", key);
        }
       
    </script>
</body>
</html>
