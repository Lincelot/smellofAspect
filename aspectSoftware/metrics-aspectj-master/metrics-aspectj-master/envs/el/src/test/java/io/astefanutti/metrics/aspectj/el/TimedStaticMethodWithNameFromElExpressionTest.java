/**
 * Copyright © 2013 Antonin Stefanutti (antonin.stefanutti@gmail.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package io.astefanutti.metrics.aspectj.el;

import com.codahale.metrics.MetricRegistry;
import com.codahale.metrics.SharedMetricRegistries;
import com.codahale.metrics.Timer;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Test;

import java.util.concurrent.atomic.AtomicLong;

import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertThat;

public class TimedStaticMethodWithNameFromElExpressionTest {

    private final static String REGISTRY_NAME = "timerStaticWithElRegistry";

    private final static String TIMER_NAME = MetricRegistry.name(TimedStaticMethodWithNameFromElExpression.class, "timer " + TimedStaticMethodWithNameFromElExpression.ID);

    private final static AtomicLong TIMER_COUNT = new AtomicLong();

    @AfterClass
    public static void clearSharedMetricRegistries() {
        SharedMetricRegistries.clear();
    }

    @Test
    public void callExpressionTimedStaticMethodOnce() {
        // Call the timed static method and assert it's been timed once
        TimedStaticMethodWithNameFromElExpression.expressionStaticTimedMethod();

        assertThat("Shared metric registry is not created", SharedMetricRegistries.names(), hasItem(REGISTRY_NAME));
        MetricRegistry registry = SharedMetricRegistries.getOrCreate(REGISTRY_NAME);

        assertThat("Timer is not registered correctly", registry.getTimers(), hasKey(TIMER_NAME));
        Timer timer = registry.getTimers().get(TIMER_NAME);

        assertThat("Timer count is incorrect", timer.getCount(), is(equalTo(TIMER_COUNT.incrementAndGet())));
    }

    @Test
    public void callCompositeExpressionTimedStaticMethodOnce() {
        // Call the timed static method and assert it's been timed once
        TimedStaticMethodWithNameFromElExpression.compositeExpressionStaticTimedMethod();

        assertThat("Shared metric registry is not created", SharedMetricRegistries.names(), hasItem(REGISTRY_NAME));
        MetricRegistry registry = SharedMetricRegistries.getOrCreate(REGISTRY_NAME);

        assertThat("Timer is not registered correctly", registry.getTimers(), hasKey(TIMER_NAME));
        Timer timer = registry.getTimers().get(TIMER_NAME);

        assertThat("Timer count is incorrect", timer.getCount(), is(equalTo(TIMER_COUNT.incrementAndGet())));
    }

    @Test
    public void callLambdaExpressionTimedStaticMethodOnce() {
        // Call the timed static method and assert it's been timed once
        TimedStaticMethodWithNameFromElExpression.lambdaExpressionStaticTimedMethod();

        assertThat("Shared metric registry is not created", SharedMetricRegistries.names(), hasItem(REGISTRY_NAME));
        MetricRegistry registry = SharedMetricRegistries.getOrCreate(REGISTRY_NAME);

        assertThat("Timer is not registered correctly", registry.getTimers(), hasKey(TIMER_NAME));
        Timer timer = registry.getTimers().get(TIMER_NAME);

        assertThat("Timer count is incorrect", timer.getCount(), is(equalTo(TIMER_COUNT.incrementAndGet())));
    }
}
