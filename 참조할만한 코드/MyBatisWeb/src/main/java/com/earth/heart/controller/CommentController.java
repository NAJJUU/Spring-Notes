package com.earth.heart.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.earth.heart.domain.CommentDTO;
import com.earth.heart.service.CommentService;

@Controller
public class CommentController {
	
	@Autowired
	CommentService commentService;

	//지정된 댓글을 삭제하는 메서드
	@DeleteMapping("/comments/{cno}")
	public ResponseEntity<String> remove(@PathVariable Integer cno, Integer bno, HttpSession session){
		String commenter = (String) session.getAttribute("id");
		
		try {
			int rowCnt = commentService.remove(cno, bno, commenter);
			
			if(rowCnt != 1)
				throw new Exception("Delete Failed");
			
			return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("DEL_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	//지정된 게시물의 모든 댓글을 가져오는 메서드
	@GetMapping("/comments")
	@ResponseBody
	public ResponseEntity<List<CommentDTO>> list(Integer bno){
		List<CommentDTO> list = null;
		
		try {
			list = commentService.getList(bno);
			return new ResponseEntity<List<CommentDTO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<List<CommentDTO>>(HttpStatus.BAD_REQUEST);
		}
		//return list;
	}
}














