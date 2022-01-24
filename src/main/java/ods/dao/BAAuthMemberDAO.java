package ods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import ods.vo.BAAuthMemberVO;

@Repository("baauthMemberDAO")
public class BAAuthMemberDAO extends EgovAbstractDAO{
	public List<?> selectBAAuthMemberList(BAAuthMemberVO baauthMemberVO) throws Exception {
		return list("baauthMemberDAO.selectBAAuthMemberList", baauthMemberVO);
	}
	public List<?> selectBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception {
		return list("baauthMemberDAO.selectBAAuthMember", baauthMemberVO);
	}
	public List<?> selectBAAuthMemberGroup(BAAuthMemberVO baauthMemberVO) throws Exception {
		return list("baauthMemberDAO.selectBAAuthMemberGroup", baauthMemberVO);
	}
	public int selectGenAuthMemberID() throws Exception {
		return (int)select("baauthMemberDAO.selectGenAuthMemberID");
	}
	public void insertBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception {
		insert("baauthMemberDAO.insertBAAuthMember", baauthMemberVO);
	}
	public void updateBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception {
		update("baauthMemberDAO.updateBAAuthMember", baauthMemberVO);
	}
	public void deleteBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception {
		delete("baauthMemberDAO.deleteBAAuthMember", baauthMemberVO);
	}
}
