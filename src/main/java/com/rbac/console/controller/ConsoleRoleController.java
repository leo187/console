package com.rbac.console.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.rbac.console.dao.ConsoleRoleMapper;
import com.rbac.console.entity.ConsoleRole;
import com.rbac.console.entity.ConsoleRoleExample;
import com.rbac.console.util.PageResultAll;
import com.rbac.console.util.SessionHelper;
import com.rbac.console.util.SessionInfo;
import com.rbac.console.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.rbac.console.service.ConsoleRoleService;
@Controller
@RequestMapping("/superadmin/ConsoleRole")
public class ConsoleRoleController {
    @Autowired
    private ConsoleRoleService consoleRoleService;
    @Autowired
    private ConsoleRoleMapper consoleRoleMapper;
    @RequestMapping("/getConsoleRoles")
    public ModelAndView getConsoleRoles(HttpServletRequest request)
            throws ParseException {
        int pageNum = 1;
        if (!StringUtils.isNull(request.getParameter("pageNum"))) {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }
        int pageSize = 10;
        if (!StringUtils.isNull(request.getParameter("pageSize"))) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }
        String roleName = null;
        if (StringUtils.isNull(request.getParameter("type"))) {
            roleName = request.getParameter("roleName");
        }
        String order = "ID  DESC";
        ModelAndView modelAndView = new ModelAndView();
        PageResultAll<ConsoleRole> pageRole = consoleRoleService
                .getConsoleRoles(pageNum, pageSize, order, roleName);
        Long pageTotal = pageRole.getTotal();
        modelAndView.addObject("roleName", roleName);
        modelAndView.addObject("roleList", pageRole.getResult());
        modelAndView.addObject("pageNum", pageNum);// 当前页
        modelAndView.addObject("pageTotal", pageTotal);// 总条数
        modelAndView.addObject("pageSize", pageSize);// 每页的条数
        modelAndView.setViewName("consolerole/console_role_list");
        return modelAndView;
    }

    @RequestMapping("/addConsoleRole")
    @ResponseBody
    // (remark="添加角色")
    public int addConsoleRole(HttpServletRequest request) throws Exception {
        long startTime = System.currentTimeMillis();
        request.setCharacterEncoding("UTF-8");
        String rolename = request.getParameter("rolename");
        String roledesc = request.getParameter("roledesc");
        Date now = new Date();
        ConsoleRoleExample ConsoleRoleExample = new ConsoleRoleExample();
        ConsoleRoleExample.createCriteria().andRolenameEqualTo(rolename);
        List<ConsoleRole> example = consoleRoleMapper
                .selectByExample(ConsoleRoleExample);
        if (example != null && example.size() > 0) {
            return -1;// 用户已存在
        }
        SessionInfo sessionInfo = SessionHelper.getAdminSessionInfo(request);
        ConsoleRole Role = new ConsoleRole();
        Role.setRolename(rolename);
        Role.setRoledesc(roledesc);
        Role.setCreateTime(now);
        return consoleRoleService.addConsoleRole(Role);
    }

    @RequestMapping("/deleteConsoleRoles")
    @ResponseBody
    // (remark="删除角色")
    public int deleteRoles(HttpServletRequest request) {
        String _sRoleIds = request.getParameter("roleIds");
        return consoleRoleService.deleteConsoleRoles(_sRoleIds);
    }

    @RequestMapping("/getConsoleRoleById")
    // (remark="通过ID获取角色信息")
    public ModelAndView getRoleById(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        ConsoleRole role = consoleRoleService
                .getConsoleRoleById(roleId);
        modelAndView.addObject("role", role);
        modelAndView.setViewName("consolerole/console_role_edit");
        return modelAndView;

    }

    @RequestMapping("/updateConsoleRoleById")
    @ResponseBody
    // (remark="通过角色ID修改角色")
    public int updateRoleById(HttpServletRequest request) throws Exception {
        long startTime = System.currentTimeMillis();
        request.setCharacterEncoding("UTF-8");
        int roleId = Integer.parseInt(request.getParameter("roleid"));
        String roleName = request.getParameter("rolename");
        String roleDesc = request.getParameter("roledesc");
        ConsoleRoleExample ConsoleRoleExample = new ConsoleRoleExample();
        ConsoleRoleExample.createCriteria().andRolenameEqualTo(roleName).
                andIdNotEqualTo(Integer.parseInt(request.getParameter("roleid")));
        List<ConsoleRole> example = consoleRoleMapper.selectByExample(ConsoleRoleExample);
        if (example != null && example.size() > 0) {
            return -1;// 用户已存在
        }
        return consoleRoleService.updateConsoleRoleByRoleId(roleId,
                roleName, roleDesc);
    }

}
