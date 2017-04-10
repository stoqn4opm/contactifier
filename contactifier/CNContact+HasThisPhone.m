//
//  CNContact+HasThisPhone.m
//  sampleProject
//
//  Created by Stoyan Stoyanov on 4/5/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "CNContact+HasThisPhone.h"
#import "CNLabeledValue+ComparisonGrade.h"

@implementation CNContact (HasThisPhone)

- (BOOL)hasThisPhoneRecord:(NSString *)searchedPhone {
    BOOL contactIsFound = NO;
    for (CNLabeledValue *phone in [self phoneNumbers]) {
        
        NSString *phoneString = [[phone value] stringValue];
        NSString *phoneNoWhiteSpaceString = [[phoneString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
        
        if ([phoneString isEqualToString:searchedPhone]) {
            contactIsFound = YES;
            break;
        } else if ([phoneNoWhiteSpaceString isEqualToString:searchedPhone]) {
            contactIsFound = YES;
            break;
        }
    }
    return contactIsFound;
}

- (NSNumber *)contactComparisonGradeFor:(NSString *)phoneNumber {
    
    NSString *phoneNumberNoWhiteSpace = [[phoneNumber componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    NSMutableArray<NSNumber *> *grades = [[NSMutableArray alloc] init];
    
    for (CNLabeledValue *phone in [self phoneNumbers]) {
        NSNumber *grade = [phone getPhoneComparisonGradeFor:phoneNumberNoWhiteSpace];
        [grades addObject:grade];
    }
    
    NSNumber *maxGrade = [grades valueForKeyPath:@"@max.doubleValue"];
    return maxGrade;
}

@end
