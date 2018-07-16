package org.jhotdraw.ccconcerns.commands.undo;

import org.jhotdraw.framework.DrawingView;
import org.jhotdraw.framework.FigureEnumeration;
import org.jhotdraw.util.Undoable;

public aspect UndoRedoActivity {
	pointcut callUndoableRedo(Undoable undoable) : 
		call(boolean Undoable.redo()) &&
		target(undoable) &&
		if(false); //just to have no match for now

	boolean around(Undoable undoable) : callUndoableRedo(undoable) {
		if(undoable.isRedoable()) {
			return proceed(undoable);
		}
		return false;
	}

	
	pointcut callUndoableUndo(Undoable undoable) : 
		call(boolean Undoable.undo()) &&
		target(undoable) &&
		if(false); 
	

	boolean around(Undoable undoable) : callUndoableUndo(undoable) {
		if(undoable.isUndoable()) {
			return proceed(undoable);
		}
		return false;
	}

	
	pointcut callUndoableIsUndoable(Undoable undoable) : 
		call(boolean Undoable.isUndoable()) &&
		target(undoable) &&
		if(false);
	
	boolean around(Undoable undoable) : callUndoableIsUndoable(undoable) {
		return proceed(undoable);
	}
	
	
	pointcut callUndoableIsRedoable(Undoable undoable) : 
		call(boolean Undoable.isRedoable()) &&
		target(undoable) &&
		if(false); 

	boolean around(Undoable undoable) : callUndoableIsRedoable(undoable) {
		return proceed(undoable);
	}

	
	pointcut callUndoableSetUndoable(Undoable undoable, boolean newIsUndoable) : 
		call(void Undoable.setUndoable(boolean)) &&
		args(newIsUndoable) &&
		target(undoable) &&
		if(false);


	void around(Undoable undoable, boolean newIsUndoable) : callUndoableSetUndoable(undoable, newIsUndoable) {
		proceed(undoable, newIsUndoable);
	}

	
	pointcut callUndoableSetRedoable(Undoable undoable, boolean newIsRedoable) : 
		call(void Undoable.setRedoable(boolean)) &&
		args(newIsRedoable) &&
		target(undoable) &&
		if(false); 
	
	boolean around(Undoable undoable, boolean newIsRedoable) : callUndoableSetRedoable(undoable, newIsRedoable) {
		return proceed(undoable, newIsRedoable);
	}

	
	pointcut callUndoableRelease(Undoable undoable) : 
		call(void Undoable.release()) &&
		target(undoable) &&
		if(false); 

	
	void around(Undoable undoable) : callUndoableRelease(undoable) {
		proceed(undoable);
	}
	
	
	pointcut callUndoableGetDrawingView(Undoable undoable) : 
		call(DrawingView Undoable.getDrawingView()) &&
		target(undoable) &&
		if(false); 
	

	DrawingView around(Undoable undoable) : callUndoableGetDrawingView(undoable) {
		return proceed(undoable);
	}


	pointcut callUndoableSetAffectedFigures(Undoable undoable, FigureEnumeration newAffectedFigures) : 
		call(void Undoable.setAffectedFigures(FigureEnumeration)) &&
		args(newAffectedFigures) &&
		target(undoable) &&
		if(false); 
	
	void around(Undoable undoable, FigureEnumeration newAffectedFigures) : callUndoableSetAffectedFigures(undoable, newAffectedFigures) {
		proceed(undoable, newAffectedFigures);
	}
	

	pointcut callUndoableGetAffectedFigures(Undoable undoable) : 
		call(FigureEnumeration Undoable.getAffectedFigures()) &&
		target(undoable) &&
		if(false); 
	
	FigureEnumeration around(Undoable undoable) : callUndoableGetAffectedFigures(undoable) {
		return proceed(undoable);
	}


	pointcut callUndoableGetAffectedFiguresCount(Undoable undoable) : 
		call(FigureEnumeration Undoable.getAffectedFiguresCount()) &&
		target(undoable);

	int around(Undoable undoable) : callUndoableGetAffectedFiguresCount(undoable) {
		return proceed(undoable);
	}
}
