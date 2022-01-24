package ods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import ods.vo.BAHrVO;

@Repository("bahrDAO")
public class BAHrDAO extends EgovAbstractDAO {
	public List<?> selectBAHrList(BAHrVO bahrVO) throws Exception {
		return list("bahrDAO.selectBAHrList", bahrVO);
	}
	
	public List<?> selectBAHr(BAHrVO bahrVO) throws Exception {
		return list("bahrDAO.selectBAHr", bahrVO);
	}
	
	public List<?> selectBAHrCust(BAHrVO bahrVO) throws Exception {
		return list("bahrDAO.selectBAHrCust", bahrVO);
	}

	public String selectGenHrCd() throws Exception {
		return (String)select("bahrDAO.selectGenHrCd");
	}
	
	public void insertBAHr(BAHrVO bahrVO) throws Exception {
		insert("bahrDAO.insertBAHr", bahrVO);
	}
	
	public void updateBAHr(BAHrVO bahrVO) throws Exception {
		insert("bahrDAO.updateBAHr", bahrVO);
	}
	
	public void deleteBAHr(BAHrVO bahrVO) throws Exception {
		insert("bahrDAO.deleteBAHr", bahrVO);
	}
}
