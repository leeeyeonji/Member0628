package kh.spring.dto;

import org.springframework.web.multipart.MultipartFile;

public class MemberDTO {

	private String id;
	private String pw;
	private String name;
	private String image;
	private String phone;
	private String email;
	private int zipcode;
	private String addr1;
	private String addr2;
	public MemberDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public MemberDTO(String id, String pw, String name, String image, String phone, String email, int zipcode,
			String addr1, String addr2) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.image = image;
		this.phone = phone;
		this.email = email;
		this.zipcode = zipcode;
		this.addr1 = addr1;
		this.addr2 = addr2;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getZipcode() {
		return zipcode;
	}
	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
}
