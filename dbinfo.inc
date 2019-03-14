<%
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String connectionURL = "jdbc:sqlserver://121.179.212.213:1433;databaseName=sqlmaster;user=sqlmaster;password=rkdqkr2)!7";
	Connection con = java.sql.DriverManager.getConnection(connectionURL);
%>