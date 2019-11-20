package user;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import util.DatabaseUtil;

public class UserDAO {
	
	DataSource dataSource;
	
	public UserDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/CapstonDesign");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//���̵�� ��й�ȣ�� �޾� �α���
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;
				}
				else {
					return 0;
				}
			}
			return -1;
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -2;
	}
	//������� ������ �޾� ȸ������ ����
	public int join(UserDTO user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,false,?,?,?)";
		Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			pstmt.setString(5, user.getUserName());
			pstmt.setString(6, user.getUserAge());
			pstmt.setString(7, user.getUserGender());
			return pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -1; //ȸ������ ����
	}
	//������� �̸��� ���� ����
	public boolean getUserEmailChacked(String userID) {
		String SQL = "SELECT userEmailChacked From USER WHERE userID = ?";
		Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getBoolean(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return false; //ȸ������ ����
	}
	//������� �̸��� ���� �޾� �̸��� �ּ� ��ȯ
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail From USER WHERE userID = ?";
		Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return null; //ȸ������ ����
	}
	//������� �̸��� ���� ����
	public boolean setUserEmailChacked(String userID) {
		String SQL = "UPDATE USER SET userEmailChacked = true WHERE userID = ? ";
		Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return false; //ȸ������ ����
	}
	// ����� ���� �˻�
	
	public ArrayList<UserDTO> search(String userName){
		String SQL = "SELECT * FROM USER WHERE userName LIKE ?";
		Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserDTO> userList = new ArrayList<UserDTO>();
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,"'%"+ userName +"%'");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserDTO userDTO = new UserDTO();
				userDTO.setUserName(rs.getString(1));
				userDTO.setUserID(rs.getString(2));
				userDTO.setUserEmail(rs.getString(3));
				userDTO.setUserAge(rs.getString(4));
				userDTO.setUserGender(rs.getString(5));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return userList;
	}
	
	public int registerCheck(String userID) {
		java.sql.Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next() || userID.equals("")) {
				return 0; // �̹� �����ϴ� ȸ��
			} else {
				return 1; //���� ������ ȸ�����̵�
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
		return -1; // �����ͺ��̽� ����
	}
	
	public UserDTO getUser(String userID) {
		UserDTO user = new UserDTO();
		java.sql.Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user.setUserID(userID);
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserName(rs.getString("userName"));
				user.setUserAge(rs.getString("userAge"));
				user.setUserGender(rs.getString("userGender"));
				user.setUserEmail(rs.getString("userEmail"));
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
		return user; // �����ͺ��̽� ����
	}
}
