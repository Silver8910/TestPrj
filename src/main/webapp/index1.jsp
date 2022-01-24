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
 
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<title>Open Draft</title>
	<link href="./Images_login/css/login.css" rel="stylesheet">

	<script type="text/javascript" src="./Images_login/js/jquery-1.11.1.min.js"></script>

	<script language="Javascript" src="./opendraftx.js"></script>
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

        var chk_dup_submit = 0;


        function LoginOpendraft()
        {


            if (document.user_info.uid.value == "") {
                alert("사용자 계정을 입력해 주세요.");
                return;
            }

            if (document.user_info.pwd.value == "") {
                alert("비밀번호를 입력해 주세요.");
                return;
            }


            if (document.user_info.ulang.value == "") {
                alert("언어를 선택해 주세요.");
                return;
            }






            //if (document.user_info.run_type.value == "") {
            //    alert("실행 타입을 선택해 주세요.");
            //    return;
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
        
    </script>



		<script type="text/javascript">


            if ((navigator.userAgent.indexOf('iPhone') != -1) ||
                (navigator.userAgent.indexOf('iPod') != -1) ||
                (navigator.userAgent.indexOf('iPad') != -1)
	        ) {
                document.location = "index_mobile.jsp";
            }
            else if (navigator.userAgent.indexOf('Android') != -1) {
                document.location = "index_mobile.jsp";
            }
            else if (navigator.userAgent.indexOf('webOS') != -1) {
                document.location = "index_mobile.jsp";
            }
            else if (navigator.userAgent.indexOf('BlackBerry') != -1) {
                document.location = "index_mobile.jsp";
            }
            else if (navigator.userAgent.indexOf('Windows') != -1) {
                //document.location = "index_mobile.jsp";
            }
            else
            {
                alert(navigator.userAgent + "기기를 알 수 없습니다. 관리자에게 이 메시지를 보내 주세요.");
            }
    </script>




		<% out.write(opendraft_auto_logoin_script); %>
	
</head>





<body>


<script language="javascript">
    opendraftx_hide("<%=opendraft_x_codebase%>");
</script>
	<div id="wrap">
		<div class="dd" style="width: 50%; height: 100%;">
		</div>
		<div class="loginWrap">
			<div class="loginBx">
				<div class="formArea">
					<div class="banner"><!--<img src="./Images_login/images/loginbanner_img01.png" alt="" />-->
						OPEN DRAFT
					</div>


							
								<label for="input_check1" style="position:relative; left: 15px"> for developer</label><span class="input_check"><input type="checkbox" id="input_check1" checked></span>
								<span class="f_right" >
							</span>
<form id="user_info" name="user_info" runat="server" method="post" >
<fieldset>
					<input name="run_type" type="radio" id="radio1" value="stand" checked="checked" style="display:none;"/>
                    <input type="radio" name="run_type" id="radio4" value="web" style="display:none;"/>
					<ul class="login_form">
						<li class="selectBx">
			                     <select name="ulang" class="" id="select4">
							      <option <%=g_lang_ko_check%> value="KO">Korean</option>
					              <option <%=g_lang_ch_check%> value="CH">中文</option>
		                          <option <%=g_lang_en_check%> value="EN">English</option>
								  <option <%=g_lang_jp_check%> value="JP">日本語</option>
						        </select>
						</li>
						<li>
							<input type=hidden maxlength=20 name="chk_login" id="Hidden1" value="" />
							<input type="text" name="uid" value="<%=g_user_id%>" class="input_txt1" placeholder="ID" id="uid"/></li>
						</li>

						<li>
							<input type="password" name="pwd" value="" class="input_pw1" placeholder="Password" id="pwd"/></li>
                            
                        <li class="loginCk">
							<!-- <label for="chk_save">Save User ID</label>
                            <span class="input_check">
                            
                                <input type="checkbox" name="chk_save" id="chk_save" value="<%=g_check_save%>"> 
                            </span> 
                            </input> -->

							<label class="chk-label check">
								<input type="checkbox" name="chk_save" id="chk_save" <%=g_check_save%>> 
								<span id="chk_save" class="txt">Save User ID</span>
							</label>
                        </li>
						<li class="loginBtn">
						<button type="submit" value="Sign In" class="BtnLogin loginBtn" onclick="javascript:LoginOpendraft()" id="submit_label"style="cursor:pointer">
						LOGIN</button>
						</li>
					</ul>
                    
</fieldset>
</form>
                    
					<!-- <a href="javascript:;" id="pwdsearch_label">* 비밀번호를 잊으셨나요?</a> -->
				</div>
			</div>

			<div class="footer"><a href="#"><!--<img src="./Images_login/images/header_logo.png" alt="Opendraft" title="Opendraft BCP" class="iconimg"/>--></a> Copyright (c) 2017 BY OpenDraft co.ltd &nbsp;All Rights Reserved.</div>
		</div>
	</div>
</body>
</html>