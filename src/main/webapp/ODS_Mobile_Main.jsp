<%@page import="java.util.ArrayList"%>
<%@page import="opendraft.service.ods_server_page.run_session.menu_session.MenuInfoShare"%>
<%@page import="opendraft.lang.StringBuilder2"%>
<%@page import="opendraft.service.gate_web.jsp_ODS_Mobile_Menu"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%


jsp_ODS_Mobile_Menu this_impl = new jsp_ODS_Mobile_Menu();
this_impl.Page_Load( request, response );

//String html_menu = this_impl._html_menu;



//===================================================================
// 외부 메뉴를 사용 한다고 하면 아래의 내용을 참조 합니다.

//MakeMenuHtml_Full 대신 GetCurrentMenuList를 호출해서 메뉴 구조를 구해 올 수 있습니다.
//MenuInfoShare 내부에는 _list_child라는 멤버가 있어서 tree형태로 구성 됩니다.
ArrayList<opendraft.service.ods_server_page.run_session.menu_session.MenuInfoShare> list_menu = this_impl.GetCurrentMenuList();
StringBuilder2 sb = new StringBuilder2();
for( opendraft.service.ods_server_page.run_session.menu_session.MenuInfoShare ms : list_menu )
{
    sb.AppendLine(
        String.format("<a href=\"javascript:RunMenu('%s');\"> %s </a> <br />", 
        ms._menu_id, ms._menu_label_val));
    sb.AppendLine("<br />");
}





//===================================================================
// 외부 메뉴를 사용 한다고 하면 아래의 내용을 참조 합니다.

//MakeMenuHtml_Full 대신 GetCurrentMenuList를 호출해서 메뉴 구조를 구해 올 수 있습니다.
//MenuInfoShare 내부에는 _list_child라는 멤버가 있어서 tree형태로 구성 됩니다.
//java.util.ArrayList<MenuInfoShare> list_menu =
//	this_impl.GetCurrentMenuList();

//===================================================================

String _layout = "";

class MenuBuilder 
{
	String _layout = "";
	public MenuBuilder(String layout)
	{
		_layout = layout;
	}
	
	public void MakeNewMenu( java.util.ArrayList<MenuInfoShare> list_menu, StringBuilder2 sb_menu, StringBuilder2 sb_auto, StringBuilder2 sb_menu_sub1, StringBuilder2 sb_menu_sub2, StringBuilder2 sb_menu_sub3  )
	{
		
		//<!-- 레이아웃 형태에 따라 expanded / collapsed / horizontal 클래스 변경 -->


		sb_menu.AppendLine("        ");
		sb_menu_sub1.AppendLine("        ");

		int show_count = 0;

		for (MenuInfoShare menu_info : list_menu)
		{
			//int max_depth = 1;
			ArrayList<Integer> max_depth_arr = new ArrayList<Integer>();
			max_depth_arr.add( 0 );
			
			Make_NewMenu_Is_MaxDepth(menu_info, max_depth_arr, 1);

				Make_NewMenu_Impl(sb_menu, menu_info, sb_menu_sub1);

			show_count++;
			if (_layout.compareTo( "horizontal") == 0 && show_count > 15)
				break;
			
		}
	}


	private void Make_NewMenu_Is_MaxDepth(MenuInfoShare menu_info, ArrayList<Integer> max_depth_arr, int depth)
	{
		if( depth > max_depth_arr.get(0) )
			max_depth_arr.set(0,  depth );

		for (MenuInfoShare menu_child : menu_info._list_child)
		{
			if( menu_child._list_child.size() > 0 )
				Make_NewMenu_Is_MaxDepth(menu_child, max_depth_arr, depth+1);
		}
	}


	private void Make_NewMenu_Impl(StringBuilder2 sb_menu, MenuInfoShare menu_info, StringBuilder2 sb_menu_sub1)
	{
		
		//{ value: "BAB020E", label: "공통코드관리", parent_label: "운영관리" }
		if (menu_info._list_child.size() <= 0   )
		{ 
//                sb_menu.AppendLine(String.format("<li><a href='javascript:RunMenu(\"%s\", \"%s\");'><span class='nav-label'>%s</span><span class='labellabel-success pull-right'>N</span></a></li>", 
//                		menu_info._menu_id, menu_info._menu_label_val, menu_info._menu_label_val));
			sb_menu.AppendLine(String.format("<li class='tree_last'><a href=\"javascript:RunMenu('%s'); \" onclick=\"javascript:RunMenu('%s');\"><img src='mobile/images/menu_icon/%s.png' alt=''>%s</a></li>", menu_info._menu_id, menu_info._menu_id, Make_NewMenu_GetMenuIcon(menu_info._menu_id), menu_info._menu_label_val));

			sb_menu_sub1.AppendLine(String.format("<li class='tree_last'><a href=\"javascript:RunMenu('%s'); \" onclick=\"javascript:RunMenu('%s');\">%s</a></li>", 
				menu_info._menu_id, menu_info._menu_id, menu_info._menu_label_val));
		}
		else
		{

			sb_menu_sub1.AppendLine(String.format(
"<li class='tree_last'><a href=\"#\">%s</a><ul data-role='ui-gnb-dep2' class = 'bottom_set'>", menu_info._menu_label_val));

			for (MenuInfoShare menu_child : menu_info._list_child)
			{
				if( menu_child._list_child.size() > 0 )
				{
					sb_menu_sub1.AppendLine(String.format("<li class='tree_last' chk='child'><a href='#'>%s</a>",menu_child._menu_label_val));
					sb_menu_sub1.AppendLine(String.format("<ul data-role='ui-gnb-dep3'>"));

					 for (MenuInfoShare menu_child2 : menu_child._list_child)
					 {
                           if( menu_child2._list_child.size() > 0 )
                           {
                                sb_menu_sub1.AppendLine(String.format("<li class='tree_last'><a href='#'>%s</a>",menu_child2._menu_label_val));
                                sb_menu_sub1.AppendLine(String.format("<ul data-role='ui-gnb-dep3'>"));

                                for (MenuInfoShare menu_child3 : menu_child2._list_child)
                                {


                                        sb_menu.AppendLine(String.format("<li class='tree_last'><a href='javascript:RunMenu(\"%s\");' onclick='javascript:RunMenu(\"%s\");'><img src='mobile/images/menu_icon/%s.png' alt=''>%s</a></li>", 
                                            menu_child3._menu_id, menu_child3._menu_id, Make_NewMenu_GetMenuIcon(menu_child3._menu_id), menu_child3._menu_label_val));

                                        // 4레벨 추후작업
                                        sb_menu_sub1.AppendLine(String.format( "<li class='tree_last'><a href='javascript:RunMenu(\"%s\");' onclick='javascript:RunMenu(\"%s\");'>%s</a></li>", menu_child3._menu_id, menu_child3._menu_id, menu_child3._menu_label_val) );

                                }

                                sb_menu.AppendLine( "</ul>" );
                                sb_menu_sub1.AppendLine( "</ul>" );
                                sb_menu_sub1.AppendLine( "</li>" );
                               
                           }
                           else
                           {
                                sb_menu.AppendLine(String.format("<li class='tree_last'><a href='javascript:RunMenu(\"%s\");' onclick='javascript:RunMenu(\"%s\");'><img src='mobile/images/menu_icon/%s.png' alt=''>%s</a></li>", 
                                    menu_child2._menu_id, menu_child2._menu_id, Make_NewMenu_GetMenuIcon(menu_child2._menu_id), menu_child2._menu_label_val));

                                // 4레벨 추후작업
                                sb_menu_sub1.AppendLine(String.format( "<li class='tree_last'><a href='javascript:RunMenu(\"%s\");' onclick='javascript:RunMenu(\"%s\");'>%s</a></li>", menu_child2._menu_id, menu_child2._menu_id, menu_child2._menu_label_val) );
                           }

					 }
					 sb_menu.AppendLine( "</ul>" );
                     sb_menu_sub1.AppendLine( "</ul>" );
					 sb_menu_sub1.AppendLine( "</li>" );
					 

				}
				else
				{
					
					sb_menu.AppendLine(String.format("<li class='tree_last'><a href='javascript:RunMenu(\"%s\");' onclick='javascript:RunMenu(\"%s\");'><img src='mobile/images/menu_icon/%s.png' alt=''>%s</a></li>", 
							menu_child._menu_id, menu_child._menu_id, Make_NewMenu_GetMenuIcon(menu_child._menu_id), menu_child._menu_label_val));

					sb_menu_sub1.AppendLine(String.format("<li class='tree_last'><a href='javascript:RunMenu(\"%s\");' onclick='javascript:RunMenu(\"%s\");'>%s</a></li>", 
							menu_child._menu_id, menu_child._menu_id, menu_child._menu_label_val));
					
				}
					 

			}
					 sb_menu.AppendLine( "</ul>" );
                     sb_menu_sub1.AppendLine( "</ul>" );
					 sb_menu_sub1.AppendLine( "</li>" );
		}
		
	}


        private String Make_NewMenu_GetMenuIcon(String menu_id)
        {

            if (menu_id.compareToIgnoreCase("TESTPOPUP11") == 0 )
            {
                return "topmenu03";
            }
            else if (menu_id.compareToIgnoreCase("TESTPOPUP21") == 0)
            {
                return "topmenu01";
            }            
            else if (menu_id.compareToIgnoreCase("TESTPOPUP11") == 0)
            {
                return "topmenu02";
            }
            else if (menu_id.compareToIgnoreCase("TESTPOPUP12") == 0)
            {
                return "topmenu04";
            }

            return "ico_nav01";

        }
}


String _html_menu = "";
String _html_menu_sub1 = "";
String _html_menu_sub2 = "";
String _html_menu_sub3 = "";

String _menu_auto_completion = "";

MenuBuilder mb = new MenuBuilder( _layout );
StringBuilder2 sb_menu =new StringBuilder2();
StringBuilder2 sb_auto =new StringBuilder2();
StringBuilder2 sb_menu_sub1 =new StringBuilder2();
StringBuilder2 sb_menu_sub2 =new StringBuilder2();
StringBuilder2 sb_menu_sub3 =new StringBuilder2();

mb.MakeNewMenu( list_menu, sb_menu, sb_auto, sb_menu_sub1, sb_menu_sub2, sb_menu_sub3);

_html_menu = sb_menu.ToString();
_html_menu_sub1 = sb_menu_sub1.ToString();
_html_menu_sub2 = sb_menu_sub2.ToString();
_html_menu_sub3 = sb_menu_sub3.ToString();
_menu_auto_completion = sb_auto.ToString();

if( _menu_auto_completion.length() > 0 )
{
	_menu_auto_completion = _menu_auto_completion.substring(0, _menu_auto_completion.length()-1); 
}


















%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<!--<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />-->
	
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta http-equiv="imagetoolbar" content="no" />
		<!--<meta name="viewport" content="width=device-width">-->
		<meta name="viewport" content="width=480" />
		<meta name="format-detection" content="telephone=no, address=no, email=no" />
		<title>OpenDraft_mobile</title>
		<link rel="stylesheet" type="text/css" href="./mobile/css/ods.css" />
		<!--<script type="text/javascript" src="./mobile/js/libs/jquery-1.11.3.min.js"></script>-->
		 <script type="text/javascript" src="./ods_web_app/jquery_design/jquery-1.8.2.js"></script>
		<script type="text/javascript" src="./mobile/js/libs/jquery.bpopup.min.js"></script>
		<!-- <script type="text/javascript" src="./mobile/js/front_ui.js"></script> -->

        <link rel="stylesheet" type="text/css" href="mobile/css/default.css">
        <link rel="stylesheet" type="text/css" href="mobile/css/style2.css">
        
        <script type="text/javascript" src="mobile/js/default2.js"></script>
        <script type="text/javascript" src="ods_web_app/jquery_design/jquery.yakutree.js"></script>
		
	    <style type="text/css">
			/*html,body, #outer, .innerPages {height:100%; padding:0px; width:100%;  margin:0; }*/
		</style>
    
    
    <style type="text/css">
    
        html,body, #outer, .innerPages {height:100%; padding:0px; width:100%;  margin:0; }
    
    </style>
        <script language="javascript">
        function RunMenu(menu_code) {
            //document.location = "./ODS_Mobile_Main.aspx?menu_code=" + menu_code;
            if (parent) {
                var p_data = ['RunMenu', menu_code];
                parent.postMessage(p_data, "*");
            }
        }
        function onLoad() {

            onResize_Impl();
            
        }

        function onResize_Impl() {
            //var height_total = document.documentElement.clientHeight;
            //var width_total = document.documentElement.clientWidth;

            var width_total = window.innerWidth;
            var height_total = window.innerHeight;


            var run_div = document.getElementById("run_div");
            if (run_div != null) {
                document.getElementById("run_div").style.height = height_total - 100;
                document.getElementById("run_div").style.width = width_total;
                //document.getElementById("run_tar").style.width = width_total;
            }

            var iframe = document.getElementById("run_tar");
            if (iframe != null) {
                iframe.width = width_total;
                iframe.height = height_total - 100;
            }
        }


        function OnMessageReceive(e) {

            if (event.data.length > 1) {
                if (event.data[0] == "RunMenu") {
                    //alert(event.data[1] );
                    OnMenuShowImpl(false);
                    document.location = "./ODS_Mobile_Run.jsp?menu_code=" + event.data[1];
                }
            }

            //var p_data = ['ods_parent_call', this._menu_id, event_name, param1, param2, param3, param4, param5];
        }
        window.addEventListener("message", OnMessageReceive, false);


        function OnMenuShow() {
            var ele_menu = document.getElementById('ods_mobile_menu');
            if (ele_menu == null)
                return;

            if (ele_menu.style.display == "none")
                OnMenuShowImpl(true);
            else
                OnMenuShowImpl(false);

        }

        function OnMenuShowImpl(show) {
            var ele_menu = document.getElementById('ods_mobile_menu');
            if (ele_menu == null)
                return;

            if (show) {
                ele_menu.style.display = "block";
            }
            else {
                ele_menu.style.display = "none";
            }
        }
        
    
    </script>
    
    
</head>

	<body onload="javascript:onLoad();" onresize="onResize_Impl()">
    


<header>
	<!-- <h1><a href="#a"><img src="mobile/images/h1_logo2.png" alt="BOKSANONICE" style="width: 150px; height:25px; top: 20px; position: relative;left:-8px;"></a></h1> -->
	<h1><a href="#a"><img src="mobile/images/opendraft_white.png" alt="BOKSANONICE" style="width:240px;height:55px;top:0px;position:relative;"></a></h1>
    <p><a href="#a" class="btn_nav"><img src="mobile/images/btn_nav.png" alt="메뉴"></a></p>
</header>
<main>
    <section class="main_nav">
    	<nav>
        	<ul>
            <!--<li class="on"><a href="#a"><img src="mobile/images/ico_nav1.png" alt="">주문입력</a></li>
            <li><a href="#a"><img src="mobile/images/ico_nav2.png" alt="">매출내역조회</a></li>
            <li><a href="#a"><img src="mobile/images/ico_nav3.png" alt="">매출원장</a></li>
            <li><a href="#a"><img src="mobile/images/ico_nav4.png" alt="">거래처잔고내역서</a></li>-->
    <%out.write(_html_menu);%>
            </ul>
                
        </nav>
    </section>
</main>
<div class="nav" style="display: none;">
    <ul id="sdk">
    <!--
    <li><button type="button" class="toggle plus">+</button><a href="#a" class="selected">작업지시 및 조정</a>
        <ul style="display: none;">
        <li><button type="button" class="toggle plus">+</button><a href="#a">작업지시 및 조정</a>
            <ul style="display: none;">
            <li class="tree_last"><button type="button" class="toggle plus">+</button><a href="#a">작업지시 및 조정</a>
                <ul style="display: none;">
                <li class="tree_last"><a href="#a">작업지시 및 조정</a></li>
                </ul>
            </li>
            </ul>
        </li>
        <li class="tree_last"><a href="#a">작업지시 및 조정</a></li>
        </ul>
    </li>
    <li><a href="#a">123</a></li>
    <li><a href="#a">작업지시 및 조정</a></li>
    <li><a href="#a">작업지시 및 조정</a></li>
    <li><a href="#a">작업지시 및 조정</a></li>
    <li class="tree_last"><a href="#a">작업지시 및 조정</a></li>
    -->
    <%out.write(_html_menu_sub1);%>
    </ul>
    <script type="text/javascript">
    // <![CDATA[
    
    $(function(){
        $("#sdk, #sdk2").yakutree({
            unique: false,
            animate: true,
            duration: 100 ,
            aTagClick : true ,
            btnAllExpand : '.expend',
            btnAllColspand : '.colspend',
            btnFirst : '.btnFirst',
            btnLast : '.btnLast',
            btnUp : '.btnUp',
            btnDown : '.btnDown',
            btnAdd : '.btnAdd',
            btnDel : '.btnDel',
            dragndrop : false,
            btnCallback : function ( type, $source, $target) {
                switch( type ) {
                    case 'moveUp':
                        //this.moveAnimation(  $source, $target, 'revert' );
                        break;
                }
            }
        });
    });
    
    // ]]>
    </script>
</div>


	</body>
<address>Copyrights OpenDraft 2017. All Right Reserved.</address>
</html>

