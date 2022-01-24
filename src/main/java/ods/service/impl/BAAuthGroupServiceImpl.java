package ods.service.impl;

import java.util.List;
import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import ods.dao.BAAuthGroupDAO;
import ods.service.BAAuthGroupService;
import ods.vo.BAAuthGroupVO;

@Service("baauthGroupService")
public class BAAuthGroupServiceImpl extends EgovAbstractServiceImpl implements BAAuthGroupService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(BAAuthGroupServiceImpl.class);
	
	@Resource(name = "baauthGroupDAO")
	private BAAuthGroupDAO baauthGroupDAO;
	
	@Override
	public List<?> selectBAAuthGroupList(BAAuthGroupVO baauthGroupVO) throws Exception {
		return baauthGroupDAO.selectBAAuthGroupList(baauthGroupVO);
	}
	@Override
	public List<?> selectBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception {
		return baauthGroupDAO.selectBAAuthGroup(baauthGroupVO);
	}
	@Override
	public int insertBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception {
		int GroupID = baauthGroupDAO.selectGenGroupID();
		baauthGroupVO.setGroupID(GroupID);
		baauthGroupDAO.insertBAAuthGroup(baauthGroupVO);
		return GroupID;
	}
	@Override
	public void updateBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception {
		baauthGroupDAO.updateBAAuthGroup(baauthGroupVO);
	}
	@Override
	public void deleteBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception {
		baauthGroupDAO.deleteBAAuthGroup(baauthGroupVO);
	}
}
