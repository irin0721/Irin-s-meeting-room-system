package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;

import jakarta.annotation.PostConstruct;
import jakarta.transaction.Transactional;
import lombok.Data;

@Service
@Data
public class UserService {
//	private List<User> users = new ArrayList<>();
	
	@Autowired
	UserRepository userRepository;
	
	public User getUser(Integer id) {
		return userRepository.getReferenceById(id);
	}
	
	public List<User> getAllUsers() {
		return userRepository.findAll();
	}
	
	@Transactional
	public User editUser(Integer id , User user) {
		User dbUser = userRepository.getReferenceById(id);
		dbUser.setEmail(user.getEmail());
		dbUser.setPassword(user.getPassword());
		dbUser.setDepartment(user.getDepartment());
		return userRepository.save(dbUser);	//包含id
		
	} 
	
	@Transactional
	public User addUser(User user) {
		return userRepository.save(user); //不包含id	
		
	}
	
	@Transactional
	public void deleteUsers(Integer id) {
		userRepository.deleteById(id);

	}
	
	@Transactional
	public List<User> findUserByUsernameContaining(String username) {
		return userRepository.findByUsernameContaining(username);
		
		
	}

	}
	
