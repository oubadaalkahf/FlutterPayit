package com.example.mylibrarytts;

import android.util.Base64;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.IOException;
import java.lang.reflect.Type;
import java.security.Key;
import java.security.MessageDigest;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
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
    static byte[] iv = hexStringToByteArray("48E53E0639A76C5A5E0C5BC9E3A91538");


    public String login(String phoneNumber,String password,String session,String header) throws Exception {
        System.out.println(phoneNumber);
        System.out.println(password);
        System.out.println(header);
        System.out.println(session);


        // STEP 1 :  PASSWORD TO SHA1
       MessageDigest mDigest = MessageDigest.getInstance("SHA1");
        byte[] result = mDigest.digest(password.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < result.length; i++) {
            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
        }
        session = session.replaceAll("-","");
        session = session.replaceAll("/","");

        session = session.replaceAll("_","");
        session = session.substring(0,32);
        System.out.println(session);
        //STEP 2 : PASSWORD ecnrypted with session
        Key secretKey = parseSecretKey(session);


        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKey, new IvParameterSpec(iv));
        byte[] encryptedMessage = cipher.doFinal(sb.toString().getBytes());

        String encryptedByteValue   = Base64.encodeToString(encryptedMessage, Base64.NO_WRAP);

    System.out.println(encryptedByteValue);

        String LOGIN_END_POINT = "wallet/login";

        RequestBody body = new FormBody.Builder()
                .addEncoded("phoneNumber", phoneNumber)
                .addEncoded("password",encryptedByteValue)
                .build();
    //ZEDT HADI
        System.out.println(header);
        //mjkhjfgdfsfghjkl
        Request request = new Request.Builder()

                .url(url + LOGIN_END_POINT)

                .post(body)
                .addHeader("Cookie", header)
                .build();
        System.out.println(request.toString());
        try (Response response = client.newCall(request).execute()) {
            String resp = Objects.requireNonNull(response.body()).string();
        System.out.println(resp);
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

    public static byte[] hexStringToByteArray(String s) {
        int len = s.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                    + Character.digit(s.charAt(i+1), 16));
        }
        return data;
    }
    public static byte[] stringToByteArray(String hexaString) throws ParseException {
        // the padding shouldn't be used, so a random one was chosen
        return stringToByteArray(hexaString, hexaString.length() / 2, (byte) 0xFF);
    }

    public static byte[] stringToByteArray(String hexaString, int resultArraySize, byte padding) throws ParseException {
        final int HEXA_RADIX = 36;
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

}


