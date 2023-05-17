package com.earth.heart;

import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.earth.heart.dao.BoardDao;
import com.earth.heart.domain.BoardDTO;
import com.earth.heart.domain.SearchItem;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class BoardDaoImplTest {

	@Autowired
	private BoardDao boardDao;
	
	//@Test
	public void countTest() throws Exception{
		boardDao.deleteAll();
		assertTrue(boardDao.count()==0);
		
		BoardDTO boardDTO = new BoardDTO("Pioneering", "Ready for Action", "earth");
		assertTrue(boardDao.insert(boardDTO)==1);
		assertTrue(boardDao.count()==1);
		
		assertTrue(boardDao.insert(boardDTO)==1);
		assertTrue(boardDao.count()==2);
	}
	
	//@Test
	public void insertTest() throws Exception{
		boardDao.deleteAll();
		BoardDTO boardDTO = new BoardDTO("Pioneering", "Ready for Action", "earth");
		assertTrue(boardDao.insert(boardDTO)==1);
		
		assertTrue(boardDao.insert(boardDTO)==1);
		assertTrue(boardDao.count()==2);
		
		boardDao.deleteAll();
		assertTrue(boardDao.insert(boardDTO)==1);
		assertTrue(boardDao.count()==1);
	}
	
	//@Test
	public void selectTest() throws Exception {
		assertTrue(boardDao != null);
		System.out.println("boardDao = "+boardDao);
		
		BoardDTO boardDTO = boardDao.select(6); 
		System.out.println("boardDTO = "+boardDTO);
		assertTrue(boardDTO.getBno().equals(6));
		
		boardDao.deleteAll();
		boardDTO = new BoardDTO("Pioneering", "Ready for Action", "earth");
		boardDao.insert(boardDTO);
		
		boardDTO = boardDao.select(7);
		System.out.println("boardDTO = "+boardDTO);
		assertTrue(boardDTO.getBno().equals(7));
	}
	
	//@Test
	public void selectAllTest() throws Exception{
		boardDao.deleteAll();
		assertTrue(boardDao.count()==0);
		
		List<BoardDTO> list = boardDao.selectAll();
		assertTrue(list.size()==0);
		
		BoardDTO boardDTO = new BoardDTO("Pioneering", "Ready for Action", "earth");
		assertTrue(boardDao.insert(boardDTO)==1);
		
		list = boardDao.selectAll();
		assertTrue(list.size()==1);
		
		assertTrue(boardDao.insert(boardDTO)==1);
		list = boardDao.selectAll();
		assertTrue(list.size()==2);
	}
	
	//@Test
	public void deleteTest() throws Exception{
		boardDao.deleteAll();
		assertTrue(boardDao.count()==0);
		
		BoardDTO boardDTO = new BoardDTO("Pioneering", "Ready for Action", "earth");
		assertTrue(boardDao.insert(boardDTO)==1);
		Integer bno = boardDao.selectAll().get(0).getBno();
		assertTrue(boardDao.delete(bno, boardDTO.getWriter())==1);
		assertTrue(boardDao.count()==0);
		
		assertTrue(boardDao.insert(boardDTO)==1);
		bno = boardDao.selectAll().get(0).getBno();
		//같은 작성자가 아니면 삭제할 수 없음
		assertTrue(boardDao.delete(bno, boardDTO.getWriter()+"earth")==0);
		assertTrue(boardDao.count()==1);
		
		assertTrue(boardDao.delete(bno, boardDTO.getWriter())==1);
		assertTrue(boardDao.count()==0);
		
		assertTrue(boardDao.insert(boardDTO)==1);
		bno = boardDao.selectAll().get(0).getBno();
		//글번호가 같지 않으면 삭제할 수 없음
		assertTrue(boardDao.delete(bno+1, boardDTO.getWriter())==0);
		assertTrue(boardDao.count()==1);
	}
	
	//@Test
	public void deleteAllTest() throws Exception{
		boardDao.deleteAll();
		assertTrue(boardDao.count()==0);
		
		BoardDTO boardDTO = new BoardDTO("Pioneering", "Ready for Action", "earth");
		assertTrue(boardDao.insert(boardDTO)==1);
		assertTrue(boardDao.deleteAll()==1);
		assertTrue(boardDao.count()==0);
		
		assertTrue(boardDao.insert(boardDTO)==1);
		assertTrue(boardDao.insert(boardDTO)==1);
		assertTrue(boardDao.deleteAll()==2);
		assertTrue(boardDao.count()==0);
	}
	
	//@Test
	public void updateTest() throws Exception{
		boardDao.deleteAll();
		
		BoardDTO boardDTO = new BoardDTO("Pioneering", "Ready for Action", "earth");
		assertTrue(boardDao.insert(boardDTO)==1);
		
		Integer bno = boardDao.selectAll().get(0).getBno();
		System.out.println("bno = "+bno);
		boardDTO.setBno(bno);
		boardDTO.setTitle("yes i can");
		assertTrue(boardDao.update(boardDTO)==1);
		
		BoardDTO boardDTO2 = boardDao.select(bno);
		assertTrue(boardDTO.equals(boardDTO2));
	}
	
	@Test
	public void insertDummyTestData() throws Exception{
		boardDao.deleteAll();
		
		for(int i=1; i <= 250; i++) {
			BoardDTO boardDTO = new BoardDTO("Pioneering"+i, "Ready for Action", "earth");
			boardDao.insert(boardDTO);			
		}
	}
	
	//@Test
	public void searchSelectPageTest() throws Exception {
		boardDao.deleteAll();
		for(int i=1; i<=20; i++) {
			BoardDTO boardDTO = new BoardDTO("아메아메아메"+i, "아메리카노 죠아 맛나 시원해"+i, "earth");
			boardDao.insert(boardDTO);	
		}
		
		SearchItem sc = new SearchItem(1, 10, "T", "아메2");		//%아메2%
		List<BoardDTO> list = boardDao.searchSelectPage(sc);
		System.out.println("list = "+list);
		
		assertTrue(list.size()==2); 	//1~20, 아메2, 아메20
	}
	
	//@Test
	public void searchResultCntTest() throws Exception{
		boardDao.deleteAll();
		for(int i=1; i<=20; i++) {
			BoardDTO boardDTO = new BoardDTO("아메아메아메"+i, "아메리카노 죠아 맛나 시원해"+i, "earth");
			boardDao.insert(boardDTO);	
		}
		
		SearchItem sc = new SearchItem(1, 10, "T", "아메2");		//%아메2%
		int cnt = boardDao.searchResultCnt(sc);
		
		assertTrue(cnt==2); 	//1~20, 아메2, 아메20
	}
	
	
}







































