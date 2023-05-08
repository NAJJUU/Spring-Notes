package com.earth.egg;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login")
public class LoginController {

	@GetMapping("/login")
	public String loginForm() {
		return "loginForm";
	}
	
	@PostMapping("/login")
	public String login(String id, String pwd, boolean rememberId, 
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		System.out.println("id= "+id);
		System.out.println("pwd= "+pwd);
		System.out.println("rememberId= "+rememberId);
		
		//1. id와 pw를 확인
		if(!loginCheck(id, pwd)) {
			//2-1. 일치하지 않으면, loginForm으로 이동
			String msg = URLEncoder.encode("id 또는 비밀번호가 일치하지 않습니다.", "utf-8");
			return "redirect:/login/login?msg="+msg;
		}
		
		
		
		//2-2. 일치하면 로그인 후 화면(홈) 이동
		if(rememberId) {
			//2-2-1. 쿠키를 생성
			//2-2-2. 응답헤더에 저장(addCookie)
			Cookie cookie = new Cookie("id", id);
			response.addCookie(cookie);
			
		}else {
			//2-3-1. 쿠키를 삭제
			//2-3-2. 응답헤더에 저장(addCookie)
			Cookie cookie = new Cookie("id", id);
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		
		
		
		return "redirect:/";
	}

	private boolean loginCheck(String id, String pwd) {
		// TODO Auto-generated method stub
		return "earth".equals(id) && "0629".equals(pwd);
	}
}
