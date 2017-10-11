// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.inbloom.content.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.persistence.PostPersist;
import javax.persistence.PostUpdate;
import javax.persistence.PreRemove;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrInputDocument;
import org.inbloom.content.domain.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;

privileged aspect Tag_Roo_SolrSearch {
    
    @Autowired
    transient SolrServer Tag.solrServer;
    
    public static QueryResponse Tag.search(String queryString) {
        String searchString = "Tag_solrsummary_t:" + queryString;
        return search(new SolrQuery(searchString.toLowerCase()));
    }
    
    public static QueryResponse Tag.search(SolrQuery query) {
        try {
            return solrServer().query(query);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new QueryResponse();
    }
    
    public static void Tag.indexTag(Tag tag) {
        List<Tag> tags = new ArrayList<Tag>();
        tags.add(tag);
        indexTags(tags);
    }
    
    @Async
    public static void Tag.indexTags(Collection<Tag> tags) {
        List<SolrInputDocument> documents = new ArrayList<SolrInputDocument>();
        for (Tag tag : tags) {
            SolrInputDocument sid = new SolrInputDocument();
            sid.addField("id", "tag_" + tag.getId());
            sid.addField("tag.name_s", tag.getName());
            sid.addField("tag.id_l", tag.getId());
            // Add summary field to allow searching documents for objects of this type
            sid.addField("tag_solrsummary_t", new StringBuilder().append(tag.getName()).append(" ").append(tag.getId()));
            documents.add(sid);
        }
        try {
            SolrServer solrServer = solrServer();
            solrServer.add(documents);
            solrServer.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @Async
    public static void Tag.deleteIndex(Tag tag) {
        SolrServer solrServer = solrServer();
        try {
            solrServer.deleteById("tag_" + tag.getId());
            solrServer.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @PostUpdate
    @PostPersist
    private void Tag.postPersistOrUpdate() {
        indexTag(this);
    }
    
    @PreRemove
    private void Tag.preRemove() {
        deleteIndex(this);
    }
    
    public static SolrServer Tag.solrServer() {
        SolrServer _solrServer = new Tag().solrServer;
        if (_solrServer == null) throw new IllegalStateException("Solr server has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return _solrServer;
    }
    
}
