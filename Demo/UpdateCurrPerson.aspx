<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateCurrPerson.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.UpdateCurrPerson" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="../AppContent/AppScript/boot.js"></script>
</head>
<body>
    <form id="form1" runat="server">
         <h3 style="text-align: center">修改流程当前责任人</h3>

        <div>
            <input type="text" class="tdinputText" id="key" onenter="search" />
            <input type="button" class="button" onclick="search()" value="查询" />
            <input type="button"  id="btnwt" class="button" onclick="updatePerson()" value="修改责任人" />
            <table id="Material" class="tableblue" PageSize="10" ondblclick="updatePerson()" showpager=true  url="MaterialHandler.ashx?method=GetAllcurrperson">
                <tr>
                    <th id="radio" width="100px">选择</th>
                    <th id="Name" width="200px">流程名称</th>
                    <th id="StatusCN" width="200px">流程节点</th>
                    <th id="currpersonName" width="100px">当前责任人</th>
                    <th id="Status" class="hidden">Status</th>
                    <th id="currperson" class="hidden">currperson</th>
                    <th id="Code" class="hidden">Code</th>
                </tr>
            </table>
        </div>
        <div id="win" style="display: none;">
            <table>
                <tr>
                    <td style="padding-left: 20px;">新审核人：</td>
                    <td>
                        <input type="text" id="newPersons" class="autocomplete"  valueFiled="PersonCode" textFiled="Pname" url="MaterialHandler.ashx?method=GetUserInfo"/></td>
                </tr>
            </table>
            <div style="text-align: center">
                <input type="button" class="button" onclick="saveNewPerson()" value="保存" /></div>
        </div>
        <div style="background-color: #fff; padding-left: 20px; padding-right: 2%;cursor:pointer" onclick="showdetail()">
            <img id="imgdetail" align="middle" src="../Resources/Images/cat_open.gif" style="width:12px;vertical-align:middle"/>
            <font style="color:#648bb1;text-decoration:underline">查看修改日志</font>
        </div>
        <div id="detail" style="display: none; cursor: pointer; padding-top: 10px;">
             <table id="Detail" class="tableblue"   PageSize="10" showpager=true   url="MaterialHandler.ashx?method=GetUpdateLog">
                  <tr>
                        <th id="index" width="30px" rowspan="2">序号</th>
                        <th id="ProcessName" width="100px" rowspan="2">流程名称</th>
                      <th id="NodeName" width="100px" rowspan="2">流程节点</th>
                      <th id="OldPerson" width="100px" rowspan="2">修改前责任人</th>
                      <th id="NewPerson" width="100px" rowspan="2">修改后责任人</th>
                      <th id="Creater" width="100px" rowspan="2">修改人</th>
                       <th id="Createtime" width="100px" rowspan="2">修改时间</th>
                 </tr>
             </table>
        </div>
    </form>
    <script>
        InitUI();
        search();
        load("Detail");
        function updatePerson() {
            ShowWin($("#win"), "400px", "300px", "修改责任人");
        }
        function showdetail() {
            if ($("#detail").style.display == "none") {
                $("#detail").style.display = "";
                $("#imgdetail").src = "../Resources/Images/cat_close.gif";
            }
            else {
                $("#detail").style.display = "none";
                $("#imgdetail").src = "../Resources/Images/cat_open.gif";
            }
        }
        function saveNewPerson() {
            var newperson = document.getElementById("newPersons").getAttribute("text");
            if (newperson == "") {
                alert("请选择新责任人"); return;
            }
            var obj;
            var checkeds = $("&Materialradio");
            for (var i = 0; i < checkeds.length; i++) {
                if (checkeds[i].checked) {
                    obj = checkeds[i];
                }
            }
            if (!obj) { alert("请选择要修改的流程！"); return; }
            var index = GetTrIndex(obj);
            var Mydata = GetTableData("Material");
            Status = Mydata[index - 1].Status;
            CurrPerson = Mydata[index - 1].currperson;
            var data = { "Status": Status, "CurrPerson": CurrPerson, "newPersons": newperson,"Code":Mydata[index - 1].Code };
                Ajax("MaterialHandler.ashx?method=updatePerson",
                    "get",
                    data,
                    function (text) {
                        if (text) {
                            UIalert(text);
                            search();
                            load("Detail");
                        }
                    });
        }
        function search() {
            var key = { "key": document.getElementById("key").value };
            load("Material", key);
        }
    </script>
</body>
</html>
