<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialSearch.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.MaterialSearch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../AppContent/AppScript/boot.js"></script>
    <script src="../Resources/JS/My97DatePicker/WdatePicker.js"></script>
    <style>
        select {
            border: 1px solid #a3b8cb;
            font-family: Verdana, "宋体", Arial,Sans-serif;
            font-size: 12px;
            color: #000000;
            line-height: 20px;
            /*background: #fff url(../../Resources/Images/Common/input_bg.gif) repeat-x 50% top;*/
            padding-left: 5px;
            height: 22px;
            width: 277px;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h3 style="text-align: center">资源计划审批电子流查询</h3>
        <div >
            <table width="100%" class="ucTable" id="con">
                <tr>
                    <td class="FristTd">
                        <span>申请状态：</span>
                    </td>
                    <td class="FristConTd">
                        <select id="conApproveStatus" name="ApproveStatus" valuefiled="ConstantKey" textfiled="ConstantValue" url="MaterialHandler.ashx?method=GetApproveStatus"></select>
                    </td>
                    <td class="FristTd">
                        <span>申请单号：</span>
                    </td>
                    <td class="FristConTd">
                        <input type="text" id="conPlanCode" class="tdinputText" />
                    </td>
                    <td class="FristTd">
                        <span>物料描述：</span>
                    </td>
                    <td class="FristConTd">
                        <input type="text" id="conMaterialInfo" class="tdinputText" />
                    </td>
                </tr>
                <tr>
                    <td class="FristTd">
                        <span>申请人ID：</span>
                    </td>
                    <td class="FristConTd">
                        <input id="conApplyUser" type="text" class="autocomplete" valuefiled="PersonCode" textfiled="Pname" url="MaterialHandler.ashx?method=GetUserInfo" />
                    </td>
                    <td class="FristTd">
                        <span>申请月份：</span>
                    </td>
                    <td class="FristConTd">
                        <input id="conApproveMonth"  type="text" class="Wdate1" style="width:275px;border:1px solid #a3b8cb;" autocomplete="off" onfocus="WdatePicker({skin:'blue',dateFmt:'yyyyMM'})"/>
                        <%--<select id="conApproveMonth">
                            <option value=""></option>
                            <option value="01">01月</option>
                            <option value="02">02月</option>
                            <option value="03">03月</option>
                            <option value="04">04月</option>
                            <option value="05">05月</option>
                            <option value="06">06月</option>
                            <option value="07">07月</option>
                            <option value="08">08月</option>
                            <option value="09">09月</option>
                            <option value="10">10月</option>
                            <option value="11">11月</option>
                            <option value="12">12月</option>
                        </select>--%>
                    </td>
                    <td class="FristTd">
                        <span>物品型号：</span>
                    </td>
                    <td class="FristConTd">
                        <input type="text" id="conMaterialName" class="tdinputText" nulltip="整机名称+系列" />
                    </td>
                </tr>
                <tr>
                    <td class="FristTd">
                        <span>申请部门：</span>
                    </td>
                    <td class="FristConTd">
                        <input type="text" id="conDeptName" class="search" event="inputsearch(this)"/>
                    </td>
                    <td class="FristTd">
                        <span>申请部门编码：</span>
                    </td>
                    <td class="FristConTd">
                        <input type="text" id="conDeptCOACode" class="tdinputText" nulltip="COA" />
                    </td>
                    <td class="FristTd">
                        <span>项目编码：</span>
                    </td>
                    <td class="FristConTd">
                        <input id="conItemCode" type="text" class="autocomplete" showvalue="true" valuefiled="CD_PROJECT_CODE" textfiled="CD_PROJECT_NAME" url="MaterialHandler.ashx?method=GetItem" />
                    </td>
                </tr>
                <tr>
                    <td class="FristTd">
                        <span>到货地点：</span>
                    </td>
                    <td class="FristConTd">
                        <select id="conReceiverPlace" name="place" valuefiled="ConstantKey" textfiled="ConstantValue" url="MaterialHandler.ashx?method=GetRecivePlace2"></select>
                    </td>
                    <td class="FristTd">
                        <span>审批结果：</span>
                    </td>
                    <td class="FristConTd">
                        <select id="conApproveRel">
                            <option value=""></option>
                            <option value="通过">通过</option>
                            <option value="未通过">未通过</option>
                            <option value="部分通过">部分通过</option>
                        </select>
                    </td>
                    <td colspan=2>
                        <input type="button" class="button" onclick="SearchMaterial()" value="搜索" />
                        <input type="button" class="button" onclick="Rest()" value="重置" />
                        <input type="button" id="download" class="button" style="display:none"  onclick="DownLoad()" value="导出" />
                        <input type="button" id="active" class="button" style="display:none"  onclick="Active()" value="激活特殊单" />
                    </td>
                </tr>
            </table>


        </div>
        <div style="width:100%;height:400px;overflow-x:scroll;overflow-y:hidden">
             
            <table id="Material" style="width: 2700px;" class="tableblue" PageSize="10" pageprompt="mypager"  showpager=true  url="MaterialHandler.ashx?method=MaterialApproveSearch">
                <tr>
                    <th id="checkbox" width="40px" ></th>
                    <th id="index" width="40px" >序号</th>
                    <th id="ApplyTime" width="100px">申请日期</th>
                    <th id="RequiredUser" width="100px">申请使用人</th>
                    <th id="MaterialName" width="200px" >整机名称+系列</th>
                    <th id="MaterialCode" width="80px" >物料编码</th>
                    <th id="MaterialInfo" width="300px" >物料描述</th>
                    <th id="MaterialStauts" width="40px" >状态</th>
                    <th id="PlanMonth" width="60px" >申请月份</th>
                    <th id="RequeirdNO" width="60px" >需求数量</th>
                    <th id="RequeirdNOAudit" width="80px" >评审后数量</th>
                    <th id="AuditNotPass" width="80px" >评审未通过</th>
                    <th id="Purpose" width="200px" >用途</th>
                    <th id="Price" width="200px" class="hidden">单价</th>
                    <th id="MtotalMoney" width="200px" class="hidden">申购金额</th>
                    <th id="MActualMoney" width="200px" class="hidden">审批后金额</th>
                    <th id="dept2name" width="100px" class="hidden">二级部门</th>
                    <th id="dept3name" width="100px" >三级部门</th>
                    <th id="ItemCode" width="100px">项目编码</th>
                    <th id="ProjectManager" width="100px">项目经理</th>
                    <th id="UsageRate" width="100px" rowspan="2" abbr="link" >使用率摘要<a href="#" onclick="SearchUseRate(this)"></a></th>
                    <th id="ReceiverPlace" width="80px">到货地点</th>
                    <th id="StatusCN"   width="80px">审批状态</th>
                    <th id="Currperson"   width="80px">当前处理人</th>
                    <th id="Dept2ManagerNote" width="200px" >评审意见</th>
                    <th id="action" width="60px" frozen="true">详情<a href="#" onclick="SearchMe(this)">审批详情</a></th>
                    <th id="ibmpLink" frozen="true" width="100px" rowspan="2" abbr="link">要货电子流<a href="#" onclick="toIBMP(this)"></a></th>
                    <th id="ID"  class="hidden">key</th>
                    <th id="Status"  class="hidden">Status</th>
                    <th id="IsCreateIbmp"  class="hidden">IsCreateIbmp</th>
                    <th id="ibmpDocId"  class="hidden">ibmpDocId</th>
                </tr>
            </table>
             
        </div>
        <div class="pager" id="mypager"></div>
        <div ><input type="button" class="button" id="creatibpm" style="right:12%;position:absolute;display:none" onclick="createbpm()" value="新建" /></div>
        <div id="win" style="display:none;font-size:14px">
            <span id="checkdetail"></span>
        </div>
    </form>
    <script>
        InitUI();
        SearchMaterial();
        DisplayDownload();
        Frozen("Material", "right");
        var url= "<% =ibmpurl%>";
        function Rest() {
            $("#form1").reset();
            document.getElementById("conDeptName").setAttribute("DeptCode", "");
            document.getElementById("conDeptName").setAttribute("Deptlevel", "")
            InitUI(true);
        }
        function toIBMP(obj) 
        {

            var index = GetTrIndex(obj);
            var ibmpDocId = $("#MaterialibmpDocId" + index).innerText;
            window.open(url+"&wf_docunid=" + ibmpDocId);
        }
        function Active() {
            GetSelectRow("Material");
            var data = GetTableValue("Material");
            var IsCreateIbmp = false;
            if (data.length == 0) {
                alert("请选择要激活的物料申请");
                return;
            }
            var ID = "";
             
            for (var i = 0; i < data.length; i++) {
                if (data[i].Status != "109") {
                    alert("非流程终结电子流无法激活");
                    return;
                }
                ID += data[i].ID;
                if (i < data.length - 1) {
                    ID += ",";
                }
            }
            
            Ajax("MaterialHandler.ashx?method=ActiveMaterialPlan&ID="+ID,
                "Post",
                ID,
                function (text) {
                    UIalert(text);
                    SearchMaterial();
                })

        }
        function createbpm() {
            GetSelectRow("Material");
            var data = GetTableValue("Material");
            var IsCreateIbmp = false;
            if (data.length == 0) {
                alert("请选择要创建的要货电子流");
                return;
            }
            for (var i = 0; i < data.length; i++) {
                if (data[i].IsCreateIbmp == "1") {
                    IsCreateIbmp = true;
                }
                if (data[i].Status != "100") {
                    alert("未归档不能新建研发合同要货电子流");
                    return;
                }
                if (data[i].ItemCode != data[0].ItemCode) {
                    alert("不同项目不能创建同一个要货电子流");
                    return;
                }
                if (data[i].ReceiverPlace != data[0].ReceiverPlace) {
                    alert("不同收货地不能创建同一个要货电子流");
                    return;
                }
                if (data[i].Purpose != data[0].Purpose) {
                    alert("不同用途不能创建同一个要货电子流");
                    return;
                }
            }
            if (IsCreateIbmp) {
                UIConfirm("已创建要货电子流，是否要重新创建", function (action) {
                    if (action == "ok") { 
                    UImask();
                    Ajax("MaterialHandler.ashx?method=CreateIbmp",
                    "Post",
                    data,
                    function (text) {
                        if (text == 0) {
                            UIalert("创建失败");
                            UIunmask();
                        }
                        else {
                            var msg = "创建成功，<a target='_blank' href='" + text + "'>点击这里跳转</a>"
                            UIalert(msg);
                            SearchMaterial();
                            UIunmask();
                        }
                        })
                    }
                })
            }
            else {
                UImask();
                Ajax("MaterialHandler.ashx?method=CreateIbmp",
                    "Post",
                    data,
                    function (text) {
                        if (text == 0) {
                            UIalert("创建失败");
                            UIunmask();
                        }
                        else {
                            var msg = "创建成功，<a target='_blank' href='" + text + "'>点击这里跳转</a>"
                            UIalert(msg);
                            SearchMaterial();
                            UIunmask();
                        }
                    });
            }
            
        }
        function inputsearch(e) {
            var id = e.id;
            var input = e
            OpenWin("fm/DeptInfo.aspx", "680px", "450px", "选择部门", function (action) {
                if (action == "ok") {
                    var data = MySelectData;
                    if (data) {
                        document.getElementById(id).value = data.Name;

                        input.setAttribute("DeptCode", data.Code);
                        input.setAttribute("Deptlevel", data.DeptLevel)
                    }
                }
            })
        }
        function SearchMaterial() {
            var ApproveStatus = $("#conApproveStatus").value;
            var PlanCode = $("#conPlanCode").value;
            var MaterialInfo = $("#conMaterialInfo").value;
            var ApplyUser = $("#conApplyUser").getAttribute("text");
            var ApproveMonth = $("#conApproveMonth").value;
            var MaterialName = $("#conMaterialName").value;
            var DeptCode = $("#conDeptName").getAttribute("DeptCode");
            var Deptlevel = $("#conDeptName").getAttribute("Deptlevel");
            var DeptCOACode = $("#conDeptCOACode").value;
            var ItemCode = $("#conItemCode").value;
            var ReceiverPlace = $("#conReceiverPlace").value;
            var ApproveRel = $("#conApproveRel").value;
            MaterialName = encodeURI(encodeURI(MaterialName));
            MaterialInfo = encodeURI(encodeURI(MaterialInfo));
            ApproveRel = encodeURI(encodeURI(ApproveRel));
            var key = {
                ApproveStatus: ApproveStatus, PlanCode: PlanCode, MaterialInfo: MaterialInfo, ApplyUser: ApplyUser,
                ApproveMonth: ApproveMonth, MaterialName: MaterialName, DeptCode: DeptCode, Deptlevel: Deptlevel,
                DeptCOACode: DeptCOACode, ItemCode: ItemCode, ReceiverPlace: ReceiverPlace, ApproveRel: ApproveRel
            };
            load("Material", key)
           
        }
        function DownLoad() {
            var ApproveStatus = $("#conApproveStatus").value;
            var PlanCode = $("#conPlanCode").value;
            var MaterialInfo = $("#conMaterialInfo").value;
            var ApplyUser = $("#conApplyUser").getAttribute("text");
            var ApproveMonth = $("#conApproveMonth").value;
            var MaterialName = $("#conMaterialName").value;
            var DeptCode = $("#conDeptName").getAttribute("DeptCode");
            var Deptlevel = $("#conDeptName").getAttribute("Deptlevel");
            var DeptCOACode = $("#conDeptCOACode").value;
            var ItemCode = $("#conItemCode").value;
            var ReceiverPlace = $("#conReceiverPlace").value;
            var ApproveRel = $("#conApproveRel").value;
            var key = {
                ApproveStatus: ApproveStatus, PlanCode: PlanCode, MaterialInfo: MaterialInfo, ApplyUser: ApplyUser,
                ApproveMonth: ApproveMonth, MaterialName: MaterialName, DeptCode: DeptCode, Deptlevel: Deptlevel,
                DeptCOACode: DeptCOACode, ItemCode: ItemCode, ReceiverPlace: ReceiverPlace, ApproveRel: ApproveRel
            };
            paths = "DownLoad.aspx?method=DownLoadSearchMaterial";
            for (var item in key) {
                paths += "&" + item + "=" + key[item];
            }
            window.open(paths);
        }
        function DisplayDownload() {
            Ajax("MaterialHandler.ashx?method=ShowDownLoad",
                "GET",
                "",
                function (data) {
                    if (data == "1")
                    {
                        document.getElementById("download").style.display = ""; 
                        document.getElementById("creatibpm").style.display = "";
                        document.getElementById("active").style.display = "";
                }
                })
        }
        function SearchUseRate(obj) {
            var index = GetTrIndex(obj);
            var ID = $("#MaterialID" + index).innerText;
            
            //window.location.href = "fm/UseRate.aspx?ID=" + ID;
            parent.addTab("MaterialApproval/fm/UseRate.aspx?ID=" + ID,"使用率明细");
        }
        function SearchMe(obj) {
            var index = GetTrIndex(obj);
            var ID = $("#MaterialID" + index).innerText;
            parent.addTab("MaterialApproval/fm/CheckDetail.aspx?ID=" + ID, "审核详情");
            //Ajax("MaterialHandler.ashx?method=GetCheckDetail&ID="+ID,
            //    "GET",
            //    "",
            //    function (data) {
            //        if (data) {
            //            var html = "<table style='border: 5px;border-corlor:#fff'>";
            //            html += "<tr><td><B>【申请】</B> </td><td>" + data[0].ApplyTime + "</td><td>" + data[0].ApplyUser + "</td><td>使用人:" + data[0].RequiredUser +"</td></tr>";
            //            html += "<tr><td><B>【接口人审核】</B></td><td>" + data[0].ReviewTime + "</td><td>" + data[0].Reviewer + "</td><td>审批结果:<B>" + data[0].ReviewResult + "</B></td><td>审批备注:<B>" + tongyi(data[0].ReviewNote) +"</B></td></tr>";
            //            html += "<tr><td><B>【项目经理审核】</B></td><td>" + data[0].PMCheckTime + "</td><td>" + data[0].ProjectManager + "</td><td>审批备注:<B>" + tongyi(data[0].PMCheckNote) + "</B></td></tr>";
            //            html += "<tr><td><B>【部门审批】</B></td><td>" + data[0].Dept2ManagerTime + "</td><td>" + data[0].Dept2Manager + "</td><td>审批结果:<B>" + data[0].Dept2ReviewResult + "</B></td><td>审批备注:<B>" + tongyi(data[0].Dept2ManagerNote) + "</B></td></tr>";
            //            html += "<tr><td><B>【计划员汇总】</B></td><td>" + data[0].PlanManagerTime + "</td><td>" + data[0].PlanManager + "</td><td>审批备注:<B>" + tongyi(data[0].PlanManagerNote) + "</B></td></tr>";
            //            html += "<tr><td><B>【综合审批】</B></td><td>" + data[0].FinalReviewTime + "</td><td>" + data[0].FinalReviewer + "</td><td>审批备注:<B>" + tongyi(data[0].FinalReviewNote) + "</B></td></tr>";
            //            html += "</table>"
            //            $("#checkdetail").innerHTML = html;
            //        }
            //    });
            //ShowWin($("#win"), "660px", "250px", "查看详细");
        }
        function tongyi(str) {
            if (str && str != "" && str != " ") {
                return str;
            }
            else {
                return "同意";
            }
        }
    </script>
</body>
</html>
