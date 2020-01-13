package com.wuyanzu007.listen2;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.MiGuUtil;
import io.flutter.plugins.NeteaseUtil;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "com.wuyanzu007.listen2/encrypt";


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                (call, result) -> {
                    switch (call.method){
                        case "miGuGenerateKeyAndIV":
                            String secret = call.argument("secret");
                            Map keyAndIV = MiGuUtil.generateKeyAndIV(secret);
                            result.success(keyAndIV);
                            break;
                        case "encryptNeteaseParam":
                            String param = call.argument("param");
                            try {
                                Map encrypted = NeteaseUtil.encryptWebApiParam(param);
                                result.success(encrypted);
                                break;
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        default:
                            result.notImplemented();

                    }
                }
        );
    }
}
