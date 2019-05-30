package com.tencent.bugly.bugly_crash;
import android.util.Log;
/**
 * Description:print log
 * @author rockypzhang
 * @since 2019/5/28
 */
public class BuglyCrashPluginLog{

    private static String TAG = "CrashReport";
    public static boolean isEnable = false;

    public static void d(String content) {
        if (isEnable) {
            Log.d(TAG,content);
        }
    }

}