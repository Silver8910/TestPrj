<%@page import="opendraft.service.gate_web.jsp_index_impl"%>
<%@ page import="opendraft.service.ods_server_page.run_session.menu_session.MenuInfoShare"%>
<%@ page import="opendraft.service.gate_web.jsp_ODS_ServerPage_Main"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<%

String _init_mode = request.getParameter("init_mode");

// Opendraft Service 초기화
opendraft.service.gate_web.ODWebembedGate gate_impl = new opendraft.service.gate_web.ODWebembedGate();

String str_init_error = gate_impl.InitService( request.getSession().getServletContext() );
if( str_init_error.length() > 0 )
{
	response.getWriter().write(str_init_error);
	return;
}


//response.


jsp_index_impl this_impl = new jsp_index_impl();

// demo 페이지로 이동
this_impl._init_redirect_page = "ODS_ServerPage_Main.jsp";


this_impl.Page_Load( request, response );

String opendraft_auto_logoin_script = this_impl.opendraft_auto_logoin_script;
String opendraft_x_codebase = this_impl.opendraft_x_codebase;

String g_lang_ko_check = this_impl.g_lang_ko_check;
String g_lang_ch_check = this_impl.g_lang_ch_check;
String g_lang_en_check = this_impl.g_lang_en_check;
String g_lang_jp_check = this_impl.g_lang_jp_check;

String g_run_type_stan = this_impl.g_run_type_stan;
String g_run_type_silver = this_impl.g_run_type_silver;
String g_run_type_web = this_impl.g_run_type_web;
String g_check_save = this_impl.g_check_save;
String g_user_id = this_impl.g_user_id;

//g_check_save= "ok";



/*
// pwd 전달 테스트
System.out.println("indexpwd1:"+request.getParameter("pwd"));
request.setAttribute("pwd2", request.getParameter("pwd"));
System.out.println("indexpwd2:"+request.getAttribute("pwd2"));

// Cookie 테스트
 Cookie cookie = new Cookie("testCookie", request.getParameter("pwd")); //Cookie cookie = new Cookie("쿠키이름", 쿠키값); 
 //2. Cookie객체 설정
 //setXXX 매서들을 이용하여 설정. 만일 값이 없으면 기본값이 설정됨.
 cookie.setMaxAge(60*60*24*15); //c.setMacAge(초 단위으 쿠키 유효시간 값);
 cookie.setPath("/"); //쿠키가 유효한 디렉토리 정보 설정 cookie.setPath("유효 디렉토리");, "/"일경우 해당 도메인에 모든 페이지에서 유효
 //3. Cookie 추가
 response.addCookie(cookie); //Cookie 객체를 response 객체에 addCookie() 매서드로 추가
*/

String g_LoginRsltMsg = (String)session.getAttribute("LoginRsltMsg");
session.setAttribute("LoginRsltMsg", "");
String g_SignRsltMsg = (String)session.getAttribute("SignRsltMsg");




	// 메뉴 생성
    opendraft.service.gate_web.ODWebembedGate web_gate = new opendraft.service.gate_web.ODWebembedGate();
    web_gate._opendraft_server = opendraft.service.ServiceManager._service_mng;

    String Prefix = "result : ";
    String dw_name = "BAMenuSetting";
    String type = "Query";
    String method = "query_menu_html_index";
    String col_result = "result";

    java.util.Hashtable<String, String> map_param = new java.util.Hashtable<String, String>();
    //map_param.put("PARAM1", _TreeName); // tree_name
    map_param.put("PARAM1", "annony"); // tree_name
    map_param.put("PARAM2", "root_menu"); // 상위메뉴
    map_param.put("PARAM3", "KO"); // 언어코드

    String RsltData = "";
    String _MenuHtml = "";
    // query
    if (web_gate.DW_Call(dw_name, type, method, map_param, col_result))
    {
        RsltData = web_gate._result_val;
        _MenuHtml = RsltData;
    }
%>


<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<meta data-n-head="ssr" charset="utf-8">
	<meta data-n-head="ssr" name="viewport" content="width=device-width,initial-scale=1">
	<meta data-n-head="ssr" data-hid="description" name="description" content="POP System">
	
	
	<script src="./asset_ods/js/jquery.min.js"></script>
	<script src="./asset_ods/js/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="./ods_web_app/jquery/redmond/jquery-ui-1.9.1.custom.css" />
	
	<!-- aend -->
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta property="og:title" content="" />
	<meta property="og:description" content="" />
	<meta property="og:url" content="" />
	<meta property="og:type" content="article" />
	<meta property="og:site_name" content="" />

	<link rel="icon" type="image/png" sizes="32x32" href="../img/favicon.png">
	<link rel="stylesheet" href="./odshtml_css/homepage.css">

	<link rel="stylesheet" href="./assets/fonts/fontawesome-free-5.12.0-web/css/all.css" type="text/css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<link rel="stylesheet" href="./assets/lib/jquery-ui-1.12.1/jquery-ui.min.css" type="text/css" />
	<link rel="stylesheet" href="./assets/lib/jquery.jqGrid-4.4.3/css/ui.jqgrid.css" type="text/css" />
	<link rel="stylesheet" href="./assets/css/style.css" type="text/css" />
	<link rel="stylesheet" href="./assets/css/pop.css" type="text/css" />

	<script src="./assets/lib/cssua.min.js"></script>
	<script type="text/javascript" src="./ods_web_app/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" language="javascript" src="./ods_web_app/ods_html5.js"></script>
	<script src="./assets/lib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
	<script src="./assets/lib/jquery.jqGrid-4.4.3/js/jquery.jqGrid.min.js"></script>

	<!-- <script src="./assets/js/iitp.common.js"></script> -->
	<!-- <script src="./assets/js/ND.function.js"></script> -->
	
	<!--// include_once("_inc/head.html"); -->
	<!-- aend -->

	<title>전자계약시스템</title>
	<!-- <link href="./Images_login/css/login.css" rel="stylesheet"> -->

	<!--  <link href="./Images_login/css/login2.css" rel="stylesheet"> -->
	
	<!-- Main.jsp -->
	<link rel="stylesheet" href="./asset_ods/font-awesome/css/font-awesome.min.css">

	<script src="./asset_ods/js/jquery.min.js"></script>
	<script src="./asset_ods/js/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="./ods_web_app/jquery/redmond/jquery-ui-1.9.1.custom.css" />
	<script type="text/javascript" src="./ods_web_app/ods_external.js"></script>
	<script type="text/javascript" language="javascript" src="./ods_web_app/ods_html5.js"></script>
	<script type="text/javascript" language="javascript" src="./ods_web_app/ods_webapp_tab_custom.js"></script>

	<link rel="stylesheet" type="text/css" href="./odshtml_css/ods_serverpage_main.css"/>
	<!--<link rel="stylesheet" type="text/css" href="./odshtml_css/index.css">-->
	<link rel="stylesheet" href="./ImageServer/KO/ods_thema_2/opendraft_style_auto.css" type="text/css"  />

	<script language="Javascript" src="./opendraftx.js"></script>

    <script src="./pki/js/nxts/nxts.min.js"></script>
    <script src="./pki/js/nxts/nxtspki_config.js"></script>
    <script src="./pki/js/nxts/nxtspki.js"></script>
	<!-- Main.jsp -->
	
	
	
	
	
	
	<!--
	<link data-n-head="ssr" rel="icon" type="image/x-icon" href="/favicon.ico">
	<link data-n-head="ssr" rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900&amp;display=swap">
	<link data-n-head="ssr" rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@mdi/font@latest/css/materialdesignicons.min.css">
	
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/@mdi/font@5.x/css/materialdesignicons.min.css" rel="stylesheet">

	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue@2.6.0"></script>
	<script type="module">
	import Vue from 'https://cdn.jsdelivr.net/npm/vue@2.6.0/dist/vue.esm.browser.js'
	</script>


	<script type="text/javascript" src="./Images_login/js/jquery-1.11.1.min.js"></script>

	<script language="Javascript" src="./opendraftx.js"></script>
	-->
	<style type="text/css">
		#ods_screen_run_dialog_back{display:none; position:fixed; _position:absolute; top:0;left:0; z-index:996; background:#000; width:100%; height:100%; filter:Alpha(opacity=50); opacity:0.5; -moz-opacity:0.5;}
		#ods_screen_run_dialog.dlg_popup:after{width:90%;height:50px;display:block;content:"";position:absolute;top:0;left:0;z-index:9999;cursor:move;}
	</style>
	
	
	<script language="javascript">

        $(document).ready(function() {
			$("input").attr("autocomplete","off");

            $('#input_check1').on('change', function() {
                if ($(this).is(':checked')) {
                    $('#radio1').click();
                } else {
                    $('#radio4').click();
                }
            });
            
            $('#select4').on('change', function() {
                var lang = $(this).val();
                if ( lang == 'KO') {
                    /* $('#login_label').text('로그인'); */             $('#userid_label').text('사용자 계정');
                    $('#userpwd_label').text('비밀번호');               $('#chksave_label').text('사용자 아이디 저장');
                    /* $('#submit_label').text('로그인'); */            $('#pwdsearch_label').text('* 비밀번호를 잊으셨나요?');
                }
                else if (lang == 'EN') {
                    /* $('#login_label').text('Sign in'); */            $('#userid_label').text('User Name');
                    $('#userpwd_label').text('Password');               $('#chksave_label').text('Remember ID');
                    /* $('#submit_label').text('Sign in'); */           $('#pwdsearch_label').text('* Forgot your password? Get Password help.');
                }
                else if (lang == 'CH') {
                    /* $('#login_label').text('登入'); */               $('#userid_label').text('User Name');
                    $('#userpwd_label').text('Password');               $('#chksave_label').text('Remember ID');
                    /* $('#submit_label').text('Sign in'); */           $('#pwdsearch_label').text('* Forgot your password? Get Password help.');
                }
                else if (lang == 'JP') {
                    /* $('#login_label').text('ログイン'); */           $('#userid_label').text('User Name');
                    $('#userpwd_label').text('Password');               $('#chksave_label').text('Remember ID');
                    /* $('#submit_label').text('Sign in'); */           $('#pwdsearch_label').text('* Forgot your password? Get Password help.');
                }
            });
        });

		
		
		document.onkeydown = function(e){
			/* F5, Ctrl+r, Ctrl+F5 */
			if(e.keyCode == 116 || e.ctrlKey == true && (e.keyCode == 82)){
				e.cancelBubble = true;
				e.returnValue = false;
				ods_run_frame.location.reload();
				return false;
			}
		}
		
		// 상단 프레임 대화상자
		var Form = new Object();
		Form._server_type = "java";
		Form._dlg_mng = null;
		var Form_First = null;
		function UseFrameDlgMnanager() {
			return true;
		}
		
		function onLoad()
		{
			//=======================================
			// 상단 프레임 대화상자
			Form._dlg_mng = new OdsDialogManager();
			Form._dlg_mng.InitMainFrame();
			//--------------------------------------
			
			//MenuDisplay();

			var init_mode = "<%=_init_mode%>";
			if ( init_mode == "login" ) RunLogin("Person");
			else if ( init_mode == "loginPerson" ) RunLogin("Person");
			else if ( init_mode == "loginCust" ) RunLogin("Cust");
			else if ( init_mode == "loginCustCerti" ) RunLogin("CustCerti");
			else if ( init_mode == "cust_join" ) RunMenu("Main", "KCU120E", "", "", "");

			var LoginRsltMsg = "<%=g_LoginRsltMsg%>";
			var LoginCallCode = LoginRsltMsg.split("//")[0];
			LoginRsltMsg = LoginRsltMsg.split("//")[1];
			if ( LoginRsltMsg != "" && LoginRsltMsg != null && LoginRsltMsg != "null" )
			{
				RunLogin(LoginCallCode);
				//setTimeout( function(e){
			        alert(LoginRsltMsg);
				//},100 );
				//console.log("LoginRsltMsg");
				//console.log(LoginRsltMsg);
			}
		}
		
		function OpenChildMenu(  )
		{
			Common.Reset();
			$("[data-selector=gnbContainer]").addClass("_openMenu");
		}
		
		function MenuDisplay(  )
		{
			try{
				var Prefix = "result : ";
				var _form = {"dwname":"BAMenuAuth" // dw명
						   , "type":"Query" // Insert, Update, Delete, Query
						   , "method":"query_CallDW_UserMenu" // dw명
						   , "col_result":"result"
						   };
				var request = $.ajax({
					url: "./CallDWMethod.aspx", // http://
					type: "post", //call_type, // get, post
					//dataType: "text", // {name : "value"},
					data: _form,
					//timeout: timeout,
					//contentType: "text/json",
					//crossDomain: true,
					error: function(xhr, status, error) {
						//alert("통신 오류 : " + error );
					},
					success: function(data) {
						var MenuAuth_Arr = JSON.parse(data.substr(Prefix.length));
						for ( var i = 0 ; i < MenuAuth_Arr.length ; i++ )
						{
							if ( MenuAuth_Arr[i]["UseYN"] != "1" )
							{
								var MenuTag = document.getElementById(MenuAuth_Arr[i]["MenuID"]);
								MenuTag.style.display = "none";
							}
						}
					},
					done : function(data){
						//alert("ok :" + data );
					}
				});
			}				
			catch(e)
			{
				//console.log( "try_catch" );
				//console.log( e );
			}
		}

        var chk_dup_submit = 0;

        function LoginOpendraft( Type )
        {
			if ( Type == "Person" )
			{
				if (document.getElementById("uid").value == "") {
					alert("사용자 아이디을 입력해 주세요.");
					document.getElementById("uid").focus();
					return;
				}
				if (document.getElementById("pwd").value == "") {
					alert("비밀번호를 입력해 주세요.");
					document.getElementById("pwd").focus();
					return;
				}

				var param_uid = encodeURIComponent(document.getElementById("uid").value);
				var param_pwd = encodeURIComponent(document.getElementById("pwd").value);
				var chk_save = "";
				if( document.getElementById("chk_save").checked )
					chk_save = "on";

				var path = location.pathname.substr(1);
				path = path.substr(0, path.indexOf("/"));
				var url = location.origin+"/"+path+"/index_check.jsp?user_id="+param_uid+"&pwd="+param_pwd+"&chk_save="+chk_save+"&call_type="+Type;

				document.location.href = url;
			}
			else if ( Type == "Cust" )
			{
				if (document.getElementById("BizRegNo2_1").value == "") {
					alert("사업자등록번호를 입력해 주세요.");
					document.getElementById("BizRegNo2_1").focus();
					return;
				}
				if (document.getElementById("BizRegNo2_2").value == "") {
					alert("사업자등록번호를 입력해 주세요.");
					document.getElementById("BizRegNo2_2").focus();
					return;
				}
				if (document.getElementById("BizRegNo2_3").value == "") {
					alert("사업자등록번호를 입력해 주세요.");
					document.getElementById("BizRegNo2_3").focus();
					return;
				}
				if (document.getElementById("uid2").value == "") {
					alert("사용자 아이디을 입력해 주세요.");
					document.getElementById("uid2").focus();
					return;
				}
				if (document.getElementById("pwd2").value == "") {
					alert("비밀번호를 입력해 주세요.");
					document.getElementById("pwd2").focus();
					return;
				}

				var param_uid = encodeURIComponent(document.getElementById("uid2").value);
				var param_pwd = encodeURIComponent(document.getElementById("pwd2").value);
				var BizRegNo = document.getElementById("BizRegNo2_1").value+document.getElementById("BizRegNo2_2").value+document.getElementById("BizRegNo2_3").value;
				var chk_save = "";
				if( document.getElementById("chk_save2").checked )
					chk_save = "on";
				
				var path = location.pathname.substr(1);
				path = path.substr(0, path.indexOf("/"));
				var url = location.origin+"/"+path+"/index_check.jsp?user_id="+param_uid+"&pwd="+param_pwd+"&biz_reg_no="+BizRegNo+"&chk_save="+chk_save+"&call_type="+Type;
				
				document.location.href = url;
			}
			else if ( Type == "CustCerti" )
			{
				if (document.getElementById("BizRegNo3_1").value == "") {
					alert("사업자등록번호를 입력해 주세요.");
					document.getElementById("BizRegNo3_1").focus();
					return;
				}
				if (document.getElementById("BizRegNo3_2").value == "") {
					alert("사업자등록번호를 입력해 주세요.");
					document.getElementById("BizRegNo3_2").focus();
					return;
				}
				if (document.getElementById("BizRegNo3_3").value == "") {
					alert("사업자등록번호를 입력해 주세요.");
					document.getElementById("BizRegNo3_3").focus();
					return;
				}
				if (document.getElementById("uid3").value == "") {
					alert("사용자 아이디을 입력해 주세요.");
					document.getElementById("uid3").focus();
					return;
				}
				var BizRegNo = document.getElementById("BizRegNo3_1").value+document.getElementById("BizRegNo3_2").value+document.getElementById("BizRegNo3_3").value;
				var options = {};
				options.ssn = BizRegNo.replace(/-/gi, "");
				nxTSPKI.signData(BizRegNo, options, PKI_CallBack_JSP);
			}
        }
		
		function PKI_CallBack_JSP( RsltData )
		{
			if ( RsltData.code == 0 )
			{
				var param_uid = document.getElementById("uid3").value;
				var SerialNumberDec = RsltData.data.certInfo.serialNumberDec;
				var SubjectKeyID = RsltData.data.certInfo.subjectKeyID;
				var BizRegNo = document.getElementById("BizRegNo3_1").value+document.getElementById("BizRegNo3_2").value+document.getElementById("BizRegNo3_3").value;
				var path = location.pathname.substr(1);
				path = path.substr(0, path.indexOf("/"));
				var url = location.origin+"/"+path+"/index_check.jsp?user_id="+param_uid+"&pwd="+param_uid+"&biz_reg_no="+BizRegNo+"&SerialNumberDec="+SerialNumberDec+"&SubjectKeyID="+SubjectKeyID+"&chk_save=0&call_type=CustCerti";
				document.location.href = url;
			}
			else
			{
				alert(RsltData.errorMessage);
			}
		}

        function CloseOdsBrowser() {
            setTimeout( function(){
				if (navigator.appVersion.indexOf("MSIE 6.0") == 0) {
					window.opener = self;
					self.close();

				}
				else {
					window.open('about:blank', '_self').close();

				}
			}
			, 5000);
            

        }
        
		var g_CurLoginPageTp = "";
		function RunLogin( Type ) {
			TopMenuOut();

			if ( Type == "RunMenu" )
			{
				if ( g_CurLoginPageTp != "" ) Type = g_CurLoginPageTp;
				else Type = "Person";
			}
			if ( g_CurLoginPageTp == Type ) return;
			g_CurLoginPageTp = Type;

			document.getElementById("ImgLoginPerson").style.backgroundColor = "";
			document.getElementById("ImgLoginCust").style.backgroundColor = "";
			document.getElementById("ImgLoginCustCerti").style.backgroundColor = "";

			document.getElementById("textPerson").style.color = "#888989";
			document.getElementById("textCust").style.color = "#888989";
			document.getElementById("textCustCerti").style.color = "#888989";

			document.getElementById("textPerson").style.fontWeight  = "normal";
			document.getElementById("textCust").style.fontWeight = "normal";
			document.getElementById("textCustCerti").style.fontWeight  = "normal";


			document.getElementById("ImgLoginPerson").style.border = "1px solid lightgray";
			document.getElementById("ImgLoginCust").style.border = "1px solid lightgray";
			document.getElementById("ImgLoginCustCerti").style.border = "1px solid lightgray";

			//document.getElementById("BTN_LoginPerson").style.backgroundColor = "";
			//document.getElementById("BTN_LoginCust").style.backgroundColor = "";
			//document.getElementById("BTN_LoginCustCerti").style.backgroundColor = "";

			document.getElementById("ImgLogin"+Type).style.backgroundColor = "#f3f8ff";
			//document.getElementById("BTN_Login"+Type).style.backgroundColor = "lightgray";

			document.getElementById("text"+Type).style.color = "#004098";
			document.getElementById("text"+Type).style.fontWeight = "bold";

			document.getElementById("ImgLogin"+Type).style.color = "#004098";
			document.getElementById("ImgLogin"+Type).style.border = "1px solid #004098";

			// document.getElementById("Persontext").style.color = "#004098";
			

			var content_div = document.getElementById("content");
			content_div.style.display = "";
			
			var content2_div = document.getElementById("content2");
			content2_div.style.display = "none";
			
			var content_main_div = document.getElementById("container_main");
			content_main_div.style.display = "none";
			
			if ( Type == "Person" )
			{
				document.getElementById("LoginFieldPerson").style.display = "";
				document.getElementById("LoginFieldCust").style.display = "none";
				document.getElementById("LoginFieldCustCerti").style.display = "none";

				document.getElementById("uid").value = "<%=g_user_id%>";
				document.getElementById("pwd").value = "";
				document.getElementById("chk_save").checked = "<%=g_check_save%>";
				
				if ( document.getElementById("uid").value == "" )
				{
					document.getElementById("uid").focus();
				}
				else
				{
					document.getElementById("pwd").focus();
				}
			}
			else if ( Type == "Cust" )
			{
				document.getElementById("LoginFieldPerson").style.display = "none";
				document.getElementById("LoginFieldCust").style.display = "";
				document.getElementById("LoginFieldCustCerti").style.display = "none";

				document.getElementById("BizRegNo2_1").value = "";
				document.getElementById("BizRegNo2_2").value = "";
				document.getElementById("BizRegNo2_3").value = "";
				document.getElementById("uid2").value = "<%=g_user_id%>";
				document.getElementById("pwd2").value = "";
				document.getElementById("chk_save2").checked = "<%=g_check_save%>";
				
				document.getElementById("BizRegNo2_1").focus();
			}
			else if ( Type == "CustCerti" )
			{
				document.getElementById("LoginFieldPerson").style.display = "none";
				document.getElementById("LoginFieldCust").style.display = "none";
				document.getElementById("LoginFieldCustCerti").style.display = "";
				
				document.getElementById("BizRegNo3_1").value = "";
				document.getElementById("BizRegNo3_2").value = "";
				document.getElementById("BizRegNo3_3").value = "";
				document.getElementById("uid3").value = "<%=g_user_id%>";
				document.getElementById("chk_save3").checked = "<%=g_check_save%>";

				document.getElementById("BizRegNo3_1").focus();
			}
		}
		function RunContent2(  ) {
			
			//document.getElementById("uid").value = "";
			//document.getElementById("pwd").value = "";
			
			var content2_div = document.getElementById("content2");
			content2_div.style.display = "";
			
			var content_div = document.getElementById("content");
			content_div.style.display = "none";
			
			var content_main_div = document.getElementById("container_main");
			content_main_div.style.display = "none";
		}
		//ods 메뉴 실행            
		//function RunMenu( run_type, menu_id, param ) {
		function RunMenu(Type, MenuID, TopMenu, Label, Param) {
			g_CurLoginPageTp = "";

			//document.getElementById("uid").value = "";
			//document.getElementById("pwd").value = "";
			if ( Param == undefined || Param == null ) Param = "";
			
			var content_main_div = document.getElementById("container_main");
			content_main_div.style.display = "";
			
			var content_div = document.getElementById("content");
			content_div.style.display = "none";
			
			var content2_div = document.getElementById("content2");
			content2_div.style.display = "none";
			
			$("#ods_run_frame").attr("src", "./ODS_ServerPage_Run.jsp?ods_sid=annony_user&menu_code="+MenuID+Param);
			var main_frame = document.getElementById("ods_run_frame");
			main_frame.style.height = "800px";
			
			/*
			//프로그램 실행
			//$("#ods_run_frame").attr("src", "./ODS_ServerPage_Run.jsp?ods_sid=annony_user&menu_code="+menu_id);
			document.location = "./ODS_ServerPage_Run.jsp?ods_sid=annony_user&menu_code="+menu_id;

			//마이페이지일 경우 좌측 메뉴 보이도록
			if( run_type == "main" ) {
				$("#ods_iframe").css("width", "100%");
				$("#mypage_menu").css("display", "none");
			} else if( run_type == "mypage" ) {
				$("#mypage_menu").css("display", "");
				$("#ods_iframe").css("width", "800px");
			}
			*/
			Common.Reset();

			window.scrollTo(0, 0);
			TopMenuOut();
		}

		function TopMenuOver(  )
		{
			var TopMenu = document.getElementById("TopMenu");
			TopMenu.className = "TopMenu OpenTopMenu";
		}

		function TopMenuOut(  )
		{
			var TopMenu = document.getElementById("TopMenu");
			TopMenu.className = "TopMenu";
		}

		function NextFocus( TagID, KeyCode )
		{
			if ( (KeyCode >= 48 && KeyCode <= 57) || (KeyCode >= 96 && KeyCode <= 105) )
			{
				var Input_Tag = document.getElementById(TagID);
				var MaxLength = Input_Tag.getAttribute("maxlength");
				if ( Input_Tag.value.length >= MaxLength )
				{
					if ( TagID == "BizRegNo2_1" ) document.getElementById("BizRegNo2_2").focus();
					if ( TagID == "BizRegNo2_2" ) document.getElementById("BizRegNo2_3").focus();
					if ( TagID == "BizRegNo3_1" ) document.getElementById("BizRegNo3_2").focus();
					if ( TagID == "BizRegNo3_2" ) document.getElementById("BizRegNo3_3").focus();
				}
			}
		}
			
    </script>



		<script type="text/javascript">


            if ((navigator.userAgent.indexOf('iPhone') != -1) ||
                (navigator.userAgent.indexOf('iPod') != -1) ||
                (navigator.userAgent.indexOf('iPad') != -1)
	        ) {
                //document.location = "index_mobile.jsp";
            }
            else if (navigator.userAgent.indexOf('Android') != -1) {
                //document.location = "index_mobile.jsp";
            }
            else if (navigator.userAgent.indexOf('webOS') != -1) {
                //document.location = "index_mobile.jsp";
            }
            else if (navigator.userAgent.indexOf('BlackBerry') != -1) {
                //document.location = "index_mobile.jsp";
            }
            else if (navigator.userAgent.indexOf('Windows') != -1) {
                //document.location = "index_mobile.jsp";
            }
            else
            {
                //alert(navigator.userAgent + "기기를 알 수 없습니다. 관리자에게 이 메시지를 보내 주세요.");
            }

            
    </script>




		<% out.write(opendraft_auto_logoin_script); %>

	
 

</head>

<body onload="javascript:onLoad();">
	<div id="wrap" class="page-login">

		<!-- skipNavi -->
		<ul id="skipNavi">
			<li><a href="#container">본문바로가기</a></li>
		</ul>
		<!-- //skipNavi -->
		<!---------- header------------->
		<header id="header">
			<!-- include_once("_inc/header.html"); -->
			<div class="nav-top flex ">
				<div class="col-left">
					<!-- <h1 id="logo"><a href="javascript:RunContent2()" class="logo-img"><img src="./img/logo.png" alt="markany"/></a></h1> -->
					<h1 id="logo"><a href="./index.jsp" class="logo-img"><img src="./img/logo.png" alt="markany"/></a></h1>
				</div>
				<div class="col-right">
					<!-- <strong class="item name">님 로그인!</strong> -->
					<nav>
						<a href="javascript:RunMenu('Main', 'KCV000E', '', '', '')" class="item">계약서 위변조 검증</a>
						<a href="javascript:RunLogin('Person')" class="item">로그인</a>
						<a href="javascript:RunMenu('Main', 'KCU100E', '', '', '') " class="item">회원가입</a>
					</nav>
				</div>
			</div>
			<div class="gnb-container" data-selector="gnbContainer">
				<div class="head_bottom">
					<div class="head_bottom_in">
						<!--<div class="TopMenu" id="TopMenu" onmouseenter="javascript:TopMenuOver();" onmouseleave="javascript:TopMenuOut();">-->
						<div class="TopMenu" id="TopMenu" onmouseleave="javascript:TopMenuOut();">
							<ul>
								<!-- <li id="MENUP100">
									<a href="javascript:RunMenu('Main', 'INT100E', '', '', '')" class="nav-item" data-action="depth1">서비스 소개</a>
									<ul class="row-depth">
										<li><a href="javascript:RunMenu('Main', 'INT100E', '', '', '')" id="INT100E" class="row-item">인사말</a></li>
									</ul>
								</li> -->
								<%=_MenuHtml%>
							</ul>
						</div>
					</div><!-- //head_bottom_in -->
				</div><!--// head_bottom -->
			</div>
			<!--// include_once("_inc/header.html"); -->
		</header>
		<!---------- container------------->
		<div id="container">
			
			<div id="content" style="display:none;">
				<div class="m-main">

					<header class="page-header" style="height:200px;">
						<h2 class="page-tit t2">로그인</h2>
						<p class="page-dec">전자계약 시스템을 이용하실려면 반드시 회원 로그인을 하셔야 합니다.</p>
					</header>
					
					<div style="height: 220px;">
						<div id="ImgLoginPerson" style="color: #888989; position:absolute; width:184px; height:237px; left:470px; background: url(./img/login_1.png) no-repeat center #eee; cursor: pointer; background-size: 70px;background-position: center 35px;border: 1px solid lightgrey;background-color: white;" onclick="RunLogin('Person')">
							<div id="textPerson" style="text-align: center; margin-top: 150px; font-size: 17px;  ">개인 회원</br>로그인</div>
						</div>
						<div id="ImgLoginCust" style="position:absolute; width:184px; height:237px; left:720px; background: url(./img/login_2.png) no-repeat center #eee; cursor: pointer; background-size: 70px;background-position: center 50px; border: 1px solid lightgrey;background-color: white;" onclick="RunLogin('Cust')">
							<div id="textCust" style="text-align: center; margin-top: 150px; font-size: 17px;">기업 회원</br>로그인</div>
						</div>
						<div id="ImgLoginCustCerti" style="position:absolute; width:184px; height:237px; left:970px; background: url(./img/login_3.png) no-repeat center #eee;cursor: pointer; background-size: 70px;background-position: center 50px; border: 1px solid lightgrey;background-color: white;" onclick="RunLogin('CustCerti')">
							<div id="textCustCerti" style="text-align: center; margin-top: 150px; font-size: 17px; ">기업 회원</br>로그인(인증서)</div>
						</div>
						<!-- <div id="inst_LoginPerson" style="position:absolute; display:none; left:465px; top:370px; width:170px; height:38px;">
							<button id="BTN_LoginPerson" style="width:100%; height:100%; cursor: pointer; background-color: #ffffff; border: 1px solid #004098; border-radius: 6px; color: #004098; font-size: 16px; font-weight: bold;" alt="개인 회원 로그인" title="개인 회원 로그인" onclick="RunLogin('Person')">개인 회원 로그인</button>
						</div>
						<div id="inst_LoginCust" style="position:absolute; display:none; left:725px; top:370px; width:170px; height:38px;">
							<button id="BTN_LoginCust" style="width:100%; height:100%; cursor: pointer; background-color: #ffffff; border: 1px solid #004098; border-radius: 6px; color: #004098; font-size: 16px; font-weight: bold;" alt="기업 회원 로그인" title="기업 회원 로그인" onclick="RunLogin('Cust')">기업 회원 로그인</button>
						</div>
						<div id="inst_LoginCustCerti" style="position:absolute; display:none; left:960px; top:370px; width:200px; height:38px;">
							<button id="BTN_LoginCustCerti" style="width:100%; height:100%; cursor: pointer; background-color: #ffffff; border: 1px solid #004098; border-radius: 6px; color: #004098; font-size: 16px; font-weight: bold;" alt="기업 회원 로그인(인증서)" title="기업 회원 로그인(인증서)" onclick="RunLogin('CustCerti')">기업 회원 로그인(인증서)</button> -->
						</div>
					</div>

					<div class="login-container">
						<!--<div id="user_info" name="user_info" runat="server" method="post">-->
						
						<!-- <form id="user_info" name="user_info" runat="server" method="post" > -->
						<!-- <fieldset> -->
							<div id="LoginFieldPerson">
								<input type="radio" name="run_type" id="radio4" value="web" checked="checked" style="display:none;"/>
								<label style="color:white; display:none;" for="input_check1" style="position:relative; left: 15px"> for developer</label><span class="input_check"><input type="checkbox" id="input_check1" style="display:none;"></span>
								<div class="form-wrap flex">
									<div class="col-left">
										<dl class="flex">
											<dt>아이디</dt>
											<input type=hidden maxlength=20 name="chk_login" id="Hidden1" value="" style="display:none;" />
											<dd><input type="text" name="uid" value="<%=g_user_id%>" required="required" class="input_txt1"  id="uid"/></dd>
										</dl>
										<dl class="flex">
											<dt>비밀번호</dt>
											<dd><input type="password" name="pwd" required="required"  value="" class="input_pw1"  id="pwd" onkeyPress="if (event.keyCode==13){javascript:LoginOpendraft('Person');}"/></dd>
										</dl>
									</div>
									<div class="col-right">
										<button type="submit" value="Sign In" onclick="javascript:LoginOpendraft('Person')" class="btn b1 btn-login v-btn v-btn--contained theme--light v-size--default success BtnLogin loginBtn">로그인</button>
									</div>
								</div>
								<div class="btt-flex flex">
									<div class="col-left">
										<label class="chk-label check">
											<input type="checkbox" name="chk_save" id="chk_save" <%=g_check_save%>> 
											<span class="txt">아이디저장</span>
										</label>
									</div>
									<div class="col-right">
										<a href="javascript:RunMenu('Main', 'KCU130E', '', '', '')" class="item">아이디찾기</a> /
										<a href="javascript:RunMenu('Main', 'KCU132E', '', '', '')" class="item">비밀번호 찾기</a>
									</div>
									<select name="ulang" class="" id="select4" style="display:none;">
										<option <%=g_lang_ko_check%> value="KO">Korean</option>
										<option <%=g_lang_ch_check%> value="CH">中文</option>
										<option <%=g_lang_en_check%> value="EN">English</option>
										<option <%=g_lang_jp_check%> value="JP">日本語</option>
									</select>
								</div>
							</div>
						<!-- </fieldset> -->
						<!-- </form> -->
						<!-- <form> -->
						<!-- <fieldset> -->
							<div id="LoginFieldCust" style="display:none;">
								<div class="form-wrap flex">
									<div class="col-left">
										<dl class="flex">
											<dt>사업자등록번호</dt>
											<input type="text" name="BizRegNo2_1" value="" required="required" class="input_txt1"  id="BizRegNo2_1" style="width:Calc((100% - 110px - 30px) / 100 * 35)" maxlength="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeyup="javascript:NextFocus('BizRegNo2_1', event.keyCode)"/>
											<label style="width:15px; text-align: center;">-</label>
											<input type="text" name="BizRegNo2_2" value="" required="required" class="input_txt1"  id="BizRegNo2_2" style="width:Calc((100% - 110px - 30px) / 100 * 25)" maxlength="2" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeyup="javascript:NextFocus('BizRegNo2_2', event.keyCode)"/>
											<label style="width:15px; text-align: center;">-</label>
											<input type="text" name="BizRegNo2_3" value="" required="required" class="input_txt1"  id="BizRegNo2_3" style="width:Calc((100% - 110px - 30px) / 100 * 40)" maxlength="5" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
										</dl>
										<dl class="flex">
											<dt>아이디</dt>
											<dd><input type="text" name="uid" value="<%=g_user_id%>" required="required" class="input_txt1"  id="uid2"/></dd>
										</dl>
										<dl class="flex">
											<dt>비밀번호</dt>
											<dd><input type="password" name="pwd" required="required"  value="" class="input_pw1"  id="pwd2" onkeyPress="if (event.keyCode==13){javascript:LoginOpendraft('Cust');}"/></dd>
										</dl>
									</div>
									<div class="col-right">
										<button type="submit" value="Sign In" onclick="javascript:LoginOpendraft('Cust')" class="btn b1 btn-login v-btn v-btn--contained theme--light v-size--default success BtnLogin loginBtn">로그인</button>
									</div>
								</div>
								<div class="btt-flex flex">
									<div class="col-left">
										<label class="chk-label check">
											<input type="checkbox" name="chk_save" id="chk_save2" <%=g_check_save%>> 
											<span class="txt">아이디저장</span>
										</label>
									</div>
									<div class="col-right">
										<a href="javascript:RunMenu('Main', 'KCU134E', '', '', '')" class="item">아이디찾기</a> /
										<a href="javascript:RunMenu('Main', 'KCU135E', '', '', '')" class="item">비밀번호 찾기</a>
									</div>
								</div>
							</div>
						<!-- </fieldset> -->
						<!-- </form> -->
						<!-- <form> -->
						<!-- <fieldset> -->
							<div id="LoginFieldCustCerti" style="display:none;">
								<div class="form-wrap flex">
									<div class="col-left">
										<dl class="flex">
											<dt>사업자등록번호</dt>
											<input type="text" name="BizRegNo3_1" value="" required="required" class="input_txt1"  id="BizRegNo3_1" style="width:Calc((100% - 110px - 30px) / 100 * 35)" maxlength="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeyup="javascript:NextFocus('BizRegNo3_1', event.keyCode)"/>
											<label style="width:15px; text-align: center;">-</label>
											<input type="text" name="BizRegNo3_2" value="" required="required" class="input_txt1"  id="BizRegNo3_2" style="width:Calc((100% - 110px - 30px) / 100 * 25)" maxlength="2" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeyup="javascript:NextFocus('BizRegNo3_2', event.keyCode)"/>
											<label style="width:15px; text-align: center;">-</label>
											<input type="text" name="BizRegNo3_3" value="" required="required" class="input_txt1"  id="BizRegNo3_3" style="width:Calc((100% - 110px - 30px) / 100 * 40)" maxlength="5" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
										</dl>
										<dl class="flex">
											<dt>아이디</dt>
											<dd><input type="text" name="uid" value="<%=g_user_id%>" required="required" class="input_txt1"  id="uid3"/></dd>
										</dl>
									</div>
									<div class="col-right">
										<button type="submit" value="Sign In" onclick="javascript:LoginOpendraft('CustCerti')" class="btn b1 btn-login v-btn v-btn--contained theme--light v-size--default success BtnLogin loginBtn">인증서</button>
									</div>
								</div>
								<div class="btt-flex flex" style="display: none;">
									<div class="col-left">
										<label class="chk-label check">
											<input type="checkbox" name="chk_save" id="chk_save3" <%=g_check_save%>> 
											<span class="txt">아이디저장</span>
										</label>
									</div>
									<div class="col-right">
										<a href="javascript:RunMenu('Main', 'KCU136E', '', '', '')" class="item">아이디찾기</a> /
										<a href="javascript:RunMenu('Main', 'KCU137E', '', '', '')" class="item">비밀번호 찾기</a>
									</div>
								</div>
							</div>
						<!-- </fieldset> -->
						<!-- </form> -->
						
					</div>

					<div class="login-btt">
						<span class="dec">아직 회원이 아니신가요?</span>
						<a href="javascript:RunMenu('Main', 'KCU100E', '', '', '')" target="_self" class="item under"><회원가입></a>
					</div>
				</div>
			</div>
			
			<!-- ODS -->
			<div id="container_main" style="display:none; width: 1200px; margin: 0 auto;">
				<iframe id="ods_run_frame" style="z-index: 100; background: white; width:100%; height:700px;">
					이 브라우저는 iframe을 지원하지 않습니다.
				</iframe>
			</div>
			<!-- //ODS -->
		</div><!--container-->
		
		
		<div id="wrap" class="page-main">
			<div id="content2">
				<div class="kv-container">
					<div class="img-box" style="background-image:url(./img/sign_01.jpg)">
						<div class="dec-wrap">
							<strong class="tit">간편하게 누구든지 손쉽게</strong>
							<p class="dec">
								종이 계약서가 없어지거나 훼손된 적이 있었나요? <br />계약이 필요한 순간 바로 활용할 수 있습니다.
							</p>
						</div>
					</div>
				</div>
				<section class="sec s1">
					
					<div class="m-main">
						<div class="col-flex flex">
							<div class="col-left">
								<strong class="tit">5분만에 <br />끝내는 계약업무</strong>
							</div>
							<div class="col-right">
								<ul class="process-flex flex">
									<li>
										<div class="img-box" style="background-image:url(./img/contract_process_01.png)"></div>
										<p class="dec">문서업로드</p>
									</li>
									<li>
										<div class="img-box" style="background-image:url(./img/contract_process_02.png)"></div>
										<p class="dec">서명요청</p>
									</li>
									<li>
										<div class="img-box" style="background-image:url(./img/contract_process_03.png)"></div>
										<p class="dec">서명입력</p>
									</li>
									<li>
										<div class="img-box" style="background-image:url(./img/contract_process_04.png)"></div>
										<p class="dec">완료</p>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</section>
				
				<section class="sec s2">
					<figure>
						<img src="./img/sign_02.jpg" alt="" />
					</figure>
					<div class="dec-wrap">
						<div class="m-main">
							<strong class="tit">
								계약서 파일을 직접 업로드하여 서명을 요청하면 계약이 완료됩니다.
							</strong>
							<p class="dec">
								계약자는 등록된 서명으로 손쉽게 계약을 할 수 있습니다. <br />
								계약자가 허가한 제3자에게 영지식 증명방법으로 계약성립을 입증할 수 있습니다. <br />
								계약서와 계약자의 서명은 블록체인으로 모두 안전하게 저장되며 위조되지 않습니다.
							</p>
							<div class="btn-wrap">
								<a href="javascript:RunMenu('Main', 'INT100E', '', '', '')" class="btn blue-line">서비스 소개 바로가기</a>
							</div>
						</div>
					</div>
				</section>
				
				<section class="sec s3">
					<div class="m-main">
						<div class="col-flex flex">
							<div class="col-left">
								<img src="./img/sign_04.png" alt="" />
							</div>
							<div class="col-right">
								<strong class="tit">
									사용하던 서명 그대로 <br />
									<span class="c1">간편한 서명 입력</span>
								</strong>
								<div class="dl-container">
									<dl class="flex">
										<dt>
											<img src="./img/main_ico1.png" alt="" />
										</dt>
										<dd>
											<strong class="tit">사용하던 서명 이미지 사용하기</strong>
											<p class="dec">
												사용하는 도장을 서명으로 등록할 수 있습니다. <br />
												여러 개의 서명으로 용도에 맞게 관리할 수 있습니다.
											</p>
										</dd>
									</dl>
									<dl class="flex">
										<dt>
											<img src="./img/main_ico2.png" alt="" />
										</dt>
										<dd>
											<strong class="tit">내 서명 바로 만들어 사용하기</strong>
											<p class="dec">
												업로드할 서명 이미지가 없다면, 손으로 직접 그려서 서명으로 <Br />
												사용할 수 있습니다. 지금 바로 해보세요~
											</p>
										</dd>
									</dl>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
		
		
		<!-- 푸터 영역-------------------------------------------------------------------------------------------------------------->
		<div class="footer noindex">
			<div class="foot_in">
				<img src="./img/footer_logo.jpg" style="width: 10%; float: left; padding: 24px; box-sizing:content-box;" alt="">
				<div class="foot_con">

					<div class="foot_m">
						<ul>
							<!-- <li><a href="javascript:void(0)">고객서비스헌장</a></li>
							<li><a href="javascript:void(0)">고객의소리</a></li>
							<li><a href="javascript:void(0)">이용약관</a></li>
							<li><a href="javascript:void(0)">공고</a></li>
							<li><a href="javascript:void(0)"><span style="color:#3E93CC;">개인정보처리방침</span></a></li> -->
						</ul>
					</div>
					<address style="line-height: initial;">
					한국무역정보통신, KTNET
					13493) 경기도 성남시 분당구 판교로 338 (판교테크노밸리) 한국전자무역센터
					</address>
					<p class="copy" style="line-height: initial;">Copyright 2013 KTNET All Rights Reserved.</p>
				</div>

				<div class="foot_sel">
					<div class="sel_list" style="top: -261px;">
						<ul>
							<li><a href="http://www.opendraft.net/help" target="_blank">Help</a></li>
							<li><a href="http://dev.opendraft.net/ods_demo" target="_blank">Demo</a></li>
						</ul>
					</div>
				</div>
			</div><!--// foot_in -->
		</div><!--// footer -->
	</div>
</body>


</html>