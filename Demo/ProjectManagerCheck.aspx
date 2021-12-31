<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectManagerCheck.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.ProjectManagerCheck" %>

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
            当前审批流程：项目经理审核
        </div>
        <div>
             <div style="width:100%;height:400px;overflow-x:scroll;overflow-y:hidden">
            <table id="Material" style="width:2200px" class="tableblue" forUpdate=true PageSize="10" pageprompt="detailpage" showpager=true  url="MaterialHandler.ashx?method=SearchMaterialPMCheck">
                <tr>
                    <th id="index" width="30px" rowspan="2">序号</th>
                    <th id="ApplyTime" width="80px" rowspan="2">申请时间</th>
                    <th id="RequiredUser" width="80px" rowspan="2">使用人</th>
                    <th id="MaterialName" width="100px" rowspan="2">整机名称+系列</th>
                    <th id="MaterialCode" width="70px" rowspan="2">物料编码</th>
                    <th id="MaterialInfo" width="200px" rowspan="2">物料描述</th>
                    <th id="MaterialStauts" width="30px" rowspan="2">状态</th>
                    <th colspan="3">需求数量</th>
                    
                    <th id="Purpose" width="100px" rowspan="2">用途</th>
                    <th id="Price" width="50px" rowspan="2">单价</th>
                    <th id="MTotalMoney" width="50px" rowspan="2">总金额</th>
                    
                    <th id="dept2code" width="80px" rowspan="2">二级部门</th>
                    <th id="dept3code" width="80px" rowspan="2">三级部门</th>
                    <th id="ItemCode" rowspan="2" width="80px">项目编码</th>
                    <th id="ItemName" rowspan="2" width="100px">项目描述</th>
                    
                    <th id="ReceiverPlace" width="80px" rowspan="2">到货地点</th>
                    
                    <th id="PMCheckResult" width="140px" rowspan="2" frozen="true">评审结果<input type="radio" onchange="ChangeRel(this)"  value="同意" checked="checked"/><input type="radio" onchange="ChangeRel(this)" value="不同意"/></th>
                    <th colspan="3" frozen="true">审批数量</th>
                    <th id="MActualMoney" width="70px" rowspan="2" frozen="true">审批后金额</th>
                    <th id="PMCheckNote" frozen="true" width="120px" rowspan="2">评审意见<input type="text" /></th>
                    <th id="UsageRate" width="100px" rowspan="2" abbr="link" frozen="true">使用率摘要<a href="#" onclick="SearchUseRate(this)"></a></th>
                    <th id="ID" rowspan="2" class="hidden">key</th>
                    <th id="AuditNum" rowspan="2" class="hidden">审批数量</th>
                </tr>
                <tr>
                    <th id="NO1MthRequireds" width="30px">XX月</th>
                    <th id="NO2MthRequireds" width="30px">XX月</th>
                    <th id="NO3MthRequireds" width="30px">XX月</th>
                    <th id="NO1MthRequiredsAudit" width="30px"frozen="true">XX月<input type="text" onblur="ChangeAudit(this)" class="number" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" /></th>
                    <th id="NO2MthRequiredsAudit" width="30px"frozen="true">XX月<input type="text" onblur="ChangeAudit(this)" class="number" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" /></th>
                    <th id="NO3MthRequiredsAudit" width="30px"frozen="true">XX月<input type="text" onblur="ChangeAudit(this)" class="number" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" /></th>
                </tr>
            </table>
            </div>
            <div class="pager" id="detailpage">
                 <span style="margin-right:15%">总计: &nbsp;&nbsp;需求数量<span id="Requireds"  style="margin-left: 2px;">0</span>
                &nbsp;&nbsp;审批数量<span id="RequiredsAudit" style="margin-left: 2px;">0</span>
                &nbsp;&nbsp;总金额<span id="Totalmoney" style="margin-left: 2px;">0</span>
                &nbsp;&nbsp;审批后金额<span id="TotalmoneyAudit" style="margin-left: 2px;">0</span>
                </span>
            </div>
        </div>
        <div style="text-align: left">

            <input type="button" class="button" id="btnsubmit" style="margin-left: 20%" onclick="Submit()" value="提交" />
            &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="btnsave" class="button" onclick="Save()" value="保存" />
            &nbsp;&nbsp;&nbsp;&nbsp;<input type="button"  id="btnwt" class="button" onclick="转其他人处理()" value="委托审批" />
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
        <script>
            InitUI();
            InitPage();
            Frozen("Material", "right");
            function ChangeRel(obj) {
                var index = GetTrIndex(obj);
                var table = GetTable("Material");
                if (obj.value == "同意") {
                    $("#MaterialNO1MthRequiredsAudit" + index + "val").value = table.Mydata[index - 1].NO1MthRequiredsAudit;
                    $("#MaterialNO2MthRequiredsAudit" + index + "val").value = table.Mydata[index - 1].NO2MthRequiredsAudit;
                    $("#MaterialNO3MthRequiredsAudit" + index + "val").value = table.Mydata[index - 1].NO3MthRequiredsAudit;
                }
                else {
                    $("#MaterialNO1MthRequiredsAudit" + index + "val").value = 0;
                    $("#MaterialNO2MthRequiredsAudit" + index + "val").value = 0;
                    $("#MaterialNO3MthRequiredsAudit" + index + "val").value = 0;
                }
            }
            function updatePerson() {
                ShowWin($("#win"), "400px", "300px", "委托审批");
            }
            function saveNewPerson() {
                var newperson = document.getElementById("NewPerson").getAttribute("text");
                if (newperson == "") {
                    alert("请选择委托人"); return;
                }
                var data = { "Status": 20, "CurrPerson": "<%=UserCode%>", "NewPerson": newperson };
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
            function InitPage() {
                var month = new Date().getMonth();
                $("#NO1MthRequireds").innerHTML = $("#NO1MthRequireds").innerHTML.replace("XX", month + 2);
                $("#NO2MthRequireds").innerHTML = $("#NO2MthRequireds").innerHTML.replace("XX", month + 3);
                $("#NO3MthRequireds").innerHTML = $("#NO3MthRequireds").innerHTML.replace("XX", month + 4);
                $("#NO1MthRequiredsAudit").innerHTML = $("#NO1MthRequiredsAudit").innerHTML.replace("XX", month + 2);
                $("#NO2MthRequiredsAudit").innerHTML = $("#NO2MthRequiredsAudit").innerHTML.replace("XX", month + 3);
                $("#NO3MthRequiredsAudit").innerHTML = $("#NO3MthRequiredsAudit").innerHTML.replace("XX", month + 4);
                SearchMaterial();
            }
            function ChangeAudit(obj) {
                var index = GetTrIndex(obj);
                var price = $("#MaterialPrice" + index).innerText;
                var NO1rq = $("#MaterialNO1MthRequireds" + index).innerText;
                var NO2rq = $("#MaterialNO2MthRequireds" + index).innerText;
                var NO3rq = $("#MaterialNO3MthRequireds" + index).innerText;
                var NO1 = $("#MaterialNO1MthRequiredsAudit" + index + "val").value;
                var NO2 = $("#MaterialNO2MthRequiredsAudit" + index + "val").value;
                var NO3 = $("#MaterialNO3MthRequiredsAudit" + index + "val").value;
                NO1rq = parseInt(NO1rq);
                NO2rq = parseInt(NO2rq);
                NO3rq = parseInt(NO3rq);
                NO1 = parseInt(NO1);
                NO2 = parseInt(NO2);
                NO3 = parseInt(NO3);
                if (NO1 + NO2 + NO3 == 0) {
                    var radios = document.getElementsByName("Material" + index);
                    for (var k = 0; k < radios.length; k++) {
                        if (radios[k].value == "不同意") {
                            radios[k].checked = true;
                        }
                    }
                }
                price = parseFloat(price);
                $("#RequiredsAudit").innerText = parseInt($("#RequiredsAudit").innerText) + NO3 + NO2 + NO1 - $("#MaterialAuditNum" + index).innerText
                $("#TotalmoneyAudit").innerText = CastNum($("#TotalmoneyAudit").innerText) + (NO3 + NO2 + NO1) * price - CastNum($("#MaterialMActualMoney" + index).innerText);
                $("#TotalmoneyAudit").innerText = parseFloat($("#TotalmoneyAudit").innerText).toFixed(2); 

                $("#MaterialMActualMoney" + index).innerText = ((NO3 + NO2 + NO1) * price).toFixed(2); 
                $("#MaterialAuditNum" + index).innerText = NO3 + NO2 + NO1;
                //if (NO1 + NO2 + NO3 - NO1rq - NO2rq - NO3rq > 0) {
                //    alert("审核数量大于需求数量");
                //}
            }
            function SearchMaterial() {
                // var key = { "key": PlanCode };
                load("Material");
                GetPMcheckTotal();
            }
            function GetPMcheckTotal() {
                Ajax("MaterialHandler.ashx?method=GetPMcheckTotal",
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
            function Save() {
                var data = GetTableValue("Material");
                for (var i = 0; i < data.length; i++) {
                    if (data[i].NO1MthRequiredsAudit == "" || data[i].NO2MthRequiredsAudit == "" || data[i].NO3MthRequiredsAudit == "") {
                        alert("审批数量不能为空"); return;
                    }
                    var NO1rq = data[i].NO1MthRequireds;
                    var NO2rq = data[i].NO2MthRequireds;
                    var NO3rq = data[i].NO3MthRequireds;
                    var NO1 = data[i].NO1MthRequiredsAudit;
                    var NO2 = data[i].NO2MthRequiredsAudit;
                    var NO3 = data[i].NO3MthRequiredsAudit;
                    NO1rq = parseInt(NO1rq);
                    NO2rq = parseInt(NO2rq);
                    NO3rq = parseInt(NO3rq);
                    NO1 = parseInt(NO1);
                    NO2 = parseInt(NO2);
                    NO3 = parseInt(NO3);
                    if (NO1 + NO2 + NO3 - NO1rq - NO2rq - NO3rq > 0){
                        alert("审批数量不能大于需求数量"); return;
                    }
                    if (data[i].PMCheckResult == "不同意" && (NO1 + NO2 + NO3) > 0) {
                        alert("当审批结果为不同意时，审批数量不能大于0"); return;
                    }
                }
                if (data.length > 0) {
                    Ajax("MaterialHandler.ashx?method=SaveMaterialAuditPM" ,
                        "Post",
                        data,
                        function (text) {
                            if (text) {
                                UIalert(text);
                                SearchMaterial();
                            }
                        });
                }
                else {
                    UIalert("没有修改审核数量，不需要保存");
                }
            }
            function Submit() {
                var data = GetTableValue("Material");
                for (var i = 0; i < data.length; i++) {
                    if (data[i].NO1MthRequiredsAudit == "" || data[i].NO2MthRequiredsAudit == "" || data[i].NO3MthRequiredsAudit == "") {
                        alert("审批数量不能为空"); return;
                    }
                    var NO1rq = data[i].NO1MthRequireds;
                    var NO2rq = data[i].NO2MthRequireds;
                    var NO3rq = data[i].NO3MthRequireds;
                    var NO1 = data[i].NO1MthRequiredsAudit;
                    var NO2 = data[i].NO2MthRequiredsAudit;
                    var NO3 = data[i].NO3MthRequiredsAudit;
                    NO1rq = parseInt(NO1rq);
                    NO2rq = parseInt(NO2rq);
                    NO3rq = parseInt(NO3rq);
                    NO1 = parseInt(NO1);
                    NO2 = parseInt(NO2);
                    NO3 = parseInt(NO3);
                    if (NO1 + NO2 + NO3 - NO1rq - NO2rq - NO3rq > 0) {
                        alert("审批数量不能大于需求数量"); return;
                    } 
                }
                Ajax("MaterialHandler.ashx?method=PMCheckSubmit",
                    "Post",
                    data,
                    function (text) {
                        if (text) {
                            UIalert(text);
                            SearchMaterial();
                        }
                    });

            }
            function SearchUseRate(obj) {
                var index = GetTrIndex(obj);
                var ID = $("#MaterialID" + index).innerText;
                parent.addTab("MaterialApproval/fm/UseRate.aspx?ID=" + ID, "使用率明细");
                //window.location.href = "fm/UseRate.aspx?ID=" + ID;
            }
            GetChuangKou();
            function GetChuangKou() {
                data = { "ConstantKey": "项目经理审核" }
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
    </form>
</body>
</html>
