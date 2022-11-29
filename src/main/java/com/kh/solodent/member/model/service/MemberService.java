package com.kh.solodent.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.solodent.member.model.vo.Member;

public interface MemberService {

	Member login(Member m);

	int insertMember(Member m);

	int checkNickName(String nickName);

	int checkId(String id);

	int updateMember(Member m);

	ArrayList<HashMap<String, Object>> selectMyList(String id);

	String finEmail(String email);

	String findPwd(Member m);

	

	

	int changePwd(Member m);

	
	

	
}