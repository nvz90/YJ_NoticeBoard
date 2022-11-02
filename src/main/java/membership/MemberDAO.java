package membership;

import common.JDBConnect;

public class MemberDAO extends JDBConnect {

	public MemberDTO getMemberDTO(String uid, String upass) {
		MemberDTO dto = new MemberDTO();
		String query = "select * from member where id=? and pass=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();
			
			//System.out.println(uid +  upass);
			
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setRegidate(rs.getString(4));
			}
			
			//System.out.println(dto.getId()+"앵");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	public boolean insertMember(String id, String pass, String name) {
		boolean check = false;
		String query = "insert into member(id, pass, name) values(?,?,?)";
		try {
			psmt=con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pass);
			psmt.setString(3, name);
			psmt.executeUpdate();
			return check;
		}catch(Exception e) {
			System.out.println("회원가입 중 예외발생");
			e.printStackTrace();
			check = true;
		}
		return check;
	}
	public boolean checkId(String id){
		boolean check = false;
		String checkId = "";
		String query = "select id from member where id=?";
		try {
			psmt=con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				checkId = rs.getString("id");
			}
			if(checkId.equals(id)) {
				check = true;
			}
		}catch(Exception e) {
			System.out.println("회원가입 아이디확인 중 예외발생");
			e.printStackTrace();
		}
		return check;
	}
	public boolean checkName(String name){
		boolean check = false;
		String checkName = "";
		String query = "select name from member where name=?";
		try {
			psmt=con.prepareStatement(query);
			psmt.setString(1, name);
			rs = psmt.executeQuery();
			if(rs.next()) {
				checkName = rs.getString("name");
			}
			System.out.println(checkName);
			if(checkName.equals(name)) {
				System.out.println("중복");
				check = true;
			}
			
		}catch(Exception e) {
			System.out.println("회원가입 닉네임확인 중 예외발생");
			e.printStackTrace();
		}
		
		return check;
	}
}
	
