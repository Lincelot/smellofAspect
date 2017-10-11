package smellofAspect;

import java.sql.*;

import com.mysql.jdbc.log.Log;

public aspect aspectD {
	pointcut checkLevel(String username, String password):call(void user(String,String))&&args(username,password);

	pointcut ccc1():call(int ccc(int));

	pointcut ccc2(int cN):call(int cc(int))&&args(cN);

	pointcut ccc3(int ccN):(ccc1()||ccc2(int))&&args(ccN);

	pointcut pointTest():call(void test1());
	

	int a = 0;

	pointcut testHandler():handler(*);

	before():testHandler(){
//		System.out.println("handler");
	}

	before():ccc1(){
		test1();
//		System.out.println("ccc1");

	}

	after():pointTest(){
//		System.out.println("after test1");
	}

	private void test1() {
		// TODO Auto-generated method stub
//		System.out.println("test1");
	}

	before(int ccN):ccc3(ccN){
//		System.out.println("ccc3" + ccN);
	}

	before(String username, String password):checkLevel(username,password){
//		System.out.println("user=" + username + ",password=" + password);
		int level = 0;
		// 連結資料庫料庫
		Connection con = null;
		String url = "jdbc:mysql://localhost/test";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url, "lincelot", "yoyoyo66");
			Statement st = con.createStatement();
			st.execute("SELECT * FROM user");
			ResultSet rs = st.getResultSet();
			while (rs.next()) {
//				System.out.println("UserName=" + rs.getString("user") + " password=" + rs.getString("password")
//						+ " level=" + rs.getInt("level"));
				// 比對帳號
				if (username.equals(rs.getString("user")) && password.equals(rs.getString("password"))) {
					// 給予對應帳號權限
					level = rs.getInt("level");
					break;
				}
			}
		} catch (Exception e) {
		}
		// 不同權限不同動作
		switch (level) {
		case 1:
//			System.out.println("your level is " + level);
			break;
		case 2:
//			System.out.println("your level is " + level);
			break;
		case 3:
//			System.out.println("your level is " + level);
			break;
		case 4:
//			System.out.println("your level is " + level);
			break;
		case 5:
//			System.out.println("your level is " + level);
			break;
		default:
//			System.out.println("not the user");
		}
	}
}
