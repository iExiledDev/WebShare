TWEAK_NAME = WebShare
WebShare_FILES = Tweak.xm
WebShare_FRAMEWORKS = UIKit
WebShare_PRIVATE_FRAMEWORKS = WebCore

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"