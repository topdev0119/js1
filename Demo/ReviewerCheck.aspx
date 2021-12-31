<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReviewerCheck.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.ReviewerCheck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
     <script src="../AppContent/AppScript/boot.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <h3 style="text-align: center">资源计划审批电子流</h3>
        <div style="text-align:right;margin-right:10px">
            当前审批流程：接口人审核
        </div>
        <div>
            
            <table id="Material" class="tableblue" ondblclick="TabledDoubleClick(this)" PageSize="10" forUpdate=true showpager=true  url="MaterialHandler.ashx?method=SearchMaterialReviewerCheck">
                <tr>
                    <th id="checkbox" width="50px" rowspan="2">选择<input type="checkbox" id="selectall" class="show" onchange="Allcheck(this)"/></th>
                    <th id="index" width="40px" rowspan="2">序号</th>
                    <th id="ApplyTime" width="100px" rowspan="2">申请时间</th>
                    <th id="RequiredUser" width="100px" rowspan="2">使用人</th>
                    <th id="MaterialName" width="200px" rowspan="2">整机名称+系列</th>
                    <th id="MaterialCode" width="80px" rowspan="2">物料编码</th>
                    <th id="MaterialInfo" width="300px" rowspan="2">物料描述</th>
                    <th id="MaterialStauts" width="40px" rowspan="2">状态</th>
                    <th colspan="3">需求数量</th>
                    <th id="Purpose" width="200px" rowspan="2">用途</th>
                    <th id="dept2code" width="100px" rowspan="2">二级部门</th>
                    <th id="dept3code" width="100px" rowspan="2">三级部门</th>
                    <th id="ItemCode" width="80px" rowspan="2">项目编码</th>
                   
                    <th id="ReceiverPlace" width="100px" rowspan="2">到货地点</th>
                    <th id="ReviewResult" width="100px" rowspan="2">是否规范
                <select style="width: 100%;" onchange="submitunleagle(this)" >
                    <option value="未审核" selected="selected">未审核</option>
                    <option value="规范">规范</option>
                    <option value="不规范">不规范</option>
                    <%--<option value="再审核">再审核</option>--%>
                </select></th>
                    <th id="ReviewNote" width="200px" rowspan="2">规范备注<input type="text" onblur="submitunleagle(this)"/></th>
                    <th id="ID" rowspan="2" class="hidden">key</th>
                    <th id="Price" rowspan="2" class="hidden">Price</th>
                    <th id="DeptCode2" rowspan="2" class="hidden">DeptCode2</th>
                </tr>
                <tr>
                    <th id="NO1MthRequireds"  width="40px">XX月</th>
                    <th id="NO2MthRequireds"  width="40px">XX月</th>
                    <th id="NO3MthRequireds"  width="40px">XX月</th>
                </tr>
            </table>
            
        </div>
        <div style="text-align: left">
            <%--<input type="checkbox" id="selectall" onchange="Allcheck(this)"/><span onclick="selectall()" style="cursor:pointer">全选</span>--%>
            <input type="button" class="button" id="btnsubmit" style="margin-left: 20%" onclick="Submit()" value="提交" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="btnemail" class="button" onclick="SendEmail()" value="不规范邮催" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%--<input type="button" id="btnwt"  class="button" onclick="updatePerson()" value="委托审批" />--%>
            <input type="button" class="button" style="right:12%;position:absolute" onclick="checkAll()" value="全部规范" />

        </div>
        <div id="win" style="display: none;">
            <table>
                <tr>
                    <td style="padding-left: 20px;">新审核人：</td>
                    <td>
                        <input type="text" id="NewPerson" class="autocomplete"  valueFiled="PersonCode" textFiled="Pname" url="MaterialHandler.ashx?method=GetUserInfo"/></td>
                </tr>
            </table>
            <div style="text-align: center">
                <input type="button" class="button" onclick="saveNewPerson()" value="保存" /></div>
        </div>
    </form>
    <script>
        InitUI();
        InitPage();
        function updatePerson() {
            ShowWin($("#win"), "400px", "300px", "委托审批");
        }
        function saveNewPerson() {
            var newperson = document.getElementById("NewPerson").getAttribute("text");
            if (newperson == "") {
                alert("请选择委托人"); return;
            }
            var data = { "Status": 10, "CurrPerson":"<%=UserCode%>", "NewPerson": newperson};
            Ajax("MaterialHandler.ashx?method=updatePerson",
                "get",
                data,
                function (text) {
                    if (text) {
                        UIalert(text);
                        SearchMaterial();
                    }
                });
        }
        function InitPage()
        {
            var month = new Date().getMonth();
            $("#NO1MthRequireds").innerHTML = $("#NO1MthRequireds").innerHTML.replace("XX", month + 2);
            $("#NO2MthRequireds").innerHTML = $("#NO2MthRequireds").innerHTML.replace("XX", month + 3);
            $("#NO3MthRequireds").innerHTML = $("#NO3MthRequireds").innerHTML.replace("XX", month + 4);
            SearchMaterial();
        }
        function SearchMaterial()
        {
            // var key = { "key": PlanCode };
            load("Material");
            selectall();
        }
        function selectall() {
            $("#selectall").checked = !$("#selectall").checked;
            Allcheck($("#selectall"));
        }
        function Allcheck(e) {
            var op = $("*input");
            if (e.checked == true) {
                for (var i = 0; i < op.length; i++) {
                    if (op[i].type == "checkbox") {
                        op[i].checked = true;
                    }
                }
            }
            else {
                for (var i = 0; i < op.length; i++) {
                    if (op[i].type == "checkbox") {
                        op[i].checked = false;
                    }
                }
            }
        }
        function checkAll() {
            var op = $("*select");
            for (var i = 0; i < op.length; i++) {
                 
                if (op[i].id.indexOf("ReviewResult")>-1) {
                    op[i].value = "规范"
                }
            }
        }
        function Submit()
        {
            GetSelectRow("Material");
            var data = GetTableValue("Material");
            if (data.length == 0) {
                UIalert("请选择数据！"); return;
            }
            for (var i = 0; i < data.length; i++) {
                if (data[i]["ReviewResult"] == "不规范" && data[i]["ReviewNote"] == "") {
                    UIalert("第" + (i + 1) + "行审核结果为不规范，请填写备注", function () { $("#ReviewNote" + (i + 1) + "val").focus();});
                    return;
                }
                if (data[i]["ReviewResult"] == "未审核") {
                    UIalert("第" + (i + 1) + "行未审核，请审核后提交。")
                    return;
                }
            }
            Ajax("MaterialHandler.ashx?method=ReviewerCheck",
                "Post",
                data,
                function (text) {
                    if (text) {
                        UIalert(text);
                        SearchMaterial();
                    }
                });
        }
        function SendEmail() {
            Ajax("MaterialHandler.ashx?method=ReviewerCheckSendEmail",
                "get",
                "",
                function (text) {
                    if (text) {
                        UIalert(text);
                        //SearchMaterial();
                    }
                });
        }
        function submitunleagle(obj) {
            var index = GetTrIndex(obj);
            var ReviewResult = $("#MaterialReviewResult" + index + "val").value;
            var ReviewNote = $("#MaterialReviewNote" + index + "val").value;
            var ID = $("#MaterialID" + index).innerText;

            if (ReviewResult == "不规范" && ReviewNote.replace(" ","")!="") {
                ReviewNote = encodeURI(encodeURI(ReviewNote))
                if (Can) { 
                    Ajax("MaterialHandler.ashx?method=ReviewerCheckUnleagle&ID=" + ID + "&ReviewResult=" + ReviewNote, "post", "");
                }
            }
        }
       
        var Can = true;
        GetChuangKou();
        function GetChuangKou() {
            data = { "ConstantKey": "接口人审核" }
            var date = new Date();

            var day = date.getDate();
            Ajax("MaterialHandler.ashx?method=GetChuangKou",
                "get",
                data,
                function (text) {
                    if (text) {
                        var days = text.split("-");
                        if (days[0] > day || day > days[1]) {
                            alert("已经过了窗口期，不允许审核");
                            document.getElementById("btnemail").style.display = "none";
                            document.getElementById("btnsubmit").style.display = "none";
                            document.getElementById("btnwt").style.display = "none";
                            Can = false;
                        }
                    }
                });
        }
    </script>
</body>
</html>
