package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.happyhouse.model.CommentDto;
import com.ssafy.happyhouse.model.BoardDto;
import com.ssafy.happyhouse.model.BoardParameterDto;
import com.ssafy.happyhouse.model.mapper.BoardMapper;
import com.ssafy.util.PageNavigation;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	@Transactional
	public boolean writeArticle(BoardDto boardDto) throws Exception {
		return sqlSession.getMapper(BoardMapper.class).writeArticle(boardDto) == 1;
	}

	@Override
	public List<BoardDto> listArticle(BoardParameterDto boardParameterDto) throws Exception {
		int start = boardParameterDto.getPg() == 0 ? 0 : (boardParameterDto.getPg() - 1) * boardParameterDto.getSpp();
		boardParameterDto.setStart(start);
		return sqlSession.getMapper(BoardMapper.class).getListArticle(boardParameterDto);
	}
	
	@Override
	public int listArticleTotalCount(BoardParameterDto boardParameterDto) throws Exception {
		return sqlSession.getMapper(BoardMapper.class).getTotalCount(boardParameterDto);
	}
	
	@Override
	public PageNavigation makePageNavigation(BoardParameterDto boardParameterDto) throws Exception {
		PageNavigation pageNavigation = new PageNavigation();
		
		int naviSize = 10;
		int currentPage = boardParameterDto.getPg();
		int sizePerPage = boardParameterDto.getSpp();
		
		pageNavigation.setCurrentPage(currentPage);
		pageNavigation.setNaviSize(naviSize);
		int totalCount = sqlSession.getMapper(BoardMapper.class).getTotalCount(boardParameterDto);
		pageNavigation.setTotalCount(totalCount);
		int totalPageCount = (totalCount - 1) / sizePerPage + 1;
		pageNavigation.setTotalPageCount(totalPageCount);
		boolean startRange = currentPage <= naviSize;
		pageNavigation.setStartRange(startRange);
		boolean endRange = (totalPageCount - 1) / naviSize * naviSize < currentPage;
		pageNavigation.setEndRange(endRange);
		pageNavigation.makeNavigator();
		
		return pageNavigation;
	}

	@Override
	public BoardDto getArticle(int articleNo) throws Exception {
		return sqlSession.getMapper(BoardMapper.class).getArticle(articleNo);
	}

	@Override
	@Transactional
	public boolean updateArticle(BoardDto boardDto) throws Exception {
		return sqlSession.getMapper(BoardMapper.class).updateArticle(boardDto) == 1;
	}

	@Override
	@Transactional
	public boolean deleteArticle(int articleNo) throws Exception {
		return sqlSession.getMapper(BoardMapper.class).deleteArticle(articleNo) == 1;
	}

	@Override
	public List<CommentDto> getListComment(int articleNo) throws Exception {
		return sqlSession.getMapper(BoardMapper.class).getListComment(articleNo);
	}

	@Override
	public boolean writeComment(CommentDto commentDto) throws Exception {
		return sqlSession.getMapper(BoardMapper.class).writeComment(commentDto) == 1;
	}

	@Override
	public boolean updateComment(CommentDto commentDto) throws Exception {
		return sqlSession.getMapper(BoardMapper.class).updateComment(commentDto) == 1;
	}

	@Override
	public boolean deleteComment(CommentDto commentDto) throws Exception {
		return sqlSession.getMapper(BoardMapper.class).deleteComment(commentDto) == 1;
	}

}
