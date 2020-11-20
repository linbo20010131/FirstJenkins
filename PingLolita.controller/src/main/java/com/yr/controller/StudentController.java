package com.yr.controller;

import com.yr.entity.Page;
import com.yr.entity.School;
import com.yr.entity.Student;
import com.yr.service.SchoolService;
import com.yr.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.*;


@SessionAttributes(value={"locale"})
@Controller
public class StudentController {
	
	@Autowired
	private SchoolService schoolService;
	
	@Autowired
	private StudentService studentService;
	
	@Autowired
	private ResourceBundleMessageSource messageSource;

	/**
	 * 获取所有学校
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/sch",method = RequestMethod.GET)
	public List<School> getSchoolList() {
	List<School> list = schoolService.getList();
		return list;
	}
	
	
	
	/**
	 * 返回学生列表数据
	 * @param page
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/stulist",method = RequestMethod.GET)
	public  Page<Student> query(Page<Student> page) {

		studentService.query(page);
		return page;
	}
	/**
	 * 国际化页面
	 * @param locale
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/i18n",method = RequestMethod.GET)
	public String i18n(Locale locale,Map<String,Object> map) {
		map.put("locale", locale);
		return "stulist";
	}
	/**
	 * 添加学生
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/stu",method = RequestMethod.POST)
	public Student add(@RequestParam(value = "file",required = false) MultipartFile file, Student student)throws Exception {
		Integer id =studentService.add(head(file,student));
	return studentService.getStudent(id);
	}
	

	
	/**
	 * 删除学生
	 * @param id
	 * @return 列表
	 */
	@ResponseBody
	@RequestMapping(value = "/stu/{id}",method = RequestMethod.DELETE)
	public String delete(@PathVariable("id")Integer id) {
		studentService.delete(id);
		return "删除成功";
	}
	
	
	/**
	 * 修改回显
	 * @return 修改页面
	 */
	@ResponseBody
	@RequestMapping(value = "/stu/{id}",method = RequestMethod.GET)
	public Student getStudent(@PathVariable("id")Integer id) {
		return studentService.getStudent(id);
	}
	
	/**
	 * 修改数据  返回修改后的数据到页面
	 * @param stu
	 * @return 列表
	 */
	@ResponseBody
	@RequestMapping(value = "/stu",method = RequestMethod.PUT)
	public Student update(@RequestParam(value = "file",required = false) MultipartFile file, @ModelAttribute("stu")Student stu) throws Exception{

		 studentService.updateStudent(head(file,stu));
		 //根据id返回修改后的值到页面
		return studentService.getStudent(stu.getId());
	}
	
	
	/**
	 * 修改回显修改
	 * @param
	 * @param map
	 */
	@ModelAttribute
	public void get(Student stu,Map<String,Object> map) {
		if(stu!=null && stu.getId() !=null && stu.getId() !=0) {
			map.put("stu",studentService.getStudent(stu.getId()));
		}
	}


	
	
	/**
	 * 页面性别国际化
	 * @param map
	 * @param session
	 */
	public void sex(Map<String,Object> map, HttpSession session) {
		Map<String,String> sex = new HashMap<String,String>();
		Locale locale = (Locale) session.getAttribute("locale");
		if( locale.getLanguage().equals("zh")) {
			sex.put("0", "女");
			sex.put("1", "男");
		}
		if(locale.getLanguage().equals("en")) {
			sex.put("0", "she");
			sex.put("1", "man");
		}
		map.put("sexs",sex);
	}
	/**
	 * 头像上传
	 * @param file
	 * @param stu
	 * @return
	 */
	public Student head(MultipartFile file, Student stu) throws Exception {
		//String prefix = UUID.randomUUID().toString();
	   //  prefix = prefix.replace("-","");
		if(file == null) {
			//默认头像
			if(stu.getHead() == null || stu.getHead().equals("")) {
				stu.setHead("c.jpg");
			}
			return stu;
		}
	    String fileName =file.getOriginalFilename();//使用UUID加前缀命名文件，防止名字重复被覆盖
	     // 输入流，上传文件的   
	    	 InputStream inputStream = file.getInputStream();	 	 
	 		// 输出流,保存文件的
	 		OutputStream out = new FileOutputStream(new File("E:\\use\\spring\\SpringCrud\\WebContent\\files\\"+fileName));
	 		byte b[] = new byte[1024 * 1024 * 1];
	 		int i = inputStream.read(b);
	 		while (i != -1) {
	 			out.write(b, 0, i);
	 			i = inputStream.read(b);
	 		}
	 		  out.close();
	 		  inputStream.close();
	 		  //将文件名放入head
	 		  stu.setHead(fileName);
	    
		return stu;
	}
	
	/**
	 * * 头像下载
	 * 文件下载  支持大文件下载
	 * @param session
	 * @param request
	 * @param response
	 * @param fileName
	 * @return
	 */
	@RequestMapping(value = "/download",method = RequestMethod.GET)
	public String downloadResource(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestParam("fileName")String fileName) {

		ServletContext servletContext = request.getServletContext();
		 //获取项目路径      得到文件所在位置
		String realPath ="E:\\use\\spring\\SpringCrud\\WebContent\\files\\"+fileName;
		if ( fileName !=null && !fileName.equals("")) {
			File file = new File(realPath);
			response.setContentType("application/octet-stream");
			//设置
			response.addHeader("Content-Disposition", "attachment;filename="+fileName);
			byte[] buffer = new byte[1024 * 1024 * 2];
			FileInputStream in = null;//输入流
			BufferedInputStream out = null;//输出流
			try {
				//将该文件加入到输入流之中
				in = new FileInputStream(file);
				//将输入转为输出流
				out = new BufferedInputStream(in);
				OutputStream os = response.getOutputStream();
				int i = out.read(buffer);
				while (i != -1) {
					os.write(buffer, 0, i);
					i = out.read(buffer);
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	
	/**
	 * 文件上传
	 * @param desc
	 * @param file
	 * @param session
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/FileUpload")
	public String testFileUpload(@RequestParam("desc") String desc, @RequestParam("file") MultipartFile[] file,
                                 HttpSession session) throws IOException {
		//获取ServletContext的对象 代表当前WEB应用
		ServletContext servletContext = session.getServletContext();
		 //得到文件上传目的位置的真实路径
		//String path = session.getServletContext().getRealPath("");//获取项目动态绝对路径
		for (MultipartFile multipartFile : file) {
			 String prefix = UUID.randomUUID().toString();
		     prefix = prefix.replace("-","");
		     String fileName = prefix+"_"+multipartFile.getOriginalFilename();//使用UUID加前缀命名文件，防止名字重复被覆盖
		     // 输入流，上传文件的   
		     InputStream inputStream = multipartFile.getInputStream();	 	 
		 
			// 输出流,保存文件的
			OutputStream out = new FileOutputStream(new File("E:\\use\\spring\\SpringCrud\\WebContent\\files\\"+fileName));
			
			byte b[] = new byte[1024 * 1024 * 1];
			int i = inputStream.read(b);
			while (i != -1) {
				out.write(b, 0, i);
				i = inputStream.read(b);
				if(i== -1) {
					out.close();
					 inputStream.close();
				}
			}
		}
		return "success";
	}
	

	
}
