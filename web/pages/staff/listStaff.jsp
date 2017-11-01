<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>无标题文档</title>

    <link href="${pageContext.request.contextPath}/css/sys.css" type="text/css" rel="stylesheet"/>
</head>

<body>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
    <tr>
        <td class="topg"></td>
    </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" class="wukuang" width="100%">
    <tr>
        <td width="1%"><img src="${pageContext.request.contextPath}/images/tleft.gif"/></td>
        <td width="39%" align="left">[员工管理]</td>

        <td width="57%" align="right">
            <%--高级查询 --%>
            <a href="javascript:void(0)" onclick="condition()"><img
                    src="${pageContext.request.contextPath}/images/button/gaojichaxun.gif"/></a>
            <script type="text/javascript">
                function condition() {
                    document.getElementById("conditionFormId").submit();
                }
            </script>
            <%--员工注入 --%>
            <a href="${pageContext.request.contextPath}/pages/staff/addStaff.jsp">
                <img src="${pageContext.request.contextPath}/images/button/tianjia.gif"/>
            </a>

        </td>
        <td width="3%" align="right"><img src="${pageContext.request.contextPath}/images/tright.gif"/></td>
    </tr>
</table>

<!-- 查询条件：马上查询 -->
<form id="conditionFormId" action="${pageContext.request.contextPath}/findStaff.action" method="post">
    <table width="88%" border="0" style="margin: 20px;">
        <tr>
            <td width="80px">部门：</td>
            <td width="200px">

                <select name="post.department.depID" onchange="changePost(this)">
                    <option value="-1">--请选择部门--</option>
                    <s:iterator value="#attr.departments" var="depart">
                        <option value="${depart.depID}">${depart.depName}</option>
                    </s:iterator>

                    <%--<option value="ee050687bd1a4455a153d7bbb7000002">咨询部</option>--%>
                </select>

            </td>
            <td width="80px">职务：</td>
            <td width="200px">

                <select name="post.postId" id="postSelectId">
                    <option value="-1">--请选择职务--</option>
                    <%--<option value="ee050687bd1a4455a153d7bbb7000003">总监</option>--%>
                    <%--<option value="ee050687bd1a4455a153d7bbb7000004">讲师</option>--%>
                    <%--<option value="ee050687bd1a4455a153d7bbb7000005">主管</option>--%>
                    <script type="text/javascript">
                        function createXMLHttpRequest() {
                            try {
                                return new XMLHttpRequest();
                            } catch (e) {
                                try {
                                    return new ActiveXObject("Msxml2.HTTP");
                                } catch (e) {
                                    try {
                                        return new ActiveXObject("Microsoft.HTTP");
                                    } catch (e) {
                                        throw e;
                                    }
                                }
                            }
                        }
                        function changePost(obj) {

                            var departId = obj.value;
                            var httpRequest = createXMLHttpRequest();
                            var url = "${pageContext.request.contextPath}/findPost.action";
                            httpRequest.open("POST", url, true);
                            httpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                            httpRequest.send("depId=" + departId);
                            httpRequest.onreadystatechange = function () {
                                if (httpRequest.readyState == 4 && httpRequest.status == 200) {
                                    var jsonData = eval("(" + httpRequest.responseText + ")");
                                    var postSelect = document.getElementById("postSelectId");
                                    postSelect.innerHTML = "<option value='-1'>---请选择---</option>";
                                    for (var i = 0; i < jsonData.length; i++) {
                                        var id = jsonData[i].postId;
                                        var postName = jsonData[i].postName;
                                        postSelect.innerHTML += "<option value='" + id + "'>" + postName + "</option>";
                                    }
                                }
                            }

                        }
                    </script>
                </select>

            </td>
            <td width="80px">姓名：</td>
            <td width="200px"><input type="text" name="staffName" size="12"/></td>
            <td></td>
        </tr>
    </table>
</form>


<table border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
    <tr>
        <td><img src="${pageContext.request.contextPath}/images/result.gif"/></td>
    </tr>
</table>

<table width="100%" border="1">
    <tr class="henglan" style="font-weight:bold;">
        <td width="10%" align="center">员工姓名</td>
        <td width="6%" align="center">性别</td>
        <td width="12%" align="center">入职时间</td>
        <td width="15%" align="center">所属部门</td>
        <td width="10%" align="center">职务</td>
        <td width="10%" align="center">编辑</td>
    </tr>

    <s:iterator value="#session.staffs" var="staff" status="st">
        <s:if test="#st.Even">
            <tr class="tabtd1">
        </s:if>
        <s:else>
            <tr class="tabtd2">
        </s:else>
        <td align="center">${staff.staffName}</td>
        <td align="center">${staff.gender}</td>
        <td align="center">${staff.onDutyDate}</td>
        <td align="center">${staff.post.department.depName}</td>
        <td align="center">${staff.post.postName}</td>
        <td width="7%" align="center">

            <a href="${pageContext.request.contextPath}/findById.action?staffId=${staff.staffId}"><img
                    src="${pageContext.request.contextPath}/images/button/modify.gif" class="img"/></a>
        </td>

        </tr>
    </s:iterator>

</table>


<%-- 
<table border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td align="right">
    	<span>第1/3页</span>
        <span>
        	<a href="#">[首页]</a>&nbsp;&nbsp;
            <a href="#">[上一页]</a>&nbsp;&nbsp;
            <a href="#">[下一页]</a>&nbsp;&nbsp;
            <a href="#">[尾页]</a>
        </span>
    </td>
  </tr>
</table>
--%>
</body>
</html>
