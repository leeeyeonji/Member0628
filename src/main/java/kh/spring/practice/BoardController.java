package kh.spring.practice;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Member;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.common.TemplateAwareExpressionParser;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kh.spring.dto.BoardDTO;
import kh.spring.impl.BoardDAOImpl;


@Controller
public class BoardController {

	@Autowired             
	private HttpSession session;

	@Autowired
	private BoardDAOImpl dao;

	@RequestMapping("boardForm")
	public String boardForm() {
		return "/Board/boardForm";
	}

	@RequestMapping("writeForm")
	public String writeForm() {
		if(session.getAttribute("loginID") == null) {
			return "home";
		}
		return "/Board/writeForm";
	}

	@ResponseBody
	@RequestMapping("writeImgProc")
	public String writeImgProc(MultipartHttpServletRequest request) {
		MultipartFile image = request.getFile("image");
		File dir = new File("/resources/write/");
		if(!dir.exists()) { // 폴더가 있는지 확인.
			System.out.println("폴더생성");
			dir.mkdirs(); // 없으면 생성
		}
		
		String resourcesPath = session.getServletContext().getRealPath("/resources/write/");
		System.out.println(resourcesPath);
		String imgName = "_"+System.currentTimeMillis()+"_write.png";
		try {
			image.transferTo(new File(resourcesPath+imgName));
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return imgName;
	}

	@RequestMapping("writeProc")
	public String writeProc(String title, String contents, HttpServletRequest request) {		
		SimpleDateFormat sd= new SimpleDateFormat("MM/dd HH:mm:ss");
		String writeDate = sd.format(System.currentTimeMillis());
		if(session.getAttribute("loginID")==null) {
			request.setAttribute("id", false);
		}else {
		int result = dao.insert(new BoardDTO(0, title, contents, (String)session.getAttribute("loginID"), writeDate, 0));
			request.setAttribute("id", true);
			request.setAttribute("result", result);
		}
		return "/Board/boardView";
	}

	@RequestMapping("boardProc")
	public String boardProc(String page, HttpServletRequest request) {
		int nowPage = 1;	
			try {	
				
				int startNavi = BoardDAOImpl.startNavi;
				int endNavi = BoardDAOImpl.endNavi;

				if(page.equals("다음>")) {
					nowPage = endNavi+1;
					page = nowPage+"";
				}else if(page.equals("<이전")) {
					nowPage = startNavi-1;
					page = nowPage+"";
				}else {
					nowPage = Integer.parseInt(page);	
				}		
				int start = (nowPage*5)-4;
				int end = nowPage*5;
				System.out.println(end+":"+start);
				List<BoardDTO> list = dao.boardList(start, end);	
				request.setAttribute("list", list);
				List<String> navi = dao.getNavi(nowPage);
				int size = navi.size();
				if (size==0) {
					size=1;
				}
				request.setAttribute("now", page);
				request.setAttribute("navi", navi);
				request.setAttribute("size", size);
			} catch (Exception e) {
				e.printStackTrace();
			}	
		
		return "/Board/boardForm";
	}

	@RequestMapping("readProc")
	public String readProc(int seq, HttpServletRequest request) {
		dao.viewCount(seq);
		BoardDTO dto = dao.read(seq);
		request.setAttribute("dto", dto);
		return "/Board/readForm";	
	}
	
	@RequestMapping("modifyBoardProc")
	public String modifyBoardProc(int seq, HttpServletRequest request) {
		BoardDTO dto = dao.read(seq);
		request.setAttribute("dto", dto);
		return "/Board/modifyForm";	
	}
	
	@ResponseBody
	@RequestMapping("modifyBoardImgProc")
	public String modifyBoardImgProc(MultipartHttpServletRequest request) {
		MultipartFile image = request.getFile("fileImg");
		File dir = new File("/resources/modify/");
		if(!dir.exists()) { // 폴더가 있는지 확인.
			System.out.println("폴더생성");
			dir.mkdirs(); // 없으면 생성
		}
		String resourcesPath = session.getServletContext().getRealPath("/resources/modify/");
		System.out.println(resourcesPath);
		String imgName = "_"+System.currentTimeMillis()+"_modify.png";
		try {
			image.transferTo(new File(resourcesPath+imgName));
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return imgName;
	}
	
	@RequestMapping("modifySaveBoardProc")
	public String modifySaveBoardProc(String title, String contents, int seq, HttpServletRequest request) {
		int result = dao.modify(title, contents, seq);
		request.setAttribute("result", result);
		request.setAttribute("seq", seq);
		return "/Board/modifyView";
	}
	
	@RequestMapping("dropProc")
	public String dropProc(int seq, String writer, HttpServletRequest request) {
		if(writer.equals(session.getAttribute("loginID"))){
			request.setAttribute("id", true);
			request.setAttribute("seq", seq);
		}
		int result = dao.delete(seq);
		request.setAttribute("result", result);
		return "/Board/dropView";
	}
	
}
