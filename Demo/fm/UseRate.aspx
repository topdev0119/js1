<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UseRate.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.fm.UseRate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="../../AppContent/AppScript/boot.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div  style="text-align:right;margin-right:20px;"><input type="button"  class="button" value="返回" onclick="window.history.back()"/></div>
            <span>本部门该型号使用率</span>
            <table id="userateTable" class="tableblue" showpager=false  url="../MaterialHandler.ashx?method=UseRateTotal">
                <tr>
                    <th id="dept2name"  width="100px">申购部门</th>
                    <th  id="assetcategory" width="100px">型号</th>
                    <th  id="DeptBomRate" width="40px">使用率</th>
                    <th id="DeptBomcount" width="40px">数量</th>
                    <th id="Distribute" width="200px">设备分布</th>
                    <th id="Detail" width="300px">使用率明细</th>
                    <th id="BomRate" width="40px">研发总体</th>
                    <th id="Bomcount" width="40px">研发总体数量</th>
                </tr>
            </table>
        </div>
        
        <div>
            <span>使用率明细</span>
            <table id="Material" class="tableblue" PageSize="10" showpager=true  url="../MaterialHandler.ashx?method=UseRateDetail">
            <tr>
                <th id="collect_time" width="100px">统计时间</th>
                <th id="asset_number" width="80px">资产编号</th>
                <th id="dept_name" width="40px">部门</th>
                <th id="assert_class" width="100px">设备大类</th>
                <th id="asset_category" width="120px">设备小类</th>
                <th id="area" width="40px">地区</th>
                <th id="provider" width="80px">供应商</th>
                <th id="run_function" width="40px">功能速率</th>
                <th id="port_num" width="40px">端口数</th>
                <th id="owner_name" width="40px">挂账人姓名</th>
                <th id="owner_code" width="40px">挂账人工号</th>
                <th id="asset_desc" width="200px">描述</th>
                <th id="userate" width="40px">使用率</th>
            </tr>
        </table>
        </div>
    </form>
    <script type="text/javascript">
        InitUI();
        var ID = getQueryString("ID");
        SearchDetail();
        function SearchDetail() {
            var key = { "ID": ID };
            load("Material", key);
            load("userateTable", key);
        }
       
    </script>
</body>
</html>
