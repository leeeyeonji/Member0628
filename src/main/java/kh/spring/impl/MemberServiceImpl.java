package kh.spring.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import kh.spring.dto.MemberDTO;
import kh.spring.service.MemberService;

@Component
public class MemberServiceImpl implements MemberService{
	@Autowired
	public MemberDAOImpl dao;
	
	@Transactional("txManager")
	public void MemberService(MemberDTO dto) {
	
	}
	
}
