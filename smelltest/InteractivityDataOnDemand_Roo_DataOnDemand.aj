// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.inbloom.content.domain;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.inbloom.content.domain.Interactivity;
import org.inbloom.content.domain.InteractivityDataOnDemand;
import org.springframework.stereotype.Component;

privileged aspect InteractivityDataOnDemand_Roo_DataOnDemand {
    
    declare @type: InteractivityDataOnDemand: @Component;
    
    private Random InteractivityDataOnDemand.rnd = new SecureRandom();
    
    private List<Interactivity> InteractivityDataOnDemand.data;
    
    public Interactivity InteractivityDataOnDemand.getNewTransientInteractivity(int index) {
        Interactivity obj = new Interactivity();
        setName(obj, index);
        return obj;
    }
    
    public void InteractivityDataOnDemand.setName(Interactivity obj, int index) {
        String name = "name_" + index;
        obj.setName(name);
    }
    
    public Interactivity InteractivityDataOnDemand.getSpecificInteractivity(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Interactivity obj = data.get(index);
        Long id = obj.getId();
        return Interactivity.findInteractivity(id);
    }
    
    public Interactivity InteractivityDataOnDemand.getRandomInteractivity() {
        init();
        Interactivity obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Interactivity.findInteractivity(id);
    }
    
    public boolean InteractivityDataOnDemand.modifyInteractivity(Interactivity obj) {
        return false;
    }
    
    public void InteractivityDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Interactivity.findInteractivityEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Interactivity' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Interactivity>();
        for (int i = 0; i < 10; i++) {
            Interactivity obj = getNewTransientInteractivity(i);
            try {
                obj.persist();
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
