package aspects;

import java.util.Scanner;

public aspect SecurityAspect {
	private String login;
	private String password;
pointcut security():call(metier.Banque.new(..));

Object around():security(){
	if(login==null){
		Scanner clavier=new Scanner(System.in);
		System.out.println("login = ");
		login=clavier.next();
		System.out.println("password = ");
		password=clavier.next();
		
		if(login.equals("root") && password.equals("root")){
			return proceed();
		}
		else{
			throw new RuntimeException("Access denied");
		
		}
		
	}
	return null;
}
}
