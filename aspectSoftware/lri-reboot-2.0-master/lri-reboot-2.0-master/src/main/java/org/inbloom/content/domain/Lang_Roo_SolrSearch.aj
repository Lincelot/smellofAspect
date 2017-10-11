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
import org.inbloom.content.domain.Lang;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;

privileged aspect Lang_Roo_SolrSearch {
    
    @Autowired
    transient SolrServer Lang.solrServer;
    
    public static QueryResponse Lang.search(String queryString) {
        String searchString = "Lang_solrsummary_t:" + queryString;
        return search(new SolrQuery(searchString.toLowerCase()));
    }
    
    public static QueryResponse Lang.search(SolrQuery query) {
        try {
            return solrServer().query(query);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new QueryResponse();
    }
    
    public static void Lang.indexLang(Lang lang) {
        List<Lang> langs = new ArrayList<Lang>();
        langs.add(lang);
        indexLangs(langs);
    }
    
    @Async
    public static void Lang.indexLangs(Collection<Lang> langs) {
        List<SolrInputDocument> documents = new ArrayList<SolrInputDocument>();
        for (Lang lang : langs) {
            SolrInputDocument sid = new SolrInputDocument();
            sid.addField("id", "lang_" + lang.getId());
            sid.addField("lang.name_s", lang.getName());
            sid.addField("lang.code_s", lang.getCode());
            sid.addField("lang.id_l", lang.getId());
            // Add summary field to allow searching documents for objects of this type
            sid.addField("lang_solrsummary_t", new StringBuilder().append(lang.getName()).append(" ").append(lang.getCode()).append(" ").append(lang.getId()));
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
    public static void Lang.deleteIndex(Lang lang) {
        SolrServer solrServer = solrServer();
        try {
            solrServer.deleteById("lang_" + lang.getId());
            solrServer.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @PostUpdate
    @PostPersist
    private void Lang.postPersistOrUpdate() {
        indexLang(this);
    }
    
    @PreRemove
    private void Lang.preRemove() {
        deleteIndex(this);
    }
    
    public static SolrServer Lang.solrServer() {
        SolrServer _solrServer = new Lang().solrServer;
        if (_solrServer == null) throw new IllegalStateException("Solr server has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return _solrServer;
    }
    
}
