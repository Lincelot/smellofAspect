// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.inbloom.content.controller;

import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.inbloom.content.controller.LearningResourceController;
import org.inbloom.content.domain.LearningResource;
import org.inbloom.content.domain.Resource;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect LearningResourceController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String LearningResourceController.create(@Valid LearningResource learningResource, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, learningResource);
            return "learningresources/create";
        }
        uiModel.asMap().clear();
        learningResource.persist();
        return "redirect:/learningresources/" + encodeUrlPathSegment(learningResource.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String LearningResourceController.createForm(Model uiModel) {
        populateEditForm(uiModel, new LearningResource());
        return "learningresources/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String LearningResourceController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("learningresource", LearningResource.findLearningResource(id));
        uiModel.addAttribute("itemId", id);
        return "learningresources/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String LearningResourceController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("learningresources", LearningResource.findLearningResourceEntries(firstResult, sizeNo));
            float nrOfPages = (float) LearningResource.countLearningResources() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("learningresources", LearningResource.findAllLearningResources());
        }
        return "learningresources/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String LearningResourceController.update(@Valid LearningResource learningResource, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, learningResource);
            return "learningresources/update";
        }
        uiModel.asMap().clear();
        learningResource.merge();
        return "redirect:/learningresources/" + encodeUrlPathSegment(learningResource.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String LearningResourceController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, LearningResource.findLearningResource(id));
        return "learningresources/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String LearningResourceController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        LearningResource learningResource = LearningResource.findLearningResource(id);
        learningResource.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/learningresources";
    }
    
    void LearningResourceController.populateEditForm(Model uiModel, LearningResource learningResource) {
        uiModel.addAttribute("learningResource", learningResource);
        uiModel.addAttribute("resources", Resource.findAllResources());
    }
    
    String LearningResourceController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}