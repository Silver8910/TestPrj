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
    
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
    
    <script type="text/javascript" language="javascript">
		/*     
		var map = new naver.maps.Map('mapContainer', {
			size: new naver.maps.Size(300, 400)
		});
		*/
    
		function OdsFunctionCall(func_name, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
			try {

				
				if (func_name == "show_icon") {
					OdsShowIcon(arg1, arg2, arg3, arg4, arg5);
				}
				else if (func_name == "center") {
					OdsSetCenter(arg1, arg2, Number(arg3));
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


	/*
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
	*/  
		

		function OdsShowIcon(lat, lon, id, label, icon_type ) {
			/*
			var oPoint = new naver.maps.LatLng(Number(lat), Number(lon));

			//var oMarker = new naver.maps.Marker(oIcon, { title: '��Ŀ : ' + oPoint.toString() });
			var oMarker = new naver.maps.Marker(oIcon, { title: label });
			oMarker.setPoint(oPoint);

			oMarker._ods_id = id;
			oMap.addOverlay(oMarker);
			*/
			
			
			var cityHall = new naver.maps.LatLng(lat, lon);
			var markerOptions = {
				position: cityHall,
				icon: {
					url: 'http://static.naver.net/maps/v3/pin_default.png',
					size: new naver.maps.Size(22, 35),
					anchor: new naver.maps.Point(11, 35)
				}
			};
			var marker = new naver.maps.Marker(markerOptions);

			marker.setMap(map); // �߰�
			marker.setMap(null); // ����
		}

		function OdsSetCenter(lat, lon, level) {
			// var oPoint = new naver.maps.LatLng(Number(lat), Number(lon));
			// oMap.setCenterAndLevel(oPoint, level);
			
			var cityHall = new naver.maps.LatLng(Number(lat), Number(lon));
			oMap.setCenter(cityHall);
			oMap.setZoom(level);

			var bounds = oMap.getBounds();
			oMap.fitBounds(bounds);

			oMap.panBy(new naver.maps.Point(15, -30));
			
			var cityHall = new naver.maps.LatLng(Number(lat), Number(lon));
			var markerOptions = {
				position: cityHall,
				icon: {
					url: 'http://static.naver.net/maps/v3/pin_default.png',
					size: new naver.maps.Size(22, 35),
					anchor: new naver.maps.Point(11, 35)
				}
			};
			var marker = new naver.maps.Marker(markerOptions);

			marker.setMap(map); // �߰�
			marker.setMap(null); // ����
		}

		function OnODSDataShow() {


			OdsMapEvent("onmapload", "", "", "", "", "", "", "");
			
		}


		function AddressToLatLng(search) {
			var geocoder = new google.maps.Geocoder();
			geocoder.geocode({ 'address': search }, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					//var latLng = results[0].geometry.location;   

					var lat = results[0].geometry.location.lat();
					var lng = results[0].geometry.location.lng();
					var addr = results[0].formatted_address;


					OdsMapEvent("addresstolatlon", lat, lng, addr, "", "", "");
					
				}
				else {
					alert('Geocoder failed due to: ' + status);
				}
			});

		}


		function LatLngToAddress(str_lat, str_lon) {
			
			var lat = parseFloat(str_lat);
			var lng = parseFloat(str_lon);
			var latlng = new google.maps.LatLng(lat, lng);

			var geocoder = new google.maps.Geocoder();
			geocoder.geocode({ 'latLng': latlng }, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					if (results[0]) {
						for (var i = 0; i < 5; i++) {
							if (results[i]) {

								var addr = results[i].formatted_address;

								OdsMapEvent("latlontoaddress", addr, "", "", "", "", "", "");
								
							}
							else {
								break;
							}
						}

					} else {
						alert('No results found');
					}
				} else {
					alert('Geocoder failed due to: ' + status);
				}
			});
		}
    </script>
</head>

<body style="margin-top:0;margin-left:0;margin-bottom:0;margin-right:0;">

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=HPrq7VD32xI2M4KY3ptD&submodules=geocoder"></script>
<div id="map" style="border:1px solid #000;" ></div>
<script type="text/javascript">
	

    var _margine =5;
    var _map_width = document.documentElement.clientWidth - _margine;
    var _map_height = document.documentElement.clientHeight - _margine;
    

		var oSeoulCityPoint = new naver.maps.LatLng(37.5675451, 126.9773356);
		var defaultLevel = 11;
		var oMap = new naver.maps.Map(document.getElementById('map'), { 
						point : oSeoulCityPoint,
						zoom : defaultLevel,
						enableWheelZoom : true,
						enableDragPan : true,
						enableDblClickZoom : false,
						mapMode : 0,
						activateTrafficMap : false,
						activateBicycleMap : false,
						minMaxLevel : [ 1, 14 ],
						size: new naver.maps.Size(_map_width, _map_height)
		});
		var oSlider = new naver.maps.ZoomControl();
		oMap.addControl(oSlider);
		oSlider.setPosition({
			top : 10,
			left : 10

});


        window.onresize = doResize;
        function doResize() {
            if (oMap)
                oMap.setSize(new naver.maps.Size(document.documentElement.clientWidth - _margine, document.documentElement.clientHeight - _margine));            
        }

        setTimeout("onTimer()", 1000); //

        function onTimer() {
            if (oMap)
                oMap.setSize(new naver.maps.Size(document.documentElement.clientWidth - _margine, document.documentElement.clientHeight - _margine));

            //OdsShowIcon(37.5676, 126.9773356, "��!!!");
      }
        
        

		var oMapTypeBtn = new naver.maps.MapTypeBtn();
		oMap.addControl(oMapTypeBtn);
		oMapTypeBtn.setPosition({
			bottom : 10,
			right : 80
		});
		
		var oThemeMapBtn = new naver.maps.ThemeMapBtn();
		oThemeMapBtn.setPosition({
			bottom : 10,
			right : 10
		});
		oMap.addControl(oThemeMapBtn);

/*
		var oBicycleGuide = new naver.maps.BicycleGuide(); // - ������ ���� ����
		oBicycleGuide.setPosition({
			top : 10,
			right : 10
		}); // - ������ ���� ��ġ ����
		oMap.addControl(oBicycleGuide);// - ������ ���ʸ� ������ �߰�.

		var oTrafficGuide = new naver.maps.TrafficGuide(); // - ���� ���� ����
		oTrafficGuide.setPosition({
			bottom : 30,
			left : 10
		});  // - ���� ���� ��ġ ����.
		oMap.addControl(oTrafficGuide); // - ���� ���ʸ� ������ �߰�.
		*/

		var trafficButton = new naver.maps.TrafficMapBtn(); // - �ǽð� �������� ��ư ����
		trafficButton.setPosition({
			bottom:10, 
			right:150
		}); // - �ǽð� �������� ��ư ��ġ ����
		oMap.addControl(trafficButton);

		var oSize = new naver.maps.Size(28, 37);
		var oOffset = new naver.maps.Size(14, 37);
		var oIcon = new naver.maps.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);

		var oInfoWnd = new naver.maps.InfoWindow();
		oInfoWnd.setVisible(false);
		oMap.addOverlay(oInfoWnd);

		oInfoWnd.setPosition({
			top : 20,
			left :20
		});

		var oLabel = new naver.maps.MarkerLabel(); // - ��Ŀ �� ����.
		oMap.addOverlay(oLabel); // - ��Ŀ �� ������ �߰�. �⺻�� ���� ������ �ʴ� ���·� �߰���.

		oInfoWnd.attach('changeVisible', function(oCustomEvent) {
			if (oCustomEvent.visible) {
				oLabel.setVisible(false);
			}
		});
		
		var oPolyline = new naver.maps.Polyline([], {
			strokeColor : '#f00', // - ���� ����
			strokeWidth : 5, // - ���� �β�
			strokeOpacity : 0.5 // - ���� ����
		}); // - polyline ����, ù��° ���ڴ� ���� �׷��� ���� ��ġ. ����� ����.
		oMap.addOverlay(oPolyline); // - ������ ���� �߰���.

		oMap.attach('mouseenter', function(oCustomEvent) {

			var oTarget = oCustomEvent.target;
			// ��Ŀ���� ���콺 �ö󰣰Ÿ�
			if (oTarget instanceof naver.maps.Marker) {
				var oMarker = oTarget;
				oLabel.setVisible(true, oMarker); // - Ư�� ��Ŀ�� �����Ͽ� �ش� ��Ŀ�� title�� �����ش�.
			}
		});

		oMap.attach('mouseleave', function(oCustomEvent) {

			var oTarget = oCustomEvent.target;
			// ��Ŀ������ ���콺 �����Ÿ�
			if (oTarget instanceof naver.maps.Marker) {
				oLabel.setVisible(false);
			}
		});


		oMap.attach('click', function(oCustomEvent) {
		    var oPoint = oCustomEvent.point;
		    var oTarget = oCustomEvent.target;
		    //oInfoWnd.setVisible(false);

		    //alert(oPoint.toString());

		    // ��Ŀ Ŭ���ϸ�
		    if (oTarget instanceof naver.maps.Marker) {

		        // ��ħ ��Ŀ Ŭ���ѰŸ�
		        if (oCustomEvent.clickCoveredMarker) {
		            return;
		        }

		        //alert(oTarget._ods_id);

		        OdsMapEvent("onmarkerclick", oTarget._ods_id, "", "", "", "", "");






		        /*
		        // - InfoWindow �� �� ������ setContent �� �����Ӱ� ���� �� �ֽ��ϴ�. �ܺ� css�� �̿��� �� ������, 
		        // - �ܺ� css�� ����� class�� �̿��ϸ� �ش� class�� ��Ÿ���� �ٷ� ������ �� �ֽ��ϴ�.
		        // - ��, DIV �� position style �� absolute �� �Ǹ� �ȵǸ�, 
		        // - absolute �� ��� autoPosition �� �������� �ʽ��ϴ�. 
		        oInfoWnd.setContent('<DIV style="border-top:1px solid; border-bottom:2px groove black; border-left:1px solid; border-right:2px groove black;margin-bottom:1px;color:black;background-color:white; width:auto; height:auto;">' +
		        '<span style="color: #000000 !important;display: inline-block;font-size: 12px !important;font-weight: bold !important;letter-spacing: -1px !important;white-space: nowrap !important; padding: 2px 5px 2px 2px !important">' +
		        'Hello World <br /> ' + oTarget.getPoint()
		        + '<span></div>');
		        oInfoWnd.setPoint(oTarget.getPoint());
		        oInfoWnd.setPosition({ right: 15, top: 30 });
		        oInfoWnd.setVisible(true);
		        oInfoWnd.autoPosition();
		        */
		        return;
		    }


		    OdsMapEvent("onmapclick", String(oPoint.y), String(oPoint.x), "", "", "", "", "");




		    /*
		    var oMarker = new naver.maps.Marker(oIcon, { title: '��Ŀ : ' + oPoint.toString() });
		    oMarker.setPoint(oPoint);
		    oMap.addOverlay(oMarker);

		    var aPoints = oPolyline.getPoints(); // - ���� ���������� �̷�� ���� �����ͼ� �迭�� ����.
		    aPoints.push(oPoint); // - �߰��ϰ��� �ϴ� ���� �߰��Ͽ� �迭�� ������.
		    oPolyline.setPoints(aPoints); // - �ش� �������ο� �迭�� ����� ���� �߰���
		    */
		});


		OnODSDataShow();

        

	</script>
	
	
    <form id="form1" runat="server">
    <div>    
    </div>
    </form>
</body>
</html>
