package org.jhotdraw.ccconcerns.commands;

import org.jhotdraw.ccconcerns.commands.undo.*;

import org.jhotdraw.framework.DrawingEditor;
import org.jhotdraw.framework.FigureSelectionListener;
import org.jhotdraw.framework.DrawingView;
import org.jhotdraw.standard.AbstractCommand;
import org.jhotdraw.standard.AlignCommand;
import org.jhotdraw.standard.BringToFrontCommand;
import org.jhotdraw.standard.ChangeAttributeCommand;
import org.jhotdraw.standard.CutCommand;
import org.jhotdraw.standard.DeleteCommand;
import org.jhotdraw.standard.DuplicateCommand;
import org.jhotdraw.standard.PasteCommand;
import org.jhotdraw.figures.GroupCommand;
import org.jhotdraw.figures.InsertImageCommand;
import org.jhotdraw.standard.SelectAllCommand;
import org.jhotdraw.standard.SendToBackCommand;
import org.jhotdraw.figures.UngroupCommand;
import org.jhotdraw.util.Command;
import org.jhotdraw.util.Undoable;
import org.jhotdraw.util.UndoableAdapter;

public aspect UndoableCommand  {

	pointcut undoableCommands() :
		(
		(target(AlignCommand) && !within(AlignCommand) && !within(AlignCommandUndo))  
		|| (target(BringToFrontCommand) && !within(BringToFrontCommand) && !within(BringToFrontCommandUndo))	
		|| (target(ChangeAttributeCommand) && !within(ChangeAttributeCommand) && !within(ChangeAttributeCommandUndo))
		|| (target(CutCommand) && !within(CutCommand) && !within(CutCommandUndo))
		|| (target(DeleteCommand) && !within(DeleteCommand) && !within(DeleteCommandUndo))
		|| (target(DuplicateCommand) && !within(DuplicateCommand) && !within(DuplicateCommandUndo))
		|| (target(PasteCommand) && !within(PasteCommand) && !within(PasteCommandUndo))
		|| (target(GroupCommand) && !within(GroupCommand) && !within(GroupCommandUndo))
		|| (target(InsertImageCommand) && !within(InsertImageCommand) )
		|| (target(SelectAllCommand) && !within(SelectAllCommand) )
		|| (target(SendToBackCommand) && !within(SendToBackCommand) )
		|| (target(UngroupCommand) && !within(UngroupCommand))
		) && !within(UndoableCommand);

	
	private boolean AbstractCommand.hasSelectionChanged;
	

		
	pointcut callCommandFigureSelectionChanged( DrawingView drawingView) :
		call(void FigureSelectionListener+.figureSelectionChanged(DrawingView)) && 
		undoableCommands() &&
		args(drawingView);
	
	void around( DrawingView drawingView) : callCommandFigureSelectionChanged(drawingView) {

		AbstractCommand command = (AbstractCommand)thisJoinPoint.getTarget();
		
		command.hasSelectionChanged = true;
		proceed( drawingView);
	}


	
	pointcut callCommandExecute() :
		call(void Command+.execute()) && undoableCommands();
	void around() : callCommandExecute(/*command*/) {
	    	
		AbstractCommand command = (AbstractCommand)thisJoinPoint.getTarget();
	    	
		command.hasSelectionChanged = false;
		command.view().addFigureSelectionListener(/*this*/command);
		
		proceed();

		Undoable undoableCommand = command.getUndoActivity();
		
		if ((undoableCommand != null) && (undoableCommand.isUndoable())) {
			command.getDrawingEditor().getUndoManager().pushUndo(undoableCommand);
			command.getDrawingEditor().getUndoManager().clearRedos();
		}
		if (!command.hasSelectionChanged || (command.getDrawingEditor().getUndoManager().getUndoSize() == 1)) {
			command.getDrawingEditor().figureSelectionChanged(command.view());
		}
		command.view().removeFigureSelectionListener(/*this*/command);
	}

	
	pointcut callCommandIsExecutable() :
		call(boolean Command+.isExecutable()) && undoableCommands();
    
    boolean around() : callCommandIsExecutable() {
        return proceed();
    }

    
	pointcut callCommandName() :
		call(String Command+.name()) && undoableCommands();
    
    String around() : callCommandName() {
        return proceed();
    }


	pointcut callCommandGetDrawingEditor() :
		call(DrawingEditor Command+.getDrawingEditor()) && undoableCommands();
    
    DrawingEditor around() : callCommandGetDrawingEditor() {
        return proceed();
    }
        

	pointcut callCommandGetUndoActivity() :
		call(Undoable Command+.getUndoActivity()) && undoableCommands();

    Undoable around() : callCommandGetUndoActivity() {
    	AbstractCommand command = (AbstractCommand)thisJoinPoint.getTarget();
    	return new UndoableAdapter(command.getDrawingEditor().view());
    }
    
    
	pointcut callCommandSetUndoActivity( Undoable undoable) :
		call(void Command+.setUndoActivity(Undoable)) && undoableCommands() && args(undoable);

    void around( Undoable undoable) : callCommandSetUndoActivity(undoable) {
    }  
}
