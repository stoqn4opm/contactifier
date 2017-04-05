//
//  CNContactStore+NameForPhoneNumber.m
//  sampleProject
//
//  Created by Stoyan Stoyanov on 4/5/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "CNContactStore+NameForPhoneNumber.h"
#import "CNContact+HasThisPhone.h"

@implementation CNContactStore (NameForPhoneNumber)

- (NSString *)nameForPhoneNumber:(NSString *)searchedPhone {
    
    NSString __block *result;
    
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactPhoneNumbersKey]];
    [self enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        BOOL hasFoundContact = [contact hasThisPhoneRecord:searchedPhone];
        
        if (hasFoundContact) {
            NSArray *keysToFetch = @[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName]];
            CNContact *fullContact = [self unifiedContactWithIdentifier:contact.identifier keysToFetch:keysToFetch error:nil];
            result = [CNContactFormatter stringFromContact:fullContact style: CNContactFormatterStyleFullName];
            *stop = YES;
        }
    }];
    
    return result;
}

@end
