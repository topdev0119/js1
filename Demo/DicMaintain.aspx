<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DicMaintain.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.DicMaintain" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../AppContent/AppScript/boot.js"></script>
    <style>
        .tableblue tr td input {
    width: 99% !important;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h3 style="text-align: center">数据字典维护</h3>
        <div style="width:100%">
            <input type="text" class="tdinputText" id="key" onenter="search"/>
            <input type="button" class="button" onclick="search()" value="查询" />
            <input type="button" class="button" onclick="add()" value="增加行" style="position:absolute;right:15px;"/>
            <div>
            <table id="Material" class="tableblue" ondblclick="TabledDoubleClick(this)"  PageSize="20" showpager=true  url="MaterialHandler.ashx?method=GetDicInfo">
                <tr>
                    <th id="ID" width="40px">ID</th>
                    <th id="ConstantType" width="100px">字典类型</th>
                    <th id="ConstantKey" width="80px">Key<input type="text"/></th>
                    <th id="ConstantValue" width="80px">Value<input type="text"/></th>
                    <th id="ConstantIndex" width="80px">排序索引<input type="text"/></th>
                    <th id="Summary" width="200px">说明<input type="text"/></th>
                    <th id="action" width="40px">操作<a href="#" onclick="Remove(this)">删除</a></th>
                </tr>
            </table>
        </div>
         
        <div style="text-align:center"> 
             <input type="button" class="button" onclick="Save()" value="保存"/>
        </div>
            </div>
    </form>
    <script>
        InitUI();
        var ConstantType = "<%=ConstantType%>";
        search();
        function search() {
            var key = { "key": document.getElementById("key").value, ConstantType: ConstantType };
            load("Material", key)
        }
        function add() {
            AddNewRow('Material')
            var index = GetTable("Material");
            console.log(index);
        }
        function Save() {
            var data = GetTableValue("Material");
            
            for (var i = 0; i < data.length; i++) {
                if (data[i]["ConstantKey"] == "") {
                    UIalert("请填写Key"); return;
                }
                 
                if (data[i]["ConstantValue"] == "") {
                    UIalert("请填写Value"); return;
                }
                if (data[i]["ConstantIndex"] == "") {
                    UIalert("请填写排序索引"); return;
                }
                
            }
            var RemoveID = GetRemove("Material");
            console.log(data);
            var url = "&RemoveID=" + RemoveID + "&ConstantType=" + ConstantType;
            Ajax("MaterialHandler.ashx?method=SaveDic" + url,
                "Post",
                data,
                function (text) {
                    if (text) {
                        UIalert(text);
                        search();
                    }
                });
        }     
    </script>
</body>
</html>
