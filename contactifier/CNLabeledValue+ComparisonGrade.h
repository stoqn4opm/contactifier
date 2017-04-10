//
//  CNLabeledValue+ComparisonGrade.h
//  sampleProject
//
//  Created by Stoyan Stoyanov on 4/10/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <Contacts/Contacts.h>

@interface CNLabeledValue (ComparisonGrade)

- (NSNumber *)getPhoneComparisonGradeFor:(NSString *)phone;

@end
