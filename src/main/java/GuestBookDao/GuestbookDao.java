package GuestBookDao;

import java.util.List;


public interface GuestbookDao {
	public List<GuestVo> getList(); 	// emaillist table SELECT
	public boolean insert(GuestVo vo);	// emaillist table INSERT
	public boolean delete(int no, String password);
}
