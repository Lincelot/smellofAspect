/*
 * AOPActivity      2016-03-28
 * Copyright (c) 2016 hujiang Co.Ltd. All right reserved(http://www.hujiang.com).
 * 
 */
package com.hujiang.library.demo;

import android.app.Activity;
import android.os.Bundle;
import android.widget.ImageView;

import com.nostra13.universalimageloader.core.ImageLoader;

/**
 * class description here
 *
 * @author simon
 * @version 1.0.0
 * @since 2016-03-28
 */
public class AOPActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.aop_activity_layout);
        ImageView imageView = (ImageView)findViewById(R.id.img_t);
        ImageLoader.getInstance().displayImage("http://cichang.hujiang.com/images/friendquan_share.png", imageView);
    }

    @Override
    protected void onResume() {
        super.onResume();

        new AspectJavaDemo().work();
    }
}