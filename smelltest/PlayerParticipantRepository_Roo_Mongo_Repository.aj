// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.saas.golf.repository;

import com.saas.golf.domain.PlayerParticipant;
import com.saas.golf.repository.PlayerParticipantRepository;
import java.math.BigInteger;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

privileged aspect PlayerParticipantRepository_Roo_Mongo_Repository {
    
    declare parents: PlayerParticipantRepository extends PagingAndSortingRepository<PlayerParticipant, BigInteger>;
    
    declare @type: PlayerParticipantRepository: @Repository;
    
}