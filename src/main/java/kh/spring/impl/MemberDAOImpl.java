package kh.spring.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Component;

import kh.spring.dao.MemberDAO;
import kh.spring.dto.MemberDTO;

@Component
public class MemberDAOImpl implements MemberDAO {

	//1. JdbcTemplate
	@Autowired
	private JdbcTemplate template;

	//2. SqlSessionTemplate
	@Autowired
	private SqlSessionTemplate sst;
	
	public int insertMem(MemberDTO dto) {
//		String sql = "insert into member values (?,?,?,?,?,?,?,?,?)";
//		return template.update(sql, dto.getId(), dto.getPw(), dto.getName(), dto.getImage(), dto.getPhone(), dto.getEmail(), 
//				dto.getZipcode(), dto.getAddr1(), dto.getAddr2());
		return sst.insert("MemberDAO.insert", dto);
	}

	public int idCheck(String id) {
//		String sql = "select count(*) from member where id = ?";
//		return template.queryForObject(sql, Integer.class, id);
		return sst.selectOne("MemberDAO.idCheck", id);
	}

	public int loginCheck(String id, String pw) {
//		String sql = "select count(*) from member where id = ? and pw = ?";
//		return template.queryForObject(sql, Integer.class, id, pw);
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pw", pw);
		return sst.selectOne("MemberDAO.loginCheck", map);
	}
	
	public MemberDTO myPage(String id) {
//		String sql = "select * from member where id = ?";
//		
//		return template.query(sql, new Object[] {id}, new ResultSetExtractor<MemberDTO>() {
//			@Override
//			public MemberDTO extractData(ResultSet rs) throws SQLException, DataAccessException {
//						MemberDTO dto = new MemberDTO();
//						if(rs.next()) {
//						dto.setPw(rs.getString(2));
//						dto.setName(rs.getString(3));
//						dto.setImage(rs.getString(4));
//						dto.setPhone(rs.getString(5));
//						dto.setEmail(rs.getString(6));
//						dto.setZipcode(rs.getInt(7));
//						dto.setAddr1(rs.getString(8));
//						dto.setAddr2(rs.getString(9));
//						}
//						return dto;
//			}	
//		});
		return sst.selectOne("MemberDAO.myPage", id);
	}
	
	public int update(String id, String modifiedImg) {
//		String sql = "update member set image=? where id=?";
//		return template.update(sql, modifiedImg, id);
		Map<String,String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("modifiedImg", modifiedImg);
		return sst.update("MemberDAO.update",map);
	}
	
	public int modify(MemberDTO dto, String id) {
		String sql = "update member set pw=?, name=?, phone=?, email=?, zipcode=?, addr1=?, addr2=? where id=?";
		System.out.println( dto.getPw()+ dto.getName()+ dto.getPhone()+ dto.getEmail()+ dto.getZipcode()+ dto.getAddr1()+ dto.getAddr2()+ id);
		return template.update(sql, dto.getPw(), dto.getName(), dto.getPhone(), dto.getEmail(), dto.getZipcode(), dto.getAddr1(), dto.getAddr2(), id);	
		//return sst.update("MemberDAO.modify"); 
	}
}
