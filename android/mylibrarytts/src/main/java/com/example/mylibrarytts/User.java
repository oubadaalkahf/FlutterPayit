package com.example.mylibrarytts;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;


import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class User {

    String url = "http://3.217.215.70:8081/";
    OkHttpClient client = new OkHttpClient();
    public static final MediaType JSON = MediaType.get("application/json; charset=utf-8");
    Gson gson = new Gson();

    public String loadLoggedInUserNative(String phoneNumber) throws Exception {
        String LOAD_USER_PHONE_END_POINT = "wallet/registration/userByphone?phone_number=";

        Request request = new Request.Builder()
                .url(url + LOAD_USER_PHONE_END_POINT + phoneNumber)
                .build();

        try (Response response = client.newCall(request).execute()) {
            return response.body().string();

        }
    }

    public String ShowHistoryEmetteur(String phoneNumber) throws Exception {
        String EMETTEUR_HISTORY = "transferws/showTransactionsEmetteur?phoneNumber=";
        Request request = new Request.Builder()
                .url(url + EMETTEUR_HISTORY+phoneNumber)
                .build();
        try (Response response = client.newCall(request).execute()) {
            return Objects.requireNonNull(response.body()).string();
        }

    }
    public String ShowHistoryDestinataire(String phoneNumber) throws Exception {
        String DESTINATAIRE_HISTORY = "transferws/showTransactionDestinataire?phoneNumber=";
        Request request = new Request.Builder()
                .url(url + DESTINATAIRE_HISTORY+phoneNumber)
                .build();
        try (Response response = client.newCall(request).execute()) {
            return Objects.requireNonNull(response.body()).string();
        }

    }

    public String addFcmTokenToUser(String email, String deviceToken)throws Exception {
        String DEVICE_TOKEN_ENDPOINT = "wallet/registration/fcm_token?user_email=";
        RequestBody body = RequestBody.create(null, new byte[]{});


        Request request = new Request.Builder()
                .url(url + DEVICE_TOKEN_ENDPOINT+email+"&device_token="+deviceToken)
                .post(body)
                .build();
        try (Response response = client.newCall(request).execute()) {
            return Objects.requireNonNull(response.body()).string();
        }
    }

    public String removeFcmToken(String email) throws Exception{
        String REMOVE_DEVICE_TOKEN_ENDPOINT = "wallet/registration/remove_fcm_token?user_email=";
        RequestBody body = RequestBody.create(null, new byte[]{});
        Request request = new Request.Builder()
                .url(url + REMOVE_DEVICE_TOKEN_ENDPOINT+email)
                .post(body)
                .build();
        try (Response response = client.newCall(request).execute()) {
            return Objects.requireNonNull(response.body()).string();
        }
    }

    public String sendOtp(String phoneNumber)throws Exception {
        String SEND_OTP_ENDPOINT = "twilio/sendotp";
        Map<String,Object>data = new HashMap<>();
        data.put("phoneNumber",phoneNumber);
        Type gsonType = new TypeToken<HashMap>(){}.getType();

        String gsonString = gson.toJson(data,gsonType);


        RequestBody body = RequestBody.create(JSON, gsonString);
        Request request = new Request.Builder()
                .url(url+SEND_OTP_ENDPOINT)
                .post(body)
                .build();
        try (Response response = client.newCall(request).execute()) {


            return Objects.requireNonNull(response.body()).string();
        }
    }

    public String verifyOtp(String phoneNumber, String otp) throws Exception{
        String VERIFY_OTP_ENDPOINT = "twilio/verifyotp?";
        Map<String,Object>data = new HashMap<>();
        data.put("phoneNumber",phoneNumber);

        Type gsonType = new TypeToken<HashMap>(){}.getType();

        String gsonString = gson.toJson(data,gsonType);


        RequestBody body = RequestBody.create(JSON, gsonString);
        Request request = new Request.Builder()
                .url(url+VERIFY_OTP_ENDPOINT+"otp="+otp)
                .post(body)
                .build();
        try (Response response = client.newCall(request).execute()) {


            return Objects.requireNonNull(response.body()).string();
        }
    }

    public String makeVersement(String montant, String destinataire, String message)throws Exception {
        String MAKE_VERSEMENT_ENDPOINT = "transferws/do/operation";
        Map<String,Object>data = new HashMap<>();
        data.put("operation_type","versement");
        data.put("montant",montant);
        data.put("destinataire",destinataire);
        data.put("message",message);
        Type gsonType = new TypeToken<HashMap>(){}.getType();
        String gsonString = gson.toJson(data,gsonType);
        RequestBody body = RequestBody.create(JSON, gsonString);
        Request request = new Request.Builder()
                .url(url+MAKE_VERSEMENT_ENDPOINT)
                .put(body)
                .build();
        try (Response response = client.newCall(request).execute()) {


            return Objects.requireNonNull(response.body()).string();
        }

    }

    public  Map<String,String> getSessionId() throws Exception {
        String SESSIONID_ENDPOINT = "wallet/registration/session";

        Request request = new Request.Builder()
                .url(url + SESSIONID_ENDPOINT)
                .get()
                .build();
        try (Response response = client.newCall(request).execute()) {
            Map<String,String> data = new HashMap<String,String>();
            data.put("header",response.headers().get("Set-Cookie"));
           data.put("sessionId",Objects.requireNonNull(response.body()).string());
            return data;
        }
    }






}
