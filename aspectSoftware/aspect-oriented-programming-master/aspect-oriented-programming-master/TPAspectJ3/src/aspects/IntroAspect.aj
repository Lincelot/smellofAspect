package aspects;

import dao.DaoImpl;

public aspect IntroAspect {
declare parents:dao.DaoImpl implements dao.IDao;

private double dao.DaoImpl.value;

public double dao.DaoImpl.getValue(){
	return value;
}
public void dao.DaoImpl.setValue(double v){
	this.value=v;
}
//s'applique avant l'instanciation de n'import quel sous type de IDao
before():initialization(dao.IDao+.new(..)){
	DaoImpl dao=(DaoImpl)thisJoinPoint.getTarget();
	dao.setValue(11);
}
}
