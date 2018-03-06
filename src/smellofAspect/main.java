package smellofAspect;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

//import com.mysql.jdbc.log.Log;

import java.io.File;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.*;
import java.util.Scanner;
import java.lang.String;
import java.lang.Object;
import java.util.Arrays;
import java.util.*;
import java.util.Set;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import java.util.HashSet;
import java.text.ParseException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class main extends JFrame {

	public main() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String args[]) throws IOException {
		// TODO Auto-generated method stub
		String folderPath = "smelltest/";
		StringBuffer fileList = new StringBuffer();
//		detectionLaxPointcut(folderPath, fileList);
		detectionDispersedPointcut();
		detectionComplicatedPointcut(folderPath, fileList);
		detectionHighControlCoupledAspect();
		detectionCohesionAspect();

//		user("test1", "test");
		cc(0);
		ccc(0);
		// main frame = new main();
		// frame.setTitle("KeyEventDemo");
		// frame.setSize(500, 500);
		// frame.setLocationRelativeTo(null);
		// frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		// frame.setVisible(true);

		try {
			// Robot robot = new Robot();
			// robot.delay(5000);
			// for (int num = 0; num < 400; num++) {
			// robot.delay(10000);
			// robot.keyPress(KeyEvent.VK_0);
			// robot.keyRelease(KeyEvent.VK_0);
			// robot.delay(5000);
			// robot.keyPress(KeyEvent.VK_ENTER );
			// robot.keyRelease(KeyEvent.VK_ENTER );
			// robot.delay(1000);

			// robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
			// robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
			// robot.delay(1000);
			// robot.keyPress(KeyEvent.VK_5 );
			// robot.keyRelease(KeyEvent.VK_5 );
			// robot.delay(1000);
			// robot.keyPress(KeyEvent.VK_0 );
			// robot.keyRelease(KeyEvent.VK_0 );
			// robot.delay(1000);
			// robot.keyPress(KeyEvent.VK_0 );
			// robot.keyRelease(KeyEvent.VK_0 );
			// robot.delay(1000);
			// robot.keyPress(KeyEvent.VK_ENTER );
			// robot.keyRelease(KeyEvent.VK_ENTER );
			// robot.delay(55000);

			// robot.keyPress(KeyEvent.VK_F2 );
			// robot.keyRelease(KeyEvent.VK_F2 );
			// robot.delay(6000);
			// robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
			// robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
			// robot.delay(1000);
			// robot.keyPress(KeyEvent.VK_P);
			// robot.keyRelease(KeyEvent.VK_P);
			// robot.delay(1000);
			// robot.keyPress(KeyEvent.VK_ENTER );
			// robot.keyRelease(KeyEvent.VK_ENTER );
			// robot.delay(55);
			// robot.mouseMove(50, 50);
			// System.out.println(num);
			// }
			// robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
			// robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
			// System.out.println("finish");
		} catch (Exception e) {

		}
	}

	private static void detectionCohesionAspect() {
		// TODO Auto-generated method stub

	}

	private static void detectionHighControlCoupledAspect() {
		// TODO Auto-generated method stub

	}

	private static void detectionComplicatedPointcut(String folderPath, StringBuffer fileList) {
		// TODO Auto-generated method stub
		try {
			int smellsN=0;
			java.io.File folder = new java.io.File(folderPath);
			String[] list = folder.list();
			for (int fileQuantity = 0; fileQuantity < list.length; fileQuantity++) {
				// list[0] = "ActivityController_Roo_Controller.aj";
				// for (int fileQuantity = 0; fileQuantity < 1; fileQuantity++)
				// {
				int a = 0, number = 0;
				fileList.append(list[fileQuantity]).append(", ");
				System.out.println(list[fileQuantity] + "\n------------------------");
				File file = new File("smelltest/" + list[fileQuantity]);
				Scanner scanner = new Scanner(file);
				String data = "";

				while (scanner.hasNext()) {
					data += scanner.next() + " ";
					number++;
				}
				data = data.replace("default", "0");
				data = data.replaceAll("declare .* ", "0");//remove,such as "declare * "
//				data = data.replaceAll("\".*\"", "0");//remove,such as " " "
				data = data.replaceAll("[0-9]+[:]", "");
				data = data.replace(":", "\n:");
				data = data.replace("{", ";");
				data = data.replace(";", "\n");
				// Pattern pattern = Pattern.compile("call[(][a-zA-Z0-9+*]*[
				// ][a-zA-Z0-9+*]*[(]*");
				Pattern pattern = Pattern.compile("[:]");
				Matcher matcher = pattern.matcher(data);
				String[] dataAll = data.split("\n");
				data = "";
				for (int i = 0; i < dataAll.length; i++) {
					matcher = pattern.matcher(dataAll[i]);
					if (matcher.find()) {
						data += dataAll[i].replace(":", "").toString() + "\n";
					}
				}
				// data = data.replaceAll("[!@a-zA-Z0-9*+..<>\" ,/]", "");
				String[] dataMethod = data.split("\n");

				for (int i = 0; i < dataMethod.length; i++) {
					boolean isMethod = false;
					int levelBrackets = 0, level = 0;
					String dataNow = "";
					// System.out.println(dataMethod[i].replaceAll("[!@a-zA-Z0-9*+..<>\"
					// ,/]", ""));
					if (!dataMethod[i].replaceAll("[!@a-zA-Z0-9*+..<>\" ,/ ]", "").equals("")) {
						if (String.valueOf(dataMethod[i].replaceAll("[!@a-zA-Z0-9*+..<>\" ,/]", "").charAt(0))
								.equals("(")
								|| String.valueOf(dataMethod[i].replaceAll("[!@a-zA-Z0-9*+..<>\" ,/]", "").charAt(0))
										.equals("|")
								|| String.valueOf(dataMethod[i].replaceAll("[!@a-zA-Z0-9*+..<>\" ,/]", "").charAt(0))
										.equals("&")) {
							isMethod = true;
						}
						if (!isMethod) {
							System.out.println("it's not need.");
							// break;
						} else {
							System.out.println("Method Pattern : " + dataMethod[i]);
							dataMethod[i] = dataMethod[i].replaceAll("[!@a-zA-Z0-9*+..<>\" ,/]", "");
							dataMethod[i] = dataMethod[i].replace("&&", "&");
							dataMethod[i] = dataMethod[i].replace("||", "|");
							// System.out.println("test of dataMethod[i]: " +
							// dataMethod[i]);
							do {
								dataNow = dataMethod[i];
								dataMethod[i] = dataMethod[i].replace("()", "");
							} while (!dataMethod[i].equals(dataNow));
							// System.out.println("test1: " + dataMethod[i] + "
							// number:" + dataMethod[i].length());
							// System.out.println("test2: " +
							// dataMethod[i].replaceAll("[)|&]", "") + "number:"
							// + dataMethod[i].replaceAll("[)|&]",
							// "").length());
							int[] levelAnd = new int[dataMethod[i].replaceAll("[)|&]", "").length() + 1];
							int[] levelOr = new int[dataMethod[i].replaceAll("[)|&]", "").length() + 1];
							// for(int
							// and=0;and<dataMethod[i].replaceAll("[)|&]",
							// "").length();and++){
							// System.out.println("123 "+levelOr[and]);
							// }
							pattern = Pattern.compile("[()|&]");
							matcher = pattern.matcher(dataMethod[i]);
							while (matcher.find()) {
								if (matcher.group().toString().equals("(")) {
									levelBrackets++;
								} else if (matcher.group().toString().equals(")")) {
									if (levelBrackets == 0) {
										break;
									}
									if (levelOr[levelBrackets] > 0) {
										level += (levelOr[levelBrackets] + 1) * (Math.pow(2, levelBrackets));
									}
									if (levelAnd[levelBrackets] > 0) {
										level += (Math.pow(2, levelAnd[levelBrackets])) * (Math.pow(2, levelBrackets));
									}
									levelOr[levelBrackets] = 0;
									levelAnd[levelBrackets] = 0;
									levelBrackets--;
								} else if (matcher.group().toString().equals("|")) {
									levelOr[levelBrackets]++;
								} else if (matcher.group().toString().equals("&")) {
									levelAnd[levelBrackets]++;
								}
								// System.out.println("Now Level : " + level );
								// System.out.println("matcher:" +
								// matcher.group().toString());
								// System.out.println("matcher:"+matcher);
							}
							if (levelOr[0] > 0) {
								level += levelOr[levelBrackets] + 1;
							}
							if (levelAnd[0] > 0) {
								level += Math.pow(2, levelAnd[levelBrackets]);
							}
							System.out.println("Complicated Pointcut Level : " + level + "\n");
							if (level >= 3){
								System.out.println("it's smell. "+smellsN+++"\n");
//								smellsN++;
							}
						}
					}
				}
				System.out.println("---------------\n");
			}
			System.out.println("smells = "+smellsN);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void detectionDispersedPointcut() {
		// TODO Auto-generated method stub

	}

	private static void detectionLaxPointcut(String folderPath, StringBuffer fileList) {
		// TODO Auto-generated method stub
		try {
			java.io.File folder = new java.io.File(folderPath);
			String[] list = folder.list();
			int smells50=0,smells60=0,smells70=0,smells80=0,smells90=0,smells100=0;
			// list[0] = "aspectD.aj";
			for (int fileQuantity = 0; fileQuantity < list.length; fileQuantity++) {
				// for (int fileQuantity = 0; fileQuantity < 1; fileQuantity++)
				// {
				int a = 0, number = 0;
				fileList.append(list[fileQuantity]).append(", ");
				System.out.println(list[fileQuantity] + "\n------------------------");
				File file = new File("smelltest/" + list[fileQuantity]);
				Scanner scanner = new Scanner(file);
				String data = "";

				while (scanner.hasNext()) {
					data += scanner.next() + " ";
					number++;
				}
				String javaModifier[] = { "public", "protected", "private", "static", "abstract", "final", "native",
						"synchronized", "transient", "volatile", "strictfp", "!public", "!protected", "!private",
						"!static", "!abstract", "!final", "!native", "!synchronized", "!transient", "!volatile",
						"!strictfp" };
				data = data.replaceAll("[@][\\S]{0,99}[\\s]", "");
				data = data.replace("execution(", "call(");
				data = data.replace("execution (", "call(");
				data = data.replace("withincode(", "call(");
				data = data.replace("withincode (", "call(");
				data = data.replace("call (", "call(");
				data = data.replace("call(", "\ncall(");
				data = data.replace("( ", "(");
				data = data.replace("!", "");
				data = data.replace(")", ")\n");
				for (int m = 0; m < javaModifier.length; m++) {
					data = data.replace("call(" + javaModifier[m] + " ", "call(");
				}
				// Pattern pattern = Pattern.compile("call[(][a-zA-Z0-9+*]*[
				// ][a-zA-Z0-9+*]*[(]*");
				Pattern pattern = Pattern.compile("call[(]");
				Matcher matcher = pattern.matcher(data);
				String[] dataAll = data.split("\n");
				data = "";
				for (int i = 0; i < dataAll.length; i++) {
					matcher = pattern.matcher(dataAll[i]);
					if (matcher.find()) {
						data += dataAll[i].toString() + "\n";
					}
				}
				data = data.replace("call(", "");
				String[] dataMethod = data.split("\n");
				String[] idPattern = null;
				for (int i = 0; i < dataMethod.length; i++) {
					pattern = Pattern.compile("[!@a-zA-Z0-9*+..<>]*");
					matcher = pattern.matcher(dataMethod[i]);
					// Log.d("Method Pattern : "
					// ,""+String.valueOf(dataMethod[i]));
					System.out.println("Method Pattern : " + dataMethod[i]);
					float q = 0, level = 0, idLevel = 0, typeLevel = 0, signatureBC = 0;
					boolean sectionB = false;
					while (matcher.find()) {
						if (q == 0) {
							// System.out.pri ntln(q + matcher.group());
							if (matcher.group().equals("*")) {
								level += 30;
							}
						} else if (q == 2) {
							// System.out.println(q + matcher.group());
							idPattern = matcher.group().split("");
							for (int z = 0; z < idPattern.length; z++) {
								// System.out.println(idPattern[z]);
								if (idPattern[z].equals(".")) {
									sectionB = true;
									signatureBC /= 2;
									idLevel = z + 1;
									if (level >= 1) {
										level += -10;
									}
								}
								if (!sectionB) {
									if (idPattern[z].equals("*")) {
										signatureBC += 60;
									} else if (idPattern[z].equals("+") && (z - idLevel) < 10) {
										signatureBC += (50 - 5 * (z - idLevel)) * 0.6;
									}
								} else if (sectionB) {
									if (idPattern[z].equals("*")) {
										signatureBC += 40;
									} else if (idPattern[z].equals("+") && (z - idLevel) < 10) {
										signatureBC += (50 - 5 * (z - idLevel)) * 0.4;
									}
								}
							}
							level += signatureBC;
						} else if (q > 3 && q % 2 == 0) {
							// System.out.println(q + matcher.group());
							if (matcher.group().equals("*") || matcher.group().equals("..")) {
								// level+=25;
								typeLevel = 10;
							}
						}
						q++;
					}
					System.out.println("level=" + (level + typeLevel) + "%");
					if(level+typeLevel>=50)
						System.out.println("It's smells.");
					if(level+typeLevel>=100)
						smells100++;
					else if(level+typeLevel>=90)
						smells90++;
					else if(level+typeLevel>=80)
						smells80++;
					else if(level+typeLevel>=70)
						smells70++;
					else if(level+typeLevel>=60)
						smells60++;
					else if(level+typeLevel>=50)
						smells50++;
				}
				System.out.println("---------------\n");
			}
			System.out.println("Level>=50:::"+smells50);
			System.out.println("Level>=60:::"+smells60);
			System.out.println("Level>=70:::"+smells70);
			System.out.println("Level>=80:::"+smells80);
			System.out.println("Level>=90:::"+smells90);
			System.out.println("Level>=100:::"+smells100);
			// while (matcher.find()) {
			// System.out.print(matcher.group() + "\n");
			// System.out.print(matcher);
			// }
			// String test[][] = new String[number][];
			// scanner = new Scanner(file);
			//
			// System.out.println("" + scanner.next(Pattern.compile("..ll")));
			//
			// for (int i = 0; i < str.length; i++) {
			// for (int j = 0; j < str[i].length; j++) {
			// System.out.println("[" + i + "]" + "[" + j + "] :" + str[i][j]);
			// }
			// }

			// ArrayList<String> view = new ArrayList<String>();
			// Set<String> inset = new HashSet<String>();
			// for (int i = 0; i < str.length; i++) {
			// for (int j = 0; j < str[i].length; j++) {
			// inset.add(str[i][j]);
			// }
			// }
			// view.addAll(inset);
			// for (int s = 0; s < view.size(); s++) {
			// System.out.println(view.get(s));
			// }
			// System.out.println(str[5][0].equals(view.get(0)));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}

	private static void aspectSoftwareData() {
		// TODO Auto-generated method stub

	}

	private static int cc(int cc) {
		// TODO Auto-generated method stub
		return cc;
	}

	private static int ccc(int ccc) {
		// TODO Auto-generated method stub
		return ccc;
	}

	public static void user(String username, String password) {
		// System.out.println(username + ":" + password);
	}
}
