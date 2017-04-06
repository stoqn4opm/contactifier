include $(THEOS)/makefiles/common.mk

TWEAK_NAME = contactifier
contactifier_FILES = Tweak.xm CNContact+HasThisPhone.m ContactsLookupManager.m NSAttributedString+Contactified.m
contactifier_FRAMEWORKS = UIKit Contacts Foundation
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileSMS"
