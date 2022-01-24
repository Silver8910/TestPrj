package ods.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import ods.dao.BACmpyDAO;
import ods.service.BACmpyService;
import ods.vo.BACmpyVO;

@Service("bacmpyService")
public class BACmpyServiceImpl extends EgovAbstractServiceImpl implements BACmpyService {
	private static final Logger LOGGER = LoggerFactory.getLogger(BACmpyServiceImpl.class);
	
	@Resource(name = "bacmpyDAO")
	private BACmpyDAO bacmpyDAO;
	
	@Override
	public List<?> selectBACmpyList(BACmpyVO bacmpyVO) throws Exception {
		return bacmpyDAO.selectBACmpyList(bacmpyVO);
	}
	
	@Override
	public List<?> selectBACmpy(BACmpyVO bacmpyVO) throws Exception {
		return bacmpyDAO.selectBACmpy(bacmpyVO);
	}
	
	@Override
	public String insertBACmpy(BACmpyVO bacmpyVO) throws Exception {
		String CustCd = bacmpyDAO.selectGenCustCd();
		bacmpyVO.setCustCd(CustCd);
		bacmpyDAO.insertBACmpy(bacmpyVO);
		return CustCd;
	}
	
	@Override
	public void updateBACmpy(BACmpyVO bacmpyVO) throws Exception {
		bacmpyDAO.updateBACmpy(bacmpyVO);
	}
	
	@Override
	public void deleteBACmpy(BACmpyVO bacmpyVO) throws Exception {
		bacmpyDAO.deleteBACmpy(bacmpyVO);
	}
}
