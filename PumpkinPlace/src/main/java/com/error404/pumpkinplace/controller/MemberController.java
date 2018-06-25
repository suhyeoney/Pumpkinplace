package com.error404.pumpkinplace.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.error404.pumpkinplace.domain.Member;
import com.error404.pumpkinplace.service.MemberService;


@Controller
@RequestMapping(value = "/member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(Member member, RedirectAttributes attr) {
		logger.info("register(mem_id: {}, mem_pwd: {}, mem_email: {}, mem_tel: {})",
				member.getMem_id(), member.getMem_pwd(), member.getMem_email(), member.getMem_tel());
		int result = memberService.create(member);
		if (result == 1) { // 회원 가입 성공
			attr.addFlashAttribute("registerResult", "success");
		}
		
		return "redirect:/";
	} // end register(member)
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login(String target, Model model) {
		logger.info("login(target: {}) 호출", target);
		model.addAttribute("targetUrl", target);
	} // end login(target)
	
	
	@RequestMapping(value = "/login-post", method = RequestMethod.POST)
	public void login(Member member, Model model) {
		logger.info("login(mem_id: {}, mem_pwd: {}) 호출", member.getMem_id(), member.getMem_pwd());
		
		Member loginResult = memberService.read(member);
		
		// loginResult Null 체크 여부 확인
		// null이 아니면 session에 로그인 정보 저장,  target으로 redirect
		// -> 컨트롤러에서 직접 담당하지 않고, LoginInterceptor에서 담당.
		model.addAttribute("loginResult", loginResult);
		
	} // end login(member)
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		logger.info("logout() 호출");
		
		session.removeAttribute("loginId");
		
		// 해당 문장은 꼭 사용해야 로그아웃이 가능함
		session.invalidate();
		
		return "redirect:/member/login";
	} // end logout()

	
} // end class MemberController