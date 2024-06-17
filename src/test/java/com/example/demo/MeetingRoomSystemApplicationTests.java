package com.example.demo;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;

import jakarta.transaction.Transactional;

@SpringBootTest
class MeetingRoomSystemApplicationTests {
	
	@Autowired
	UserRepository userRepository;
	
	@Test
	@Rollback(value = false)
	void contextLoadsAddUser() {
		//資料庫有個元件會自動產生流水號，所以不用自己寫id
		User user = User.builder() 
		.username("Kevin")
		.password("abc123")
		.email("Kevin@gmail.com")
		.department("marketing")
		.build();
		
		User dbUser = userRepository.save(user);
		System.out.println(dbUser);
	}
	
	@Test
	@Transactional
	void contextLoadsGetUser() {
		User dbUser = userRepository.getReferenceById(1);
		System.out.println(dbUser);
	}

	@Test
	void contextLoadsCountUser() {
		
		System.out.println(userRepository.count());
	}
}
