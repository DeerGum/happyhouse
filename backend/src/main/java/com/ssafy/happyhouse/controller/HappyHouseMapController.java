package com.ssafy.happyhouse.controller;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.ValidDto;
import com.ssafy.happyhouse.model.service.HappyHouseMapService;

import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/map")
public class HappyHouseMapController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private HappyHouseMapService happyHouseMapService;
	
	@GetMapping("/sido")
	@ApiOperation(value = "시도 목록", notes = "시도 목록를 반환한다.", response = SidoGugunCodeDto.class)
	public ResponseEntity<List<SidoGugunCodeDto>> sido() throws SQLException {
		logger.info("sido - 호출 ");
		return new ResponseEntity<List<SidoGugunCodeDto>>(happyHouseMapService.getSido(), HttpStatus.OK);
	}

	@GetMapping("/gugun")
	@ApiOperation(value = "구군 목록", notes = "구군 목록을 반환한다.", response = SidoGugunCodeDto.class)
	public ResponseEntity<List<SidoGugunCodeDto>> gugun(@RequestParam("sido") String sido) throws SQLException {
		logger.info("gugun - 호출 ");
		return new ResponseEntity<List<SidoGugunCodeDto>>(happyHouseMapService.getGugunInSido(sido), HttpStatus.OK);
	}
	
	@GetMapping("/dong")
	@ApiOperation(value = "동 목록", notes = "해당하는 구군의 동 목록을 반환한다.", response = HouseInfoDto.class)
	public ResponseEntity<List<HouseInfoDto>> dong(@RequestParam("gugun") String gugun) throws SQLException {
		logger.info("dong - 호출 ");
		return new ResponseEntity<List<HouseInfoDto>>(happyHouseMapService.getDongInGugun(gugun), HttpStatus.OK);
	}
	
	@GetMapping("/apt")
	@ApiOperation(value = "아파트 정보 목록", notes = "해당하는 동의 아파트 정보 목록을 반환한다.", response = HouseInfoDto.class)
	public ResponseEntity<List<HouseInfoDto>> apt(@RequestParam("dong") String dong) throws SQLException {
		logger.info("apt - 호출 ");
		return new ResponseEntity<List<HouseInfoDto>>(happyHouseMapService.getAptInDong(dong), HttpStatus.OK);
	}
	
	@GetMapping("/list")
	@ApiOperation(value = "아파트 거래내역 목록", notes = "아파트코드에 해당하는 아파트 거래내역 목록을 반환한다.", response = HouseDealDto.class)
	public ResponseEntity<List<HouseDealDto>> listApt(@RequestParam("aptCode") String aptCode) throws Exception {
		logger.info("listApt - 호출 ");
		return new ResponseEntity<List<HouseDealDto>>(happyHouseMapService.getAptListForAptCode(aptCode.trim()), HttpStatus.OK); 		
	}
	
	@GetMapping("/search")
	@ApiOperation(value = "아파트 거래내역 목록", notes = "해당하는 이름의 아파트 거래내역 목록을 반환한다.", response = HouseDealDto.class)
	public ResponseEntity<List<HouseDealDto>> searchApt(@RequestParam("aptName") String aptName) throws Exception {
		logger.info("searchApt - 호출 ");
		return new ResponseEntity<List<HouseDealDto>>(happyHouseMapService.getAptListForAptName(aptName.trim()), HttpStatus.OK); 		
	}

	@GetMapping("/keywordcheck")
	@ApiOperation(value = "키보드 데이터 유효성", notes = "키보드 데이터 유효성을 반환한다.", response = ValidDto.class)
	public ResponseEntity<ValidDto> keywordCheck(@RequestParam("keyword") String keyword) throws Exception {
		logger.info("keywordCheck - 호출 ");
		return new ResponseEntity<ValidDto>(happyHouseMapService.isValidKeyword(keyword.trim()), HttpStatus.OK); 		
	}
}
