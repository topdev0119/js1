<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialApproveUpdate.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.MaterialApproveUpdate" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
     
    <script src="../AppContent/AppScript/boot.js"></script>
    <%--<script>
        document.write("<script src='../AppContent/AppScript/MainUI.js?rnd=" + Math.random() + "'></s" + "cript>")
        document.write("<link href='../AppContent/CSS/MainUI.css?rnd=" + Math.random() + "'rel='stylesheet' type='text/css' />")
    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
        <h3 style="text-align: center">资源计划审批电子流</h3>
        <div>电子流编号:<span id="PlanCode"></span></div>
        <fieldset id="fieldset" style="padding: 5px; display: block; width: auto; height: auto;">
            <legend>填写人填写</legend>
            <div>
                <table width="100%" class="ucTable">
                    <tr>
                        <td class="FristTd">
                            <span>项目编码：</span>
                        </td>
                        <td class="FristConTd">
                            <input type="text" id="ItemCodes" class="search" event="showItem(this)" /></td>
                        <td class="FristTd">
                            <span>项目描述：</span>
                        </td>
                        <td class="FristConTd">
                            <input type="text" id="ItemName" class="tdinputTextReadOnly" readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td class="FristTd">
                            <span>申报人ID：</span>
                        </td>
                        <td class="FristConTd">
                            <input type="text" id="ApplyUser" class="tdinputTextReadOnly" readonly="readonly" /></td>
                        <td class="FristTd">
                            <span>申购日期：</span>
                        </td>
                        <td class="FristConTd">
                            <input type="text" id="ApplyTime" class="tdinputTextReadOnly" readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td class="FristTd">
                            <span>二级部门：</span>
                        </td>
                        <td class="FristConTd">
                            <input type="text" id="Dept2Code" class="tdinputTextReadOnly" readonly="readonly" /></td>
                        <td class="FristTd">
                            <span>部门编码：</span>
                        </td>
                        <td class="FristConTd">
                            <input type="text" id="DeptCOA" class="tdinputTextReadOnly" readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td class="FristTd">
                            <span>三级部门：</span>
                        </td>
                        <td class="FristConTd">
                            <input type="text" id="Dept3Code" class="tdinputTextReadOnly" readonly="readonly" /></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="FristTd">
                            <span>计划接口人ID：</span>
                        </td>
                        <td class="FristConTd">
                            <input type="text" id="Reviewer" class="tdinputTextReadOnly" readonly="readonly" /></td>
                        <td class="FristTd">
                            <span>计划员ID：</span>
                        </td>
                        <td class="FristConTd">
                            <input type="text" id="PlanManager" class="tdinputTextReadOnly" readonly="readonly" /></td>
                    </tr>
                </table>
            </div>
        </fieldset>
       
        <div>
            <table id="Material" class="tableblue"  forUpdate=true  PageSize="10" showpager=true  url="MaterialHandler.ashx?method=SearchMaterialillegal">
        <tr>
            <th id="action" width="40px" rowspan="2">操作<a href="#" onclick="Remove(this)">删除</a></th>
            <th id="index" width="40px" rowspan="2">序号</th>
            <th id="MaterialName" width="200px" rowspan="2">整机名称+系列</th>
            <th id="MaterialCode" width="80px" rowspan="2">物料编码<input   type="text" class="search" event="inputsearch(this)"/></th>
            <th id="MaterialInfo" width="300px" rowspan="2">物料描述</th>
            <th id="MaterialStauts" width="40px" rowspan="2">状态</th>
            <th colspan="3">需求数量</th>
            <th id="Purpose" width="200px" rowspan="2">用途<input type="text" onblur="ChangePurpose(this)"/></th>
            <th id="dept2code" width="100px" rowspan="2">二级部门</th>
            <th id="dept3code" width="100px"  rowspan="2">三级部门</th>
            <th id="ItemCode" width="80px" rowspan="2">项目编码<input type="text" class="search" event="showItem(this)"/></th>
            <th id="RequiredUser" width="100px" rowspan="2">使用人<input type="text" class="autocomplete"   callback="UserChange(self)" valueFiled="PersonCode" textFiled="Pname" url="MaterialHandler.ashx?method=GetUserInfo"/></th>
            <th id="ReceiverPlace" width="100px" rowspan="2">到货地点<select name="place" onchange="ChangePlace(this)" valueFiled="ConstantKey" textFiled="ConstantValue" url="MaterialHandler.ashx?method=GetRecivePlace"></select></th>
            <th id="MaterialNote" width="200px" rowspan="2">备注<input type="text" /></th>
            <th id="ReviewNote" width="200px" rowspan="2">规范备注</th>
            <th id="ID" rowspan="2" class="hidden">key</th>
            <th id="Price" rowspan="2" class="hidden">Price</th>
        </tr>
        <tr>
            <th id="NO1MthRequireds"  width="40px">XX月<input type="text" class="number" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/></th>
            <th id="NO2MthRequireds"  width="40px">XX月<input type="text"  class="number" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/></th>
            <th id="NO3MthRequireds"  width="40px">XX月<input type="text"  class="number" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/></th>
        </tr>
    </table>
    
        </div>
        <div style="text-align:center"> 
            <input type="button" class="button" onclick="SubmitData()" id="submit" value="提交计划单"/>
            &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="button" id="btnsave" onclick="Save()" value="保存草稿"/>
        </div>
    </form>
    <script>
        InitUI();
        InitPage();
       
        function add() {
            AddNewRow('Material')
            InitUI();
            document.getElementById("dept2code" + (rowNum-1)).innerText = Dept2Name;
            document.getElementById("dept3code" + (rowNum - 1)).innerText = Dept3Name;
            if (ItemCode) {
                document.getElementById("ItemCode" + (rowNum - 1) + "val").value = ItemCode;
                document.getElementById("ItemCode" + (rowNum - 1) + "val").setAttribute("text", itemname);
            }
            if (UserCode) {
                document.getElementById("RequiredUser" + (rowNum - 1) + "val").value = UserCode;
                document.getElementById("RequiredUser" + (rowNum - 1) + "val").setAttribute("text", RequiredUserCode);
            }
            if (Place) {
                document.getElementById("ReceiverPlace" + (rowNum - 1) + "val").value = Place;
            }
            if (Purpose) {
                document.getElementById("Purpose" + (rowNum - 1) + "val").value = Purpose;
            }
        }
        function fileup(e) {
             
            document.getElementById("filename").value = e.value;
        }
        function browse() {
            document.getElementById("fileupload").click();
        }
        var ItemCode = "", UserCode = "", Place, Purpose, PlanCode, RequiredUserCode,itemname;
        function ItemChange() {
            document.getElementById("ItemName").value = document.getElementById("ItemCodes").getAttribute("text");
            ItemCode = document.getElementById("ItemCodes").value;
            itemname = document.getElementById("ItemCodes").getAttribute("text");
        }
        function ItemChange2(e) {
            //document.getElementById("ItemName").value = document.getElementById("ItemCodes").getAttribute("text");
            ItemCode = document.getElementById(e.id).value;
            itemname = document.getElementById(e.id).getAttribute("text");
        }
        function UserChange(e) {
            //document.getElementById("ItemName").value = document.getElementById("ItemCodes").getAttribute("text");
            UserCode = document.getElementById(e.id).value;
            RequiredUserCode = document.getElementById(e.id).getAttribute("text");
        }
        function inputsearch(e) {
            var id = e.id;
            var index = e.parentNode.parentNode.id.replace("Material", "");
            OpenWin("fm/MaterialInfo.aspx", "680px", "450px", "选择相关项目", function (action) {
                if (action == "ok") {
                    var data = MySelectData;
                    if (data) {
                        document.getElementById(id).value = data.MaterialCode; 
                        document.getElementById("MaterialMaterialName" + index).innerText = data.MaterialName;
                        document.getElementById("MaterialMaterialInfo" + index).innerText = data.MaterialInfo;
                        document.getElementById("MaterialMaterialStauts" + index).innerText = data.MaterialStauts;
                        document.getElementById("MaterialPrice" + index).innerText = data.Price;
                    }
                }
            })
        }
        function showItem(e) {
            var id = e.id;
            OpenWin("fm/itemInfo.aspx", "1000px", "600px", "选择相关项目", function (action) {
                if (action == "ok") {
                    var data = MySelectData;
                    if (data) {
                        document.getElementById(id).value = data.CD_PROJECT_CODE;
                        ItemCode = data.CD_PROJECT_CODE;
                        itemname = data.CD_PROJECT_NAME;
                        if (id == "ItemCodes") {
                            document.getElementById("ItemName").value = itemname;
                        }
                    }
                }
            })
        }
        var Reviewer, PlanManager, DeptCOA, Dept2Code, Dept3Code, Dept2Name, Dept3Name, FinalReviewer
        function InitPage() {
            var month = new Date().getMonth();
            $("#NO1MthRequireds").innerHTML = $("#NO1MthRequireds").innerHTML.replace("XX", month+2);
            $("#NO2MthRequireds").innerHTML = $("#NO2MthRequireds").innerHTML.replace("XX", month + 3);
            $("#NO3MthRequireds").innerHTML = $("#NO3MthRequireds").innerHTML.replace("XX", month + 4);
            Ajax("MaterialHandler.ashx?method=GetApproveInfo", "GET", "", function (data) {
                document.getElementById("ApplyUser").value = data.PName;
                document.getElementById("ApplyTime").value = data.ApproveDate;
                document.getElementById("Dept2Code").value = data.Dept2Name;
                document.getElementById("DeptCOA").value = data.DeptCOACode;
                document.getElementById("Dept3Code").value = data.Dept3Name;
                document.getElementById("Reviewer").value = data.ReviewerPName;
                document.getElementById("PlanManager").value = data.PlanManagerPName;
                document.getElementById("PlanCode").innerText = data.PlanCode;
                Reviewer = data.ReviewerCode;
                PlanManager = data.PlanManagerCode;
                DeptCOA = data.DeptCOACode;
                Dept2Code = data.Dept2Code;
                Dept3Code = data.Dept3Code;
                Dept2Name = data.Dept2Name;
                Dept3Name = data.Dept3Name;
                PlanCode = data.PlanCode;
                FinalReviewer = data.FinalReviewer;
                SearchMaterial();
            })
        }
        function ChangePlace(e) {
            Place = document.getElementById(e.id).value;
        }
        function ChangePurpose(e) {
            Purpose = document.getElementById(e.id).value;
        }
        function Save() {
            var data = GetTableValue("Material");
            for (var i = 0; i < data.length; i++) {
                if (data[i]["MaterialCode"] == "") {
                    UIalert("请填写物料编码"); return;
                }
                if (data[i]["MaterialCode"] == "") {
                    UIalert("请填写物料编码"); return;
                }
                if (data[i]["NO1MthRequireds"] == "" || data[i]["NO2MthRequireds"] == "" || data[i]["NO3MthRequireds"] == "") {
                    UIalert("请填写需求数量，没有请填0"); return;
                }
                if (data[i]["Purpose"] == "") {
                    UIalert("请填写用途"); return;
                }
                if (data[i]["ItemCode"] == "") {
                    UIalert("请填写项目编码"); return;
                }
                if (data[i]["RequiredUser"] == "") {
                    UIalert("请填写使用人"); return;
                }
                if (data[i]["NO1MthRequireds"] + data[i]["NO2MthRequireds"] + data[i]["NO3MthRequireds"] == 0) {
                    UIalert("第"+(i+1)+"行，3个月份总需求数量不能都为0"); return;
                }
            }
            var RemoveID = GetRemove("Material");
            var url = "&PlanCode=" + PlanCode + "&Reviewer=" + Reviewer + "&PlanManager=" + PlanManager + "&DeptCOA=" + DeptCOA + "&Dept2Code=" + Dept2Code + "&Dept3Code=" + Dept3Code + "&RemoveID=" + RemoveID + "&FinalReviewer=" + FinalReviewer;
                Ajax("MaterialHandler.ashx?method=SaveMaterialApprove" + url,
                "Post",
                data,
                function (text) {
                    if (text) {
                        UIalert(text);
                        SearchMaterial();
                    }
                });
        }      
        function SearchMaterial() {
            var key = { "key": PlanCode };
            load("Material", key);
        }
        function SubmitData() {
            var data = GetTableValue("Material");
            for (var i = 0; i < data.length; i++) {
                if (data[i]["MaterialCode"] == "") {
                    UIalert("请填写物料编码"); return;
                }
                if (data[i]["MaterialCode"] == "") {
                    UIalert("请填写物料编码"); return;
                }
                if (data[i]["NO1MthRequireds"] == "" || data[i]["NO2MthRequireds"] == "" || data[i]["NO3MthRequireds"] == "") {
                    UIalert("请填写需求数量，没有请填0"); return;
                }
                if (data[i]["Purpose"] == "") {
                    UIalert("请填写用途"); return;
                }
                if (data[i]["ItemCode"] == "") {
                    UIalert("请填写项目编码"); return;
                }
                if (data[i]["RequiredUser"] == "") {
                    UIalert("请填写使用人"); return;
                }
                if (data[i]["NO1MthRequireds"] + data[i]["NO2MthRequireds"] + data[i]["NO3MthRequireds"] == 0) {
                    UIalert("第" + (i + 1) + "行，3个月份总需求数量不能都为0"); return;
                }
            }
            var RemoveID = GetRemove("Material");
            var url = "&PlanCode=" + PlanCode + "&Reviewer=" + Reviewer + "&PlanManager=" + PlanManager + "&DeptCOA=" + DeptCOA + "&Dept2Code=" + Dept2Code + "&Dept3Code=" + Dept3Code + "&RemoveID=" + RemoveID + "&FinalReviewer=" + FinalReviewer +"&Status=8" ;
            Ajax("MaterialHandler.ashx?method=SubmitMaterialApprove" + url,
                "Post",
                data,
                function (text) {
                    if (text) {
                        UIalert(text);
                        SearchMaterial();
                    }
                });
        }
        function Export() {
            if (!$("#fileupload").files[0]) {
                UIalert("请选择文件"); return;
            }
            var file = $("#fileupload").files[0];
            console.log(file)
            if (file.type != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" && file.type !="application/vnd.ms-excel")
            {
                UIalert("文件类型只能为Excel"); return;
            }
            AjaxFile("MaterialHandler.ashx?method=ExportMaterialApprove", $("#fileupload").files[0],
                function (text) {
                    console.log(text);
                    UIalert(text);
                    SearchMaterial();
                })
        }
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
                            alert("已经过了窗口期，不允许修改");
                            document.getElementById("btnsave").style.display = "none";
                            document.getElementById("btnsubmit").style.display = "none";
                        }
                    }
                });
        }
    </script>
</body>
</html>
