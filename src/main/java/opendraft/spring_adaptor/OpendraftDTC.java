package opendraft.spring_adaptor;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import opendraft.service.hook.dataweaver.DWRunRequest;
import opendraft.service.hook.dataweaver.DWRunResponse;
import opendraft.service.run.odw.ODWContext;

public class OpendraftDTC {

	DWRunRequest _request = null; 
	DWRunResponse _response = null;
	
	
	public OpendraftDTC( DWRunRequest request, DWRunResponse response )
	{
		_request = request;
		_response = response;
	}
	
	
	public boolean IsPageUse()
    {
    	return _request.IsPageUse();
    }
    
    public int GetPageIndex()
    {
    	return _request.GetPageIndex();
    }
    
    public int GetPageRecordCount()
    {
    	return _request.GetPageRecordCount();
    }
    
    public void SetTotalRecordCount(int row_count)
    {
    	_request.SetTotalRecordCount( row_count );
    }
	
    
    public String GetRunParam()
    {
    	return _request._run_param1;
    }
    
    
    
    
    public List<Map> GetInputParam()
    {
    	List<Map> list = new ArrayList<Map>();
    	Hashtable map = null;
    	
    	
    	int record_count =_request.getParamRecordCount(); 
    	if( record_count < 1 )
    	{
	    	map = new Hashtable();
	    	list.add(map );
	    	
	    	for( ODWContext.COL_DATA ci : _request._list_col)
			{
				map.put( ci._col_name, _request.ParamGet( ci._col_name ) );
			}
    	}
    	else
    	{
    		for( int i = 0 ; i < record_count ; i++ )
    		{
    			map = new Hashtable();
    			list.add(map );
    			
    			for( ODWContext.COL_DATA ci : _request._list_col)
    			{
    				map.put( ci._col_name, _request.ParamGetRecord( ci._col_name, i ) );
    			}
    			
    		}
    	}
    	
    
    	return list;
    }
	
    
    public List<Map> GetInputSubTable(String sub_table)
    {
    	List<Map> list = new ArrayList<Map>();
    	Hashtable map = null;
    	
    	
    	ODWContext.SUBTABLE_DATA st = _request.GetSubTable( sub_table );
    	if( st != null )
    	{
    		int count = _request.SUB_GetRecordCount( sub_table );
    		for( int i = 0 ; i < count; i++ )
    		{
    			map = new Hashtable();
    			list.add(map );
    			
    			for( ODWContext.COL_DATA ci : st._list_col)
    			{
    				if( st.GetParamValue( ci._col_name, i ) )    				
    					map.put( ci._col_name, st._param_val_out );
    				else
    					map.put( ci._col_name, "" );
    			}	
    		}
    	}
    	
    	return list;
    }
    
    
     
    public void SetOutputParam( String param_name, int i_row, String val)
    {    	
    	_response.SetData( param_name, i_row, val );
    }
    
    public void SetOutputSubTable( String st_name, List<Map> list  )
    {
    	ODWContext.SUBTABLE_DATA st = _response.GetSubTable( st_name );
    	if( st == null )
    		return;
    	
    	int i_row = 0;
    	for( Map map : list )
    	{
    		for( Object key : map.keySet() )
    		{
    			st.SetCellData( key.toString(), i_row, map.get(key).toString() );
    		}
    		
    		i_row++;
    	}    	
    }
    
    public void SetOutputSubTableCell( String st_name, String col_name, int i_row, String val  )
    {
    	ODWContext.SUBTABLE_DATA st = _response.GetSubTable( st_name );
    	if( st == null )
    		return;
    	
    	st.SetCellData( col_name, i_row, val );
    }
    
    
    
}
