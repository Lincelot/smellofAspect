package org.jhotdraw.ccconcerns.commands;

import org.jhotdraw.framework.JHotDrawRuntimeException;
import org.jhotdraw.standard.AbstractCommand;

public aspect CommandContracts {

    pointcut commandExecuteCheckView(AbstractCommand acommand) :
		this(acommand)
		&& execution(void AbstractCommand+.execute())
		&& !within(*..DrawApplication.*)
        && !within(*..CTXWindowMenu.*)
        && !within(*..WindowMenu.*)
        && !within(*..JavaDrawApp.*);

	
	before(AbstractCommand acommand) : commandExecuteCheckView(acommand) {

		if (acommand.view() == null) {
			throw new JHotDrawRuntimeException("execute should NOT be getting called when view() == null");
		};

	}

    pointcut commandExecuteNotifyView(AbstractCommand acommand) :
    	commandExecuteCheckView(acommand)
    	&& !within(org.jhotdraw.util.UndoCommand)
    	&& !within(org.jhotdraw.util.RedoCommand)
		&& !within(org.jhotdraw.standard.CopyCommand)
		&& !within(org.jhotdraw.standard.ToggleGridCommand)
		&& !within(org.jhotdraw.contrib.zoom.ZoomCommand);

	after(AbstractCommand acommand) : commandExecuteNotifyView(acommand) {
		acommand.view().checkDamage();

	}
    
	
}
