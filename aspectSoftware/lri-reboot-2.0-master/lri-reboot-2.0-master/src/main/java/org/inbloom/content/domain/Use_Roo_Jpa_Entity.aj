// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.inbloom.content.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;
import org.inbloom.content.domain.Use;

privileged aspect Use_Roo_Jpa_Entity {
    
    declare @type: Use: @Entity;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Use.id;
    
    @Version
    @Column(name = "version")
    private Integer Use.version;
    
    public Long Use.getId() {
        return this.id;
    }
    
    public void Use.setId(Long id) {
        this.id = id;
    }
    
    public Integer Use.getVersion() {
        return this.version;
    }
    
    public void Use.setVersion(Integer version) {
        this.version = version;
    }
    
}
