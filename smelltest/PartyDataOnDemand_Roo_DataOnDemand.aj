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
import org.inbloom.content.domain.Party;
import org.inbloom.content.domain.PartyDataOnDemand;
import org.springframework.stereotype.Component;

privileged aspect PartyDataOnDemand_Roo_DataOnDemand {
    
    declare @type: PartyDataOnDemand: @Component;
    
    private Random PartyDataOnDemand.rnd = new SecureRandom();
    
    private List<Party> PartyDataOnDemand.data;
    
    public Party PartyDataOnDemand.getNewTransientParty(int index) {
        Party obj = new Party();
        setName(obj, index);
        return obj;
    }
    
    public void PartyDataOnDemand.setName(Party obj, int index) {
        String name = "name_" + index;
        obj.setName(name);
    }
    
    public Party PartyDataOnDemand.getSpecificParty(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Party obj = data.get(index);
        Long id = obj.getId();
        return Party.findParty(id);
    }
    
    public Party PartyDataOnDemand.getRandomParty() {
        init();
        Party obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Party.findParty(id);
    }
    
    public boolean PartyDataOnDemand.modifyParty(Party obj) {
        return false;
    }
    
    public void PartyDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Party.findPartyEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Party' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Party>();
        for (int i = 0; i < 10; i++) {
            Party obj = getNewTransientParty(i);
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