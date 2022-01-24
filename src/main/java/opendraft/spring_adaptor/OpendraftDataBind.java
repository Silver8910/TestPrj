package opendraft.spring_adaptor;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import opendraft.lang.xml.OdXmlDocument;
import opendraft.lang.xml.OdXmlElement;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;


public class OpendraftDataBind {

	boolean _use_base_64 = false;
	boolean _use_json = true;
	
	
	public String _sid = "";
	
	public String _dw_name = "";
	public String _method_name = "";
	
	
	public String _error_system = "";
	
	
	// page navi
	public boolean _page_navi_use = false;    	
	public int _page_navi_cur_page  = 0;
	public int _page_navi_row_count = 20;
	public int _page_total_row_count = 20;
	
	
	
	// data struct
	int _row_count = 0;
	ArrayList<opendraft.api.argo.ArgoODW_COL_DATA> _list_col = new ArrayList<opendraft.api.argo.ArgoODW_COL_DATA>();
	Hashtable<String,opendraft.api.argo.ArgoODW_COL_DATA> _map_col = new Hashtable<String,opendraft.api.argo.ArgoODW_COL_DATA>();
	
	ArrayList<opendraft.api.argo.ArgoODW_SUBTABLE_DATA> _list_st = new ArrayList<opendraft.api.argo.ArgoODW_SUBTABLE_DATA>(); 
	Hashtable<String,opendraft.api.argo.ArgoODW_SUBTABLE_DATA> _map_st = new Hashtable<String,opendraft.api.argo.ArgoODW_SUBTABLE_DATA>();
	
	
	// send data
	int _row_count_send = 0;
	ArrayList<opendraft.api.argo.ArgoODW_COL_DATA> _list_col_send = new ArrayList<opendraft.api.argo.ArgoODW_COL_DATA>();
	Hashtable<String,opendraft.api.argo.ArgoODW_COL_DATA> _map_col_send = new Hashtable<String,opendraft.api.argo.ArgoODW_COL_DATA>();
	
	ArrayList<opendraft.api.argo.ArgoODW_SUBTABLE_DATA> _list_st_send = new ArrayList<opendraft.api.argo.ArgoODW_SUBTABLE_DATA>(); 
	Hashtable<String,opendraft.api.argo.ArgoODW_SUBTABLE_DATA> _map_st_send = new Hashtable<String,opendraft.api.argo.ArgoODW_SUBTABLE_DATA>();
	
	
	
	
	public String GetReqData( String col_name, int row)
	{
		if( !this._map_col.containsKey( col_name.toUpperCase() ) )
			return "";
		
		opendraft.api.argo.ArgoODW_COL_DATA col_data = this._map_col.get(col_name.toUpperCase() );
		if( col_data._list_val.size() > row )
			return col_data._list_val.get(row);
		
		return "";
	}
	
	
	public void SetSendData( String col_name, int row, int data )
	{
		SetSendData(  col_name,  row, String.valueOf(data) );
	}
	public void SetSendData( String col_name, int row, String data )
	{
		if( !this._map_col_send.containsKey( col_name.toUpperCase() ) )
			return;
		
		opendraft.api.argo.ArgoODW_COL_DATA col_data = this._map_col_send.get(col_name.toUpperCase() );
		while( col_data._list_val.size() < row+1 )
			col_data._list_val.add("");
		
		col_data._list_val.set( row, data );
		if( this._row_count_send < col_data._list_val.size() )
			this._row_count_send = col_data._list_val.size();
	}
	
	
	
	public void SetResultSet( String sub_table, List<?> list_send )
	{
		int count = list_send.size();
		for( int i_row = 0 ; i_row < count ; i_row++ )
		{
			egovframework.rte.psl.dataaccess.util.EgovMap m =
					(egovframework.rte.psl.dataaccess.util.EgovMap)list_send.get(i_row);			
			for( Object key : m.keyList() )
			{
				if( m.get(key) != null )
					this.SetSendData( key.toString(), i_row, m.get(key).toString() );
			}
		}
	}
	
	
	
	
	public boolean ReadData( String body_data )
	{
		try
		{
			if( body_data.indexOf("xml:") == 0 )
			{
				_use_base_64 = true;
				_use_json = false;
			
				body_data = body_data.substring( 4 );
				
				return ReadData_Xml( body_data );
			}
			
			
			return ReadData_Json( body_data );
		}
		catch(Exception exp)
		{
			this._error_system = exp.toString();
			return false;
		}
	}
	
	
	
	
	private boolean ReadData_Json( String body_data )
	{
		JSONTokener tokener = new JSONTokener( body_data );
        JSONObject dom = new JSONObject(tokener);
        
        
        
        
        
        JSONObject ele_root = dom.getJSONObject("ods_http_rpc");
        
        JSONObject ele_data = ele_root.getJSONObject("data");
        JSONObject ele_catalog = ele_root.getJSONObject("catalog");
        
        if( ele_data == null || ele_catalog == null )
        {
        	_error_system = "Data format error.";
        	return false;
        }


        
        // catalog
        _sid = ele_catalog.getString("sid");
        _dw_name = ele_catalog.getString("odw_name");
        _method_name = ele_catalog.getString("method_name" );
        
        
        // page navi
        this._page_navi_use = false;
        if( ele_catalog.has("page_navi_use"))
        {
		    if( ele_catalog.getString("page_navi_use").compareTo("1") == 0 )
		    {
		    	this._page_navi_use = true;
		    	this._page_navi_cur_page = Integer.parseInt( ele_catalog.getString("page_navi_cur_page") );
		    	this._page_navi_row_count = Integer.parseInt( ele_catalog.getString("page_navi_row_count") );
		    	
		    	if( this._page_navi_row_count < 1 )
		    		this._page_navi_row_count = 20;
		    		
		    }
        }
        
        
        

        JSONArray ele_list_col = ele_catalog.getJSONArray("list_col");
        
        int count_col = ele_list_col.length();
        for( int i_col = 0 ; i_col < count_col ; i_col++ )
        {
        	JSONObject ele_col = ele_list_col.getJSONObject( i_col );
        	
        	opendraft.api.argo.ArgoODW_COL_DATA col_data = new opendraft.api.argo.ArgoODW_COL_DATA();
        	opendraft.api.argo.ArgoODW_COL_DATA col_data_send = new opendraft.api.argo.ArgoODW_COL_DATA();
        	
        	col_data._col_name = ele_col.getString("col_name");
        	col_data_send._col_name = ele_col.getString("col_name");
        	
        	this._list_col.add( col_data );
        	if( !this._map_col.containsKey( col_data._col_name.toUpperCase() ) )
        		this._map_col.put(col_data._col_name.toUpperCase(), col_data );
        	
        	// send
        	this._list_col_send.add( col_data_send );
        	if( !this._map_col_send.containsKey( col_data_send._col_name.toUpperCase() ) )
        		this._map_col_send.put(col_data_send._col_name.toUpperCase(), col_data_send );
        }
        


        JSONArray ele_list_st = ele_catalog.getJSONArray("list_st");
        int count_st = ele_list_st.length();
        
        for( int i_st = 0 ; i_st < count_st ; i_st++ )
        {
        	JSONObject ele_st_root = ele_list_st.getJSONObject(i_st);
        	
        	opendraft.api.argo.ArgoODW_SUBTABLE_DATA st = new opendraft.api.argo.ArgoODW_SUBTABLE_DATA();
        	opendraft.api.argo.ArgoODW_SUBTABLE_DATA st_send = new opendraft.api.argo.ArgoODW_SUBTABLE_DATA();
        	
        	st._name = ele_st_root.getString("name");
        	st_send._name = ele_st_root.getString("name");
        	
        	
        	this._list_st.add( st );
        	if( !this._map_st.containsKey(st._name.toUpperCase() ) )
        		this._map_st.put(st._name.toUpperCase(), st );
        	
        	
        	// send
        	this._list_st_send.add( st_send );
        	if( !this._map_st_send.containsKey(st_send._name.toUpperCase() ) )
        		this._map_st_send.put(st_send._name.toUpperCase(), st_send );
        	
        	
        	ele_list_col =ele_st_root.getJSONArray("list_col"); 
        	count_col = ele_list_col.length();
        	
        	for( int i_col = 0 ; i_col < count_col ; i_col++ )
            {
            	JSONObject ele_col = ele_list_col.getJSONObject( i_col );
            	
            	opendraft.api.argo.ArgoODW_COL_DATA col_data = new opendraft.api.argo.ArgoODW_COL_DATA();
            	opendraft.api.argo.ArgoODW_COL_DATA col_data_send = new opendraft.api.argo.ArgoODW_COL_DATA();
            	
            	col_data._col_name = ele_col.getString("col_name");
            	col_data_send._col_name = ele_col.getString("col_name");
            	
            	st._list_col.add( col_data );
            	if( !st._map_col.containsKey( col_data._col_name.toUpperCase() ) )
            		st._map_col.put(col_data._col_name.toUpperCase(), col_data );
            	
            	
            	// send
            	st_send._list_col.add( col_data_send );
            	if( !st_send._map_col.containsKey( col_data_send._col_name.toUpperCase() ) )
            		st_send._map_col.put(col_data_send._col_name.toUpperCase(), col_data_send );
            }
        	
        }

        

        


        // read data
        JSONObject ele_data_main_root = ele_data.getJSONObject("data_main");
        if (ele_data_main_root != null)
        {
        	JSONArray ele_data_main = ele_data_main_root.getJSONArray("data");
        	
            _row_count = ele_data_main.length();
            for (int i_row = 0; i_row < _row_count; i_row++)
            {
                JSONObject ele_row = ele_data_main.getJSONObject(i_row);

                for (opendraft.api.argo.ArgoODW_COL_DATA col_info : _list_col)
                {
                	String str_cell_val = "";
                	
                	
                	if( ele_row.has(col_info._col_name) && !ele_row.isNull(col_info._col_name) )
                	{
                		str_cell_val = ele_row.get(col_info._col_name).toString();
                		//str_cell_val = ele_row.getString( col_info._col_name);
                	}
                	
                    if (str_cell_val == null)
                        str_cell_val = "";

                    col_info._list_val.add(str_cell_val);
                }
            }


            // 빈값 채우기.
            for (opendraft.api.argo.ArgoODW_COL_DATA col_info : _list_col)
            {
                while (col_info._list_val.size() < _row_count)
                    col_info._list_val.add("");
            }
        }



        // sub table
        JSONArray ele_data_list_st = ele_data.getJSONArray("list_st");
        if (ele_data_list_st != null)
        {
            int count_sub_table = ele_data_list_st.length();
            for (int i_st = 0; i_st < count_sub_table; i_st++)
            {
                JSONObject ele_st_root = ele_data_list_st.getJSONObject(i_st);
                String str_st_name = ele_st_root.getString("name");
                
                


                opendraft.api.argo.ArgoODW_SUBTABLE_DATA st_result = null;
                if (!_map_st.containsKey(str_st_name.toUpperCase()))
                {
                    st_result = new opendraft.api.argo.ArgoODW_SUBTABLE_DATA();
                    st_result._name = str_st_name;

                    _map_st.put(st_result._name.toUpperCase(), st_result);
                    _list_st.add(st_result);

                }
                else
                {
                    st_result = _map_st.get(str_st_name.toUpperCase());
                }
                
                
                JSONArray ele_st = ele_st_root.getJSONArray("data");
                //st_result._row_count = Integer.parseInt( ele_st.GetAttribute("row_count"));
                st_result._row_count = ele_st.length();
                

                for (int i_row = 0; i_row < st_result._row_count; i_row++)
                {
                    JSONObject ele_row = ele_st.getJSONObject(i_row);
                    for (opendraft.api.argo.ArgoODW_COL_DATA col_info : st_result._list_col)
                    {
                    	String str_cell_val = "";
                    	//if( ele_row.has(col_info._col_name) )
                    	//	str_cell_val = ele_row.getString(col_info._col_name);
                    	if( ele_row.has(col_info._col_name) && !ele_row.isNull(col_info._col_name) )
                    	{
                    		str_cell_val = ele_row.get(col_info._col_name).toString();
                    	}
                    	
                        if (str_cell_val == null)
                            str_cell_val = "";

                        col_info._list_val.add(str_cell_val);
                    }
                }


                // 빈값 채우기.
                for (opendraft.api.argo.ArgoODW_COL_DATA col_info : st_result._list_col)
                {
                    while (col_info._list_val.size() < st_result._row_count)
                        col_info._list_val.add("");
                }

            }
        }

        
		
		
		return true;
	}
	
	
	
	
	
	
	private boolean ReadData_Xml( String body_data )
	{
		body_data = opendraft.lang.OdsBase64.FromBase64String( body_data );		
		OdXmlDocument dom = new OdXmlDocument(); 
		dom.LoadXml( body_data );
		
		
		
		
        OdXmlElement ele_data = dom.SelectSingleNode("/ods_http_rpc/data");
        OdXmlElement ele_catalog = dom.SelectSingleNode("/ods_http_rpc/catalog");
        
        if( ele_data == null || ele_catalog == null )
        {
        	_error_system = "Data format error.";
        	return false;
        }


        
        // catalog
        _sid = ele_catalog.GetAttribute("sid");
        _dw_name = ele_catalog.GetAttribute("odw_name");
        _method_name = ele_catalog.GetAttribute("method_name" );

        OdXmlElement ele_list_col = ele_catalog.SelectSingleNode("list_col");
        int count_col = ele_list_col.GetCount();
        for( int i_col = 0 ; i_col < count_col ; i_col++ )
        {
        	OdXmlElement ele_col = ele_list_col.GetItem( i_col );
        	
        	opendraft.api.argo.ArgoODW_COL_DATA col_data = new opendraft.api.argo.ArgoODW_COL_DATA();
        	opendraft.api.argo.ArgoODW_COL_DATA col_data_send = new opendraft.api.argo.ArgoODW_COL_DATA();
        	
        	col_data._col_name = ele_col.GetAttribute("col_name");
        	col_data_send._col_name = ele_col.GetAttribute("col_name");
        	
        	this._list_col.add( col_data );
        	if( !this._map_col.containsKey( col_data._col_name.toUpperCase() ) )
        		this._map_col.put(col_data._col_name.toUpperCase(), col_data );
        	
        	// send
        	this._list_col_send.add( col_data_send );
        	if( !this._map_col_send.containsKey( col_data_send._col_name.toUpperCase() ) )
        		this._map_col_send.put(col_data_send._col_name.toUpperCase(), col_data_send );
        }
        


        OdXmlElement ele_list_st = ele_catalog.SelectSingleNode("list_st");
        int count_st = ele_list_st.GetCount();
        for( int i_st = 0 ; i_st < count_st ; i_st++ )
        {
        	OdXmlElement ele_st = ele_list_st.GetItem(i_st);
        	
        	opendraft.api.argo.ArgoODW_SUBTABLE_DATA st = new opendraft.api.argo.ArgoODW_SUBTABLE_DATA();
        	opendraft.api.argo.ArgoODW_SUBTABLE_DATA st_send = new opendraft.api.argo.ArgoODW_SUBTABLE_DATA();
        	
        	st._name = ele_st.GetAttribute("name");
        	st_send._name = ele_st.GetAttribute("name");
        	
        	this._list_st.add( st );
        	if( !this._map_st.containsKey(st._name.toUpperCase() ) )
        		this._map_st.put(st._name.toUpperCase(), st );
        	
        	
        	// send
        	this._list_st_send.add( st_send );
        	if( !this._map_st_send.containsKey(st_send._name.toUpperCase() ) )
        		this._map_st_send.put(st_send._name.toUpperCase(), st_send );
        	
        	
        	ele_list_col =ele_st.SelectSingleNode("list_col"); 
        	count_col = ele_list_col.GetCount();
        	
        	for( int i_col = 0 ; i_col < count_col ; i_col++ )
            {
            	OdXmlElement ele_col = ele_list_col.GetItem( i_col );
            	
            	opendraft.api.argo.ArgoODW_COL_DATA col_data = new opendraft.api.argo.ArgoODW_COL_DATA();
            	opendraft.api.argo.ArgoODW_COL_DATA col_data_send = new opendraft.api.argo.ArgoODW_COL_DATA();
            	
            	col_data._col_name = ele_col.GetAttribute("col_name");
            	col_data_send._col_name = ele_col.GetAttribute("col_name");
            	
            	st._list_col.add( col_data );
            	if( !st._map_col.containsKey( col_data._col_name.toUpperCase() ) )
            		st._map_col.put(col_data._col_name.toUpperCase(), col_data );
            	
            	
            	// send
            	st_send._list_col.add( col_data_send );
            	if( !st_send._map_col.containsKey( col_data_send._col_name.toUpperCase() ) )
            		st_send._map_col.put(col_data_send._col_name.toUpperCase(), col_data_send );
            }
        	
        }

        

        


        // read data
        OdXmlElement ele_data_main = ele_data.SelectSingleNode("data_main");
        if (ele_data_main != null)
        {
            _row_count = ele_data_main.GetCount();
            for (int i_row = 0; i_row < _row_count; i_row++)
            {
                OdXmlElement ele_row = ele_data_main.GetItem(i_row);

                for (opendraft.api.argo.ArgoODW_COL_DATA col_info : _list_col)
                {
                    String str_cell_val = ele_row.GetAttribute(col_info._col_name);
                    if (str_cell_val == null)
                        str_cell_val = "";

                    col_info._list_val.add(str_cell_val);
                }
            }


            // 빈값 채우기.
            for (opendraft.api.argo.ArgoODW_COL_DATA col_info : _list_col)
            {
                while (col_info._list_val.size() < _row_count)
                    col_info._list_val.add("");
            }
        }



        // sub table
        OdXmlElement ele_data_list_st = ele_data.SelectSingleNode("list_st");
        if (ele_data_list_st != null)
        {
            int count_sub_table = ele_data_list_st.GetCount();
            for (int i_st = 0; i_st < count_sub_table; i_st++)
            {
                OdXmlElement ele_st = ele_data_list_st.GetItem(i_st);
                String str_st_name = ele_st.GetAttribute("name");


                opendraft.api.argo.ArgoODW_SUBTABLE_DATA st_result = null;
                if (!_map_st.containsKey(str_st_name.toUpperCase()))
                {
                    st_result = new opendraft.api.argo.ArgoODW_SUBTABLE_DATA();
                    st_result._name = str_st_name;

                    _map_st.put(st_result._name.toUpperCase(), st_result);
                    _list_st.add(st_result);

                }
                else
                {
                    st_result = _map_st.get(str_st_name.toUpperCase());
                }
                
                //st_result._row_count = Integer.parseInt( ele_st.GetAttribute("row_count"));
                st_result._row_count = ele_st.GetCount();
                

                for (int i_row = 0; i_row < st_result._row_count; i_row++)
                {
                    OdXmlElement ele_row = ele_st.GetItem(i_row);
                    for (opendraft.api.argo.ArgoODW_COL_DATA col_info : st_result._list_col)
                    {
                        String str_cell_val = ele_row.GetAttribute(col_info._col_name);
                        if (str_cell_val == null)
                            str_cell_val = "";

                        col_info._list_val.add(str_cell_val);
                    }
                }


                // 빈값 채우기.
                for (opendraft.api.argo.ArgoODW_COL_DATA col_info : st_result._list_col)
                {
                    while (col_info._list_val.size() < st_result._row_count)
                        col_info._list_val.add("");
                }

            }
        }
				
		
		return true;		
	}
	
	
	
	
	
	
	public String SendError(String error_str )
	{
		if( !this._use_json )
		{
			return SendError_Xml( error_str );
		}
		
		
		
		JSONObject obj_dom = new JSONObject();
		
		JSONObject obj_root = new JSONObject();		
		obj_dom.put("ods_http_rpc", obj_root);
		
		
		JSONObject obj_data = new JSONObject();
		JSONObject obj_catalog = new JSONObject();
		
		
		obj_root.put("data", obj_data);
		obj_root.put("catalog", obj_catalog);
		
		
		obj_catalog.put("odw_name", _dw_name);
		obj_catalog.put("method_name", _method_name);
        
        
		obj_data.put("error", "1");
		obj_data.put("system_error", this._error_system );
		obj_data.put("user_error", error_str );
		
			
	    return obj_dom.toString();
	}
	
	
	
	
	public String SendError_Xml(String error_str )
	{
		// xml 데이터를 만들어서 보낸다.
        OdXmlDocument dom = new OdXmlDocument();
        OdXmlElement ele_root = dom.CreateElement("ods_http_rpc");
        OdXmlElement ele_data = dom.CreateElement("data");
        OdXmlElement ele_catalog = dom.CreateElement("catalog");

        dom.AppendChild(ele_root);
        ele_root.AppendChild(ele_data);
        ele_root.AppendChild(ele_catalog);


        // catalog
        ele_catalog.SetAttribute("odw_name", _dw_name);
        ele_catalog.SetAttribute("method_name", _method_name);
        
        
        ele_data.SetAttribute("error", "1");
        ele_data.SetAttribute("system_error", this._error_system );
        ele_data.SetAttribute("user_error", error_str );
        
        
        return opendraft.lang.OdsBase64.ToBase64String( dom.GetXml() );
	}
	
	
	
	
	public String SendResult()
	{
		if( !this._use_json )
		{
			return SendResult_Xml();
		}
		
		return SendResult_Json();
	}
	
	
	public String SendResult_Json()
	{
		JSONObject obj_dom = new JSONObject();
		
		JSONObject obj_root = new JSONObject();		
		obj_dom.put("ods_http_rpc", obj_root);
		
		
		JSONObject obj_data = new JSONObject();
		JSONObject obj_catalog = new JSONObject();
		
		
		obj_root.put("data", obj_data);
		obj_root.put("catalog", obj_catalog);
		
		
		obj_catalog.put("odw_name", _dw_name);
		obj_catalog.put("method_name", _method_name);
		
		
		// page_navi
		// paging info
        // page navi
        if (this._page_navi_use) {
        	obj_catalog.put("page_navi_use","1");
        	obj_catalog.put("page_navi_cur_page", String.valueOf( this._page_navi_cur_page ));
        	obj_catalog.put("page_navi_row_count", String.valueOf( this._page_navi_row_count ));
        	obj_catalog.put("page_navi_total_row_count", String.valueOf( this._page_total_row_count ));
        }
        
		
		
		JSONArray ele_list_col = new JSONArray();
		obj_catalog.put( "list_col", ele_list_col );
		
        for (opendraft.api.argo.ArgoODW_COL_DATA col_info : _list_col_send )
        {
        	JSONObject ele_col = new JSONObject();
        	ele_list_col.put( ele_col );
            ele_col.put("col_name", col_info._col_name);
        }
        



        JSONArray ele_list_st = new JSONArray();
        obj_catalog.put( "list_st", ele_list_st );
                

        for (opendraft.api.argo.ArgoODW_SUBTABLE_DATA st : _list_st_send)
        {
        	JSONObject ele_st = new JSONObject();
        	ele_list_st.put( ele_st );
        	
            ele_st.put("name", st._name);

            JSONArray ele_list_col_st = new JSONArray();
            ele_st.put("list_col", ele_list_col_st );



            for (opendraft.api.argo.ArgoODW_COL_DATA col_info : st._list_col)
            {
            	JSONObject ele_col = new JSONObject();
            	ele_list_col_st.put( ele_col );
                ele_col.put("col_name", col_info._col_name);
            	
            }
        }

        


        // data
        JSONObject ele_data_main_root = new JSONObject();
        obj_data.put("data_main", ele_data_main_root);

        ele_data_main_root.put("row_count", String.valueOf( _row_count_send ));
        
        JSONArray ele_data_main = new JSONArray();
        ele_data_main_root.put("data", ele_data_main );
        
        
        for (int i_row = 0; i_row < _row_count_send; i_row++)
        {
        	JSONObject ele_row = new JSONObject();
            ele_data_main.put(ele_row);

            for (opendraft.api.argo.ArgoODW_COL_DATA col_info : _list_col_send )
            {
                if (col_info._col_name.length() > 0 && col_info._list_val.size() > i_row)
                    ele_row.put(col_info._col_name, col_info._list_val.get(i_row) );

            }
        }
        
        



        // sub table이 추가 되었다.
        JSONArray ele_data_list_st = new JSONArray();
        obj_data.put("list_st", ele_data_list_st);

        
        for (opendraft.api.argo.ArgoODW_SUBTABLE_DATA st : _list_st_send )
        {
        	JSONObject ele_st_root = new JSONObject();
            ele_data_list_st.put(ele_st_root);

            ele_st_root.put("row_count", String.valueOf(st._row_count ));
            ele_st_root.put("name", st._name);
            
            JSONArray ele_st = new JSONArray();
            ele_st_root.put("data", ele_st);

            for (int i_row = 0; i_row < st._row_count; i_row++)
            {

            	JSONObject ele_row = new JSONObject();
                ele_st.put(ele_row);

                for (opendraft.api.argo.ArgoODW_COL_DATA col_info : st._list_col)
                {

                    if (col_info._col_name.length() > 0 && col_info._list_val.size() > i_row)
                        ele_row.put(col_info._col_name, col_info._list_val.get(i_row) );
                }
            }
        }
        
        
        return obj_dom.toString();
	}
	
	
	public String SendResult_Xml()
	{
		
		// xml 데이터를 만들어서 보낸다.
        OdXmlDocument dom = new OdXmlDocument();
        OdXmlElement ele_root = dom.CreateElement("ods_http_rpc");
        OdXmlElement ele_data = dom.CreateElement("data");
        OdXmlElement ele_catalog = dom.CreateElement("catalog");

        dom.AppendChild(ele_root);
        ele_root.AppendChild(ele_data);
        ele_root.AppendChild(ele_catalog);


        // catalog
        ele_catalog.SetAttribute("odw_name", _dw_name);
        ele_catalog.SetAttribute("method_name", _method_name);

        OdXmlElement ele_list_col = dom.CreateElement("list_col");
        ele_catalog.AppendChild(ele_list_col);

        for (opendraft.api.argo.ArgoODW_COL_DATA col_info : _list_col_send )
        {
            OdXmlElement ele_col = dom.CreateElement("col");
            ele_col.SetAttribute("col_name", col_info._col_name);
            ele_list_col.AppendChild(ele_col);
        }



        OdXmlElement ele_list_st = dom.CreateElement("list_st");
        ele_catalog.AppendChild(ele_list_st);

        for (opendraft.api.argo.ArgoODW_SUBTABLE_DATA st : _list_st_send)
        {
            OdXmlElement ele_st = dom.CreateElement("st");
            ele_list_st.AppendChild(ele_st);

            ele_st.SetAttribute("name", st._name);

            OdXmlElement ele_list_col_st = dom.CreateElement("list_col");
            ele_st.AppendChild(ele_list_col_st);


            for (opendraft.api.argo.ArgoODW_COL_DATA col_info : st._list_col)
            {
                OdXmlElement ele_col = dom.CreateElement("col");
                ele_col.SetAttribute("col_name", col_info._col_name);
                ele_list_col_st.AppendChild(ele_col);
            }
        }

        


        // data
        OdXmlElement ele_data_main = dom.CreateElement("data_main");
        ele_data.AppendChild(ele_data_main);

        ele_data_main.SetAttribute("row_count", String.valueOf( _row_count_send ));
        for (int i_row = 0; i_row < _row_count_send; i_row++)
        {
            OdXmlElement ele_row = dom.CreateElement("r");
            ele_data_main.AppendChild(ele_row);

            for (opendraft.api.argo.ArgoODW_COL_DATA col_info : _list_col_send )
            {
                if (col_info._col_name.length() > 0 && col_info._list_val.size() > i_row)
                    ele_row.SetAttribute(col_info._col_name, col_info._list_val.get(i_row) );

            }
        }



        // sub table이 추가 되었다.
        OdXmlElement ele_data_list_st = dom.CreateElement("list_st");
        ele_data.AppendChild(ele_data_list_st);

        
        for (opendraft.api.argo.ArgoODW_SUBTABLE_DATA st : _list_st_send )
        {
            OdXmlElement ele_st = dom.CreateElement("st");
            ele_data_list_st.AppendChild(ele_st);

            ele_st.SetAttribute("row_count", String.valueOf(st._row_count ));
            ele_st.SetAttribute("name", st._name);

            for (int i_row = 0; i_row < st._row_count; i_row++)
            {

                OdXmlElement ele_row = dom.CreateElement("r");
                ele_st.AppendChild(ele_row);

                for (opendraft.api.argo.ArgoODW_COL_DATA col_info : st._list_col)
                {

                    if (col_info._col_name.length() > 0 && col_info._list_val.size() > i_row)
                        ele_row.SetAttribute(col_info._col_name, col_info._list_val.get(i_row) );
                }
            }
        }
        
        
        return opendraft.lang.OdsBase64.ToBase64String( dom.GetXml() );
	}
	
	
	
	
}
