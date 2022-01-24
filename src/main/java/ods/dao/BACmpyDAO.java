package ods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import ods.vo.BACmpyVO;

@Repository("bacmpyDAO")
public class BACmpyDAO extends EgovAbstractDAO {
	public List<?> selectBACmpyList(BACmpyVO bacmpyVO) throws Exception {
		return list("bacmpyDAO.selectBACmpyList", bacmpyVO);
	}
	
	public List<?> selectBACmpy(BACmpyVO bacmpyVO) throws Exception {
		return list("bacmpyDAO.selectBACmpy", bacmpyVO);
	}
	
	public String selectGenCustCd() throws Exception {
		return (String)select("bacmpyDAO.selectGenCustCd");
	}
	
	public void insertBACmpy(BACmpyVO bacmpyVO) throws Exception {
		insert("bacmpyDAO.insertBACmpy", bacmpyVO);
	}
	
	public void updateBACmpy(BACmpyVO bacmpyVO) throws Exception {
		insert("bacmpyDAO.updateBACmpy", bacmpyVO);
	}
	
	public void deleteBACmpy(BACmpyVO bacmpyVO) throws Exception {
		insert("bacmpyDAO.deleteBACmpy", bacmpyVO);
	}
}
