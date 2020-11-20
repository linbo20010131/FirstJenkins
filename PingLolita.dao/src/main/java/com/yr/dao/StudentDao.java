package com.yr.dao;




import com.yr.entity.Page;
import com.yr.entity.Student;

import java.util.List;

public interface StudentDao extends BaseDao<Student> {

    @Override
    Integer save(Student student);

    @Override
    void delete(Integer id);

    @Override
    List<Student> getAll();

    @Override
    Student getById(Integer id);

    @Override
    void update(Student student);

    @Override
    List<Student> pageList(Page page);

    @Override
    Long getCount();

}
