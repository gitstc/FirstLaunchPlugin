package org.stc.applicationPreferences;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
 
import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;
 
public class applicationPreferences extends CordovaPlugin {
 
    public static final String LOG_PROV = "PhoneGapLog";
	public static final String LOG_NAME = "applicationPreferences Plugin";
 
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
		try {
            Context context=this.cordova.getActivity().getApplicationContext();

			if (action.equals("isFirstLaunch")){

                SharedPreferences sharedPref = context.getSharedPreferences("Recipes",context.MODE_PRIVATE);

				String app_version = context.getPackageManager().getPackageInfo(context.getPackageName(), 0).versionName;
                String saved_version = sharedPref.getString("app_version","");

                SharedPreferences.Editor prefEditor = sharedPref.edit();

                if(sharedPref.getString("app_version","").equals("")){
                    //First Launch
                    prefEditor.putString("app_version",app_version);
                    
                    callbackContext.success("true");
                }
                else{
                    double d_app_version = Double.parseDouble(app_version);
                    double d_saved_version = Double.parseDouble(saved_version);

                    if(d_saved_version < d_app_version){
                        //First Launch
                        prefEditor.putString("app_version",app_version);
                    
                        callbackContext.success("true");
                    }
                    else{
                        //Not first launch

                        callbackContext.success("false");
                    }
                }
                prefEditor.apply();
			}
			else{
                callbackContext.error("");
				return false;
			}
		} catch (Exception e) {
            callbackContext.error(e.getMessage());
            return false;
		}

        return false;
	}
}