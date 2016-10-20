//
//  WorldsCollection.m
//  XyralityTest
//
//  Created by Konstantin Efimenko on 10/19/16.
//  Copyright © 2016 Efimenko Ink. All rights reserved.
//

#import "WorldsCollection.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "AppDelegate.h"

#define kAuthorizationUrl [NSURL URLWithString:@"http://backend1.lordsandknights.com/XYRALITY/WebObjects/BKLoginServer.woa"]

@implementation WorldsCollection
{
    AFHTTPSessionManager *manager;
}


+ (WorldsCollection*)sharedInstance{
    static WorldsCollection *worldsCollection = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        worldsCollection = [[self alloc] init];
    });
    return worldsCollection;
}


- (void)loginWithLogin:(NSString*)login password:(NSString*)password callback:(void (^)(NSError*))callback{
    
    if(![AFNetworkReachabilityManager sharedManager].reachable){
        [self showAlert:@"No internet connection"];
        callback([NSError errorWithDomain:@"com.efimenko.error.no_internet_connection" code:NSURLErrorNotConnectedToInternet userInfo:@{@"description":@"No internet connection"}]);
        return;
    }
    
    NSString *deviceType = [NSString stringWithFormat:@"%@ - %@%@",
                            [[UIDevice currentDevice] model],
                            [[UIDevice currentDevice] systemName],
                            [[UIDevice currentDevice] systemVersion]];
    NSString *deviceId = [[NSUUID UUID] UUIDString];
    NSDictionary *parameters = @{@"login":login,
                                 @"password":password,
                                 @"deviceType":deviceType,
                                 @"deviceId":deviceId};
    if(!manager){
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:kAuthorizationUrl];
        manager.responseSerializer = [AFPropertyListResponseSerializer serializer];
    }
    [manager POST:@"wa/worlds" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        _worlds = responseObject[@"allAvailableWorlds"];
        if(_worlds){
            callback(nil);
        }else{
            _worlds = @[];
            [self showAlert:@"allAvailableWorlds field not exists in response"];
            callback([NSError errorWithDomain:@"com.efimenko.error.no_worlds_field" code:-100 userInfo:@{@"description":@"allAvailableWorlds field not exists in response"}]);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:XyralityTestWorldsListContentWasChanged object:self];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(error);
    }];
}


- (void)showAlert:(NSString*)message{
    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(message,nil) preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];

    [[AppDelegate topViewController] presentViewController:alertController animated:YES completion:nil];
}

@end
