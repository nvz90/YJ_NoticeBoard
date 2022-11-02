package model1.board;

import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletContext;
import common.JDBConnect;

public class BoardDAO extends JDBConnect {
//    public BoardDAO(ServletContext application) {
//        super(application);
//    }

    // 검색 조건에 맞는 게시물의 개수를 반환합니다.
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0; // 결과(게시물 수)를 담을 변수

        // 게시물 수를 얻어오는 쿼리문 작성
        String query = "SELECT COUNT(*) FROM board";
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%'";	// 해당문자열에 % % 사이문자있으면 get 
        }

        try {
            stmt = con.createStatement();   // 쿼리문 생성
            rs = stmt.executeQuery(query);  // 쿼리 실행
            rs.next();  // 커서를 첫 번째 행으로 이동
            totalCount = rs.getInt(1);  // 첫 번째 칼럼 값을 가져옴
        }
        catch (Exception e) {
            System.out.println("게시물 수를 구하는 중 예외 발생");
            e.printStackTrace();
        }

        return totalCount; 
    }
    
    // 검색 조건에 맞는 게시물 목록을 반환합니다.
	public List<BoardDTO> selectList (Map<String, Object> map){
		List<BoardDTO> bbs = new Vector<BoardDTO>();
		
		String query = "select * from board ";
		if(map.get("searchWord") != null) {
			query += " where "+ map.get("searchField") + " "
					+ " Like '%"+ map.get("searchWord") +"%' " ;	// 해당문자열에 % % 사이문자있으면 get 
		}
		query += " order by num desc ";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("Postdate"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setVisitcount(rs.getString("visitCount"));
					
				bbs.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return bbs;
	}
    public List<BoardDTO> boardPaging (Map<String, Object> map, int pageNum, String boardNum){
    	List<BoardDTO> bbs = new Vector<BoardDTO>();
    	
    	String query = "select @rownum := @rownum + 1 rownum, b.* from board b,(select @rownum := 1) rownum";
    	
    	if(map.get("searchWord") != null) {
			query += " where "+ map.get("searchField") + " "
					+ " Like '%"+ map.get("searchWord") +"%'" ;	// 해당문자열에 % % 사이문자있으면 get 
		}
    	
    	int start = (pageNum-1)*(Integer.parseInt(boardNum))+1;
    	int end = Integer.parseInt(boardNum);
    	if(pageNum == 1)start=0;
    	
		query += " order by num desc limit " + start + "," + end;
    	try {
//			psmt = con.prepareStatement(query);
//    		psmt.setInt(1, pageNum);
//			psmt.setInt(2, boardNum);
    		
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(query);
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("Postdate"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setVisitcount(rs.getString("visitCount"));
					
				bbs.add(dto);
			}
		}catch(Exception e) {
    		System.out.println("게시물 페이징 처리중 예외 발생");
    		e.printStackTrace();
    	}
    	
    	return bbs;
    }
    public BoardDTO selectView(String num) {
    	BoardDTO dto = new BoardDTO();
    	
    	String query = "select B.*, M.name "
    				+ " From member M inner Join board B "
    				+ " on M.id = B.id "
    				+ " where num=? ";
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, num);
    		rs = psmt.executeQuery();
    		
    		if(rs.next()) {
    			dto.setNum(rs.getString(1));
                dto.setTitle(rs.getString(2));
                dto.setContent(rs.getString(3));
                dto.setPostdate(rs.getDate("postdate"));
                dto.setId(rs.getString("id"));
                dto.setVisitcount(rs.getString("visitcount"));
                dto.setName(rs.getString("name"));
    		}
    	}
    	catch(Exception e) {
    		System.out.println("게시물 상세보기 중 예외발생");
    		e.printStackTrace();
    	}
    	return dto;
    }
    public void updateVisitCount(String num) {
    	String query = "update board set visitcount = visitcount+1 where num=?";
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, num);
    		psmt.executeUpdate();
    	}catch(Exception e) {
    		System.out.println("게시물 조회수업데이트 중 예외발생");
    		e.printStackTrace();
    	}
    }
    public void updateTitle(String title, String num) {
    	String query = "update board set title = ? where num=?";
    	try {
    		psmt= con.prepareStatement(query);
    		psmt.setString(1, title);
    		psmt.setString(2, num);
    		psmt.executeUpdate();	
    	}catch(Exception e) {
    		System.out.println("게시물 제목업데이트 중 예외발생");
    		e.printStackTrace();
    	}
    	
    }
    public void updateContent(String content, String num) {
    	String query = "update board set content = ? where num=?";
    	try {
    		psmt= con.prepareStatement(query);
    		psmt.setString(1, content);
    		psmt.setString(2, num);
    		psmt.executeUpdate();	
    	}catch(Exception e) {
    		System.out.println("게시물 내용업데이트 중 예외발생");
    		e.printStackTrace();
    	}
    }
    public void insertWrite(String id, String title, String content, String name) {
    	String query = "insert into board(id, title, content, visitcount, name) values(?,?,?,?,?)";
    	try {
    		psmt= con.prepareStatement(query);
    		psmt.setString(1, id);
    		psmt.setString(2, title);
    		psmt.setString(3, content);
    		psmt.setInt(4, 0);
    		psmt.setString(5,name);
    		psmt.executeUpdate();
    	}catch(Exception e) {
    		System.out.println("게시물 등록 중 예외발생");
    		e.printStackTrace();
    	}
    }
    public void deleteBoard(String num) {
    	String query = "delete from board where num=?";
    	try {
    		psmt=con.prepareStatement(query);
    		psmt.setString(1,num);
    		psmt.executeUpdate();
    	}catch(Exception e) {
    		System.out.println("게시물 삭제 중 예외발생");
    		e.printStackTrace();
    	}
    }
}
