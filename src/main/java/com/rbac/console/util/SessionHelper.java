package com.rbac.console.util;

import javax.servlet.http.HttpServletRequest;

public final class SessionHelper {
	public static SessionInfo getAdminSessionInfo(HttpServletRequest request){
		Object si = request.getSession().getAttribute("adminSessionInfo");
		if (si != null){
			return (SessionInfo) si;												
		}else{
			return null;
		}
	}
}
