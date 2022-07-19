package com.example.mylibrarytts;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class MyLibTesting {

    OkHttpClient client = new OkHttpClient();
    public static final MediaType JSON = MediaType.get("application/json; charset=utf-8");
    Gson gson = new Gson();



  public String GetMethod(String url) throws Exception {

        Request request = new Request.Builder()
                .url(url)
                .build();

        try (Response response = client.newCall(request).execute()) {
            return response.body().string();

        }
    }

    public String PostUrlEncoded(String url, Map<String,Object> data) throws Exception {

        Type gsonType = new TypeToken<HashMap>(){}.getType();
        String gsonString = gson.toJson(data,gsonType);
        RequestBody body = RequestBody.create(JSON, gsonString);
        Request request = new Request.Builder()
                .url(url).addHeader("ContentType", "application/x-www-form-urlencoded")
                .post(body)
                .build();


        try (Response response = client.newCall(request).execute()) {
            System.out.println("HIIIIIIIIIIIIIIIIIIIIII");

            return Objects.requireNonNull(response.body()).string();

        }
    }

    public String ShowHistory(String url) throws Exception {

        Request request = new Request.Builder()
                .url(url)
                .build();
        try (Response response = client.newCall(request).execute()) {
            System.out.println("HIIIIIIIIIIIIIIIIIIIIII");

            return Objects.requireNonNull(response.body()).string();

        }

}}


