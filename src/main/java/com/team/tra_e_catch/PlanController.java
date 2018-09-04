package com.team.tra_e_catch;

import java.util.Locale;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value="/plan")
public class PlanController {
	
	private static final Logger logger = Logger.getLogger(PlanController.class);

	@RequestMapping(value="/prop/view/propList/{pageNumber}")
	public String viewPropList(@PathVariable int  pageNumber) {
		logger.info("viewPropList(pageNumber="+pageNumber+")");
		return "plan/prop/propList";
	}
	
	@RequestMapping(value="/prop/view/insertProp")
	public String viewInsertProp(@RequestParam Map<String,Object> pMap) {
		logger.info("viewInsertProp()");
		logger.info("parameter : " + pMap);
		return "plan/prop/insertProp";
	}
}
