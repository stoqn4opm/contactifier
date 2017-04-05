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

- (void)nameForPhoneNumber:(NSString *)searchedPhone withCompletion:(void (^)(NSString *))completionBlock {
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        BOOL __block hasFoundContact = NO;
        CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactPhoneNumbersKey]];
        [self enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            
            hasFoundContact = [contact hasThisPhoneRecord:searchedPhone];
            
            if (hasFoundContact) {
                NSError *error;
                NSArray *keysToFetch = @[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName]];
                CNContact *fullContact = [self unifiedContactWithIdentifier:contact.identifier keysToFetch:keysToFetch error:&error];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completionBlock) {
                        if (error) {
                            completionBlock(nil);
                        }
                        else {
                            NSString *foundedName = [CNContactFormatter stringFromContact:fullContact style: CNContactFormatterStyleFullName];
                            completionBlock(foundedName);
                        }
                    }
                });
                *stop = YES;
            }
        }];
        
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!hasFoundContact) {
                    completionBlock(nil);
                }
            });
        }
    });
}

@end
