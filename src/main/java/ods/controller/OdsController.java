package ods.controller;

import java.util.Hashtable;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ods.dwservice.DWService_BAAuthGroup;
import ods.dwservice.DWService_BAAuthMember;
import ods.dwservice.DWService_BACmpy;
import ods.service.BAAuthGroupService;
import ods.service.BAAuthMemberService;
import ods.service.BACmpyService;
import ods.service.BAHrService;
import ods.web.ODSDWServiceBase;
import ods.web.ODSDWServiceBaseImpl;
import opendraft.lang.StringBuilder2;
import opendraft.service.gate_web.ODS_ServerPage_FileUpload_impl;
import opendraft.service.gate_web.ODWebembedGate;
import opendraft.service.gate_web.jsp_ODS_ServerPage_Dlg;
import opendraft.service.gate_web.jsp_ODS_ServerPage_Main;
import opendraft.service.gate_web.jsp_ODS_ServerPage_Run;
import opendraft.service.gate_web.jsp_ODS_odshtml_image;
import opendraft.service.gate_web.jsp_index_impl;
import opendraft.service.ods_server_page.run_session.menu_session.MenuInfoShare;
import opendraft.service.run.javascript.ScriptableODWParameter;
import opendraft.service.run.javascript.ScriptableOpendraftSystem;
import opendraft.service.run.odw.ODWContext;
import opendraft.spring_adaptor.OpendraftDTC;
import opendraft.spring_adaptor.OpendraftDataBind;

@Controller
public class OdsController implements opendraft.service.run.odw.IODWExternalRunner {

	@Resource(name = "bacmpyService")
	public BACmpyService bacmpyService;
	
	@Resource(name = "bahrService")
	public BAHrService bahrService;
	
	@Resource(name = "baauthGroupService")
	public BAAuthGroupService baauthGroupService;
	
	@Resource(name = "baauthMemberService")
	public BAAuthMemberService baauthMemberService;
	
	//==========================================================================================================
	// Openddraft_System_Code Start
	
	private void OnRunDWService_Init()
	{
		if( ODSDWServiceBaseImpl.gMap_DWRunner != null )
			return;
		
		
		Hashtable<String,ODSDWServiceBase> map_dw = new Hashtable<String,ODSDWServiceBase>();
		
		ODSDWServiceBase b = null;
		
		// dw ex_cdmr의 구현을 추가.
//			b = new ODSDWService_EX_MD01();
//			b.OnPutRunner( map_dw );
		
		
		// BACmpy
		b = new DWService_BACmpy();
		b.OnPutRunner( map_dw );
		
		// BAHr
		//b = new DWService_BAHr();
		//b.OnPutRunner( map_dw );

		// BAAuthGroup
		b = new DWService_BAAuthGroup();
		b.OnPutRunner( map_dw );

		// BAAuthMember
		b = new DWService_BAAuthMember();
		b.OnPutRunner( map_dw );
		
		
		
		ODSDWServiceBaseImpl.gMap_DWRunner = map_dw;
	}
	
	
	
	public boolean OnRunDWService( 
			ODWContext odw_ctx,
			String dw_name, String method_type, String method_name,			
			ScriptableOpendraftSystem ODS, 
			ScriptableODWParameter Request, ScriptableODWParameter Response)
	{
		
		OnRunDWService_Init();
		
		String dw_impl_key = dw_name + ":" + method_type + ":" + method_name ;
		if( ODSDWServiceBaseImpl.gMap_DWRunner != null && ODSDWServiceBaseImpl.gMap_DWRunner.containsKey(dw_impl_key.toUpperCase()) )
		{
			try
			{
				ODSDWServiceBase dw_runner = ODSDWServiceBaseImpl.gMap_DWRunner.get(dw_impl_key.toUpperCase());
				
				return dw_runner.GetRunner().RunDW(odw_ctx, this, method_type, method_name, ODS, Request, Response);
				
				
			}
			catch(Exception exp)
			{
				ODS.Rollback(0,  exp.toString() );
				return true;
			}
			
		}
		
		// false가 반한되면 opendraft dw의 기본 java script가 실행 된다.
		return false;
	}
	
	
	
	@RequestMapping(value = "/eGovOdsDataGate.do"  )
	@ResponseBody
	public String eGovOdsDataGate(HttpServletRequest request, HttpServletResponse response ) throws Exception {
	
		
		ODWebembedGate web_gate = new ODWebembedGate();
		StringBuilder2 sb = new StringBuilder2();
		
		
		try
		{
			if( !web_gate.RunService_Ready( request, response, sb ) )	
				return sb.ToString();
						
			
			// is odw실행?
			if( !web_gate.RunService2( request, response, sb, this ) )
				return sb.ToString();
			
			
			response.setContentType("application/octet-stream");
			response.setCharacterEncoding("utf-8");
			web_gate.MakeResultString( sb );
			
		}
		catch(Exception exp )
		{
			sb.AppendLine("@@"+exp.toString());
		}
		
		
		return sb.ToString();
	}
		
	@RequestMapping(value = "/eGovOdsIndex.do")
	public String eGovOdsIndex(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

	
		request.setCharacterEncoding("utf-8");
		
		
		// Opendraft Service 초기화
		opendraft.service.gate_web.ODWebembedGate gate_impl = 
		new opendraft.service.gate_web.ODWebembedGate();
	
		
		boolean is_init_error = false;
		String str_init_error = gate_impl.InitService( request.getSession().getServletContext() );
		if( str_init_error.length() > 0 )
			is_init_error = true;
	
		
	
	
		jsp_index_impl this_impl = new jsp_index_impl();
	
	
	
		// login으로 이 페이지가 호출 되었는지 확인.
		String chk_login = "";        
        if (request.getParameter("chk_login") != null)
            chk_login = request.getParameter("chk_login");
	
        
		if( chk_login.compareTo("ok") == 0 )
		{
			if( this_impl.OdsLogin( request, response ) )
			{
				// login 성공.
				// init main
				
				
				this.eGovOdsScreenMain_Impl( request,  response,  model);
				return "ods_egov/eGovOdsScreenMain";
			}
			else
			{
				str_init_error = this_impl._error_str;
				is_init_error = true;
			}
		}
		else
		{
			this_impl.ReadInitData( request, response );
		}
	
		//this_impl.Page_Load( request, response );
		
		
	
		String opendraft_auto_logoin_script = this_impl.opendraft_auto_logoin_script;
		String opendraft_x_codebase = this_impl.opendraft_x_codebase;
	
		String g_lang_ko_check = this_impl.g_lang_ko_check;
		String g_lang_ch_check = this_impl.g_lang_ch_check;
		String g_lang_en_check = this_impl.g_lang_en_check;
		String g_lang_jp_check = this_impl.g_lang_jp_check;
	
		String g_run_type_stan = this_impl.g_run_type_stan;
		String g_run_type_silver = this_impl.g_run_type_silver;
		String g_run_type_web = this_impl.g_run_type_web;
	
		String g_check_save = this_impl.g_check_save;
	
		String g_user_id = this_impl.g_user_id;
	
		
		model.addAttribute("opendraft_auto_logoin_script", opendraft_auto_logoin_script );
		model.addAttribute("opendraft_x_codebase", opendraft_x_codebase );
		
		model.addAttribute("g_lang_ko_check", g_lang_ko_check );
		model.addAttribute("g_lang_ch_check", g_lang_ch_check );
		model.addAttribute("g_lang_en_check", g_lang_en_check );
		model.addAttribute("g_lang_jp_check", g_lang_jp_check );
	
		model.addAttribute("g_run_type_stan", g_run_type_stan );
		model.addAttribute("g_run_type_silver", g_run_type_silver );
		model.addAttribute("g_run_type_web", g_run_type_web );
	
		model.addAttribute("g_check_save", g_check_save );
	
		model.addAttribute("g_user_id", g_user_id );
		
		
		
		return "ods_egov/eGovOdsIndex";
	}
	
	
	
	@RequestMapping(value = "/eGovOdsScreenMain.do")
	public String eGovOdsScreenMain(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
				
		
		this.eGovOdsScreenMain_Impl( request,  response,  model);
		
		return "ods_egov/eGovOdsScreenMain";
	}
	
	
	
	public void eGovOdsScreenMain_Impl(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
	
		// Opendraft Service 초기화
		opendraft.service.gate_web.ODWebembedGate gate_impl = new opendraft.service.gate_web.ODWebembedGate();
		gate_impl.InitService(request.getSession().getServletContext());

		jsp_ODS_ServerPage_Main this_impl = new jsp_ODS_ServerPage_Main();

		// session error 발생시 Page_Load에서 바로 redirect하지 않고 
		// 에러 결과를 설정.
		this_impl._session_error_skip = true;

		this_impl.Page_Load( request, response );

		//
		// session에러가 발생할 경우 원하는 페이지로 보낼 수 있음
		if( this_impl._session_error_result == true )
		{
			response.getWriter().write(
				"<script language=javascript> \r\n"
				+"	alert('세션이 종료되어 초기페이지로 이동합니다.\r\n다시 로그인 해 주세요'); "
				+"	setTimeout(function(){document.location = 'index.jsp'},500)  \r\n"
				+"</script>" );
			return;
		}

		String _ocm_server_url = this_impl._ocm_server_url;
		String _ocm_server_key = this_impl._ocm_server_key;
		String _session_id = this_impl._session_id;

		String _lang_id = this_impl._lang_id.toLowerCase();
		String _user_name = this_impl._user_name;
		String _user_id = this_impl._user_id;
		
		if ( _user_id.equals("annony") )
		{
			response.getWriter().write(
				"<script language=javascript> \r\n"
				+"	alert('잘못된 접근입니다. 초기페이지로 이동합니다.'); "
				+"	setTimeout(function(){document.location = 'index.jsp'},500)  \r\n"
				+"</script>" );
			return;
		}

		
	    String _TreeName = "ROOT";
		String _LangCd = request.getParameter("LangCd");
		
		/*
		if ( _LangCd == null )
		{
			_LangCd = (String)session.getAttribute("LangCd");
			session.setAttribute("LangCd", "");
		}
		*/

		if ( _LangCd == null || _LangCd == "" ) _LangCd = _lang_id;
		
	    // 메뉴 생성
	    opendraft.service.gate_web.ODWebembedGate web_gate = new opendraft.service.gate_web.ODWebembedGate();
	    web_gate._opendraft_server = opendraft.service.ServiceManager._service_mng;

	    String Prefix = "result : ";
	    String dw_name = "BAMenuSetting";
	    String type = "Query";
	    String method = "query_menu_html";
	    String col_result = "result";

	    java.util.Hashtable<String, String> map_param = new java.util.Hashtable<String, String>();
	    //map_param.put("PARAM1", _TreeName); // tree_name
	    map_param.put("PARAM1", _user_id); // tree_name
	    map_param.put("PARAM2", "root_menu"); // 상위메뉴
	    map_param.put("PARAM3", _LangCd); // 언어코드

	    String RsltData = "";
	    String _MenuHtml = "";
	    // query
	    if (web_gate.DW_Call(dw_name, type, method, map_param, col_result))
	    {
	        RsltData = web_gate._result_val;
	        _MenuHtml = RsltData;
	    }

	    model.addAttribute("_session_id", _session_id );
	    model.addAttribute("_lang_id", _lang_id );
	    model.addAttribute("_user_id", _user_id );
	    model.addAttribute("_MenuHtml", _MenuHtml );
	    
		return;
	}
	
	
	
	
	
	
	@RequestMapping(value = "/eGovOdsImageDownload.do"  )
	public void eGovOdsImageDownload(HttpServletRequest request, HttpServletResponse response ) throws Exception {
		jsp_ODS_odshtml_image impl_page = new jsp_ODS_odshtml_image();
		impl_page.Page_Load(request, response);
	}
	
	
	
	
	
	
	/**
	 * OdsScreenWrap
	 * @param model
	 * @return "ods_egov/eGovOdsScreenRun"
	 * @exception Exception
	 */
	@RequestMapping(value = "/eGovOdsScreenRun.do")
	public String eGovOdsScreenRun(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		

		request.setCharacterEncoding("utf-8");
		
		
		String ods_param1 = request.getParameter("ods_param1");
	    String ods_param2 = request.getParameter("ods_param2");
	    String ods_param3 = request.getParameter("ods_param3");
	    String ods_param4 = request.getParameter("ods_param4");
	    String ods_param5 = request.getParameter("ods_param5");

	    String _menu_type = request.getParameter("menu_type");
	    String _menu_code = request.getParameter("menu_code");
	    String _top_menu = request.getParameter("top_menu");



	    // Opendraft Service 초기화
	    opendraft.service.gate_web.ODWebembedGate gate_impl = new opendraft.service.gate_web.ODWebembedGate();
	    jsp_ODS_ServerPage_Run this_impl = new jsp_ODS_ServerPage_Run();


	    // session error 발생시 Page_Load에서 바로 redirect하지 않고 
	    // 에러 결과를 설정.
	    this_impl._session_error_skip = true;

	    this_impl.Page_Load( request, response, false, "", "" );

	    // session에러가 발생 했다.
	    if( this_impl._session_error_result == true )
	    {
	        response.getWriter().write(
	                        "<script language=javascript> \r\n"+
	                        "   alert('세션이 종료되어 초기페이지로 이동합니다.\\n다시 로그인 해 주세요'); "+
	                        "   setTimeout(function(){parent.document.location = 'index.jsp'},500)  \r\n"+
	                        "</script>" );
	        return "ods_egov/eGovOdsIndex";
	    }



	    String _lang_id = this_impl._lang_id.toLowerCase();
	    String str_init_script = this_impl._script_div_scroll_init.replaceAll("Form.DialogInit();", "");
	    int pos = str_init_script.indexOf( "Form.DialogInit();" );
	    pos = str_init_script.indexOf( "Form.DialogInit();" );
	    _lang_id = this_impl._lang_id.toLowerCase();
			
		model.addAttribute("param1", "" );
		model.addAttribute("param2", "" );

		model.addAttribute("_menu_type", _menu_type );
		model.addAttribute("_menu_code", _menu_code );
		model.addAttribute("_top_menu", _top_menu );
		model.addAttribute("_lang_id", _lang_id );
		model.addAttribute("str_init_script", str_init_script );
		model.addAttribute("_html_body", this_impl._html_body );
	
	
		
		return "ods_egov/eGovOdsScreenRun";
	}
	
	
	
	/**
	 * OdsScreenWrap
	 * @param model
	 * @return "ods_egov/eGovOdsScreenDlg"
	 * @exception Exception
	 */
	@RequestMapping(value = "/eGovOdsScreenDlg.do")
	public String eGovOdsScreenDlg(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
	
		request.setCharacterEncoding("utf-8");
		
		opendraft.service.gate_web.ODWebembedGate gate_impl = new opendraft.service.gate_web.ODWebembedGate();
		jsp_ODS_ServerPage_Dlg this_impl = new jsp_ODS_ServerPage_Dlg();



		this_impl.Page_Load( request, response );

		String _lang_id = this_impl._lang_id.toLowerCase();
		
		
				
		
		if( _lang_id.length() < 1 )
			_lang_id = "ko";
		
		
					
		
		model.addAttribute("_lang_id", _lang_id );
		model.addAttribute("str_init_script",
				"<script type=\"text/javascript\">function ods_init_script_wrap(){" + 
						this_impl._script_div_scroll_init +
				"}</script>" );
		
		model.addAttribute("_script_div_scroll_init", this_impl._script_div_scroll_init);
		model.addAttribute("_screen_name", this_impl._screen_name );
		model.addAttribute("_html_body", this_impl._html_body );
		
		
			
		return "ods_egov/eGovOdsScreenDlg";
	}
	
	
	
	@RequestMapping(value = "/eGovOdsFileUpload.do")
	public String eGovOdsFileUpload(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
	
		request.setCharacterEncoding("utf-8");
		

		ODS_ServerPage_FileUpload_impl this_impl = new ODS_ServerPage_FileUpload_impl();
		this_impl.Page_Load( request, response );

		String _html_download_script = this_impl._html_download_script;
		String _html_download = this_impl._html_download;
		String _excel_data = this_impl._excel_data;

		boolean _is_upload_form = this_impl._is_upload_form;
		String _recv_od = this_impl._recv_od;

		String _file_fillter = this_impl._file_fillter;
					
		
		
		
		model.addAttribute("_html_download_script", _html_download_script );
		model.addAttribute("_html_download", _html_download );
		model.addAttribute("_excel_data", _excel_data );
		model.addAttribute("_recv_od", _recv_od );
		model.addAttribute("_file_fillter", _file_fillter );
		
		model.addAttribute("_is_upload_form", _is_upload_form );
		
		
		
		
			
			return "ods_egov/eGovOdsFileUpload";
	}
	
	

	// Openddraft_System_Code End
	//==========================================================================================================
}
