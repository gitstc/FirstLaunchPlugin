//
//  applicationPreferences.m
//  
//
//  Created by Tue Topholm on 31/01/11.
//  Copyright 2011 Sugee. All rights reserved.
//
// THIS HAVEN'T BEEN TESTED WITH CHILD PANELS YET.

#import "FirstLaunchPlugin.h"
#import <Cordova/CDV.h>

@implementation FirstLaunchPlugin
@synthesize callbackId;

-(void) isFirstLaunch:(CDVInvokedUrlCommand*)command;
{
    self.callbackId = command.callbackId;

	CDVPluginResult *result = nil;
    
    @try
    {
        // Get current version ("Bundle Version") from the default Info.plist file
        NSString *currentVersion = (NSString*)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        NSArray *prevStartupVersions = [[NSUserDefaults standardUserDefaults] arrayForKey:@"prevStartupVersions"];
        if (prevStartupVersions == nil) 
        {
            // Starting up for first time with NO pre-existing installs (e.g., fresh 
            // install of some version)
            result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool:YES];
            [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:currentVersion] forKey:@"prevStartupVersions"];
        }
        else
        {
            if (![prevStartupVersions containsObject:currentVersion]) 
            {
                // Starting up for first time with this version of the app. This
                // means a different version of the app was alread installed once 
                // and started.
                result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool:YES];
                NSMutableArray *updatedPrevStartVersions = [NSMutableArray arrayWithArray:prevStartupVersions];
                [updatedPrevStartVersions addObject:currentVersion];
                [[NSUserDefaults standardUserDefaults] setObject:updatedPrevStartVersions forKey:@"prevStartupVersions"];
            }
			else
			{
				result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool:NO];
			}
        }

        // Save changes to disk
        [[NSUserDefaults standardUserDefaults] synchronize];
		[self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    }
    @catch(NSException* e)
    {
        result = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR messageAsString:[NSString stringWithFormat:@"%@",[e reason]]];
    	[self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    }
}

@end