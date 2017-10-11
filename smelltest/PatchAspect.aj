package aspects;


import metier.Compte;

public aspect PatchAspect {
pointcut patch(double montant):call(* metier..Compte.retirer(..)) && args(montant);

void around(double montant):patch(montant){
	Compte compte=(Compte)thisJoinPoint.getTarget();
	//pr récuperer les argument autre maniere
	//thisJoinPoint.getArgs();
	if(montant<compte.getSolde())
		proceed(montant);
	else 
		throw new RuntimeException("Solde Insuffisant Montant="+montant+" alors que Solde ="+compte.getSolde());
}
}
