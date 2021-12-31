<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="itemInfo.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.fm.itemInfo" %>

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
        <table id="Material" class="tableblue" ondblclick="Getdata(this)" PageSize="15" PageList="[15,20,30]" showpager=true  url="../MaterialHandler.ashx?method=GetItem">
            <tr>
                <th id="CD_PROJECT_CODE" width="100px">项目编码</th>
                <th id="CD_PROJECT_NAME" width="150px">项目名称</th>
                <th id="CD_PROJECT_PLINE_NAME" width="100px">产品线</th>
                <th id="CD_PROJECT_PDT_NAME" width="100px">PDT</th>
                <th id="CD_PROJECT_R_NAME"  width="100px">R版本</th>
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
