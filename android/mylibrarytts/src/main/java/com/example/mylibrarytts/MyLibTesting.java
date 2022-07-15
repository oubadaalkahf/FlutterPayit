package com.example.mylibrarytts;

import android.os.AsyncTask;
import android.os.StrictMode;

import java.io.IOException;
import java.util.HashMap;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class MyLibTesting {

    OkHttpClient client = new OkHttpClient();


    public String testt(){

       // System.out.println("hhihi");
        return "hihi";
    }

  public  String run(String url) throws IOException {

        Request request = new Request.Builder()
                .url(url)
                .build();

        try (Response response = client.newCall(request).execute()) {

            return response.body().string();
        }
    }


}


