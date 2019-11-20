package user;

import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ChatuserDAO {
	
	DataSource dataSource;
	
	public ChatuserDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/CapstonDesign");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String ChatuserID, String ChatuserPassword) {
		java.sql.Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CHATUSER WHERE ChatuserID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, ChatuserID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString("ChatuserPassword").equals(ChatuserPassword)) {
					return 1; // 로그인 성공
				}
				return 2; // 비밀번호 틀림
			} else {
				return 0; // 사용자가 존재하지 않음
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}
	
	public int registerCheck(String ChatuserID) {
		java.sql.Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CHATUSER WHERE ChatuserID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, ChatuserID);
			rs = pstmt.executeQuery();
			if (rs.next() || ChatuserID.equals("")) {
				return 0; // 이미 존재하는 회원
			} else {
				return 1; //가입 가능한 회원아이디
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}
	
	public int register(String ChatuserID, String ChatuserPassword, String ChatuserName, String ChatuserAge, String ChatuserGender, String ChatuserEmail, String ChatuserProfile) {
		java.sql.Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		String SQL = "INSERT INTO CHATUSER VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, ChatuserID);
			pstmt.setString(2, ChatuserPassword);
			pstmt.setString(3, ChatuserName);
			pstmt.setInt(4, Integer.parseInt(ChatuserAge));
			pstmt.setString(5, ChatuserGender);
			pstmt.setString(6, ChatuserEmail);
			pstmt.setString(7, ChatuserProfile);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}
	
	
}
