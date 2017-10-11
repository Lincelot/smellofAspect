// C. Constantinides, 2013.

public aspect Security {
	  
	pointcut calls (Object sender):
		call(* Catalog.makeNewBook(..)) &&
		this(sender);

	void around(Object sender): calls(sender) {
		if (sender instanceof BookEntrySession) {
			System.out.println(">Proceed: " + thisJoinPoint);
			proceed(sender);
		}

		else
			System.out.println(">Access denied.");
			
	}

}
