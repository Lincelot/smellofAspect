package org.jhotdraw.ccconcerns.figures.persistence;

import org.jhotdraw.figures.FigureAttributes;
import org.jhotdraw.util.StorableInput;
import org.jhotdraw.util.Storable;

import java.io.IOException;

public aspect IOExceptionHandling {
	
	pointcut persistenceSupportFigures() : 
		call(String StorableInput.readString() throws IOException) ||
		call(int StorableInput.readInt() throws IOException) ||
		call(long StorableInput.readLong() throws IOException) ||
		call(double StorableInput.readDouble() throws IOException) ||
		call(boolean StorableInput.readBoolean() throws IOException) ||
		call(Storable StorableInput.readStorable() throws IOException);
	
	declare soft: IOException : persistenceSupportFigures();
	
	
	pointcut persistenceSupportFigureAttributes() :
		call(void FigureAttributes.read(StorableInput) throws IOException);
	
	declare soft: IOException : persistenceSupportFigureAttributes();
	
}
