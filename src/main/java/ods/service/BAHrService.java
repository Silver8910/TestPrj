package ods.service;

import java.util.List;

import ods.vo.BAHrVO;

public interface BAHrService {
	List<?> selectBAHrList(BAHrVO bahrVO) throws Exception;
	List<?> selectBAHr(BAHrVO bahrVO) throws Exception;
	List<?> selectBAHrCust(BAHrVO bahrVO) throws Exception;
	String insertBAHr(BAHrVO bahrVO) throws Exception;
	void updateBAHr(BAHrVO bahrVO) throws Exception;
	void deleteBAHr(BAHrVO bahrVO) throws Exception;
}
