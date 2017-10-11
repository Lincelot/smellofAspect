package aspects;

import java.util.logging.Logger;

//aspect to calculate the time of execution of a method
public aspect LoggerAspect {
	private long time1, time2;
	private Logger logger = Logger.getLogger(this.getClass().getName());

	//pointcut log():call(* metier.Compte.*(..));
	//pointcut log():initialization(*.Compte.new(..));
	//combiner les deux
	pointcut log():call(* aaametier..Compte.*(..))||initialization(*.Compte.new(..));
	before():log(){
		System.out.println("*************************");
		logger.info("Avant éxecution de la methode : "
				+thisJoinPoint.getSignature());
		time1 = System.currentTimeMillis();
	}

	after():log(){
		logger.info("Après éxecution de la methode : "
				+thisJoinPoint.getSignature());
		time2 = System.currentTimeMillis();
		logger.info("Durée = "+(time2-time1));
		System.out.println("*************************");
	}
}
