package opendraft.spring_adaptor;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

import opendraft.service.hook.dataweaver.SpringRequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;


@Controller
public class OdsRequestMappingReader {

	@Autowired 
	 private RequestMappingHandlerMapping requestMappingHandlerMapping;
	 
	
	
	 public void GetMapList(List<SpringRequestMapping> list_mapping)
	 {
		 
		  Map<RequestMappingInfo, HandlerMethod> map = requestMappingHandlerMapping.getHandlerMethods();
		  
		  for( RequestMappingInfo mi :  map.keySet() )
		  {  
			  HandlerMethod hm  = map.get(mi);
			  
			  
			  String url = mi.getPatternsCondition().getPatterns().toString();
			  String method_name = hm.getMethod().getName();
			  String bean_name = hm.getBean().toString();
			  
			  SpringRequestMapping new_map = new SpringRequestMapping();
			  new_map._url = url;
			  new_map._bean_name = bean_name;
			  new_map._method_name = method_name;
			  list_mapping.add( new_map );
			  
		  }
	 }
}
