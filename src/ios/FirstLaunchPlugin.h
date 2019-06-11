//
//  applicationPreferences.h
//  
//
//  Created by Tue Topholm on 31/01/11.
//  Copyright 2011 Sugee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Cordova/CDVPlugin.h>

@interface FirstLaunchPlugin : CDVPlugin 
{

}

@property (nonatomic, copy) NSString* callbackId;

-(void) isFirstLaunch:(CDVInvokedUrlCommand*)command;

@end