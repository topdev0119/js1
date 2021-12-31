<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportEarnings.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../AppContent/AppScript/boot.js"></script>
    <script src="../AppContent/AppScript/echarts4.8/echarts.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="vertical-align:top;height:500px;">
                <tr>
                    <td>
                        <div  style="width:150px;height:100%;padding-top:20px;">
                        <table id="monthTable" class="tableblue" PageSize="12" url="MaterialHandler.ashx?method=GetReportmonthTable">
                            <tr>
                                <th id="month">月份</th>
                                <th id="monthEarnings">收益金额(万元)</th>
                            </tr>
                             </table>
                         </div>
                    </td>
                    <td>
                        <div id="monthPic" style="width:800px;height:100%"></div>
                    </td>
                    <td>
                        <div  style="width:250px;height:100%;padding-top:20px;">
                        <table id="deptTable" class="tableblue" PageSize="100" url="MaterialHandler.ashx?method=GetReportdeptTable">
                            <tr>
                                <th id="dept">部门</th>
                                <th id="deptEarnings">收益金额(万元)</th>
                            </tr>
                             </table>
                            </div>
                    </td>
                    <td>
                        <div id="deptPic" style="width:600px;height:100%"></div>
                    </td>
                </tr>
                </table>
            <div style="width: 2500px; overflow-y: scroll">
              <table id="Material" class="tableblue" PageSize="10" showpager=true pageprompt="mypager"  url="MaterialHandler.ashx?method=MaterialArchived">
                <tr>
                    <th id="index" width="40px" >序号</th>
                    <th id="MaterialName" width="200px" >整机名称+系列</th>
                    <th id="MaterialCode" width="80px" >物料编码</th>
                    <th id="MaterialInfo" width="300px" >物料描述</th>
                    <th id="MaterialStauts" width="40px" >状态</th>
                    <th id="PlanMonth" width="60px" >需求月份</th>
                    <th id="RequeirdNO" width="60px" >需求数量</th>
                    <th id="RequeirdNOAudit" width="80px" >评审后数量</th>
                    <th id="AuditNotPass" width="80px" >评审未通过</th>
                    <th id="Purpose" width="200px" >用途</th>
                    <th id="Price" width="200px" >单价</th>
                    <th id="MtotalMoney" width="200px" >申购金额</th>
                    <th id="MActualMoney" width="200px" >审批后金额</th>
                    <th id="dept2name" width="100px" >二级部门</th>
                    <th id="dept3name" width="100px" >三级部门</th>
                    <th id="ItemCode" width="100px">项目编码</th>
                    <th id="RequiredUser" width="100px">申请使用人</th>
                    <th id="ProjectManager" width="100px">项目经理</th>
                    <th id="UsageRate" width="80px" >使用率摘要</th>
                    <th id="actiontwo" width="80px" >使用率信息<a href="#" onclick="SearchUseRate(this)">查看</a></th>
                    <th id="ReceiverPlace" width="80px">到货地点</th>
                    <th id="Dept2ManagerNote" width="200px" >备注</th>
                    <th id="ID"  class="hidden">key</th>
                </tr>
            </table>
           </div>
             <div class="pager" id="mypager"></div>
        </div>
    </form>
</body>
    <script>
        InitUI();
        load("monthTable");
        load("deptTable");
        load("Material");
        setmonthpic();
        setdeptpic();
        function setmonthpic() {
            var data = GetTableData("monthTable");
            var title = new Array();
            var picdata = new Array();
            
            
            for (var i = 0; i < data.length; i++) {
                title.push(data[i].month);
                picdata.push(data[i].monthEarnings);
            }
            var myChart = echarts.init($("#monthPic"));
            // 指定图表的配置项和数据
            var option = {
                //title: {
                //    text: 'ECharts 入门示例'
                //},
                tooltip: {},
                legend: {
                    data: ['收益金额（万元）']
                },
                xAxis: {
                    data: title //["衬衫", "羊毛衫", "雪纺衫", "裤子", "高跟鞋", "袜子"]
                },
                yAxis: {},
                series: [{
                    name: '收益金额（万元）',
                    type: 'bar',
                    data: picdata//[5, 20, 36, 10, 10, 20]
                }]
            };
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        }
        function setdeptpic() {
            var data = GetTableData("deptTable");
            var title = new Array();
            var picdata = new Array();
            for (var i = 0; i < data.length; i++) {
                title.push(data[i].dept);
                var obj = new Object();
                obj.name = data[i].dept;
                obj.value = data[i].deptEarnings;
                picdata.push(obj);
            }
            var myChart = echarts.init($("#deptPic"));
            option = {
                title: {
                    text: '收益金额（万元）',
                    //subtext: '纯属虚构',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: '{a} <br/>{b} : {c} ({d}%)'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: title
                },
                series: [
                    {
                        name: '收益金额',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '60%'],
                        data: picdata,
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            myChart.setOption(option);
        }
        function SearchUseRate(obj) {
            var index = obj.parentNode.parentNode.id.replace("Material", "");
            var ID = $("#MaterialID" + index).innerText;

            window.location.href = "fm/UseRate.aspx?ID=" + ID;
        }

    </script>
</html>
