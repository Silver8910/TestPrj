package ods.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import ods.vo.BACmpyVO;

@Mapper("bacmpyMapper")
public interface BACmpyMapper {
	List<?> selectBACmpyList(BACmpyVO bacmpyVO) throws Exception;
	List<?> selectBACmpy(BACmpyVO bacmpyVO) throws Exception;
	String selectGenCustCd() throws Exception;
	void insertBACmpy(BACmpyVO bacmpyVO) throws Exception;
	void updateBACmpy(BACmpyVO bacmpyVO) throws Exception;
	void deleteBACmpy(BACmpyVO bacmpyVO) throws Exception;
}
