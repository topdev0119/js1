<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DicConfig.aspx.cs" Inherits="H3C.iLab.UI.Web.MaterialApproval.DicConfig" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <script src="../AppContent/AppScript/boot.js"></script>
    <link rel="Stylesheet" type="text/css" href="../Resources/JS/ext-3.2.0/resources/css/ext-all.css" />
    <link rel="Stylesheet" type="text/css" href="../Resources/CSS/Global.css" />
    <script language="javascript" type="text/javascript" src="../Resources/JS/ext-3.2.0/adapter/ext/ext-base.js"></script>
    <script language="javascript" type="text/javascript" src="../Resources/JS/ext-3.2.0/ext-all.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div id="TabPanelDiv">
            
        </div>
        
    </form>
</body>
    <script>
        
        Ext.onReady(function () {
           
            new Ext.TabPanel({
                id: "IndexPageTab",
                renderTo: "TabPanelDiv",
                deferredRender: true,
                width: "100%",
                activeTab: 0,
                border: false,

                bodyStyle: 'background-color:#FFFFFF;border:1px solid #8db2e3;border-top-width:0px;', //设置面板体的背景色
                height: document.documentElement.clientHeight - 2,
                defaults: {
                    autoScroll: true,
                    autoHeight: true,
                    style: "padding:0;border:0px;",
                    border: false
                },
                enableTabScroll: true,
                listeners: {// 添加监听器，点击此页面的tab时候要重新加载（刷新功能）
                    tabchange: function (_tab, _pan) {
                        ReloadTabPage();
                    }
                }
            });
            IndexPageaddTab("DicMaintain.aspx?ConstantType=到货地点", "到货地点", true);
            IndexPageaddTab("DicMaintain.aspx?ConstantType=流程状态", "流程状态", false);
            IndexPageaddTab("DicMaintain.aspx?ConstantType=审核窗口期", "审核窗口期", false);
            IndexPageaddTab("DicMaintain.aspx?ConstantType=人员配置", "人员配置", false);
            IndexPageaddTab("DicMaintain.aspx?ConstantType=系统管理员", "系统管理员", false);
            IndexPageaddTab("DicMaintain.aspx?ConstantType=使用率取值天数", "使用率取值天数", false);
        })
        var index = 0;
        function IndexPageaddTab(hrafStr, titleStr, isShow) {
            var tabs = Ext.getCmp("IndexPageTab");
            var idStr = ++index
            var obj = {
                id: idStr,
                title: titleStr,
                width: "100%",
                bodyStyle: 'width:100%;',
                html: "<div id='" + idStr + "loading' class='loading'><div id='loadingImge' class='loading-indicator'><img src='/Resources/JS/ext-3.2.0/extanim32.gif' alt='' width='40' height='40' style='margin-left:8px' class='loadingimg'>loading...</div></div><div id='" + idStr + "loading-mask' class='loading-mask'></div><iframe frameborder='no'  border='0' scrolling=\"auto\" id=\"tab0_" + idStr + "\" name=\"tab" + idStr + "\" height=\"" + (document.documentElement.clientHeight - 35) + "px\" width=\"100%\"  src=\"" + hrafStr + "\" onload=\"javascript:RemoveLoading('" + idStr + "');\"   style=\"border-color:#ffffff;overflow-x: hidden;overflow-y: hidden;\"></iframe>"
            };
            if (isShow) {
                tabs.add(obj).show();
            }
            else {
                tabs.add(obj);
            }
        }
        function ReloadTabPage() {
            try {
                var PageTabPanel = Ext.getCmp("IndexPageTab");
                if (PageTabPanel == null) {
                    return;
                }
                var tab = PageTabPanel.getActiveTab();
                if (tab == null) {
                    return;
                }
                // ShowLoading(tab.id);
                var tempDom = eval("tab0_" + tab.id);
                if (typeof (tempDom.window.UpdateData) == 'function') {
                    tempDom.window.UpdateData();
                    RemoveLoading(tab.id);
                }
                else {
                    tempDom.window.ReLoad();
                }
            }
            catch (e) {
            }
        }

        function RemoveLoading(idStr) {
            try {
                Ext.get(idStr + 'loading').fadeOut({ remove: false });
                Ext.get(idStr + 'loading-mask').fadeOut({ remove: false });
                SetSize();
            }
            catch (ex) {
            }
        }
    </script>
</html>
