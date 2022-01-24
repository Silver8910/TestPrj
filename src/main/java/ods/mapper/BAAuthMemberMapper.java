package ods.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import ods.vo.BAAuthMemberVO;

@Mapper("baauthMemberMapper")
public interface BAAuthMemberMapper {
	List<?> selectBAAuthMemberList(BAAuthMemberVO baauthMemberVO) throws Exception;
	List<?> selectBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception;
	List<?> selectBAAuthMemberGroup(BAAuthMemberVO baauthMemberVO) throws Exception;
	int selectGenAuthMemberID() throws Exception;
	void insertBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception;
	void updateBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception;
	void deleteBAAuthMember(BAAuthMemberVO baauthMemberVO) throws Exception;
}
