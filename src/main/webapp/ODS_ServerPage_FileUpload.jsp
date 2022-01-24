<%@page import="opendraft.service.gate_web.ODS_ServerPage_FileUpload_impl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>



<%



ODS_ServerPage_FileUpload_impl this_impl = new ODS_ServerPage_FileUpload_impl();
this_impl.Page_Load( request, response );

String _html_download_script = this_impl._html_download_script;
String _html_download = this_impl._html_download;
String _excel_data = this_impl._excel_data;

boolean _is_upload_form = this_impl._is_upload_form;
String _recv_od = this_impl._recv_od;

String _file_fillter = this_impl._file_fillter;
%>




<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
    
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-ui-1.9.1.custom.js"></script>
    <script type="text/javascript" language="javascript" src="./ods_web_app/ods_html5.js"></script>
    
    
    <script language=javascript>

    	var g_excel_data = "<% out.write(_excel_data); %>";
    
        function onLoad() {
			
			<% out.write(_html_download_script); %>
			
			//document.getElementsByClassName("ods_fileupload_dlg_close")[0].innerText = 'X';
			
	}
        
        
        function onUploadResult(ctrl_name, error_str)
    {    
        if( ctrl_name != "" )
        {
            if( window.opener )
            {
                window.opener.onOdsFileUpload(ctrl_name);
            }
            else
            {
                parent.onOdsFileUpload(ctrl_name);
                parent.CloseFileWindow();
                return;
            }
        }
        else
        {
            
            alert(Base64.decode( error_str ));
        }
        
        
        CloseOdsBrowser();
    }
    
    
    function onExcelImportEnd()
    {
        if( window.opener )
        {
            window.opener.ods_ExcelUploadEnd(g_excel_data);
        }
        else
        {
            parent.ods_ExcelUploadEnd(g_excel_data);
            parent.CloseFileWindow();
            return;
        }
        CloseOdsBrowser();
    }
    
    function onImageFileReadEnd()
    {
        if( window.opener )
        {
            window.opener.ods_ImageFileReadEnd(g_excel_data);
        }
        else
        {
            parent.ods_ImageFileReadEnd(g_excel_data);
            parent.CloseFileWindow();
            return;
        }
        
        
        CloseOdsBrowser();
    }
    
    function onNormalFileReadEnd(file_name)
    {
        if( window.opener )
        {
            window.opener.ods_NormalFileReadEnd(file_name, g_excel_data);
        }
        else
        {
            parent.ods_NormalFileReadEnd(file_name, g_excel_data);
            parent.CloseFileWindow();
            return;
        }
            
        CloseOdsBrowser();
    }
    
    
    
    function CloseOdsBrowser() {

            if( window.opener )
            {
                if (navigator.appVersion.indexOf("MSIE 6.0") == 0) {
                    window.opener = self;
                    self.close();

                }
                else {
                    window.open('about:blank', '_self').close();

                }
            }
    }
    
    
                
        
        
        function onUpload()
        {
            if( document.file_form.file_data.value == "" )
            {
                alert("파일을 선택해 주세요.");
                return false;
            }
            document.file_form.submit();
        }
    
    </script>
    
    
</head>
<style>
body,html{margin:0;padding:0; overflow: hidden;}
.popWrap{padding:35px 30px; margin-top: 10px;}
.popWrap .tit{margin:0; /*font-size:15px;*/line-height:1;color:#333;font-weight:100;font-size: 13.5px;font-family: "Nanum Gothic",Malgun Gothic, Arial, Helvetica, sans-serif;}
.popUpload{margin:15px 0 0;}
.popUpload .file_input_textbox{margin-right:10px;padding:4px 5px;width: calc(100% - 122px);/*width:300px;*/height:20px; border:1px solid #c4c4c4;border-radius:3px; float:left;}
.popUpload .file_input_div{width:100px;height:30px; position:relative;overflow:hidden;}
.popUpload .file_input_button{}
.popUpload .file_input_hidden{font-size:45px; position:absolute;right:0;top:0;opacity:0;filter:alpha(opacity=0);-ms-filter:"alpha(opacity=0)";-khtml-opacity:0;-moz-opacity:0; height:30px;cursor:pointer;}
.btnBlock{margin:20px 0 0 0;text-align:center;}
.btnType{width:100px;height:30px; font-size:13px;line-height:30px;color:#333;font-weight:bold;text-align:center;text-decoration:none;vertical-align:middle; cursor:pointer; display:inline-block;}
/*.btnType1{border:1px solid #999;border-radius:3px;background-color:#c5c5c5;}*/

.btnType2{border:1px solid #c5c5c5;border-radius:3px;background-color:#eee;font-family: "Nanum Gothic",Malgun Gothic, Arial, Helvetica, sans-serif;font-weight: 100;font-size: 13.5px;line-height: 0px;}

/*.btnType1{margin:0 auto;width:80px;height:35px; font-size:13px;line-height:35px;color:#fff;font-weight:bold;text-align:center;text-decoration:none; background-color:#2776c7; display:block;border-radius: 2px;}*/
.btnType1{font-size: 13.5px;
	font-weight: 100;
    width: 90px;
    max-height: 30px;
    margin: 0px;
    right: auto;
    top: 7px;
    background-color: rgb(0 64 152);
    font-family: "Nanum Gothic",Malgun Gothic, Arial, Helvetica, sans-serif;
    border: none;
    color: #fff;
    min-height: 30px;
*/
</style>

<body onload="javascript:onLoad();">

    <% if (_is_upload_form)
       { %>
       
       
    <form id="file_form" name="file_form" method="post" action="ODS_ServerPage_FileUpload.jsp?mtp=y" enctype="multipart/form-data" >
        <div class="popWrap">
            <p class="tit">업로드할 파일 선택</p>
            <div class="popUpload">
                <input type="text" id="fileName" class="file_input_textbox" readonly="readonly">
                <div class="file_input_div">
                    <input type="button" value="파일 선택" class="btnType btnType2" style="cursor:pointer;"/>
                    <input type="file" name="file_data" <% out.write(_file_fillter); %> class="file_input_hidden" onchange="javascript: document.getElementById('fileName').value = this.value" />
                </div>
                <input type="hidden" name="od" value="<% out.write(_recv_od); %>" />
                <input type="hidden" name="od2" value="up" />
            </div>
            <p class="btnBlock">
                <a class="btnType btnType1" onclick="javascript:onUpload();">업로드</a>
            </p>
        </div>
    </form>
    
    <script>
    
        $(window).load(function() {
            $('.file_input_hidden').click();
        });
    
    </script>
    
    <% } %>
    
    <% out.write(_html_download); %>
    
</body>
</html>