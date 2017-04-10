#include "CTPRootListController.h"

@implementation CTPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)donate {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/stoqn4opm"]];
}

-(void)facebook {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/stoqn4opm"]];
}

//-(void)postNotification {
//    CFNotificationCenterRef center = CFNotificationCenterGetLocalCenter();
//    
//    // post a notification
//    CFDictionaryKeyCallBacks keyCallbacks = {0, NULL, NULL, CFCopyDescription, CFEqual, NULL};
//    CFDictionaryValueCallBacks valueCallbacks  = {0, NULL, NULL, CFCopyDescription, CFEqual};
//    CFMutableDictionaryRef dictionary = CFDictionaryCreateMutable(kCFAllocatorDefault, 1,
//                                                                  &keyCallbacks, &valueCallbacks);
//    CFDictionaryAddValue(dictionary, CFSTR("identifier"), CFSTR("value"));
//    CFNotificationCenterPostNotification(center, CFSTR("com.identifier.message"), NULL, dictionary, TRUE);
//    CFRelease(dictionary);
//}

@end
