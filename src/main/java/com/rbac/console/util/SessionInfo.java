package com.rbac.console.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import com.rbac.console.entity.ConsoleUser;

@SuppressWarnings("serial")
public class SessionInfo implements java.io.Serializable,HttpSessionBindingListener {
	private ConsoleUser consoleUser;
	
	private String roleName;
	
	private List<Integer> roleId;
	
	private int istsjs; //是否是特殊角色,备用
	
	private Date loginDate;	

	private List<String> resourceUrls = new ArrayList<String>();
	//判断超级管理员
	public boolean isSuperAdmin() {
		boolean result = false;
		if(roleId.size() == 1 && roleId.contains(3))
			result = true;
		return result;
	}
	public ConsoleUser getConsoleUser() {
		return consoleUser;
	}

	public void setConsoleUser(ConsoleUser consoleUser) {
		this.consoleUser = consoleUser;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public int getIstsjs() {
		return istsjs;
	}

	public void setIstsjs(int istsjs) {
		this.istsjs = istsjs;
	}

	public Date getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
	}

	public List<String> getResourceUrls() {
		return resourceUrls;
	}

	public void setResourceUrls(List<String> resourceUrls) {
		this.resourceUrls = resourceUrls;
	}
}
