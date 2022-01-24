<%@page import="opendraft.service.gate_web.jsp_index_impl"%>
<%@ page import="opendraft.service.ods_server_page.run_session.menu_session.MenuInfoShare"%>
<%@ page import="opendraft.service.gate_web.jsp_ODS_ServerPage_Main"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");

String user_id = request.getParameter("user_id");
String pwd = request.getParameter("pwd");
String biz_reg_no = request.getParameter("biz_reg_no");
String param_check_save = request.getParameter("chk_save");
String call_type = request.getParameter("call_type");
String SerialNumberDec = request.getParameter("SerialNumberDec");
String SubjectKeyID = request.getParameter("SubjectKeyID");

opendraft.service.gate_web.ODWebembedGate web_gate = new opendraft.service.gate_web.ODWebembedGate();
web_gate._opendraft_server = opendraft.service.ServiceManager._service_mng;

String dw_name = "BAHr";
String type = "Query";
String method = "query_login_check";
String col_result = "result";

java.util.Hashtable<String, String> map_param = new java.util.Hashtable<String, String>();
map_param.put("PARAM1", user_id);
map_param.put("PARAM2", pwd);
if ( call_type.equals("CustCerti") ) map_param.put("PARAM3", call_type+"//"+biz_reg_no+"//"+SerialNumberDec+"//"+SubjectKeyID);
else map_param.put("PARAM3", call_type+"//"+biz_reg_no);

String RsltData = "";
// query
if (!web_gate.DW_Call(dw_name, type, method, map_param, col_result))
{
	session.setAttribute("LoginRsltMsg", call_type+"//로그인에 실패하였습니다.");
	response.sendRedirect("./index.jsp");
	return;

}
else
{
	RsltData = web_gate._result_val;
}

String[] RsltData_Arr = RsltData.split("//");
String RsltCode = RsltData_Arr[0];
String RsltMsg = "";
if ( RsltData_Arr.length > 1 ) RsltMsg = RsltData_Arr[1];

if( !RsltCode.equals("00") )
{
	session.setAttribute("LoginRsltMsg", call_type+"//"+RsltMsg);
	response.sendRedirect("./index.jsp");
}
else
{
	// login session build

	opendraft.service.gate_web.jsp_index_impl page_impl = 
			new opendraft.service.gate_web.jsp_index_impl(request, response, session);
	
	String sid = "";
	if ( call_type.equals("CustCerti") )
	{
		sid = page_impl.SL_P2( "web", user_id, "ko" );
		if( sid.length() < 1)
		{
			String error = page_impl.GetError();
			response.sendRedirect("./index.jsp");
			return;
		}
	}
	else
	{
		sid = page_impl.Session_Login( "web", user_id, pwd, "KO");
		if( sid.length() < 1 )
		{
			// page_impl._error_str <- error value
			response.sendRedirect("./index.jsp");
			return;
		}
	}

	if ( sid.equals("") )
	{
		response.sendRedirect("./index.jsp");
		return;
	}


	// save session
	session.setAttribute("ods_session_id", sid);
	session.setAttribute("lang_id", "KO");




	// cookie write
	page_impl.CookieWrite("lang_id", "KO");		
	if (param_check_save != null && (param_check_save.compareTo("on") ==0||param_check_save.compareTo("1") ==0) )
	{
		page_impl.CookieWrite("user_id", user_id);
		page_impl.CookieWrite("chk_save", "Y");
	}
	else
	{
		page_impl.CookieWrite("user_id", "");
		page_impl.CookieWrite("chk_save", "");
	}
	response.sendRedirect("./ODS_ServerPage_Main.jsp");
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
				
				
				
			   </script>

</head>

<body style=" overflow:auto; width:480px;  ">

	chk : <%out.write(param_check_save);%>
	uid : <%out.write(user_id);%>
</body>

</html>