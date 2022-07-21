package com.example.mylibrarytts;

import com.google.gson.Gson;

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
}
