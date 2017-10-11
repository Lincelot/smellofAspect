// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.saas.golf.domain;

import com.saas.golf.domain.Competition;
import com.saas.golf.domain.CompetitionDataOnDemand;
import com.saas.golf.repository.CompetitionRepository;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect CompetitionDataOnDemand_Roo_DataOnDemand {
    
    declare @type: CompetitionDataOnDemand: @Component;
    
    private Random CompetitionDataOnDemand.rnd = new SecureRandom();
    
    private List<Competition> CompetitionDataOnDemand.data;
    
    @Autowired
    CompetitionRepository CompetitionDataOnDemand.competitionRepository;
    
    public Competition CompetitionDataOnDemand.getNewTransientCompetition(int index) {
        Competition obj = new Competition();
        setDateCreated(obj, index);
        setName(obj, index);
        return obj;
    }
    
    public void CompetitionDataOnDemand.setDateCreated(Competition obj, int index) {
        Date dateCreated = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setDateCreated(dateCreated);
    }
    
    public void CompetitionDataOnDemand.setName(Competition obj, int index) {
        String name = "name_" + index;
        if (name.length() > 50) {
            name = name.substring(0, 50);
        }
        obj.setName(name);
    }
    
    public Competition CompetitionDataOnDemand.getSpecificCompetition(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Competition obj = data.get(index);
        BigInteger id = obj.getId();
        return competitionRepository.findOne(id);
    }
    
    public Competition CompetitionDataOnDemand.getRandomCompetition() {
        init();
        Competition obj = data.get(rnd.nextInt(data.size()));
        BigInteger id = obj.getId();
        return competitionRepository.findOne(id);
    }
    
    public boolean CompetitionDataOnDemand.modifyCompetition(Competition obj) {
        return false;
    }
    
    public void CompetitionDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = competitionRepository.findAll(new org.springframework.data.domain.PageRequest(from / to, to)).getContent();
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Competition' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Competition>();
        for (int i = 0; i < 10; i++) {
            Competition obj = getNewTransientCompetition(i);
            try {
                competitionRepository.save(obj);
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            data.add(obj);
        }
    }
    
}