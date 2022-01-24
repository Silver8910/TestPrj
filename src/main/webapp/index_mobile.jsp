<%@page import="opendraft.service.gate_web.jsp_index_mobile_impl"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
opendraft.service.gate_web.ODWebembedGate gate_impl = new opendraft.service.gate_web.ODWebembedGate();

String str_init_error = gate_impl.InitService( request.getSession().getServletContext() );
if( str_init_error.length() > 0 )
{
	response.getWriter().write(str_init_error);
	return;
}

String is_error = "";
String error_client_str = "";

String uid = "";
String pwd = "";

jsp_index_mobile_impl this_impl = new jsp_index_mobile_impl();
this_impl.Page_Load( request, response );

is_error = this_impl._is_error;
error_client_str = this_impl._error_client_str;

%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Opendraft</title>
<meta charset="utf-8">
<meta name="format-detection" content="telephone=no">

<link rel="stylesheet" type="text/css" href="mobile/css/default.css">
<link rel="stylesheet" type="text/css" href="mobile/css/login2.css">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=medium-dpi">

    
    
    <script type="text/javascript">
        
        function LoginOpendraft() {
            if (document.user_info.uid.value == "") {
                alert("사용자 계정을 입력해 주세요.");
                return;
            }

            if (document.user_info.pwd.value == "") {
                alert("비밀번호를 입력해 주세요.");
                return;
            }
            

            document.user_info.chk_login.value = "ok";            
            document.user_info.submit();
        }


        
    </script>
    
    <script type="text/javascript" language = "javascript">

        //window.addEventListener('load', function() {

        //    setTimeout(scrollTo, 0, 0, 1);

        //}, false);
 
    </script>
</head>

<body style="">

<form id="user_info" name="user_info" runat="server">
<input type=hidden maxlength=20 name="chk_login" id="chk_login" value="" />
<div class="log_box">
    	<div>
            <h1><img src="mobile/images/h1_logo.png" alt="각자의 힘, 하나의 복산 나이스"></h1>
            <p>Login</p>
            <ul>
            <li class="line">
                <select>
                <option>KO</option>
                </select>
            </li>
            
            <li><input type="text" placeholder="사용자 ID" name="uid" id="uid" value="<%=uid%>"></li>
            <li><input type="password" placeholder="비밀번호" name="pwd" id="pwd" value="<%=pwd%>"></li>
            <li class="bt"><!--<a href="javascript:LoginOpendraft()" >Login</a></li>-->
				<button type="submit" value="Sign In" class="BtnLogin loginBtn" onclick="javascript:LoginOpendraft()" id="submit_label" style="cursor:pointer">
						Login</button>
            </ul>
        </div>
    </div>
</form>
</body>
</html>
