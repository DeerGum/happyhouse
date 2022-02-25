package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.CommentDto;
import com.ssafy.happyhouse.model.BoardDto;
import com.ssafy.happyhouse.model.BoardParameterDto;
import com.ssafy.util.PageNavigation;

public interface BoardService {
	
	boolean writeArticle(BoardDto boardDto) throws Exception;
	List<BoardDto> listArticle(BoardParameterDto boardParameterDto) throws Exception;
	int listArticleTotalCount(BoardParameterDto boardParameterDto) throws Exception;
	PageNavigation makePageNavigation(BoardParameterDto boardParameterDto) throws Exception;
	BoardDto getArticle(int articleNo) throws Exception;
	boolean updateArticle(BoardDto boardDto) throws Exception;
	boolean deleteArticle(int articleNo) throws Exception;
	List<CommentDto> getListComment(int articleNo) throws Exception;
	boolean writeComment(CommentDto commentDto) throws Exception;
	boolean updateComment(CommentDto commentDto) throws Exception;
	boolean deleteComment(CommentDto commentDto) throws Exception;
}
