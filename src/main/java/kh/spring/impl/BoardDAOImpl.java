package kh.spring.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.spring.dao.BoardDAO;
import kh.spring.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	@Autowired
	private JdbcTemplate template;

	public int insert(BoardDTO dto) {
		String sql = "insert into board values (board_seq.nextval,?,?,?,?,?)";
		return template.update(sql, dto.getTitle(), dto.getContents(), dto.getWriter(), dto.getWritedate(), dto.getViewcount());
	}

	//	public String writer(String id) {
	//		String sql = "select name from member where id=?";
	//		return template.queryForObject(sql, String.class);
	//	}

	public List<BoardDTO> boardList(int start, int end){
		String sql = "select * from (select row_number() over(order by seq desc) as rown, board.* from board) where rown between ? and ?";
	      return template.query(sql, new Object[] {start,end}, new RowMapper<BoardDTO>() {
	         @Override
	         public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
	            BoardDTO dto = new BoardDTO();
	            dto.setSeq(rs.getInt(2));
				dto.setTitle(rs.getString(3));
				dto.setContents(rs.getString(4));
				dto.setWriter(rs.getString(5));
				dto.setWritedate(rs.getString(6));
				dto.setViewcount(rs.getInt(7));
	            return dto;
	         }
	      });
	   }

	public int viewCount(int seq) {
		String sql = "update board set viewcount=viewcount+1 where seq=?";
		return template.update(sql, seq);
	}
	
	public BoardDTO read(int seq) {
		String sql = "select * from board where seq = ?";
		return template.query(sql, new Object[]{seq}, new ResultSetExtractor<BoardDTO>() {

			@Override
			public BoardDTO extractData(ResultSet rs) throws SQLException, DataAccessException {
				BoardDTO dto = new BoardDTO();
				if(rs.next()) {
					dto.setSeq(rs.getInt(1));
					dto.setTitle(rs.getString(2));
					dto.setContents(rs.getString(3));
					dto.setWriter(rs.getString(4));
					dto.setWritedate(rs.getString(5));
					dto.setViewcount(rs.getInt(6));
				}
					return dto;		
			}
		});
	}
	
	public int modify(String title, String contents, int seq) {
		String sql = "update board set title=?, contents=? where seq=?";
		return template.update(sql, title, contents, seq);
	}
	
	public int recordTotalCount() {
		String sql = "select count(*) from board";
		return template.queryForObject(sql, int.class);
	}
	
	public int delete(int seq) {
		String sql = "delete board where seq = ?";
		return template.update(sql, seq);
	}
	
	static int recordCountPerPage = 5; 
	public static int startNavi = 0;
	public static int endNavi = 0;
	public List<String> getNavi(int currentPage) throws Exception {
		
		int recordTotalCount = this.recordTotalCount();  //DAO 로 리턴값받아오기
		System.out.println(recordTotalCount);
		
		int recordCountPerPage = 5; 
		int naviCountPerPage = 3;	
		int pageTotalCount = 0; // 변수만드는 용
		if(recordTotalCount % recordCountPerPage == 0) {
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}else{
			pageTotalCount = recordTotalCount / recordCountPerPage + 1 ;
		}
		
		// 현재페이지 오류 검출 및 정정 (공격을 막기 위해 작성하는 일종의 보안코드) 
		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}
		// 최소페이지 == currntPage / 최대페이지 == pageTotalCount
		// 내가 위치한 기준으로 네비게이터의 위치가 1~10 이라는것을 알아야함
//		int startNavi;
//		int endNavi;
		
		startNavi = (currentPage-1)/naviCountPerPage*naviCountPerPage+1; 
		// 10의자리는 그대로, 1의자리는 1
		// 현재페이지에서 1을 빼야 한다. --> 30페이지가 21~30 에 있어야 하기 때문!! 31은 31~40에 있어야하는데, 계산하면 31이 된다.
		//(currentPage-1)/10*10+1;

		endNavi = startNavi + (naviCountPerPage-1);

		if(endNavi>pageTotalCount) {
			endNavi = pageTotalCount;
		}
		//총페이지가 15인데, endNavi가  20이라면 말이 안되기 때문에.

		System.out.println("현재위치 : " + currentPage);
		System.out.println("네비시작 : " + startNavi);
		System.out.println("네비 끝 : " + endNavi);

		boolean needPrev = true;
		boolean needNext = true;
		
		if(startNavi == 1) {
			needPrev = false;
		}
		
		if(endNavi == pageTotalCount) {
			needNext = false;
		}


		//StringBuilder sb = new StringBuilder();
		List<String> list = new ArrayList<String>();
		//지금까지 만든걸 String에 담아서 보낸다.	
		if(needPrev) {
			list.add("<이전 ");
		}
		for(int i = startNavi ; i <= endNavi ; i++) {
			//sb.append("<a href='list.board?currentPage="+i+"'>"+i + "</a>");
			//sb.append(i+"");
			list.add(i+"");
		}
		if(needNext) {
			//sb.append("다음>");
			list.add("다음>");
		}
		//return sb.toString();
		return list;
	}	

	
	
}
