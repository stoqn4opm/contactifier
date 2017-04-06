#import "NSAttributedString+Contactified.h"

%hook CKChatItem

+(id)chatItemWithIMChatItem:(id)arg1 balloonMaxWidth:(double)arg2 otherMaxWidth:(double)arg3 {

    if ([NSStringFromClass([arg1 class]) isEqualToString:@"IMTextMessagePartChatItem"]) {

        // NSAttributedString *text = [[NSAttributedString alloc] initWithAttributedString:(NSAttributedString *)[arg1 valueForKey:@"text"]];
        // NSAttributedString *contactifiedString = [text  contactifiedString];

        // [arg1 setValue:contactifiedString forKey:@"text"];
        CGFloat rand = 1 + 2.0 / arc4random_uniform(1000);
        return %orig(arg1, arg2 * rand, arg3 * rand);
    } else {
        return %orig;
    }
}

%end

%hook CKBalloonTextView

- (void)setAttributedText:(NSAttributedString *)attributedText {

	%orig([attributedText contactifiedString]);

    // BOOL __block containsTelScheme = NO;
    // [attributedText enumerateAttributesInRange:NSMakeRange(0, attributedText.length)
    //                                    options:NSAttributedStringEnumerationReverse
    //                                 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
    //     NSURL *link = [attrs valueForKey:@"NSLink"];
    //     if ([link.scheme isEqualToString:@"tel"]) { 
            

    //         NSString *phone = [[attributedText attributedSubstringFromRange:range] string];
    //         CNContactStore *store = [[CNContactStore alloc] init];
    //         [store nameForPhoneNumber:phone withCompletion:^(NSString *formattedName) {
    //             if (formattedName) {
    //                 NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithAttributedString: attributedText];
    //                 NSString *originalText = [[mStr attributedSubstringFromRange:range] string];
    //                 [mStr replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%@ (%@)", originalText, formattedName]];
    //                 // NSLog(@"printed modified text %@", mStr);
    //                 %orig(mStr);
    //                 [self setNeedsDisplay];
    //                 [self setNeedsLayout];
    //             } else {
    //                 // NSLog(@"no match in contacts for phone %@", phone);
    //                 %orig(attributedText);
    //             }
    //         }];
    //     } 
    // }];

    // if (!containsTelScheme) {
    //     // NSLog(@"no tel scheme %@", attributedText);
    //     %orig(attributedText);
    // }
}

%end