package com.example.mylibrarytts;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import okhttp3.FormBody;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class Auth {
    String url = "http://3.217.215.70:8081/";
    OkHttpClient client = new OkHttpClient();
    public static final MediaType JSON = MediaType.get("application/json; charset=utf-8");
    Gson gson = new Gson();




    public String login(String phoneNumber,String password) throws Exception {
        String LOGIN_END_POINT = "wallet/login";

        RequestBody body = new FormBody.Builder()
                .addEncoded("phone_number", phoneNumber)
                .addEncoded("password",password)
                .build();
        Request request = new Request.Builder()
                .url(url + LOGIN_END_POINT)
                .post(body)
                .build();
        try (Response response = client.newCall(request).execute()) {
            String resp = Objects.requireNonNull(response.body()).string();
        //System.out.println(resp);
            return resp;

        }
    }


    public String register(Map<String, Object> data) throws Exception {
        String REGISTER_END_POINT = "wallet/registration";
        Type gsonType = new TypeToken<HashMap>(){}.getType();

        String gsonString = gson.toJson(data,gsonType);
        RequestBody body = RequestBody.create(JSON, gsonString);
        Request request = new Request.Builder()
                .url(url+REGISTER_END_POINT)
                .post(body)
                .build();

        try (Response response = client.newCall(request).execute()) {


            return Objects.requireNonNull(response.body()).string();
        }

    }
}


