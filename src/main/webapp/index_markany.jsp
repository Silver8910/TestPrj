<%@page import="opendraft.service.gate_web.jsp_index_impl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<%


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
this_impl._init_redirect_page = "ODS_ServerPage_Main_User.jsp";


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

	<link rel="icon" type="image/png" sizes="32x32" href="../img//favicon.png">

	<link rel="stylesheet" href="./assets/fonts/fontawesome-free-5.12.0-web/css/all.css" type="text/css" />
	<link rel="stylesheet" href="./assets/lib/jquery-ui-1.12.1/jquery-ui.min.css" type="text/css" />
	<link rel="stylesheet" href="./assets/lib/jquery.jqGrid-4.4.3/css/ui.jqgrid.css" type="text/css" />
	<link rel="stylesheet" href="./assets/css/style.css" type="text/css" />
	<link rel="stylesheet" href="./assets/css/pop.css" type="text/css" />

	<script src="./assets/lib/cssua.min.js"></script>
	<!-- <script src="./assets/lib/jquery-1.8.2.min.js"></script> -->
	<script type="text/javascript" src="./ods_web_app/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" language="javascript" src="./ods_web_app/ods_html5.js"></script>
	<script src="./assets/lib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
	<script src="./assets/lib/jquery.jqGrid-4.4.3/js/jquery.jqGrid.min.js"></script>
	<!--[if lt IE 9]><script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script><![endif]-->
	<!--[if lt IE 9]><script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script><![endif]-->

	<script src="./assets/js/iitp.common.js"></script>
	<script src="./assets/js/ND.function.js"></script>
	
	<!--// include_once("_inc/head.html"); -->
	<!-- aend -->

	<title>전자계약서비스</title>
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
			
			MenuDisplay();
			var LoginRsltMsg = "<%=g_LoginRsltMsg%>";
			if ( LoginRsltMsg != "" && LoginRsltMsg != null && LoginRsltMsg != "null" )
			{
				RunLogin();
				//setTimeout( function(e){
			        alert(LoginRsltMsg);
				//},100 );
				console.log("LoginRsltMsg");
				console.log(LoginRsltMsg);
			}
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

        function LoginOpendraft()
        {
			//if (document.user_info.run_type.value == "") {
			//    alert("실행 타입을 선택해 주세요.");
			//    return;
			//}
			
			if (document.getElementById("uid").value == "") {
				alert("사용자 계정을 입력해 주세요.");
				document.getElementById("uid").focus();
				return;
			}

			if (document.getElementById("pwd").value == "") {
				alert("비밀번호를 입력해 주세요.");
				document.getElementById("pwd").focus();
				return;
			}

			//if (document.user_info.ulang.value == "") {
			//	alert("언어를 선택해 주세요.");
			//	return;
			//}
			
			
			try {
                document.odsx.OdsXSetData("userid", document.user_info.uid.value);
                document.odsx.OdsXSetData("password", document.user_info.pwd.value);
                document.odsx.OdsXSetData("lang_id", document.user_info.ulang.value);
            }
            catch (exp) {
                
            }

            document.user_info.chk_login.value = "ok";
            document.user_info.submit();

			return;

        }


        function CloseOdsBrowser() {
            			setTimeout( function(){
            if (navigator.appVersion.indexOf("MSIE 6.0") == 0) {
                window.opener = self;
                self.close();

            }
            else {
                window.open('about:blank', '_self').close();

//window.open(location, '_self').close();
//window.close();


            }
			}
			, 5000);
            

        }
        
		function RunLogin(  ) {
			
			document.getElementById("uid").value = "<%=g_user_id%>";
			document.getElementById("pwd").value = "";
			document.getElementById("chk_save").checked = "<%=g_check_save%>";
			
			var content_div = document.getElementById("content");
			content_div.style.display = "";
			
			var content2_div = document.getElementById("content2");
			content2_div.style.display = "none";
			
			var content_main_div = document.getElementById("container_main");
			content_main_div.style.display = "none";
			
			if ( document.getElementById("uid").value == "" )
			{
				document.getElementById("uid").focus();
			}
			else
			{
				document.getElementById("pwd").focus();
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
		function RunMenu( run_type, menu_id ) {
			
			//document.getElementById("uid").value = "";
			//document.getElementById("pwd").value = "";
			
			var content_main_div = document.getElementById("container_main");
			content_main_div.style.display = "";
			
			var content_div = document.getElementById("content");
			content_div.style.display = "none";
			
			var content2_div = document.getElementById("content2");
			content2_div.style.display = "none";
			
			$("#ods_run_frame").attr("src", "./ODS_ServerPage_Run.jsp?ods_sid=annony_user&menu_code="+menu_id);
			
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
					<h1 id="logo"><a href="javascript:RunContent2()" class="logo-img"><img src="./img/logo.png" alt="markany"/></a></h1>
				</div>
				<div class="col-right">
					<!-- <strong class="item name">님 로그인!</strong> -->
					<nav>
						<a href="javascript:RunLogin()" class="item">로그인</a>
						<a href="javascript:RunLogin()" class="item">Mypage</a>
						<a href="javascript:RunMenu('main', 'BAN140E')" class="item">이용안내</a>
						<a href="javascript:void()" class="item">FAQ</a>
						<a href="javascript:RunMenu('main', 'BAN100E')" class="item">공지사항</a>
						<!-- <a href="" class="item btn cancel">로그아웃</a> -->
					</nav>
				</div>
			</div>
			<div class="gnb-container" data-selector="gnbContainer">
				<div class="m-main">
					<ul class="main-nav flex">
						<li id="MENUP100">
							<a href="javascript:RunMenu('main', 'INT100E')" class="nav-item" data-action="depth1">서비스 소개</a>
							<ul class="row-depth">
								<li><a href="javascript:RunMenu('main', 'INT100E')" id="INT100E" class="row-item">인사말</a></li>
							</ul>
						</li>
						<li id="MENUP200">
							<a href="javascript:RunMenu('main', 'ECD300E')" class="nav-item" data-action="depth1">전자계약효력</a>
							<ul class="row-depth">
								<li><a href="javascript:RunMenu('main', 'ECD300E')" id="ECD300E" class="row-item">본인확인</a></li>
								<li><a href="javascript:RunMenu('main', 'ECD300Q')" class="row-item" id="ECD300Q">인증서류 DownLoad</a></li>
							</ul>
						</li>
						<li id="MENUP300">
							<a href="javascript:void()" class="nav-item" data-action="depth1">계약서</a>
							<ul class="row-depth">
								<li><a href="javascript:RunLogin()" id="ECD100E" class="row-item" >비서식계약서</a></li>
							</ul>
						</li>
						<li id="MENUP400">
							<a href="javascript:RunMenu('main', 'ECD320E')" class="nav-item" data-action="depth1">이용혜택</a>
							<ul class="row-depth">
								<li><a href="javascript:RunMenu('main', 'ECD320E')" id="ECD320E" class="row-item">계약서 DownLoad</a></li>
							</ul>
						</li>
						<li id="MENUP500">
							<a href="javascript:RunMenu('main', 'BAN140E')" class="nav-item" data-action="depth1">고객센터</a>
							<ul class="row-depth">
								<li><a href="javascript:RunMenu('main', 'BAN140E')" id="BAN140E" class="row-item">이용안내</a></li>
								<li><a href="javascript:RunMenu('main', 'BAN100E')" id="BAN100E" class="row-item">공지사항</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<!--// include_once("_inc/header.html"); -->
		</header>
		<!---------- container------------->
		<div id="container">
			
			<div id="content" style="display:none;">
				<div class="m-main">

					<header class="page-header">
						<h2 class="page-tit t2">로그인</h2>
						<p class="page-dec">전자계약 서비스를 이용하실려면 반드시 회원 로그인을 하셔야 합니다.</p>
					</header>

					<div class="login-container">
						<!--<div id="user_info" name="user_info" runat="server" method="post">-->
						<fieldset>
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
										<dt>패스워드</dt>
										<dd><input type="password" name="pwd" required="required"  value="" class="input_pw1"  id="pwd" onkeyPress="if (event.keyCode==13){javascript:LoginOpendraft();}"/></dd>
									</dl>
								</div>
								<div class="col-right">
									<button value="Sign In" onclick="javascript:LoginOpendraft()" class="btn b1 btn-login v-btn v-btn--contained theme--light v-size--default success BtnLogin loginBtn">로그인</button>
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
									<a href="javascript:RunMenu('main', 'BAL110E')" class="item">아이디찾기</a> /
									<a href="javascript:RunMenu('main', 'BAL120E')" class="item">패스워드 찾기</a>
								</div>
								<select name="ulang" class="" id="select4" style="display:none;">
													  <option <%=g_lang_ko_check%> value="KO">Korean</option>
													  <option <%=g_lang_ch_check%> value="CH">中文</option>
													  <option <%=g_lang_en_check%> value="EN">English</option>
													  <option <%=g_lang_jp_check%> value="JP">日本語</option>
								</select>
							</div>
						</fieldset>
						<!--</form>-->
						
					</div>

					<div class="login-btt">
						<span class="dec">아직 회원이 아니세요?</span>
						<a href="javascript:RunMenu('main', 'BAL010E')" target="_self" class="item under"><회원가입></a>
					</div>
				</div>
			</div>
			
			<!-- ODS -->
			<div id="container_main" style="display:none;">
				<iframe id="ods_run_frame" style="z-index: 100; background: white; width:100%; height:700px;">
					이 브라우저는 iframe을 지원하지 않습니다.
				</iframe>
			</div>
			<!-- //ODS -->
		</div><!--container-->
		
		
		<div id="wrap" class="page-main">
			<div id="content2">
				<div class="kv-container">
					<div class="img-box" style="background-image:url(./img/kv_main.png)">
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
						<img src="./img/main_img1.png" alt="" />
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
								<a href="javascript:RunMenu('main', 'INT100E')" class="btn blue-line">서비스소개 바로가기</a>
							</div>
						</div>
					</div>
				</section>
				
				<section class="sec s3">
					<div class="m-main">
						<div class="col-flex flex">
							<div class="col-left">
								<img src="./img/main_img2.png" alt="" />
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
		
		
		<footer id="footer">
			<!-- include_once("_inc/footer.html"); -->
			<div class="m-main">
				<div class="foot-flex flex">
					<div class="col-left">
						<img src="./img/logo_foot.png" alt="markany" />
					</div>
					<div class="col-right">
						<ul class="foot-nav">
							<li><a href="javascript:void(0)" class="item">이메일 무단 수집 거부</a></li>
							<li><a href="javascript:void(0)" class="item">서비스이용약관</a></li>
							<li><a href="javascript:void(0)" class="item">개인정보처리방침</a></li>
							<li><a href="javascript:void(0)" class="item">이용약관</a></li>
						</ul>
						<div class="dl-wrap">
							<dl>
								<dt><span class="a11y">주소</span></dt>
								<dd>서울 구로구 디지털로 33길 48 908호</dd>
							</dl>
							<dl>
								<dt><span class="txt">Tel</span></dt>
								<dd>02-942-0210</dd>
							</dl>
							<dl>
								<dt><span class="txt">* 전자계약시스템 문의 Tel</span></dt>
								<dd>02-942-0210</dd>
							</dl>
							<dl>
								<dt><span class="txt">E-Mail</span></dt>
								<dd>hscho@opendraft.co.kr</dd>
							</dl>
							</dl>
							<p class="copy">ALL RIGHTS RESERVED &copy; (주)오픈드래프트</p>
						</div>
					</div>
				</div>
			</div>
			<!--// include_once("_inc/footer.html"); -->
		</footer>
	</div>
</body>


</html>