//
//  AXCViewController.m
//  Prospect POC
//
//  Created by Steven Jordan Kozmary on 12/6/14.
//  Copyright (c) 2014 HCL. All rights reserved.
//

#import "AXCViewController.h"
#import <ADALiOS/ADAuthenticationContext.h>

@interface AXCViewController ()

@end

@implementation AXCViewController
{
    ADAuthenticationContext *authContext;
    NSString *authority;
    NSString *redirectURIString;
    NSString *resourceID;
    NSString *clientID;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    authority = @"https://login.windows.net/contoso.com";
    redirectURIString = @"https://androidauthpoc.azure-mobile.net/";
    
//    [self getToken:NO completionHandler:nil];
}

- (void)getToken:(BOOL)clearCache completionHandler:(void (^) (NSString*))completionBlock
{
    ADAuthenticationError *error;
    authContext = [ADAuthenticationContext authenticationContextWithAuthority:authority error:&error];
    
    NSURL *redirectURI = [NSURL URLWithString:redirectURIString];
    
    if(clearCache)
    {
        [authContext.tokenCacheStore removeAllWithError:&error];
    }
    
    [authContext acquireTokenWithResource:resourceID clientId:clientID redirectUri:redirectURI completionBlock:^(ADAuthenticationResult *result) {
        if(AD_SUCCEEDED != result.status){
            //display error on screen
//            [self showError:result.error.errorDetails];
            NSLog(@"%@",result.error.errorDetails);
        }
        else{
            completionBlock(result.accessToken);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
