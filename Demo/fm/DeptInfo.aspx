<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeptInfo.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.fm.DeptInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../AppContent/AppScript/boot.js"></script>
</head>
<body>
    <form id="form2" runat="server">
        <div>
            <input type="text" id="key" class="tdinputText" onenter="search"/>
            <input type="button" class="button" onclick="search()" value="查询" />
        </div>
        <table id="Material" class="tableblue"  ondblclick="Getdata(this)" PageSize="5" showpager=true  url="../MaterialHandler.ashx?method=GetDeptInfo">
            <tr>
                <th id="Name" width="100px">部门名称</th>
                <th id="Code" width="80px">部门编码</th>
                <th id="DeptLevel" width="40px">部门级别</th>
                <th id="DeptCOACode" width="40px">部门COA编码</th>
            </tr>
        </table>
         
        <script>
            InitUI();
            search();
            function search() {
                var key = { "key": document.getElementById("key").value };
                load("Material",key);
            }
            function Getdata(e) {
                var index = event.srcElement.parentNode.rowIndex - 1;
                var table = GetTable("Material");
                var jsonObj = table.SelectRows;
                if (jsonObj) {
                    parent.MySelectData = jsonObj;
                    parent.closeWindow("ok")
                }
            }
        </script>
    </form>
</body>
</html>
