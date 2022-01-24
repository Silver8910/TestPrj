<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.URLDecoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%

// Opendraft Service ÃÊ±âÈ­
opendraft.service.gate_web.ODWebembedGate gate_impl = new opendraft.service.gate_web.ODWebembedGate();
String map_key_web = gate_impl.GetMapKey();

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>simpleMap</title>
         <script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=4a3509db-b062-3e7e-8750-14c0b6556fb2"></script>
         <script type="text/javascript" language="javascript">

         //alert("hi~~");

         	var stopCoordList = [];
         	var stopObj = [];

         	var map;

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




        function init() {
        
 map = new Tmap.Map({div:'map_div', width:'100%', height:'650px'});

var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 3);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 3);
//	map.setCenter(new Tmap.LonLat(14135893.887852,4518348.1852606), 14);
  map.setCenter(new Tmap.LonLat(  _lon, _lat), 13);

var pointList = [];
for( var i = 0 ; i < parent.WGSheet_4.GetRowCount() ; i++ )
{
pointList.push(new Tmap.Geometry.Point(parent.WGSheet_4.GetGridCellText("Portal_lon", i), parent.WGSheet_4.GetGridCellText("Portal_lat", i)));
}

var lineString = new Tmap.Geometry.LineString(pointList);

var style_bold = {strokeWidth: 4, strokeColor: "#6688ff"};
var mLineFeature = new Tmap.Feature.Vector(lineString, null, style_bold);
 
var vectorLayer = new Tmap.Layer.Vector("vectorLayerID");
map.addLayer(vectorLayer);
 
vectorLayer.addFeatures([mLineFeature]);






for( var i = 0 ; i < parent.WGSheet_4.GetRowCount() ; i++ )
{
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", i);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", i);
pointList.push(new Tmap.Geometry.Point(_lon, _lat));
}




// 마커 1
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 0);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 0);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 0);
var markers = new Tmap.Layer.Markers( "MarkerLayer1",{name: "gg"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon);
marker1.name = "marker1";
markers.addMarker(marker1);

// 마커1 이벤트 
//markers.events.on({"click":onRightClick});
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 0, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 0, null, null, null, null, null);}});




// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 1);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 1);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 1);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 1, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 1, null, null, null, null, null);}});
 






// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 3);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 3);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 3);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 2, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 2, null, null, null, null, null);}});
 






// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 6);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 6);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 6);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 3, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 3, null, null, null, null, null);}});
 






// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 7);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 7);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 7);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 4, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 4, null, null, null, null, null);}});
 






// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 10);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 10);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 10);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 5, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 5, null, null, null, null, null);}});
 






// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 12);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 12);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 12);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 6, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 6, null, null, null, null, null);}});
 






// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 13);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 13);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 13);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 7, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 7, null, null, null, null, null);}});
 






// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 14);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 14);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 14);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 8, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 8, null, null, null, null, null);}});
 






// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 16);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 16);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 16);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 9, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 9, null, null, null, null, null);}});
 






// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 17);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 17);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 17);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('./odshtml_images/tmap/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 10, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 10, null, null, null, null, null);}});
 






// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 19);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 19);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 19);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('./odshtml_images/tmap/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 11, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 11, null, null, null, null, null);}});
 



 


// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 21);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 21);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 21);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('./odshtml_images/tmap/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 12, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 12, null, null, null, null, null);}});
 

// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 22);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 22);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 22);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('./odshtml_images/tmap/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 13, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 13, null, null, null, null, null);}});
 
 
// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 23);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 23);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 23);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('./odshtml_images/tmap/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 14, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 14, null, null, null, null, null);}});
 
 
// 마커 2
var _lon = parent.WGSheet_4.GetGridCellText("Portal_lon", 24);
var _lat = parent.WGSheet_4.GetGridCellText("Portal_lat", 24);
var _type = parent.WGSheet_4.GetGridCellText("Portal_gps_tp", 24);
var markers = new Tmap.Layer.Markers( "MarkerLayer2",{name: "hh"} );
map.addLayer(markers);
var lonlat = new Tmap.LonLat(_lon, _lat);
var size = new Tmap.Size(24,38);
var offset = new Tmap.Pixel(-(size.w/2), -size.h);
var icon = new Tmap.Icon('./odshtml_images/tmap/pin_b_m_'+_type+'.png', size, offset); 
var marker1 = new Tmap.Marker(lonlat, icon); 
markers.addMarker(marker1);


// 마커2 이벤트 
marker1.name = "marker2";
markers.events.on({"click":function(){OdsMapEvent('markerClick', marker1.name, 15, null, null, null, null, null);}});
markers.events.on({"touchstart":function(){OdsMapEvent('markerClick', marker1.name, 15, null, null, null, null, null);}});
 









        }
var cg = null;
	function onRightClick(evt){
		cg=evt;
		alert(evt.name);
     if(evt.button==2 || evt.button==3){
        showMenu(evt);
     }
}
    function onOverMarker (evt){
        this.show();
    }

    function onOutMarker (evt){
        this.hide();
    }


    function vFnOnDrawnFeatures(e) {


        map.zoomToExtent(this.getDataExtent());
    }


    function vFnArvRoute() {

        var arvNum =0;
        var avrList = [];
        var avrUrlStr = [];
        var startArvX = [];
        var startArvY = [];
        var endArvX = [];
        var endArvY = [];
        var arvPassList = [];
        var arvPrtcl = [];
        var arvRouteLayer = [];
        var routeFormat = new Tmap.Format.KML({extractStyles:false});
        var arvStylemap = new Tmap.StyleMap({
            'default': new Tmap.Style({
                pointRadius: 0,
                fillOpacity: 3,
                strokeColor: "#0000ff",
                strokeWidth: 4,
                strokeOpacity: 4,
                graphicZIndex: 1
            })
        });



        for(var i =0; i<stopObj.length;i++){
            if(i%6 == 0){
                if(i == 0){
                    startArvX[arvNum] = stopObj[i].lon;
                    startArvY[arvNum] = stopObj[i].lat;
                    arvNum += 1;

                }else if(i != 0){
                    if(stopObj[i+1]!=null){
                        startArvX[arvNum] = stopObj[i].lon;
                        startArvY[arvNum] = stopObj[i].lat;
                        endArvX[arvNum-1] = stopObj[i].lon;
                        endArvY[arvNum-1] = stopObj[i].lat;
                        arvNum +=1;
                    }else if(stopObj[i+1]==null){
                        endArvX[arvNum-1] = stopObj[i].lon;
                        endArvY[arvNum-1] = stopObj[i].lat;
                    }
                }
            }else if(i%6 != 0){
                if(stopObj[i+1]==null){
                    endArvX[arvNum-1] = stopObj[i].lon;
                    endArvY[arvNum-1] = stopObj[i].lat;
                }else if((i+1)%6==0 ||(stopObj[i+1]!= null && stopObj[i+2] ==null)){
                    if(arvPassList[arvNum-1]==null){
                        arvPassList[arvNum-1] = stopObj[i].lon+','+stopObj[i].lat+',0,G,0';
                    }else{
                        arvPassList[arvNum-1] += stopObj[i].lon+','+stopObj[i].lat+',0,G,0';
                    }
                }else if((i+1)%6!=0 && stopObj[i+2]!= null){
                    if(arvPassList[arvNum-1]==null){
                        arvPassList[arvNum-1] = stopObj[i].lon+','+stopObj[i].lat+',0,G,0'+'_';
                    }else{
                        arvPassList[arvNum-1] += stopObj[i].lon+','+stopObj[i].lat+',0,G,0'+'_';
                    }
                }
            }

        }
        for(var i = 0; i < arvNum; i ++){
            avrUrlStr[i] = "https://apis.skplanetx.com/tmap/routes?version=1&format=xml";
            avrUrlStr[i] += "&startX="+startArvX[i];
            avrUrlStr[i] += "&startY="+startArvY[i];
            avrUrlStr[i] += "&endX="+endArvX[i];
            avrUrlStr[i] += "&endY="+endArvY[i];
            if(arvPassList[i] != null){
                avrUrlStr[i] += "&passList="+arvPassList[i];
            }
            avrUrlStr[i] += "&reqCoordType=WGS84GEO";
          //  avrUrlStr[i] += "&appKey=8f7e8c7f-8226-342c-9f0f-2b3ea262b547";
            avrUrlStr[i] += "&appKey=58209c21-f38a-39b1-979d-600bb1c2e4b7";

            arvPrtcl[i] = new Tmap.Protocol.HTTP({
                url: avrUrlStr[i],
                format:routeFormat
            });
            arvRouteLayer[i] = new Tmap.Layer.Vector("arvRoute", {protocol:arvPrtcl[i], strategies:[new Tmap.Strategy.Fixed()],styleMap:arvStylemap});
            arvRouteLayer[i].events.register("featureadded", arvRouteLayer[i], this.vFnOnDrawnFeatures);
            map.addLayer(arvRouteLayer[i]);
        }
    }

        </script>
    </head>


    <body onload="init()">
        <div style="width:100%; height:100%">
            <div id="map_div"></div>
         </div>
    </body>
</html>
