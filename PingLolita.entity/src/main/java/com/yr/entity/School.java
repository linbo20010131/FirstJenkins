package com.yr.entity;

public class School {

	private Integer id;//学校的id
	
	private String schoolName;//学校的名字
	

	
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	@Override
	public String toString() {
		return "School [id=" + id + ", schoolName=" + schoolName + "]";
	}
	
	
	

	
	
}
