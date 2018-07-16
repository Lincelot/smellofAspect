package aspects;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class FirstAspectWithAnnotation {
	@Pointcut("execution(* *..App.main(..))")
	public void testMain(){
		
	}
	@Before("testMain()")
	public void avant(){
	System.out.println("----Aspect Annotation----");	
	System.out.println("Before Main method");	
	}
	@After("testMain()")
	public void apres(){
	System.out.println("----Aspect Annotation----");	
	System.out.println("Before Main method");	
	}

}
