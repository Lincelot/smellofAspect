package Application;

import dao.DaoImpl;

public class App {

	public static void main(String[] args){
	DaoImpl dao=new DaoImpl();
	System.out.println(dao.getValue());
	dao.setValue(100);
	System.out.println(dao.getValue());
	
}
}
