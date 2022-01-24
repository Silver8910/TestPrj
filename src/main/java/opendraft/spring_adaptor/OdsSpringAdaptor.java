package opendraft.spring_adaptor;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;

import opendraft.service.hook.dataweaver.SpringRequestMapping;

import opendraft.interfaces.hook.IHookEGavManager;
import opendraft.service.hook.dataweaver.DWRunRequest;
import opendraft.service.hook.dataweaver.DWRunResponse;
import opendraft.spring_adaptor.OdsRequestMappingReader;
import opendraft.spring_adaptor.OpendraftDTC;



public class OdsSpringAdaptor  implements IHookEGavManager {

	public IHookEGavManager GetNewEGav()
	{
		OdsSpringAdaptor egav = new OdsSpringAdaptor();
		return egav;
	}
	
	ServletContext _servelet = null;
	org.springframework.web.context.WebApplicationContext _app_ctx = null;
	public void SetServletContext( ServletContext svl_ctx, ServletRequest request )
	{
		_servelet = svl_ctx;
		
		_app_ctx = 
				org.springframework.web.servlet.support.RequestContextUtils.getWebApplicationContext(
						request, svl_ctx);
		

	}
	
	
	

	public Object GetObject( String class_name )
	{
		try
		{
			ClassLoader classLoader = OdsSpringAdaptor.class.getClassLoader();
	        Class cls_inst = classLoader.loadClass(class_name);
	        
	        return		cls_inst.newInstance();
		}
		catch(Exception e)
		{
			
		}
		
		return null;
	}
	
	
	public Object GetBean( String bean_name )
	{	
		return _app_ctx.getBean(bean_name);
	}
	
	
	
	public String RunSpringController( String map_name, String controller_name, String method_name, 
			DWRunRequest request, DWRunResponse response ) throws Exception
	{
		
		
		//EndpointDocController ec = (EndpointDocController)_app_ctx.getBean("endpointDocController");
		//ec.GetMapList();
		//String[] aaa= _app_ctx.getBeanDefinitionNames();
				
		
		Object obj = _app_ctx.getBean( controller_name);
		
		Class[] arg_get = new Class[1];
		arg_get[0] = OpendraftDTC.class;
		Method m = obj.getClass().getMethod(method_name, arg_get);
		
		
		
		OpendraftDTC od_dtc = new OpendraftDTC(request, response);
		Object[] arg = new Object[1];
		arg[0] = od_dtc;
		
        Object ret = m.invoke(obj, arg );
              
		
		return ret.toString();
	}
	
	
	public void GetRequestMappingList( List<SpringRequestMapping> list_mapping )
	{
		OdsRequestMappingReader map_reader = (OdsRequestMappingReader)_app_ctx.getBean( "odsRequestMappingReader" );
		map_reader.GetMapList( list_mapping );
		
		//OdsRequestMappingReader
	}
	
}
