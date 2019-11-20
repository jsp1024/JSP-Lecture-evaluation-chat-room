package user;

public class ChatuserDTO {
	String ChatuserID;
	String ChatuserPassword;
	String ChatuserName;
	int ChatuserAge;
	String ChatuserGender;
	String ChatuserEmail;
	String ChatuserProfile;
	public String getChatuserID() {
		return ChatuserID;
	}
	public void setChatuserID(String chatuserID) {
		ChatuserID = chatuserID;
	}
	public String getChatuserPassword() {
		return ChatuserPassword;
	}
	public void setChatuserPassword(String chatuserPassword) {
		ChatuserPassword = chatuserPassword;
	}
	public String getChatuserName() {
		return ChatuserName;
	}
	public void setChatuserName(String chatuserName) {
		ChatuserName = chatuserName;
	}
	public int getChatuserAge() {
		return ChatuserAge;
	}
	public void setChatuserAge(int chatuserAge) {
		ChatuserAge = chatuserAge;
	}
	public String getChatuserGender() {
		return ChatuserGender;
	}
	public void setChatuserGender(String chatuserGender) {
		ChatuserGender = chatuserGender;
	}
	public String getChatuserEmail() {
		return ChatuserEmail;
	}
	public void setChatuserEmail(String chatuserEmail) {
		ChatuserEmail = chatuserEmail;
	}
	public String getChatuserProfile() {
		return ChatuserProfile;
	}
	public void setChatuserProfile(String chatuserProfile) {
		ChatuserProfile = chatuserProfile;
	}
	
	public ChatuserDTO() {
		
	}
	
	public ChatuserDTO(String chatuserID, String chatuserPassword, String chatuserName, int chatuserAge,
			String chatuserGender, String chatuserEmail, String chatuserProfile) {
		super();
		ChatuserID = chatuserID;
		ChatuserPassword = chatuserPassword;
		ChatuserName = chatuserName;
		ChatuserAge = chatuserAge;
		ChatuserGender = chatuserGender;
		ChatuserEmail = chatuserEmail;
		ChatuserProfile = chatuserProfile;
	}
	
	
	
	
}
