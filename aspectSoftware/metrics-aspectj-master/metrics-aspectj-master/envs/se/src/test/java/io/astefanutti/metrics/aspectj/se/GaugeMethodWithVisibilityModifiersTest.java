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
package io.astefanutti.metrics.aspectj.se;

import com.codahale.metrics.Gauge;
import com.codahale.metrics.MetricRegistry;
import com.codahale.metrics.SharedMetricRegistries;
import io.astefanutti.metrics.aspectj.se.util.MetricsUtil;
import org.hamcrest.Matchers;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.util.Set;

import static org.fest.reflect.core.Reflection.method;
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertThat;

public class GaugeMethodWithVisibilityModifiersTest {

    private final static String REGISTRY_NAME = "visibilityGaugeRegistry";

    private final static String[] GAUGE_NAMES = {"publicGaugeMethod", "packagePrivateGaugeMethod", "protectedGaugeMethod", "privateGaugeMethod"};

    private GaugeMethodWithVisibilityModifiers instance;

    private Set<String> absoluteMetricNames() {
        return MetricsUtil.absoluteMetricNames(GaugeMethodWithVisibilityModifiers.class, GAUGE_NAMES);
    }

    @Before
    public void createGaugeInstance() {
        instance = new GaugeMethodWithVisibilityModifiers();
    }

    @After
    public void clearSharedMetricRegistries() {
        SharedMetricRegistries.clear();
    }

    @Test
    public void gaugesCalledWithDefaultValues() {
        assertThat("Shared metric registry is not created", SharedMetricRegistries.names(), hasItem(REGISTRY_NAME));
        MetricRegistry registry = SharedMetricRegistries.getOrCreate(REGISTRY_NAME);
        assertThat("Gauges are not registered correctly", registry.getGauges().keySet(), is(equalTo(absoluteMetricNames())));

        // Make sure that the gauges have the expected values
        assertThat("Gauge values are incorrect", registry.getGauges().values(), everyItem(Matchers.<Gauge>hasProperty("value", equalTo(0L))));
    }

    @Test
    public void callGaugesAfterSetterCalls() {
        assertThat("Shared metric registry is not created", SharedMetricRegistries.names(), hasItem(REGISTRY_NAME));
        MetricRegistry registry = SharedMetricRegistries.getOrCreate(REGISTRY_NAME);
        assertThat("Gauges are not registered correctly", registry.getGauges().keySet(), is(equalTo(absoluteMetricNames())));

        long value = Math.round(Math.random() * Long.MAX_VALUE);
        // Call the setter methods
        instance.setPublicGauge(value);
        instance.setPackagePrivateGauge(value);
        instance.setProtectedGauge(value);
        method("setPrivateGauge").withParameterTypes(long.class).in(instance).invoke(value);

        // And assert the gauges are up-to-date
        assertThat("Gauge values are incorrect", registry.getGauges().values(), everyItem(Matchers.<Gauge>hasProperty("value", equalTo(value))));
    }
}
