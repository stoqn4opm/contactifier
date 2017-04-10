//
//  ContactsLookupManager.h
//  sampleProject
//
//  Created by Stoyan Stoyanov on 4/6/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsLookupManager : NSObject
+ (instancetype)sharedInstance;

- (NSString *)contactNameFromPhone:(NSString *)phone;

@property (nonatomic, assign) BOOL closeMatchesOn;
@property (nonatomic, strong) NSNumber *closeMatchesThreshold;

@end
