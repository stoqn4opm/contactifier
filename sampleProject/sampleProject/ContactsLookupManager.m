//
//  ContactsLookupManager.m
//  sampleProject
//
//  Created by Stoyan Stoyanov on 4/6/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "ContactsLookupManager.h"
#import <Contacts/Contacts.h>
#import "CNContact+HasThisPhone.h"

@interface ContactsLookupManager()

@property(nonatomic, strong) CNContactStore *store;
@property(nonatomic, strong) NSMutableArray<CNContact *> __block *contacts;
@end

@implementation ContactsLookupManager

+ (instancetype)sharedInstance {
    static ContactsLookupManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ContactsLookupManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.store = [[CNContactStore alloc] init];
        self.contacts = [[NSMutableArray alloc] init];
        
        NSArray *keysToFetch = @[CNContactPhoneNumbersKey, [CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName]];
        CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
        
        [self.store enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            [self.contacts addObject:contact];
        }];
    }
    return self;
}

- (NSString *)contactNameFromPhone:(NSString *)phone {
    NSString *result = nil;
    for (CNContact *contact in self.contacts) {
        if ([contact hasThisPhoneRecord:phone]) {
            result = [CNContactFormatter stringFromContact:contact style: CNContactFormatterStyleFullName];
            break;
        }
    }
    return result;
}

@end
