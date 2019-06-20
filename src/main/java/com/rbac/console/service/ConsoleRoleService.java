package com.rbac.console.service;

import com.rbac.console.entity.ConsoleRole;
import com.rbac.console.entity.ConsoleRoleExample;
import com.rbac.console.util.PageResultAll;

import java.util.List;
public interface ConsoleRoleService {
	
	/**
	 * 角色列表
	 */
	public PageResultAll<ConsoleRole> getConsoleRoles(int pageNum, int pageSize, String order, String roleName);
	
	/**
	 * 添加角色
	 */
	
	public int addConsoleRole(ConsoleRole Role);
	
	/**
	 * 根据角色ID集合删除角色
	 */
	int deleteConsoleRoles(String _sRoleIds);
	/**
	 * 根据角色Id查找角色
	 */
	
	public ConsoleRole getConsoleRoleById(int roleId);
	/**
	 * 根据角色Id号修改角色
	 */
	public int updateConsoleRoleByRoleId(int roleId, String roleName, String roleDesc);
	/**
	 * 根据角色名称得到角色编号
	 */
	public ConsoleRole getConsoleRoleByRoleName(String roleName);
	
	/**
	 * 获取所有的角色
	 */
	public List<ConsoleRole> getAllConsoleRole(ConsoleRoleExample RoleExample);
	
}
