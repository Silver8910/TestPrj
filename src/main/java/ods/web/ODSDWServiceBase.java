package ods.web;

import java.util.Hashtable;

import opendraft.service.run.javascript.ScriptableODWParameter;
import opendraft.service.run.javascript.ScriptableOpendraftSystem;
import opendraft.service.run.odw.ODWContext;

public interface ODSDWServiceBase {

	
	void OnPutRunner( Hashtable<String,ODSDWServiceBase> map_dw );
	ODSDWServiceBase GetRunner();
	
	boolean RunDW( 
			ODWContext odw_ctx,
			Object ctll, 
			String method_type, String method_name,			
			ScriptableOpendraftSystem ODS, 
			ScriptableODWParameter Request, ScriptableODWParameter Response);
}
