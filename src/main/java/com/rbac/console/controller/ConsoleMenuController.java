package com.rbac.console.controller;

import com.alibaba.fastjson.JSON;
import com.rbac.console.entity.ConsoleMenu;
import com.rbac.console.entity.ConsoleMenuExample;
import com.rbac.console.entity.ConsoleRoleMenu;
import com.rbac.console.entity.ConsoleUser;
import com.rbac.console.service.ConsoleMenuService;
import com.rbac.console.service.ConsoleRoleMenuService;
import com.rbac.console.util.PageResultAll;
import com.rbac.console.util.SessionHelper;
import com.rbac.console.util.SessionInfo;
import com.rbac.console.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/superadmin/ConsoleMenu")
public class ConsoleMenuController {
    @Autowired
    private ConsoleRoleMenuService ConsoleRoleMenuService;
    @Autowired
    private ConsoleMenuService ConsoleMenuService;
    @RequestMapping("/getAllConsoleMenus")
    // (remark="获取所有菜单")
    public ModelAndView getAllConsoleMenus(HttpServletRequest request) {
        String _id = request.getParameter("id");
        int id = 0;// 选中节点
        if ("null".equals(_id) || StringUtils.isNull(_id)) {
            id = 1;
        } else {
            id = Integer.parseInt(_id);
        }
        int _searchWord = id;
        int pageNum = 1;
        if (!StringUtils.isNull(request.getParameter("pageNum"))) {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }
        int pageSize = 10;
        if (!StringUtils.isNull(request.getParameter("pageSize"))) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }
        String order = "id desc";
        String menuName = request.getParameter("menuName");
        ModelAndView modelAndView = new ModelAndView();
        PageResultAll<ConsoleMenu> pageConsoleMenu = ConsoleMenuService.getSystemRoles(pageNum, pageSize, order, menuName, _searchWord);
        Long pageTotal = pageConsoleMenu.getTotal();
        modelAndView.addObject("menuName", menuName);
        modelAndView.addObject("menuList", pageConsoleMenu.getResult());
        modelAndView.addObject("parentId", id);
        modelAndView.addObject("pageNum", pageNum);// 当前页
        modelAndView.addObject("pageTotal", pageTotal);// 总条数
        modelAndView.addObject("pageSize", pageSize);// 每页的条数
        modelAndView.setViewName("consolemenu/console_menu_list");
        return modelAndView;
    }
    @RequestMapping("/getConsoleMenuTree")
    // (remark="左侧页面获取菜单树")
    public ModelAndView getMenuTree(HttpServletRequest request) {
        // 传入当前角色的id
        String roleId = request.getParameter("roleId");
        // 通过当前角色的id去关联表中查询对应的绑定角色情况
        List<ConsoleRoleMenu> ConsoleRoleMenus = ConsoleRoleMenuService
                .getConsoleMenusByConsoleRoleId(Integer.parseInt(roleId));
        List<Integer> sMenuIds = new ArrayList<Integer>();
        for (int i = 0; i < ConsoleRoleMenus.size(); i++) {
            sMenuIds.add(ConsoleRoleMenus.get(i).getMenuId());
        }
        int menuId = 1;
        List<Map<String, Object>> list = this.getAllConsoleMenu(menuId);
        String menuJson = JSON.toJSONString(list);
        List<ConsoleMenu> ConsoleMenuList = ConsoleMenuService
                .getAllConsoleMenus();
        List<String> allMenuIds = new ArrayList<String>();
        for (int i = 0; i < ConsoleMenuList.size(); i++) {
            allMenuIds.add(ConsoleMenuList.get(i).getId() + "");
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("menuJson", menuJson);// 所有对象
        modelAndView.addObject("roleId", roleId);// 当前角色的id
        modelAndView.addObject("sMenuIds", sMenuIds);// 本角色绑定的功能
        modelAndView.addObject("allMenuIds", allMenuIds);//
        // modelAndView.setViewName("consolemenu/console_menu_power_list");
        modelAndView
                .setViewName("consolerole/console_role_power_list");
        return modelAndView;
    }


    public List<Map<String, Object>> getAllConsoleMenu(int menuId) {
        List<Map<String, Object>> treeNode = null;
        try {
            treeNode = new ArrayList<Map<String, Object>>();
            Map<String, Object> root = new HashMap<String, Object>();
            ConsoleMenu ConsoleMenu = ConsoleMenuService
                    .getConsoleMenuById(menuId);
            root.put("id", ConsoleMenu.getId());
            root.put("pId", ConsoleMenu.getParentId());
            root.put("name", ConsoleMenu.getMenuName());
            root.put("open", true);
            treeNode.add(root);
            treeNode = getTreeNode(ConsoleMenu.getId(), treeNode);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return treeNode;
    }

    /**
     * 递归调用的查询每一个父节点下的子节点
     */
    public List<Map<String, Object>> getTreeNode(int parentId,
                                                 List<Map<String, Object>> treeNode) {
        try {
            List<ConsoleMenu> ConsoleMenuList = ConsoleMenuService
                    .getConsoleMenuByParentId(parentId);
            // 通过父id查询结果
            if (ConsoleMenuList != null && ConsoleMenuList.size() > 0) {
                for (ConsoleMenu ele : ConsoleMenuList) {
                    Map<String, Object> selfNode = new HashMap<String, Object>();
                    selfNode.put("id", ele.getId());
                    selfNode.put("name", ele.getMenuName());
                    selfNode.put("pId", ele.getParentId());
                    treeNode.add(selfNode);
                    // 通过分类的ID作为父节点
                    treeNode = getTreeNode(ele.getId(), treeNode);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return treeNode;

    }


    // @RequestMapping(value="getConsoleMenu",method=RequestMethod.GET)
    @RequestMapping("/getConsoleMenu")
    // (remark="跳转到添加菜单信息时，要选择的菜单树页面获取菜单树")
        public ModelAndView getConsoleMenu(HttpServletRequest request) {
        int menuId = 1;
        List<Map<String, Object>> list = this.getAllConsoleMenu(menuId);
        String menuJson = JSON.toJSONString(list);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("classJson", menuJson);
        modelAndView.setViewName("consoleuser/console_user_menu");
        return modelAndView;
    }

    @RequestMapping("/getConsoleMenuZTree")
    // (remark="跳转到添加菜单信息时，要选择的菜单树页面获取菜单树")
    public ModelAndView getConsoleMenuZTree(HttpServletRequest request) {
        int menuId = 1;
        List<Map<String, Object>> list = this.getAllConsoleMenu(menuId);
        String menuJson = JSON.toJSONString(list);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("menuJson", menuJson);
        modelAndView
                .setViewName("consolemenu/console_menu_power_list");
        return modelAndView;
    }

    // 转到添加菜单页面
    @RequestMapping("/toAddConsoleMenu")
    public ModelAndView toAddConsoleUser() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("consolemenu/console_menu_add");
        return modelAndView;
    }

    @RequestMapping("/addConsoleMenu")
    @ResponseBody
    // (remark="新增菜单")
    public int addMenu(HttpServletRequest request) throws Exception {
        long startTime = System.currentTimeMillis();
        request.setCharacterEncoding("UTF-8");
        String menuname = request.getParameter("menuname");
        String menudesc = request.getParameter("menudesc");
        String parentId = request.getParameter("parentId");
        String isadminMenu = request.getParameter("isadminMenu");
        String iscanUpdate = request.getParameter("iscanUpdate");
        String ismenu = request.getParameter("ismenu");
        String buttonHtmlcontent = request.getParameter("buttonHtmlcontent");
        ConsoleMenu ConsoleMenu = new ConsoleMenu();
        ConsoleMenu.setParentId(Integer.parseInt(parentId));
        ConsoleMenu.setIsmenu(ismenu);
        ConsoleMenu.setIscanUpdate(iscanUpdate);
        ConsoleMenu.setIsadminMenu(isadminMenu);
        ConsoleMenu.setMenuName(menuname);
        ConsoleMenu.setMenuDesc(menudesc);
        ConsoleMenu.setIsDelete("0");
        ConsoleMenu.setButtonHtmlcontent(buttonHtmlcontent);
        int status = 0;
        status = ConsoleMenuService.addConsoleMenu(ConsoleMenu);
        return status;
    }

    @RequestMapping("/deleteConsoleMenus")
    @ResponseBody
    // (remark="批量删除子菜单")
    public int deleteMenus(HttpServletRequest request) {
        long startTime = System.currentTimeMillis();
        int nRows = 0;
        String _sMenuIds = request.getParameter("menuIds");
        nRows = ConsoleMenuService.deleteConsoleMenus(_sMenuIds);
        return nRows;
    }

    @RequestMapping("/getConsoleMenuById")
    // (remark="通过菜单ID获取菜单信息,转到修改")
    public ModelAndView getMenuById(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        ConsoleMenu menu = ConsoleMenuService
                .getConsoleMenuById(menuId);
        modelAndView.addObject("menu", menu);
        modelAndView.setViewName("consolemenu/console_menu_edit");
        return modelAndView;
    }

    @RequestMapping("/getConsoleMenuDetailById")
    // (remark="通过菜单ID获取菜单信息，转到查看详情")
    public ModelAndView getMenuDetailById(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        ConsoleMenu menu = ConsoleMenuService.getConsoleMenuById(menuId);
        modelAndView.addObject("menu", menu);
        modelAndView.setViewName("consolemenu/console_menu_detail");
        return modelAndView;
    }

    @RequestMapping("/updateConsoleMenuById")
    @ResponseBody
    // (remark="通过菜单ID获取菜单信息")
    public int updateConsoleMenuById(HttpServletRequest request)
            throws Exception {
        int status = 0;
        long startTime = System.currentTimeMillis();
        request.setCharacterEncoding("UTF-8");
        int menuId = Integer.parseInt(request.getParameter("menuid"));
        String menuName = request.getParameter("menuname");
        String menuDesc = request.getParameter("menudesc");
        String isadminMenu = request.getParameter("isadminMenu");
        String iscanUpdate = request.getParameter("iscanUpdate");
        String ismenu = request.getParameter("ismenu");
        String buttonHtmlcontent = request.getParameter("buttonHtmlcontent");
        status = ConsoleMenuService.updateConsoleMenuById(menuId,
                menuName, menuDesc, isadminMenu, iscanUpdate, ismenu,
                buttonHtmlcontent);
        return status;
    }

    @SuppressWarnings("unchecked")
    public boolean checkUserConsole(HttpServletRequest request) {
        String servletPath = request.getServletPath();
        servletPath = servletPath.substring(1, servletPath.length());
        if (servletPath.equals("superadmin/user/getDatagrid")) {
            return true;
        }
        ConsoleMenuExample menuExample = new ConsoleMenuExample();
        menuExample.createCriteria().andMenuHrefLike("%" + servletPath + "%");
        List<ConsoleMenu> byExample = ConsoleMenuService
                .selectConsoleMenuByExample(menuExample);
        if (byExample != null && byExample.size() != 0) {
            SessionInfo sessionInfoLogin = SessionHelper
                    .getAdminSessionInfo(request);
            ConsoleUser consoleUser = sessionInfoLogin.getConsoleUser();
            HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("userId", consoleUser.getId().toString());
            hashMap.put("menuHref", "%" + servletPath + "%");
            List<ConsoleMenu> byExample1 = ConsoleMenuService
                    .getConsoleMenusByUserId(hashMap);
            if (byExample1 != null && byExample1.size() > 0) {
                Map<String, String[]> map = request.getParameterMap();
                for (int i = 0; i < byExample1.size(); i++) {
                    String menuHref = byExample.get(i).getMenuHref();
                    if (menuHref.contains("?")) {
                        menuHref = menuHref.substring(menuHref.indexOf("?"),
                                menuHref.length());
                        if (menuHref.length() > 0) {
                            String[] split = menuHref.split("&");
                            int m = 0;
                            for (int j = 0; j < split.length; j++) {
                                for (Map.Entry<String, String[]> entry : map
                                        .entrySet()) {
                                    String str = entry.getKey() + "=";
                                    String[] value = entry.getValue();
                                    for (int k = 0; k < value.length; k++) {
                                        str += entry.getValue()[k].toString();
                                    }
                                    if (str.equals(split[j])) {
                                        m++;
                                    }
                                }
                            }
                            if (m == split.length) {
                                return true;
                            }
                        }
                    }
                }
            } else {
                return false;
            }
        } else {
            return true;
        }
        return true;
    }
}
