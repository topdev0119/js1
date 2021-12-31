<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeptItemConfig.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.DeptItemConfig" %>

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

        .autocompletediv {
            max-height: 240px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h3 style="text-align: center">项目部门参数设置</h3>
        <div style="width: 100%">
            <input type="text" class="tdinputText" id="key" onenter="search" />
            <input type="button" class="button" onclick="search()" value="查询" />
            <input type="button" class="button" onclick="setdept()" value="设置" />
            <table id="Material" class="tableblue"  PageSize="20" ondblclick="setdept()" PageList="[10,15,20]" showpager=true  url="MaterialHandler.ashx?method=GetDeptPROJECT">
                <tr>
                    <th id="checkbox" width="100px">选择</th>
                    <th id="ItemCode" width="100px">PDT</th>
                   <%-- <th id="CD_PROJECT_NAME" width="100px" >项目名称</th>--%>
                    <th id="Dept2Code" width="100px">部门编码</th>
                    <th id="Name" width="100px">部门名称</th>
                    <th id="PName" width="100px">部门主管（预算处理人）</th>
                    <th id="Dept2Manager" width="100px">工号</th>
                </tr>
            </table>

        </div>
        <div id="win" style="display: none;">
            <table>
                <tr>
                    <td style="padding-left: 20px;">部门：</td>
                    <td>
                        <input type="text" class="autocomplete" id="dept2code" valuefiled="Code" textfiled="Name" url="MaterialHandler.ashx?method=GetDept2Code" />
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 20px;">部门主管：</td>
                    <td>
                        <input type="text" class="autocomplete" id="dept2manager" valuefiled="PersonCode" textfiled="Pname" url="MaterialHandler.ashx?method=GetUserInfo" /></td>
                </tr>
            </table>
            <div style="text-align: center">
                <input type="button" class="button" onclick="save()" value="保存" /></div>
        </div>
    </form>
    <script>
        InitUI();
        search();
        function search() {
            var key = { "key": document.getElementById("key").value };
            load("Material", key);
        }
        function setdept() {
            var AddRows=GetSelectRow("Material");
            $("#dept2code").value = "";
            $("#dept2code").setAttribute("text", "");
            if (AddRows.length == 0) { alert("请选择项目！"); return; }

            ShowWin($("#win"), "400px", "300px", "设置");
        }
        function save() {
           
            GetSelectRow("Material");
            var data = GetTableValue("Material");
            var ItemCode = "'";
            for (var i = 0; i < data.length; i++) {
                ItemCode += data[i].ItemCode + "'";
                if (i < data.length - 1) {
                    ItemCode += ",'";
                }
            }
            var dept2code = $("#dept2code").getAttribute("text");
            var dept2manager = $("#dept2manager").getAttribute("text");
            //var dept2manager = $("#dept2manager").getAttribute("text");
            if (!dept2code) {
                UIalert("请填写部门"); return;
            }
            if (!dept2manager) {
                UIalert("请填写部门主管（预算处理人）"); return;
            }
            if (data.length == 0) {
                UIalert("请选择项目"); return;
            }
            var key = { "ItemCode": encodeURI(ItemCode), dept2code: dept2code,dept2manager:dept2manager };
            Ajax("MaterialHandler.ashx?method=SaveDeptPROJECT", "update", key, function (text) {
                if (text) {
                    UIalert(text);
                    search()
                }
            })
        }
    </script>
</body>
</html>
