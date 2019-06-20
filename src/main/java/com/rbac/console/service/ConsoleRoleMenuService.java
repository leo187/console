package com.rbac.console.service;

import com.rbac.console.entity.ConsoleRoleMenu;

import java.util.List;
public interface ConsoleRoleMenuService {
	/***
	 * 将选中的菜单绑定到对应角色
	 */
	public int addConsoleRoleMenu(int roleId, String _sMenuIds);
	/***
	 * 根据roleId查询该角色拥有的菜单权限
	 */
	public List<ConsoleRoleMenu> getConsoleMenusByConsoleRoleId(int roleId);

}
