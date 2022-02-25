package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.UserDto;


public interface UserService {
	
	UserDto login(UserDto userDto) throws Exception;
	boolean idCheck(String checkId) throws Exception;
	
	boolean registerUser(UserDto userDto) throws Exception;
	UserDto getUser(String userId) throws Exception;
	List<UserDto> getUserList() throws Exception;
	boolean updateUser(UserDto userDto) throws Exception;
	boolean deleteUser(String userId) throws Exception;

}
