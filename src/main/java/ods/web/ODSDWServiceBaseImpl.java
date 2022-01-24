package ods.web;

import java.util.Hashtable;
import java.util.List;

import opendraft.service.run.javascript.ScriptableODWParameter;
import opendraft.service.run.javascript.ScriptableOpendraftSystem;
import opendraft.service.run.odw.ODWContext;

public class ODSDWServiceBaseImpl implements ODSDWServiceBase {

	public ODWContext odw_ctx = null;				
	public ScriptableOpendraftSystem ODS = null; 
	public ScriptableODWParameter Request = null;
	public ScriptableODWParameter Response = null;
	
	
	public static Hashtable<String,ODSDWServiceBase> gMap_DWRunner = null;
	
	
	public ODSDWServiceBase GetRunner()
	{
		return null;
	}
	
	public void OnPutRunner( Hashtable<String,ODSDWServiceBase> map_dw )
	{
		
	}
	
	public boolean RunDW( 
			ODWContext in_odw_ctx,
			Object in_ctll,
			String method_type, String method_name,			
			ScriptableOpendraftSystem in_ods, 
			ScriptableODWParameter in_request, ScriptableODWParameter in_response)
	{
		odw_ctx = in_odw_ctx;
		ODS = in_ods;
		Request = in_request;
		Response = in_response;
		
		return OnRunDW( in_ctll, method_type, method_name );
	}
	
	
	public boolean OnRunDW( 
			Object in_ctll,
			String method_type, String method_name)
	{
		return true;
	}
	
	
	
	public void SetResultSet(ScriptableODWParameter Response, List<?> list_send )
	{
		int count = list_send.size();
		for( int i_row = 0 ; i_row < count ; i_row++ )
		{
			egovframework.rte.psl.dataaccess.util.EgovMap m =
					(egovframework.rte.psl.dataaccess.util.EgovMap)list_send.get(i_row);			
			for( Object key : m.keyList() )
			{
				if( m.get(key) != null )
					Response.SetCellData( key.toString(), i_row, m.get(key).toString() );
			}
		}
	}
	
	
	public void SUB_SetResultSet(ScriptableODWParameter Response,String st_name, List<?> list_send )
	{
		int count = list_send.size();
		for( int i_row = 0 ; i_row < count ; i_row++ )
		{
			egovframework.rte.psl.dataaccess.util.EgovMap m =
					(egovframework.rte.psl.dataaccess.util.EgovMap)list_send.get(i_row);			
			for( Object key : m.keyList() )
			{
				if( m.get(key) != null )
					Response.SUB_SetCellData(st_name, key.toString(), i_row, m.get(key).toString() );
			}
		}
	}
	
}
