package com.rbac.console.service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.rbac.console.dao.ConsoleUserMapper;
import com.rbac.console.entity.ConsoleUser;
import com.rbac.console.entity.ConsoleUserExample;
import com.rbac.console.service.ConsoleUserService;
import com.rbac.console.util.PageResultAll;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
@Service
public class ConsoleUserServiceImpl implements ConsoleUserService {
	@Autowired
	private ConsoleUserMapper ConsoleUserDao;
	@SuppressWarnings("unchecked")
	@Override
	public PageResultAll<ConsoleUser> getAllConsoleUsers(int pageNum, int pageSize, String order, Map<String, Object> params) {
		int count = ConsoleUserDao.selectConsoleUser(params).size();
		PageResultAll<ConsoleUser> consoleUserPage = new PageResultAll<ConsoleUser>(pageNum,pageSize,order);
		PageHelper.startPage(pageNum,pageSize);
		List<ConsoleUser> list =ConsoleUserDao.selectConsoleUser(params);
		consoleUserPage.setResult(list);
		consoleUserPage.setTotal(count);
		return consoleUserPage;
		}
	//根据用户id查询用户信息
	@SuppressWarnings("unchecked")
	@Override
	public ConsoleUser getUserById(int userId) {
		ConsoleUser ConsoleUser  = ConsoleUserDao.selectByPrimaryKey(userId);
		return ConsoleUser;
	}
	//批量修改用户状态
	@SuppressWarnings("unchecked")
	@Override
	public int updateConsoleUserStatusByUserId(String userid) {
		int nRows = 0;
		String[] userIds=userid.split(",");
		for(int i=0;i<userIds.length;i++){
			 ConsoleUserExample example = new ConsoleUserExample();
			 ConsoleUser record=new ConsoleUser();
			 int userId=Integer.parseInt(userIds[i]);
			 example.createCriteria().andIdEqualTo(userId);
			 record.setUserStatus(0);
			 ConsoleUserDao.updateByExampleSelective(record, example);
			 nRows++;
		}
	return nRows;
	}
	//修改用户信息
	@SuppressWarnings("unchecked")
	@Override
	public int updateCosoleUserByConsoleUser(
			ConsoleUser ConsoleUser) {
		int msg = 0;
		if (ConsoleUser!=null) {
		msg = ConsoleUserDao.updateByPrimaryKeySelective(ConsoleUser);
		} 
		return msg;
	}
	@SuppressWarnings("unchecked")
	@Override
	public int updatePwdByUserIds(String _sUserIds, String passWord) {
		int nRows = 0;
		String[] userIds=_sUserIds.split(",");
		for(int i=0;i<userIds.length;i++){
			ConsoleUserExample example = new ConsoleUserExample();
			ConsoleUser ConsoleUser = new ConsoleUser();
			int userId=Integer.parseInt(userIds[i]);
			example.createCriteria().andIdEqualTo(userId);
			ConsoleUser.setPassword(passWord);
			ConsoleUserDao.updateByExampleSelective(ConsoleUser, example);
			nRows++;
		}
		return nRows;
	}
	@SuppressWarnings("unchecked")
	@Override
	public int deleteConsoleUserUserIds(String userid){
		int nRows = 0;
		String[] userIds=userid.split(",");
		for(int i=0;i<userIds.length;i++){
			 ConsoleUserExample example = new ConsoleUserExample();
			 ConsoleUser record=new ConsoleUser();
			 int userId=Integer.parseInt(userIds[i]);
			 example.createCriteria().andIdEqualTo(userId);
			 record.setUserStatus(-1);
			 ConsoleUserDao.updateByExampleSelective(record, example);
			 nRows++;
		}
	return nRows;
	}
	@SuppressWarnings("unchecked")
	@Override
	public int startConsoleUserUserIds(String userid) {
		int nRows = 0;
		String[] userIds=userid.split(",");
		for(int i=0;i<userIds.length;i++){
			 ConsoleUserExample example = new ConsoleUserExample();
			 ConsoleUser record=new ConsoleUser();
			 int userId=Integer.parseInt(userIds[i]);
			 example.createCriteria().andIdEqualTo(userId);
			 record.setUserStatus(1);
			 ConsoleUserDao.updateByExampleSelective(record, example);
			 nRows++;
	}
		return nRows;
	}
	@Override
	public List<ConsoleUser> selectConsoleUserByExample(
			ConsoleUserExample consoleUserExample) {
		return ConsoleUserDao.selectByExample(consoleUserExample);
	}
	@Override
	public List<ConsoleUser> findByUserNameAndPwd(String userName,
												  String pwd) {
		List<ConsoleUser>  list = null;
		ConsoleUserExample example = new ConsoleUserExample();
		example.createCriteria().andUsernameEqualTo(userName).andPasswordEqualTo(pwd).andUserStatusNotEqualTo(-1);
		list = ConsoleUserDao.selectByExample(example);
		return list;
	}
}