package com.ssafy.happyhouse.model.mapper;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.UserDto;


public interface UserMapper {
	
	UserDto login(UserDto userDto) throws Exception;
	int idCheck(String checkId) throws Exception;
	
	int registerUser(UserDto userDto) throws Exception;	
	UserDto getUser(String userId) throws Exception;
	List<UserDto> getUserList() throws Exception;
	int updateUser(UserDto userDto) throws Exception;
	int deleteUser(String userId) throws Exception;

}
