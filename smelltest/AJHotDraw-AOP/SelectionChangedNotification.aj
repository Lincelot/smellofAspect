package org.jhotdraw.ccconcerns.figures.figureselectionobserver;

import org.jhotdraw.standard.StandardDrawingView;
import org.jhotdraw.framework.Figure;
import org.jhotdraw.framework.FigureEnumeration;

public aspect SelectionChangedNotification {

    pointcut invalidateSelFigure(StandardDrawingView sdw) :
        (   withincode(boolean StandardDrawingView.addToSelectionImpl(Figure)) 
         || withincode(void StandardDrawingView.removeFromSelection(Figure)))
        && call(void Figure.invalidate()) 
        && this(sdw);
    
    pointcut clear_toggleSelection(StandardDrawingView sdw):
        (execution(void StandardDrawingView.clearSelection()) ||
         execution(void StandardDrawingView.toggleSelection(Figure)))
        && this(sdw);

    after(StandardDrawingView sdw): invalidateSelFigure(sdw) {
        sdw.fireSelectionChanged();
    }
    
    after(StandardDrawingView sdw): clear_toggleSelection(sdw) {
        sdw.fireSelectionChanged();
    }
}
