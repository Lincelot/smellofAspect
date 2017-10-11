package com.example.pointcut;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;

@Aspect
@Slf4j
@Component
public class PointCutViaAnnot {

    @Before("execution(* com.example.pointcut..*.*(..)) && args(..) && @annotation(getMapping)")
    public void beforeController(GetMapping getMapping) {
        log.info("Called before controller");
    }

    /* Only works on direct annotation, not the inherited one. Use .. for wildcard package. */
//    @Before("execution(* com.example.pointcut.controllers.*.*(..)) && args(..) && @annotation(requestMapping)")
//    public void beforeController(RequestMapping requestMapping) {
//        log.info("Called before controller");
//    }

    /* pjp is implied in args */
    @Around("execution(* com.example.pointcut..*.*(..)) && args(..) && @annotation(getMapping)")
    public Object aroundController(ProceedingJoinPoint pjp, GetMapping getMapping) throws Throwable {
        log.info("Called AROUND controller - before");
        long startTime = System.currentTimeMillis();
        try {
            return pjp.proceed();
        } finally {
            log.info("Called AROUND controller - after. Elapsed " + (System.currentTimeMillis() - startTime) + " ms.");
        }
    }

    @Around("@annotation(timer)")
    public Object aroundAnnotation(ProceedingJoinPoint pjp, Timer timer) throws Throwable {
        log.info("[TIMER] Called AROUND controller - before");
        log.info("Timer value: {}", timer.value());
        long startTime = System.currentTimeMillis();
        try {
            return pjp.proceed();
        } finally {
            log.info("[TIMER] Called AROUND controller - after. Elapsed {} ms.", System.currentTimeMillis() - startTime);
        }
    }
}
