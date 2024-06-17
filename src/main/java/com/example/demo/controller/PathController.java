package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class PathController {
	
	@GetMapping
	public String index() {
		
		return "index";
		
	}
	
	//助教有改過要再檢查一下
	/* @GetMapping("/reservation")
	public String reservationPage() {
		
		return "reservationTable";
	}*/

}





