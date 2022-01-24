<%@page import="opendraft.service.gate_web.jsp_ODS_Mobile_Dlg"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>





<%




jsp_ODS_Mobile_Dlg this_impl = new jsp_ODS_Mobile_Dlg();
this_impl.Page_Load( request, response );

String _script_div_scroll_init = this_impl._script_div_scroll_init;
String _html_body = this_impl._html_body;
String _lang_id = this_impl._lang_id;

String _screen_name = this_impl._screen_name;

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <meta name="viewport" content="width=480px;" />    
    
    
    <script type="text/javascript" language="javascript" src="./ods_web_app/ods_string_<%out.write(_lang_id);%>.js"></script>
    
    <link rel="stylesheet" href="./ods_web_app/jquery_design/redmond/jquery-ui-1.9.1.custom.css" />
    <link href="./ods_web_app/jqgrid_4.5.2/css/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" src="./ods_web_app/jquery_design/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery_design/jquery-ui-1.9.1.custom.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery_design/jquery.multicolselect.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery_design/jquery.maskedinput.js"></script>        
    
    
    <script src="./ods_web_app/jqgrid_4.5.2/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
    <script src="./ods_web_app/jqgrid_4.5.2/js/jquery.jqGrid.src.js" type="text/javascript"></script>
    <script src="./ods_web_app/jqgrid_4.5.2/plugins/jquery.contextmenu.js" type="text/javascript"></script>
    
    <script type="text/javascript" language="javascript" src="./ods_web_app/chartjs/Chart.js"></script>
    <script type="text/javascript" src="./ods_web_app/jui/jui.js"></script>
    
    <script src="./ods_web_app/jquery_design/jquery.alerts.js" type="text/javascript"></script>
	<link href="./ods_web_app/jquery_design/jquery.alerts.css" rel="stylesheet" type="text/css" media="screen" />
	
	
	<!-- mobile start -->
    <link href="./mobile/css/ods.css" rel="stylesheet" type="text/css" />        
    <script type="text/javascript" src="./mobile/js/libs/jquery.jqtransform.js"></script>
	<script type="text/javascript" src="./mobile/js/libs/jquery.bpopup.min.js"></script>
	<script type="text/javascript" src="./mobile/js/front_ui.js"></script>
	<!-- mobile end -->
    
    
   

	<script type="text/javascript" language="javascript" src="./ods_web_app/ods_html5.js"></script> 
   
    
    
    
    
    <link rel="stylesheet" type="text/css" href="./odshtml_css/mobile_common.css"/>    
    <link rel="stylesheet" type="text/css" href="./ImageServer/KO/ods_thema_2/opendraft_style_auto.css" />
    
    
    <style type="text/css">
    html{overflow:auto; }
    /* layerpopup */
    #ods_screen_run_dialog_back{display:none; position:absolute; top:0;left:0; z-index:998; background:#000; width:100%; height:100%; filter:Alpha(opacity=50); opacity:0.5; -moz-opacity:0.5;} 
    .layer_con { position:absolute; top:0; left:0; padding:0px; background:#fff; border:0px solid #444;   }
    .layer_con .ly_title{ margin-bottom:10px; font-size:15px; color:#252525}
    .layer_con .ly_bx{ overflow:scroll; width:100%; height:450px; margin-top:10px; border:1px solid #e5e5e5}
    .layer_con .ly_bx table.lst1{ border-top:none; border-left:none;}
    .white_12b { color:#fff; font-weight: bold; font-size: 17px;
    vertical-align: middle;}
    </style>
    
    
    <script language="javascript">

        function OnLoad() {

            //div scroll test
            <%=_script_div_scroll_init%>
            
            
            OnResize();

        }
        
        

        function OdsUseResize() {
            // 화면이 열리면 리사이즈를 시작한다.
            _use_resize = true;
        }

        var _use_resize = false;
        function OnResize() {

            if (!_use_resize)
                return;


            // 디자인으로 화면영역을 제외한 영역.
            var height_top_head = 65;
            var height_bottom = 0;

            var width_menu = 22;
            var gab = 0;

            var height_toolbar = Form._toolbar_height;


            var height_total = document.documentElement.clientHeight;
            var width_total = document.documentElement.clientWidth;
            
            

            // 화면이 차지 하는 영역 계산.
            var height_form = height_total - (height_top_head + height_bottom + gab * 2 + height_toolbar );
            var width_form = width_total - (width_menu + gab * 2 + 4 );


            if (width_form > 0 && height_form > 0)
                Form.OnResize(width_form, height_form);
                
                
            // remote 때문에...
            Form._is_dialog = true;
        }
        
        
        
        function OnOdsForm_Load() {
        
        
        //OnResize();
        //_use_resize = false;
        
        
            // mobile에서는 특정 시간이 지나면 resize를 하지 않는다.
            // mobile은 app size가 변경되지 않기 때문( 삼성의 멀티 윈도는 고려대상 아님)
            if( Form._is_mobile )
            {
                setTimeout( function(){
                    _use_resize = false;
                    //alert('resize off');
                }, 3000 );
            }
           
  /*      
        document.addEventListener('backbutton', function(){
  if(menu is visible) {
       //Hide the menu
       //This is also working fine
   return false;
  }
  else //nothing is visible, exit the app
  {
    navigator.app.exitApp();
  }
});
*/
        
        }
        
    </script>
    
    
    


    
</head>

<body style="overflow:auto;"  onload="javascript:OnLoad();" onresize="javascript:OnResize();" >
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
    
    
    
    
    
    
    <div id="layerPop">
    
    
    
  <div class="layer_con" style="width:100%;" >
  
  <table width="100%" style="border:1px solid #444;"><tr><td>
  
  
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="34" ><img src="./odshtml_images/layout_thema/Pop_bar_01_mobile.png" /></td>
    <td background="./odshtml_images/layout_thema/Pop_bar_02_mobile.png" class="white_12b" id="ods_dialog_title" ><%out.write(_screen_name);%></td>
    <td width="45">
    <img src="./odshtml_images/layout_thema/Pop_bar_03_mobile.png" onclick="javascript:Form.CloseView('0');  />
    </td>
  </tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="padding:3px 6px 6px 6px">
            
      
            
            <!-- 화면 내용 -->
            <%out.write(_html_body);%>
      
      
      
            
      </td>
  </tr>
    </table>


</td></tr></table>

	</div>
	
	
	
	
</div>


    
</body>
</html>
