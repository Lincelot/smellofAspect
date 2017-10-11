package com.example.pointcut.controllers;

import com.example.pointcut.Timer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
public class SvcController {

    @GetMapping("/h1")
    @Timer("my timer abc")
    public String hello1() {
        log.info("Reply to hello1");
        return "Hello1";
    }

    @RequestMapping(value = "/h2", method = RequestMethod.GET)
    public String hello2() {
        log.info("Reply to hello2");
        return "Hello2";
    }

    @GetMapping(value = "/h3")
    public String hello3() {
        log.info("Reply to hello3");
        throw new NullPointerException("something bad");
    }
}
