// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.inbloom.content.domain;

import java.util.Set;
import org.inbloom.content.domain.PartyType;
import org.inbloom.content.domain.ResourcePartyPartyType;

privileged aspect PartyType_Roo_JavaBean {
    
    public String PartyType.getName() {
        return this.name;
    }
    
    public void PartyType.setName(String name) {
        this.name = name;
    }
    
    public Set<ResourcePartyPartyType> PartyType.getResourcePartyPartyType() {
        return this.resourcePartyPartyType;
    }
    
    public void PartyType.setResourcePartyPartyType(Set<ResourcePartyPartyType> resourcePartyPartyType) {
        this.resourcePartyPartyType = resourcePartyPartyType;
    }
    
}
