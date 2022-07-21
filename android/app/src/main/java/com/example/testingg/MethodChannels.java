package com.example.testingg;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MethodChannels {
    private static final String USERCHANNEL = "payit/user";
    private static final String AuthCHANNEL = "payit/auth";
    private static final String HistoryCHANNEL = "payit/history";
    AppRepository repository = new AppRepository();


//USER CHANNEL
    public void userChannel(@NonNull FlutterEngine flutterEngine){
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), USERCHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            switch (call.method)
                            {
                                case "loadLoggedInUserNative" : repository.loadUser(call,result);
                                        break;
                                case  "addTokenToUser" :        repository.addTokenToUser(call,result);
                                        break;
                                case "removeFcmToken" : repository.removeFcmToken(call,result);
                                        break;
                            }

                        }
                );
    }
    //HISTORY CHANNEL
    public void historyChannel(@NonNull FlutterEngine flutterEngine){
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), HistoryCHANNEL)
                .setMethodCallHandler(
                        (call, result)  -> {

                            if (call.method.equals("showHistoryEmetteur")){
                                repository.showEmetteurHistory(call,result);
                            }
                              else

                            if(call.method.equals("showHistoryDestinataire")){
                                repository.showDestinataireHistory(call,result);
                            }


                        }
                );
    }

    //AUTH CHANNEL
    public void authChannel(@NonNull FlutterEngine flutterEngine){
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), AuthCHANNEL)
                .setMethodCallHandler(
                        (call, result)  -> {
                            if (call.method.equals("loginNative")){
                                  repository.login(call,result);
                            }
                            else
                                if(call.method.equals("registerNative")){
                                    System.out.println("hello");
                                    repository.register(call,result);
                                }
                        }
                );
    }
}
