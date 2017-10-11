// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.inbloom.content.domain;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.inbloom.content.domain.PartyType;
import org.springframework.transaction.annotation.Transactional;

privileged aspect PartyType_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager PartyType.entityManager;
    
    public static final EntityManager PartyType.entityManager() {
        EntityManager em = new PartyType().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long PartyType.countPartyTypes() {
        return entityManager().createQuery("SELECT COUNT(o) FROM PartyType o", Long.class).getSingleResult();
    }
    
    public static List<PartyType> PartyType.findAllPartyTypes() {
        return entityManager().createQuery("SELECT o FROM PartyType o", PartyType.class).getResultList();
    }
    
    public static PartyType PartyType.findPartyType(Long id) {
        if (id == null) return null;
        return entityManager().find(PartyType.class, id);
    }
    
    public static List<PartyType> PartyType.findPartyTypeEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM PartyType o", PartyType.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void PartyType.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void PartyType.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            PartyType attached = PartyType.findPartyType(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void PartyType.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void PartyType.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public PartyType PartyType.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        PartyType merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}