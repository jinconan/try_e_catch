package com.team.tra_e_catch.payment;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;

public class SqlPayDao {
	Logger logger = Logger.getLogger(SqlPayDao.class);
	private SqlSessionTemplate sqlSessionTemplate = null;
	
	

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
		
		
	}
	/**
	 * 
	 * @param pMap
	 * @return
	 */
	//기안 문서 데이터 요청 DB
	public List<Map<String, Object>> getPaymentList(Map<String, Object> pMap) {
		logger.info("getPaymentList 호출");
		logger.info(pMap);
		List<Map<String,Object>> paymentList = null;
		paymentList = sqlSessionTemplate.selectList("getPaymentList",pMap);
		
		return paymentList;
	}
	//문서 번호 채번할 때
	public int getDoc() {
		int doc_no = 0;//전체 레코드 수를 담을 변수
		doc_no = sqlSessionTemplate.selectOne("getDoc");
		return doc_no;
	}
	public int getEmp() {
		int emp_no = 0;//전체 레코드 수를 담을 변수
		emp_no = sqlSessionTemplate.selectOne("getEmp");
		return emp_no;
	}
	public int epayInsert(PaymentVO pVO) {
		int result = 0;
		result = sqlSessionTemplate.insert("epayInsert", pVO);
		return result;
	}
//결제 대기 문서 
	public List<Map<String, Object>> getEpayWaitList(Map<String, Object> pMap ) {
		logger.info("Dao EpaywaitList 호출성공");
		List<Map<String,Object>> EpayWaitList = null;
		EpayWaitList = sqlSessionTemplate.selectList("getEpayWaitList", pMap);
		return EpayWaitList;
	}
	public int getTotalEpayWaitList(Map<String, Object> pMap) {
		logger.info("Dao EpaywaitList 호출성공");
		int result = 0;
		result = sqlSessionTemplate.selectOne("getTotalEpayWaitList", pMap);
		return result;
	}
	
	
	//결제 문서 폼
	public List<Map<String, Object>> getEpayform(Map<String, Object> pMap) {
		logger.info("Dao getEpayform 호출성공");
		List<Map<String,Object>> epayform = null;
		epayform = sqlSessionTemplate.selectList("getEpayform", pMap);
		return epayform;
	}
	
	
}
		
		
