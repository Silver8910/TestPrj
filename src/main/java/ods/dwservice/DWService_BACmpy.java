package ods.dwservice;

import java.util.Hashtable;
import java.util.List;

import ods.controller.OdsController;
import ods.vo.BACmpyVO;
import ods.vo.BAHrVO;
import ods.web.ODSDWServiceBase;
import ods.web.ODSDWServiceBaseImpl;

public class DWService_BACmpy extends ODSDWServiceBaseImpl {
	public ODSDWServiceBase GetRunner()
	{
		return new DWService_BACmpy();
	}
	
	public void OnPutRunner( Hashtable<String,ODSDWServiceBase> map_dw )
	{
		String key = "";
		
		key = "BACmpy_egov:query:query_rn";
		map_dw.put( key.toUpperCase(), this );
		
		// 이렇게 계속 추가.
		key = "BACmpy_egov:query:query_detail";
		map_dw.put( key.toUpperCase(), this );

		key = "BACmpy_egov:insert:insert_md";
		map_dw.put( key.toUpperCase(), this );

		key = "BACmpy_egov:update:update_md";
		map_dw.put( key.toUpperCase(), this );

		key = "BACmpy_egov:delete:delete_md";
		map_dw.put( key.toUpperCase(), this );

		key = "BACmpy_egov:delete:delete_sc";
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
		BACmpyVO bacmpyVO = new BACmpyVO();
		bacmpyVO.setCustCd(Request.ParamGet("CustCd"));
		bacmpyVO.setCustNm(Request.ParamGet("CustNm"));
		bacmpyVO.setBizRegNo(Request.ParamGet("BizRegNo"));
		bacmpyVO.setCmpyApNo(Request.ParamGet("CmpyApNo"));
		bacmpyVO.setReprHrNm(Request.ParamGet("ReprHrNm"));
		bacmpyVO.setReprTelNo(Request.ParamGet("ReprTelNo"));
		bacmpyVO.setPostCd(Request.ParamGet("PostCd"));
		bacmpyVO.setAddr(Request.ParamGet("Addr"));
		bacmpyVO.setAddr2(Request.ParamGet("Addr2"));
		bacmpyVO.setCBTYN(Request.ParamGet("CBTYN"));
		bacmpyVO.setRemark(Request.ParamGet("Remark"));
		bacmpyVO.setUseYN(Request.ParamGet("UseYN"));
		bacmpyVO.setStampImg(Request.ParamGet("StampImg"));
		bacmpyVO.setSignImg(Request.ParamGet("SignImg"));
		bacmpyVO.setApUserID(Request.ParamGet("ApUserID"));
		bacmpyVO.setApDt(Request.ParamGet("ApDt"));
		bacmpyVO.setUpUserID(Request.ParamGet("UpUserID"));
		bacmpyVO.setUpDt(Request.ParamGet("UpDt"));
		
		if ( method_name.compareToIgnoreCase("query_rn") == 0 ) {			
			List<?> RsltList = ctll.bacmpyService.selectBACmpyList(bacmpyVO);
			
			this.SetResultSet(Response, RsltList);
		}
		else if ( method_name.compareToIgnoreCase("query_detail") == 0 ) {
			List<?> RsltList = ctll.bacmpyService.selectBACmpy(bacmpyVO);
			this.SUB_SetResultSet(Response, "STMST", RsltList);
			
			BAHrVO bahrVO = new BAHrVO();
			bahrVO.setCustCd(Request.ParamGet("CustCd"));
			List<?> RsltListHr = ctll.bahrService.selectBAHrCust(bahrVO);
			this.SUB_SetResultSet(Response, "ST01", RsltListHr);
		}
	}

	void OnInsert(String method_name) throws Exception {
		BACmpyVO bacmpyVO = new BACmpyVO();
		bacmpyVO.setCustCd(Request.SUB_GetCellData("STMST", "CustCd", 0));
		bacmpyVO.setCustNm(Request.SUB_GetCellData("STMST", "CustNm", 0));
		bacmpyVO.setBizRegNo(Request.SUB_GetCellData("STMST", "BizRegNo", 0));
		bacmpyVO.setCmpyApNo(Request.SUB_GetCellData("STMST", "CmpyApNo", 0));
		bacmpyVO.setReprHrNm(Request.SUB_GetCellData("STMST", "ReprHrNm", 0));
		bacmpyVO.setReprTelNo(Request.SUB_GetCellData("STMST", "ReprTelNo", 0));
		bacmpyVO.setPostCd(Request.SUB_GetCellData("STMST", "PostCd", 0));
		bacmpyVO.setAddr(Request.SUB_GetCellData("STMST", "Addr", 0));
		bacmpyVO.setAddr2(Request.SUB_GetCellData("STMST", "Addr2", 0));
		bacmpyVO.setCBTYN(Request.SUB_GetCellData("STMST", "CBTYN", 0));
		bacmpyVO.setRemark(Request.SUB_GetCellData("STMST", "Remark", 0));
		bacmpyVO.setUseYN(Request.SUB_GetCellData("STMST", "UseYN", 0));
		bacmpyVO.setStampImg(Request.SUB_GetCellData("STMST", "StampImg", 0));
		bacmpyVO.setSignImg(Request.SUB_GetCellData("STMST", "SignImg", 0));
		bacmpyVO.setApUserID(Request.SUB_GetCellData("STMST", "ApUserID", 0));
		bacmpyVO.setApDt(Request.SUB_GetCellData("STMST", "ApDt", 0));
		bacmpyVO.setUpUserID(Request.SUB_GetCellData("STMST", "UpUserID", 0));
		bacmpyVO.setUpDt(Request.SUB_GetCellData("STMST", "UpDt", 0));
		
		String CustCd = ctll.bacmpyService.insertBACmpy(bacmpyVO);
		Response.SUB_SetCellData("STMST", "CustCd", 0, CustCd);
		
		for ( int i_row = 0 ; i_row < Request.SUB_GetRecordCount("ST01") ; i_row++ ) {
			BAHrVO bahrVO = new BAHrVO();
			bahrVO.setHrCd(Request.SUB_GetCellData("ST01", "HrCd", i_row));
			bahrVO.setHrNm(Request.SUB_GetCellData("ST01", "HrNm", i_row));
			bahrVO.setUserTp(Request.SUB_GetCellData("ST01", "UserTp", i_row));
			bahrVO.setUserID(Request.SUB_GetCellData("ST01", "UserID", i_row));
			bahrVO.setPwd(Request.SUB_GetCellData("ST01", "Pwd", i_row));
			bahrVO.setUserKey(Request.SUB_GetCellData("ST01", "UserKey", i_row));
			bahrVO.setTelNo(Request.SUB_GetCellData("ST01", "TelNo", i_row));
			bahrVO.setHPhone(Request.SUB_GetCellData("ST01", "HPhone", i_row));
			bahrVO.setEMail(Request.SUB_GetCellData("ST01", "EMail", i_row));
			bahrVO.setPostCd(Request.SUB_GetCellData("ST01", "PostCd", i_row));
			bahrVO.setAddr(Request.SUB_GetCellData("ST01", "Addr", i_row));
			bahrVO.setAddr2(Request.SUB_GetCellData("ST01", "Addr2", i_row));
			bahrVO.setCustCd(CustCd);
			bahrVO.setMngYN(Request.SUB_GetCellData("ST01", "MngYN", i_row));
			bahrVO.setSignMngYN(Request.SUB_GetCellData("ST01", "SignMngYN", i_row));
			bahrVO.setDeptNm(Request.SUB_GetCellData("ST01", "DeptNm", i_row));
			bahrVO.setPosNm(Request.SUB_GetCellData("ST01", "PosNm", i_row));
			bahrVO.setRemark(Request.SUB_GetCellData("ST01", "Remark", i_row));
			bahrVO.setUseYN(Request.SUB_GetCellData("ST01", "UseYN", i_row));
			bahrVO.setUserTermsTm(Request.SUB_GetCellData("ST01", "UserTermsTm", i_row));
			bahrVO.setProtectTermsTm(Request.SUB_GetCellData("ST01", "ProtectTermsTm", i_row));
			bahrVO.setStampImg(Request.SUB_GetCellData("ST01", "StampImg", i_row));
			bahrVO.setSignImg(Request.SUB_GetCellData("ST01", "SignImg", i_row));
			bahrVO.setApUserID(Request.SUB_GetCellData("ST01", "ApUserID", i_row));
			bahrVO.setApDt(Request.SUB_GetCellData("ST01", "ApDt", i_row));
			bahrVO.setUpUserID(Request.SUB_GetCellData("ST01", "UpUserID", i_row));
			bahrVO.setUpDt(Request.SUB_GetCellData("ST01", "UpDt", i_row));
			
			String HrCd = Request.SUB_GetCellData("ST01", "HrCd", i_row);
			if ( Request.SUB_GetCellData("ST01", "ods_modify_flag", i_row).equals("1") ) {
				HrCd = ctll.bahrService.insertBAHr(bahrVO);
			}
			else if ( Request.SUB_GetCellData("ST01", "ods_modify_flag", i_row).equals("2") ) {
				ctll.bahrService.updateBAHr(bahrVO);
			}
			else if ( Request.SUB_GetCellData("ST01", "ods_modify_flag", i_row).equals("3") ) {
				ctll.bahrService.deleteBAHr(bahrVO);
			}
			
			Response.SUB_SetCellData("ST01", "HrCd", i_row, HrCd);
		}
	}

	void OnUpdate(String method_name) throws Exception {
		BACmpyVO bacmpyVO = new BACmpyVO();
		bacmpyVO.setCustCd(Request.SUB_GetCellData("STMST", "CustCd", 0));
		bacmpyVO.setCustNm(Request.SUB_GetCellData("STMST", "CustNm", 0));
		bacmpyVO.setBizRegNo(Request.SUB_GetCellData("STMST", "BizRegNo", 0));
		bacmpyVO.setCmpyApNo(Request.SUB_GetCellData("STMST", "CmpyApNo", 0));
		bacmpyVO.setReprHrNm(Request.SUB_GetCellData("STMST", "ReprHrNm", 0));
		bacmpyVO.setReprTelNo(Request.SUB_GetCellData("STMST", "ReprTelNo", 0));
		bacmpyVO.setPostCd(Request.SUB_GetCellData("STMST", "PostCd", 0));
		bacmpyVO.setAddr(Request.SUB_GetCellData("STMST", "Addr", 0));
		bacmpyVO.setAddr2(Request.SUB_GetCellData("STMST", "Addr2", 0));
		bacmpyVO.setCBTYN(Request.SUB_GetCellData("STMST", "CBTYN", 0));
		bacmpyVO.setRemark(Request.SUB_GetCellData("STMST", "Remark", 0));
		bacmpyVO.setUseYN(Request.SUB_GetCellData("STMST", "UseYN", 0));
		bacmpyVO.setStampImg(Request.SUB_GetCellData("STMST", "StampImg", 0));
		bacmpyVO.setSignImg(Request.SUB_GetCellData("STMST", "SignImg", 0));
		bacmpyVO.setApUserID(Request.SUB_GetCellData("STMST", "ApUserID", 0));
		bacmpyVO.setApDt(Request.SUB_GetCellData("STMST", "ApDt", 0));
		bacmpyVO.setUpUserID(Request.SUB_GetCellData("STMST", "UpUserID", 0));
		bacmpyVO.setUpDt(Request.SUB_GetCellData("STMST", "UpDt", 0));
		
		String CustCd = Request.SUB_GetCellData("STMST", "CustCd", 0);
		Response.SUB_SetCellData("STMST", "CustCd", 0, CustCd);
		
		for ( int i_row = 0 ; i_row < Request.SUB_GetRecordCount("ST01") ; i_row++ ) {
			BAHrVO bahrVO = new BAHrVO();
			bahrVO.setHrCd(Request.SUB_GetCellData("ST01", "HrCd", i_row));
			bahrVO.setHrNm(Request.SUB_GetCellData("ST01", "HrNm", i_row));
			bahrVO.setUserTp(Request.SUB_GetCellData("ST01", "UserTp", i_row));
			bahrVO.setUserID(Request.SUB_GetCellData("ST01", "UserID", i_row));
			bahrVO.setPwd(Request.SUB_GetCellData("ST01", "Pwd", i_row));
			bahrVO.setUserKey(Request.SUB_GetCellData("ST01", "UserKey", i_row));
			bahrVO.setTelNo(Request.SUB_GetCellData("ST01", "TelNo", i_row));
			bahrVO.setHPhone(Request.SUB_GetCellData("ST01", "HPhone", i_row));
			bahrVO.setEMail(Request.SUB_GetCellData("ST01", "EMail", i_row));
			bahrVO.setPostCd(Request.SUB_GetCellData("ST01", "PostCd", i_row));
			bahrVO.setAddr(Request.SUB_GetCellData("ST01", "Addr", i_row));
			bahrVO.setAddr2(Request.SUB_GetCellData("ST01", "Addr2", i_row));
			bahrVO.setCustCd(CustCd);
			bahrVO.setMngYN(Request.SUB_GetCellData("ST01", "MngYN", i_row));
			bahrVO.setSignMngYN(Request.SUB_GetCellData("ST01", "SignMngYN", i_row));
			bahrVO.setDeptNm(Request.SUB_GetCellData("ST01", "DeptNm", i_row));
			bahrVO.setPosNm(Request.SUB_GetCellData("ST01", "PosNm", i_row));
			bahrVO.setRemark(Request.SUB_GetCellData("ST01", "Remark", i_row));
			bahrVO.setUseYN(Request.SUB_GetCellData("ST01", "UseYN", i_row));
			bahrVO.setUserTermsTm(Request.SUB_GetCellData("ST01", "UserTermsTm", i_row));
			bahrVO.setProtectTermsTm(Request.SUB_GetCellData("ST01", "ProtectTermsTm", i_row));
			bahrVO.setStampImg(Request.SUB_GetCellData("ST01", "StampImg", i_row));
			bahrVO.setSignImg(Request.SUB_GetCellData("ST01", "SignImg", i_row));
			bahrVO.setApUserID(Request.SUB_GetCellData("ST01", "ApUserID", i_row));
			bahrVO.setApDt(Request.SUB_GetCellData("ST01", "ApDt", i_row));
			bahrVO.setUpUserID(Request.SUB_GetCellData("ST01", "UpUserID", i_row));
			bahrVO.setUpDt(Request.SUB_GetCellData("ST01", "UpDt", i_row));
			
			String HrCd = Request.SUB_GetCellData("ST01", "HrCd", i_row);
			if ( Request.SUB_GetCellData("ST01", "ods_modify_flag", i_row).equals("1") ) {
				HrCd = ctll.bahrService.insertBAHr(bahrVO);
			}
			else if ( Request.SUB_GetCellData("ST01", "ods_modify_flag", i_row).equals("2") ) {
				ctll.bahrService.updateBAHr(bahrVO);
			}
			else if ( Request.SUB_GetCellData("ST01", "ods_modify_flag", i_row).equals("3") ) {
				ctll.bahrService.deleteBAHr(bahrVO);
			}
			
			Response.SUB_SetCellData("ST01", "HrCd", i_row, HrCd);
		}
	}

	void OnDelete(String method_name) throws Exception {
		BACmpyVO bacmpyVO = new BACmpyVO();
		bacmpyVO.setCustCd(Request.ParamGet("CustCd"));
		ctll.bacmpyService.deleteBACmpy(bacmpyVO);
	}
}
