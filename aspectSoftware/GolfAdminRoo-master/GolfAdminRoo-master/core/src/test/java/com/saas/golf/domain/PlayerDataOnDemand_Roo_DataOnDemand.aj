// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.saas.golf.domain;

import com.saas.golf.domain.Player;
import com.saas.golf.domain.PlayerDataOnDemand;
import com.saas.golf.repository.PlayerRepository;
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

privileged aspect PlayerDataOnDemand_Roo_DataOnDemand {
    
    declare @type: PlayerDataOnDemand: @Component;
    
    private Random PlayerDataOnDemand.rnd = new SecureRandom();
    
    private List<Player> PlayerDataOnDemand.data;
    
    @Autowired
    PlayerRepository PlayerDataOnDemand.playerRepository;
    
    public Player PlayerDataOnDemand.getNewTransientPlayer(int index) {
        Player obj = new Player();
        setDateCreated(obj, index);
        setHandicap(obj, index);
        setPlayerName(obj, index);
        return obj;
    }
    
    public void PlayerDataOnDemand.setDateCreated(Player obj, int index) {
        Date dateCreated = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setDateCreated(dateCreated);
    }
    
    public void PlayerDataOnDemand.setHandicap(Player obj, int index) {
        double handicap = new Integer(index).doubleValue();
        obj.setHandicap(handicap);
    }
    
    public void PlayerDataOnDemand.setPlayerName(Player obj, int index) {
        String playerName = "playerName_" + index;
        if (playerName.length() > 50) {
            playerName = playerName.substring(0, 50);
        }
        obj.setPlayerName(playerName);
    }
    
    public Player PlayerDataOnDemand.getSpecificPlayer(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Player obj = data.get(index);
        BigInteger id = obj.getId();
        return playerRepository.findOne(id);
    }
    
    public Player PlayerDataOnDemand.getRandomPlayer() {
        init();
        Player obj = data.get(rnd.nextInt(data.size()));
        BigInteger id = obj.getId();
        return playerRepository.findOne(id);
    }
    
    public boolean PlayerDataOnDemand.modifyPlayer(Player obj) {
        return false;
    }
    
    public void PlayerDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = playerRepository.findAll(new org.springframework.data.domain.PageRequest(from / to, to)).getContent();
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Player' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Player>();
        for (int i = 0; i < 10; i++) {
            Player obj = getNewTransientPlayer(i);
            try {
                playerRepository.save(obj);
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
