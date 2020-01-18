package io.flutter.plugins;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Base64;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;


/**
 * 使用dart实现，参见 lib/utils/netease_util.dart
 */
@Deprecated
public class NeteaseUtil {

    private static String createSecretKey(int size) {
        String keys = "012345679abcdef";
        StringBuilder key = new StringBuilder();
        for (int i = 0; i < size; i++) {
            int pos = (int) Math.floor(Math.random() * keys.length());
            key.append(keys.charAt(pos));
        }
        return key.toString();
    }

    /**
     * 转十六进制字符串
     * @param text 源字符串
     * @return 十六进制字符串
     */
    private static String hex(String text) {
        String[] split = text.split("");
        String result = "";
        for (String s : split) {
            int ch = (int) s.charAt(0);
            String s4 = Integer.toHexString(ch);
            result = result + s4;
        }
        return result;
    }

    /**
     * 16进制字符串转字节数组
     *
     * @param hexString 源字符串
     * @return 字节数组
     */
    private static byte[] hexToBytes(String hexString) {
        if (hexString == null || hexString.equals("")) {
            return null;
        }

        int length = hexString.length() / 2;
        char[] hexChars = hexString.toCharArray();
        byte[] bytes = new byte[length];
        String hexDigits = "0123456789abcdef";
        for (int i = 0; i < length; i++) {
            int pos = i * 2; // 两个字符对应一个byte
            int h = hexDigits.indexOf(hexChars[pos]) << 4; // 注1
            int l = hexDigits.indexOf(hexChars[pos + 1]); // 注2
            if (h == -1 || l == -1) { // 非16进制字符
                return null;
            }
            bytes[i] = (byte) (h | l);
        }
        return bytes;
    }

    /**
     * 截取长度
     *
     * @param str 原数据
     * @param size 截取长度
     * @return 截取后的结果
     */
    private static String zFill(String str, int size) {
        while (str.length() < size) {
            str = "0" + str;
        }
        return str;
    }


    private static String join(Collection var0, String var1) {
        StringBuffer var2 = new StringBuffer();
        for(Iterator var3 = var0.iterator(); var3.hasNext(); var2.append((String)var3.next())) {
            if (var2.length() != 0) {
                var2.append(var1);
            }
        }
        return var2.toString();
    }

    private static String rsaEncrypt(String text,String pubKey,String modulus){
        List split = Arrays.asList(text.split(""));
        Collections.reverse(split);
        String _text = join(split,"");
        BigInteger biText = new BigInteger(1, _text.getBytes());
        BigInteger biEx = new BigInteger(1,hexToBytes(pubKey));
        BigInteger biMod = new BigInteger(1,hexToBytes(modulus));
        String biRet = biText.modPow(biEx, biMod).toString(16);
        return zFill(biRet, 256);
    }

    /**
     * aes加密
     *
     * @param sSrc 原数据
     * @param sKey 加密key
     * @return 加密结果
     * @throws Exception
     */
    private static String aesEncrypt(String sSrc, String sKey) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        byte[] raw = sKey.getBytes();
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        IvParameterSpec iv = new IvParameterSpec("0102030405060708".getBytes());//使用CBC模式，需要一个向量iv，可增加加密算法的强度
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
        byte[] encrypted = cipher.doFinal(sSrc.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(encrypted);//此处使用BASE64做转码。
    }

    public static Map<String, String> encryptWebApiParam(String param) throws Exception {
        String modulus = "00e0b509f6259df8642dbc35662901477df22677ec152b5ff68ace615bb7b72"
                + "5152b3ab17a876aea8a5aa76d2e417629ec4ee341f56135fccf695280104e0312ecbd"
                + "a92557c93870114af6c9d05c4f7f0c3685b7a46bee255932575cce10b424d813cfe48"
                + "75d3e82047b97ddef52741d546b8e289dc6935b3ece0462db0a22b8e7";
        String nonce = "0CoJUm6Qyw8W8jud";
        String pubKey = "010001";
        String secKey = createSecretKey(16);
        String encText = aesEncrypt(aesEncrypt(param, nonce), secKey);
        String encSecKey = rsaEncrypt(secKey, pubKey, modulus);
        Map<String, String> result = new HashMap<>();
        result.put("params",encText);
        result.put("encSecKey",encSecKey);
        return result;
    }

}
