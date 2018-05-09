package com.jeewx.plugin.demo;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.velocity.VelocityContext;
import org.jeecgframework.p3.core.util.plugin.ViewFreemarker;
import org.jeecgframework.p3.core.util.plugin.ViewVelocity;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**   
 * @Title: 插件式Controller
 * @author 张代浩
 * @date 2013-01-23 17:12:40
 * @version V1.0   
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/jpDemoController")
public class JpDemoController  {

	
	/**
	 * popup 例子
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "goHello")
	public void goHello(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Map<String,Object> mp = new HashMap<String,Object>();
		mp.put("name", "张代浩");
		ViewFreemarker.view(response,"demo/hello.ftl",mp);
	}
	
	/**
	 * popup 例子
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "goHello2")
	public void goHello2(HttpServletRequest request,HttpServletResponse response) throws Exception {
		VelocityContext velocityContext = new VelocityContext();
		velocityContext.put("name", "张代浩");
		ViewVelocity.view(response,"demo/hello2.vm",velocityContext);
	}
}
