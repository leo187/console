package com.rbac.console.service.serviceImpl;

import java.util.Date;
import java.util.List;

import com.rbac.console.dao.ConsoleUserRoleMapper;
import com.rbac.console.entity.ConsoleRole;
import com.rbac.console.entity.ConsoleUserRole;
import com.rbac.console.entity.ConsoleUserRoleExample;
import com.rbac.console.service.ConsoleUserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class ConsoleUserRoleServiceImpl implements ConsoleUserRoleService {
	@Autowired
	private ConsoleUserRoleMapper ConsoleUserRoledao;
	@Autowired
	protected com.rbac.console.service.ConsoleRoleService ConsoleRoleService;
	@Override
	public int addConsoleUserRole(int userId, String roleIds){
		String[]  str = roleIds.split(",");
		ConsoleUserRole ConsoleUserRole = new ConsoleUserRole();
		int index = 0;
		for(int i=0;i<str.length;i++){
			int roleId = Integer.parseInt(str[i].trim()); 
			ConsoleRole ConsoleRole =ConsoleRoleService.getConsoleRoleById(roleId);
			 ConsoleUserRole.setCreateTime(new Date());
			 //ConsoleUserRole.setCreateUserid();
			 ConsoleUserRole.setRoleId(roleId);
			 ConsoleUserRole.setRoleName(ConsoleRole.getRolename());
			 ConsoleUserRole.setUserId(userId);
			 int k = ConsoleUserRoledao.insert(ConsoleUserRole);
			 if(k==1){
				 index++;
			 }
		}
		if(index==str.length){
			return 1;
		}else{
			return 0;
		}
	}
	@Override
	public List<ConsoleUserRole> getConsoleUserRoleByUserId(int userid) {
		ConsoleUserRoleExample example = new ConsoleUserRoleExample();
		example.createCriteria().andUserIdEqualTo(userid);
		List<ConsoleUserRole> list = ConsoleUserRoledao.selectByExample(example);
		return list;
	}
	@Override
	public int updateConsoleUserRole(int userID, String roleIds) {
		//思路 取到ROLEIDS之前的记录删除，写入新纪录
		ConsoleUserRoleExample example = new ConsoleUserRoleExample();
		example.createCriteria().andUserIdEqualTo(userID);
		ConsoleUserRoledao.deleteByExample(example);
		int result = this.addConsoleUserRole(userID, roleIds);
		return result;
	}

}
