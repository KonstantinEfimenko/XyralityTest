//
//  WorldsCollection.h
//  XyralityTest
//
//  Created by Konstantin Efimenko on 10/19/16.
//  Copyright © 2016 Efimenko Ink. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Local notification name in case of worlds list was changed
#define XyralityTestWorldsListContentWasChanged @"XyralityTestWorldsListContentWasChanged"

@interface WorldsCollection : NSObject

@property (readonly) NSArray *worlds;

+ (WorldsCollection*)sharedInstance;

- (void)loginWithLogin:(NSString*)login password:(NSString*)password callback:(void (^)(NSError*))callback;

@end
