package com.rbac.console.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.rbac.console.dao.ConsoleUserMapper;
import com.rbac.console.entity.*;
import com.rbac.console.service.ConsoleUserRoleService;
import com.rbac.console.service.ConsoleUserService;
import com.rbac.console.service.ConsoleRoleService;
import com.rbac.console.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/superadmin/ConsoleUser")
public class ConsoleUserController {
    @Autowired
    private ConsoleUserRoleService CosoleUserRoleService;
    @Autowired
    private ConsoleRoleService ConsoleRoleService;
    @Autowired
    private ConsoleUserService consoleUserService;
    @Autowired
    private ConsoleUserMapper ConsoleUserdao;
    @RequestMapping("/getAllConsoleUser")
    // 查找用户
    public ModelAndView getAllConsoleUser(HttpServletRequest request)throws ParseException {
        int pageNum = 1;
        if (!StringUtils.isNull(request.getParameter("pageNum"))) {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }
        int index = 0;
        if (!StringUtils.isNull(request.getParameter("index"))) {
            index = Integer.parseInt(request.getParameter("class"));
        }
        int pageSize = 10;
        if (!StringUtils.isNull(request.getParameter("pageSize"))) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }
        String searchWord = request.getParameter("searchWord");
        String searchType = request.getParameter("searchType");
        String userState = "2";
        if ("0".equals(request.getParameter("userState"))
                || "1".equals(request.getParameter("userState"))) {
            userState = request.getParameter("userState");
        }
        String order = "id desc";
        ModelAndView modelAndView = new ModelAndView();
        if (userState.equals("0")) {
            modelAndView.setViewName("consoleuser/console_user_stopuse");
        } else {
            modelAndView.setViewName("consoleuser/console_user_list");
        }
        // 处理底部分页显示
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("searchWord", searchWord);
        if("username".equals(searchType)){
            params.put("searchType", "1");
        }else if("usertruename".equals(searchType)){
            params.put("searchType", "0");
        }else{
            params.put("searchType", "2");
        }
        params.put("userState", userState);
        PageResultAll<ConsoleUser> pageConsoleUser = consoleUserService.getAllConsoleUsers(pageNum, pageSize, order, params);
        List<ConsoleUser> ConsoleUserList = pageConsoleUser.getResult();
        for(int i=0;i<ConsoleUserList.size();i++){
            String roleList = "";
            List<ConsoleUserRole> ConsoleUserRoleList = CosoleUserRoleService.getConsoleUserRoleByUserId(ConsoleUserList.get(i).getId());
            for(int y=0;y<ConsoleUserRoleList.size();y++){
                roleList += ConsoleUserRoleList.get(y).getRoleName();
                if(y != (ConsoleUserRoleList.size()-1)){
                    roleList +=  ",";
                }
            }
            if(roleList != ""){
                ConsoleUserList.get(i).setUserParm2(roleList);
            }
        }
        int pageCount = 0;// 总页数
        Long pageTotal = pageConsoleUser.getTotal();
        if (pageTotal / pageSize == 0) {
            pageCount = (int) (pageTotal / pageSize);
        } else {
            pageCount = (int) (pageTotal / pageSize) + 1;
        }
        modelAndView.addObject("userList", ConsoleUserList);
        modelAndView.addObject("pageNum", pageNum);// 当前页
        modelAndView.addObject("pageCount", pageCount);// 总页数
        modelAndView.addObject("pageTotal", pageTotal);// 总条数
        modelAndView.addObject("pageSize", pageSize);// 每页的条数
        modelAndView.addObject("searchWord", searchWord);
        modelAndView.addObject("searchType", searchType);
        modelAndView.addObject("userState", userState);
        return modelAndView;
    }
    @RequestMapping("/getConsoleUserById")
    // 通过id查找用户
    public ModelAndView getConsoleUserById(HttpServletRequest request) {
        int userId = Integer.parseInt(request.getParameter("userId"));
        ConsoleUser user = consoleUserService.getUserById(userId);
        List<ConsoleUserRole> list = CosoleUserRoleService.getConsoleUserRoleByUserId(userId);
        int[] userRole = new int[list.size()];
        for (int i = 0; i < list.size(); i++) {
            userRole[i] = list.get(i).getRoleId();
        }
        ConsoleRoleExample example = new ConsoleRoleExample();
        example.createCriteria();
        List<ConsoleRole> roleList = ConsoleRoleService.getAllConsoleRole(example);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("consoleuser/console_user_detail");
        if (list.size() > 0) {
            modelAndView.addObject("userRole", userRole);
        }
        modelAndView.addObject("roleList", roleList);
        modelAndView.addObject("user", user);
        return modelAndView;
    }

    @RequestMapping("/getEditConsoleUserById")
    // 通过id修改用户
    public ModelAndView editConsoleUserById(HttpServletRequest request) {
        int userId = Integer.parseInt(request.getParameter("userId"));
        ConsoleUser user = consoleUserService.getUserById(userId);
        List<ConsoleUserRole> list = CosoleUserRoleService
                .getConsoleUserRoleByUserId(userId);
        int[] userRole = new int[list.size()];
        for (int i = 0; i < list.size(); i++) {
            userRole[i] = list.get(i).getRoleId();
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("consoleuser/console_user_edit");

        ConsoleRoleExample example = new ConsoleRoleExample();
        example.createCriteria();
        List<ConsoleRole> roleList = ConsoleRoleService.getAllConsoleRole(example);
        modelAndView.addObject("roleList", roleList);
        if (list.size() > 0) {
            modelAndView.addObject("userRole", userRole);
        }
        modelAndView.addObject("user", user);
        return modelAndView;
    }

    // 修改用户信息
    @RequestMapping("/updateConsoleUserById")
    @ResponseBody
    public int updateConsoleUserById(HttpServletRequest request)
            throws Exception {
        long startTime = System.currentTimeMillis();
        request.setCharacterEncoding("UTF-8");
        int status = 0;
        int id = Integer.parseInt(request.getParameter("userid"));
        String userRoleId = request.getParameter("roleIds");
        int result = 0;
        if (userRoleId.length() > 0) {
            result = CosoleUserRoleService.updateConsoleUserRole(id,
                    userRoleId);
        }
        String trueName = request.getParameter("trueName");
        String telephone = request.getParameter("telephone");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        int userStatus = Integer.parseInt(request.getParameter("userStatus"));
        ConsoleUser ConsoleUser = new ConsoleUser();
        ConsoleUser.setId(id);
        ConsoleUser.setTruename(trueName);
        ConsoleUser.setMobile(mobile);
        ConsoleUser.setTelephone(telephone);
        ConsoleUser.setUserStatus(userStatus);
        ConsoleUser.setUserEmail(email);
        status = consoleUserService.updateCosoleUserByConsoleUser(ConsoleUser);
        boolean flag = false; // define opear result
        int al = 0;
        if (userRoleId.length() > 0 && status == 1 && result == 1) {
            al = 1;
            flag = true;
        } else if (userRoleId.length() <= 0 && status == 1) {
            al = 1;
            flag = true;
        } else {
            al = 0;
        }
        return al;

    }

    // 处理添加用户请求
    @RequestMapping("/toAddConsoleUser")
    public ModelAndView toAddConsoleUser() {
        ConsoleRoleExample example = new ConsoleRoleExample();
        example.createCriteria();
        List<ConsoleRole> list = ConsoleRoleService.getAllConsoleRole(example);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("roleList", list);
        modelAndView.setViewName("consoleuser/console_user_add");
        return modelAndView;
    }

    @RequestMapping("/addConsoleUser")
    @ResponseBody
    // 添加用户
    public int addConsoleUser(HttpServletRequest request) throws Exception {
        long startTime = System.currentTimeMillis();
        request.setCharacterEncoding("UTF-8");
        String username = "";
        username = request.getParameter("userName");// 用户名称
        String passWord = PasswordUtil.encrypt("123456");
        String mobile = request.getParameter("mobil");
        String userEmail = request.getParameter("userEmail");
        String userSex = request.getParameter("userSex");
        String trueName = request.getParameter("trueName");
        String userTel = request.getParameter("userTel");
        // 绑定的角色id数组
        String roleIds = request.getParameter("roleIds");
        ConsoleUserExample ConsoleUserExample = new ConsoleUserExample();
        ConsoleUserExample.createCriteria().andUsernameEqualTo(username);
        List<ConsoleUser> example = ConsoleUserdao
                .selectByExample(ConsoleUserExample);
        if (example != null && example.size() > 0) {
            return -1;// 用户已存在
        }
        ConsoleUser ConsoleUser = new ConsoleUser();
        ConsoleUser.setUsername(username);
        ConsoleUser.setPassword(passWord);
        ConsoleUser.setMobile(mobile);
        ConsoleUser.setTelephone(userTel);
        ConsoleUser.setUserStatus(1);
        ConsoleUser.setUserCreattime(new Date());
        ConsoleUser.setUserSex(userSex);
        ConsoleUser.setTruename(trueName);
        ConsoleUser.setUserEmail(userEmail);
        int insert = ConsoleUserdao.insert(ConsoleUser);
        // 创建新用户完成
        // 查看userid，
        ConsoleUserExample exam = new ConsoleUserExample();
        exam.createCriteria().andUsernameEqualTo(username);
        List<ConsoleUser> list = ConsoleUserdao.selectByExample(exam);
        int userId = list.get(0).getId();
        int result = CosoleUserRoleService.addConsoleUserRole(userId,roleIds);
        boolean flag = false; // define opear result

        if (1 == insert && 1 == result) {
            return 1;
        } else {
            return 0;
        }
    }

    @RequestMapping("/updatePwdByUserIds")
    @ResponseBody
    // 批量修改密码
    public int updatePwdByUserIds(HttpServletRequest request) throws Exception {
        long startTime = System.currentTimeMillis();
        int nRows = 0;
        String _sUserIds = request.getParameter("userIds");
        String passWord = request.getParameter("passWord");
        nRows = consoleUserService.updatePwdByUserIds(_sUserIds, passWord);
        boolean flag = false; // define opear result
        if (nRows != 0)
            flag = true;
        return nRows;
    }

    // 批量修改状态
    @RequestMapping("/updateConsoleUserStatusByUserids")
    @ResponseBody
    public int updateConsoleUserStatusByuserids(HttpServletRequest request) {
        long startTime = System.currentTimeMillis();
        int nRows = 0;
        String _sUserIds = request.getParameter("userIds");
        // String type=request.getParameter("type");
        if (!StringUtils.isNull(_sUserIds)) {
            nRows = consoleUserService.updateConsoleUserStatusByUserId(_sUserIds);
            boolean flag = false; // define opear result
            if (nRows != 0)
                flag = true;
        }
        return nRows;
    }

    // 打开修改密码界面
    @RequestMapping("/getConsoleUserByIds")
    // (remark="批量得到用户主键")
    public ModelAndView getConsoleUserByIds(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        String userIds = request.getParameter("userIds");
        modelAndView.addObject("userIds", userIds);
        modelAndView.setViewName("consoleuser/console_user_pwd_edit");
        return modelAndView;
    }

    @SuppressWarnings("unused")
    @RequestMapping("/deleteConsoleUserByUserids")
    @ResponseBody
    public int deleteConsoleUserByUserids(HttpServletRequest request) {
        long startTime = System.currentTimeMillis();
        int nRows = 0;
        String _sUserIds = request.getParameter("userIds");
        String type = request.getParameter("type");
        if (!StringUtils.isNull(_sUserIds)) {
            nRows = consoleUserService.deleteConsoleUserUserIds(_sUserIds);
            boolean flag = false; // define opear result
            if (nRows != 0)
                flag = true;
        }

        return nRows;
    }

    // 批量修改状态
    @RequestMapping("/startConsoleUserStatusByUserids")
    @ResponseBody
    public int startConsoleUserStatusByuserids(HttpServletRequest request) {
        long startTime = System.currentTimeMillis();
        int nRows = 0;
        String _sUserIds = request.getParameter("userIds");
        // String type=request.getParameter("type");
        if (!StringUtils.isNull(_sUserIds)) {
            nRows = consoleUserService.startConsoleUserUserIds(_sUserIds);
        }
        boolean flag = false; // define opear result
        if (nRows != 0)
            flag = true;
        return nRows;
    }

    @RequestMapping(value = "/getDatagrid", method = RequestMethod.GET)
    // (remark="GET请求URL跳转")
    public String getDatagrid(HttpServletRequest request) {
        String url = request.getParameter("url");
        return "" + url;
    }

    @RequestMapping("/toUpdatePassWord")
    public ModelAndView toUpdatePassWord(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("updatePassWord/inputOldPassWord");
        return modelAndView;
    }
    @RequestMapping("/toInputNewPassWord")
    public ModelAndView toInputNewPassWord(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("updatePassWord/inputNewPassWord");
        return modelAndView;
    }
    @RequestMapping("/checkOldPassWord")
    @ResponseBody
    public int checkOldPassWord(HttpServletRequest request) {
        String oldPassWord = request.getParameter("oldPassWord");
        SessionInfo sessionInfo = SessionHelper
                .getAdminSessionInfo(request);
        int result = 1;
        if(!oldPassWord.equals(sessionInfo.getConsoleUser().getPassword())){//输入密码错误
            result = -1;
        }
        return result;
    }
    @RequestMapping("/updatePassWord")
    @ResponseBody
    public int updatePassWord(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("UTF-8");
        long startTime = System.currentTimeMillis();
        boolean flag = false;
        SessionInfo sessionInfo = SessionHelper.getAdminSessionInfo(request);
        String _oldPassword = sessionInfo.getConsoleUser().getPassword();//用户旧密码
        String username = sessionInfo.getConsoleUser().getUsername();//用户名
        ConsoleUser userinfo=consoleUserService.getUserById(sessionInfo.getConsoleUser().getId());
        int ret = 0;
        String oldPasswordEn = "";
        String newPasswordEn = "";
        String aginNewPasswordEn = "";
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String aginNewPassword = request.getParameter("aginNewPassword");
        try {
            oldPasswordEn = oldPassword;
            newPasswordEn = newPassword;
            aginNewPasswordEn = aginNewPassword;
        } catch (Exception e) {
            ret = -3;
        }
        if(oldPassword.length()>16||oldPassword.length()<8||newPassword.length()>16||aginNewPassword.length()>16||newPassword.length()<8||aginNewPassword.length()<8){
            ret = -6;
        }
        if(!_oldPassword.equals(oldPasswordEn)){//旧密码输入错误
            ret = -1;
        }
        if(!newPasswordEn.equals(aginNewPasswordEn)){//两次输入的密码不同
            ret = -2;
        }
        if(_oldPassword.equals(newPasswordEn)||_oldPassword.equals(aginNewPasswordEn)){
            ret = -4;
        }
        if(username.equals(newPassword)||username.equals(aginNewPassword)){
            ret = -5;
        }
        if(ret == 0){
            userinfo.setPassword(newPasswordEn);
            flag = consoleUserService.updateCosoleUserByConsoleUser(userinfo)>0?true:false;
            if(flag){
                ret = 1;
            }else{
                ret = 0;
            }
        }
        long endTime = System.currentTimeMillis();
        return ret;
    }
    @RequestMapping("/adminUserInfo")
    public ModelAndView adminUserInfo(HttpServletRequest request){
        SessionInfo sessionInfo = SessionHelper.getAdminSessionInfo(request);
        ModelAndView modelAndView = new ModelAndView();
        ConsoleUser user = consoleUserService.getUserById(sessionInfo.getConsoleUser().getId());
        modelAndView.addObject("user", user);
        modelAndView.setViewName("consoleuser/admin_user_info");
        return modelAndView;
    }
}
