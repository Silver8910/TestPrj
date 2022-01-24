package ods.dwservice;

import java.util.Hashtable;
import java.util.List;

import ods.controller.OdsController;
import ods.vo.BAAuthMemberVO;
import ods.web.ODSDWServiceBase;
import ods.web.ODSDWServiceBaseImpl;

public class DWService_BAAuthMember extends ODSDWServiceBaseImpl{
	public ODSDWServiceBase GetRunner()
	{
		return new DWService_BAAuthMember();
	}
	
	public void OnPutRunner( Hashtable<String,ODSDWServiceBase> map_dw )
	{
		String key = "";
		
		key = "BAAuthMember_egov:query:query_rn";
		map_dw.put( key.toUpperCase(), this );
		
		key = "BAAuthMember_egov:insert:insert_sc";
		map_dw.put( key.toUpperCase(), this );
		
		key = "BAAuthMember_egov:update:update_sc";
		map_dw.put( key.toUpperCase(), this );
		
		key = "BAAuthMember_egov:update:update_all";
		map_dw.put( key.toUpperCase(), this );
		
		key = "BAAuthMember_egov:delete:delete_sc";
		map_dw.put( key.toUpperCase(), this );
	}
	
	
	OdsController ctll = null;
	public boolean OnRunDW( Object in_ctll, String method_type, String method_name)
	{
		try
		{
			ctll = (OdsController)in_ctll;
			if ( method_type.compareToIgnoreCase("query") == 0 )
			{
				OnQuery(method_name);
			}
			else if ( method_type.compareToIgnoreCase("insert") == 0 )
			{
				OnInsert(method_name);
			}
			else if ( method_type.compareToIgnoreCase("update") == 0 )
			{
				OnUpdate(method_name);
			}
			else if ( method_type.compareToIgnoreCase("delete") == 0 )
			{
				OnDelete(method_name);
			}
		}
		catch(Exception e)
		{
			ODS.Rollback(0, e.toString() );
		}
		
		return true;
	}
	
	void OnQuery(String method_name) throws Exception {
		if ( method_name.compareToIgnoreCase("query_rn") == 0 )
		{
			BAAuthMemberVO baauthMemberVO = new BAAuthMemberVO();
			baauthMemberVO.setGroupID(Integer.parseInt(Request.ParamGet("GroupID")));
			
			List<?> baauthMemberList = ctll.baauthMemberService.selectBAAuthMemberGroup(baauthMemberVO);
			this.SetResultSet( Response, baauthMemberList );
		}
	}
	void OnInsert(String method_name) throws Exception {
		
	}
	void OnUpdate(String method_name) throws Exception {
		if ( method_name.compareToIgnoreCase("update_all") == 0 )
		{
			for ( int i_row = 0 ; i_row < Request.ParamCount() ; i_row++ )
			{
				String modify_flag = Request.ParamGetRecord("ods_modify_flag", i_row);
				int AuthMemberID = Integer.parseInt(Request.ParamGetRecord("AuthMemberID", i_row));
				
				BAAuthMemberVO baauthMemberVO = new BAAuthMemberVO();
				baauthMemberVO.setAuthMemberID(AuthMemberID);
				baauthMemberVO.setMemberTp(Request.ParamGetRecord("MemberTp", i_row));
				baauthMemberVO.setMemberID(Request.ParamGetRecord("MemberID", i_row));
				baauthMemberVO.setMemberCd(Request.ParamGetRecord("MemberCd", i_row));
				baauthMemberVO.setMemberNm(Request.ParamGetRecord("MemberNm", i_row));
				baauthMemberVO.setGroupID(Integer.parseInt(Request.ParamGetRecord("GroupID", i_row)));
				baauthMemberVO.setRk(Request.ParamGetRecord("Rk", i_row));
				baauthMemberVO.setCustCd(Request.ParamGetRecord("CustCd", i_row));
				baauthMemberVO.setApUserID(ODS.GetUserID());
				baauthMemberVO.setApDt(Request.ParamGetRecord("ApDt", i_row));
				baauthMemberVO.setUpUserID(ODS.GetUserID());
				baauthMemberVO.setUpDt(Request.ParamGetRecord("UpDt", i_row));
				
				if ( modify_flag.equals("1") )
				{
					AuthMemberID = ctll.baauthMemberService.insertBAAuthMember(baauthMemberVO);
				}
				else if ( modify_flag.equals("2") )
				{
					ctll.baauthMemberService.updateBAAuthMember(baauthMemberVO);
				}
				else
				{
					ctll.baauthMemberService.deleteBAAuthMember(baauthMemberVO);
				}
				
				Response.SetCellData("AuthMemberID", i_row, Integer.toString(AuthMemberID));
			}
		}
	}
	void OnDelete(String method_name) throws Exception {
		if ( method_name.compareToIgnoreCase("delete_sc") == 0 )
		{
			BAAuthMemberVO baauthMemberVO = new BAAuthMemberVO();
			baauthMemberVO.setAuthMemberID(Integer.parseInt(Request.ParamGet("AuthMemberID")));
			
			ctll.baauthMemberService.deleteBAAuthMember(baauthMemberVO);
		}
	}
}
