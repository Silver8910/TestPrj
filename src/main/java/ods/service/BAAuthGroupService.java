package ods.service;

import java.util.List;

import ods.vo.BAAuthGroupVO;


public interface BAAuthGroupService {
	List<?> selectBAAuthGroupList(BAAuthGroupVO baauthGroupVO) throws Exception;
	List<?> selectBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception;
	int insertBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception;
	void updateBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception;
	void deleteBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception;
}
