// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.inbloom.content.domain;

import java.util.Set;
import org.inbloom.content.domain.LearningResource;
import org.inbloom.content.domain.Resource;

privileged aspect LearningResource_Roo_JavaBean {
    
    public String LearningResource.getName() {
        return this.name;
    }
    
    public void LearningResource.setName(String name) {
        this.name = name;
    }
    
    public Set<Resource> LearningResource.getResource() {
        return this.resource;
    }
    
    public void LearningResource.setResource(Set<Resource> resource) {
        this.resource = resource;
    }
    
}