package com.jeecg.p3.system.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.velocity.VelocityContext;
import org.jeecgframework.p3.core.common.utils.StringUtil;
import org.jeecgframework.p3.core.logger.Logger;
import org.jeecgframework.p3.core.logger.LoggerFactory;
import org.jeecgframework.p3.core.util.plugin.ViewVelocity;
import org.jeecgframework.p3.core.web.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
/**
 * 后台系统接入认证
 */
@Controller
@RequestMapping("/system")
public class loginController extends BaseController{
	
	  public final static Logger LOG = LoggerFactory.getLogger(loginController.class);
	  /**
	   * 后台接入没有权限
	   */
	 @RequestMapping(value = "/noAuth",method ={RequestMethod.GET, RequestMethod.POST})
	 public ModelAndView noAuth(HttpServletRequest request,HttpServletResponse response){
		 String viewName = "error";
		 ModelAndView mv = new ModelAndView();
		 mv.setViewName(viewName);
		 return mv;
	 }
	  
	 /**
	   * 调整到登录页面
	   */
	 @RequestMapping(value = "/toLogin",method ={RequestMethod.GET, RequestMethod.POST})
	 public ModelAndView toLogin(HttpServletRequest request,HttpServletResponse response){
		 String viewName = "system/login";
		 ModelAndView mv = new ModelAndView();
		 mv.setViewName(viewName);
		 return mv;
	 }
	 
	 /**
	   * 登录
	   */
	 @RequestMapping(value = "/login",method ={RequestMethod.GET, RequestMethod.POST})
	 public ModelAndView login(String jwid,HttpServletRequest request,HttpServletResponse response){
		 String viewName = "base/back/main/index.vm";
		 ModelAndView mv = new ModelAndView();
		 if(StringUtil.isEmpty(jwid)){
			 viewName = "system/login";
		 }else{
			 request.getSession().setAttribute("jwid", jwid);
			 mv.setViewName(viewName);
			 VelocityContext velocityContext = new VelocityContext();
			 try {
				ViewVelocity.view(response,viewName,velocityContext);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		 }
		 mv.setViewName(viewName);
		 return mv;
	 }
	 
	 /**
	   * 退出
	   */
	 @RequestMapping(value = "/logout",method ={RequestMethod.GET, RequestMethod.POST})
	 public ModelAndView logout(String jwid,HttpServletRequest request,HttpServletResponse response){
		 String viewName = "system/login";
		 ModelAndView mv = new ModelAndView();
	     request.getSession().removeAttribute("jwid");
		 mv.setViewName(viewName);
		 return mv;
	 }
}

