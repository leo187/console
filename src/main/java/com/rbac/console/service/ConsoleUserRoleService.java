package com.rbac.console.service;

import com.rbac.console.entity.ConsoleUserRole;

import java.util.List;
public interface ConsoleUserRoleService {
	/**
	 * 添加记录
	 * @return
	 */
	public int addConsoleUserRole(int userId, String roleIds);
	/**
	 * 查找记录
	 * @return
	 */
	public List<ConsoleUserRole> getConsoleUserRoleByUserId(int userid);
	/**
	 * 修改记录
	 * @return
	 */
	public int updateConsoleUserRole(int userID, String roleIds);
}
