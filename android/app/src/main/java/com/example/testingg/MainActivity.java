package com.example.testingg;

import android.os.StrictMode;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import com.example.mylibrarytts.MyLibTesting;

import java.io.IOException;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/battery";


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);

        super.configureFlutterEngine(flutterEngine);
        String url ="http://3.217.215.70:8081/wallet/registration/userByphone?phone_number=0626708079";

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("testMyMesthode")){
                                String myLibTesting = null;
                                try {
                                    myLibTesting = new MyLibTesting().run(url);
                                    result.success(myLibTesting);
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }

                            }
                        }
                );

}}



