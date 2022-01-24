package ods.service;

import java.util.List;

import ods.vo.BACmpyVO;

public interface BACmpyService {
	List<?> selectBACmpyList(BACmpyVO bacmpyVO) throws Exception;
	List<?> selectBACmpy(BACmpyVO bacmpyVO) throws Exception;
	String insertBACmpy(BACmpyVO bacmpyVO) throws Exception;
	void updateBACmpy(BACmpyVO bacmpyVO) throws Exception;
	void deleteBACmpy(BACmpyVO bacmpyVO) throws Exception;
}
