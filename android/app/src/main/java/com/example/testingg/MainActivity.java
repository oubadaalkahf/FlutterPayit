package com.example.testingg;

import android.os.StrictMode;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import okhttp3.ResponseBody;

import com.example.mylibrarytts.MyLibTesting;

import org.json.JSONObject;

import java.io.IOException;

public class MainActivity extends FlutterActivity {
    private static final String LoadUserCHANNEL = "payit/loadUser";
    private static final String LoginCHANNEL = "payit/login";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);

        super.configureFlutterEngine(flutterEngine);
        String url ="http://3.217.215.70:8081/wallet/registration/";

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), LoadUserCHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("loadLoggedInUserNative")){
                                String phoneNumber = call.argument("phoneNumber");
                                String user = null;
                                try {
                                    user = new MyLibTesting().GetMethod(url+"userByphone?phone_number="+phoneNumber);
                                    System.out.println(url);
                                    result.success(user);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                            }
                        }
                );

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), LoginCHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("loginNative")){
                                String phoneNumber = call.argument("phoneNumber");
                                String password = call.argument("password");
                                String loginResp = null;
                                try {
                                    loginResp = new MyLibTesting().GetMethod(url+"userByphone?phone_number="+phoneNumber);
                                    System.out.println(url);
                                    result.success(loginResp);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                            }
                        }
                );



    }

}



