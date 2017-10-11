package aspects;

import java.util.logging.Logger;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

//aspect to calculate the time of execution of a method
 @Aspect
public aspect LoggerAspectWithAnnotation {
	private long time1, time2;
	private Logger logger = Logger.getLogger(this.getClass().getName());

	//pointcut log():call(* metier.Compte.*(..));
	//pointcut log():initialization(*.Compte.new(..));
	//combiner les deux
	@Pointcut("call(* aaametier..Compte.*(..))||initialization(*.Compte.new(..))")
	public void log(){}
	@Before("log()")
	public void avant(JoinPoint thisJoinPoint){
		System.out.println("*************************");
		logger.info("Avant éxecution de la methode : "
				+thisJoinPoint.getSignature());
		time1 = System.currentTimeMillis();
	}

	@After("log()")
		public void apres(JoinPoint thisJoinPoint){
		logger.info("Après éxecution de la methode : "
				+thisJoinPoint.getSignature());
		time2 = System.currentTimeMillis();
		logger.info("Durée = "+(time2-time1));
		System.out.println("*************************");
	}
}
