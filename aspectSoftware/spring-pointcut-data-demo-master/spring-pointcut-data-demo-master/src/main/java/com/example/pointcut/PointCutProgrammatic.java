package com.example.pointcut;

import lombok.extern.slf4j.Slf4j;
import org.aopalliance.intercept.MethodInterceptor;
import org.springframework.aop.Advisor;
import org.springframework.aop.aspectj.AspectJExpressionPointcut;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class PointCutProgrammatic {

    // See: https://stackoverflow.com/questions/24785423/using-methodinterceptor-in-spring
    @Bean
    public Advisor myAdvisor() {
        AspectJExpressionPointcut pointcut = new AspectJExpressionPointcut();
        pointcut.setExpression("execution(* com.example.pointcut..*.*(..)) && @annotation(org.springframework.web.bind.annotation.GetMapping)");
        return new DefaultPointcutAdvisor(pointcut, (MethodInterceptor) methodInvocation -> {
            log.info("[PROGRAMMATIC] Called AROUND controller - before");
            long startTime = System.currentTimeMillis();
            try {
                return methodInvocation.proceed();
            } finally {
                log.info("[PROGRAMMATIC] Called AROUND controller - after. Elapsed " + (System.currentTimeMillis() - startTime) + " ms.");
            }
        });
    }
}
