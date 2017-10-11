package metier;

public class Compte {
 private int code;
 private double solde;
 
 public Compte() {
	super();
	// TODO Auto-generated constructor stub
}
 
public Compte(int code, double solde) {
	super();
	this.code = code;
	this.solde = solde;
}

public void verser(double montant){
	 solde+=montant;
 }
 public void retirer(double montant){
	 solde-=montant;
 }

public int getCode() {
	return code;
}

public void setCode(int code) {
	this.code = code;
}

public double getSolde() {
	return solde;
}

@Override
public String toString() {
	return "Compte [code=" + code + ", solde=" + solde + "]";
}
 
}
