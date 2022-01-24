package ods.service.impl;

import java.util.List;
import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import ods.dao.BAAuthMemberDAO;
import ods.service.BAAuthMemberService;
import ods.vo.BAAuthMemberVO;

@Service("baauthMemberService")
public class BAAuthMemberServiceImpl extends EgovAbstractServiceImpl implements BAAuthMemberService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(BAAuthMemberServiceImpl.class);
	
	@Resource(name = "baauthMemberDAO")
	private BAAuthMemberDAO baauthMemberDAO;
	
	@Override
	public List<?> selectBAAuthMemberList(BAAuthMemberVO baauthMemberVO) throws Exception {
		return baauthMemberDAO.selectBAAuthMemberList(baauthMemberVO);
	}
	@Override
	public List<?> selectBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception {
		return baauthMemberDAO.selectBAAuthMember(baauthMemberVO);
	}
	@Override
	public List<?> selectBAAuthMemberGroup(BAAuthMemberVO baauthMemberVO) throws Exception {
		return baauthMemberDAO.selectBAAuthMemberGroup(baauthMemberVO);
	}
	@Override
	public int insertBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception {
		int AuthMemberID = baauthMemberDAO.selectGenAuthMemberID();
		baauthMemberVO.setAuthMemberID(AuthMemberID);
		baauthMemberDAO.insertBAAuthMember(baauthMemberVO);
		return AuthMemberID;
	}
	@Override
	public void updateBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception {
		baauthMemberDAO.updateBAAuthMember(baauthMemberVO);
	}
	@Override
	public void deleteBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception {
		baauthMemberDAO.deleteBAAuthMember(baauthMemberVO);
	}
}
