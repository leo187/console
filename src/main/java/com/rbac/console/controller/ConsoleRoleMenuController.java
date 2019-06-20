package com.rbac.console.controller;

import javax.servlet.http.HttpServletRequest;

import com.rbac.console.util.SessionHelper;
import com.rbac.console.util.SessionInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.rbac.console.service.ConsoleRoleMenuService;
@Controller
@RequestMapping("/superadmin/ConsoleRoleMenu")
public class ConsoleRoleMenuController {
    @Autowired
    private ConsoleRoleMenuService ConsoleRoleMenuService;
    @RequestMapping("/addConsoleRoleMenu")
    @ResponseBody
    //(remark="为角色赋予权限")
    public int addMenuRoleLinks(HttpServletRequest request) throws Exception{
        boolean flag = false; // define opear result
        long startTime = System.currentTimeMillis();
        SessionInfo sessionInfo = SessionHelper.getAdminSessionInfo(request);
        request.setCharacterEncoding("UTF-8");
        int nRows=0;
        int roleId=Integer.parseInt(request.getParameter("roleId"));
        String _sMenuIds=request.getParameter("menuIds");
        nRows=ConsoleRoleMenuService.addConsoleRoleMenu(roleId, _sMenuIds);
        return nRows;
    }
}