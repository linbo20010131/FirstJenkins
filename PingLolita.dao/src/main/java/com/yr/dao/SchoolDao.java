package com.yr.dao;

import com.yr.entity.School;

import java.util.List;

public interface SchoolDao extends BaseDao<School> {

    @Override
    List<School> getAll();

    @Override
    School getById(Integer id);
}
