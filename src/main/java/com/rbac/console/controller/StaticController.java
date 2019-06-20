package com.rbac.console.controller;

import com.rbac.console.util.UserList;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/superadmin/user")
public class StaticController {
    @RequestMapping(value = "/getDatagrTop", method = RequestMethod.GET)
    public ModelAndView getDatagrTop(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        UserList u1 = UserList.getInstance();
        modelAndView.addObject("userCount",u1.getUserCount());
        ServletContext context=request.getSession().getServletContext();
        int count = 0;
        count = context.getAttribute("count") == null ? 0 : Integer.parseInt(context.getAttribute("count").toString());
        modelAndView.addObject("count",count);
        String type = request.getParameter("type");
        modelAndView.addObject("type",type);
        modelAndView.addObject("time",time);
        modelAndView.setViewName("admin_head");
        return modelAndView;
    }
    @RequestMapping(value = "/adminDatagrid", method = RequestMethod.GET)
    //(remark="管理员查看导航栏对应菜单")
    public ModelAndView testDatagrid(HttpServletRequest request){
        String _type = request.getParameter("type");
        ModelAndView modelAndView = new ModelAndView();
        if(_type != null){
            if("console".equals(_type)){
                //授权
                request.setAttribute("type","console");
            }
        }
        modelAndView.setViewName("index");
        return modelAndView;
    }
    @RequestMapping("/propertiesDatagrid")
    //(remark="POST请求URL跳转")
    public String propertiesDatagrid(HttpServletRequest request){
        String url = request.getParameter("url");
        return ""+url;
    }
    @RequestMapping(value = "/getDatagrid", method = RequestMethod.GET)
    //(remark="GET请求URL跳转")
    public String getDatagrid(HttpServletRequest request){
        String url = request.getParameter("url");
        return ""+url;
    }
}