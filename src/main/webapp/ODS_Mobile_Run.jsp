<%@page import="opendraft.service.gate_web.jsp_ODS_Mobile_Run"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%






jsp_ODS_Mobile_Run this_impl = new jsp_ODS_Mobile_Run();
this_impl.Page_Load( request, response, "", "" );

String _script_div_scroll_init = this_impl._script_div_scroll_init;
String _html_body = this_impl._html_body;
String _user_id = this_impl._user_id;
String _lang_id = this_impl._lang_id;

%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <!-- add 영역 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="imagetoolbar" content="no" />
	<meta name="viewport" content="width=480">
	<meta name="format-detection" content="telephone=no, address=no, email=no" />
    
    
    
    
    <script type="text/javascript" language="javascript" src="./ods_web_app/ods_external.js"></script>
    
    <script type="text/javascript" language="javascript" src="./ods_web_app/ods_string_<%out.write(_lang_id);%>.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-ui-1.9.1.custom.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery.multicolselect.js"></script>   
    <script type="text/javascript" src="./ods_web_app/jquery/jquery.maskedinput.js"></script>
    <!--<script type="text/javascript" src="./ods_web_app/jquery/swiper.jquery.min.js"></script>-->
    <script type="text/javascript" src="./ods_web_app/jquery/swiper.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery.dynatree.js" type="text/javascript"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery.alerts.js" type="text/javascript"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/barcode/jquery-barcode.js" type="text/javascript"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/barcode/jquery-barcode.js" ></script>
    
    <script type="text/javascript" src="./ods_web_app/ods_html5.js" language="javascript" ></script>
    
    <link rel="stylesheet" href="./ods_web_app/jquery/jquery.alerts.css" type="text/css" media="screen" />
    <link rel="stylesheet" href="./ods_web_app/jquery/redmond/jquery-ui-1.9.1.custom.css" />
    <link rel="stylesheet" href="./ods_web_app/jquery/skin_dynatree/ui.dynatree.css" type="text/css" />
    
    <!--<link rel="stylesheet" href="./ods_web_app/jquery/swiper.min.css" >-->
    <link rel="stylesheet" href="./ods_web_app/jquery/swiper.css" >
    
    
    
    
    
    
    <!-- Mobile 프로그램 개발 WEBT를 Web에서도 확인하기 위해 -->
    <link rel="stylesheet" href="./odshtml_css/mobile_WEBT.css" type="text/css" />
    
    
    <link href="./ods_web_app/jquery_design/skin_dynatree/ui.dynatree.css" rel="stylesheet" type="text/css" />
    <!-- mobile -->
    <script type="text/javascript" src="./mobile/js/libs/jquery.jqtransform.js"></script>
	<script type="text/javascript" src="./mobile/js/libs/jquery.bpopup.min.js"></script>
	<script type="text/javascript" src="./mobile/js/front_ui.js"></script>
	<link href="./mobile/css/ods.css" rel="stylesheet" type="text/css" />
	
	<link rel="stylesheet" type="text/css" href="./odshtml_css/mobile_common.css"/>
    <link rel="stylesheet" type="text/css" href="./odshtml_css/mobile_WEBT.css"/>
    <link rel="stylesheet" type="text/css" href="./ImageServer/KO/ods_thema_2/opendraft_style_auto.css" />
    <!-- add 영역 end -->
    
    <!--
    <script src="./ods_web_app/jqgrid_4.5.2/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
    <script src="./ods_web_app/jqgrid_4.5.2/js/jquery.jqGrid.src.js" type="text/javascript"></script>
    <script src="./ods_web_app/jqgrid_4.5.2/plugins/jquery.contextmenu.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript" src="./ods_web_app/chartjs/Chart.js"></script>
    -->
    
    
     <!-- 제거하면 특정 프로그램 Innor_Position이 없다는 에러가 발생 (ViewCode: SimpleForm)
        제거하면 위젯에서 ShowToolbar 시 화면안열림
    -->
     <script src="./ods_web_app/jqgrid_4.5.2/plugins/jquery.contextmenu.js" type="text/javascript"></script>
    
    <!--<link rel="stylesheet" type="text/css" href="./ImageServer/KO/ods_thema_2/opendraft_style_auto_hibrid.css" />-->
    
    
    
    <script type="text/javascript">


//======================================================================================
    // ios 관련 코드
    function openCustomURLinIFrame(src)
    {
        var rootElm = document.documentElement;
        var newFrameElm = document.createElement("IFRAME");
        newFrameElm.setAttribute("src",src);
        rootElm.appendChild(newFrameElm);
        //remove the frame now
        newFrameElm.parentNode.removeChild(newFrameElm);
    }

    function calliOSFunction(functionName, args, successCallback, errorCallback)
    {
        var url = "js2ios://";
        
        var callInfo = {};
        callInfo.functionname = functionName;
        if (successCallback)
        {
            callInfo.success = successCallback;
        }
        if (errorCallback)
        {
            callInfo.error = errorCallback;
        }
        if (args)
        {
            callInfo.args = args;
        }
        
        url += JSON.stringify(callInfo)
        
        openCustomURLinIFrame(url);
    }

    // Capture Button Event function
    function onClickCaptureBtn() {
        calliOSFunction("CaptureCameraGetData", [], "onSuccessCapture", "onErrorCapture");
    }

    function onSuccessCapture (ret)
    {
        if (ret)
        {
            var obj = JSON.parse(ret);
            //document.write(obj.result);
            //var base64String = obj.result;
            odshybrid.OnCaptureData( obj.result );
            
        }
    }

    function onErrorCapture (ret)
    {
        if (ret)
        {
            var obj = JSON.parse(ret);
            //document.write(obj.error);
        }
    }

    // Barcode Scan Button Event function
    function onClickBarcodeScanBtn() {
        calliOSFunction("BarcodeScan", [], "onSuccessBarcodeScan", "onErrorBarcodeScan");
    }

    function onSuccessBarcodeScan (ret)
    {
        if (ret)
        {
            var obj = JSON.parse(ret);
            //document.write(obj.result);
            var barcodeString = obj.result;
            
            odshybrid.OnBarcodeResult(barcodeString);
        }
    }

    function onErrorBarcodeScan (ret)
    {
        if (ret)
        {
            var obj = JSON.parse(ret);
            //document.write(obj.error);
        }
    }
    
    
    
    ODS_IOS_Interface = function()
    {
        this._ctrl_image = "";
        this._image_data_base64 = "";
        
        this._barcode_data = "";
	this._hybrid_ok = false;
    };
    
    ODS_IOS_Interface.prototype = {
    
        CaptureCamera : function( width_size,  image_ctrl_name)
        {
            //alert("camera call start");
            
            this._ctrl_image = image_ctrl_name;
            onClickCaptureBtn();
            
            
            //this.OnCaptureData("무궁화꽃이 <br / > 무궁화 꽃이..");
        },
        CaptureCameraGetData : function()
        {
            
            return this._image_data_base64;
        },
        OnCaptureData : function( image_data )
        {
            
            this._image_data_base64 = image_data;
            
            /*
            var ele_test = document.createElement("div");
        ele_test.id = "base64_data_test_div";

        ele_test.style.position = "absolute";
        ele_test.style.top = "50px";
        ele_test.style.left = "50px";
        ele_test.style.width = "400px";
        ele_test.style.height = "400px";
        
        ele_test.style.zIndex = 9999;
        document.body.appendChild( ele_test );
        
        ele_test.innerHTML = image_data;
        */
        
        
        setTimeout(function() {
            
            //ods event실행
            //alert("이미지 받음 완료");
            eval( odshybrid._ctrl_image + ".OnCatureCameraEnd();" );

        }, 500);
            
            
            
            
            
        },
        
        
        BarcodeScan : function()
        {
            
            onClickBarcodeScanBtn();
        },
        
        OnBarcodeResult : function(barcode_data)        
        {   
            this._barcode_data = barcode_data;
        
            setTimeout(function() {
                
                //ods event실행
                //alert("바코드 받음 완료");
                
                // format data필요
                Form.OnMobileBarcodeResult( "", odshybrid._barcode_data );

            }, 500);
        
            
        },
        
        GetOdsHybrid : function()
        {
		if( this._hybrid_ok )
	                return "ods_ver_1";
		return "not_hybrid";
        }
        
        
        
    };
    


function iOS() {

      var iDevices = [
        'iPad Simulator',
        'iPhone Simulator',
        'iPod Simulator',
        'iPad',
        'iPhone',
        'iPod'
      ];

      if (!!navigator.platform) {
      
        while (iDevices.length) {
            
          if (navigator.platform === iDevices.pop()){ return true; }
        }
      }

      return false;
    }
    
    
    var odshybrid = null;
    if( iOS() )
    {
        var str_agent = String(navigator.userAgent);
        
        // hybrid체크를 넣어야 함.
        odshybrid = new ODS_IOS_Interface();    
        
        if( str_agent.indexOf("odshybrid") >= 0 )
                {
                    alert("hybrid ok!!");
                    odshybrid._hybrid_ok = true;
                }
                else
                {
                    alert("Not hybrid!!");
                    odshybrid._hybrid_ok = false;
                }
    }
    
    

    //--------------------------------------------------------------------------------------
    
            
        function OnLoad()
        {           
       
       
       

            //div scroll test
            <%=_script_div_scroll_init%>
            
            
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
            var height_toolbar = Form._toolbar_height;
            
            //var width_total = window.innerWidth;
            var width_total = 480;
            
            //window.innerWidth = 480;
            var height_total = window.innerHeight;
            height_total = 740;

            // 화면이 차지 하는 영역 계산.
            var height_form = height_total - (height_toolbar);
            var width_form = width_total;
            
            
            // 복산 재계산
            //height_form=200
            
            if( width_form > 0 && height_form > 0 )                
                Form.OnResize( width_form, height_form );
                
                /*
                //if( /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ) {
                  var ww = ( $(window).width() < window.screen.width ) ? $(window).width() : window.screen.width; //get proper width
                  
                  var mw = 480; // min width of site
                  var ratio =  ww / mw; //calculate ratio
                  if( ww < mw){ //smaller than minimum size
                  
                   $('#Viewport').attr('content', 'initial-scale=' + ratio + ', maximum-scale=' + ratio + ', minimum-scale=' + ratio + ', user-scalable=yes, width=' + ww);
                  }else{ //regular size
                  
                   $('#Viewport').attr('content', 'initial-scale=1.0, maximum-scale=2, minimum-scale=1.0, user-scalable=yes, width=' + ww);
                  }
                //}
                */

        }

        
        
        function OnOdsForm_Load() {
        
        
        //OnResize();
        //_use_resize = false;
        				Form._string_format_grid_cell = new OdsStringFormat();
				Form._string_format_grid_cell.wordwrap = false;
        
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
        


function onOdsGCMMessage( screen_info, send_user_id, send_user_name, msg_id, msg_data )
        {
            // 현재 화면 코드가 screen_info와 다르면 다른 화면을 오픈한다.
            // 이게 맞을지 고민을 해야함.
            //alert(msg_id);
            
            // screen_data를 event로 보냄.   
            var arg = [send_user_id, send_user_name, msg_id, msg_data];
            var function_name = "Form_OnPushRecv";
            if (eval("typeof " + function_name + " == 'function'"))
                Form.InvokeEvent2(function_name, arg);
        
        }

        
        
    </script>
    
    
    
    <style type="text/css">
    
    /* layerpopup */
    #ods_screen_run_dialog_back{display:none; position:fixed; _position:absolute; top:0;left:0; z-index:99; background:#000; width:100%; height:100%; filter:Alpha(opacity=50); opacity:0.5; -moz-opacity:0.5;} 
    .layer_con { position:absolute; top:50%; left:50%; padding:0; background:#fff; border:1px solid #444; z-index:99999;}
    .layer_con .ly_title{ margin-bottom:10px; font-size:15px; color:#252525}
    .layer_con .ly_bx{ overflow:scroll; width:100%; height:450px; margin-top:10px; border:1px solid #e5e5e5}
    .layer_con .ly_bx table.lst1{ border-top:none; border-left:none;}

    .white_12b { color:#fff; font-weight: bold; font-size: 17px;
    vertical-align: middle;}
    .white_12b > td:nth-child(2n) > table > tbody > tr > td:nth-child(3n) > img { height:45px;}
    </style>
    
</head>
<body   scroll="no" style=" overflow:hidden; width:480px;  "   onload="javascript:OnLoad();" onresize="javascript:OnResize();">
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
    
    
    <%=_html_body%>
    
    
</body>
</html>
