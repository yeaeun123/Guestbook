package GuestBookDao;

import java.util.Date;

public class GuestVo {
    private int no;
    private String name;
    private String password;
    private String content;
    private Date regDate;

    public GuestVo() {}

    public GuestVo(int no, String name, String password, String content, Date regDate) {
        this.no = no;
        this.name = name;
        this.password = password;
        this.content = content;
        this.regDate = regDate;
    }

    public GuestVo(String name, String password, String content) {
        this.name = name;
        this.password = password;
        this.content = content;
    }

    // Getters and Setters

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    @Override
    public String toString() {
        return "GuestVo [no=" + no + ", name=" + name + ", password=" + password + ", content=" + content + ", regDate="
                + regDate + "]";
    }
}
