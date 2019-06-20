package com.rbac.console.dao;


import com.rbac.console.entity.ConsoleMenu;
import com.rbac.console.entity.ConsoleMenuExample;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
@Mapper
public interface ConsoleMenuMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _CONSOLE_MENU
     *
     * @mbggenerated
     */
    int countByExample(ConsoleMenuExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _CONSOLE_MENU
     *
     * @mbggenerated
     */
    int deleteByExample(ConsoleMenuExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _CONSOLE_MENU
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _CONSOLE_MENU
     *
     * @mbggenerated
     */
    int insert(ConsoleMenu record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _CONSOLE_MENU
     *
     * @mbggenerated
     */
    int insertSelective(ConsoleMenu record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _CONSOLE_MENU
     *
     * @mbggenerated
     */
    List<ConsoleMenu> selectByExample(ConsoleMenuExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _CONSOLE_MENU
     *
     * @mbggenerated
     */
    ConsoleMenu selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table CONSOLE_MENU
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") ConsoleMenu record, @Param("example") ConsoleMenuExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table CONSOLE_MENU
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") ConsoleMenu record, @Param("example") ConsoleMenuExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _CONSOLE_MENU
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(ConsoleMenu record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _CONSOLE_MENU
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(ConsoleMenu record);
    
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _CONSOLE_MENU
     *
     * @mbggenerated
     */
    List<ConsoleMenu> getConsoleMenusByUserId(Map<String, String> map);
}