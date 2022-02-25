package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.ServletContext;

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

import com.ssafy.happyhouse.model.CommentDto;
import com.ssafy.happyhouse.model.BoardDto;
import com.ssafy.happyhouse.model.BoardParameterDto;
import com.ssafy.happyhouse.model.service.BoardService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

//방명록 처리용 controller
@RestController
@RequestMapping("/board")
@Api("게시판 컨트롤러 API V1")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@Autowired
	private BoardService boardService;

	@ApiOperation(value = "게시글 목록", notes = "게시글 목록을 반환한다. ", response = BoardDto.class)
	@GetMapping
	public ResponseEntity<List<BoardDto>> getBoardList(
			@ApiParam(value = "게시글을 얻기위한 부가정보.", required = true) BoardParameterDto boardParameterDto)
			throws Exception {
		logger.info("getBoardList - 호출 : "+boardParameterDto.getBoardType());
		return new ResponseEntity<List<BoardDto>>(boardService.listArticle(boardParameterDto),
				HttpStatus.OK);
	}

	@ApiOperation(value = "게시글 총 갯수", notes = "게시글 목록을 반환한다. ", response = BoardDto.class)
	@GetMapping("/count")
	public ResponseEntity<Integer> getBoardListTotalCount(
			@ApiParam(value = "게시글을 얻기위한 부가정보.", required = true) BoardParameterDto boardParameterDto)
					throws Exception {
		logger.info("getBoardListTotalCount - 호출 : "+boardParameterDto.getBoardType());
		return new ResponseEntity<Integer>(boardService.listArticleTotalCount(boardParameterDto),
				HttpStatus.OK);
	}

	@ApiOperation(value = "게시글 보기", notes = "글번호에 해당하는 게시글의 정보를 반환한다. ", response = BoardDto.class)
	@GetMapping("/{articleno}")
	public ResponseEntity<BoardDto> getBoard(
			@PathVariable("articleno") @ApiParam(value = "얻어올 글의 글번호.", required = true) int articleNo)
			throws Exception {
		logger.info("getBoard - 호출 : " + articleNo);
		return new ResponseEntity<BoardDto>(boardService.getArticle(articleNo), HttpStatus.OK);
	}

	@ApiOperation(value = "게시글 등록", notes = "게시글을 등록한다. DB입력에 성공하면 'success' 실패하면 'fail'을 반환", response = String.class)
	@PostMapping
	public ResponseEntity<String> writeBoard(
			@RequestBody @ApiParam(value = "게시글 정보.", required = true) BoardDto boardDto) throws Exception {
		logger.info("writeBoard - 호출");
		if (boardService.writeArticle(boardDto))
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		else
			return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@ApiOperation(value = "게시글 수정", notes = "게시글을 수정한다. 성공하면 'success' 실패하면 'fail'을 반환 ", response = String.class)
	@PutMapping
	public ResponseEntity<String> modifyBoard(
			@RequestBody @ApiParam(value = "수정할 글정보.", required = true) BoardDto boardDto) throws Exception {
		logger.info("modifyBoard - 호출");
		if (boardService.updateArticle(boardDto))
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		else
			return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@ApiOperation(value = "게시글 삭제", notes = "게시글을 삭제한다. 성공하면 'success' 실패하면 'fail'을 반환 ", response = String.class)
	@DeleteMapping("/{articleno}")
	public ResponseEntity<String> deleteBoard(
			@PathVariable("articleno") @ApiParam(value = "살제할 글의 글번호.", required = true) int articleNo)
			throws Exception {
		logger.info("deleteBoard - 호출 : " + articleNo);
		if (boardService.deleteArticle(articleNo))
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		else
			return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@ApiOperation(value = "댓글 목록", notes = "댓글 목록을 반환한다. ", response = CommentDto.class)
	@GetMapping("/comment/{articleno}")
	public ResponseEntity<List<CommentDto>> getListComment(
			@PathVariable("articleno") @ApiParam(value = "얻어올 글의 글번호.", required = true) int articleNo)
			throws Exception {
		logger.info("getListComment - 호출");
		return new ResponseEntity<List<CommentDto>>(boardService.getListComment(articleNo), HttpStatus.OK);
	}

	@ApiOperation(value = "댓글 등록", notes = "댓글을 등록한다. DB입력에 성공하면 'success' 실패하면 'fail'을 반환", response = String.class)
	@PostMapping("/comment")
	public ResponseEntity<String> writeComment(
			@RequestBody @ApiParam(value = "게시글 정보.", required = true) CommentDto commentDto) throws Exception {
		logger.info("writeComment - 호출");
		if (boardService.writeComment(commentDto))
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		else
			return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
	@ApiOperation(value = "댓글 수정", notes = "댓글을 수정한다. DB입력에 성공하면 'success' 실패하면 'fail'을 반환 ", response = String.class)
	@PutMapping("/comment")
	public ResponseEntity<String> modifyComment(
			@RequestBody @ApiParam(value = "수정할 글정보.", required = true) CommentDto commentDto) throws Exception {
		logger.info("modifyComment - 호출");
		if (boardService.updateComment(commentDto))
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		else
			return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@ApiOperation(value = "댓글 삭제", notes = "댓글을 삭제한다. DB삭제에 성공하면 'success' 실패하면 'fail'을 반환 ", response = String.class)
	@DeleteMapping("/comment")
	public ResponseEntity<String> deleteComment(
			@RequestBody @ApiParam(value = "댓글 정보.", required = true) CommentDto commentDto) throws Exception {
		logger.info("deleteComment - 호출 ");
		if (boardService.deleteComment(commentDto))
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		else
			return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
}