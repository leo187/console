package com.rbac.console.service;

import com.rbac.console.entity.ConsoleMenu;
import com.rbac.console.entity.ConsoleMenuExample;
import com.rbac.console.util.PageResultAll;

import java.util.List;
import java.util.Map;
public interface ConsoleMenuService {
	/**
	 * 获取所有的菜单
	 * @return
	 */
	public List<ConsoleMenu> getAllConsoleMenus();
	/**
	 * 根据菜单Id号获取菜单
	 * @param menuId
	 * @return
	 */
	public ConsoleMenu getConsoleMenuById(int menuId);
	/**
	 * 通过父类Id查询该菜单下的所有子类菜单
	 * @return
	 */
	public List<ConsoleMenu> getConsoleMenuByParentId(int parentMenuId);
	/**
	 * 根据条件获取所有角色
	 * @return
	 */
	public PageResultAll<ConsoleMenu> getSystemRoles(int pageNum, int pageSize, String order, String menuName, int _searchWord);
	/**
	 * 添加新菜单
	 * @return
	 */
	public int addConsoleMenu(ConsoleMenu ConsoleMenu);
	/**
	 * 批量删除菜单
	 * @return
	 */
	public int deleteConsoleMenus(String _sMenuIds);
	/**
	 * 修改菜单
	 * @return
	 */
	public int updateConsoleMenuById(int Id, String menuName, String menuDesc, String isadminMenu, String iscanUpdate, String ismenu, String buttonHtmlcontent);

	/***
	 * 根据用户id还有上级询下级菜单
	 * @Modified
	 */
	public List<ConsoleMenu> getConsoleMenusByUserId(Map<String, String> map);
	
	/**
	 * 公共主页菜单
	 * @return
	 */
	public Map<Object,Map<Object,List<ConsoleMenu>>> getClassMap(List<ConsoleMenu> consoleMenus, Integer userId);


	/***
	 * 查询
	 * @Modified
	 */
	public List<ConsoleMenu> selectConsoleMenuByExample(ConsoleMenuExample consoleMenuExample);
	
}
