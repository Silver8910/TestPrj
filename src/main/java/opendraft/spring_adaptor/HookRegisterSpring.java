package opendraft.spring_adaptor;



import odsx.hook_impl.HookPDFBuilder_Impl;
import opendraft.interfaces.hook.IHookManager;


public class HookRegisterSpring  extends opendraft.interfaces.hook.HookRegisterBase  {

	public void RegistHook_PDF(IHookManager hook_manager)
	{
		System.out.println( "regist pdf - start \n" );
		
		//hook pdf
		try
		{
			HookPDFBuilder_Impl pdf_builder = new HookPDFBuilder_Impl();
			hook_manager.Regist_PDFBuilder( pdf_builder );
		}
		catch(Exception exp )
		{
			System.out.println( "regist pdf - error \n" );
			System.out.println( exp.toString() );
		}
	}


	
	public void RegistHook_DataWeaver(IHookManager hook_manager)
	{	
		System.out.println( "regist dw - start \n" );
		
		try
		{
			OdsSpringAdaptor egav_mng = new OdsSpringAdaptor();
			hook_manager.Regist_EGavManager( egav_mng );
		}
		catch(Exception exp)
		{
			System.out.println( "regist dw - error \n" );
			System.out.println( exp.toString() );
		}
		
		//hook dataweaver
		//DW_Sample1 dw_sample1 = new DW_Sample1();	
		//hook_manager.Regist_DataWeaver("hook_test", "query", "query_test", dw_sample1);
		
	}
}
