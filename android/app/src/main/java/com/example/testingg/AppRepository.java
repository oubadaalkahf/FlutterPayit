package com.example.testingg;

import androidx.annotation.NonNull;

import com.example.mylibrarytts.Auth;
import com.example.mylibrarytts.User;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AppRepository {

    public void loadUser(@NonNull MethodCall call, MethodChannel.Result result){
        String phoneNumber = call.argument("phoneNumber");

        try {
            String user = new User().loadLoggedInUserNative(phoneNumber);

            result.success(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void showEmetteurHistory(@NonNull MethodCall call, MethodChannel.Result result){
        String phoneNumber = call.argument("phoneNumber");
        try {
            String    emetteurHistory = new User().ShowHistoryEmetteur(phoneNumber);
            result.success(emetteurHistory);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void login(@NonNull MethodCall call, MethodChannel.Result result){
        String phoneNumber = call.argument("phoneNumber");
        String password = call.argument("password");




        try {

            String  loginResp = new Auth().login(phoneNumber,password);

            result.success(loginResp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void showDestinataireHistory(@NonNull MethodCall call, MethodChannel.Result result) {
        String phoneNumber = call.argument("phoneNumber");
        try {
            String destinataireHistory = new User().ShowHistoryDestinataire(phoneNumber);
            result.success(destinataireHistory);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void register(@NonNull MethodCall call, MethodChannel.Result result) {

        String email = call.argument("email");
        String phoneNumber = call.argument("phoneNumber");
        String password = call.argument("password");
        String firstName = call.argument("firstName");
        String lastName = call.argument("lastName");
        String cin = call.argument("cin");

        Map<String,Object>data = new HashMap<>();
        data.put("email",email);
        data.put("password",password);
        data.put("firstName",firstName);
        data.put("lastName",lastName);
        data.put("phoneNumber",phoneNumber);
        data.put("cin",cin);

        try{
            String signupResp= new Auth().register(data);
            result.success(signupResp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addTokenToUser(@NonNull MethodCall call, MethodChannel.Result result) {
        String email = call.argument("email");
        String deviceToken = call.argument("deviceToken");
        try{
            String deviceTokenResp= new User().addFcmTokenToUser(email,deviceToken);
            result.success(deviceTokenResp);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public void removeFcmToken(MethodCall call, MethodChannel.Result result) {
        String email = call.argument("email");

        try{
            String removeFcmToken= new User().removeFcmToken(email);
            result.success(removeFcmToken);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
