package ods.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import ods.vo.BAAuthGroupVO;

@Mapper("baauthGroupMapper")
public interface BAAuthGroupMapper {
	List<?> selectBAAuthGroupList(BAAuthGroupVO baauthGroupVO) throws Exception;
	List<?> selectBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception;
	int selectGenGroupID() throws Exception;
	void insertBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception;
	void updateBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception;
	void deleteBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception;
}
