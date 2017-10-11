// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.saas.golf.web.scaffold;

import com.saas.golf.domain.ScoreCard;
import com.saas.golf.repository.GolfCourseHoleRepository;
import com.saas.golf.repository.ScoreCardRepository;
import com.saas.golf.web.scaffold.ScoreCardController;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect ScoreCardController_Roo_Controller {
    
    @Autowired
    ScoreCardRepository ScoreCardController.scoreCardRepository;
    
    @Autowired
    GolfCourseHoleRepository ScoreCardController.golfCourseHoleRepository;
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String ScoreCardController.create(@Valid ScoreCard scoreCard, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, scoreCard);
            return "scorecards/create";
        }
        uiModel.asMap().clear();
        scoreCardRepository.save(scoreCard);
        return "redirect:/scorecards/" + encodeUrlPathSegment(scoreCard.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String ScoreCardController.createForm(Model uiModel) {
        populateEditForm(uiModel, new ScoreCard());
        return "scorecards/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String ScoreCardController.show(@PathVariable("id") BigInteger id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("scorecard", scoreCardRepository.findOne(id));
        uiModel.addAttribute("itemId", id);
        return "scorecards/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String ScoreCardController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("scorecards", scoreCardRepository.findAll(new org.springframework.data.domain.PageRequest(firstResult / sizeNo, sizeNo)).getContent());
            float nrOfPages = (float) scoreCardRepository.count() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("scorecards", scoreCardRepository.findAll());
        }
        addDateTimeFormatPatterns(uiModel);
        return "scorecards/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String ScoreCardController.update(@Valid ScoreCard scoreCard, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, scoreCard);
            return "scorecards/update";
        }
        uiModel.asMap().clear();
        scoreCardRepository.save(scoreCard);
        return "redirect:/scorecards/" + encodeUrlPathSegment(scoreCard.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String ScoreCardController.updateForm(@PathVariable("id") BigInteger id, Model uiModel) {
        populateEditForm(uiModel, scoreCardRepository.findOne(id));
        return "scorecards/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String ScoreCardController.delete(@PathVariable("id") BigInteger id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        ScoreCard scoreCard = scoreCardRepository.findOne(id);
        scoreCardRepository.delete(scoreCard);
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/scorecards";
    }
    
    void ScoreCardController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("scoreCard_datecreated_date_format", "yyyy-MM-dd hh:mm:ss a");
    }
    
    void ScoreCardController.populateEditForm(Model uiModel, ScoreCard scoreCard) {
        uiModel.addAttribute("scoreCard", scoreCard);
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("golfcourseholes", golfCourseHoleRepository.findAll());
    }
    
    String ScoreCardController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
