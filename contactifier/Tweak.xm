#import "NSAttributedString+Contactified.h"

%hook CKChatItem

+(id)chatItemWithIMChatItem:(id)arg1 balloonMaxWidth:(double)arg2 otherMaxWidth:(double)arg3 {

    if ([NSStringFromClass([arg1 class]) isEqualToString:@"IMTextMessagePartChatItem"]) {

        NSAttributedString *text = [[NSAttributedString alloc] initWithAttributedString:(NSAttributedString *)[arg1 valueForKey:@"text"]];
        NSAttributedString *contactifiedString = [text  contactifiedString];

        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithAttributedString:contactifiedString];
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:@" [sample message altering with appropriate balloon resizing]"]];
        contactifiedString = [[NSAttributedString alloc] initWithAttributedString:string];

        [arg1 setValue:contactifiedString forKey:@"text"];
        return %orig(arg1, 230, 230);
    } else {
        return %orig;
    }
}

%end
