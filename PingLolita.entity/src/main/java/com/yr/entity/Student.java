package com.yr.entity;





import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;

import javax.validation.constraints.Email;
import java.util.Date;


public class Student {

	private Integer id;//学生id
	
	private String name;//学生姓名
	
	@Email
	private String emil;//学生邮箱
	
	private Integer sex;//性别
	
		@DateTimeFormat(pattern ="yyyy-MM-dd")
		@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	private Date Time;
	
	@NumberFormat(pattern = "#,###,###.##")
	private Float moeny;//金钱
	
	private String head;//头像

	private School school;//学校

	private int schoolId;

	public int getSchoolId() {
		return schoolId;
	}

	public void setSchoolId(int schoolId) {
		this.schoolId = schoolId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmil() {
		return emil;
	}

	public void setEmil(String emil) {
		this.emil = emil;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Date getTime() {
		return Time;
	}

	public void setTime(Date time) {
		Time = time;
	}

	public Float getMoeny() {
		return moeny;
	}

	public void setMoeny(Float moeny) {
		this.moeny = moeny;
	}

	public String getHead() {
		return head;
	}

	public void setHead(String head) {
		this.head = head;
	}

	public School getSchool() {
		return school;
	}

	public void setSchool(School school) {
		this.school = school;
	}

	@Override
	public String toString() {
		return "Student [id=" + id + ", name=" + name + ", emil=" + emil + ", sex=" + sex + ", Time=" + Time
				+ ", moeny=" + moeny + ", head=" + head + "]";
	}
	
	
	


	
	
	
	
}
