// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.inbloom.content.domain;

import flexjson.JSONDeserializer;
import flexjson.JSONSerializer;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.inbloom.content.domain.Interactivity;

privileged aspect Interactivity_Roo_Json {
    
    public String Interactivity.toJson() {
        return new JSONSerializer().exclude("*.class").serialize(this);
    }
    
    public String Interactivity.toJson(String[] fields) {
        return new JSONSerializer().include(fields).exclude("*.class").serialize(this);
    }
    
    public static Interactivity Interactivity.fromJsonToInteractivity(String json) {
        return new JSONDeserializer<Interactivity>().use(null, Interactivity.class).deserialize(json);
    }
    
    public static String Interactivity.toJsonArray(Collection<Interactivity> collection) {
        return new JSONSerializer().exclude("*.class").serialize(collection);
    }
    
    public static String Interactivity.toJsonArray(Collection<Interactivity> collection, String[] fields) {
        return new JSONSerializer().include(fields).exclude("*.class").serialize(collection);
    }
    
    public static Collection<Interactivity> Interactivity.fromJsonArrayToInteractivitys(String json) {
        return new JSONDeserializer<List<Interactivity>>().use(null, ArrayList.class).use("values", Interactivity.class).deserialize(json);
    }
    
}