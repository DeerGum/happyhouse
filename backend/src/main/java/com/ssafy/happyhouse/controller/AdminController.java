package com.ssafy.happyhouse.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.UserDto;
import com.ssafy.happyhouse.model.service.UserService;

@RestController
@RequestMapping("/admin")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
	
	@Autowired
	private UserService userService;

	@GetMapping(value = "/user")
	public ResponseEntity<List<UserDto>> userList() throws Exception {
		List<UserDto> list = userService.getUserList();
		if(list != null && !list.isEmpty()) {
			return new ResponseEntity<List<UserDto>>(list, HttpStatus.OK);
		} else {
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
	}
	
	@PostMapping(value = "/user")
	public ResponseEntity<List<UserDto>> userRegister(@RequestBody UserDto memberDto) throws Exception {
		userService.registerUser(memberDto);
		List<UserDto> list = userService.getUserList();
		return new ResponseEntity<List<UserDto>>(list, HttpStatus.OK);
	}
	
	@GetMapping(value = "/user/{userid}")
	public ResponseEntity<UserDto> userInfo(@PathVariable("userid") String userid) throws Exception {
		logger.debug("파라미터 : {}", userid);
		UserDto memberDto = userService.getUser(userid);
		if(memberDto != null)
			return new ResponseEntity<UserDto>(memberDto, HttpStatus.OK);
		else
			return new ResponseEntity(HttpStatus.NO_CONTENT);
	}
	
	@PutMapping(value = "/user")
	public ResponseEntity<List<UserDto>> userModify(@RequestBody UserDto memberDto) throws Exception {
		userService.updateUser(memberDto);
		List<UserDto> list = userService.getUserList();
		return new ResponseEntity<List<UserDto>>(list, HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/user/{userid}")
	public ResponseEntity<List<UserDto>> userDelete(@PathVariable("userid") String userid) throws Exception {
		userService.deleteUser(userid);
		List<UserDto> list = userService.getUserList();
		return new ResponseEntity<List<UserDto>>(list, HttpStatus.OK);
	}

}
