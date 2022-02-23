/**
 * @author Emily Young (with the reuse of JDBCTester.java structure that I DID NOT write)
 */
package coms363c;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.sql.*;
import javax.swing.*;
import javax.swing.border.LineBorder;

public class HW4 {
	public static String[] loginDialog() {
		String result[] = new String[2];
		JPanel panel = new JPanel(new GridBagLayout());
		GridBagConstraints cs = new GridBagConstraints();

		cs.fill = GridBagConstraints.HORIZONTAL;

		JLabel lbUsername = new JLabel("Username: ");
		cs.gridx = 0;
		cs.gridy = 0;
		cs.gridwidth = 1;
		panel.add(lbUsername, cs);

		JTextField tfUsername = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 0;
		cs.gridwidth = 2;
		panel.add(tfUsername, cs);

		JLabel lbPassword = new JLabel("Password: ");
		cs.gridx = 0;
		cs.gridy = 1;
		cs.gridwidth = 1;
		panel.add(lbPassword, cs);

		JPasswordField pfPassword = new JPasswordField(20);
		cs.gridx = 1;
		cs.gridy = 1;
		cs.gridwidth = 2;
		panel.add(pfPassword, cs);
		panel.setBorder(new LineBorder(Color.GRAY));

		String[] options = new String[] { "OK", "Cancel" };
		int ioption = JOptionPane.showOptionDialog(null, panel, "Login", JOptionPane.OK_OPTION,
				JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
		if (ioption == 0) // pressing OK button
		{
			result[0] = tfUsername.getText();
			result[1] = new String(pfPassword.getPassword());
		}
		return result;
	}

	/**
	 * @param stmt
	 * @param sqlQuery
	 * @throws SQLException
	 * 
	 *                      I AM REUSING THE STRUCTURE OF JDBCTester FOR HW 4
	 */
	private static void runQuery(Statement stmt, String sqlQuery) throws SQLException {
		boolean rs;
		rs = stmt.execute(sqlQuery);
		System.out.println(sqlQuery);	
	}
	private static void retrieve(Statement stmt, String sql) throws SQLException{
		ResultSet rs;
		ResultSetMetaData rsMetaData;
		rs = stmt.executeQuery(sql);
		rsMetaData = rs.getMetaData();
		String toShow = "";
		while(rs.next()){
			for(int i=0;i<rsMetaData.getColumnCount();i++){
				toShow += rs.getString(i+1);
			}
				toShow += "\n";
			}
		JOptionPane.showMessageDialog(null, toShow);
	}
	public static void main(String[] args) {
		String dbServer = "jdbc:mysql://localhost:3306/graph?useSSL=false";
		String userName = "";
		String password = "";

		String result[] = loginDialog();
		userName = result[0];
		password = result[1];

		Connection conn;
		Statement stmt;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbServer, userName, password);
			stmt = conn.createStatement();
			String sqlQuery = "";
			String sql = "";

			String nName = "";
			String imp = "";
			String start = "";
			String end = "";
			String cost ="";
			String option = "";
			String instruction = "Enter a: Insert a new graph node." + "\n"
					+ "Enter b: Insert a new graph edge."
					+ "\n" + "Enter c: Delete a graph node." + "\n"
					+ "Enter d: List all reachable nodes" + "\n"
					+ "Enter e: Quit Program";

			while (true) {
				option = JOptionPane.showInputDialog(instruction);
				if (option.equals("a")) {
					instruction = "Enter nodename: ";
					nName = JOptionPane.showInputDialog(instruction);
					instruction = "Enter importance: ";
					imp = JOptionPane.showInputDialog(instruction);
					sqlQuery = "INSERT INTO nodes SET nodename = '"+nName+"', importance = '"+imp+"' ON DUPLICATE KEY UPDATE nodename = '"+nName+"';";
					runQuery(stmt, sqlQuery);
					sql = "SELECT * FROM graph.nodes;";
					retrieve(stmt, sql);
				} else if (option.equalsIgnoreCase("b")) {
					instruction = "Enter startNode: ";
					start = JOptionPane.showInputDialog(instruction);
					instruction = "Enter endNode: ";
					end = JOptionPane.showInputDialog(instruction);
					instruction = "Enter cost: ";
					cost = JOptionPane.showInputDialog(instruction);
					sqlQuery = "INSERT INTO edges (startnode, endnode, cost)" + "VALUES('"+start+"','"+end+"','"+cost+"');";
					runQuery(stmt, sqlQuery);
					sql = "SELECT * FROM graph.edges;";
					retrieve(stmt, sql);
				} else if (option.equals("c")) {
					instruction = "Enter nodename: ";
					nName = JOptionPane.showInputDialog(instruction);
					sqlQuery = "DELETE FROM nodes WHERE nodeName = '"+nName+"'; DELETE FROM edges WHERE startnode = '"+nName+"' OR endnode = '"+nName+"';";
					runQuery(stmt, sqlQuery);
					sql = "SELECT * FROM graph.nodes, graph.edges;";
					retrieve(stmt, sql);
				} else if (option.equals("d")) {
					PreparedStatement reach = conn.prepareStatement("{call reachable(?)}");
					reach.clearParameters(); // clear previous parameter values
					instruction = "Enter nodename: ";
					nName = JOptionPane.showInputDialog(instruction);// get input from user to a String variable named value
					reach.setString(1, nName);
					ResultSet rs = reach.executeQuery();
					sql = "SELECT * FROM graph.reached;";
					retrieve(stmt, sql);
				}
				 else {
					break;
				}
			}

			stmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("Program terminates due to errors");
			e.printStackTrace(); // for debugging
		}
	}

}
