package com.ssafy.happyhouse.model.mapper;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.CommentDto;
import com.ssafy.happyhouse.model.BoardDto;
import com.ssafy.happyhouse.model.BoardParameterDto;

public interface BoardMapper {
	
	int writeArticle(BoardDto boardDto) throws Exception;
	List<BoardDto> getListArticle(BoardParameterDto boardParameterDto) throws Exception;
	int getTotalCount(BoardParameterDto boardParameterDto) throws Exception;
	BoardDto getArticle(int articleNo) throws Exception;
	int updateArticle(BoardDto boardDto) throws Exception;
	int deleteArticle(int articleNo) throws Exception;

	int writeComment(CommentDto commentDto) throws Exception;
	List<CommentDto> getListComment(int articleNo) throws Exception;
	int updateComment(CommentDto commentDto) throws Exception;
	int deleteComment(CommentDto commentDto) throws Exception;
}
