package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.UserDto;
import com.ssafy.happyhouse.model.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public UserDto login(UserDto userDto) throws Exception {
		return sqlSession.getMapper(UserMapper.class).login(userDto);
	}

	@Override
	public boolean idCheck(String checkId) throws Exception {
		int result = sqlSession.getMapper(UserMapper.class).idCheck(checkId);
		return result == 0;
	}

	@Override
	public boolean registerUser(UserDto userDto) throws Exception {
		return sqlSession.getMapper(UserMapper.class).registerUser(userDto) == 1;
	}
	
	@Override
	public UserDto getUser(String userId) throws Exception {
		return sqlSession.getMapper(UserMapper.class).getUser(userId);
	}

	@Override
	public List<UserDto> getUserList() throws Exception {
		return sqlSession.getMapper(UserMapper.class).getUserList();
	}

	@Override
	public boolean updateUser(UserDto userDto) throws Exception {
		return sqlSession.getMapper(UserMapper.class).updateUser(userDto) == 1;
	}

	@Override
	public boolean deleteUser(String userId) throws Exception {
		return sqlSession.getMapper(UserMapper.class).deleteUser(userId) == 1;
	}

}
