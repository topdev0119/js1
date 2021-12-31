<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeptConfig.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.DeptConfig" %>

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
        <h3 style="text-align: center">部门参数设置</h3>
        <div style="width: 100%">
            <input type="text" class="tdinputText" id="key" onenter="search" />
            <input type="button" class="button" onclick="search()" value="查询" />
            <input type="button" class="button" onclick="setdept()" value="设置" />
            <input type="button" class="button" onclick="download()" value="导出全部"  style="position:absolute;right:400px"/>
            <input type="file" id="fileupload" style="display:none"  onchange="fileup(this)"/>
            <input type="text" id="filename" value="未选择任何文件" class="tdinputTextReadOnly" style="position:absolute;right:180px;width:200px;margin-left:-7px;background-color:#fff"  readonly="readonly" />
            <input type="button" class="button" onclick="browse()" style="width:50px;height:22px;position:absolute;right:120px;" value="浏览"/>
            <input type="button" class="button" onclick="Export()" value="批量导入" style="position:absolute;right:20px"/>
            <table id="Material" class="tableblue" PageSize="10" ondblclick="setdept()" showpager=true  url="MaterialHandler.ashx?method=GetDept2Cofig">
                <tr>
                    <th id="radio" width="100px">选择</th>
                    <th id="Code" width="100px">部门编码</th>
                    <th id="Name" width="100px">部门名称</th>
                    <th id="PName" width="100px">部门主管（预算处理人）</th>
                    <th id="Dept2Manager" width="100px">工号</th>
                    <th id="PlanMonth" width="100px">计划月份</th>
                    <th id="ActureArrive" width="100px">实际到货</th>
                    <th id="Onload" width="100px">在途</th>
                    <th id="YearBudget" width="100px">年度预算</th>
                    <%--<th id="PName" width="100px">部门管理员姓名</th>
                    <th id="Dept2Manager" width="100px">部门管理员工号</th>--%>
                </tr>
            </table>
        </div>
        <div id="win" style="display: none;">
            <table>
                <tr>
                    <td style="padding-left: 20px;">部门主管：</td>
                    <td>
                        <input type="text" class="autocomplete" id="dept2manager" valuefiled="PersonCode" textfiled="Pname" url="MaterialHandler.ashx?method=GetUserInfo" /></td>
                </tr>
                <tr>
                    <td style="padding-left: 20px;">计划月份：</td>
                    <td>
                        <input type="text" class="tdinputText" id="myPlanMonth" nulltip="格式：yyyyMM"/></td>
                </tr>
                <tr>
                    <td style="padding-left: 20px;">实际到货：</td>
                    <td>
                        <input type="text" class="tdinputText" id="myActureArrive" /></td>
                </tr>
                <tr>
                    <td style="padding-left: 20px;">在途：    </td>
                    <td>
                        <input type="text" class="tdinputText" id="myOnload" /></td>
                </tr>
                <tr>
                    <td style="padding-left: 20px;">年度预算：</td>
                    <td>
                        <input type="text" class="tdinputText" id="myYearBudget" /></td>
                </tr>
            </table>
            <div style="text-align: center">
                <input type="button" class="button" onclick="save()" value="保存" /></div>
        </div>
    </form>
    <script>
        InitUI();
        search();
        function fileup(e) {
            document.getElementById("filename").value = e.value;
        }
        function browse() {
            document.getElementById("fileupload").click();
        }
        function download() {
            window.open("DownLoad.aspx?method=DownLoadDeptConfig")
        }
        function Export() {
            if (!$("#fileupload").files[0]) {
                UIalert("请选择文件"); return;
            }
            var file = $("#fileupload").files[0];
            if (file.type != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" && file.type != "application/vnd.ms-excel") {
                UIalert("文件类型只能为Excel"); return;
            }
            UImask("导入中,请稍候...");
            AjaxFile("MaterialHandler.ashx?method=ExportDeptConfig", $("#fileupload").files[0],
                function (text) {
                    console.log(text);
                    UIalert(text);
                    search();
                    UIunmask();
                })
        }
        function search() {
            var key = { "key": document.getElementById("key").value };
            load("Material", key);
        }
        function setdept() {
            var obj;
            var checkeds = $("&Materialradio");
            for (var i = 0; i < checkeds.length; i++) {
                if (checkeds[i].checked) {
                    obj = checkeds[i];
                }
            }

            if (!obj) { alert("请选择部门！"); return; }
            var index = GetTrIndex(obj);
            var Mydata = GetTableData("Material");
            ShowWin($("#win"), "400px", "300px", "设置");
            $("#dept2manager").value = Mydata[index - 1].PName;
            $("#dept2manager").setAttribute("text", Mydata[index - 1].Dept2Manager);
            if (Mydata[index - 1].PlanMonth != "") { 
                $("#myPlanMonth").value = Mydata[index - 1].PlanMonth;
            }
            $("#myActureArrive").value = Mydata[index - 1].ActureArrive;
            $("#myOnload").value = Mydata[index - 1].Onload;
            $("#myYearBudget").value = Mydata[index - 1].YearBudget;
        }
        function save() {
            var obj;
            var checkeds = $("&Materialradio");
            for (var i = 0; i < checkeds.length; i++) {
                if (checkeds[i].checked) {
                    obj = checkeds[i];
                }
            }
            var index = GetTrIndex(obj);
            var Mydata = GetTableData("Material");
            var dept2code = Mydata[index - 1].Code;
            if (!dept2code) {
                UIalert("请选择部门"); return;
            }
            var dept2manager = $("#dept2manager").getAttribute("text");
            var PlanMonth = $("#myPlanMonth").value;
            var ActureArrive = $("#myActureArrive").value;
            var Onload = $("#myOnload").value;
            var YearBudget = $("#myYearBudget").value;
            var key = { dept2code: dept2code, dept2manager: dept2manager, PlanMonth: PlanMonth, ActureArrive: ActureArrive, Onload: Onload, YearBudget: YearBudget };
            Ajax("MaterialHandler.ashx?method=SaveDeptConfig", "update", key, function (text) {
                if (text) {
                    UIalert(text);
                    search()
                }
            })
        }
    </script>
</body>
</html>
