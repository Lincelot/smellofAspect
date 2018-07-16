package aspects;

public aspect FirstAspect {
	pointcut testMain():execution(* *..App.main(..));
	before():testMain(){
	System.out.println("----Aspect----");	
	System.out.println("Before Main method");	
	}
	after():testMain(){
		System.out.println("----Aspect----");	
		System.out.println("After Main method");	
		}

}
