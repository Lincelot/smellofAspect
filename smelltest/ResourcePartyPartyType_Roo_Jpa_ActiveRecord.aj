// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.inbloom.content.domain;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.inbloom.content.domain.ResourcePartyPartyType;
import org.springframework.transaction.annotation.Transactional;

privileged aspect ResourcePartyPartyType_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager ResourcePartyPartyType.entityManager;
    
    public static final EntityManager ResourcePartyPartyType.entityManager() {
        EntityManager em = new ResourcePartyPartyType().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long ResourcePartyPartyType.countResourcePartyPartyTypes() {
        return entityManager().createQuery("SELECT COUNT(o) FROM ResourcePartyPartyType o", Long.class).getSingleResult();
    }
    
    public static List<ResourcePartyPartyType> ResourcePartyPartyType.findAllResourcePartyPartyTypes() {
        return entityManager().createQuery("SELECT o FROM ResourcePartyPartyType o", ResourcePartyPartyType.class).getResultList();
    }
    
    public static ResourcePartyPartyType ResourcePartyPartyType.findResourcePartyPartyType(Long id) {
        if (id == null) return null;
        return entityManager().find(ResourcePartyPartyType.class, id);
    }
    
    public static List<ResourcePartyPartyType> ResourcePartyPartyType.findResourcePartyPartyTypeEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM ResourcePartyPartyType o", ResourcePartyPartyType.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void ResourcePartyPartyType.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void ResourcePartyPartyType.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            ResourcePartyPartyType attached = ResourcePartyPartyType.findResourcePartyPartyType(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void ResourcePartyPartyType.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void ResourcePartyPartyType.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public ResourcePartyPartyType ResourcePartyPartyType.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        ResourcePartyPartyType merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}