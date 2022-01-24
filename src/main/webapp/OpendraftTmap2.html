

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <script type="text/javascript" src="./ods_web_app/jquery_design/jquery-1.8.2.js"></script>
        <title>simpleMap</title>
         <script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=4a3509db-b062-3e7e-8750-14c0b6556fb2"></script>
         <script type="text/javascript" language="javascript">

         //alert("hi~~");

         	var stopCoordList = [];
         	var stopObj = [];
			var Tmap;
         	var map;

    
    function OdsFunctionCall(func_name, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
        try {

            
            if (func_name == "Init") {
                Init();
            }
            else if (func_name == "Set_Center") {
                _set_center(arg1[0]);
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



function _set_center(row)
{
	
	var _lon = parent.WMDA_1.GetFieldData("master_grid", "Lon", row);
	var _lat = parent.WMDA_1.GetFieldData("master_grid", "Lat", row);
	map.setCenter(new Tmap.LonLat(  _lon, _lat), 13);
}

function _set_point(row)
{
	// 마커 1
	var _lon = parent.WMDA_1.GetFieldData("master_grid", "Lon", row);
	var _lat = parent.WMDA_1.GetFieldData("master_grid", "Lat", row);
	
	var _type = parent.WMDA_1.GetFieldData("master_grid", "Portal_gps_tp", row);
	var markers = new Tmap.Layer.Markers( "MarkerLayer1",{name: "gg"} );
	map.addLayer(markers);
	var lonlat = new Tmap.LonLat(_lon, _lat);
	var size = new Tmap.Size(24,38);
	
	var offset = new Tmap.Pixel(-(size.w/2), -size.h);
	var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_'+parseInt(row+1)+'.png', size, offset); 
	var marker1 = new Tmap.Marker(lonlat, icon);
	marker1.name = "marker1";
	markers.addMarker(marker1);

	// 마커1 이벤트 
	//markers.events.on({"click":onRightClick});
	//markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 0, null, null, null, null, null);}});
	
	/*
	markers.events.on({"click":function(){
	
	
		switch(row)
		{
			case 0: 
			case 1:
			case 2:
			case 3:
			case 4:
			case 5:
			default:
				var _display = document.getElementById('lable_div_'+row).style.display
				if( _display == "block" )
					document.getElementById('lable_div_'+row).style.display = 'none';
				else
					document.getElementById('lable_div_'+row).style.display = 'block';
			break;
		}
	}
	})
	*/
	
	


popup = new Tmap.Popup("p"+row,
                        new Tmap.LonLat(_lon, _lat),
                        new Tmap.Size(200, 50),
                        "<div id='lable_div_"+row+"' class='label_div' style=''>"+parent.Form.RES_String('20130513000000000008')+"&nbsp:&nbsp"+parent.Thousand_Commas(parent.WMDA_1.GetFieldData('master_grid', 'Name', row))+"<br>"+parent.Form.RES_String('20100226000000000058')+"&nbsp:&nbsp"+parent.Thousand_Commas(parent.WMDA_1.GetFieldData('master_grid', 'Amt1', row))+"<div>"
                        ); 
map.addPopup(popup);

//popup.hide();

// Event
marker1.events.register("click", popup, onClickMarker);
//marker1.events.register("mouthover", popup, onOverMarker);


}


function onClickMarker (evt){
    if( this.div.style.display == "none" )
		this.show();
	else
		this.hide();	
}

function onOutMarker (evt){
    this.hide();
}
function init() {
        
map = new Tmap.Map({div:'map_div', width:'100%', height:'650px'});

var _lon = parent.WMDA_1.GetFieldData("master_grid", "Lon", 0);
var _lat = parent.WMDA_1.GetFieldData("master_grid", "Lat", 0);

//	map.setCenter(new Tmap.LonLat(14135893.887852,4518348.1852606), 14);


  map.setCenter(new Tmap.LonLat(  _lon+1000, _lat-2500), 13);

var pointList = [];
for( var i = 0 ; i < parent.WMDA_1.GetRowCount("master_grid") ; i++ )
{
//pointList.push(new Tmap.Geometry.Point(parent.WMDA_1.GetFieldData("master_grid", "Lon", i), parent.WMDA_1.GetFieldData("master_grid", "Lat", i)));
}

var lineString = new Tmap.Geometry.LineString(pointList);

var style_bold = {strokeWidth: 4, strokeColor: "#6688ff"};
var mLineFeature = new Tmap.Feature.Vector(lineString, null, style_bold);
 
var vectorLayer = new Tmap.Layer.Vector("vectorLayerID");
map.addLayer(vectorLayer);
 
vectorLayer.addFeatures([mLineFeature]);





for( var i = 0 ; i < parent.WMDA_1.GetRowCount("master_grid") ; i++ )
{
var _lon = parent.WMDA_1.GetFieldData("master_grid", "Lon", i);
var _lat = parent.WMDA_1.GetFieldData("master_grid", "Lat", i);
pointList.push(new Tmap.Geometry.Point(_lon, _lat));
_set_point(i);
}



        }
        
var popup;
var cg = null;



        $(document).ready(function() {
			setTimeout(function(){
            // 하단 메뉴잘림 현상 처리
            $('.gnb > ul > li > a').on('mouseover', function() {})
            
            }, 1000)
        
        
        })


        </script>

    <style type="text/css">
		.label_div{
	
    width: 200px;
    height: 50px;
    position: absolute;
    z-index: 999;
    background: #fff;
    border: 1px solid #888;
    font-size:14px
    }
    </style>
    
    </head>


    <body onload="init()">
        <div style="width:100%; height:100%">
            <div id="map_div"></div>
         </div>
		<div id='label_area'>
            
         </div>
    </body>
</html>
