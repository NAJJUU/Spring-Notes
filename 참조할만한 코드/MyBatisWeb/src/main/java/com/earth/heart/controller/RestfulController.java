package com.earth.heart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.earth.heart.domain.Person;

//@RestController
@Controller
public class RestfulController {

	@GetMapping("/ajax")
	public String ajax() {
		return "ajax";
	}
	
	@PostMapping("/send")
	@ResponseBody
	public Person test(@RequestBody Person p) {
		System.out.println("p= "+p);
		p.setName("나쥬");
		p.setAge(26);
		
		return p;
	}
	
	@GetMapping("/test")
	public String test() {
		return "test";
	}
}
