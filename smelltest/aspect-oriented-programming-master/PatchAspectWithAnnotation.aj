package aspects;

import javax.management.RuntimeErrorException;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

import metier.Compte;
@Aspect
public aspect PatchAspectWithAnnotation {

	@Around("call(* aaametier..Compte.retirer(..)) && args(montant)")
	public void patch(double montant,JoinPoint thisJoinPoint,ProceedingJoinPoint pjp/*to use proceed*/){
		System.out.println("ppoo");
		Compte compte=(Compte)thisJoinPoint.getTarget();
		System.out.println(compte+"oo");

	//pr récuperer les argument autre maniere
	//thisJoinPoint.getArgs();
	if(montant<compte.getSolde())
	{	try {
			pjp.proceed(new Object[]{montant});
		} catch (Throwable e) {
			e.printStackTrace();
		}
	}
	else 
		throw new RuntimeException("Solde Insuffisant Montant="+montant+" alors que Solde ="+compte.getSolde());
}
	
}
