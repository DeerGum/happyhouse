package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.ValidDto;
import com.ssafy.happyhouse.model.mapper.HouseMapMapper;

@Service
public class HappyHouseMapServiceImpl implements HappyHouseMapService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<SidoGugunCodeDto> getSido() throws SQLException {
		return sqlSession.getMapper(HouseMapMapper.class).getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws SQLException {
		return sqlSession.getMapper(HouseMapMapper.class).getGugunInSido(sido);
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws SQLException {
		return sqlSession.getMapper(HouseMapMapper.class).getDongInGugun(gugun);
	}

	@Override
	public List<HouseInfoDto> getAptInDong(String dong) throws SQLException {
		return sqlSession.getMapper(HouseMapMapper.class).getAptInDong(dong);
	}

	@Override
	public List<HouseDealDto> getAptListForAptCode(String aptCode) throws SQLException {
		return sqlSession.getMapper(HouseMapMapper.class).getAptListForAptCode(aptCode);
	}

	@Override
	public List<HouseDealDto> getAptListForAptName(String aptName) throws SQLException {
		return sqlSession.getMapper(HouseMapMapper.class).getAptListForAptName(aptName);
	}

	@Override
	public ValidDto isValidKeyword(String keyword) {
		String pattern = "^[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|,()-]*$";
		ValidDto result = new ValidDto();

		if (!keyword.matches(pattern) || keyword.length() == 0) { //유효하지 않음
			result.setIsValid("nonpass");
		}
		else {
			result.setIsValid("pass");
		}
		return result;
	}

}
