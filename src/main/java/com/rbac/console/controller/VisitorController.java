package com.rbac.console.controller;

import com.rbac.console.aspect.WebLog;
import com.rbac.console.entity.ConsoleMenu;
import com.rbac.console.entity.ConsoleUser;
import com.rbac.console.entity.ConsoleUserExample;
import com.rbac.console.service.ConsoleMenuService;
import com.rbac.console.service.ConsoleUserService;
import com.rbac.console.util.SessionHelper;
import com.rbac.console.util.SessionInfo;
import com.rbac.console.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@org.springframework.stereotype.Controller
public class VisitorController {
    @Autowired
    private ConsoleUserService consoleUserService;
    @Autowired
    private ConsoleMenuService consoleMenuService;

    @WebLog
    @RequestMapping("/toLogin")
    public String toLogin(){
        return "login";
    }
    @RequestMapping("/adminlogin")
    // (remark="管理员登录")
    public ModelAndView loginUserAdmin(HttpServletRequest request)
            throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        String returnStr = null;
        SessionInfo sessionInfoLogin = SessionHelper.getAdminSessionInfo(request);
        if (sessionInfoLogin != null) {
            List<ConsoleMenu> topMenu = (List<ConsoleMenu>) request.getSession().getAttribute("topMenu");
            modelAndView.setViewName("redirect:/"+ topMenu.get(0).getMenuHref() + "");// 默认的第一个地址
            modelAndView.addObject("firstLogin", "1");
            return modelAndView;
        }
        String userName = request.getParameter("username");
        String passWord = request.getParameter("password");
        String unpassWord = " ";
        if (userName != null && passWord != null) {
            ConsoleUserExample userExample = new ConsoleUserExample();
            userExample.createCriteria().andUsernameEqualTo(userName).andPasswordEqualTo(passWord);
            List<ConsoleUser> example = consoleUserService.selectConsoleUserByExample(userExample);
            if (example.size() == 1) {
                ConsoleUser consoleUser = example.get(0);
                if (consoleUser.getUserStatus() != null && consoleUser.getUserStatus() == 1) {// 启用
                    HashMap<String, String> hashMap = new HashMap<String, String>();
                    hashMap.put("userId", consoleUser.getId().toString());
                    hashMap.put("parentId", "1");
                    List<ConsoleMenu> consoleMenusByUserId = consoleMenuService.getConsoleMenusByUserId(hashMap);
                    if (consoleMenusByUserId != null && consoleMenusByUserId.size() > 0) {
                            Map<Object, Map<Object, List<ConsoleMenu>>> menuMap = new LinkedHashMap<Object, Map<Object, List<ConsoleMenu>>>();
                            menuMap = consoleMenuService.getClassMap(consoleMenusByUserId, consoleUser.getId());
                            SessionInfo sessionInfo = new SessionInfo();
                            sessionInfo.setConsoleUser(consoleUser);
                            sessionInfo.setLoginDate(new Date());
                            HttpSession session = request.getSession();
                            session.setAttribute("adminSessionInfo",sessionInfo);
                            session.setAttribute("topMenu", consoleMenusByUserId);
                            session.setAttribute("allMenu", menuMap);
                            modelAndView.setViewName("redirect:/"+ consoleMenusByUserId.get(0).getMenuHref()+ "");// 默认的第一个地址
                    } else {
                        returnStr = "用户状态未启用，请联系管理员";
                        modelAndView.addObject("firstLogin", "1");
                        modelAndView.setViewName("/login");// 用户状态未启用，请联系管理员
                    }

                } else {
                    returnStr = "没有权限访问，请联系管理员";
                    modelAndView.addObject("firstLogin", "1");
                    modelAndView.setViewName("/login");// 没有权限访问，请联系管理员
                }
            } else {
                returnStr = "用户不存在或密码错误";
                modelAndView.addObject("firstLogin", "1");
                modelAndView.setViewName("/login");// 用户不存在
            }
        } else {
            if(StringUtils.isNull(request.getHeader("Referer")) || request.getHeader("Referer").endsWith("adminlogin")){
                modelAndView.addObject("firstLogin", "1");
            }else{
                modelAndView.addObject("firstLogin", "0");
            }
            returnStr = "输入为空";
            modelAndView.setViewName("/login");// 输入为空
        }
        if (returnStr != null) {
            if ("POST".equals(request.getMethod()))
                modelAndView.addObject("mess", returnStr);
        }
        return modelAndView;
    }
    @RequestMapping(value = "/adminDatagrid", method = RequestMethod.GET)
    //(remark="管理员查看导航栏对应菜单")
    public ModelAndView testDatagrid(HttpServletRequest request){
        String _type = request.getParameter("type");
        ModelAndView modelAndView = new ModelAndView();
        if(_type != null){
            if("goods".equals(_type)){
                //商品
                request.setAttribute("type", "goods");
            }else if("store".equals(_type)){
                //店铺
                request.setAttribute("type", "store");
            }else if("content".equals(_type)){
                //内容管理
                request.setAttribute("type", "content");
            }else if("classify".equals(_type)){
                //分类管理
                request.setAttribute("type", "classify");
            }else if("log".equals(_type)){
                //会员管理
                request.setAttribute("type", "log");
            }else if("set".equals(_type)){
                //店铺
                request.setAttribute("type", "set");
            }else if("user".equals(_type)){
                //店铺
                request.setAttribute("type", "user");
            }else if("personalcenter".equals(_type)){
                //店铺
                request.setAttribute("type", "personalcenter");
            }else if("advert".equals(_type)){
                //店铺
                request.setAttribute("type", "advert");
            }else if("myAgents".equals(_type)){
                //店铺
                request.setAttribute("type", "myAgents");
            }else if("statistics".equals(_type)){
                //店铺
                request.setAttribute("type", "statistics");
            }else if("market".equals(_type)){
                request.setAttribute("type","market");

            }else if("invoice".equals(_type)){
                //发票
                request.setAttribute("type","invoice");
            }else if("management".equals(_type)){
                //发票
                request.setAttribute("type","management");
            }else if("console".equals(_type)){
                //授权
                request.setAttribute("type","console");
            }else if("otherGoods".equals(_type)){
                //待处理商品
                request.setAttribute("type","otherGoods");
            }else if("money".equals(_type)){
                //待处理商品
                request.setAttribute("type","money");
            }
        }
        modelAndView.setViewName("index");
        return modelAndView ;
    }
    @RequestMapping("/adminLoginout")
    public ModelAndView adminLoginout(HttpServletRequest request)
            throws IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);// 防止创建上session
        ModelAndView model = new ModelAndView();
        model.setViewName("redirect:/toLogin");
        if (StringUtils.isNull(session)) {
            return model;
        } else {
            session.removeAttribute("adminSessionInfo");
            session.removeAttribute("topMenu");
            session.removeAttribute("allMenu");
        }
        return model;
    }
}