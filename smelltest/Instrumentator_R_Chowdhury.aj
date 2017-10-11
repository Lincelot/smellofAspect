import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

/**
 * 
 * @author Rasel
 */

public aspect Instrumentator_R_Chowdhury {

	// instance
	pointcut instantiation(): call (*.new(..))&& !within(Instrumentator_R_Chowdhury)&& !cflow(call ( java.*.*.new(..)));

	// calls
	pointcut calls(Object caller): call(* *(..))&& this(caller)  && !within(Instrumentator_R_Chowdhury) && !cflow(call (* java.*.*.*(..)));

	// execution
	pointcut executions(Object o):  (execution (* *(..)) || adviceexecution())&&this(o)&& !within(Instrumentator_R_Chowdhury)&& !cflow(execution (* java.*.*.*(..)));

	// termination
	pointcut terminations(Object o): (execution (* *(..)) || adviceexecution())&&this(o) && !within(Instrumentator_R_Chowdhury)&& !cflow(execution (* java.*.*.*(..)));

	// instace
	before(): instantiation(){
		System.out.println("instance(" + thisJoinPoint.hashCode() + ", '"
				+ thisJoinPoint.getSignature().getDeclaringTypeName() + "', '"
				+ thisJoinPoint.getSignature() + "', "
				+ System.currentTimeMillis() / 1000L + ").");
		File log = new File("instantiations.txt");
		// write to file
		try {
			log.setWritable(true);
			FileWriter fileWriter = new FileWriter(log, true);

			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			bufferedWriter.write("instance(" + thisJoinPoint.hashCode() + ", '"
					+ thisJoinPoint.getSignature().getDeclaringTypeName()
					+ "', '" + thisJoinPoint.getSignature() + "', "
					+ System.currentTimeMillis() / 1000L + ").");
			bufferedWriter.newLine();
			bufferedWriter.close();
		} catch (IOException e) {
			System.out.println("COULD NOT LOG!!");
		}
	}

	// calls
	before(Object caller): calls(caller){
		System.out.println("calls(" + caller.hashCode() + ", "
				+ caller.getClass().getName() + "," + thisJoinPoint.hashCode()
				+ ", " + thisJoinPoint.getSignature().getDeclaringTypeName()
				+ ", '" + thisJoinPoint.getSignature() + "', "
				+ System.currentTimeMillis() / 1000L + ").");
		File log = new File("calls.txt");
		// write to file
		try {
			log.setWritable(true);
			FileWriter fileWriter = new FileWriter(log, true);

			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			bufferedWriter.write("calls(" + caller.hashCode() + ", "
					+ caller.getClass().getName() + ","
					+ thisJoinPoint.hashCode() + ", "
					+ thisJoinPoint.getSignature().getDeclaringTypeName()
					+ ", '" + thisJoinPoint.getSignature() + "', "
					+ System.currentTimeMillis() / 1000L + ").");
			bufferedWriter.newLine();
			bufferedWriter.close();
		} catch (IOException e) {
			System.out.println("COULD NOT LOG!!");
		}
	}

	// executions
	before(Object o): executions(o){
		System.out.println("execution(" + thisJoinPoint.hashCode() + ", '"
				+ thisJoinPoint.getSignature().getDeclaringTypeName() + ", '"
				+ thisJoinPoint.getSignature() + "', "
				+ System.currentTimeMillis() / 1000L + ").");
		File log = new File("executions.txt");
		// write to file
		try {
			log.setWritable(true);
			FileWriter fileWriter = new FileWriter(log, true);

			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			bufferedWriter.write("execution(" + thisJoinPoint.hashCode()
					+ ", '"
					+ thisJoinPoint.getSignature().getDeclaringTypeName()
					+ ", '" + thisJoinPoint.getSignature() + "', "
					+ System.currentTimeMillis() / 1000L + ").");
			bufferedWriter.newLine();
			bufferedWriter.close();
		} catch (IOException e) {
			System.out.println("COULD NOT LOG!!");
		}
	}

	// termination
	after(Object o): terminations(o){
		System.out.println("termination('" + thisJoinPoint.getSignature()
				+ "', " + thisJoinPoint.hashCode() + ", "
				+ System.currentTimeMillis() / 1000L + ").");
		File log = new File("terminations.txt");
		// write to file
		try {
			log.setWritable(true);
			FileWriter fileWriter = new FileWriter(log, true);

			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			bufferedWriter.write("termination('" + thisJoinPoint.getSignature()
					+ "', " + thisJoinPoint.hashCode() + ", "
					+ System.currentTimeMillis() / 1000L + ").");
			bufferedWriter.newLine();
			bufferedWriter.close();
		} catch (IOException e) {
			System.out.println("COULD NOT LOG!!");
		}
	}

}
