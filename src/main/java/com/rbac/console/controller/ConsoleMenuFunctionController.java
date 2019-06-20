package com.rbac.console.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/superadmin/consoleMenuFunction")
public class ConsoleMenuFunctionController {
    @SuppressWarnings("unused")
    @RequestMapping("/selectFunctionsByMenuId")
    //(remark="模块批量添加到菜单")
    public ModelAndView selectFunctionsByMenuId(HttpServletRequest request){
        int menuId=Integer.parseInt(request.getParameter("menuId"));
        ModelAndView modelAndView = new ModelAndView();
        return null;
    }
}
