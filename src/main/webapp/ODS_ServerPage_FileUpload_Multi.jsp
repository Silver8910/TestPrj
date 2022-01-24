<%@page import="opendraft.service.gate_web.ODS_ServerPage_FileUpload_impl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>



<%



ODS_ServerPage_FileUpload_impl this_impl = new ODS_ServerPage_FileUpload_impl();
this_impl.Page_Load_Multi( request, response );

String _html_download_script = this_impl._html_download_script;
String _html_download = this_impl._html_download;
String _excel_data = this_impl._excel_data;

boolean _is_upload_form = this_impl._is_upload_form;
String _recv_od = this_impl._recv_od;

String _file_fillter = this_impl._file_fillter;


// ajax form 일때는 내용에 아래 처럼 담아서 내려 보낸다.
if( this_impl._use_ajax_form )
{	
	out.write("  __ods__");
	out.write(_html_download_script);
	out.write("__ods__  ");
}

%>




<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
    
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" language="javascript" src="./ods_web_app/ods_html5.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery.form.js"></script>
    <script language=javascript>

    	
    
        function onLoad() {
        
        <% out.write(_html_download_script); %>
        
        
        var options = {
                beforeSend : function() {
                        $("#progressbox").show();
                        
                        $("#progressbar").width('0%');
                        $("#message").empty();
                        $("#percent").html("0%");

                },
                uploadProgress : function(event, position, total, percentComplete) {
                        $("#progressbar").width(percentComplete + '%');
                        $("#percent").html(percentComplete + '%');

                        
                        if (percentComplete > 50) {
                        $("#message").html("<font color='red'>파일 전송이 진행 중입니다.</font>");
                        }


                },
                success : function() {
                        $("#progressbar").width('100%');
                        $("#percent").html('100%');
                },
                        complete: function (response) {
                            $("#message").html("<font color='blue'>업로드 완료!</font>");

                            // 여기서 값을 뽑아서 보내야 함.
                            var result_str = response.responseText;
                            var arr = result_str.split('__ods__');
                            if (arr.length > 3) {
                                eval(arr[1]);
                            }

                },
                error : function() {
                    $("#message").html("<font color='red'> 에러 파일을 업로드 할 수 없습니다.</font>");
                }
        };
                    $('#ods_multi_file_upload').ajaxForm(options);

        
        }
        
        
        function onMultiUploadResult(file_select_info, error_str)
        {    
            if( file_select_info != "" )
            {
                if( window.opener )
                {
                    window.opener.ods_MultiFileReadEnd(file_select_info);
                }
                else
                {
                    parent.ods_MultiFileReadEnd(file_select_info);
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
        	var select_file_src = document.getElementById("ods_file_select").value;
            if( select_file_src == "" )
            {
                alert("파일을 선택해 주세요.");
                return false;
            }
            //document.getElementById("ods_multi_file_upload").submit();
            $('#file_send_btn').click();
        }
    
    </script>
    
    
</head>


<body onload="javascript:onLoad();">

    <!--  숨겨진 파일 선택 관련 input -->
    <form id="ods_multi_file_upload" name="ods_multi_file_upload" method="post"  action="ODS_ServerPage_FileUpload_Multi.jsp?mtp=y" enctype="multipart/form-data" >
        <input id="ods_file_select" type="file" name="file[]" multiple style="display:none;" <%=_file_fillter%> />
        <input type="hidden" name="od" value="<%=_recv_od%>" />
        <input type="hidden" name="od2" value="up" />
        <input type="hidden" name="use_ajaxform" value="yes" />
        <input id="file_send_btn" type="submit" value="Ajax File Upload" style="display:none;" />
    </form>



<br />
    진행 상황
    <br />
    <div id="progressbox" style="display:none;">
         <div id="progressbar"></div>
         <div id="percent">0%</div>
       </div>
    <div id="message"></div>
    

    <button onclick="javascript:onselectfile();">파일선택</button>
    <button onclick="javascript:onUpload();">업로드</button>
    
    <br /><br />
      선택 목록 표현
    <br />
    <div id="select_file_list" style="height:200px;overflow-y:scroll;">
    </div>
    
    

    <script type="text/javascript">
        function onselectfile() {
            //ods_file_select
            $('#ods_file_select').click();
        }


        $("#ods_file_select").change(function(e) {

        	var html_file_list = "";

            var files_parent = document.getElementById("ods_file_select");
            for (var i = 0; i < files_parent.files.length ; i++) {

                var input_sub = files_parent.files[i];
                //files_parent.files.remove(input_sub);

                //form_send.appendChild(input_sub);

                html_file_list = html_file_list + "<p>";
                    html_file_list = html_file_list + input_sub.name;
                    html_file_list = html_file_list + "</p>";
            }

            document.getElementById("select_file_list").innerHTML = html_file_list;
        });
    </script>
    
</body>
</html>