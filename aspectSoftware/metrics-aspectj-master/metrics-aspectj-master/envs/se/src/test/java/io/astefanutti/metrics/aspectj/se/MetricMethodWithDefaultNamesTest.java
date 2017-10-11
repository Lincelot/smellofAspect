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

import com.codahale.metrics.MetricRegistry;
import com.codahale.metrics.SharedMetricRegistries;
import io.astefanutti.metrics.aspectj.se.util.MetricsUtil;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.util.Arrays;
import java.util.Set;

import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertThat;

public class MetricMethodWithDefaultNamesTest {

    private final static String REGISTRY_NAME = "defaultNameRegistry";

    private final static String[] METRIC_NAMES = {"defaultNameTimedMethod", "defaultNameMeteredMethod", "defaultNameExceptionMeteredMethod.exceptions"};

    private final static String[] ABSOLUTE_METRIC_NAMES = {"absoluteDefaultNameTimedMethod", "absoluteDefaultNameMeteredMethod", "absoluteDefaultNameExceptionMeteredMethod.exceptions"};

    private MetricMethodWithDefaultNames instance;

    private Set<String> metricNames() {
        Set<String> names = MetricsUtil.absoluteMetricNames(MetricMethodWithDefaultNames.class, METRIC_NAMES);
        names.addAll(Arrays.asList(ABSOLUTE_METRIC_NAMES));
        return names;
    }

    @Before
    public void createMetricInstance() {
        instance = new MetricMethodWithDefaultNames();
    }

    @After
    public void clearSharedMetricRegistries() {
        SharedMetricRegistries.clear();
    }

    @Test
    public void metricMethodsWithDefaultNamingConvention() {
        assertThat("Shared metric registry is not created", SharedMetricRegistries.names(), hasItem(REGISTRY_NAME));
        MetricRegistry registry = SharedMetricRegistries.getOrCreate(REGISTRY_NAME);
        assertThat("Metrics are not registered correctly", registry.getMetrics().keySet(), is(equalTo(metricNames())));
    }
}
