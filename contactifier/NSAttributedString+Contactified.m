//
//  NSAttributedString+Contactified.m
//  sampleProject
//
//  Created by Stoyan Stoyanov on 4/5/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "NSAttributedString+Contactified.h"
#import "CNContactStore+NameForPhoneNumber.h"
#import <UIKit/UIKit.h>

@implementation NSAttributedString (Contactified)

- (NSAttributedString *)contactifiedString {
    
    NSInteger countOfAllAttributes = [[self attributesAtIndex:0 longestEffectiveRange:nil inRange:NSMakeRange(0, self.length)] count];
    if (countOfAllAttributes == 0) {
        return self;
    }
    
    NSMutableAttributedString __block *mutableSelf = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    
    [self // this method is blocking the thread
     enumerateAttributesInRange:NSMakeRange(0, self.length)
     options:NSAttributedStringEnumerationReverse
     usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
         
         NSURL *link = [attrs valueForKey:NSLinkAttributeName];
         if ([link.scheme isEqualToString:@"tel"]) {
             
             NSString *phone = [[mutableSelf attributedSubstringFromRange:range] string];
             CNContactStore *store = [[CNContactStore alloc] init];
             NSString *name = [store nameForPhoneNumber:phone];
             
             if (name.length != 0) {
                 NSString *originalText = [[mutableSelf attributedSubstringFromRange:range] string];
                 [mutableSelf replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%@ (%@)", originalText, name]];
             }
         }
     }];
    
    NSAttributedString *result = [[NSAttributedString alloc] initWithAttributedString:mutableSelf];
    return result;
}

@end
