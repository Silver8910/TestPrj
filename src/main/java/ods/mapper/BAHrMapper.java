package ods.mapper;import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import ods.vo.BAHrVO;

@Mapper("bahrMapper")
public interface BAHrMapper {
	List<?> selectBAHrList(BAHrVO bahrVO) throws Exception;
	List<?> selectBAHr(BAHrVO bahrVO) throws Exception;
	List<?> selectBAHrCust(BAHrVO bahrVO) throws Exception;
	String selectGenHrCd() throws Exception;
	void insertBAHr(BAHrVO bahrVO) throws Exception;
	void updateBAHr(BAHrVO bahrVO) throws Exception;
	void deleteBAHr(BAHrVO bahrVO) throws Exception;
}
