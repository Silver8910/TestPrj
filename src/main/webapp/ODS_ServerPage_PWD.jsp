<%@page import="opendraft.service.gate_web.jsp_ODS_ServerPage_Run"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">




<html xmlns="http://www.w3.org/1999/xhtml">

<%

// Opendraft Service 초기화
opendraft.service.gate_web.ODWebembedGate gate_impl = new opendraft.service.gate_web.ODWebembedGate();
jsp_ODS_ServerPage_Run this_impl = new jsp_ODS_ServerPage_Run();


// session error 발생시 Page_Load에서 바로 redirect하지 않고 
// 에러 결과를 설정.
this_impl._session_error_skip = true;

this_impl.Page_Load( request, response, false, "", "" );

//*///////////////
// session에러가 발생 했다.
if( this_impl._session_error_result == true )
{
	response.getWriter().write(
					"<script language=javascript> \r\n"+
        			"   alert('세션이 종료되어 초기페이지로 이동합니다.\\n다시 로그인 해 주세요'); "+
        			"   setTimeout(function(){parent.document.location = 'index.jsp'},500)  \r\n"+
        			"</script>" );
	return;
}



String _lang_id = this_impl._lang_id.toLowerCase();

//*///////////////

String str_init_script = this_impl._script_div_scroll_init.replaceAll("Form.DialogInit();", "");

int pos = str_init_script.indexOf( "Form.DialogInit();" );

pos = str_init_script.indexOf( "Form.DialogInit();" );

_lang_id = this_impl._lang_id.toLowerCase();
%>


<head>
    <title></title>
    
    <link href="./asset_ods/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="./asset_ods/font-awesome/css/font-awesome.css">
	
	<!-- 기존 금칙어 + 커스텀 툴바 아이콘 삽입(class 변경) 등등 추가 load 부분에서 사용 -->
    <script type="text/javascript" language="javascript" src="./ods_web_app/ods_external.js"></script>
    
    <script type="text/javascript" language="javascript" src="./ods_web_app/ods_string_<%out.write(_lang_id);%>.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-ui-1.9.1.custom.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery.multicolselect.js"></script>   
    <script type="text/javascript" src="./ods_web_app/jquery/jquery.maskedinput.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/swiper.jquery.min.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery.dynatree.js" type="text/javascript"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery.alerts.js" type="text/javascript"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/barcode/jquery-barcode.js" type="text/javascript"></script>
    
    <script type="text/javascript" src="./ods_web_app/ods_html5.js" language="javascript" ></script>
    
    <link rel="stylesheet" href="./ods_web_app/jquery/jquery.alerts.css" type="text/css" media="screen" />
    <link rel="stylesheet" href="./ods_web_app/jquery/redmond/jquery-ui-1.9.1.custom.css" />
    <link rel="stylesheet" href="./ods_web_app/jquery/skin_dynatree/ui.dynatree.css" type="text/css" />
    <link rel="stylesheet" href="./odshtml_css/AddNew.css" type="text/css" />
    
    <link rel="stylesheet" href="./ods_web_app/jquery/swiper.min.css" >
    
    <link rel="stylesheet" href="./ImageServer/KO/ods_thema_2/opendraft_style_auto.css" type="text/css"  />
    
    <link rel="stylesheet" href="./odshtml_css/ods_serverpage_common.css" type="text/css" />
	
    
    <link rel="stylesheet" href="./odshtml_css/ods_serverpage_toolbar.css" type="text/css" />
    <link rel="stylesheet" href="./odshtml_css/ods_serverpage_custom.css" type="text/css" /> <!--20180611 yhl 디자인-->
    
    <!-- dgn 스타일-->
    <link rel="stylesheet" href="./ImageServer/ods_design_widget_style.css" type="text/css" />
    
    
    <!-- dgn 커스텀 이벤트-->
    <script type="text/javascript" src="./ods_web_app/dgn_custom_event.js" type="text/javascript"></script>
    
    <!-- Mobile 프로그램 개발 WEBT를 Web에서도 확인하기 위해 -->
    <link rel="stylesheet" href="./odshtml_css/mobile_WEBT.css" type="text/css" />
    
    <!-- 제거하면 특정 프로그램 Innor_Position이 없다는 에러가 발생 (ViewCode: SimpleForm)-->
    <script src="./ods_web_app/jqgrid_4.5.2/plugins/jquery.contextmenu.js" type="text/javascript"></script>
    
    
<!-- 안쓸예정 및 확인 후 제거대상

    <script src="./ods_web_app/jqgrid_4.5.2/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
    <script src="./ods_web_app/jqgrid_4.5.2/js/jquery.jqGrid.src.js" type="text/javascript"></script>
    
    <script type="text/javascript" src="./ods_web_app/jui/jui.js"></script>
    
    <link rel="stylesheet" href="./ods_web_app/jqgrid_4.5.2/css/ui.jqgrid.css" type="text/css" />
-->    
    
    <style type="text/css">
		html{ overflow:auto; }

		.layer_con { position:absolute; top:50%; left:50%; padding:0; background:#fff; border:1px solid #444; z-index:99999;}
		.layer_con .ly_title{ margin-bottom:10px; font-size:15px; color:#252525}
		.layer_con .ly_bx{ overflow:scroll; width:100%; height:450px; margin-top:10px; border:1px solid #e5e5e5}
		.layer_con .ly_bx table.lst1{ border-top:none; border-left:none;}


        .loading_img{/*margin:-100px 0 0 -100px;position:fixed;top:55%;left:55%;z-index:99999;display:block;*/
        width: 100%;
    height: 100%;
    left: 0px;
    top: 0px;
    position: absolute; 
    background: url(./odshtml_images/loading.gif) no-repeat center center;
    }

    .loading_img > img{/*margin:-100px 0 0 -100px;position:fixed;top:55%;left:55%;z-index:99999;display:block;*/
        
        width: 100%;
        height: 100%;
    }

		#ods_screen_run_dialog_back{display:none; position:fixed; _position:absolute; top:0;left:0; z-index:998; background:#000; width:100%; height:100%; filter:Alpha(opacity=50); opacity:0.5; -moz-opacity:0.5;} 
		#ods_screen_run_dialog.dlg_popup:after{width:90%;height:50px;display:block;content:"";position:absolute;top:0;left:0;z-index:9999;cursor:move;}

		.white_12b { /*color:#fff; font-weight: bold; font-size:12px*/
		background: #fff;
		color: #000;
		font-size: 22px;
		}

		#ods_screen_run_dialog{/*overflow:hidden;*/}

		.white_12b>td>table{border:1px solid #e1e1e1;}
		
		// test
		.combo_popup > table > tbody > tr > td:hover{ color: #398ae4 !important; background:white; }
    }
    </style>
    
            
        <script type="text/javascript">

        
        function RunMenu(menu_id)
        {            
            document.location = "ODS_ServerPage_Run.jsp?menu_code=" + menu_id;
        }
        
        function OdsRunMenuNext(menu_id)
        {            
            document.location = "ODS_ServerPage_Run.jsp?use_next=y&menu_code=" + menu_id;
        }
        
        

        function OnLoad()
        {
			// external--------------------------------------
			// 툴바에 awsome 아이콘 박기
			//_ods_toolbar_icon(); 
			
			// Group 접었다 펴기 기능. 존재하지않으면 실행하지 않음
			//_ods_external_init_minimize(); 
			// external--------------------------------------
			
        	try
        	{
        	//div scroll test
				<%  out.write( str_init_script ); %>
            
            
				// 로딩 이미지 숨김.
				//$('.loading_img').removeClass('loading');
				
				document.getElementById("ods_screen_loading_image").style.display = "none";
				
				Form._string_format_grid_cell = new OdsStringFormat();
				Form._string_format_grid_cell.wordwrap = false;
        	}
        	catch( exp)
        	{
        		alert(exp.toString() );
        	}
            
        	
            OnResize();

        }
        
        
        function OdsUseResize(){
            // 화면이 열리면 리사이즈를 시작한다.
            _use_resize = true;
        }
        
        var _use_resize = false;
        function OnResize() {        
        
            if( !_use_resize )
                return;
                
        
            // 디자인으로 화면영역을 제외한 영역.
            var height_top_head = -5;
            var height_bottom = 0;
            
            var width_menu = 0;            
            var gab = 3;
            
            var height_toolbar = Form._toolbar_height;
            
            
            var height_total = document.documentElement.clientHeight;
            var width_total = document.documentElement.clientWidth;
            

            // 화면이 차지 하는 영역 계산.
            var height_form = height_total - (height_top_head+height_bottom+gab*2+height_toolbar);
            var width_form = width_total - (width_menu+gab*2);
                
                
            if( width_form > 0 && height_form > 0 )                
                Form.OnResize( width_form, height_form );
			
			$("#ods_screen_run_dialog").css("overflow","hidden");
			
			
        }
        
        
        
        function ODS_GoMobileLayout() {
            var frm = document.ods_form_action;
            if (frm) {
                frm.ods_layout_target.value = "mobile";
                frm.action = "ODS_ServerPage_Layout.aspx";
                frm.submit();
            }
            else {
                document.location = "ODS_ServerPage_Layout.aspx?chtarget=mobile";
            }
        }
		
		// MDI 배열 변경시 TITLE 컨트롤 하는 기능
		function OnOdsShowParentMDITitle(show, title)
        {
			
			/*
			if( show )
            {
				document.getElementById("ods_label_web_title").style.display = "none";
            }
            else
            {
				document.getElementById("ods_label_web_title").style.display = "";
				document.getElementById("ods_label_web_title").style.display = "";
            }
			*/
        }

			
		/* focus 시 img 가 있으면 테두리 TEST 171107 */ 

		$( document ).ready(function() {
			/*
			$(".edit_default_edit, .edit_default80_edit, .edit_default0_edit").focus(function(){
					
					//if( this.name.replace(/_label/, "_btn").indexOf("_btn") > 0)
						//$("#"+this.name.replace(/_label/, "_btn")).css({"border-top":"2px solid #99c9ff","border-right":"2px solid #99c9ff","border-bottom":"2px solid #99c9ff","transition": "0.3s ease all","border-top-right-radius": "5px","border-bottom-right-radius": "5px" });
						$("#"+this.name.replace(/_label/, "_btn")).attr("src", "./odshtml_images/ctrl_select/select_focus.png");
						
			});

			$(".edit_default_edit, .edit_default80_edit, .edit_default0_edit").focusout(function(){
					if( this.name.replace(/_label/, "_btn").indexOf("_btn") > 0)
						//$("#"+this.name.replace(/_label/, "_btn")).css({"border":"0"});
						$("#"+this.name.replace(/_label/, "_btn")).attr("src", "./odshtml_images/ctrl_select/select_nor.png");
					else
						;
						//$("#"+this.name.replace(/_label/, "_btn")).css({"border": "1px solid #DCDCDC", "border-radius": "5px"});
			});
			
			*/
			
			$("input[ods_type=combo]").focus(function(){
				$("#"+this.name.replace(/_label/, "_btn")).attr("src", "./odshtml_images/ctrl_select/select_focus.png");
			});
			$("input[ods_type=combo]").focusout(function(){
				$("#"+this.name.replace(/_label/, "_btn")).attr("src", "./odshtml_images/ctrl_select/select_nor.png");
			});
			
			$("input[ods_type=date_time]").focus(function(){
				$(this).parents("tr:first").find("img").attr("src", "./odshtml_images/calendar_focus.png");
			});
			$("input[ods_type=date_time]").focusout(function(){
					$(this).parents("tr:first").find("img").attr("src", "./odshtml_images/calendar.png");
			});
			
			$("input[ods_type=date_time_month], input[ods_type=date_time_year]").focus(function(){
					$(this).parents("tr:first").parents("tr:first").find("img").attr("src", "./odshtml_images/calendar_focus.png");
			});

			$("input[ods_type=date_time_month], input[ods_type=date_time_year]").focusout(function(){
					$(this).parents("tr:first").parents("tr:first").find("img").attr("src", "./odshtml_images/calendar.png");
			});

			
			/*
			$("input[alt=combo]").focus(function(){
						$("#"+this.name.replace(/_label/, "_btn")).attr("src", "./odshtml_images/ctrl_select/select_nor_focus.png");
			});

			$("input[alt=combo]").focusout(function(){
					$("#"+this.name.replace(/_label/, "_btn")).css({"border": "1px solid #DCDCDC", "border-radius": "5px"});
			});

			*/
		
			
			
			
		});


    $(function(){
	setTimeout(function(){
	$(".combo_popup").parent().css({"border": "2px solid #99c9ff", "border-radius": "5px", "padding": "0px","padding-bottom": "0px", "overflow-y":"hidden"});
	$(".combo_popup").css({"padding-bottom":"5px"});
	
    $(".combo_popup").slimScroll({
    height: '150px',
    size: '6px',
    position: 'right',
    color: '#919191',
    alwaysVisible: true,
    railVisible: true,
    railColor: 'white',
    railOpacity: 0.5
    
    });
    
    $(".combo_popup > table > tbody > tr > td").css({"padding-left": "0px","color": "rgb(113,113,113)", "cursor":"pointer"});
    $(".combo_popup > table > tbody > tr > td:hover").css({"color": "#99c9ff", "background":"white"});
    
    },300);
});

 
    
     
    </script>
    

</head>

<body onload="javascript:OnLoad();" onresize="javascript:OnResize();">
   
    <%  out.write( this_impl._html_body ); %>
    

<!--<div  id="ods_screen_loading_image" class="loading_img loading"><img src="odshtml_images/loading.gif" alt="로딩" ></div>    -->
<div  id="ods_screen_loading_image" class="loading_img loading"></div>   
<script src="asset_ods/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>

</body>
</html>

