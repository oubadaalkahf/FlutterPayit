package com.example.mylibrarytts;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.IOException;
import java.lang.reflect.Type;
import java.security.Key;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

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
    private static final String CIPHER_ALGORITHM = "AES/CBC/ISO10126PADDING";



    public String login(String phoneNumber,String password,String sessionId) throws Exception {
        String LOGIN_END_POINT = "wallet/login";
        Key secretKey = parseSecretKey(sessionId);
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);

        byte[] encryptedMessage = cipher.doFinal(password.getBytes());
        byte[] encryptedByteValue = new Base64().encode(encryptedMessage);
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

    public static SecretKey parseSecretKey(String secretKey) throws ParseException {
        return new SecretKeySpec(stringToByteArray(secretKey), "AES");
    }
    public static byte[] stringToByteArray(String hexaString, int resultArraySize, byte padding) throws ParseException {
        final int HEXA_RADIX = 16;
        int length = hexaString.length();
        if (length % 2 == 0) {
            length /= 2;
            if (length <= resultArraySize) {
                byte[] numbers = new byte[resultArraySize];
                int i;
                // filling the array
                for (i = 0; i < length; i++) {
                    // the following line will trigger a NumberFormatException if str contains a non
                    // 0-9 A-F character
                    try {
                        int j = Integer.parseInt(hexaString.substring(2 * i, 2 * i + 2), HEXA_RADIX);
                        numbers[i] = (byte) (j & 0xFF);
                    } catch (NumberFormatException ex) {
                        throw new ParseException(ex.getMessage(), i);
                    }
                }
                // padding
                for (; i < resultArraySize; i++) {
                    numbers[i] = padding;
                }
                return numbers;
            } else {
                throw new ParseException(
                        "the resulting array size is too big compared to the min size specified in the parameters", 0);
            }
        } else {
            throw new ParseException("string length must be even", 0);
        }
    }
    public static byte[] stringToByteArray(String hexaString) throws ParseException {
        // the padding shouldn't be used, so a random one was chosen
        return stringToByteArray(hexaString, hexaString.length() / 2, (byte) 0xFF);
    }

}


