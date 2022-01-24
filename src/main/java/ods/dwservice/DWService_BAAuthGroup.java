package ods.dwservice;

import java.util.Hashtable;
import java.util.List;

import ods.controller.OdsController;
import ods.vo.BAAuthGroupVO;
import ods.web.ODSDWServiceBase;
import ods.web.ODSDWServiceBaseImpl;
import opendraft.service.run.javascript.ScriptableDBConnection;
import opendraft.service.run.javascript.ScriptableDBRecordSet;

public class DWService_BAAuthGroup extends ODSDWServiceBaseImpl {
	public ODSDWServiceBase GetRunner()
	{
		return new DWService_BAAuthGroup();
	}
	
	public void OnPutRunner( Hashtable<String,ODSDWServiceBase> map_dw )
	{
		String key = "";
		
		key = "BAAuthGroup_egov:query:query_rn_by_CustCd";
		map_dw.put( key.toUpperCase(), this );

		key = "BAAuthGroup_egov:insert:insert_sc";
		map_dw.put( key.toUpperCase(), this );

		key = "BAAuthGroup_egov:update:update_sc";
		map_dw.put( key.toUpperCase(), this );

		key = "BAAuthGroup_egov:delete:delete_sc";
		map_dw.put( key.toUpperCase(), this );
	}
	
	OdsController ctll = null;
	public boolean OnRunDW( Object in_ctll, String method_type, String method_name)
	{
		try
		{
			// controller 마다 다름.
			ctll = (OdsController)in_ctll;
		
			if( method_type.compareToIgnoreCase("query") == 0 )
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
		if ( method_name.compareToIgnoreCase("query_rn_by_CustCd") == 0 )
		{
			BAAuthGroupVO baautoGroupVO = new BAAuthGroupVO();
			baautoGroupVO.setCustCd(Request.ParamGet("CustCd"));
			List<?> RsltList = ctll.baauthGroupService.selectBAAuthGroupList(baautoGroupVO);
			
			this.SetResultSet(Response, RsltList);
			
//			ScriptableDBConnection dbconn = (ScriptableDBConnection)ODS.GetConnection();
//			
//			String sql ="SELECT GroupID, GroupNm \r\n"
//			           +"FROM  BAAuthGroup  \r\n";
//			
//			ODS.TraceQueryState( "test", sql, dbconn );
//			
//			ScriptableDBRecordSet rset = (ScriptableDBRecordSet)dbconn.ExecuteReader(sql);
//			Response.SendRecordSet(rset);
//			rset.Close();
		}
	}
	void OnInsert(String method_name) throws Exception {
		if( method_name.compareToIgnoreCase("insert_sc") == 0 ) {
			BAAuthGroupVO baautoGroupVO = new BAAuthGroupVO();
			//baautoGroupVO.setGroupID(Integer.parseInt(Request.ParamGet("GroupID")));
			baautoGroupVO.setGroupNm(Request.ParamGet("GroupNm"));
			baautoGroupVO.setCustCd(Request.ParamGet("CustCd"));
			baautoGroupVO.setRk(Request.ParamGet("Rk"));
			baautoGroupVO.setApUserID(ODS.GetUserID());
			baautoGroupVO.setApDt(Request.ParamGet("ApDt"));
			baautoGroupVO.setUpUserID(ODS.GetUserID());
			baautoGroupVO.setUpDt(Request.ParamGet("UpDt"));
			
			int GroupID = ctll.baauthGroupService.insertBAAuthGroup(baautoGroupVO);
			Response.SetCellData("GroupID", 0, Integer.toString(GroupID));
		}
	}
	void OnUpdate(String method_name) throws Exception {
		if( method_name.compareToIgnoreCase("update_sc") == 0 ) {
			BAAuthGroupVO baautoGroupVO = new BAAuthGroupVO();
			baautoGroupVO.setGroupID(Integer.parseInt(Request.ParamGet("GroupID")));
			baautoGroupVO.setGroupNm(Request.ParamGet("GroupNm"));
			baautoGroupVO.setCustCd(Request.ParamGet("CustCd"));
			baautoGroupVO.setRk(Request.ParamGet("Rk"));
			baautoGroupVO.setApUserID(ODS.GetUserID());
			baautoGroupVO.setApDt(Request.ParamGet("ApDt"));
			baautoGroupVO.setUpUserID(ODS.GetUserID());
			baautoGroupVO.setUpDt(Request.ParamGet("UpDt"));
			
			ctll.baauthGroupService.updateBAAuthGroup(baautoGroupVO);
		}
	}
	void OnDelete(String method_name) throws Exception {
		if( method_name.compareToIgnoreCase("delete_sc") == 0 ) {
			BAAuthGroupVO baautoGroupVO = new BAAuthGroupVO();
			baautoGroupVO.setGroupID(Integer.parseInt(Request.ParamGet("GroupID")));
			
			ctll.baauthGroupService.deleteBAAuthGroup(baautoGroupVO);
		}
	}
}
