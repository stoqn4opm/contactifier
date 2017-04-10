#import "NSAttributedString+Contactified.h"

// Preference related things

static BOOL ENABLED = YES; // Default value
static NSNumber *MINIMAL_GRADE_BOUND = @(0.6);

static void loadPrefs() {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.stoqn4opm.contactifier.plist"];
    if(prefs) {
        ENABLED = ([prefs objectForKey:@"TweakEnabled"] ? [[prefs objectForKey:@"TweakEnabled"] boolValue] : ENABLED);
        MINIMAL_GRADE_BOUND = ([prefs objectForKey:@"minimumGrade"] ? [prefs objectForKey:@"minimumGrade"] : MINIMAL_GRADE_BOUND);
    }
}

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.stoqn4opm.contactifier/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}

// Message Balloon Size related hacks

%hook CKChatItem

+(id)chatItemWithIMChatItem:(id)arg1 balloonMaxWidth:(double)arg2 otherMaxWidth:(double)arg3 {

    if (ENABLED && [NSStringFromClass([arg1 class]) isEqualToString:@"IMTextMessagePartChatItem"]) {
		//this weird trick with random numbers is done in order to invalidate message balloons sizes
        double rand = 1.0 - 1.0 / arc4random_uniform(100);
        return %orig(arg1, arg2 * rand, arg3 * rand);
    } else {
        return %orig;
    }
}

%end

// Messages Altering

%hook CKBalloonTextView

- (void)setAttributedText:(NSAttributedString *)attributedText {
	if (ENABLED) {
		%orig([attributedText contactifiedString]);		
	} else {
		%orig;
	}
}

%end
