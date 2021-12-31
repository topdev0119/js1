<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FinalCheck.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.FinalCheck" %>

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
            当前审批流程：综合审批
        </div>
        <div>
           <div style="width:100%;height:400px;overflow-x:scroll;overflow-y:hidden">
            <table id="Material" style="width: 2300px;" class="tableblue" forUpdate=true pageprompt="mypager" PageSize="10" showpager=true  url="MaterialHandler.ashx?method=SearchMaterialFinalCheck">
                <tr>
                    <th id="index" width="40px" rowspan="2">序号</th>
                    <th id="ApplyTime" width="100px" rowspan="2">申请时间</th>
                    <th id="RequiredUser" rowspan="2">申请使用人</th>
                    <th id="MaterialName" width="100px" rowspan="2">整机名称+系列</th>
                    <th id="MaterialCode" width="60px" rowspan="2">物料编码</th>
                    <th id="MaterialInfo" width="200px" rowspan="2">物料描述</th>
                    <th id="MaterialStauts" width="30px" rowspan="2">状态</th>
                    <th colspan="3">需求数量</th>
                    
                    <th id="Purpose" width="100px" rowspan="2">用途</th>
                    <th id="Price" width="50px" rowspan="2">单价</th>
                    <th id="MTotalMoney" width="70px" rowspan="2">申购价格</th>
                   
                    <th id="AuditNotPassMoney" width="90px" rowspan="2">审批未通过金额</th>
                    <th id="dept2code" width="80px" rowspan="2">二级部门</th>
                    <th id="dept3code" width="80px" rowspan="2">三级部门</th>
                    <th id="ItemCode" rowspan="2" width="60px">项目编码</th>
                    
                    <th id="ProjectManager" rowspan="2">项目经理</th>
                   
                    <th id="ReceiverPlace" rowspan="2">到货地点</th>
                    <th colspan="4" frozen="true">审批数量</th>
                    <th id="MActualMoney" width="70px" rowspan="2" frozen="true">审批后金额</th>
                    <th id="PlanManagerNote" width="150px" rowspan="2" frozen="true">评审意见<input type="text" /></th>
                    <th id="action" width="60px" frozen="true" rowspan="2" frozen="true">详情<a href="#" onclick="SearchMe(this)">审批详情</a></th>
                     <th id="UsageRate" width="100px" rowspan="2" abbr="link" frozen="true">使用率摘要<a href="#" onclick="SearchUseRate(this)"></a></th>
                    <th id="ID" rowspan="2" class="hidden">key</th>
                </tr>
                <tr>
                    <th id="NO1MthRequireds">XX月</th>
                    <th id="NO2MthRequireds">XX月</th>
                    <th id="NO3MthRequireds">XX月</th>
                    <th id="NO1MthRequiredsAudit" frozen="true">XX月<input type="text" onblur="ChangeAudit(this)" class="number" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" /></th>
                    <th id="NO2MthRequiredsAudit" frozen="true">XX月<input type="text" onblur="ChangeAudit(this)" class="number" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" /></th>
                    <th id="NO3MthRequiredsAudit" frozen="true">XX月<input type="text" onblur="ChangeAudit(this)" class="number" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" /></th>
                    <th id="AuditNotPass" frozen="true">审核未通过</th>
                </tr>
            </table>
            </div>
            <div class="pager" id="mypager">
                 <span style="margin-right:15%">总计: &nbsp;&nbsp;评审未通过<span id="AuditNotPassTotal"  style="margin-left: 2px;">0</span>
                &nbsp;&nbsp;申购金额<span id="MTotalMoneyTotal" style="margin-left: 2px;">0</span>
                &nbsp;&nbsp;审批后金额<span id="MActualMoneyTotal" style="margin-left: 2px;">0</span>
                &nbsp;&nbsp;审批未通过金额<span id="AuditNotPassMoneyTotal" style="margin-left: 2px;">0</span>
                </span>
            </div>
        </div>
        <div style="text-align: left">
            
            <input type="button" class="button" style="margin-left: 20%" id="btnsubmit" onclick="Submit()" value="同意" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="btnsave" class="button" onclick="Save()" value="保存" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%--<input type="button"  id="btnwt" class="button" onclick="updatePerson()" value="委托审批" />--%>
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
            function updatePerson() {
                ShowWin($("#win"), "400px", "300px", "委托审批");
            }
            function saveNewPerson() {
                var newperson = document.getElementById("NewPerson").getAttribute("text");
                if (newperson == "") {
                    alert("请选择委托人"); return;
                }
                var data = { "Status": 50, "CurrPerson": "<%=UserCode%>", "NewPerson": newperson };
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
                var MTotalMoney = $("#MaterialMTotalMoney" + index).innerText;
                NO1rq = parseInt(NO1rq);
                NO2rq = parseInt(NO2rq);
                NO3rq = parseInt(NO3rq);
                NO1 = parseInt(NO1);
                NO2 = parseInt(NO2);
                NO3 = parseInt(NO3);
                price = parseFloat(price);
                MTotalMoney = parseFloat(MTotalMoney);
 
                $("#AuditNotPassTotal").innerText = parseFloat($("#AuditNotPassTotal").innerText) + (NO1rq + NO2rq + NO3rq - NO1 - NO2 - NO3) - parseFloat($("#MaterialAuditNotPass" + index).innerText)
                $("#MActualMoneyTotal").innerText = CastNum($("#MActualMoneyTotal").innerText) + (NO3 + NO2 + NO1) * price - CastNum($("#MaterialMActualMoney" + index).innerText)
                $("#AuditNotPassMoneyTotal").innerText = CastNum($("#AuditNotPassMoneyTotal").innerText) + MTotalMoney - (NO3 + NO2 + NO1) * price - CastNum($("#MaterialAuditNotPassMoney" + index).innerText);
                $("#AuditNotPassTotal").innerText = parseFloat($("#AuditNotPassTotal").innerText).toFixed(2);
                $("#MActualMoneyTotal").innerText = parseFloat($("#MActualMoneyTotal").innerText).toFixed(2);
                $("#AuditNotPassMoneyTotal").innerText = parseFloat($("#AuditNotPassMoneyTotal").innerText).toFixed(2);

                $("#MaterialMActualMoney" + index).innerText = ((NO3 + NO2 + NO1) * price).toFixed(2);
                $("#MaterialAuditNotPass" + index).innerText = NO1rq + NO2rq + NO3rq - NO1 - NO2 - NO3;
                $("#MaterialAuditNotPassMoney" + index).innerText = (MTotalMoney - (NO3 + NO2 + NO1) * price).toFixed(2);
            }
           
            function SearchMaterial() {
                // var key = { "key": PlanCode };
                load("Material");
                GetPMcheckTotal()
            }
            function GetPMcheckTotal() {
                Ajax("MaterialHandler.ashx?method=GetFinalcheckTotal",
                    "GET",
                    "",
                    function (data) {
                        if (data) {
                            $("#AuditNotPassTotal").innerText = data[0].AuditNotPassTotal;
                            $("#MTotalMoneyTotal").innerText = data[0].MTotalMoneyTotal;
                            $("#MActualMoneyTotal").innerText = data[0].MActualMoneyTotal;
                            $("#AuditNotPassMoneyTotal").innerText = data[0].AuditNotPassMoneyTotal;
                        }
                    });
            }
            function Save() {
               // GetSelectRow();
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
                if (data.length > 0) {
                    Ajax("MaterialHandler.ashx?method=SaveMaterialAuditFinal" ,
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
                //GetSelectRow();
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
                Ajax("MaterialHandler.ashx?method=FinalCheckSubmit",
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
            }
            function SearchMe(obj) {
                var index = GetTrIndex(obj);
                var ID = $("#MaterialID" + index).innerText;
                parent.addTab("MaterialApproval/fm/CheckDetail.aspx?ID=" + ID, "审核详情");
            }
            //GetChuangKou();
            function GetChuangKou() {
                data = { "ConstantKey": "综合审批" }
                var date = new Date();
                var day = date.getDate();
                Ajax("MaterialHandler.ashx?method=GetChuangKou",
                    "get",
                    data,
                    function (text) {
                        if (text) {
                            var days = text.split("-");
                            if (days[0] > day || day > days[1]) {
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
