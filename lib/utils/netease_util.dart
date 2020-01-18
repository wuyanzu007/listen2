import 'dart:convert';
import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:convert/convert.dart';

class NeteaseUtil {
  static String createSecretKey(int size) {
    String keys = "012345679abcdef";
    String secKey = "";
    for (int i = 0; i < size; i++) {
      int pos = (Random().nextDouble() * keys.length).floor();
      secKey += keys[pos];
    }
    return secKey;
  }

  static Future<Map> encryptWebApiParam(String param) async {
    String modulus = "00e0b509f6259df8642dbc35662901477df22677ec152b5ff68ace615bb7b72" +
        "5152b3ab17a876aea8a5aa76d2e417629ec4ee341f56135fccf695280104e0312ecbd" +
        "a92557c93870114af6c9d05c4f7f0c3685b7a46bee255932575cce10b424d813cfe48" +
        "75d3e82047b97ddef52741d546b8e289dc6935b3ece0462db0a22b8e7";
    String nonce = "0CoJUm6Qyw8W8jud";
    String pubKey = "010001";
    String secKey = createSecretKey(16);
    String encText = aesEncrypt(aesEncrypt(param, nonce), secKey);
    String encSecKey = await rsaEncrypt(secKey, pubKey, modulus);
    Map<String, String> result = {};
    result["params"] = encText;
    result["encSecKey"] = encSecKey;
    return result;
  }

  static BigInt decodeBigInt(List<int> bytes) {
    BigInt result = new BigInt.from(0);
    for (int i = 0; i < bytes.length; i++) {
      result += new BigInt.from(bytes[bytes.length - i - 1]) << (8 * i);
    }
    return result;
  }

  static String zFill(String str, int length) {
    while (str.length < length) {
      str = "0" + str;
    }
    return str;
  }

  static Future<String> rsaEncrypt(
      String plainText, String pubKey, String modulus) async {
    List<String> split = plainText.split("");
    List<String> reversed = split.reversed.toList();
    String _text = reversed.join();
    BigInt biText = decodeBigInt(utf8.encode(_text));
    BigInt biEx = decodeBigInt(hex.decode(pubKey));
    BigInt biMod = decodeBigInt(hex.decode(modulus));
    BigInt biRet = biText.modPow(biEx, biMod);
    return zFill(biRet.toRadixString(16), 256);
  }

  static String aesEncrypt(String plainText, String secKey) {
    var key = Key.fromUtf8(secKey);
    var iv = IV.fromUtf8("0102030405060708");
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encryptedStr = encrypter.encrypt(plainText, iv: iv);
    return encryptedStr.base64;
  }
}
