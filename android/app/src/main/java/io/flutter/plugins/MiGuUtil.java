package io.flutter.plugins;

import java.security.DigestException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class MiGuUtil {

    public static Map<String,String> generateKeyAndIV(String secret){
        final int keyLength = 32;
        final int SaltSize = 64 / 8;
        final int ivLength = 16;
        final int iterations = 1;
        final byte[] salt = Arrays.copyOf("12345678".getBytes(), SaltSize);
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        int digestLength = md.getDigestLength();
        int requiredLength = (keyLength + ivLength + digestLength - 1) / digestLength * digestLength;
        byte[] generatedData = new byte[requiredLength];
        int generatedLength = 0;
        try {
            md.reset();
            while (generatedLength < keyLength + ivLength) {
                if (generatedLength > 0)
                    md.update(generatedData, generatedLength - digestLength, digestLength);
                md.update(secret.getBytes());
                if (salt != null)
                    md.update(salt, 0, 8);
                md.digest(generatedData, generatedLength, digestLength);
                for (int i = 1; i < iterations; i++) {
                    md.update(generatedData, generatedLength, digestLength);
                    md.digest(generatedData, generatedLength, digestLength);
                }
                generatedLength += digestLength;
            }
            Map<String, String> keyAndIv = new HashMap<>();
            String key = Base64.getEncoder().encodeToString(Arrays.copyOfRange(generatedData, 0, keyLength));
            String iv = Base64.getEncoder().encodeToString(Arrays.copyOfRange(generatedData, keyLength, keyLength + ivLength));
            keyAndIv.put("key", key);
            keyAndIv.put("iv", iv);
            return keyAndIv;
        } catch (DigestException e) {
            throw new RuntimeException(e);
        } finally {
            Arrays.fill(generatedData, (byte) 0);
        }
    }


}
