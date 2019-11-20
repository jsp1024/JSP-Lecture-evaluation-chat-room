package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String ChatuserID = request.getParameter("ChatuserID");
		String ChatuserPassword1 = request.getParameter("ChatuserPassword1");
		String ChatuserPassword2 = request.getParameter("ChatuserPassword2");
		String ChatuserName = request.getParameter("ChatuserName");
		String ChatuserAge = request.getParameter("ChatuserAge");
		String ChatuserGender = request.getParameter("ChatuserGender");
		String ChatuserEmail = request.getParameter("ChatuserEmail");
		String ChatuserProfile = request.getParameter("ChatuserProfile");
		if(ChatuserID == null || ChatuserID.equals("") || ChatuserPassword1 == null || ChatuserPassword1.equals("")
			||	ChatuserPassword2 == null || ChatuserPassword2.equals("") || ChatuserName == null || ChatuserName.equals("")
			|| ChatuserAge == null || ChatuserAge.equals("") || ChatuserGender == null || ChatuserGender.equals("")	
			|| ChatuserEmail == null || ChatuserEmail.equals("")) {
			request.getSession().setAttribute("messageType", "warning");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			response.sendRedirect("chatJoin.jsp");
			return;
			
		}
		else if(ChatuserPassword1 != ChatuserPassword2) {
			request.getSession().setAttribute("messageType", "warning");
			request.getSession().setAttribute("messageContent", "비밀번호가 서로 다릅니다.");
			response.sendRedirect("chatJoin.jsp");
			return;
				
		}
		int result = new ChatuserDAO().register(ChatuserID, ChatuserPassword1, ChatuserName, ChatuserAge, ChatuserGender, ChatuserEmail, ChatuserProfile);
		if(result == 1) {
			request.getSession().setAttribute("messageType", "success");
			request.getSession().setAttribute("messageContent", "회원가입에 성공했습니다.");
			response.sendRedirect("chatindex.jsp");
			return;
			
		} else {
			request.getSession().setAttribute("messageType", "warning");
			request.getSession().setAttribute("messageContent", "이미 존재하는 회원입니다.");
			response.sendRedirect("chatJoin.jsp");
			return;
		}
	}
}
