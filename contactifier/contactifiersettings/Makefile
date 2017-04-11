include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ContactifierSettings
ContactifierSettings_FILES = CTFRSRootListController.m
ContactifierSettings_INSTALL_PATH = /Library/PreferenceBundles
ContactifierSettings_FRAMEWORKS = UIKit
ContactifierSettings_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ContactifierSettings.plist$(ECHO_END)
