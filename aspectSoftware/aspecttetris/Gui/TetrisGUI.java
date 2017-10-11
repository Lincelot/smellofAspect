/* Description: This is the window that handle the user interface.
 * It also handle the user input.
 * 
 * Copyright 2003 Gustav Evertsson All Rights Reserved.
*/

package Gui;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

import java.beans.*;

import Logic.*;
import EventInterface.*;

public class TetrisGUI extends JPanel {
	static JFrame theFrame;
	
	public BlockPanel gamePanel;
	protected IEventListner listner;
	
	public TetrisGUI(IEventListner pListner, int gameSizeX, int gameSizeY) {
		this.listner = pListner;
		gamePanel = new BlockPanel(gameSizeX, gameSizeY, "background.gif");
		add(gamePanel);
		//gamePanel.setLocation( 75, 75);
		
		AbstractAction actionUp = new AbstractAction() {
			public void actionPerformed(ActionEvent e) {
				listner.incomingEvent(IEventListner.UP);
				//System.out.println("Key: Up");
			}
		};

		AbstractAction actionDown = new AbstractAction() {
			public void actionPerformed(ActionEvent e) {
				listner.incomingEvent(IEventListner.DOWN);
				//System.out.println("Key: Down");
			}
		};
		
		AbstractAction actionLeft = new AbstractAction() {
			public void actionPerformed(ActionEvent e) {
				listner.incomingEvent(IEventListner.LEFT);
				//System.out.println("Key: Left");
			}
		};
		
		AbstractAction actionRight = new AbstractAction() {
			public void actionPerformed(ActionEvent e) {
				listner.incomingEvent(IEventListner.RIGHT);
				//System.out.println("Key: Right");
			}
		};

		AbstractAction actionNewGame = new AbstractAction() {
			public void actionPerformed(ActionEvent e) {
				listner.incomingEvent(IEventListner.NEWGAME);
				//System.out.println("Key: Right");
			}
		};
		
		AbstractAction actionPause = new AbstractAction() {
			public void actionPerformed(ActionEvent e) {
				listner.incomingEvent(IEventListner.PAUSE);
				//System.out.println("Key: Right");
			}
		};
		try{
			KeyStroke strokeUp = KeyStroke.getKeyStroke(KeyEvent.VK_UP, 0);
			gamePanel.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW ).put(strokeUp, "UP");
			gamePanel.getActionMap().put("UP", actionUp);

			KeyStroke strokeDown = KeyStroke.getKeyStroke(KeyEvent.VK_DOWN, 0);
			gamePanel.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW ).put(strokeDown, "DOWN");
			gamePanel.getActionMap().put("DOWN", actionDown);

			KeyStroke strokeLeft = KeyStroke.getKeyStroke(KeyEvent.VK_LEFT, 0);
			gamePanel.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW ).put(strokeLeft, "LEFT");
			gamePanel.getActionMap().put("LEFT", actionLeft);

			KeyStroke strokeRight = KeyStroke.getKeyStroke(KeyEvent.VK_RIGHT, 0);
			gamePanel.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW ).put(strokeRight, "RIGHT");
			gamePanel.getActionMap().put("RIGHT", actionRight);

			KeyStroke strokeNewGame = KeyStroke.getKeyStroke(KeyEvent.VK_F2, 0);
			gamePanel.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW ).put(strokeNewGame, "NEWGAME");
			gamePanel.getActionMap().put("NEWGAME", actionNewGame);

			KeyStroke strokePause = KeyStroke.getKeyStroke(KeyEvent.VK_F3, 0);
			gamePanel.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW ).put(strokePause, "PAUSE");
			gamePanel.getActionMap().put("PAUSE", actionPause);
		}
		catch(Exception e) {
			System.out.println("Problem setting up key events: " + e);
		}
	}







	public static TetrisGUI start(IEventListner listner, int gameSizeX, int gameSizeY) {
		TetrisGUI gui = new TetrisGUI(listner, gameSizeX, gameSizeY);
		theFrame = new JFrame("AspectTetris 1.0");
		theFrame.addWindowListener(new WindowAdapter() {
		    public void windowClosing(WindowEvent e) {System.exit(0);}
		});
		//theFrame.getContentPane().add("Center", gui);
		theFrame.getContentPane().add(gui);
		theFrame.pack();
		theFrame.setSize(300, 400);
 		theFrame.setVisible(true);
 		
 		
		return gui;
	}
}
