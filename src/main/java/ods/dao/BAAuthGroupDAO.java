package ods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import ods.vo.BAAuthGroupVO;

@Repository("baauthGroupDAO")
public class BAAuthGroupDAO extends EgovAbstractDAO{
	public List<?> selectBAAuthGroupList(BAAuthGroupVO baauthGroupVO) throws Exception {
		return list("baauthGroupDAO.selectBAAuthGroupList", baauthGroupVO);
	}
	public List<?> selectBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception {
		return list("baauthGroupDAO.selectBAAuthGroup", baauthGroupVO);
	}
	public int selectGenGroupID() throws Exception {
		return (int)select("baauthGroupDAO.selectGenGroupID");
	}
	public void insertBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception {
		insert("baauthGroupDAO.insertBAAuthGroup", baauthGroupVO);
	}
	public void updateBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception {
		update("baauthGroupDAO.updateBAAuthGroup", baauthGroupVO);
	}
	public void deleteBAAuthGroup(BAAuthGroupVO baauthGroupVO) throws Exception {
		delete("baauthGroupDAO.deleteBAAuthGroup", baauthGroupVO);
	}
}
