<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">




<html xmlns="http://www.w3.org/1999/xhtml">

<%

String _lang_id = "ko";
%>






<style>

#tracebtn {
    background-color: white;
    border: 1px solid #3c8dbc;
    color: #3c8dbc;
    width: 100px;
    height: 25px;
    cursor: pointer;
    float: right;
}

#tracebtn:hover {
    background-color: #3c8dbc;
    color:white;
}

.ods_widget_design_tab_head_select {
    height: 30px !important;
    background-color: #3c8dbc!important;
    color: white !important;
    border: none !important;
    font-weight: bold !important;
    background-image: url(./odshtml_images/ctrl_tab/tap_icon.png) !important;
    background-repeat: no-repeat !important;
    background-position: 90% !important;
    border-radius: 0px !important;
}

#combo_sub_table {
    width: 150px;
	height: 25px;
    border: 1px solid #bebebe;
    font-family: inherit;
    background: url(./odshtml_images/ctrl_select/select_nor.png) no-repeat 95% 50%;
    border-radius: 0px;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
	background-position: right;
	text-indent: 10px;
}

</style>







<head>
    <title>Opendraft Data Trace</title>
    <script type="text/javascript" language="javascript" src="./ods_web_app/ods_string_<%out.write(_lang_id);%>.js"></script>
    
    <link rel="stylesheet" href="./ods_web_app/jquery/redmond/jquery-ui-1.9.1.custom.css" />
    
    
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-ui-1.9.1.custom.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery.multicolselect.js"></script>   
         
    
    
    <script src="./ods_web_app/jqgrid_4.5.2/js/i18n/grid.locale-kr.js" type="text/javascript"></script>    
    <script src="./ods_web_app/jqgrid_4.5.2/plugins/jquery.contextmenu.js" type="text/javascript"></script>
    
    
    
    
    
    <script src="./ods_web_app/jquery/jquery.alerts.js" type="text/javascript"></script>
	<link href="./ods_web_app/jquery/jquery.alerts.css" rel="stylesheet" type="text/css" media="screen" />
	
	  
    <script type="text/javascript" language="javascript" src="./ods_web_app/ods_html5.js"></script>
    
    
    
    <link rel="stylesheet" type="text/css" href="./odshtml_css/ods_serverpage_common.css"/>
    <link rel="stylesheet" type="text/css" href="./ImageServer/KO/ods_thema_2/opendraft_style_auto.css" />
    
    



    <script type="text/javascript">

        var Form = new ods_form_base_Form("user1", "ko", "menu001", "form001", 640, 480, 30, false);
        var g_trace = null;
        function OnLoad() {
            g_trace = new wnd_debug_comm_trace();
            g_trace.InitPage();

            if (opener)
                opener.ods_debug_comm_trace._wnd_comm_trace = g_trace;


            OnResize();
        }

        function OnResize() {
            if (g_trace == null)
                return;

            g_trace.OnResize();
        }


        function OnUnload() {
            if (opener)
                opener.ods_debug_comm_trace._wnd_comm_trace = null;
        }
    </script>


    
</head>



<body onload="javascript:OnLoad();" onbeforeunload="javascript:OnUnload();" onresize="javascript:OnResize();" >
	<div style="font-size: 30px; font-weight: bold; color: #3c8dbc; padding: 5px 10px;">Data Trace</div>
    <!-- left list -->
    <div id="id_btn_clear_all" style="position:absolute; left:4px; top:30px; width:300px; height:30px; ">
        <button id="tracebtn" onclick="OdsDebugTraceAllClear();">Clear</button>
    </div>
    <div style="position:absolute; left:4px; top:60px; width:300px; bottom:4px; ">
        <div id="ods_grid_main" style="position:absolute; left:0px; top:0px; right:0px; bottom:0px;">
            <canvas id="inst_grid_main" style="position:absolute; left:0px; top:0px; right:0px; bottom:0px;">
            </canvas>
        </div>
    </div>


    

    <div id="id_split_vertical" class="split_cero" style="position:absolute; top:0px; bottom:0px; left:10px; z-index:999;">
        
            </div>


    <!-- tab -->
    <div id="id_debug_tab_frame" style="position:absolute; left:310px; top:30px; right:4px; bottom:4px;">
        <!-- tab head-->
        <div style="position:absolute; left:0px; top:0px; right:0px; height:30px; border-bottom: 1px solid #ededed; ">
            <table>
                <tr>
                    <td id="id_btn_trace" class="ods_widget_design_tab_head_select">Trace</td>
                    <td id="id_btn_data" class="ods_widget_design_tab_head_normal">Data</td>
                    <td id="id_btn_detail" class="ods_widget_design_tab_head_normal">Detail</td>
                </tr>
            </table>
            <!--
            <button id="id_btn_trace">Trace</button>
            <button id="id_btn_data">Data</button>
            <button id="id_btn_detail">Detail</button>
            -->
        </div>


        <!-- tab content-->
        <div id="debug_tab_content" style="position:absolute; left:0px; top:30px; right:0px; bottom:0px;">

            <!-- trace-->
            <div  id="frame_trace"  style="position:absolute; left:0px; top:0px; right:0px; bottom:0px;">
                <div id="ods_grid_trace" style="position:absolute; left:0px; top:0px; right:0px; bottom:0px;">
                    <canvas id="inst_grid_trace" style="position:absolute; left:0px; top:0px; right:0px; bottom:0px;">                    
                    </canvas>
                </div>
            </div>


            <!-- data-->
            <div id="frame_data"   style="position:absolute; left:0px; top:0px; right:0px; bottom:0px; display:none;">

                <div style="position:absolute; left:0px; top:6px; right:0px; height:30px;">
                    Sub table : <select id="combo_sub_table" onchange="javascript:OdsDebug_SubtableSelectChanged()">
                    </select>
                </div>

                <div id="ods_grid_data" style="position:absolute; left:0px; top:36px; right:0px; bottom:0px;">
                    <canvas id="inst_grid_data" style="position:absolute; left:0px; top:0px; right:0px; bottom:210px;">                    
                    </canvas>
                </div>

                <div id="ods_grid_trace_sub" style="position:absolute; left:0px; right:0px; bottom:0px; height:200px;">
                    <canvas id="inst_grid_trace_sub" style="position:absolute; left:0px; right:0px; bottom:0px; height:200px;">
                    </canvas>
                </div>
            </div>


            <!-- detail-->
            <div id="frame_detail"  style="position:absolute; left:0px; top:0px; right:0px; bottom:0px; display:none;">
                <div style="position:absolute; left:0px; top:0px; right:0px; height:390px;">
                    <textarea id="query_edit" style="position:absolute; left:0px; top:0px; right:0px; height:390px; width:100%;     border: 1px solid lightgray;">

                    </textarea>
                </div>


                <div id="ods_grid_param" style="position:absolute; left:0px; top:400px; right:0px; bottom:0px;">
                    <canvas id="inst_grid_param" style="position:absolute; left:0px; top:0px; right:0px; bottom:0px;">                    
                    </canvas>
                </div>
            </div>

        </div>
    </div>

</body>
</html>
