package kh.spring.ao;

import java.util.Arrays;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class PerfCheckAdvice {

	@Autowired
	public HttpSession session;
	@Pointcut("execution(* kh.spring.practice.HomeController.myPage*(..))")
	public void mypageAll() {};
	@Pointcut("execution(* kh.spring.practice.HomeController.modify*(..))")
	public void modifyAll() {};
	
	@Around("mypageAll() || modifyAll()")
	public Object perfCheck(ProceedingJoinPoint pjp) {
		//before
		long startTime = System.currentTimeMillis();
		Object retVal = null;
		Signature sign = pjp.getSignature();
		if(session.getAttribute("loginID")==null) {
			return "home";
		}
		try {
			retVal=pjp.proceed();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		//after
		System.out.println(sign.getName()+" 배열값 : "+Arrays.toString(pjp.getArgs()));
		//if(sign.getName().equals("login"))
		long endTime = System.currentTimeMillis();
		System.out.println(sign.getName()+" : "+(endTime-startTime)/1000.0 + "초 간 수행");
		return retVal;
	}
}
