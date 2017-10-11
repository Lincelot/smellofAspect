// C. Constantinides, 2013.

public aspect AccessLogger {

	declare precedence: AccessLogger, Security;

	before() : get(* Catalog.catalog) {
		System.out.println(">Before read access: " + thisJoinPoint);
	}

	before() : set(* Catalog.catalog) {
		System.out.println(">Before write access: " + thisJoinPoint);
	}

	after() : get(* Catalog.catalog) {
		System.out.println(">After read access: " + thisJoinPoint);
	}


	after() : execution(* Catalog.make*(..)) {
		System.out.println(">After: " + thisJoinPoint);
	}
	
	after() : set(* Catalog.catalog) {
		System.out.println(">After write access: " + thisJoinPoint);
	}

}

