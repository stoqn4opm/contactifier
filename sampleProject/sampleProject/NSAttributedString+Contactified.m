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

- (void)contactifyStringWithCompletion:(void (^)(NSAttributedString *))completion {
    BOOL __block containsTelScheme = NO;
    
    [self enumerateAttributesInRange:NSMakeRange(0, self.length)
                             options:NSAttributedStringEnumerationReverse
                          usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
                              
                              NSURL *link = [attrs valueForKey:NSLinkAttributeName];
                              if ([link.scheme isEqualToString:@"tel"]) {
                                  containsTelScheme = YES;
                                  
                                  NSString *phone = [[self attributedSubstringFromRange:range] string];
                                  CNContactStore *store = [[CNContactStore alloc] init];
                                  [store nameForPhoneNumber:phone withCompletion:^(NSString *formattedName) {
                                      if (formattedName) {
                                          NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithAttributedString: self];
                                          NSString *originalText = [[mStr attributedSubstringFromRange:range] string];
                                          [mStr replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%@(%@)", originalText, formattedName]];
                                          if (completion) {
                                              NSAttributedString *result = [[NSAttributedString alloc] initWithAttributedString:mStr];
                                              completion(result);
                                          }
                                      } else {
                                          if (completion) {
                                              completion(self);
                                          }
                                      }
                                  }];
                              }
                          }];
    if (!containsTelScheme) {
        if (completion) {
            completion(self);
        }
    }
}

@end
