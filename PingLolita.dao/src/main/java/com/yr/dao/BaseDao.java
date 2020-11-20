package com.yr.dao;

import com.yr.entity.Page;

import java.util.List;

public interface BaseDao<T> {


    /**
     * 添加
     * @param t
     */
    public Integer save(T t);

    /**
     *根据id删除
     * @param id
     */
    public void delete(Integer id);

    /**
     * 查询所有
     * @return
     */
    public List<T> getAll();

    /**
     * 根据id查询
     * @param id
     * @return
     */
    public T getById(Integer id);


    /**
     * 修改
     * @param t
     */
    public void update(T t);

    /**
     * 分页查询
     * @param page
     * @return
     */
    public List<T> pageList(Page page);

    /**
     * 获取总记录数
     * @return
     */
    public Long getCount();

}
