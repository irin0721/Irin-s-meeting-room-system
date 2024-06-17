package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.UserService;



@RestController
//@RequestMapping("/api")
public class UserController {
	
	@Autowired
	UserService userService;
	@Autowired
	UserRepository userRepository;
	
	
	@GetMapping("/users")
	public ResponseEntity<List<User>> getAllUser() {
		return ResponseEntity.ok(userService.getAllUsers());
	}
	
	//新增資料
	@PostMapping("/users")
	public ResponseEntity<User> addUser(@RequestBody User user) {
		return ResponseEntity.ok(userService.addUser(user));
	}
	

	//刪除資料 
	//自己寫的delete
	@DeleteMapping("/users/{id}")
	public ResponseEntity deleteUser(@PathVariable("id") Integer id) {
		userService.deleteUsers(id);
		return ResponseEntity.noContent().build();
	}
	
	//查尋資料
	//為啥不行 ResponseEntity<List<User>>
	@GetMapping("/users/{id}")
	public ResponseEntity<User> searchUser(@PathVariable("id") Integer id){
		return ResponseEntity.ok(userService.getUser(id));
	}
	
	//修改資料
	@PutMapping("/users/{id}")
	public ResponseEntity<User> editUser(@PathVariable("id") Integer id, @RequestBody User user) {
		return ResponseEntity.ok(userService.editUser(id, user));
	}
	
	@GetMapping("/users/username/{username}")
	public ResponseEntity<List<User>> searchUser(@PathVariable("username") String username){
		return ResponseEntity.ok(userService.findUserByUsernameContaining(username));
	}
	
	
	
}