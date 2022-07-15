package com.example.mylibrarytts;

import java.util.List;
import java.util.Map;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class MyLibTesting {

    OkHttpClient client = new OkHttpClient();


    public String testt(){

       // System.out.println("hhihi");
        return "hihi";
    }

  public String GetMethod(String url) throws Exception {

        Request request = new Request.Builder()
                .url(url)
                .build();

        try (Response response = client.newCall(request).execute()) {
            return response.body().string();

        }
    }

    public String PostUrlEncoded(String url, Map<String,Object> data) throws Exception {



        Request request = new Request.Builder()
                .url(url)
                .build();

        try (Response response = client.newCall(request).execute()) {
            return response.body().string();

        }
    }
}


