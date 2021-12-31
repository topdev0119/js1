<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeptManagerCheck.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.DeptManagerCheck" %>

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
         <div style="text-align:right;margin-right:40%">
            当前审批流程：部门主管审核
        </div>
        <div>
            <table class="tableblue" id="huiong" style="width: 60%">
                <tr>
                    <th>部门</th>
                    <th>本期计划金额</th>
                    <th>实际到货</th>
                    <th>在途</th>
                    <th>合计(到货+在途)</th>
                    <th>本年预算</th>
                    <th>预算剩余</th>
                </tr>
                <tr>
                    <td id="dept2name">部门</td>
                    <td id="PlanMoney">0</td>
                    <td id="ActualArrival">0</td>
                    <td id="OntheWay">0</td>
                    <td id="total">0</td>
                    <td id="YearPlanMoney">0</td>
                    <td id="LeftPlanMoney">0</td>
                </tr>
            </table>
        </div>
        <div>
            <table class="tableblue" id="CheckView" style="margin-top: 20px;width: 60%" forUpdate=true PageSize="1000" url="MaterialHandler.ashx?method=GetDeptCheckView">
                <tr>
                    <th id="checkbox" width="50px" event="onchange='change()'">选择<input type="checkbox" class="show" id="selectall" onchange="Allcheck(this)" /></th>
                    <th id="myDept2ReviewResult">同意或不同意
                        <select style="width: 100%;" onchange="CheckChange()">
                            <option value="同意">同意</option>
                            <option value="不同意">不同意</option>
                        </select></th>
                    <th id="myDept2ManagerNote">评审意见<input type="text" /></th>
                    <th id="myItemCode">项目编码</th>
                    <th id="myItemName">项目描述</th>
                    <th id="myMActualMoney">金额</th>
                    <th id="myProManager">项目经理</th>
                    <th id="action">项目经理审批详情<a href="#" onclick="SearchMe(this)">审批详情</a></th>
                    <th id="myProManagerID" class="hidden">项目经理</th>
                   <%-- <th id="myPurpose" class="hidden">用途</th>
                    <th id="myReceiverPlaceID" class="hidden"></th>
                    <th id="myReceiverPlace" class="hidden">到货地点</th>
                    <th id="myMTotalMoney" class="hidden">总金额</th>
                    <th id="myDept3Code" class="hidden"></th>
                    <th id="myDept3Name" class="hidden">部门</th>--%>
                </tr>
            </table>
            <div class="pager" style="width:60%">
                <span style="margin-right: 5px">总计:金额</span><span id="myMActualMoneyTotal" style="margin-right: 70%">0</span>
            </div>
            <div style="text-align: left">
                <%--<input type="checkbox" id="selectall" onchange="Allcheck(this)" /><span onclick="selectall()" style="cursor: pointer">全选</span>--%>
                <input type="button" class="button" id="btnsave" style="left: 80px; position: absolute" onclick="checkAll()" value="批量处理" />
                <input type="button" class="button" id="btnsubmit" style="margin-left: 20%" onclick="Submit()" value="提交" />
                &nbsp;&nbsp;&nbsp;&nbsp;<input type="button"  id="btnwt" class="button" onclick="updatePerson()" value="转其他人处理" />
            </div>
        </div>
        <div id="win2" style="display: none;">
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
        <div style="background-color: #fff; padding-left: 20px; padding-right: 2%;cursor:pointer" onclick="showdetail()">
            <img id="imgdetail" align="middle" src="../Resources/Images/cat_open.gif" style="width:12px;vertical-align:middle"/>
            <font style="color:#648bb1;text-decoration:underline">物料电子流申请明细</font>
        </div>
        <div id="detail" style="display: none; cursor: pointer; padding-top: 10px;">
            <div style="width: 2300px; overflow-y: scroll">
                <table id="Material" class="tableblue"   PageSize="10" showpager=true pageprompt="detailpage"  url="MaterialHandler.ashx?method=SearchMaterialDeptCheck">
                    <tr>
                        <th id="index" width="30px" rowspan="2">序号</th>
                        <th id="ApplyTime" width="100px" rowspan="2">申请时间</th>
                        <th id="RequiredUser" width="100px" rowspan="2">使用人</th>
                        <th id="MaterialName" width="100px" rowspan="2">整机名称+系列</th>
                        <th id="MaterialCode" width="60px" rowspan="2">物料编码</th>
                        <th id="MaterialInfo" width="200px" rowspan="2">物料描述</th>
                        <th id="MaterialStauts" width="30px" rowspan="2">状态</th>
                        <th colspan="3">需求数量</th>
                        <th colspan="3">审批数量</th>
                        <th id="Purpose" width="100px" rowspan="2">用途</th>
                        <th id="Price" width="50px" rowspan="2">单价</th>
                        <th id="MTotalMoney" width="50px" rowspan="2">总金额</th>
                        <th id="MActualMoney" width="70px" rowspan="2">审批后金额</th>
                        <th id="dept2code" width="80px" rowspan="2">二级部门</th>
                        <th id="dept3code" width="80px" rowspan="2">三级部门</th>
                        <th id="DeptCOA" width="80px" rowspan="2">三级部门</th>
                        <th id="ItemCode" rowspan="2" width="60px">项目编码</th>
                        <th id="ItemName" rowspan="2" width="100px">项目描述</th>
                        <th id="ProjectManager" rowspan="2">项目经理</th>
                        <th id="ReceiverPlace" rowspan="2">到货地点</th>
                        <th id="UsageRate" width="100px" rowspan="2" abbr="link">使用率摘要<a href="#" onclick="SearchUseRate(this)"></a></th>
                        <th id="PMCheckNote" width="150px" rowspan="2">申购评审意见</th>
                        <th id="ID" rowspan="2" class="hidden">key</th>
                    </tr>
                    <tr>
                        <th id="NO1MthRequireds">XX月</th>
                        <th id="NO2MthRequireds">XX月</th>
                        <th id="NO3MthRequireds">XX月</th>
                        <th id="NO1MthRequiredsAudit">XX月</th>
                        <th id="NO2MthRequiredsAudit">XX月</th>
                        <th id="NO3MthRequiredsAudit">XX月</th>
                    </tr>
                </table>

            </div>
            <div class="pager" id="detailpage">
                <span style="margin-right: 15%">总计: &nbsp;&nbsp;需求数量<span id="Requireds" style="margin-left: 2px;">0</span>
                    &nbsp;&nbsp;审批数量<span id="RequiredsAudit" style="margin-left: 2px;">0</span>
                    &nbsp;&nbsp;总金额<span id="Totalmoney" style="margin-left: 2px;">0</span>
                    &nbsp;&nbsp;审批后金额<span id="TotalmoneyAudit" style="margin-left: 2px;">0</span>
                </span>
            </div>
        </div>
        <div id="win" style="display: none">
            <table style="margin-top:5px;width:100%">
                <tr>
                    <td style="padding-left: 15px; width: 25%">评审意见
                    </td>
                    <td>
                        <textarea id="Dept2ManagerNote" style="width: 95%; height: 150px"></textarea>
                    </td>
                </tr>
            </table>
            <div style="text-align: center">
                <button class="alertbutton" onclick="SubmitPL('同意')">同意</button>
                <button class="alertbuttoncancel" onclick="SubmitPL('不同意')">不同意</button>
            </div>
        </div>
    </form>
    <script>
        InitUI();
        InitPage();
        function SearchMe(obj) {
            var index = GetTrIndex(obj);
            var ItemCode = $("#CheckViewmyItemCode" + index).innerText;
            var ProjectManager = $("#CheckViewmyProManagerID" + index).innerText;
            //parent.addTab("MaterialApproval/fm/PMCheckDetail.aspx?ItemCode=" + ItemCode, "项目经理审批详情");
            OpenWin("fm/PMCheckDetail.aspx?ItemCode=" + ItemCode + "&ProjectManager=" + ProjectManager, "700px", "400px","项目经理审批详情")
        }
        function updatePerson() {
            ShowWin($("#win2"), "400px", "300px", "委托审批");
        }
        function saveNewPerson() {
            var newperson = document.getElementById("NewPerson").getAttribute("text");
            if (newperson == "") {
                alert("请选择委托人"); return;
            }
            var data = { "Status": 30, "CurrPerson": "<%=UserCode%>", "NewPerson": newperson };
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
        var init = true;
        var show = false;
        function showdetail() {
            if ($("#detail").style.display == "none") {
                $("#detail").style.display = "";
                $("#imgdetail").src = "../Resources/Images/cat_close.gif";
                show = true;
                change();
            }
            else {
                $("#detail").style.display = "none";
                $("#imgdetail").src = "../Resources/Images/cat_open.gif";
                show = false;
            }
        }
        function selectall() {
            $("#selectall").checked = !$("#selectall").checked;
            Allcheck($("#selectall"));
        }
        function change() {
            if (show) { 
            GetSelectRow("CheckView");
            var data = GetTableValue("CheckView");
            var ItemCode = ""
            for (var i = 0; i < data.length; i++) {
                ItemCode += "'" + data[i].myItemCode + "'";
                if (i < data.length - 1) {
                    ItemCode += ",";
                }
            }
            var key = { "ItemCode": ItemCode}
                load("Material", key);
            }
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
            change();
        }
        function InitPage() {
            var month = new Date().getMonth();
            $("#NO1MthRequireds").innerHTML = $("#NO1MthRequireds").innerHTML.replace("XX", month + 2);
            $("#NO2MthRequireds").innerHTML = $("#NO2MthRequireds").innerHTML.replace("XX", month + 3);
            $("#NO3MthRequireds").innerHTML = $("#NO3MthRequireds").innerHTML.replace("XX", month + 4);
            $("#NO1MthRequiredsAudit").innerHTML = $("#NO1MthRequiredsAudit").innerHTML.replace("XX", month + 2);
            $("#NO2MthRequiredsAudit").innerHTML = $("#NO2MthRequiredsAudit").innerHTML.replace("XX", month + 3);
            $("#NO3MthRequiredsAudit").innerHTML = $("#NO3MthRequiredsAudit").innerHTML.replace("XX", month + 4);
            SearchCheckView();

        }
        function SearchCheckView() {
            load("CheckView");
            var total = 0;
            data = GetTableData("CheckView");
            
            for (var i = 0; i < data.length; i++) {

                total += parseFloat(data[i].myMActualMoney);
            }
            $("#myMActualMoneyTotal").innerText = total.toFixed(2);
            
            GetTotal();
        }
        function SearchMaterial() {

            //load("Material");
            GetPMcheckTotal()
        }
        function Submit() {
            GetSelectRow("CheckView");
            var data = GetTableValue("CheckView");
            if (data.length == 0) {
                UIalert("请选择数据！"); return;
            }
            for (var i = 0; i < data.length; i++) {
                if (data[i]["myDept2ReviewResult"] == "不同意" && data[i]["myDept2ManagerNote"] == "") {
                    UIalert("第" + (i + 1) + "行审核结果为不同意，请填写评审意见", function () { $("#CheckViewmyDept2ManagerNote" + (i + 1) + "val").focus(); });
                    return;
                }
            }
            Ajax("MaterialHandler.ashx?method=DeptManagerCheck",
                "Post",
                data,
                function (text) {
                    if (text) {
                        UIalert(text);
                        SearchCheckView();
                    }
                });
        }
        function GetPMcheckTotal() {
            Ajax("MaterialHandler.ashx?method=GetDeptcheckTotal",
                "GET",
                "",
                function (data) {
                    if (data) {
                        $("#Requireds").innerText = data[0].Requireds;
                        $("#RequiredsAudit").innerText = data[0].RequiredsAudit;
                        $("#Totalmoney").innerText = data[0].Totalmoney;
                        $("#TotalmoneyAudit").innerText = data[0].TotalmoneyAudit;
                    }
                });
        }
       var mytotaldata
        function GetTotal() {
            Ajax("MaterialHandler.ashx?method=GetTotal",
                "GET",
                "",
                function (data) {
                    if (data) {
                        mytotaldata = data;
                        var left = data[0].YearBudget - data[0].total - $("#myMActualMoneyTotal").innerText - CastNum(data[0].MActualMoney);
                        $("#PlanMoney").innerText = CastNum(data[0].MActualMoney) + CastNum($("#myMActualMoneyTotal").innerText);
                        $("#ActualArrival").innerText = data[0].ActureArrive;
                        $("#OntheWay").innerText = data[0].Onload;
                        $("#total").innerText = data[0].total;
                        $("#LeftPlanMoney").innerText = left.toFixed(2);
                        $("#YearPlanMoney").innerText = data[0].YearBudget;
                        $("#dept2name").innerText = data[0].Name;
                    }
                });
            SearchMaterial()
        }
        function CheckChange() {
             
            data = mytotaldata;
            var total = 0;
            var datacheck = GetTableData("CheckView");
            for (var i = 0; i < datacheck.length; i++) {
                if (datacheck[i].myDept2ReviewResult == "同意") { 
                    total += parseFloat(datacheck[i].myMActualMoney);
                }
            }
            $("#myMActualMoneyTotal").innerText = total.toFixed(2);

            $("#PlanMoney").innerText = (CastNum(data[0].MActualMoney) + CastNum($("#myMActualMoneyTotal").innerText)).toFixed(2);
            var left = data[0].YearBudget - data[0].total - $("#myMActualMoneyTotal").innerText - CastNum(data[0].MActualMoney);
            $("#LeftPlanMoney").innerText = left.toFixed(2);
        }
        function checkAll() {
            GetSelectRow("CheckView");
            var data = GetTableValue("CheckView");
            if (data.length == 0) {
                UIalert("请选择数据！"); return;
            }
            ShowWin($("#win"), "400px", "250px", "批量审核");
        }
        function SubmitPL(Dept2ReviewResult) {
            GetSelectRow("CheckView");
            var data = GetTableValue("CheckView");
            var Dept2ManagerNote = $("#Dept2ManagerNote").value;
            if (data.length == 0) {
                UIalert("请选择数据！"); return;
            }
            if (Dept2ReviewResult == "不同意" && Dept2ManagerNote.replace(" ","")=="") {
                UIalert("请填写审批意见！"); return;
            }
            
            Dept2ReviewResult = encodeURI(Dept2ReviewResult);
            Dept2ManagerNote = encodeURI(Dept2ManagerNote);
            Dept2ReviewResult = encodeURI(Dept2ReviewResult);
            Dept2ManagerNote = encodeURI(Dept2ManagerNote);
            Ajax("MaterialHandler.ashx?method=DeptManagerCheckPL&Dept2ReviewResult=" + Dept2ReviewResult + "&Dept2ManagerNote=" + Dept2ManagerNote,
                "Post",
                data,
                function (text) {
                    if (text) {
                        UIalert(text);
                        SearchCheckView();
                    }
                });

        }
        function SearchUseRate(obj) {
            var index = obj.parentNode.parentNode.id.replace("Material", "");
            var ID = $("#MaterialID" + index).innerText;
            //window.location.href = "fm/UseRate.aspx?ID=" + ID;
            parent.addTab("MaterialApproval/fm/UseRate.aspx?ID=" + ID, "使用率明细");
        }
        GetChuangKou();
        function GetChuangKou() {
            data = { "ConstantKey": "部门主管审核" }
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
                            document.getElementById("btnsave").style.display = "none";
                            document.getElementById("btnsubmit").style.display = "none";
                            document.getElementById("btnwt").style.display = "none";
                        }
                    }
                });
        }
    </script>
</body>
</html>
