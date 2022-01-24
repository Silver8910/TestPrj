package ods.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import ods.dao.BAHrDAO;
import ods.service.BAHrService;
import ods.vo.BAHrVO;

@Service("bahrService")
public class BAHrServiceImpl extends EgovAbstractServiceImpl implements BAHrService {
	@Resource(name = "bahrDAO")
	private BAHrDAO bahrDAO;
	
	public List<?> selectBAHrList(BAHrVO bahrVO) throws Exception {
		return bahrDAO.selectBAHrList(bahrVO);
	}
	public List<?> selectBAHr(BAHrVO bahrVO) throws Exception {
		return bahrDAO.selectBAHr(bahrVO);
	}
	public List<?> selectBAHrCust(BAHrVO bahrVO) throws Exception {
		return bahrDAO.selectBAHrCust(bahrVO);
	}
	public String insertBAHr(BAHrVO bahrVO) throws Exception {
		String HrCd = bahrDAO.selectGenHrCd();
		bahrVO.setHrCd(HrCd);
		bahrDAO.insertBAHr(bahrVO);
		return HrCd;
	}
	public void updateBAHr(BAHrVO bahrVO) throws Exception {
		bahrDAO.updateBAHr(bahrVO);
	}
	public void deleteBAHr(BAHrVO bahrVO) throws Exception {
		bahrDAO.deleteBAHr(bahrVO);
	}
}
