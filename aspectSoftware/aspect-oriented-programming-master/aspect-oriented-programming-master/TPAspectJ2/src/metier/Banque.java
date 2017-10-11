package metier;

import java.util.Scanner;

public class Banque {

	public static void main(String[] args)
	{
		new Banque().init();
	}
	public void init()
	{
		try{
			Scanner clavier=new Scanner(System.in);
			System.out.println("Code : ");
			int code=clavier.nextInt();
			Compte compte=new Compte();
			compte.setCode(code);
			while(true){
				System.out.println("Montant à verser : ");
				double montant1=clavier.nextDouble();
				compte.verser(montant1);
				System.out.println("Montant à retirer : ");
				double montant2=clavier.nextDouble();
				compte.retirer(montant2);
				System.out.println(compte.toString());
				
			}
		/*Compte compte=new Compte();
		compte.setCode(1);
		compte.verser(10000);
		compte.retirer(20000);
		System.out.println(compte.toString());*/
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		}
		
	}
}
