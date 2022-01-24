<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%

// Opendraft Service 초기화
opendraft.service.gate_web.ODWebembedGate gate_impl = new opendraft.service.gate_web.ODWebembedGate();
String map_key_web = gate_impl.GetMapKey();



%>



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-ui-1.9.1.custom.js"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=HPrq7VD32xI2M4KY3ptD"></script> 
    
    <script type="text/javascript" language="javascript">


    
    function OdsFunctionCall(func_name, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
        try {

            
            if (func_name == "show_icon") {
                OdsShowIcon(arg1, arg2, arg3, arg4, arg5);
            }
            else if (func_name == "_set_center") {
                OdsSetCenter(arg1, arg2, Number(arg3));
            }
            else if (func_name == "_set_center_text") {
                OdsSetCenterText(arg1, arg2, Number(arg3));
            }
            else if (func_name.toLowerCase() == "addresstolatlng") {
                AddressToLatLng(arg1);
            }
            else if (func_name.toLowerCase() == "latlngtoaddress") {
                LatLngToAddress(arg1, arg2);
            }


        }
        catch (e) {
            alert(e);
        }
    }


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
    
    function OdsSetCenterText(text)
    {
		//e.preventDefault();
		if( text == "제주" )
		{
			//map.panToBounds(jeju);
			
			map.setCenter(jeju);
		}
		else if( text == "독도" )
		{
			map.panToBounds(dokdo);
		}
		else if( text == "부산" )
		{
			map.panTo(busan);
			
		}
		else if( text == "서울" )
		{
			map.panToBounds(seoul);
		}
    }
        
        

    var jeju = new naver.maps.LatLng(33.3590628, 126.534361),
    busan = new naver.maps.LatLng(35.1797865, 129.0750194),
    dokdo = new naver.maps.LatLngBounds(
                new naver.maps.LatLng(37.2380651, 131.8562652),
                new naver.maps.LatLng(37.2444436, 131.8786475)),
    seoul = new naver.maps.LatLngBounds(
                new naver.maps.LatLng(37.42829747263545, 126.76620435615891),
                new naver.maps.LatLng(37.7010174173061, 127.18379493229875));

        




    </script>
</head>

<body style=" overflow:hidden;"> 
<div id="map" style="top:0px;width:100%;height:800px; overflow:hidden;"></div> 

<script> 

$( document ).ready()
{
var map = new naver.maps.Map('map', {
    center: new naver.maps.LatLng(37.5666805, 126.9784147),
    zoom: 4
});

}
</script> 


</div> 
</body> 
</html>
