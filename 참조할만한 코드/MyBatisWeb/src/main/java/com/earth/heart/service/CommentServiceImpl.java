package com.earth.heart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.earth.heart.dao.BoardDao;
import com.earth.heart.dao.CommentDao;
import com.earth.heart.domain.CommentDTO;

@Service
public class CommentServiceImpl implements CommentService {
	
	//두 개의 dao가 모두 DI가 되어야 함
	//@Autowired
	CommentDao commentDao;
	//@Autowired
	BoardDao boardDao;

	//생성자 주입으로 하는 것이 더 안전함
	//생성자가 하나일 경우 @Autowired 생략 가능
	@Autowired
	public CommentServiceImpl(CommentDao commentDao, BoardDao boardDao) {
		super();
		this.commentDao = commentDao;
		this.boardDao = boardDao;
	}

	@Override
	public List<CommentDTO> getList(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		//throw new Exception("exception test");
		return commentDao.selectAll(bno);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int remove(Integer cno, Integer bno, String commenter) throws Exception {
		int	rowCnt = commentDao.delete(cno, commenter);
		if(rowCnt == 1) {
			boardDao.updateCommentCnt(bno, -1);
		}
		return rowCnt;
	}
 
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int write(CommentDTO commentDTO) throws Exception {
		boardDao.updateCommentCnt(commentDTO.getBno(), 1);
		return commentDao.insert(commentDTO);
	}

	@Override
	public int modify(CommentDTO commentDTO) throws Exception {
		// TODO Auto-generated method stub
		return commentDao.update(commentDTO);
	}

}
