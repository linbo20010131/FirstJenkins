package com.yr.service;

import com.yr.dao.BaseDao;
import com.yr.entity.Page;
import com.yr.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {
	
	@Autowired
	private BaseDao<Student> studentDao;
	
	@Autowired
	private SchoolService schoolService;
	
	/**
	 * 分页查询
	 * @param page
	 */

	public void query(Page<Student> page) {

		//开始下标
		int start = (page.getPageNo() - 1) * page.getPageSize();
		page.setStart(start);


		//数据总记录
		page.setSum(studentDao.getCount());
		//查询记录
		List<Student> list =  studentDao.pageList(page);
		//封装数据
		page.setList(list);
	}
	 
	
	/**
	 * 查询列表
	 * @return
	 */

	public List<Student> query() {
		
		//查询所有学生
		List<Student> list = studentDao.getAll();
		return list;
	}
	/**
	 * 新增
	 * @param stu
	 * @return stu
	 */

	public Integer add(Student stu) {
		
		stu.setSchoolId(stu.getSchool().getId());

		studentDao.save(stu);
		return stu.getId();
	}
	
	
	/**
	 * 根据id删除
	 * 
	 * @param id
	 */

	public void delete(Integer id) {
		studentDao.delete(id);
	}
	
	/**
	 * 根据student修改 
	 * 
	 * @param
	 * @return stu
	 */

	public void updateStudent(Student stu) {
		if(stu.getId() !=null && stu.getId() !=0) {
			stu.setSchoolId(stu.getSchool().getId());
			//修改
			studentDao.update(stu);
		}
		
		
	}
	
	/**
	 * 根据id获取学生信息
	 * @param id
	 * @return
	 */
	public Student getStudent(Integer id) {
		Student stu = studentDao.getById(id);

		return stu;
	}
	
	
}
