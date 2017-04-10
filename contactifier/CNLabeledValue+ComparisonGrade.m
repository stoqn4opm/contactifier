//
//  CNLabeledValue+ComparisonGrade.m
//  sampleProject
//
//  Created by Stoyan Stoyanov on 4/10/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "CNLabeledValue+ComparisonGrade.h"
#import "NSString+ReversedChars.h"

@implementation CNLabeledValue (ComparisonGrade)

- (NSNumber *)getPhoneComparisonGradeFor:(NSString *)phoneForEvaluation {
    
    NSString *phoneString = [[self value] stringValue];
    NSString *phoneNoWhiteSpaceString = [[phoneString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    
    NSArray<NSString *> *phoneChars = [phoneNoWhiteSpaceString reversedCharactersArray];
    NSArray<NSString *> *evalChars = [phoneForEvaluation reversedCharactersArray];
    
    double grade = 0.0;
    for (NSInteger i = 0; i < evalChars.count; i++) {
        
        if (!(i < phoneChars.count)) { break; }
        
        if ([evalChars[i] isEqualToString:phoneChars[i]]) {
            grade++;
        } else {
            break;
        }
    }
    
    grade /= phoneForEvaluation.length;
    return @(grade);
}

@end
