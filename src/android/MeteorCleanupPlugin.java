package me.tonny.cordova.meteorcleanup;

import android.content.Context;
import android.util.Log;

import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import android.preference.PreferenceManager;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.pm.PackageManager;

import java.io.File;

public class MeteorCleanupPlugin extends CordovaPlugin {


    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {

        PackageManager packageManager = this.cordova.getActivity().getPackageManager();
        String version;
        try {
            version = packageManager.getPackageInfo(this.cordova.getActivity().getPackageName(), 0).versionName;
        } catch (Exception e) {
            return;
        }
        String key = "esportsplus_mcp_version_mark_" + version;

        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(cordova.getActivity());
        if (!sharedPrefs.contains(key)) {
            Context context = cordova.getActivity();
            String dataDirectory = context.getFilesDir().toString();
            String meteorVersion = dataDirectory + "/meteor/version";

            try {
                File mvf = new File(meteorVersion);
                boolean noError = true;
                if (mvf.exists()) {
                    noError = mvf.delete();
                }
                if (noError) {
                    Editor editor = sharedPrefs.edit();
                    editor.putString(key, "marked");
                    editor.commit();
                }
            } catch (Exception e) {
                Log.d("MeteorCleanupPlugin", "Error while check meteor version files");
            }
        }
        super.initialize(cordova, webView);
    }

}
