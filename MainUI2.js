//Writer By zhoujie ys2469
//Time 20200511

var MySelectData;
var tables = new Array();
function AddNewRow(TableID) {
    AddRow(TableID, false)
}

function GetTable(id) {
    for (var i = 0; i < tables.length; i++) {
        if (tables[i].id == id) {
            return tables[i];
        }
    }
}
///初始化标头
function Inittitle(table) {
    var title = new Array();
    title.length = 0;
    var firstrow = table.rows[0];
    var mm = 0;
    for (var k = 0; k < firstrow.cells.length; k++) {
        if (firstrow.cells[k].getAttribute("colSpan") > 1) {
            var secondrow = table.rows[1];
            for (var j = 0; j < firstrow.cells[k].getAttribute("colSpan"); j++) {
                title.push(secondrow.cells[mm]);
                mm++;
            }
        }
        else {
            title.push(firstrow.cells[k])
        }

    }
    return title;
}
///向表格中添加列
function AddRow(TableID, init) {
    var table = GetTable(TableID);
   
    var rowNum = table.rowNum;

    var AddRows = table.AddRows;
    var IndexArr = table.IndexArr;
    var index = rowNum;
    var title = table.title;
     
    var trobj = document.createElement("tr");
    for (var i = 0; i < title.length; i++) {
        var tdobj = document.createElement("td");
        tdobj.width = title[i].width;

        var innerhtml = title[i].innerHTML;
        var id = TableID+title[i].id + index;
         
        if (title[i].id == "index") {
            innerhtml = index;
            tdobj.id = id;
        }
        else if (title[i].id == "checkbox") {
             
            innerhtml = "<input type='checkbox' id='" + id + "' " + title[i].getAttribute('event')+" />";
        }
        else if (title[i].id == "radio") {
            innerhtml = "<input type='radio' id='" + id + "' name='" + TableID + "radio' " + title[i].getAttribute('event') +" />";
        }
        else if (title[i].id.indexOf("action") == 0) {

            innerhtml = Cut(innerhtml, "<", ">").replace(">", "id='" + id + "'/>");
        }
        else if (title[i].abbr == "link") {
            innerhtml = "";
        }
        else {
            innerhtml = Cut(innerhtml, "<", ">").replace(">", "id='" + id + "val'/>");
            if (innerhtml.indexOf('type="radio"') > 0) {
                innerhtml = setRatio(innerhtml, TableID + index);
            }
            if (init) {
                innerhtml = ""
            }
        }
        if (innerhtml == "") {
            tdobj.id = id;
            innerhtml = "&nbsp;"
        }
        if (title[i].className) {
            tdobj.className = title[i].className;
        }
        tdobj.innerHTML = innerhtml;
        trobj.appendChild(tdobj);
    }
    trobj.id = TableID + index;
    document.getElementById(table.id).appendChild(trobj);
    if (!init) {
        AddRows.push(index);
    }

    IndexArr.push(index);
    rowNum++;
    table.rowNum = rowNum;
    table.IndexArr = IndexArr;
    table.AddRows = AddRows;
}
///处理表格中的Ratio
function setRatio(str,gname) {
    var ratios = parseDom(str);
    var rrlstr = "";
    for (var i = 0; i < ratios.length; i++) {
        ratios[i].name = gname;
        rrlstr += ratios[i].outerHTML + ratios[i].value;
    }
    return rrlstr;
}
function parseDom(arg) {
    var objE = document.createElement("div");
    objE.innerHTML = arg;
    return objE.childNodes;
}; 
///截取字符串
function Cut(Str, start, end) {
    if (Str.indexOf(start) <= 0) {
        return "";
    }
    return Str.substring(Str.indexOf(start), Str.lastIndexOf(end) + 1)
}
///从表格中删除某行
function Remove(obj) {
    var mytable = obj.parentNode.parentNode.parentNode;
    var table = GetTable(mytable.id);
    var index = GetTrIndex(obj)
    var IndexArr = table.IndexArr;
    var AddRows = table.AddRows;
    var UpdateRows = table.UpdateRows;
    var Mydata = table.Mydata;
    table.IndexArr = IndexArr.filter(function (item) {
        return item != index
    });
    table.AddRows = AddRows.filter(function (item) {
        return item != index
    });
    table.UpdateRows = UpdateRows.filter(function (item) {
        return item != index
    });
    var RemoveRows = table.RemoveRows;
    if (Mydata && Mydata.length >= index) {
        RemoveRows.push(Mydata[index - 1]["ID"]);
    }
    document.getElementById(mytable.id + "rowcount").innerText-=1
    //obj.parentNode.parentNode.remove();
    obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
    table.RemoveRows = RemoveRows;
}
function GetRemove(id) {
    var RemoveRows = GetTable(id).RemoveRows;
     
    var RemoveID = "";
    for (var i = 0; i < RemoveRows.length; i++) {
        RemoveID += RemoveRows[i];
        if (i < RemoveRows.length - 1) {
            RemoveID += ",";
        }
    }
    return RemoveID;
}
function GetTrIndex(obj)
{
    var tableid = obj.parentNode.parentNode.parentNode.id;
    return obj.parentNode.parentNode.id.replace(tableid, "").replace("_FrozenTable", "")
}
///获取表格中新增或者编辑过后的所有数据
function GetTableValue(TableID) {

    var Rows = new Array();
    var table = GetTable(TableID);
    var title = table.title;
    var colNum = title.length;
    var AddRows = table.AddRows;
    var UpdateRows = table.UpdateRows;
    for (var i = 0; i < AddRows.length; i++) {
        var row = "{";
        for (var j = 0; j < colNum; j++) {
            var htmlKey = title[j].id;
            var htmlvalue = GetCellValue(TableID+title[j].id + AddRows[i]);
            row += '"' + htmlKey + '"' + ':"' + htmlvalue + '"';
            if (j < colNum - 1) {
                row += ",";
            }
        }
        row += "}";
        Rows.push(JSON.parse(row));
    }
    if (UpdateRows.length > 0) {

        for (var i = 0; i < UpdateRows.length; i++) {
            var row = "{";
            for (var j = 0; j < colNum; j++) {
                var htmlKey = title[j].id;
                var htmlvalue = GetCellValue(TableID +title[j].id + UpdateRows[i]);
                row += '"' + htmlKey + '"' + ':"' + htmlvalue + '"';
                if (j < colNum - 1) {
                    row += ",";
                }
            }
            row += "}";
            Rows.push(JSON.parse(row));
        }
    }
    return Rows;
}
function GetTableData(TableID) {

    var Rows = new Array();
    var table = GetTable(TableID);
    var title = table.title;
    var colNum = title.length;
    for (var i = 0; i < table.IndexArr.length; i++) {
        var row = "{";
        for (var j = 0; j < colNum; j++) {
            var htmlKey = title[j].id;
            var htmlvalue = GetCellValue(TableID + title[j].id + table.IndexArr[i]);
            row += '"' + htmlKey + '"' + ':"' + htmlvalue + '"';
            if (j < colNum - 1) {
                row += ",";
            }
        }
        row += "}";
        Rows.push(JSON.parse(row));
    }
    return Rows;
}
///获取表格中某个ID的值
function GetCellValue(id) {
    var val = document.getElementById(id);
    var val2 = document.getElementById(id + "val");
    if (val2 && val2.getAttribute("text")) {
        if (val2.getAttribute("showValue")) {
            return val2.value;
        }
        else {
            return val2.getAttribute("text");
        }
    }
    else if (val2 && val2.className == "autocomplete") {
        val2.value = "";
        return "";
    }
    else if (val2 && val2.type == "radio")
    {
        var radios = document.getElementsByName(val2.name)
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked == true) {
                return radios[i].value;
            }
        }
        return "";
    }
    else if (val2 && val2.value != undefined) {

        return val2.value;
    }
    else {
        return val.innerText;
    }
}
function tableclick() {
    var table = GetTable(this.id.replace("_FrozenTable", ""));
    var mytable = document.getElementById(this.id.replace("_FrozenTable", ""));
    var FrozenID;
    if (this.id.indexOf("FrozenTable") > 0) {
        FrozenID = this.id.replace("_FrozenTable", "")
    }
    else {
        FrozenID = this.id + "_FrozenTable";
    }
    if (event.srcElement.tagName.toLowerCase() == 'td') {
        var rownum = event.srcElement.parentNode.rowIndex;
        for (var i = table.titleRowCount; i < mytable.rows.length; i++) {
            if (i == rownum) {
             
                var index = table.IndexArr[rownum - table.titleRowCount];
                document.getElementById(this.id + index).classList.add("trselect");
                if (document.getElementById(FrozenID + index)) {
                    document.getElementById(FrozenID + index).classList.add("trselect");
                }
                if (table.Mydata) { 
                    table.SelectRows = table.Mydata[index - 1];
                }
                for (var j = 0; j < mytable.rows[i].cells.length; j++) {
                        if (table.title[j].id == "checkbox" || table.title[j].id ==  "radio") {
                            mytable.rows[i].cells[j].childNodes[0].checked = true;
                        }
                }
            }
            else {
                var index = table.IndexArr[i - table.titleRowCount];
                document.getElementById(this.id + index).classList.remove("trselect");
                if (document.getElementById(FrozenID + index)) {
                    document.getElementById(FrozenID + index).classList.remove("trselect");
                }
            }
        }

    }
}
function tablemouseover() {
    var table = GetTable(this.id.replace("_FrozenTable", ""));
    var mytable = document.getElementById(this.id.replace("_FrozenTable", ""));
    var FrozenID;
    if (this.id.indexOf("FrozenTable") > 0) {
        FrozenID = this.id.replace("_FrozenTable", "")
    }
    else {
        FrozenID = this.id + "_FrozenTable";
    }
    if (event.srcElement.tagName.toLowerCase() == 'td') {
        var rownum = event.srcElement.parentNode.rowIndex;
        for (var i = table.titleRowCount; i < mytable.rows.length; i++) {
            if (i == rownum) {

                var index = table.IndexArr[rownum - table.titleRowCount];
                document.getElementById(this.id + index).classList.add("trover");
                if (document.getElementById(FrozenID + index)) {
                    document.getElementById(FrozenID + index).classList.add("trover");
                }
            }
            else {
                var index = table.IndexArr[i - table.titleRowCount];
                document.getElementById(this.id + index).classList.remove("trover");
                if (document.getElementById(FrozenID + index)) {
                    document.getElementById(FrozenID + index).classList.remove("trover");
                }
            }
        }

    }
}
function tablemouseout() {
    var table = GetTable(this.id.replace("_FrozenTable", ""));
    var mytable = document.getElementById(this.id.replace("_FrozenTable", ""));
    var FrozenID;
    if (this.id.indexOf("FrozenTable") > 0) {
        FrozenID = this.id.replace("_FrozenTable", "")
    }
    else {
        FrozenID = this.id + "_FrozenTable";
    }
    if (event.srcElement.tagName.toLowerCase() == 'td') {
        var rownum = event.srcElement.parentNode.rowIndex;
        for (var i = table.titleRowCount; i < mytable.rows.length; i++) {
            if (i == rownum) {
                var index = table.IndexArr[i - table.titleRowCount];
                document.getElementById(this.id + index).classList.remove("trover");
                if (document.getElementById(FrozenID + index)) {
                    document.getElementById(FrozenID + index).classList.remove("trover");
                }
            }
        }

    }
}
///双击表格把某列变为可编辑状态
function TabledDoubleClick(e) {
    var table = GetTable(e.id);
    var mytable = document.getElementById(e.id);
    var title = table.title;
    var UpdateRows = table.UpdateRows;
    if (event.srcElement.tagName.toLowerCase() == 'td') {
        //alert("行：" + (event.srcElement.parentNode.rowIndex + 1) + "列：" + (event.srcElement.cellIndex + 1));
        var rownum = event.srcElement.parentNode.rowIndex;
        var colnum = event.srcElement.cellIndex;
        var index = table.IndexArr[rownum - table.titleRowCount];
        if (UpdateRows.indexOf(index) < 0)//防止第二次双击清空已填写数据
        for (var i = 0; i < title.length; i++) {
            colnum = i;
            var id = table.id+title[colnum].id + index;
            var innerhtml = title[colnum].innerHTML;
            var innerText = mytable.rows[rownum].cells[colnum].innerText;
            var ahtml = mytable.rows[rownum].cells[colnum].innerHTML;
            innerhtml = Cut(innerhtml, "<", ">").replace(">", "id='" + id + "val'/>")
            
            if (innerhtml != "") {
                
                if (innerhtml.indexOf("</a>") > 0) {
                    document.getElementById(id).innerHTML = ahtml;
                }
                else
                { 
                    document.getElementById(id).innerHTML = innerhtml;
                    InitTDUI(document.getElementById(id + "val"));
                    //document.getElementById(id + "val").value = innerText;
                    TDFindValueByText(table, document.getElementById(id + "val"), innerText, index - 1, title[colnum].id)
                    if (UpdateRows.indexOf(index) < 0 && table.AddRows.indexOf(index) < 0) {
                        UpdateRows.push(index);
                    }
                }
            }
        }
    }
    table.UpdateRows = UpdateRows;
}
function GetRow(e) {
    var table = GetTable(e.id);
    if (event.srcElement.tagName.toLowerCase() == 'td') {
        var rownum = event.srcElement.parentNode.rowIndex;
        var index = rownum - table.titleRowCount;
       
        return table.Mydata[index];
    }
}
//table中根据text查找值
function TDFindValueByText(table,obj, text, index, property) {
    if (obj.tagName.toLowerCase() == "select") {

        for (var i = 0; i < obj.options.length; i++) {
            if (obj.options[i].text == text)
                obj.options[i].selected = "selected";
        }
    }
    else if (obj.className == "autocomplete") {
        obj.value = text;
        if (table.Mydata[index][property + "ID"])
            obj.setAttribute("text", table.Mydata[index][property + "ID"]);
        else {
            obj.setAttribute("text", text);
        }
    }
    else {
        obj.value = text;
    }
}
///清楚表格数据
function ClearTable(TableID) {
    var table = GetTable(TableID);
    var mytable = document.getElementById(TableID);
    var tablerowcount = mytable.rows.length;
    for (var i = table.titleRowCount; i < tablerowcount; i++) {
        mytable.deleteRow(i);
        tablerowcount = tablerowcount - 1;
        i = i - 1;
    }
    table.rowNum = 1;
    table.IndexArr.length = 0;
    table.AddRows.length = 0;
    table.UpdateRows.length = 0;
    table.RemoveRows.length = 0;

}
///填充表格数据
function FillTable(TableID, ds) {
   
    ClearTable(TableID);
    var table = GetTable(TableID);
    var mytable = document.getElementById(TableID);
    var data = ds.data;
    if (ds.total) {
        var RowCount = ds.total;
        var PageCount = Math.ceil(RowCount / table.PageSize);

        var PageIndex = table.PageIndex;
        table.RowCount = RowCount;
        table.PageCount = PageCount;
        if (document.getElementById(TableID + "rowcount")) {
            document.getElementById(TableID + "rowcount").innerText = RowCount;
            document.getElementById(TableID + "pagecount").innerText = PageCount;
            document.getElementById(TableID + "pageindex").innerText = PageIndex + 1;
            document.getElementById(TableID + "pageindex2").value = PageIndex + 1;
        }
    }
    else {
        data = ds;
    }
    table.Mydata = data;
    var rowcount = data.length;
    if (rowcount > table.PageSize) {
        rowcount = table.PageSize;
    }
    if (rowcount > RowCount) {
        rowcount = RowCount;
    }
    var IndexArr = table.IndexArr;
    var title = table.title;
    var colNum = title.length;
    var forUpdate = table.forUpdate;
    for (var i = 0; i < rowcount; i++) {

        if (rowcount > IndexArr.length) {
            if (forUpdate) {
                AddRow(TableID, false);
            }
            else {
                AddRow(TableID, true);
            }
        }
        var index = IndexArr[i];
        for (var j = 0; j < colNum; j++) {
            if (title[j].id.indexOf("action") != 0) {

                if (data[i].hasOwnProperty(title[j].id)) {
                   
                    if (data[i][title[j].id] == "" && document.getElementById(TableID + title[j].id + index) && data[i][title[j].id] != "0") {
                        
                        document.getElementById(TableID + title[j].id + index).innerText = " ";
                    }
                    else if (title[j].abbr == "link") {
                        document.getElementById(TableID + title[j].id + index).innerHTML = Cut(title[j].innerHTML, "<", ">").replace("><", ">" + data[i][title[j].id] + "<")
                    }
                    else if (title[j].children.length > 0 && title[j].children[0].type == "radio")
                    {
                        for (var k = 0; k < mytable.rows[index + table.titleRowCount - 1].cells[j].children.length; k++)
                        {
                            if (mytable.rows[index + table.titleRowCount - 1].cells[j].children[k].value == data[i][title[j].id])
                            {
                                mytable.rows[index + table.titleRowCount - 1].cells[j].children[k].checked = true;
                            }
                        }
                    }
                    else if (document.getElementById(TableID + title[j].id + index + "val")) {
                        TDFindValueByText(table, document.getElementById(TableID + title[j].id + index + "val"), data[i][title[j].id], index - 1, title[j].id)
                    }
                    else {
                        document.getElementById(TableID + title[j].id + index).innerText = data[i][title[j].id];
                    }
                }
                else if (title[j].id == "index") {
                    document.getElementById(TableID +title[j].id + index).innerText = index;
                }
                else {
                    if (document.getElementById(TableID +title[j].id + index)) {
                        document.getElementById(TableID +title[j].id + index).innerText = " "
                    }
                }
            }
        }
    }
    if (table.Frozen == true) {
        Frozen(TableID, table.FrozenSide);
    }
}
///ajax发送数据（同步）
function Ajax(paths, Method, data) {
    if (arguments.length == 4) {
        Ajaxsync(arguments[0], arguments[1], arguments[2], arguments[3]);
        return;
    }
    var xhr = null;
    Method = Method.toUpperCase();
    if (window.XMLHttpRequest) {// code for IE7, Firefox, Opera, etc.
        xhr = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {// code for IE6, IE5
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
    }
    //var okStatus = document.location.protocol === "file:" ? 0 : 200;
    
    if (Method == "GET") {
        if (paths.indexOf("?") > 0) {
            paths += "&r=" + Math.random();
        }
        else {
            paths += "?r=" + Math.random();
        }
        for (var item in data) {
            paths += "&" + item + "=" + data[item];
        }
    }
    //xhr.overrideMimeType("text/html;charset=utf-8");//默认为utf-8
    if (Method == "POST") {
        xhr.open('POST', paths, false);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=gb2312");//设置请求头 注：post方式必须设置请求头（在建立连接后设置请求头）
        var dataStr = JSON.stringify(data);
        dataStr = encodeURI(dataStr);
        dataStr = encodeURI(dataStr);
        xhr.send("data=" + dataStr);
        //xhr.setRequestHeader("Content-type", "application/json");//设置请求头 注：post方式必须设置请求头（在建立连接后设置请求头）var obj = { name: 'zhansgan', age: 18 };
        //xhr.send(JSON.stringify(data));//发送请求 将json写入send中
    }
    else {
        xhr.open('GET', paths, false);
        xhr.send(null);
    }

    //var rel = xhr.status === okStatus ? eval('(' + xhr.responseText + ')')[0].Version : "1.0.0.0.1";
    return eval('(' + xhr.responseText + ')');
}
///ajax发送数据(异步)
function Ajaxsync(paths, Method, data, callback) {
   
    MyPath = paths;
    Submitdata = data;
    var xhr = null;
    Method = Method.toUpperCase();
    if (window.XMLHttpRequest) {// code for IE7, Firefox, Opera, etc.
        xhr = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {// code for IE6, IE5
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
    }
    //var okStatus = document.location.protocol === "file:" ? 0 : 200;
    
    if (Method == "GET") {
        if (paths.indexOf("?") > 0) {
            paths += "&r=" + Math.random();
        }
        else {
            paths += "?r=" + Math.random();
        }
        for (var item in data) {
            paths += "&" + item + "=" + data[item];
        }
    }
    if (Method == "UPDATE") {
        for (var item in data) {
            paths += "&" + item + "=" + data[item];
        }
        Method ="POST"
    }
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var json = xhr.responseText;//获取到json字符串，还需解析

            if (isJSON(json)) {
                callback(eval('(' + json + ')'));
            }
            else {
                callback(json);
            }
        }
    }
    //xhr.overrideMimeType("text/html;charset=utf-8");//默认为utf-8
    if (Method == "POST") {
        xhr.open('POST', paths, true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=gb2312");//设置请求头 注：post方式必须设置请求头（在建立连接后设置请求头）
        var dataStr = JSON.stringify(data);
        dataStr = encodeURI(dataStr);
        dataStr = encodeURI(dataStr);
        xhr.send("data=" + dataStr);
        //xhr.setRequestHeader("Content-type", "application/json");//设置请求头 注：post方式必须设置请求头（在建立连接后设置请求头）var obj = { name: 'zhansgan', age: 18 };
        //xhr.send(JSON.stringify(data));//发送请求 将json写入send中
    }
    else {
        xhr.open('GET', paths, true);
        var dataStr = JSON.stringify(data);
        xhr.send("data=" + dataStr);
    }

    //var rel = xhr.status === okStatus ? eval('(' + xhr.responseText + ')')[0].Version : "1.0.0.0.1";

}
function AjaxFile(paths, data, callback) {


    xhr = null;
    Method = "POST";
    if (window.XMLHttpRequest) {// code for IE7, Firefox, Opera, etc.
        xhr = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {// code for IE6, IE5
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
    }
    //var okStatus = document.location.protocol === "file:" ? 0 : 200;

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var json = xhr.responseText;//获取到json字符串，还需解析
            if (isJSON(json)) {
                callback(eval('(' + json + ')'));
            }
            else {
                callback(json);
            }
        }
    }

    xhr.open('POST', paths + "&key=key&data=data", true);
    //xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=gb2312");//设置请求头 注：post方式必须设置请求头（在建立连接后设置请求头）
    var form = new FormData(); // FormData 对象
    form.append("file", data); // 文件对象
    xhr.send(form);


}
function isJSON(str) {
    if (typeof str == 'string') {
        try {
            JSON.parse(str);
            return true;
        } catch (e) {
            return false;
        }
    }
}
///查询table
function load(_MyTableID, Submitdata) {
    if (!Submitdata) {
        Submitdata = "";
    }
    var table = GetTable(_MyTableID);
    var MyPath = table.url;
    var PageSize = table.PageSize;
    var PageIndex = table.PageIndex;
    if (MyPath.indexOf("?") > 0) {
        MyPath += "&PageSize=" + PageSize + "&PageIndex=" + PageIndex;
    }
    else {
        MyPath += "?PageSize=" + PageSize + "&PageIndex=" + PageIndex;
    }
    table.Submitdata = Submitdata;
    var data = Ajax(MyPath, "GET", Submitdata)
    FillTable(_MyTableID, data);
}
///查询table
function MySearch(_MyTableID) {

    var table = GetTable(_MyTableID);
    var MyPath = table.url;
    var Submitdata = table.Submitdata;
    if (MyPath.indexOf("?") > 0) {
        MyPath += "&PageSize=" + table.PageSize + "&PageIndex=" + table.PageIndex;
    }
    else {
        MyPath += "?PageSize=" + table.PageSize + "&PageIndex=" + table.PageIndex;
    }
    var data = Ajax(MyPath, "GET", Submitdata)
    FillTable(_MyTableID, data);
    
}
///重定义PageSize查询
function BindGridSize(_PageSize, _MyTableID) {

    BindGrid(0, _PageSize, _MyTableID)
}
///重定义pageindex查询
function BindGridInex(_pageindex, _MyTableID) {
    var table = GetTable(_MyTableID);
    BindGrid(_pageindex, table.PageSize, _MyTableID)
}
function BindGrid(_pageindex, _PageSize, _MyTableID) {
    var table = GetTable(_MyTableID);
    var PageIndex = table.PageIndex;
    var PageCount = table.PageCount;
    if (_pageindex == "first") {
        PageIndex = 0;
    }
    else if (_pageindex == "prve") {
        PageIndex--;
    }
    else if (_pageindex == "next") {
        PageIndex++;
    }
    else if (_pageindex == "last") {
        PageIndex = PageCount;
    }
    else {
        PageIndex = _pageindex;
    }
    if (PageIndex < 0) {
        PageIndex = 0
    }
    if (PageIndex > PageCount - 1) {
        PageIndex = PageCount - 1;
    }
    PageSize = _PageSize;
    table.PageSize = PageSize;
    table.PageIndex = PageIndex;
    MySearch(_MyTableID);
}
///跳转到第几页
function Go(_MyTableID) {
    PageIndex = document.getElementById(_MyTableID + "pageindex2").value - 1;
    BindGridInex(PageIndex, _MyTableID);
}
///获取checkbox选择行
function GetSelectRow(_MyTableID) {
    var table = GetTable(_MyTableID);
    table.AddRows.length = 0;
    var rowcount = document.getElementById( _MyTableID).rows.length - table.titleRowCount
    for (var i = 0; i < rowcount; i++) {
        
        if (document.getElementById(_MyTableID + "checkbox" + (i + 1)).checked) {
            table.AddRows.push(i + 1);
        }
    }
    
    return table.AddRows;
}
//给某个控件注册方法， AddEvt(this, 'input', autocompletes)
function AddEvt(ele, evt, fn) {
    if (document.addEventListener) {
        ele.addEventListener(evt, fn, false);
    } else if (document.attachEvent) {
        ele.attachEvent('on' + (evt == "input" ? "propertychange" : evt), fn);
    } else {
        ele['on' + (evt == "input" ? "propertychange" : evt)] = fn;
    }
}
function removeEvt(element, eventName, fn) {
    if (element.removeEventListener) {
        element.removeEventListener(eventName, fn);
    } else if (element, detachEvent) {
        element.detachEvent("on" + eventName, fn);
    } else {
        element["on" + eventName] = null;
    }
}
//给某个元素插入子元素
function insertAfter(ele, targetELe) {
    var parentnode = targetELe.parentNode || targetELe.parentElement;
    if (parentnode.lastChild == targetELe) {
        parentnode.appendChild(ele);
    } else {
        parentnode.insertBefore(ele, targetELe.nextSibling);
    }
}
//隐藏某个DIV
function closeDiv(div) {
    if (div) {
        div.style.display = 'none';
    }

}
///autocomplete触发方法
function autocompletes() {
    var parentNode = this.parentNode || this.parentElement;
    var childNodes = parentNode.childNodes;
    this.setAttribute("text", "");
    var showDiv = document.getElementById(this.id + "showdivId");
    if (showDiv) {
        parentNode.removeChild(showDiv);
    }
    //创建下拉Div
    var div = document.createElement('div');
    div.id = this.id + "showdivId";
    div.className = "autocompletediv";
    //div.style["left"] = this.offsetLeft + "px";
    //div.style["top"] = (this.offsetTop + this.offsetHeight) + "px";
    //div.style["width"] = this.offsetWidth +"px";
    this.showdiv = div;
    insertAfter(this.showdiv, this)
    var url = this.attributes["url"].nodeValue;
    var get = { "key": encodeURI(this.value) };
    MySelectData = Ajax(url, "GET", get)
   
    this.style.zIndex = 900;
    var bodyDiv = document.getElementById(this.id + "bodyDiv");
    if (bodyDiv) {
        document.body.removeChild(bodyDiv);
    }
    var Bdiv = document.createElement('div');
    Bdiv.id = this.id + "bodyDiv";
    Bdiv.className = "Bdiv";
    document.body.appendChild(Bdiv);
    AddEvt(Bdiv, 'click', function (e) {
        closeDiv(Bdiv)
        closeDiv(div)
    })
    FillautocompleteDiv(this, div, MySelectData, Bdiv)
}
///autocomplete内容数据填充
function FillautocompleteDiv(self, div, data, Bdiv) {
    var fragment = document.createDocumentFragment();
    if (JSON.stringify(data) == "[{}]") {
        var child = document.createElement('div');
        child.className = "selectItem"
        child.setAttribute('text', "undefind");
        child.innerHTML = "NULL";
        child.style.backgroundColor = "#0A246A";
        child.style.color = "#fff";
        fragment.appendChild(child);
    }
    else {

        for (var i = 0; i < data.length; i++) {
            var obj = data[i];
            var child = document.createElement('div');
            child.className = "selectItem"
            child.setAttribute('index', i);
            child.setAttribute('text', obj[self.attributes["valueFiled"].nodeValue]);
            child.innerHTML = obj[self.attributes["textFiled"].nodeValue];
            fragment.appendChild(child);
        }
    }



    self.showdiv.appendChild(fragment);
    insertAfter(self.showdiv, self);
    //为下拉框添加点击事件
    AddEvt(div, 'click', function (e) {
        var evt = e || window.event;
        var target = evt.srcElement || evt.target;
        var text = target.getAttribute("text");
        var index = target.getAttribute("index");
        var val = target.innerHTML;
        var showvalue = self.getAttribute("showValue");
        if (target.className == "selectItem") { 
            if (val != "NULL") {
                if (showvalue) {
                    self.value = text;
                    self.setAttribute('text', val)
                }
                else {
                    self.value = val;
                    self.setAttribute('text', text)
                }
                self.setAttribute('index', index)
            }
            else {
                self.value = "";
                self.setAttribute('text', "")
                self.setAttribute('index', "")
            }
            //self.setAttribute('data', data)
            var callback = self.getAttribute("callback");
            if (callback) {
                var fn = eval(callback);
                if (fn) {
                    fn();
                }
            }
            closeDiv(Bdiv)
            closeDiv(div);
        }
    });
}
///打开新窗口
var Mycallback, Mycallback2;
function OpenWin(url, width, height, _title, callback) {
    Mycallback = callback;
    showWindows = true;
    if (document.getElementById("miniwin")) {
        document.body.removeChild(document.getElementById("miniwin"));
    }
    if (document.getElementById("mask")) {
        document.body.removeChild(document.getElementById("mask"));
    }
    //获取高度和宽度
    var divw = width;
    var divh = height;
    var contentsh = (divh.substring(0, divh.indexOf("px")) - 36) + "px";
    var iframew = (divw.substring(0, divw.indexOf("px")) - 4) + "px";
    var iframeh = (contentsh.substring(0, contentsh.indexOf("px")) - 8) + "px";
    var titlefontw = (divw.substring(0, divw.indexOf("px")) - 70) + "px";
    var divstyle = "width:" + divw + ";height:" + divh
    var contentstyle = "width:" + divw + ";height:" + contentsh
    var titlefontstyle = "width:" + titlefontw
    //遮罩
    var mask = document.createElement("div");
    mask.className = "mask";
    mask.id = "mask"
    document.body.appendChild(mask);
    //弹出窗口
    var div = document.createElement("div");
    div.className = "div_shadow";
    div.id = "miniwin"
    div.setAttribute('style', divstyle);
    //标题
    var title = document.createElement("div");
    title.className = "title";
    title.setAttribute('onmousedown', 'windrag("miniwin",event)');
    var titlefont = document.createElement("div");
    titlefont.className = "titlefont";
    titlefont.innerHTML = _title;
    titlefont.setAttribute('unselectable', 'on');
    titlefont.setAttribute('onselectstart', 'return false;');
    titlefont.setAttribute('style', titlefontstyle);
    title.appendChild(titlefont);
    //关闭按钮
    var closes = document.createElement("div");
    closes.className = "close";
    closes.setAttribute('onclick', 'closeWindow("cancel")');
    title.appendChild(closes);
    div.appendChild(title);
    //正文内容
    var contents = document.createElement("div");
    var iframe = document.createElement("iframe");
    iframe.id = "MyIFrame";
    iframe.name = "MyIFrame";
    iframe.setAttribute('src', url);
    iframe.setAttribute('width', iframew);
    iframe.setAttribute('height', iframeh);
    contents.setAttribute('style', contentstyle);
    contents.appendChild(iframe);

    div.appendChild(contents);



    document.body.appendChild(div);
    AddEvt(mask, 'mousemove', function (e) {
        if (dragFlag) {
            e = e || window.event;
            document.getElementById("divghost").style.left = e.clientX - x + "px";
            document.getElementById("divghost").style.top = e.clientY - y + "px";
        }
    })
}
function ShowWin(win, width, height, _title, callback) {
    Mycallback = callback;
    showWindows = true;
    if (document.getElementById("mask")) {
        document.getElementById("mask").style.display = "";
    }
    if (document.getElementById("mywin")) {
        document.getElementById("mywin").style.display = ""; return;
    }

    //获取高度和宽度
    var divw = width;
    var divh = height;
    var contentsh = (divh.substring(0, divh.indexOf("px")) - 36) + "px";
    var titlefontw = (divw.substring(0, divw.indexOf("px")) - 70) + "px";
    var divstyle = "width:" + divw + ";height:" + divh
    var contentstyle = "width:" + divw + ";height:" + contentsh
    var titlefontstyle = "width:" + titlefontw
    //遮罩
    var mask = document.createElement("div");
    mask.className = "mask";
    mask.id = "mask"
    document.body.appendChild(mask);
    //弹出窗口
    var div = document.createElement("div");
    div.className = "div_shadow";
    div.id = "mywin"
    div.setAttribute('style', divstyle);
    //标题
    var title = document.createElement("div");
    title.className = "title";
    title.setAttribute('onmousedown', 'windrag("mywin",event)');
    var titlefont = document.createElement("div");
    titlefont.className = "titlefont";
    titlefont.innerHTML = _title;
    titlefont.setAttribute('unselectable', 'on');
    titlefont.setAttribute('onselectstart', 'return false;');
    titlefont.setAttribute('style', titlefontstyle);
    title.appendChild(titlefont);
    //关闭按钮
    var closes = document.createElement("div");
    closes.className = "close";
    closes.setAttribute('onclick', 'closeWindow("cancel")');
    title.appendChild(closes);
    div.appendChild(title);
    //正文内容
    var contents = document.createElement("div");
    contents.setAttribute('style', contentstyle);
    win.style.display = "";
    contents.innerHTML = win.outerHTML;
    //win.remove();
    win.parentNode.removeChild(win);
    div.appendChild(contents);
    document.body.appendChild(div);
    
    AddEvt(mask, 'mousemove', function (e) {
        if (dragFlag) {
            e = e || window.event;
            document.getElementById("divghost").style.left = e.clientX - x + "px";
            document.getElementById("divghost").style.top = e.clientY - y + "px";
        }
    })
   
    InitUI(true);
}
//关闭窗口
function closeWindow(action) {
    dragFlag = false;
    closeDiv(document.getElementById("miniwin"));
    closeDiv(document.getElementById("mask"));
    closeDiv(document.getElementById("mywin"));
    closeDiv(document.getElementById("maskalert"));
    closeDiv(document.getElementById("alert"));
    //destroy();
    if (Mycallback) {
        Mycallback(action);//关闭窗口回调函数
    }
    Mycallback = null;
}
function closeWindow2(action) {
    dragFlag = false;
    closeDiv(document.getElementById("miniwin"));
    closeDiv(document.getElementById("mask"));
    closeDiv(document.getElementById("maskalert"));
    closeDiv(document.getElementById("alert"));
    //destroy();
    if (Mycallback2) {
        if (action == "ok") {
            Mycallback(action);
        }
        else {
            Mycallback2(action);
        }
    }
    else if (Mycallback) {
        Mycallback(action);//关闭窗口回调函数
    }
}
var dragFlag = false;
//窗口拖拽
function windrag(id, e) {
    e = e || window.event;
    x = e.clientX - document.getElementById(id).offsetLeft;
    y = e.clientY - document.getElementById(id).offsetTop;
    dragFlag = true;
    setTimeout(function () {
        if (dragFlag) { 
        var divW = document.getElementById(id).style.width;
        var divH = document.getElementById(id).style.height;
        var divleft = document.getElementById(id).offsetLeft + "px";
        var divtop = document.getElementById(id).offsetTop + "px";
        var divstyle = "width:" + divW + ";height:" + divH + ";top:" + divtop + ";left:" + divleft;
        var div = document.createElement("div");
        div.className = "div_ghost";
        div.setAttribute('style', divstyle);
        div.id = "divghost"
        AddEvt(div, 'mousemove', function (e) {
            if (dragFlag) {
                e = e || window.event;
                document.getElementById("divghost").style.left = e.clientX - x + "px";
                document.getElementById("divghost").style.top = e.clientY - y + "px";
            }
        })
        AddEvt(div, 'mouseup', function (e) {
            dragFlag = false;
            document.getElementById(id).style.left = e.clientX - x + "px";
            document.getElementById(id).style.top = e.clientY - y + "px";
            document.getElementById(id).style.display = "";
            document.body.removeChild(document.getElementById("divghost"));
        })
        document.getElementById(id).style.display = "none";
            document.body.appendChild(div);
        }
    }, 200)
    
}

//初始化select标签控件
function InitSelect(item) {
    var url = item.getAttribute("url");
    if (url && item.options.length == 0) {
        var valueFiled = item.getAttribute("valueFiled");
        var textFiled = item.getAttribute("textFiled");
        var data = Ajax(url, "GET", "");
        //item.options.length = 0;
        for (var i = 0; i < data.length; i++) {
            item.options.add(new Option(data[i][textFiled], data[i][valueFiled]))
        }
    }
}
//input控件增加回车事件
function OnEnter(onenter) {
    var evt = window.event;
    if (evt.keyCode == 13) {
        //回车后要干的业务代码
        var fn = eval(onenter);
        if (fn) { fn(); }
    }
}
//初始化表格中的控件
function InitTDUI(item) {
    if (item.tagName.toLowerCase() == "select") {
        InitSelect(item);
    }
    else if (item.className == "autocomplete") {
        AddEvt(item, 'input', autocompletes)
        item.autocomplete = "off";
    }
    else if (item.className == "search") {
        AddEvt(item, 'click', function () {
            var callback = this.getAttribute("event");
            if (callback) {
                var fn = eval(callback);
                if (fn) {
                    fn();
                }
            }
        })
        item.autocomplete = "off";
    }
}
window.alert = UIalert;
//弹出窗口警告
var x, y;
function UIalert(msg, callback) {
    Mycallback = callback;
    showWindows = true;
    if (document.getElementById("alert")) {
        document.body.removeChild(document.getElementById("alert"));
    }
    if (document.getElementById("maskalert")) {
        document.body.removeChild(document.getElementById("maskalert"));
    }
    //获取高度和宽度
    var divw = "235px";
    var divh = "122px";
    var contentsh = (divh.substring(0, divh.indexOf("px")) - 36) + "px";
    var titlefontw = (divw.substring(0, divw.indexOf("px")) - 70) + "px";
    var divstyle = "width:" + divw + ";height:" + divh + ";background: #CED9E7"
    var contentstyle = "width:" + divw + ";height:" + contentsh
    var titlefontstyle = "width:" + titlefontw
    //遮罩
    var mask = document.createElement("div");
    mask.className = "mask";
    mask.id = "maskalert"
    document.body.appendChild(mask);
    //弹出窗口
    var div = document.createElement("div");
    div.className = "div_alertshadow";
    div.id = "alert"
    div.setAttribute('style', divstyle);
    //标题
    var title = document.createElement("div");
    title.className = "title";
    title.setAttribute('onmousedown', 'windrag("alert",event)');
    
    var titlefont = document.createElement("div");
    titlefont.className = "titlefont";
    titlefont.setAttribute('unselectable', 'on');
    titlefont.setAttribute('onselectstart', 'return false;');
    titlefont.innerHTML = "提示";
    titlefont.setAttribute('style', titlefontstyle);
    title.appendChild(titlefont);
    //关闭按钮
    var closes = document.createElement("div");
    closes.className = "close";
    closes.setAttribute('onclick', 'closeWindow("cancel")');
    title.appendChild(closes);
    div.appendChild(title);
    //正文内容
    var contents = document.createElement("div");
    var msgdiv = document.createElement("div");
    msgdiv.className = "msgdiv"
    var span = document.createElement("span");
    span.innerHTML = msg;
    span.setAttribute('text-align', "left");
    msgdiv.appendChild(span);
    var buttondiv = document.createElement("div");
    buttondiv.className = "buttondiv";
    var button = document.createElement("button");
    button.value = "OK";
    button.innerText = "OK";
    button.className = "alertbutton"
    button.setAttribute('onclick', 'closeWindow("ok")');
    buttondiv.appendChild(button);
    contents.setAttribute('style', contentstyle);
    contents.appendChild(msgdiv);
    contents.appendChild(buttondiv);

    div.appendChild(contents);
    AddEvt(mask, 'mousemove', function (e) {
        if (dragFlag) {
            e = e || window.event;
            document.getElementById("divghost").style.left = e.clientX - x + "px";
            document.getElementById("divghost").style.top = e.clientY - y + "px";
        }
    })
    document.body.appendChild(div);
}
//弹出窗口确认
function UIConfirm(msg, callback) {
    Mycallback = callback;
    showWindows = true;
    if (document.getElementById("alert")) {
        document.body.removeChild(document.getElementById("alert"));
    }
    if (document.getElementById("maskalert")) {
        document.body.removeChild(document.getElementById("maskalert"));
    }
    //获取高度和宽度
    var divw = "325px";
    var divh = "182px";
    var contentsh = (divh.substring(0, divh.indexOf("px")) - 36) + "px";
    var iframew = (divw.substring(0, divw.indexOf("px")) - 4) + "px";
    var iframeh = (contentsh.substring(0, contentsh.indexOf("px")) - 8) + "px";
    var titlefontw = (divw.substring(0, divw.indexOf("px")) - 70) + "px";
    var divstyle = "width:" + divw + ";height:" + divh + ";background: #CED9E7"
    var contentstyle = "width:" + divw + ";height:" + contentsh
    var titlefontstyle = "width:" + titlefontw
    //遮罩
    var mask = document.createElement("div");
    mask.className = "mask";
    mask.id = "maskalert"
    document.body.appendChild(mask);
    //弹出窗口
    var div = document.createElement("div");
    div.className = "div_alertshadow";
    div.id = "alert"
    div.setAttribute('style', divstyle);
    //标题
    var title = document.createElement("div");
    title.className = "title";
    title.setAttribute('onmousedown', 'windrag("alert",event)');
    var titlefont = document.createElement("div");
    titlefont.className = "titlefont";
    titlefont.innerHTML = "提示";
    titlefont.setAttribute('unselectable', 'on');
    titlefont.setAttribute('onselectstart', 'return false;');
    titlefont.setAttribute('style', titlefontstyle);
    title.appendChild(titlefont);
    //关闭按钮
    var closes = document.createElement("div");
    closes.className = "close";
    closes.setAttribute('onclick', 'closeWindow("cancel")');
    title.appendChild(closes);
    div.appendChild(title);
    //正文内容
    var contents = document.createElement("div");
    //message内容
    var msgdiv = document.createElement("div");
    msgdiv.className = "confirmmsgdiv"
    var span = document.createElement("span");
    span.innerHTML = msg;
    span.setAttribute('text-align', "left");
    msgdiv.appendChild(span);
    var buttondiv = document.createElement("div");
    buttondiv.className = "buttondiv";
    //确认按钮
    var button = document.createElement("button");
    button.value = "OK";
    button.innerText = "确认";
    button.className = "alertbutton"
    button.setAttribute('onclick', 'closeWindow("ok")');
    buttondiv.appendChild(button);
    //取消按钮
    var button2 = document.createElement("button");
    button2.value = "cancel";
    button2.innerText = "取消";
    button2.className = "alertbuttoncancel"
    button2.setAttribute('onclick', 'closeWindow("cancel")');
    buttondiv.appendChild(button2);

    contents.setAttribute('style', contentstyle);
    contents.appendChild(msgdiv);
    contents.appendChild(buttondiv);

    div.appendChild(contents);
    AddEvt(mask, 'mousemove', function (e) {
        if (dragFlag) {
            e = e || window.event;
            document.getElementById("divghost").style.left = e.clientX - x + "px";
            document.getElementById("divghost").style.top = e.clientY - y + "px";
        }
    })
    document.body.appendChild(div);
}
function UImask(msg) {
    if (document.getElementById("mymask")) {
        document.body.removeChild(document.getElementById("mymask"));
    }
    if (document.getElementById("loadmsg")) {
        document.body.removeChild(document.getElementById("loadmsg"));
    }
    if (!msg) {
        msg="Loading..."
    }
    var divw = "235px";
    var divh = "122px";

    var divstyle = "width:" + divw + ";height:" + divh + ";background: #FFFFFF"
    //遮罩
    var mask = document.createElement("div");
    mask.className = "mask";
    mask.id = "mymask"
    document.body.appendChild(mask);
    //弹出窗口
    var div = document.createElement("div");
    div.className = "div_alertshadow";
    div.id = "loadmsg"
    div.setAttribute('style', divstyle);

    var loadimg = document.createElement("div");
    loadimg.className = "loadimg";
    div.appendChild(loadimg);

    var span = document.createElement("div");
    span.innerHTML = msg;
    span.setAttribute('style', "text-align:center");
    div.appendChild(span);

    document.body.appendChild(div);

}
function UIunmask() {
    if (document.getElementById("mymask")) {
        document.body.removeChild(document.getElementById("mymask"));
    }
    if (document.getElementById("loadmsg")) {
        document.body.removeChild(document.getElementById("loadmsg"));
    }
    
}
//弹出窗口自定义按钮
function UIConfirm2(msg, btn1, btn2, callback1, callback2) {
    Mycallback = callback1;
    Mycallback2 = callback2;
    showWindows = true;
    if (document.getElementById("alert")) {
        document.body.removeChild(document.getElementById("alert"));
    }
    if (document.getElementById("maskalert")) {
        document.body.removeChild(document.getElementById("maskalert"));
    }
    //获取高度和宽度
    var divw = "275px";
    var divh = "182px";
    var contentsh = (divh.substring(0, divh.indexOf("px")) - 36) + "px";
    var iframew = (divw.substring(0, divw.indexOf("px")) - 4) + "px";
    var iframeh = (contentsh.substring(0, contentsh.indexOf("px")) - 8) + "px";
    var titlefontw = (divw.substring(0, divw.indexOf("px")) - 70) + "px";
    var divstyle = "width:" + divw + ";height:" + divh + ";background: #CED9E7"
    var contentstyle = "width:" + divw + ";height:" + contentsh
    var titlefontstyle = "width:" + titlefontw
    //遮罩
    var mask = document.createElement("div");
    mask.className = "mask";
    mask.id = "maskalert"
    document.body.appendChild(mask);
    //弹出窗口
    var div = document.createElement("div");
    div.className = "div_alertshadow";
    div.id = "alert"
    div.setAttribute('style', divstyle);
    //标题
    var title = document.createElement("div");
    title.className = "title";
    title.setAttribute('onmousedown', 'windrag("alert",event)');
    var titlefont = document.createElement("div");
    titlefont.className = "titlefont";
    titlefont.setAttribute('unselectable', 'on');
    titlefont.setAttribute('onselectstart', 'return false;');
    titlefont.innerHTML = "提示";
    titlefont.setAttribute('style', titlefontstyle);
    title.appendChild(titlefont);
    //关闭按钮
    var closes = document.createElement("div");
    closes.className = "close";
    closes.setAttribute('onclick', 'closeWindow2("cancel")');
    title.appendChild(closes);
    div.appendChild(title);
    //正文内容
    var contents = document.createElement("div");
    //message内容
    var msgdiv = document.createElement("div");
    msgdiv.className = "confirmmsgdiv"
    var span = document.createElement("span");
    span.innerHTML = msg;
    span.setAttribute('text-align', "left");
    msgdiv.appendChild(span);
    var buttondiv = document.createElement("div");
    buttondiv.className = "buttondiv";
    //确认按钮
    var button = document.createElement("button");
    button.value = "OK";
    button.innerText = btn1;
    button.className = "alertbutton"
    button.setAttribute('onclick', 'closeWindow2("ok")');
    buttondiv.appendChild(button);
    //取消按钮
    var button2 = document.createElement("button");
    button2.value = "cancel";
    button2.innerText = btn2;
    button2.className = "alertbuttoncancel"
    button2.setAttribute('onclick', 'closeWindow2("cancel")');
    buttondiv.appendChild(button2);

    contents.setAttribute('style', contentstyle);
    contents.appendChild(msgdiv);
    contents.appendChild(buttondiv);

    div.appendChild(contents);

    AddEvt(mask, 'mousemove', function (e) {
        if (dragFlag) {
            e = e || window.event;
            document.getElementById("divghost").style.left = e.clientX - x + "px";
            document.getElementById("divghost").style.top = e.clientY - y + "px";
        }
    })
 
    document.body.appendChild(div);
}
//输入框提示
function TextBlur() {

    var tip = this.getAttribute("nulltip");
    if (this.value == "") {
        this.value = tip;
        this.style.color = "Silver";
    }
}
function TextFocus() {
    var tip = this.getAttribute("nulltip");
    if (this.value == tip) {
        this.value = "";
        this.style.color = "#000000";
    }
}
//初始化DropDown
function InitArrow(arrow)
{
    var dropdown = arrow.getAttribute("dropdown");
    var drop = arrow.getAttribute("drop");
    var span = document.createElement("span");
    if (drop == "true")
    {
        span.className = "arrow-down right";
        document.getElementById(dropdown).style.display = "";
    }
    else
    { 
        span.className = "arrow-right right";
        document.getElementById(dropdown).style.display = "none";
    }
    span.id = dropdown + "ico";
    arrow.appendChild(span);
    AddEvt(arrow, 'click', function () {
        var drop = arrow.getAttribute("drop");
        var dropdown = arrow.getAttribute("dropdown");
        if (drop == "true") {
            document.getElementById(dropdown + "ico").className = "arrow-right right";
            document.getElementById(dropdown).style.display = "none";
            arrow.setAttribute("drop","false")
        }
        else {
            document.getElementById(dropdown + "ico").className = "arrow-down right";
            document.getElementById(dropdown).style.display = "";
            arrow.setAttribute("drop", "true")
        }
    })
}
//初始化控件
function InitUI(IsReload) {
    //初始化autocomplete
    var auto = document.getElementsByClassName("autocomplete");
    for (var item = 0; item < auto.length; item++) {
        AddEvt(auto[item], 'input', autocompletes)
        auto[item].autocomplete = "off";
    }
    //初始化search
    var serch = document.getElementsByClassName("search");
    for (var item = 0; item < serch.length; item++) {
        AddEvt(serch[item], 'click', function () {
            var callback = this.getAttribute("event");
            if (callback) {
                var fn = eval(callback);
                if (fn) {
                    fn();
                }
            }
        })
        serch[item].autocomplete = "off";
    }
    //初始化select
    var select = document.getElementsByTagName("select");
    for (var j = 0; j < select.length; j++) {
        InitSelect(select[j]);
    }
     //初始化tdinputText
    var inputs = document.getElementsByClassName("tdinputText");
    for (var j = 0; j < inputs.length; j++) {
        var onenter = inputs[j].getAttribute("onenter");
        if (onenter) {
            AddEvt(inputs[j], 'keydown', function () { OnEnter(onenter); })
        }
        var tips = inputs[j].getAttribute("nulltip");

        if (tips) {

            AddEvt(inputs[j], 'focus', TextFocus)
            AddEvt(inputs[j], 'blur', TextBlur)
            inputs[j].value = tips;
            inputs[j].style.color = "Silver"; //"tdinputTextTip";
        }
    }
    //初始化tableblue
    var mytables = document.getElementsByClassName("tableblue")
    if (!IsReload) {
        tables.length = 0;
    }
    for (var j = 0; j < mytables.length; j++) {
        AddEvt(mytables[j], 'click', tableclick)
        AddEvt(mytables[j], 'mouseover', tablemouseover)
        AddEvt(mytables[j], 'mouseout', tablemouseout)
        if (!IsReload) {
            InitTable(mytables[j]);
        }
        
    }
    //初始化arrow
    var arrows = document.getElementsByClassName("arrow")
    for (var j = 0; j < arrows.length; j++) {
        InitArrow(arrows[j]);
    }
}
//初始化table
function InitTable(table) {
    var Mytable = new Object();
    Mytable.id = table.id;
    var showpager = table.getAttribute("showpager");
    var forUpdate = table.getAttribute("forUpdate");
    var url = table.getAttribute("url");
    Mytable.url = url;
    if (forUpdate) {
        Mytable.forUpdate = forUpdate;
    }
    var PageSize = table.getAttribute("PageSize");
    if (!PageSize) {
        table.setAttribute("PageSize", 10)
        PageSize = 10;
    }
    Mytable.PageSize = PageSize;
    Mytable.PageIndex = 0;
    if (showpager == "true") {
        if (document.getElementById(table.id + "pager")) {
            document.getElementById(table.id + "pager").parentNode.removeChild(document.getElementById(table.id + "pager"));
        }
        var pager = document.createElement("div");
        pager.id = table.id + "pager";
        pager.className = "pager";
        var pagerhtml = "<span>总条数：</span><span id='" + table.id + "rowcount' style='margin-left: 2px;'>0</span>&nbsp;&nbsp;<span>每页显示：</span>";
        pagerhtml += "<select id='" + table.id + "pagesize' style='width:78px;' onchange='BindGridSize(this.value,&apos;" + table.id + "&apos;)'><option value='10'>10</option>";
        pagerhtml += "<option value='20'>20</option><option value='30'> 30</option></select><a onclick='BindGridInex(&apos;first&apos;,&apos;" + table.id + "&apos;)'>首页</a>";
        pagerhtml += "<a onclick='BindGridInex(&apos;prve&apos;,&apos;" + table.id + "&apos;)'>上一页</a>第<span id='" + table.id + "pageindex'>1</span>/<span id='" + table.id + "pagecount'>1</span>页";
        pagerhtml += "<a onclick='BindGridInex(&apos;next&apos;,&apos;" + table.id + "&apos;)'>下一页</a><a onclick='BindGridInex(&apos;last&apos;,&apos;" + table.id + "&apos;)'>末页</a>";
        pagerhtml += "<input type='text' style='width: 50px; margin: 0px;' value='1' id='" + table.id + "pageindex2'><a onclick='Go(&apos;" + table.id + "&apos;)'>跳转</a>";
        pager.innerHTML = pagerhtml;

        var pageprompt = table.getAttribute("pageprompt");
        if (pageprompt) {
            document.getElementById(pageprompt).innerHTML += pagerhtml
        }
        else {
            table.parentNode.appendChild(pager);
        }
        var PageList = table.getAttribute("PageList");
        if (PageList) {
            var arr = PageList.replace("[", "").replace("]", "").split(",")
            document.getElementById( table.id + "pagesize").options.length = 0;
            for (var i = 0; i < arr.length; i++) {
                document.getElementById( table.id + "pagesize").options.add(new Option(arr[i], arr[i]))
            }
        }
        document.getElementById(table.id + "pagesize").value = PageSize;
    }
    else {
        Mytable.PageSize = 1000;
    }
    Mytable.title = Inittitle(table);
    Mytable.titleRowCount = table.rows.length;
    Mytable.rowNum = 1;
    var AddRows = new Array();
    var UpdateRows = new Array();
    var IndexArr = new Array();
    Mytable.IndexArr = IndexArr;
    Mytable.AddRows = AddRows;
    Mytable.UpdateRows = UpdateRows;
    Mytable.RemoveRows = new Array();
    Mytable.titleCol
    tables.push(Mytable);
}
function $(name) {
    if (name.substring(0, 1) == "#") {
        return document.getElementById(name.substring(1, name.length))
    }
    else if (name.substring(0, 1) == ".") {
        return document.getElementsByClassName(name.substring(1, name.length))
    }
    else if (name.substring(0, 1) == "*") {
        return document.getElementsByTagName(name.substring(1, name.length))
    }
    else if (name.substring(0, 1) == "&") {
        return document.getElementsByName(name.substring(1, name.length))
    }
}
//重新设置控件url,(table必须使用此方法重置，否则无效)
function setUrl(id,url) {
    var table = GetTable(id);
    if (table) {
        table.url = url;
    }
    document.getElementById(id).setAttribute("url", url);
}
function CastNum(str) {
    if (str && str != "" && str != " " && str != "undefined" && str != "null" && str != "NULL") {
        return parseFloat(str);
    }
    else {
        return 0;
    }
}
//冻结列
function Frozen(id, side) {
    var table = GetTable(id);
    var mytable = document.getElementById(id);
    if (document.getElementById(id + "_FrozenDiv")) {
        mytable.parentNode.removeChild(document.getElementById(id + "_FrozenDiv"));
    }
    mytable.parentNode.setAttribute("style", "width:100%;height:400px;overflow-x:scroll;overflow-y:hidden");
    var div = document.createElement("div");
    div.className = "div_Frozen";
    div.id = id +"_FrozenDiv"
    
    var title = table.title;
    var divW = 0, divH = 0, divtop = 0, sideleft = 0;
    var Ftable = document.createElement("table");
    Ftable.id = table.id + "_FrozenTable";
    Ftable.className = "tableblue";
    divtop = mytable.offsetTop;
    var Ftbody = document.createElement("tbody");
    for (var j = 0; j < mytable.rows.length; j++) { 
        var Ftr = document.createElement("tr");
        divH += CastNum(mytable.rows[j].offsetHeight);
        
        for (var i = 0; i < title.length; i++)
        {
            if (mytable.rows[j].cells[i])//标题
            { 
                if (mytable.rows[j].cells[i].getAttribute("frozen") == "true")
                {
                     
                    var Ftd;
                    if (j < table.titleRowCount) {
                        Ftd = document.createElement("th");
                        Ftd.height = mytable.rows[j].offsetHeight - 1;
                        if (mytable.rows[j].cells[i].getAttribute("rowspan")) {
                            Ftd.setAttribute("rowspan", mytable.rows[j].cells[i].getAttribute("rowspan"));
                        }
                        if (mytable.rows[j].cells[i].getAttribute("colspan")) {
                            Ftd.setAttribute("colspan", mytable.rows[j].cells[i].getAttribute("colspan"));
                        }
                        if (j == 0) {
                            divW += CastNum(mytable.rows[j].cells[i].offsetWidth);
                        }
                    }
                    Ftd.width = mytable.rows[j].cells[i].offsetWidth-8;
                    Ftd.innerHTML = mytable.rows[j].cells[i].innerHTML;
                    Ftr.appendChild(Ftd);
                }
            }
            if (title[i].getAttribute("frozen") == "true" && j >= table.titleRowCount)//行内容
            {
                var Ftd = document.createElement("td");
                Ftd.height = mytable.rows[j].offsetHeight - 3;
                Ftd.width = mytable.rows[j].cells[i].offsetWidth - 8;
                if (mytable.rows[j].cells[i].childNodes[0]) {
                    var childs = mytable.rows[j].cells[i].childNodes;
                    for (var k = 0; k < childs.length; k++) { 
                        var Fchild = childs[k].cloneNode(true);
                        if (childs[k].id) {
                            childs[k].id += "frozen"
                        }
                        Ftd.appendChild(Fchild);
                    }
                    if (mytable.rows[j].cells[i].id) {
                        Ftd.id = mytable.rows[j].cells[i].id;
                        mytable.rows[j].cells[i].id += "frozen"
                    }
                }
                else {
                    Ftd.innerHTML = mytable.rows[j].cells[i].innerHTML;
                }
                Ftr.appendChild(Ftd);
            }

        }
        
        if (j < table.titleRowCount) {
            Ftbody.appendChild(Ftr);
        }
        else {
            Ftable.appendChild(Ftr);
            Ftr.id = table.id + "_FrozenTable" + (j - table.titleRowCount+1);
        }
        if (j == table.titleRowCount-1) {
            Ftable.appendChild(Ftbody);
        }
    }
    AddEvt(Ftable, 'click', tableclick)
    div.appendChild(Ftable);
    //divtop = 0;
    sideleft = 8;
    var divstyle = "width:" + (divW+1) + "px;height:" + (divH) + "px;top:" + divtop + "px;" + side + ":" + sideleft + "px";
    div.setAttribute('style', divstyle);
    mytable.parentNode.appendChild(div);
    mytable.parentNode.style.height = (divH+30) + "px";
    table.Frozen = true;
    table.FrozenSide = side;
    var Mytable = new Object();
    Mytable.id = table.id + "_FrozenTable";
    Mytable.titleRowCount = table.titleRowCount;
    Mytable.IndexArr = table.IndexArr;
    tables = tables.filter(function (item) {
        return item.id != Mytable.id
    });
    tables.push(Mytable);
}