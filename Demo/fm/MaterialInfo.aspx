<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialInfo.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.fm.MaterialInfo" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../AppContent/AppScript/boot.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <input type="text" id="key" class="tdinputText" onenter="search"/>
            <input type="button" class="button" onclick="search()" value="查询" />
        </div>
        <table id="Material" class="tableblue" ondblclick="Getdata(this)" PageSize="15" PageList="[15,20,30]" showpager=true  url="../MaterialHandler.ashx?method=GetMaterialInfo">
            <tr>
                <th id="MaterialName" width="200px">整机名称+系列</th>
                <th id="MaterialCode" width="80px">物料编码</th>
                <th id="MaterialInfo" width="300px">物料描述</th>
                <th id="MaterialStauts" width="40px">状态</th>
                <th id="Price" class="hidden" width="40px">价格</th>
            </tr>
        </table>
         
        <script>
            InitUI();
            search();
            function search() {
                var key = { "key": document.getElementById("key").value };
                load("Material", key);
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
