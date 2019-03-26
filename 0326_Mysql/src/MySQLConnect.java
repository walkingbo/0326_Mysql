import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class MySQLConnect {

	public static void main(String[] args) {
		//1.드라이버 클래스를 로드 - 처음에 한번만 수행
		//이 부분에서 오류가 발생하면 드라이버 크래스 이름 오류이거나 
		//드라이버 파일을 프로젝트의 build path 에 추가 하지 않은 것이다.
		 try {
			 Class.forName("com.mysql.jdbc.Driver");
		 }catch(Exception e) {
			 System.out.printf("드라이버 클래스 로드 : %s\n", e.getMessage());
		 }
		 
		 //2.데이터베이스 연결
		 //try(){} : try with resource 구문은로  AutoClosable 인터페이스를
		 //implements 한 클래스의 인스턴스를 생성하는 구문을 삽입할 수 있는데
		 //이 경우에는 close()를 호출하지 않아도 영역을 벗어나면 자동으로 호출한다.
		try(Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sample?useUnicode=yes&characterEncoding=UTF-8","root","1111");
			//sql 실행객체 - 입력 받아서 넣는 자리는 ?로 설정 
			//PreparedStatement pstmt = con.prepareStatement("insert into usertbl(userid, name, birthyear, addr, mobile, mdate) values(?,?,?,?,?,?)");-삽입하기
			//PreparedStatement pstmt = con.prepareStatement("update usertbl set mobile = ? where userid = ?"); -수정하기
			//PreparedStatement pstmt = con.prepareStatement("select avg(price) from buytbl");-평균 조회
			//PreparedStatement pstmt = con.prepareStatement("select userid from buytbl group by userid");-List
			//조회할 내용이 연산식인 경우에는 연산식에 별명을 사용하는 것이 좋다.	
			PreparedStatement pstmt = con.prepareStatement("select userid, sum(price * amount) buy from buytbl group by userid");){
			List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				//HashMap(해싱 -키의 순서를 모름)
				//LinkedHashMap(키의 순서대로 저장)
				//TreeMap(키를 오름차순으로 정렬 - 트리구조로 저장)
				Map<String,Object>	map = new LinkedHashMap<String,Object>();
				map.put("userid", rs.getString("userid"));
				map.put("sum", rs.getString("buy"));
				
				list.add(map);
			}
			rs.close();
			System.out.printf("%s\n",list);
			
			/* -List
			//select userid from buytbl group by userid의 결과를 저장할 자료구조
			List<String> list = new ArrayList<String>();
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String temp = rs.getNString("userid");
				list.add(temp);
			}
			rs.close();
			System.out.printf("%s\n",list);
			*/
			
			
			
			
			
			/* 평균 구하기 	
			double avg = -1;
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				//avg =rs.getDouble(1);
				avg = rs.getDouble("avg(price)");
			}
			System.out.printf("평균 : %f\n",avg);
			rs.close();
			*/
			
			
			//System.out.printf("%s\n",con); - 데이터베이스 연결 확인	 
			
			//sql 실행 객체에 ?가 있으면 ?에 실제 데이터를 대입 - 바인딩
			
			/* 수정
			pstmt.setString(1, "01000000000");
			pstmt.setString(2,"moon");
			*/
			
			/*
			pstmt.setString(1,"moon");
			pstmt.setString(2,"문정");
			pstmt.setInt(3,1992);
			pstmt.setString(4,"광");
			pstmt.setString(5,"01058884222");
			//Date를 생성할 때는 Calendar를 이용해서 작
			Calendar cal = new GregorianCalendar(1992,3,24);
			java.sql.Date date = new java.sql.Date(cal.getTimeInMillis());
			pstmt.setDate(6,date);
			*/
			
			
			//SQL 실행
			//select는 ResultSet(List 나 일반 객체 또는 스칼라 데이터)으로 리턴
			//나머지 SQL은 전부 정수로 리턴
			//정수의 값을 가지고 성공 여부를 판단해야한다.
			//이 정수값은 영향받은 행의 개수 입니다.
			//삽입은 0보다 크면 성공
			
			//수정은 0보다 크면 수정할 데이터가 있어서 수정한 것이고 
			//0이 리턴 되면 수정할 데이터가 없어서 수정을 안한 것이다.
			
			/*
			int result = pstmt.executeUpdate();
			if(result > 0) {
				System.out.printf("수정 성공");
			}else {
				System.out.printf("조건에 맞는 데이터가 없습니다.");
			}
			*/
			
		}catch(Exception e) {
			System.out.printf("데이터베이스 사용예외 : %s\n", e.getMessage());
		}
	}

}
