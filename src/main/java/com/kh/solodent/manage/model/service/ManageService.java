package com.kh.solodent.manage.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.kh.solodent.manage.model.vo.DeclareManager;

@Service
public interface ManageService {

	ArrayList<DeclareManager> getDeclareList();

	int deleteMember(String[] userIds);

}
