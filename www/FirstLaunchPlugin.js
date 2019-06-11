var FirstLaunchPlugin = {
    isFirstLaunch: function(success,fail){
        cordova.exec(function(isFL){
            if($.type(isFL) === "undefined"){
                success ? success(true) : false;
                return;
            }
            
            if($.type(isFL) === "string"){
                if(isFL === "true"){
                    isFL = true;
                }
                else{
                    isFL = false;
                }
            }
            
            success ? success(isFL) : false;
            
        }, fail, "FirstLaunchPlugin", "isFirstLaunch", []);
    }
};

module.exports = FirstLaunchPlugin;