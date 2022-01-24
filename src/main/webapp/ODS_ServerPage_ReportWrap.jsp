<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>



<%

opendraft.service.gate_web.ODWebembedGate gate_impl = new opendraft.service.gate_web.ODWebembedGate();
opendraft.service.gate_web.jsp_ODS_ServerPage_ReportWrap this_impl = new opendraft.service.gate_web.jsp_ODS_ServerPage_ReportWrap();

String _ods_report_source_url = "";
String _ods_report_pdf_url = "";



//===================================================================================
// mozilla의 pdf.js를 사용 한다.
String _pdf_js_mode = "Y";
//------------------------------------------------------------------------------------



boolean is_external_pdf = false;


String mode_view = request.getParameter("viewmode");
if( mode_view != null && mode_view.compareTo( "ext_pdf") == 0 )
{
	is_external_pdf = true;
    _ods_report_pdf_url = opendraft.lang.OdsBase64.FromBase64String(  request.getParameter("pdf_url")  );
    
}
else
{
	// Opendraft Service �ʱ�ȭ
	this_impl.Page_Load( request, response );
	
	_ods_report_source_url = this_impl._ods_report_source_url;
	_ods_report_pdf_url = this_impl._ods_report_pdf_url;	
	
}

%>




<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>


	<link rel="stylesheet" href="./ods_web_app/jquery/redmond/jquery-ui-1.9.1.custom.css" />
    <link rel="stylesheet" type="text/css" href="./odshtml_css/ods_serverpage_common.css"/>
    
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-ui-1.9.1.custom.js"></script>
    
    <script src="./ods_web_app/pdf_js/pdfobject.min.js"></script>
    <script type="text/javascript" src="./ods_web_app/ods_html5.js"></script>
    
    

<script language="Javascript" src="./opendraftx.js"></script>    
    <script language="javascript">

        function CloseOdsBrowser() {
        
            if (navigator.appVersion.indexOf("MSIE 6.0") == 0) {
                window.opener = self;
                self.close();

            }
            else {
                window.open('about:blank', '_self').close();
            }
        }
        
        function CloseOdsBrowserDelay() {

            setTimeout(CloseOdsBrowser, 5000);
        }
        
        
        function OnResize() {
            var height_total = document.documentElement.clientHeight;
            var width_total = document.documentElement.clientWidth;

            if (use_pdf_js) {
                var frame_report = document.getElementById("pdf");
                frame_report.style.width = width_total + "px";
                frame_report.style.height = height_total + "px";
            }
            else {

		           var frame_report = document.getElementById("ods_report_preview_frame");
		           frame_report.style.width = width_total + "px";
		           frame_report.style.height = height_total + "px";
            }
        }

        
        
        
        
        function OnLoad() {
        	
			
        	var url_src = "<% out.write(_ods_report_source_url);%>";
        	var url_pdf = "<% out.write(_ods_report_pdf_url);%>";
        	
        	var pdf_js_mode = "<% out.write(_pdf_js_mode);%>";
        	if (pdf_js_mode == "Y") {

                try {
                    document.getElementById("pdf").style.display = "";

                    use_pdf_js = true;
                    OnResize();

                    

                    
                    url_pdf = url_pdf.replace("./", "../../../");

					

                    var options = {
                        pdfOpenParams: {
                            navpanes: 0,
                            toolbar: 0,
                            statusbar: 0,
                            view: "FitV",
                            pagemode: "none",
                            page: 0
                        },
                        forcePDFJS: true,
                        PDFJS_URL: "./ods_web_app/pdf_js/web/viewer.html"
                    };

                    var url = String(url_pdf);
                    var myPDF = PDFObject.embed(url, "#pdf", options);

                    //alert(url_pdf);
                }
                catch (e) {
                    alert(e);
                }

            }
            else {
                // 기존의 html5 방식 미리보기

	           // 리포트 출력
	           
	           if (url != "") {
	               ShowReportPreview(url_src, "page_list");                
	           }
            }
        }


        //


        function OnOdsReportSave() {
            //리포트저장

            var url = "<% out.write(_ods_report_pdf_url);%>";


            var _iframe_dl = $('<iframe />')
           .attr('src', url)
           .hide()
           .appendTo('body');
            return;
        }
        
    
    </script>
    
    
    <% out.write( this_impl.opendraft_init_script ); %>
    
    
    
</head>


<body style="height:100%; overflow:hidden;"  onresize="javascript:OnResize();"  onload="javascript:OnLoad();">

	<script language=javascript>
	var str_opendraft_x = "<% out.write( this_impl.opendraft_x_codebase); %>";
	if( str_opendraft_x != "" )
	    opendraftx_hide(str_opendraft_x);
    
    </script>
    
    
    
    <div id="pdf" style="display:none;"></div>
    
    
    
    <!-- Start : 숨겨진 html5 viewer -->
    <div id="ods_report_preview_frame" style=" display:none;  left:0px; top:0px; width:0px; height:0px;  ">
    
        <div id="ods_report_toolbar" style=" position:absolute; left:0px; right:0px; top:0px; height:40px; background:LightGray; ">
        
            <button onclick="javascript:OnOdsReportZoomin();"
                style=" position:absolute; left:4px; width:80px; top:4px; height:32px;" >확대</button>
            <button onclick="javascript:OnOdsReportZoomout();"
                style=" position:absolute; left:88px; width:80px; top:4px; height:32px;" >축소</button>
            
            
            <button  onclick="javascript:OnOdsReportPagePrev();"
                style=" position:absolute; left:178px; width:80px; top:4px; height:32px;" >이전</button>
            <div
                style=" position:absolute; left:262px; width:62px; top:4px; height:32px;" >
                <select  id="page_list" onchange="javascript:OnOdsReportGoPage();" style=" position:absolute; width:60px; height:32px;"></select>
            </div>
            <button   onclick="javascript:OnOdsReportPageNext();"
                style=" position:absolute; left:328px; width:80px; top:4px; height:32px;" >다음</button>
            
            <button  onclick="javascript:OnOdsReportSave();"
                style=" position:absolute; right:88px; width:80px; top:4px; height:32px;" >저장</button>
            
            <button  onclick="javascript:CloseOdsBrowser();"
                style=" position:absolute; right:4px; width:80px; top:4px; height:32px;" >닫기</button>
            
        </div>
    
    
    
        <div id="ods_layer_report_view" style=" position:absolute; overflow:scroll; left:0px; right:0px; top:40px; bottom:0px; background:#EEEEEE;  ">
                <table style="  left:0px; top:0px;  ">
                    <tr>
                        <td id="ods_td_report_size" style="  width:768px; height:1024px;  ">
                        
                        <canvas id="ods_canvas_report_size" width="768px" height="1024px;" style="  left:0px; top:0px; width:768px; height:1024px; ">
                        </canvas>       
                            
                        </td>
                    </tr>
                </table>
        </div>
    
    
    </div>
    <!-- End : 숨겨진 html5 viewer -->
    
    
    
    <% out.write( this_impl.opendraft_pdf_script); %>
    
    <script language="javascript">
    <% out.write( this_impl.opendraft_pdf_script2); %>
    </script>
    
</body>
</html>