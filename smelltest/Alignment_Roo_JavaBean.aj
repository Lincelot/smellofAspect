// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.inbloom.content.domain;

import org.inbloom.content.domain.Alignment;
import org.inbloom.content.domain.AlignmentType;
import org.inbloom.content.domain.Resource;
import org.inbloom.content.domain.Standard;

privileged aspect Alignment_Roo_JavaBean {
    
    public Standard Alignment.getStandard() {
        return this.standard;
    }
    
    public void Alignment.setStandard(Standard standard) {
        this.standard = standard;
    }
    
    public Resource Alignment.getResource() {
        return this.resource;
    }
    
    public void Alignment.setResource(Resource resource) {
        this.resource = resource;
    }
    
    public AlignmentType Alignment.getAlignmentType() {
        return this.alignmentType;
    }
    
    public void Alignment.setAlignmentType(AlignmentType alignmentType) {
        this.alignmentType = alignmentType;
    }
    
}
