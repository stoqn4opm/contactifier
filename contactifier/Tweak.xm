#import "NSAttributedString+Contactified.h"
#import "ContactsLookupManager.h"

#pragma mark - Settings Related Stuff

static BOOL ENABLED = YES;
static BOOL CLOSE_MATCHES = YES;
static NSNumber *MATCH_THRESHOLD = @(60);

static void loadPrefs() {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.stoqn4opm.contactifier.plist"];
    if(prefs) {
        ENABLED = ([prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : ENABLED);
        CLOSE_MATCHES = ([prefs objectForKey:@"closeMatches"] ? [[prefs objectForKey:@"closeMatches"] boolValue] : CLOSE_MATCHES);
        MATCH_THRESHOLD = ([prefs objectForKey:@"threshold"] ? [prefs objectForKey:@"threshold"] : MATCH_THRESHOLD);
        
        [[ContactsLookupManager sharedInstance] setCloseMatchesOn:CLOSE_MATCHES];
        [[ContactsLookupManager sharedInstance] setCloseMatchesThreshold:@(MATCH_THRESHOLD.doubleValue / 100.0)];
    }
}

%hook CKChatController

- (void)viewWillAppear:(BOOL)animated {
    loadPrefs();
    %orig;
}

%end

#pragma mark - Message Balloon Size related hacks

%hook CKChatItem

+(id)chatItemWithIMChatItem:(id)arg1 balloonMaxWidth:(double)arg2 otherMaxWidth:(double)arg3 {

    if (!ENABLED) {
        return %orig;
    }

    if ([NSStringFromClass([arg1 class]) isEqualToString:@"IMTextMessagePartChatItem"]) {
        //this weird trick with random numbers is done in order to invalidate message balloons sizes
        double rand = 1.0 - 1.0 / arc4random_uniform(1000);
        return %orig(arg1, arg2 * rand, arg3 * rand);
    } else {
        return %orig;
    }
}

%end

#pragma mark - Messages Altering

%hook CKBalloonTextView

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (ENABLED) {
        %orig([attributedText contactifiedString]);     
    } else {
        %orig;
    }
}

%end
