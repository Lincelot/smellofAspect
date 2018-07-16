/* Description: This file is the main class for the Tetris game.
 * All the game logic is placed here.
 * 
 * Copyright 2003 Gustav Evertsson All Rights Reserved.
*/

import java.util.Random;
import Gui.*;
import EventInterface.*;
import Logic.*;

public class AspectTetris implements IEventListner {
	
	public static final int GAMESIZEX = 10;
	public static final int GAMESIZEY = 20;
	
	public static final int BLOCKSIZEX = 4;
	public static final int BLOCKSIZEY = 4;
	
	protected int[][] gameBoard;
	protected int[][] currentBlock;
	protected int currentXPos = (GAMESIZEX / 2) - (BLOCKSIZEX / 2);
	protected int currentYPos = 0;
	
	protected TetrisGUI gui;
	protected Blocks blocks;
	protected Timer timer;
	protected boolean onGoingGame = false;
	protected boolean paused = false;
	
	public void startTetris() {
		System.out.println("Starting AspectTetris...");
		
		TetrisImages.preLoad();
		
		blocks = new Blocks(BLOCKSIZEX, BLOCKSIZEY, GAMESIZEX, GAMESIZEY);
		
		// Creates an empty game board.
		gameBoard = new int[GAMESIZEX][GAMESIZEY];
 		for(int x = 0; x < GAMESIZEX; x++) {
			for(int y = 0; y < GAMESIZEY; y++) {
				gameBoard[x][y] = Blocks.EMPTY;
			}
		}

		// Creates an empty block.
		currentBlock = new int[BLOCKSIZEX][BLOCKSIZEY];
 		for(int x = 0; x < BLOCKSIZEX; x++) {
			for(int y = 0; y < BLOCKSIZEY; y++) {
				currentBlock[x][y] = Blocks.EMPTY;
			}
		}

		gui = TetrisGUI.start(this, GAMESIZEX, GAMESIZEY);
 		gui.gamePanel.setBlocks(gameBoard);

		currentBlock = getRandomBlock();
 		
 		timer = new Timer(this, 700);
		timer.start();
		onGoingGame = true;
	}
	
	public void incomingEvent(int eventType) {
		if(!onGoingGame && eventType != IEventListner.NEWGAME)
			return;
		if(paused && eventType != IEventListner.PAUSE && eventType != IEventListner.NEWGAME)
			return;
		//System.out.println("New event of type " + eventType);
		if(eventType == IEventListner.UP) {	// Turn currentBlock...
			if(blocks.checkCombineBlocks(blocks.turnBlock(currentBlock), blocks.deleteBlocks(currentBlock, gameBoard, currentXPos, currentYPos), currentXPos, currentYPos)){
	 			currentBlock = blocks.turnBlock(currentBlock);
	 			blocks.combineBlocks(currentBlock, gameBoard, currentXPos, currentYPos);
	 			gui.gamePanel.setBlocks(gameBoard);
	 		}
		}
		else if(eventType == IEventListner.DOWN) {	// Fast down...
			while(blocks.checkCombineBlocks(currentBlock, blocks.deleteBlocks(currentBlock, gameBoard, currentXPos, currentYPos), currentXPos, currentYPos + 1)){
	 			currentYPos++;
	 			blocks.combineBlocks(currentBlock, gameBoard, currentXPos, currentYPos);
	 		}
	 		
	 		//System.out.println("The block has reached the bottom!");
	 		blocks.combineBlocks(currentBlock, gameBoard, currentXPos, currentYPos);
	 		deleteLines();
	 		newBlock();
	 		
		}
		else if(eventType == IEventListner.LEFT){
	 		if(blocks.checkCombineBlocks(currentBlock, blocks.deleteBlocks(currentBlock, gameBoard, currentXPos, currentYPos), currentXPos - 1, currentYPos)){
	 			currentXPos--;
	 			blocks.combineBlocks(currentBlock, gameBoard, currentXPos, currentYPos);
	 			gui.gamePanel.setBlocks(gameBoard);
	 		}
		}
		else if(eventType == IEventListner.RIGHT) {
	 		if(blocks.checkCombineBlocks(currentBlock, blocks.deleteBlocks(currentBlock, gameBoard, currentXPos, currentYPos), currentXPos + 1, currentYPos)){
	 			currentXPos++;
	 			blocks.combineBlocks(currentBlock, gameBoard, currentXPos, currentYPos);
	 			gui.gamePanel.setBlocks(gameBoard);
	 		}
	 	}
 		else if(eventType == IEventListner.TIMER) {
	 		if(blocks.checkCombineBlocks(currentBlock, blocks.deleteBlocks(currentBlock, gameBoard, currentXPos, currentYPos), currentXPos, currentYPos + 1)){
	 			currentYPos++;
	 			blocks.combineBlocks(currentBlock, gameBoard, currentXPos, currentYPos);
	 			gui.gamePanel.setBlocks(gameBoard);
	 		}
	 		else {
	 			//System.out.println("The block has reached the bottom!");
	 			blocks.combineBlocks(currentBlock, gameBoard, currentXPos, currentYPos);
	 			deleteLines();
	 			newBlock();
	 		}		
		}
 		else if(eventType == IEventListner.NEWGAME) {
 			restartGame();
  		}
  		else if(eventType == IEventListner.PAUSE) {
 			pauseGame();
 		}
			
 		
	}
	
	protected void newBlock() {
		
		currentXPos = (GAMESIZEX / 2) - (BLOCKSIZEX / 2);
		currentYPos = 0;
		
		
		
		currentBlock = getRandomBlock();
		
		if(!blocks.checkCombineBlocks(currentBlock, gameBoard, currentXPos, currentYPos)){
	 		gameOver();
	 	}
		else {
			blocks.combineBlocks(currentBlock, gameBoard, currentXPos, currentYPos);
	 		gui.gamePanel.setBlocks(gameBoard);
		}
	}
	
	protected void deleteLines() {
		for(int i = 0; i < GAMESIZEY; i++) {
			boolean complete = true;
			for(int j = 0; j < GAMESIZEX; j++) {
				if(gameBoard[j][i] == Blocks.EMPTY)
					complete = false;
			}
			if(complete) {
				blocks.deleteLine(i, gameBoard);
			}
		}	
	}
	
	protected void gameOver() {
		System.out.println("Game Over!");
		onGoingGame = false;
		timer.stop();
	}
	
	protected void restartGame() {
		System.out.println("New Game...");

		// Creates an empty game board.
		gameBoard = new int[GAMESIZEX][GAMESIZEY];
 		for(int x = 0; x < GAMESIZEX; x++) {
			for(int y = 0; y < GAMESIZEY; y++) {
				gameBoard[x][y] = Blocks.EMPTY;
			}
		}
		
		newBlock();
		
 		timer.start();
 		paused = false;
		onGoingGame = true;		
	}
	
	protected void pauseGame() {
		if(paused) {
			paused = false;
			timer.start();
		}
		else {
			paused = true;
			timer.stop();
			System.out.println("Pause...");
		}
	}
	
	public int[][] getRandomBlock() {
		Random rn = new Random();

		int randomValue = rn.nextInt(Blocks.NUMBEROFTYPES);
		System.out.println("New " + Blocks.typeToString(randomValue) + " block.");
		return blocks.getBlock(randomValue);
	}
	

	
	public static void main(String[] args) {
		AspectTetris tetris = new AspectTetris();
		tetris.startTetris();
	}
}