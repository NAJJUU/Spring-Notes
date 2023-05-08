package com.earth.rain;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RegisterController {
	
	@RequestMapping("/register/add")
	public String register() {
		return "registerForm";			//신규회원 가입 화면
	}
	
	@RequestMapping(value = "/register/save")
	public String save(User user) {
		return "registerinfo";
	}
	
}
