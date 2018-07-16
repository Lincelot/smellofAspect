package org.jhotdraw.ccconcerns.figures.persistence;

import org.jhotdraw.standard.CompositeFigure;
import org.jhotdraw.framework.Figure;
import org.jhotdraw.framework.FigureEnumeration;
import org.jhotdraw.util.*;

import java.io.IOException;

/**
 * Implements the "persistence" concern for composite figures.
 * The aspect accesses fields of the class into which introduces
 * the persistence concern (e.g., fFigures - protected list of the 
 * component figures of a composite), therefore needs to be given 
 * privileged access.
 * 
 * @author Marius M.
 *
 */
public privileged aspect PersistentCompositeFigure {
	
	public void CompositeFigure.write(StorableOutput dw) {
		super.write(dw);
		int cnt = figureCount();
		dw.writeInt(cnt);
		FigureEnumeration fe = figures();
		int i = 0;
		while (fe.hasNextFigure()) {
			i++;
			Figure f = fe.nextFigure();
			assert f != null;
			dw.writeStorable(f);
		}
		assert cnt == i;
	}


	public void CompositeFigure.read(StorableInput dr) /*@AJHD refactored throws IOException*/ { 
		super.read(dr);
		int size = dr.readInt();
		fFigures = CollectionsFactory.current().createList(size);
	
		for (int i=0; i<size; i++) {
			Storable s = dr.readStorable();
			assert s != null : "reading null storable";
			add((Figure)s);
		}
		init(displayBox());
	}


}
