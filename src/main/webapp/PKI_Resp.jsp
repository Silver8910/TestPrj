<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="tradesign.crypto.provider.*" %>
<%@ page import="tradesign.pki.pkix.X509Certificate" %> 
<%@ page import="tradesign.pki.pkix.X509CRL" %>
<%@ page import="tradesign.pki.pkix.SignedData" %>
<%@ page import="tradesign.pki.util.JetsUtil" %>

<%@ page import="java.io.*, java.security.*, java.util.*, java.lang.*" %>


<%	
    /*
     이 스크립트는 demosign.html 로부터 수신한 서명데이터(SignedData)에 대해서 서명검증/해석을 수행합니다.
     서명데이터는 Base64인코딩된 텍스트형태이기때문에 스트링으로 넘겨받습니다.
    */


	// DemoSign.htm 로부터 수신한 서명데이터(SignedData)를 스트링으로 받습니다.
	String message = new String(request.getParameter("data1").getBytes("ISO-8859-1"), "utf-8");
	
	
	// 인증서 검증 포함 여부 체크
	String VerifyType = request.getParameter("certVerifyType");

     // TradeSign PKIT 툴킷 사용을 위해 프로바이더를 등록합니다.
	JeTS.installProvider("D:/PKI/tradesign3280.properties");
	
	// 서명데이터(SignedData)는 바이너리형태이지만, 송수신을 위해 Base64인코딩되어 텍스트형태로 변환되어 있습니다.
	// 이를 다시 Base64디코딩을 통해 원형으로 복구합니다.		
	
	byte[] content = JetsUtil.base64ToBytes(message);

	// 위에서 디코딩되어 복원된 서명데이터를 서명검증/해석하기 위해 SignData를 선언한다.
	String ret = null;
	
	String expyn[] = null;
	String expday[] = null;
	String expreason[] = null; 
	String CertDn[] = null; 
	String IssuerDn[] = null; 
	
	try {
		SignedData sd =  new SignedData(content);        
		
		String plaintext = new String(sd.getContent());
		                
		X509Certificate[] certs = sd.verify();
		
		expyn  = new String[certs.length]; // 폐지여부
		expday  = new String[certs.length]; // 폐지일
		expreason  = new String[certs.length]; // 폐지사유
		CertDn  = new String[certs.length]; // 서명자
		IssuerDn  = new String[certs.length]; // 발급자
			
		for (int i = 0; i < certs.length; i++)
		{
		    // crl 통한 검증 포함
			if (VerifyType.equals("2"))
			{
				X509CRL crl = new X509CRL(certs[i].getCrlDp(), true);
				boolean r= crl.isRevoked(certs[i].getSerialNumber());
				
				if(r){
					expyn[i] = "폐지됨"; // 폐지여부
					expday[i] = crl.getRevokedDate().toString(); // 폐지일
					if( crl.getRevokedReason() == null ) expreason[i] = "없음";
					else expreason[i] = crl.getRevokedReason(); // 폐지사유
					
				}	
				else{
					expyn[i] = "유효함";
				}	
		
			}
			
			CertDn[i] = certs[i].getSubjectDNStr(); // 서명자
			IssuerDn[i] = certs[i].getIssuerDNStr(); // 발급자
			
		}	
		
		// 서명 시각
		String SignTime = sd.getSigningTime().toString();
		
		// ODW 호출
		opendraft.service.gate_web.ODWebembedGate web_gate = new opendraft.service.gate_web.ODWebembedGate();
		web_gate._opendraft_server = opendraft.service.ServiceManager._service_mng;

		String Prefix = "result : ";
		String dw_name = "PKI";
		String type = "Insert";
		String method = "pki_result";
		String col_result = "result";

		java.util.Hashtable<String, String> map_param = new java.util.Hashtable<String, String>();
		map_param.put("PARAM1", CertDn[0]);
		map_param.put("PARAM2", IssuerDn[0]);
		map_param.put("PARAM3", SignTime);

		String RsltData = "";
		// query
		if (web_gate.DW_Call(dw_name, type, method, map_param, col_result))
		{
			RsltData = web_gate._result_val;
			ret = RsltData;
		}
	}
	catch (Exception e) {
		e.printStackTrace();
		ret = e.getMessage();
		out.print("에러 : " + ret);
	}
%>

<html>
	<header>
		<script language="javascript">
			function onLoad(  )
			{
				parent.PKI_End(<%=ret%>);
			}
		</script>
	</header>
	<body onLoad="onLoad()">
	</body>
</html>
