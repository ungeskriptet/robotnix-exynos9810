EXTRA_PATH := vendor/extra

ifneq (,$(wildcard $(EXTRA_PATH)/adbkey.pub))
PRODUCT_ADB_KEYS := $(EXTRA_PATH)/adbkey.pub
PRODUCT_COPY_FILES += $(PRODUCT_ADB_KEYS):$(TARGET_COPY_OUT_RECOVERY)/root/$(TARGET_COPY_OUT_PRODUCT)/etc/security/adb_keys
endif

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.sys.adb.shell=/system_ext/bin/bash

PRODUCT_PACKAGE_OVERLAYS += $(EXTRA_PATH)/overlay-lineage
