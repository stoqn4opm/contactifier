#import "NSAttributedString+Contactified.h"

%hook CKChatItem

+(id)chatItemWithIMChatItem:(id)arg1 balloonMaxWidth:(double)arg2 otherMaxWidth:(double)arg3 {

    if ([NSStringFromClass([arg1 class]) isEqualToString:@"IMTextMessagePartChatItem"]) {

        NSAttributedString *text = [[NSAttributedString alloc] initWithAttributedString:(NSAttributedString *)[arg1 valueForKey:@"text"]];
        NSAttributedString *contactifiedString = [text  contactifiedString];

        [arg1 setValue:contactifiedString forKey:@"text"];
        return %orig(arg1, 231, 231);
    } else {
        return %orig;
    }
}

%end
