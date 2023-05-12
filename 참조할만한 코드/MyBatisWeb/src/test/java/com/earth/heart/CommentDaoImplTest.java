package com.earth.heart;

import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.earth.heart.dao.CommentDao;
import com.earth.heart.domain.CommentDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class CommentDaoImplTest {

	@Autowired
	CommentDao commentDao;
	
	//@Test
	public void count() throws Exception{
		commentDao.deleteAll(1);
		assertTrue(commentDao.count(1)==0);
	}
	
	//@Test
	public void delete() throws Exception{
		commentDao.deleteAll(1);
		
		CommentDTO commentDTO = new CommentDTO(1, 0, "목아파", "나쥬");
		assertTrue(commentDao.insert(commentDTO)==1);;
		assertTrue(commentDao.count(1)==1);
	}
	
	//@Test
	public void insert() throws Exception{
		commentDao.deleteAll(1);
		
		CommentDTO commentDTO = new CommentDTO(1, 0, "목아파", "나쥬");
		assertTrue(commentDao.insert(commentDTO)==1);;
		assertTrue(commentDao.count(1)==1);
		
		commentDTO = new CommentDTO(1, 0, "졸려.. 하루종일 누워있고 싶댜..", "나쥬");
		assertTrue(commentDao.insert(commentDTO)==1);;
		assertTrue(commentDao.count(1)==2);
	}
	
	//@Test
	public void selectAll() throws Exception{
		commentDao.deleteAll(1);
		
		CommentDTO commentDTO = new CommentDTO(1, 0, "목아파", "나쥬");
		assertTrue(commentDao.insert(commentDTO)==1);;
		assertTrue(commentDao.count(1)==1);
		
		List<CommentDTO> list = commentDao.selectAll(1);
		assertTrue(list.size()==1);
		
		commentDTO = new CommentDTO(1, 0, "졸려.. 하루종일 누워있고 싶댜..", "나쥬");
		assertTrue(commentDao.insert(commentDTO)==1);;
		assertTrue(commentDao.count(1)==2);
		
		list = commentDao.selectAll(1);
		assertTrue(list.size()==2);		
	}
	
	//@Test
	public void select() throws Exception{
		commentDao.deleteAll(1);
		
		CommentDTO commentDTO = new CommentDTO(1, 0, "목아파", "나쥬");
		assertTrue(commentDao.insert(commentDTO)==1);;
		assertTrue(commentDao.count(1)==1);
		
		List<CommentDTO> list = commentDao.selectAll(1);
		String comment = list.get(0).getComment();
		String commenter = list.get(0).getCommenter();
		assertTrue(comment.equals(commentDTO.getComment()));
		assertTrue(commenter.equals(commentDTO.getCommenter()));
	}
	
	@Test
	public void update() throws Exception{
		commentDao.deleteAll(1);
		
		CommentDTO commentDTO = new CommentDTO(1, 0, "목아파", "나쥬");
		assertTrue(commentDao.insert(commentDTO)==1);;
		assertTrue(commentDao.count(1)==1);
		
		List<CommentDTO> list = commentDao.selectAll(1);
		commentDTO.setCno(list.get(0).getCno());
		commentDTO.setComment("힘 내야지 힘 내야지이이이이이ㅣ이이잉");
		assertTrue(commentDao.update(commentDTO)==1);
		
		list = commentDao.selectAll(1);
		String comment = list.get(0).getComment();
		String commenter = list.get(0).getCommenter();
		assertTrue(comment.equals(commentDTO.getComment()));
		assertTrue(commenter.equals(commentDTO.getCommenter()));
	}
} 



 

















