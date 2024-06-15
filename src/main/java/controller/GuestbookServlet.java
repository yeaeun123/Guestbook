
package controller;

import java.io.IOException;
import java.util.List;

import GuestBookDao.GuestBookOracleImpl;
import GuestBookDao.GuestVo;
import GuestBookDao.GuestbookDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "guestbook", urlPatterns = "/gb")
public class GuestbookServlet extends BaseServlet {

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String actionName = req.getParameter("a");

		if ("add".equals(actionName)) {
			// 사용자 입력 페이지로 FORWARD
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/WEB-INF/views/guestbook/list.jsp");
			rd.forward(req, resp);

		} else {
			// 목록 받아오는 부분 -> el
			GuestbookDao dao = new GuestBookOracleImpl(dbuser, dbpass);
			List<GuestVo> list = dao.getList();

			// list를 요청 객체에 추가
			req.setAttribute("list", list);
			// list객체 -> jsp로 전달(FORWARD)
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/WEB-INF/views/guestbook/list.jsp");
			rd.forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String actionName = req.getParameter("a");

		if ("insert".equals(actionName)) {
			// INSERT 기능 수행
			String name = req.getParameter("name");
			String password = req.getParameter("pass");
			String content = req.getParameter("content");

			GuestVo vo = new GuestVo();
			vo.setName(name);
			vo.setPassword(password);
			vo.setContent(content);

			GuestbookDao dao = new GuestBookOracleImpl(dbuser, dbpass);
			boolean success = dao.insert(vo);

			if (success) {
				System.out.println("INSERT SUCCESS");
				resp.sendRedirect(req.getContextPath() + "/gb"); // Redirect (3xx)
			} else {
				System.out.println("INSERT FAILED");
				resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "데이터 입력 중 오류가 발생했습니다.");
			}
		} else if ("delete".equals(actionName)) {
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/WEB-INF/views/guestbook/deleteform.jsp");
			req.setAttribute("no", req.getParameter("no"));
			rd.forward(req, resp);

		} else if ("deleteform".equals(actionName)) {

			Long no = Long.valueOf(req.getParameter("no"));
		
			
			GuestbookDao dao = new GuestBookOracleImpl(dbuser, dbpass);
			GuestVo vo = dao.get(no);
			
			String password = req.getParameter("password");
			if (password.equals(vo.getPassword())) {
				
				boolean success = dao.delete(vo);
				if (success) {
					System.out.println("Delete Success");
					resp.sendRedirect(req.getContextPath() + "/gb");
				} else {
					resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "데이터 삭제 중 오류가 발생했습니다.");
				}
			} else {
				resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "패스워드가 틀립니다.");
			}
		} else {
			super.doPost(req, resp);
		}
	}
}
