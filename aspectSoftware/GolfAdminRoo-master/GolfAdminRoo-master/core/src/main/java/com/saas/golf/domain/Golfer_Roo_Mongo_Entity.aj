// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.saas.golf.domain;

import com.saas.golf.domain.Golfer;
import java.math.BigInteger;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Persistent;

privileged aspect Golfer_Roo_Mongo_Entity {
    
    declare @type: Golfer: @Persistent;
    
    @Id
    private BigInteger Golfer.id;
    
    public BigInteger Golfer.getId() {
        return this.id;
    }
    
    public void Golfer.setId(BigInteger id) {
        this.id = id;
    }
    
}
