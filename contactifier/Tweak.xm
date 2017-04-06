#import "NSAttributedString+Contactified.h"

// Message Balloon Size related hacks

%hook CKChatItem

+(id)chatItemWithIMChatItem:(id)arg1 balloonMaxWidth:(double)arg2 otherMaxWidth:(double)arg3 {

    if ([NSStringFromClass([arg1 class]) isEqualToString:@"IMTextMessagePartChatItem"]) {
		//this weird trick with random numbers is done in order to invalidate message balloons sizes
        CGFloat rand = 1 + 2.0 / arc4random_uniform(1000);
        return %orig(arg1, arg2 * rand, arg3 * rand);
    } else {
        return %orig;
    }
}

%end

// Messages Altering

%hook CKBalloonTextView

- (void)setAttributedText:(NSAttributedString *)attributedText {
	%orig([attributedText contactifiedString]);
}

%end