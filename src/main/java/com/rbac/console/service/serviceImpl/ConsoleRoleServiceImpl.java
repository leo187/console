package com.rbac.console.service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.rbac.console.dao.ConsoleRoleMapper;
import com.rbac.console.entity.ConsoleRole;
import com.rbac.console.entity.ConsoleRoleExample;
import com.rbac.console.service.ConsoleRoleService;
import com.rbac.console.util.PageResultAll;
import com.rbac.console.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ConsoleRoleServiceImpl implements ConsoleRoleService {
	@Autowired
	private ConsoleRoleMapper ConsoleRoleMapper;

	@SuppressWarnings("unchecked")
	@Override
	public PageResultAll<ConsoleRole> getConsoleRoles(int pageNum, int pageSize,
											 String order, String roleName) {
			ConsoleRoleExample example = new ConsoleRoleExample();
			if(!StringUtils.isNull(roleName)){
			   example.createCriteria().andRolenameLike("%"+roleName+"%");
			}else{
				example.createCriteria().andIdIsNotNull();
			}
			int count = ConsoleRoleMapper.countByExample(example);
			PageResultAll<ConsoleRole> consoleRolePage = new PageResultAll<ConsoleRole>(pageNum,pageSize,order);
			PageHelper.startPage(pageNum, pageSize, order);
			consoleRolePage.setResult(ConsoleRoleMapper.selectByExample(example));
			consoleRolePage.setTotal(count);
		   return consoleRolePage;
	}

	@Override
	public int addConsoleRole(ConsoleRole Role) {
		int flag=ConsoleRoleMapper.insertSelective(Role);
		return flag;
	}

	@Override
	public int deleteConsoleRoles(String _sRoleIds) {
		int nRows = 0;
		String[] roleIds=_sRoleIds.split(",");
		for(int i=0;i<roleIds.length;i++){
			 ConsoleRoleExample example = new ConsoleRoleExample();
			 int roleId=Integer.parseInt(roleIds[i]);
			 example.createCriteria().andIdEqualTo(roleId);
			 ConsoleRoleMapper.deleteByExample(example);
			 nRows++;
           }
		return nRows;
	}

	@Override
	public ConsoleRole getConsoleRoleById(int roleId) {
		ConsoleRole Role=ConsoleRoleMapper.selectByPrimaryKey(roleId);
		return Role;
	}

	@Override
	public int updateConsoleRoleByRoleId(int roleId,String roleName,String roleDesc) {
		int status=0;
		ConsoleRoleExample example = new ConsoleRoleExample();
		example.createCriteria().andIdEqualTo(roleId);
		ConsoleRole record=new ConsoleRole();
		record.setRolename(roleName);
		record.setRoledesc(roleDesc);
		status=ConsoleRoleMapper.updateByExampleSelective(record, example);
		return status;
	}

	@Override
	public ConsoleRole getConsoleRoleByRoleName(String roleName) {
		ConsoleRoleExample example = new ConsoleRoleExample();
		example.createCriteria().andRolenameEqualTo(roleName);
		List<ConsoleRole> Roles=ConsoleRoleMapper.selectByExample(example);
		ConsoleRole Role=Roles.get(0);
		return Role;
	}

	@Override
	public List<ConsoleRole> getAllConsoleRole(ConsoleRoleExample RoleExample) {
		return ConsoleRoleMapper.selectByExample(RoleExample);
	}



}
