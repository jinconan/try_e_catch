package com.team.tra_e_catch.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.team.tra_e_catch.payment.PaymentLogic;
import com.team.tra_e_catch.payment.PaymentVO;

@Controller
@RequestMapping(value = "/pay")
public class PaymentController {
	
	@Autowired
	private PaymentLogic paymentLogic = null;

	private static final Logger logger = Logger.getLogger(PaymentController.class);
	private final ApplicationContext context = new ClassPathXmlApplicationContext("submenu/payment-submenu.xml");


	// 기안문서테이블URL(JSON)
	/*@RequestMapping("/epay/epayjson")
	public String getPaymentList(Model mod, @RequestParam Map<String, Object> pMap, HttpServletResponse res) {
		logger.info("getPaymentList 호출");
		List<Map<String, Object>> paymentList = null;
		paymentList = paymentLogic.getPaymentList(pMap, res);
		mod.addAttribute("getPaymentList", paymentList);
		return "pay/epay/epayjson";

	}*/
	
	@RequestMapping("epayInsert")
	public String epayInsert(@ModelAttribute PaymentVO pVO)
	{	
		//DB 연동 처리
		int result = 0;
		pVO.setEmp_no(pVO.getEmp_no());
		pVO.setDtype_no(pVO.getDtype_no());
		pVO.setPath(pVO.getPath());
		pVO.setContent(pVO.getContent());
		pVO.setDoc_no(pVO.getDoc_no());
		pVO.setUp_date(pVO.getUp_date());
		result = paymentLogic.epayInsert(pVO);
		return "pay/epay/draft";
	}

	//////////////////////////// 기안 ///////////////////////////////
	// 기안 문서 작성
	@RequestMapping(value = "/epay", method = RequestMethod.GET)
	public String epay(Model mod) {
		logger.info("epayview 호출");
		List<Map<String, Object>> subMenuList = (List<Map<String, Object>>) context.getBean("pay-draft-submenu");
		mod.addAttribute("curSubMenu", "기안문서 작성");
		mod.addAttribute("subMenuList", subMenuList);
		return "pay/epay/epayview";
	}
	
	

	// 작업지시서 페이지
	@RequestMapping(value = "/epay/jobInst", method = RequestMethod.GET)
	public String jobtable(@RequestParam Map<String, Object> pMap,Model mod) {
		logger.info("jobtable호출");
		System.out.println(pMap);
		// 컨트롤러로 부터 넘겨받는 속성
		// subMenuList : List<Map<String, Object>>
		// [{key : value}] = [{"sm_name" : "서브메뉴이름"}, {"sm_url" : "링크경로"}]
		// curSubMenu : String
		/*List<Map<String,Object>> jobinsert = null;
		jobinsert = paymentLogic.setJobInsert(pMap);*/
		return "pay/epay/jobInst";

	}
	// 작업지시서 입력
	/*@RequestMapping(value = "/jobInst/insert", method = RequestMethod.GET)
	public String jobInsert(@RequestParam Map<String, Object> pMap) 
	{	
		logger.info("jobInsert호출");
		System.out.println(pMap);
		List<Map<String,Object>> jobinsert = null;
		jobinsert = paymentLogic.setJobInsert(pMap);
		
		return "pay/epay";
	}*/
	//휴가 페이지
	@RequestMapping(value = "/epay/restForm", method = RequestMethod.POST) 
		public String restcert(@RequestParam Map<String, Object> pMap, Model mod) {
			// 컨트롤러로 부터 넘겨받는 속성
			// subMenuList : List<Map<String, Object>>
			// [{key : value}] = [{"sm_name" : "서브메뉴이름"}, {"sm_url" : "링크경로"}]
			// curSubMenu : String
			List<Map<String, Object>> subMenuList = (List<Map<String, Object>>) context.getBean("pay-draft-submenu");
			mod.addAttribute("curSubMenu", "기안문서 작성");
			mod.addAttribute("subMenuList", subMenuList);
			/*List<Map<String, Object>> restinsert = null;
			System.out.println(pMap);
			restinsert = paymentLogic.restInsert(pMap);*/
			logger.info("restForm호출");
			return "pay/epay/restForm";
	}

	// 기안 문서
	@RequestMapping(value = "/epay/draft/{counts}", method = RequestMethod.GET)
	public String draft(@RequestParam Map<String,Object> pMap, Model mod, @PathVariable int counts) {
		logger.info("draft 호출");
		List<Map<String, Object>> subMenuList = (List<Map<String, Object>>) context.getBean("pay-draft-submenu");
		mod.addAttribute("curSubMenu", "기안 목록");
		mod.addAttribute("subMenuList", subMenuList);
		return "pay/epay/draft";
	}

	// 부결기안
	@RequestMapping(value = "/epay/backdraft", method = RequestMethod.GET)
	public String backdrift(Model mod) {
		logger.info("Welcome home! The client locale is");
		List<Map<String, Object>> subMenuList = (List<Map<String, Object>>) context.getBean("pay-draft-submenu");
		mod.addAttribute("curSubMenu", "부결 기안");
		mod.addAttribute("subMenuList", subMenuList);
		return "pay/epay/backdraft";
	}

	//////////////////////////// 결재 //////////////////////////////////
	// 결재 대기 문서
	@RequestMapping(value = "/epay/epaywait", method = RequestMethod.GET)
	public String epaywait(@RequestParam Map<String, Object> pMap, Model mod, HttpSession session) {
		logger.info("epaywait");
		List<Map<String, Object>> subMenuList = (List<Map<String, Object>>) context.getBean("pay-submenu");
		mod.addAttribute("curSubMenu", "결재 대기 문서");
		mod.addAttribute("subMenuList", subMenuList);
		List<Map<String,Object>> epaywaitList = null;
		pMap.put("emp_no", session.getAttribute("emp_no"));
		System.out.println("epaywaitList에 들어가는 : " +pMap);
		
		epaywaitList = paymentLogic.getEpayWaitList(pMap);
		logger.info("epaywaitList :"+epaywaitList);
		mod.addAttribute("epaywaitList", epaywaitList);
		return "pay/epay/epaywait";
	}

	// 결재 완료 문서
	@RequestMapping(value = "/epay/epayend", method = RequestMethod.GET)
	public String epayend(@RequestParam Map<String, Object> pMap,Model mod) {
		logger.info("Welcome home! The client locale is");
		List<Map<String, Object>> subMenuList = (List<Map<String, Object>>) context.getBean("pay-submenu");
		mod.addAttribute("curSubMenu", "결재 완료 문서");
		mod.addAttribute("subMenuList", subMenuList);
		
		return "pay/epay/epayend";
	}

}
