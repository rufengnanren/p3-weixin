import org.jeecgframework.p3.core.GeneratorFactory;


/**
 * 
 * @author jeecg
 * @email jeecg@sina.com
 */
public class GeneratorMain {
	
	/**
	 * 请修改{项目名}，执行项目生成
	 */
	public static void main(String[] args) throws Exception {
		//项目名
		String projectName = "Gogo";//项目名称 ：P3-Biz-{自定义模块名}
		GeneratorFactory.doMake(projectName);
	}
}
