package com.rbac.console.service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.rbac.console.dao.ConsoleMenuMapper;
import com.rbac.console.entity.ConsoleMenu;
import com.rbac.console.entity.ConsoleMenuExample;
import com.rbac.console.service.ConsoleMenuService;
import com.rbac.console.util.PageResultAll;
import com.rbac.console.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;


@Service
public class ConsoleMenuServiceImpl implements ConsoleMenuService {
	@Autowired
	private ConsoleMenuMapper ConsoleMenudao;

	@Override
	public ConsoleMenu getConsoleMenuById(int menuId) {
		ConsoleMenu ConsoleMenu=ConsoleMenudao.selectByPrimaryKey(menuId);
		return ConsoleMenu;
	}

	@Override
	public List<ConsoleMenu> getConsoleMenuByParentId(int parentId) {
		ConsoleMenuExample example = new ConsoleMenuExample();
		example.createCriteria().andParentIdEqualTo(parentId).andIsDeleteEqualTo("0");
		List<ConsoleMenu> ConsoleMenuList=ConsoleMenudao.selectByExample(example);
		return ConsoleMenuList;
	}

	@Override
	public List<ConsoleMenu> getAllConsoleMenus() {
		ConsoleMenuExample example=new ConsoleMenuExample();
		example.createCriteria();
		List<ConsoleMenu> ConsoleMenuList=ConsoleMenudao.selectByExample(example);
		return ConsoleMenuList;
	}
	@SuppressWarnings("unchecked")
	@Override
	public PageResultAll<ConsoleMenu> getSystemRoles(int pageNum, int pageSize,
											String order, String menuName, int _searchWord) {

		ConsoleMenuExample example = new ConsoleMenuExample();
		if(!StringUtils.isNull(menuName)){
			   example.createCriteria().andMenuNameLike("%"+menuName+"%").andParentIdEqualTo(_searchWord).andIsDeleteEqualTo("0");
		}else{
			example.createCriteria().andParentIdEqualTo(_searchWord).andIsDeleteEqualTo("0");
		}
		int count = ConsoleMenudao.countByExample(example);
		PageResultAll<ConsoleMenu> consoleMenuPage = new PageResultAll<ConsoleMenu>(pageNum,pageSize,order);
		PageHelper.startPage(pageNum,pageSize);
		consoleMenuPage.setResult(ConsoleMenudao.selectByExample(example));
		consoleMenuPage.setTotal(count);
		return consoleMenuPage;
	}

	@Override
	public int addConsoleMenu(ConsoleMenu ConsoleMenu) {
		int flag=ConsoleMenudao.insertSelective(ConsoleMenu);
		return flag;
	}

	@Override
	public int deleteConsoleMenus(String _sMenuIds) {
		// TODO Auto-generated method stub
		int nRows = 0;
		String[] menuIds=_sMenuIds.split(",");
		for(int i=0;i<menuIds.length;i++){
		ConsoleMenuExample example = new ConsoleMenuExample();
		int menuId=Integer.parseInt(menuIds[i]);
		example.createCriteria().andIdEqualTo(menuId);
		//ConsoleMenudao.deleteByExample(example);
		ConsoleMenu menu = new ConsoleMenu();
		menu.setIsDelete("1");
		int index = ConsoleMenudao.updateByExampleSelective(menu, example);
		if(index==1){
			nRows++;
		}
		}
		return nRows++;
	}

	@Override
	public int updateConsoleMenuById(int Id,String menuName,String menuDesc,String isadminMenu,String iscanUpdate,String ismenu,String buttonHtmlcontent) {
		int status=0;
		ConsoleMenuExample example = new ConsoleMenuExample();
		example.createCriteria().andIdEqualTo(Id);
		ConsoleMenu menu = new ConsoleMenu();
		menu.setMenuName(menuName);
		menu.setMenuDesc(menuDesc);
		menu.setIsadminMenu(isadminMenu);
		menu.setIscanUpdate(iscanUpdate);
		menu.setIsmenu(ismenu);
		menu.setButtonHtmlcontent(buttonHtmlcontent);
		status = ConsoleMenudao.updateByExampleSelective(menu, example);
		return status;
	}

	@Override
	public List<ConsoleMenu> getConsoleMenusByUserId(
			Map<String, String> map) {
		return ConsoleMenudao.getConsoleMenusByUserId(map);
	}

	@Override
	public Map<Object,Map<Object,List<ConsoleMenu>>> getClassMap(List<ConsoleMenu> byUserIdFirst,Integer userId){
		//一级分类
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("userId", userId.toString());
		
		List<ConsoleMenu>  ListSecond = new ArrayList<ConsoleMenu>();
		List<ConsoleMenu>  ListThird = new ArrayList<ConsoleMenu>();
		
		//结果变量
		Map<Object,Map<Object,List<ConsoleMenu>>> ClassMap = new LinkedHashMap<Object, Map<Object,List<ConsoleMenu>>>();
		Map<Object,List<ConsoleMenu>> tempClassMap = null;
		
		for (int i = 0; i < byUserIdFirst.size(); i++) {
			tempClassMap = new LinkedHashMap<Object, List<ConsoleMenu>>();
			hashMap.put("parentId", byUserIdFirst.get(i).getId().toString());
			//二级分类
			ListSecond = this.getConsoleMenusByUserId(hashMap);
			for (int j = 0; j < ListSecond.size(); j++) {
				hashMap.put("parentId", ListSecond.get(j).getId().toString());
				//san级分类
				ListThird = this.getConsoleMenusByUserId(hashMap);
				tempClassMap.put(ListSecond.get(j), ListThird);
			}
			ClassMap.put(byUserIdFirst.get(i).getMenuParm3(), tempClassMap);
		}
		return  ClassMap;
	}

	@Override
	public List<ConsoleMenu> selectConsoleMenuByExample(
			ConsoleMenuExample consoleMenuExample) {
		return ConsoleMenudao.selectByExample(consoleMenuExample);
	}
}
