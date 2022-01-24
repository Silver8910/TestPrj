<%@page import="opendraft.service.gate_web.jsp_index_impl"%>
<%@ page import="opendraft.service.ods_server_page.run_session.menu_session.MenuInfoShare"%>
<%@ page import="opendraft.service.gate_web.jsp_ODS_ServerPage_Main"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
String ReqVal = request.getParameter("ReqVal");

opendraft.service.gate_web.ODWebembedGate web_gate = new opendraft.service.gate_web.ODWebembedGate();
web_gate._opendraft_server = opendraft.service.ServiceManager._service_mng;

String dw_name = "KCResultSign";
String type = "Query";
String method = "query_SignCheck_call_dw";
String col_result = "result";

java.util.Hashtable<String, String> map_param = new java.util.Hashtable<String, String>();
map_param.put("PARAM1", ReqVal);
map_param.put("PARAM2", "");
map_param.put("PARAM3", "");

String RsltData = "";
String _RsltTp = "";
String _RsltMsg = "";
// query
if (!web_gate.DW_Call(dw_name, type, method, map_param, col_result))
{
	_RsltTp = "Error";
	_RsltMsg = "계약서 확인중 오류가 발생했습니다.";
	return;
}
else
{
	RsltData = web_gate._result_val;
}

String[] RsltData_Arr = RsltData.split("//");
String SignCustCd = RsltData_Arr[0];
String SignCustNm = RsltData_Arr[1];
String SignBizRegNo = RsltData_Arr[2];
String SignHrCd = RsltData_Arr[3];
String SignHrNm = RsltData_Arr[4];
String EMail = RsltData_Arr[5];
String SignStatus = RsltData_Arr[6];

if ( SignCustCd.equals("") )
{
	_RsltTp = "CustJoin";
	_RsltMsg = "전자계약시스템 기업회원이 아닙니다. 회원가입화면으로 이동합니다.";
	//response.sendRedirect("./index.jsp?init_mode=cust_join");
}
else
{
    String param_1 = URLEncoder.encode(ReqVal, "UTF-8");
	response.sendRedirect("./ODS_ServerPage_Run.jsp?ods_sid=annony_user&menu_code=KCC113E&ods_param1="+param_1);
}

%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Opendraft</title>
<meta charset="utf-8">

<link rel="stylesheet" type="text/css" href="mobile/css/default.css">
<link rel="stylesheet" type="text/css" href="mobile/css/login2.css">

	<meta name="viewport" content="width=device-width, 
	initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=medium-dpi">


<script type="text/javascript">
				
	function OnLoad(  )
	{
		var RsltTp = "<%=_RsltTp%>";
		var RsltMsg = "<%=_RsltMsg%>";
		alert(RsltMsg);
		if ( RsltTp == "Error" ) self.close();
		else if ( RsltTp == "CustJoin" ) location.href = "./index.jsp?init_mode=cust_join";
	}
				
</script>

</head>

<body onload="OnLoad()" style=" overflow:auto; width:480px;  ">

</body>

</html>