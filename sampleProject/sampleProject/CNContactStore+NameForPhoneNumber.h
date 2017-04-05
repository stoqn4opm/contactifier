//
//  CNContactStore+NameForPhoneNumber.h
//  sampleProject
//
//  Created by Stoyan Stoyanov on 4/5/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <Contacts/Contacts.h>

@interface CNContactStore (NameForPhoneNumber)
- (void)nameForPhoneNumber:(NSString *)searchedPhone withCompletion:(void (^)(NSString *))completionBlock;
@end
