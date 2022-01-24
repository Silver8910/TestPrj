<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%

// Opendraft Service �ʱ�ȭ
opendraft.service.gate_web.ODWebembedGate gate_impl = new opendraft.service.gate_web.ODWebembedGate();
String map_key_web = gate_impl.GetMapKey();



%>



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="./ods_web_app/jquery/jquery-ui-1.9.1.custom.js"></script>
    
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=HPrq7VD32xI2M4KY3ptD"></script> 
    
    <link rel="stylesheet" type="text/css" href="./odshtml_images/naver_map/css/base.css"/>
    
    <script type="text/javascript" language="javascript">


    
    function OdsFunctionCall(func_name, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
        try {

            
            if (func_name == "show_icon") {
                OdsShowIcon(arg1, arg2, arg3, arg4, arg5);
            }
            else if (func_name == "_set_center") {
                OdsSetCenter(arg1, arg2, Number(arg3));
            }
            else if (func_name == "center") {
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

	

        function OdsShowIcon(lat, lon, id, label, icon_type ) {
			
			/*
			var cityHall = new naver.maps.LatLng(lat, lon);
			var markerOptions = {
				position: cityHall,
				icon: {
					url: './odshtml_images/naver_map/pin_default.png',
					size: new naver.maps.Size(22, 35),
					anchor: new naver.maps.Point(11, 35)
				}
			};
			var marker = new naver.maps.Marker(markerOptions);

			marker.setMap(map); // �߰�
			marker.setMap(null); // ����
            */
            
            
            var marker = new naver.maps.Marker({
				position: new naver.maps.LatLng(lat, lon),
				map: map
			});
        }
        
        
        function OdsSetCenter(lat, lon, level) {
			map = new naver.maps.Map('map', {
				center: new naver.maps.LatLng(lat, lon),
				zoom: 10
			});
			
			/*�Ϲݸ�Ŀ*/
			/*
			marker = new naver.maps.Marker({
				position: new naver.maps.LatLng(lat+0.03, lon),
				map: map
			});
			*/
			
			/*��ũ��Ŀ*/
			var HOME_PATH = "./odshtml_images/naver_map" || '.';

			var pinkMarker = new naver.maps.Marker({
				position: new naver.maps.LatLng(lat, lon),
				map: map,
				icon: {
					content: [
								'<div class="cs_mapbridge">',
									'<div class="map_group _map_group">',
										'<div class="map_marker _marker tvhp tvhp_big">',
											'<span class="ico _icon"></span>',
											'<span class="shd"></span>',
										'</div>',
									'</div>',
								'</div>'
							].join(''),
					size: new naver.maps.Size(38, 58),
					anchor: new naver.maps.Point(19, 58),
				}
			});

			pinkMarker.setTitle('Pink Hot');
			pinkMarker.setDraggable(true);


        }

var map;
var marker;
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
		if( text == "����" )
		{
			//map.panToBounds(jeju);
			
			map.setCenter(jeju);
		}
		else if( text == "����" )
		{
			map.panToBounds(dokdo);
		}
		else if( text == "�λ�" )
		{
			map.panTo(busan);
			
		}
		else if( text == "����" )
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
<div id="map" style="top:0px;width:100%;height:1000px; overflow:hidden;"></div> 

<script> 

$( document ).ready()
{
map = new naver.maps.Map('map', {
        bounds: naver.maps.LatLngBounds.bounds(new naver.maps.LatLng(37.42829747263545, 126.76620435615891),
                                              new naver.maps.LatLng(37.7010174173061, 127.18379493229875)),
                                              
        scaleControl: false,
        logoControl: false,
        mapDataControl: false,
        zoomControl: true,
    });
}

</script> 


</div> 
</body> 
</html>
