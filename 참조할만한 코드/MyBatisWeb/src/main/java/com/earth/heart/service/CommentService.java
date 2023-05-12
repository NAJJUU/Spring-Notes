package com.earth.heart.service;

import java.util.List;

import com.earth.heart.domain.CommentDTO;

public interface CommentService {

	List<CommentDTO> getList(Integer bno) throws Exception;
	int remove(Integer cno, Integer bno, String commenter) throws Exception;
	int write(CommentDTO commentDTO) throws Exception;
	int modify(CommentDTO commentDTO) throws Exception;
}
