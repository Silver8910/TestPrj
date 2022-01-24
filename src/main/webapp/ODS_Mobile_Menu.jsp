<%@page import="opendraft.service.gate_web.jsp_ODS_Mobile_Menu"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%

jsp_ODS_Mobile_Menu this_impl = new jsp_ODS_Mobile_Menu();
this_impl.Page_Load( request, response );

String html_menu = this_impl._html_menu;

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <meta name="viewport" content="width=480px;" />    
    <link rel="stylesheet" type="text/css" href="./odshtml_css/mobile_common.css"/>
    
    
    <script language="javascript">

        function RunMenu(menu_code) {
            //document.location = "./ODS_Mobile_Main.aspx?menu_code=" + menu_code;
            if (parent) {
                var p_data = ['RunMenu', menu_code];
                parent.postMessage(p_data, "*");
            }
        }
        
    
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
    
    
    <%out.write(html_menu);%>
    
</body>
</html>

