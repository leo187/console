package com.rbac.console.service;

import com.rbac.console.entity.ConsoleUser;
import com.rbac.console.entity.ConsoleUserExample;
import com.rbac.console.util.PageResultAll;

import java.util.List;
import java.util.Map;
public interface ConsoleUserService {
	/***
	 * 查询所有用户
	 */
	public PageResultAll<ConsoleUser> getAllConsoleUsers(int pageNum, int pageSize, String order, Map<String, Object> params);
	/***
	 * 根据用户Id查询用户数据
	 */
	public ConsoleUser getUserById(int userId);
	/***
	 * 根据用户Id修改用户状态
	 */
	public int updateConsoleUserStatusByUserId(String userid);
	/***
	 * 修改用户信息
	 */
	public int updateCosoleUserByConsoleUser(ConsoleUser ConsoleUser);
	/***
	 * 根据用户Id批量修改用户密码
	 */
	int updatePwdByUserIds(String _sUserIds, String passWord);
	/***
	 * 根据用户Id批量删除用户
	 */
	public int deleteConsoleUserUserIds(String userid);
	/***
	 * 根据用户Id批量启用用户
	 */
	public int startConsoleUserUserIds(String userid);

	public List<ConsoleUser> selectConsoleUserByExample(ConsoleUserExample consoleUserExample);
	/***
	 * 根据用户名和密码查找用户
	 */
	public List<ConsoleUser> findByUserNameAndPwd(String userName, String pwd);
	
}
