<%@page import="opendraft.service.gate_web.jsp_ODS_ServerPage_Run"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"></html>
<%
String SiteID = request.getParameter("SiteID");
String FileNm = request.getParameter("FileNm");
String ImgURL = request.getParameter("ImgURL");
String BackColor = request.getParameter("BackColor");
String CallCtrl = request.getParameter("CallCtrl");
String ImgNm = ImgURL.substring(ImgURL.lastIndexOf("/")+1);
%>

<head>
    <script type="text/javascript">
        

        // ods의 map컨트롤에서 함수 호출 하면 불리는 함수.
        function OdsFunctionCall(func_name, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
            try {

                
                if (func_name == "show_img") {
                    document.getElementById("img_show").src = arg1;
                }


            }
            catch (e) {
                alert(e);
            }
        }



        // 현재 페이지에서 map 컨트롤의 이벤트를 발생 시키는 함수.
        function OdsMapEvent(event_name, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
            
            try {

                if (parent && eval("typeof parent.OdsMapEventImpl == 'function'")) {
                    parent.OdsMapEventImpl(event_name, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
                }
                else {
                    // external
                    if (window.external) {
                        window.external.OdsMapEvent(event_name, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
                    }

                }
            } catch (e) {
            alert(e);
            }
        }


        function ImageClicked()
        {
            OdsMapEvent("img_clicked", "<%=CallCtrl%>", "", "", "", "", "", "" );
        }
    </script>
</head>

<html>
    <body style="margin:0px; overflow-y: hidden; background-color: <%=BackColor%>;">
        <!--<img id="img_show" src="./file_storage/pland/Site/<%=SiteID%>/<%=FileNm%>" style="width: 100%; height: 100%;" onclick="ImageClicked();"/>-->
        <img id="img_show" src="<%=ImgURL%>" style="width: 100%; height: 100%;" onclick="ImageClicked();"/>
    </body>
</html>