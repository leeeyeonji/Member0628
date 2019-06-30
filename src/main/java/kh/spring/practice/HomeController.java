package kh.spring.practice;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.google.gson.Gson;

import kh.spring.dto.MemberDTO;
import kh.spring.impl.MemberDAOImpl;

@Controller
public class HomeController {
	
	@Autowired
	private MemberDAOImpl dao;
	
	@Autowired             
	private HttpSession session;
	
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	@RequestMapping("webChat")
	public String webChat() {
		return "webChat";
	}
	
	@RequestMapping("/joinForm")
	public String joinForm() {
		return "joinForm";
	}
	
	@RequestMapping("/joinProc")
	public String joinProc(MemberDTO dto, HttpServletRequest request) {
		String resourcePath = session.getServletContext().getRealPath("/resources");
		System.out.println(resourcePath);
		try {
//			String imgName = System.currentTimeMillis()+"_file.png";
//			fileImg.transferTo(new File(resourcePath+"/"+imgName));

		} catch (Exception e) {
			e.printStackTrace();
		}
		int result = dao.insertMem(dto);
		request.setAttribute("result", result);
		return "joinView";
	}
	
	@RequestMapping("joinImgProc")
	public String joinImgProc() {
		return "joinImgProc";
	}
	
	@ResponseBody
	@RequestMapping("/joinImg")
	public String joinImg(MultipartHttpServletRequest request) {
		MultipartFile fileImg = request.getFile("fileImg");
		String resourcePath = session.getServletContext().getRealPath("/resources");
		System.out.println(fileImg.getOriginalFilename());
		String imgName = "/"+System.currentTimeMillis()+"_save.png";
		try {
			fileImg.transferTo(new File(resourcePath+imgName));
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return imgName;
	}
	
	@ResponseBody
	@RequestMapping("/idCheck")
	public String idCheck(String id, HttpServletRequest request) {
		int result = dao.idCheck(id);
		request.setAttribute("result", result);
//		System.out.println(id+"id:"+result+"result");
		return new Gson().toJson(result);
	}
	
	@RequestMapping("/login")
	public String login(String id, String pw, HttpServletRequest request) {
		int result = dao.loginCheck(id, pw);
		MemberDTO dto = dao.myPage(id);
		session.setAttribute("loginDTO", dto);
		if(result>0) {
		session.setAttribute("loginID", id);
		request.setAttribute("result", true);
		}else {
			request.setAttribute("result", false);
		}
		return "loginView";
	}
	
	@RequestMapping("/myPageForm")
	public String myPageForm(HttpServletRequest request) {
//		String loginID = (String) session.getAttribute("loginID");
//		MemberDTO dto = dao.myPage(loginID);
//		request.setAttribute("dto", dto);
		return "myPageForm";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "home";
	}
	
//	@RequestMapping("/upload")
//	public String upload(MultipartFile image) {
//		String resourcePath = session.getServletContext().getRealPath("/resources");
//		System.out.println(resourcePath);
//		try {
//			image.transferTo(new File(resourcePath+"/"+System.currentTimeMillis()+"_file.png"));
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "joinForm";
//	}
	
	@RequestMapping("/modifyImg")
	public String modifyImg() {
		return "modify";
	}
	
	@ResponseBody
	@RequestMapping("/modifyImgProc")
	public String modifyProc(MemberDTO dto, MultipartHttpServletRequest request) {
		//MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
        MultipartFile file = request.getFile("modifyImg");	
		String resourcePath = session.getServletContext().getRealPath("/resources");
		System.out.println("모디파이"+resourcePath);
		String imgName = null;
		try {
			imgName = "/"+System.currentTimeMillis()+session.getAttribute("loginID")+"_modified.png";
			file.transferTo(new File(resourcePath+imgName));
			dao.update((String)session.getAttribute("loginID"), imgName);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return imgName;
	}
	
	@RequestMapping("modifyForm")
	public String modifyForm(MemberDTO dto, HttpServletRequest request) {
		return "modifyForm";
	}
	
	@RequestMapping("modifyProc")
	public String modifyProc(MemberDTO dto, HttpServletRequest request) {
		int result = dao.modify(dto, (String)session.getAttribute("loginID"));
		request.setAttribute("result", result);
		MemberDTO newDTO = dao.myPage((String)session.getAttribute("loginID"));
		session.setAttribute("loginDTO", newDTO);
		return "modifyView";
	}
	
	@RequestMapping("modifyView")
	public String modifyView() {
		return "modifyView";
	}
	
}
