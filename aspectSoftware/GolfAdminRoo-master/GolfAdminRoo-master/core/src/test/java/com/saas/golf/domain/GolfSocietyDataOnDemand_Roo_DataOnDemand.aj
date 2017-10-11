// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.saas.golf.domain;

import com.saas.golf.domain.Account;
import com.saas.golf.domain.AccountDataOnDemand;
import com.saas.golf.domain.GolfSociety;
import com.saas.golf.domain.GolfSocietyDataOnDemand;
import com.saas.golf.repository.GolfSocietyRepository;
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

privileged aspect GolfSocietyDataOnDemand_Roo_DataOnDemand {
    
    declare @type: GolfSocietyDataOnDemand: @Component;
    
    private Random GolfSocietyDataOnDemand.rnd = new SecureRandom();
    
    private List<GolfSociety> GolfSocietyDataOnDemand.data;
    
    @Autowired
    private AccountDataOnDemand GolfSocietyDataOnDemand.accountDataOnDemand;
    
    @Autowired
    GolfSocietyRepository GolfSocietyDataOnDemand.golfSocietyRepository;
    
    public GolfSociety GolfSocietyDataOnDemand.getNewTransientGolfSociety(int index) {
        GolfSociety obj = new GolfSociety();
        setAccount(obj, index);
        setDateCreated(obj, index);
        setSocietyName(obj, index);
        return obj;
    }
    
    public void GolfSocietyDataOnDemand.setAccount(GolfSociety obj, int index) {
        Account account = accountDataOnDemand.getRandomAccount();
        obj.setAccount(account);
    }
    
    public void GolfSocietyDataOnDemand.setDateCreated(GolfSociety obj, int index) {
        Date dateCreated = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setDateCreated(dateCreated);
    }
    
    public void GolfSocietyDataOnDemand.setSocietyName(GolfSociety obj, int index) {
        String societyName = "societyName_" + index;
        if (societyName.length() > 50) {
            societyName = societyName.substring(0, 50);
        }
        obj.setSocietyName(societyName);
    }
    
    public GolfSociety GolfSocietyDataOnDemand.getSpecificGolfSociety(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        GolfSociety obj = data.get(index);
        BigInteger id = obj.getId();
        return golfSocietyRepository.findOne(id);
    }
    
    public GolfSociety GolfSocietyDataOnDemand.getRandomGolfSociety() {
        init();
        GolfSociety obj = data.get(rnd.nextInt(data.size()));
        BigInteger id = obj.getId();
        return golfSocietyRepository.findOne(id);
    }
    
    public boolean GolfSocietyDataOnDemand.modifyGolfSociety(GolfSociety obj) {
        return false;
    }
    
    public void GolfSocietyDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = golfSocietyRepository.findAll(new org.springframework.data.domain.PageRequest(from / to, to)).getContent();
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'GolfSociety' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<GolfSociety>();
        for (int i = 0; i < 10; i++) {
            GolfSociety obj = getNewTransientGolfSociety(i);
            try {
                golfSocietyRepository.save(obj);
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