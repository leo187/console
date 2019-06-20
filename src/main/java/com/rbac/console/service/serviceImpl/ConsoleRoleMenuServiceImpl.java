package com.rbac.console.service.serviceImpl;

import java.util.ArrayList;
import java.util.List;

import com.rbac.console.dao.ConsoleRoleMenuMapper;
import com.rbac.console.entity.ConsoleRoleMenu;
import com.rbac.console.entity.ConsoleRoleMenuExample;
import com.rbac.console.service.ConsoleRoleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ConsoleRoleMenuServiceImpl implements ConsoleRoleMenuService {
	@Autowired
	private ConsoleRoleMenuMapper ConsoleRoleMenuMapperdao;

	
	
	@Override
	public int addConsoleRoleMenu(int roleId, String _sMenuIds) {
		// TODO Auto-generated method stub
		
		int nRows = 0;
		String[] menuIds=_sMenuIds.split(",");
		List<Integer> newMenuIds=new ArrayList<Integer>();
		for(int i=0;i<menuIds.length;i++){
			if(!newMenuIds.contains(Integer.parseInt(menuIds[i]))){
				newMenuIds.add(Integer.parseInt(menuIds[i]));
			}
		}
		List<ConsoleRoleMenu> ConsoleRoleMenuList=this.getConsoleMenusByConsoleRoleId(roleId);
		if(ConsoleRoleMenuList.size()!=0){
			List<Integer> menuIdds=new ArrayList<Integer>();
			
			for(int j=0;j<ConsoleRoleMenuList.size();j++){
				menuIdds.add(ConsoleRoleMenuList.get(j).getMenuId());
			}
			
			int flagg=0;
			for(int i=0;i<menuIdds.size();i++){
				int flag=0;
				for(int k=0;k<newMenuIds.size();k++){
					int menuId=newMenuIds.get(k);
					if(menuIdds.get(i)==menuId){
						flag++;
						flagg++;
						if(flagg<=newMenuIds.size()){
						if(!menuIdds.contains(menuId)){
							ConsoleRoleMenu record=new ConsoleRoleMenu();
							 record.setMenuId(menuId);
							 record.setRoleId(roleId);
							 ConsoleRoleMenuMapperdao.insertSelective(record);
							 nRows++;
						  }else{
							  continue;
						  }
						}else{
							continue;
						}
					}else{
						flagg++;
						if(flagg<=newMenuIds.size()){
						if(!menuIdds.contains(menuId)){
							ConsoleRoleMenu record=new ConsoleRoleMenu();
							 record.setMenuId(menuId);
							 record.setRoleId(roleId);
							 ConsoleRoleMenuMapperdao.insertSelective(record);
							 nRows++;
						  }else{
							  continue;
						  }
						}else{
							continue;
						}
					}
				 
				}
				
				if(flag==0){
					ConsoleRoleMenuExample example=new ConsoleRoleMenuExample();
					example.createCriteria().andRoleIdEqualTo(roleId).andMenuIdEqualTo(menuIdds.get(i));
					ConsoleRoleMenuMapperdao.deleteByExample(example);
				
				}
				
			}
		}else{
			for(int i=0;i<newMenuIds.size();i++){
				ConsoleRoleMenu record=new ConsoleRoleMenu();
				 record.setMenuId(newMenuIds.get(i));
				 record.setRoleId(roleId);
				 ConsoleRoleMenuMapperdao.insertSelective(record);
				 nRows++;
			}
		}
		return nRows++;
	}
	
	
	@Override
	public List<ConsoleRoleMenu> getConsoleMenusByConsoleRoleId(int roleId) {
		ConsoleRoleMenuExample example = new ConsoleRoleMenuExample();
		example.createCriteria().andRoleIdEqualTo(roleId);
		List<ConsoleRoleMenu>  ConsoleRoleMenu=ConsoleRoleMenuMapperdao.selectByExample(example);
		return ConsoleRoleMenu;
	}
}
