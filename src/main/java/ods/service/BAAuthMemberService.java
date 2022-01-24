package ods.service;

import java.util.List;

import ods.vo.BAAuthMemberVO;


public interface BAAuthMemberService {
	List<?> selectBAAuthMemberList(BAAuthMemberVO baauthMemberVO) throws Exception;
	List<?> selectBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception;
	List<?> selectBAAuthMemberGroup(BAAuthMemberVO baauthMemberVO) throws Exception;
	int insertBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception;
	void updateBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception;
	void deleteBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception;
}
