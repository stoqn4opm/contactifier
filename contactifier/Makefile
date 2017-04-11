export ARCHS = armv7 armv7s arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = contactifier
contactifier_FILES = Tweak.xm CNContact+HasThisPhone.m ContactsLookupManager.m NSAttributedString+Contactified.m CNLabeledValue+ComparisonGrade.m NSString+ReversedChars.m
contactifier_FRAMEWORKS = UIKit Contacts Foundation
include $(THEOS_MAKE_PATH)/tweak.mk

ADDITIONAL_OBJCFLAGS = -fobjc-arc

after-install::
	install.exec "killall -9 MobileSMS"

SUBPROJECTS += contactifiersettings
include $(THEOS_MAKE_PATH)/aggregate.mk
