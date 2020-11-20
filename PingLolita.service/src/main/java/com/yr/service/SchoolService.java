package com.yr.service;

import com.yr.dao.BaseDao;
import com.yr.entity.School;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SchoolService {
	
	@Autowired
	private BaseDao<School> schoolDao;
	/**
	 * 返回学校数据
	 * @return
	 */
	public List<School> getList(){
		return schoolDao.getAll();
	}
	/**
	 * 根据学校id返回学校
	 * @param
	 * @return
	 */
	public School getSchool(Integer id) {
		return schoolDao.getById(id);
	}
		
	
}
