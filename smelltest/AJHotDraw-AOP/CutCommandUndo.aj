package org.jhotdraw.ccconcerns.commands.undo;

import java.util.List;

import org.jhotdraw.framework.FigureEnumeration;
import org.jhotdraw.standard.CutCommand;
import org.jhotdraw.standard.FigureEnumerator;
import org.jhotdraw.standard.FigureTransferCommand;
import org.jhotdraw.util.CollectionsFactory;
import org.jhotdraw.util.Undoable;
import org.jhotdraw.util.UndoableAdapter;

public privileged aspect CutCommandUndo {

	public Undoable CutCommand.createUndoActivity() {
		return new CutCommandUndo.UndoActivity(this);
	}
	
    pointcut commandExecuteInitUndo(CutCommand acommand) :
		this(acommand)
		&& execution(void CutCommand.execute());



    before(CutCommand acommand) : commandExecuteInitUndo(acommand) {
		acommand.setUndoActivity(acommand.createUndoActivity());
	}
    
    before(CutCommand acommand) : commandExecuteInitUndo(acommand) {
		acommand.getUndoActivity().setAffectedFigures(acommand.collectAffectedFigures());
		UndoActivity ua = (UndoActivity) acommand.getUndoActivity();
		ua.setSelectedFigures(acommand.view().selection());

	}

	
	public static class UndoActivity extends UndoableAdapter {

		private FigureTransferCommand myCommand;
		private List mySelectedFigures;

		public UndoActivity(FigureTransferCommand newCommand) {
			super(newCommand.view());
			myCommand = newCommand;
			setUndoable(true);
			setRedoable(true);
		}

		public boolean undo() {
			if (super.undo() && getAffectedFigures().hasNextFigure()) {
				getDrawingView().clearSelection();
				myCommand.insertFigures(getAffectedFiguresReversed(), 0, 0);
				return true;
			}
			return false;
		}

		public boolean redo() {
			if (isRedoable()) {
				myCommand.copyFigures(getSelectedFigures(), getSelectedFiguresCount());
				myCommand.deleteFigures(getAffectedFigures());
				return true;
			}

			return false;
		}

		public void setSelectedFigures(FigureEnumeration newSelectedFigures) {
			rememberSelectedFigures(newSelectedFigures);
		}
		protected void rememberSelectedFigures(FigureEnumeration toBeRemembered) {
			mySelectedFigures = CollectionsFactory.current().createList();
			while (toBeRemembered.hasNextFigure()) {
				mySelectedFigures.add(toBeRemembered.nextFigure());
			}
		}
	
		public FigureEnumeration getSelectedFigures() {
			return new FigureEnumerator(
				CollectionsFactory.current().createList(mySelectedFigures));
		}

		public int getSelectedFiguresCount() {
			return mySelectedFigures.size();
		}

		public void release() {
			super.release();
			FigureEnumeration fe = getSelectedFigures();
			while (fe.hasNextFigure()) {
				fe.nextFigure().release();
			}
			setSelectedFigures(FigureEnumerator.getEmptyEnumeration());
		}
	}


}
