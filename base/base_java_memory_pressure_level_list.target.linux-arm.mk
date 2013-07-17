# This file is generated by gyp; do not edit.

include $(CLEAR_VARS)

LOCAL_MODULE_CLASS := GYP
LOCAL_MODULE := base_base_java_memory_pressure_level_list_gyp
LOCAL_MODULE_STEM := base_java_memory_pressure_level_list
LOCAL_MODULE_SUFFIX := .stamp
LOCAL_MODULE_TAGS := optional
gyp_intermediate_dir := $(call local-intermediates-dir)
gyp_shared_intermediate_dir := $(call intermediates-dir-for,GYP,shared)

# Make sure our deps are built first.
GYP_TARGET_DEPENDENCIES :=


### Generated for rule "base_base_gyp_base_java_memory_pressure_level_list_target_generate_java_constants":
# "{'inputs': ['../build/android/gyp/util/build_utils.py', '../build/android/gyp/gcc_preprocess.py', 'memory/memory_pressure_level_list.h'], 'extension': 'template', 'outputs': ['$(gyp_shared_intermediate_dir)/templates/org/chromium/base/%(INPUT_ROOT)s.java'], 'variables': {'output_path': '$(gyp_shared_intermediate_dir)/templates/org/chromium/base/%(INPUT_ROOT)s.java'}, 'rule_name': 'generate_java_constants', 'rule_sources': ['android/java/src/org/chromium/base/MemoryPressureLevelList.template'], 'action': ['python', '../build/android/gyp/gcc_preprocess.py', '--include-path=..', '--output=$(gyp_shared_intermediate_dir)/templates/org/chromium/base/%(INPUT_ROOT)s.java', '--template=$(RULE_SOURCES)'], 'message': 'Generating Java from cpp template $(RULE_SOURCES)'}":
$(gyp_shared_intermediate_dir)/templates/org/chromium/base/MemoryPressureLevelList.java: gyp_local_path := $(LOCAL_PATH)
$(gyp_shared_intermediate_dir)/templates/org/chromium/base/MemoryPressureLevelList.java: gyp_intermediate_dir := $(abspath $(gyp_intermediate_dir))
$(gyp_shared_intermediate_dir)/templates/org/chromium/base/MemoryPressureLevelList.java: gyp_shared_intermediate_dir := $(abspath $(gyp_shared_intermediate_dir))
$(gyp_shared_intermediate_dir)/templates/org/chromium/base/MemoryPressureLevelList.java: export PATH := $(subst $(ANDROID_BUILD_PATHS),,$(PATH))
$(gyp_shared_intermediate_dir)/templates/org/chromium/base/MemoryPressureLevelList.java: $(LOCAL_PATH)/base/android/java/src/org/chromium/base/MemoryPressureLevelList.template $(LOCAL_PATH)/build/android/gyp/util/build_utils.py $(LOCAL_PATH)/build/android/gyp/gcc_preprocess.py $(LOCAL_PATH)/base/memory/memory_pressure_level_list.h $(GYP_TARGET_DEPENDENCIES)
	mkdir -p $(gyp_shared_intermediate_dir)/templates/org/chromium/base; cd $(gyp_local_path)/base; python ../build/android/gyp/gcc_preprocess.py "--include-path=.." "--output=$(gyp_shared_intermediate_dir)/templates/org/chromium/base/MemoryPressureLevelList.java" "--template=android/java/src/org/chromium/base/MemoryPressureLevelList.template"

.PHONY: base_base_java_memory_pressure_level_list_gyp_rule_trigger
base_base_java_memory_pressure_level_list_gyp_rule_trigger: $(gyp_shared_intermediate_dir)/templates/org/chromium/base/MemoryPressureLevelList.java

### Finished generating for all rules

GYP_GENERATED_OUTPUTS := \
	$(gyp_shared_intermediate_dir)/templates/org/chromium/base/MemoryPressureLevelList.java

# Make sure our deps and generated files are built first.
LOCAL_ADDITIONAL_DEPENDENCIES := $(GYP_TARGET_DEPENDENCIES) $(GYP_GENERATED_OUTPUTS)

LOCAL_GENERATED_SOURCES := \
	base_base_java_memory_pressure_level_list_gyp_rule_trigger

GYP_COPIED_SOURCE_ORIGIN_DIRS :=

LOCAL_SRC_FILES :=


# Flags passed to both C and C++ files.
MY_CFLAGS_Debug := \
	-fstack-protector \
	--param=ssp-buffer-size=4 \
	-Werror \
	-fno-exceptions \
	-fno-strict-aliasing \
	-Wall \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-fvisibility=hidden \
	-pipe \
	-fPIC \
	-fno-tree-sra \
	-fuse-ld=gold \
	-Wno-psabi \
	-ffunction-sections \
	-funwind-tables \
	-g \
	-fstack-protector \
	-fno-short-enums \
	-finline-limit=64 \
	-Wa,--noexecstack \
	-U_FORTIFY_SOURCE \
	-Wno-extra \
	-Wno-ignored-qualifiers \
	-Wno-type-limits \
	-Os \
	-g \
	-fomit-frame-pointer \
	-fdata-sections \
	-ffunction-sections

MY_DEFS_Debug := \
	'-DANGLE_DX11' \
	'-D_FILE_OFFSET_BITS=64' \
	'-DNO_TCMALLOC' \
	'-DDISCARDABLE_MEMORY_ALWAYS_SUPPORTED_NATIVELY' \
	'-DSYSTEM_NATIVELY_SIGNALS_MEMORY_PRESSURE' \
	'-DDISABLE_NACL' \
	'-DCHROMIUM_BUILD' \
	'-DUSE_LIBJPEG_TURBO=1' \
	'-DUSE_PROPRIETARY_CODECS' \
	'-DENABLE_GPU=1' \
	'-DUSE_OPENSSL=1' \
	'-DENABLE_EGLIMAGE=1' \
	'-DENABLE_LANGUAGE_DETECTION=1' \
	'-D__STDC_CONSTANT_MACROS' \
	'-D__STDC_FORMAT_MACROS' \
	'-DANDROID' \
	'-D__GNU_SOURCE=1' \
	'-DUSE_STLPORT=1' \
	'-D_STLP_USE_PTR_SPECIALIZATIONS=1' \
	'-DCHROME_BUILD_ID=""' \
	'-DDYNAMIC_ANNOTATIONS_ENABLED=1' \
	'-DWTF_USE_DYNAMIC_ANNOTATIONS=1' \
	'-D_DEBUG'


# Include paths placed before CFLAGS/CPPFLAGS
LOCAL_C_INCLUDES_Debug := \
	$(PWD)/frameworks/wilhelm/include \
	$(PWD)/bionic \
	$(PWD)/external/stlport/stlport


# Flags passed to only C++ (and not C) files.
LOCAL_CPPFLAGS_Debug := \
	-fno-rtti \
	-fno-threadsafe-statics \
	-fvisibility-inlines-hidden \
	-Wsign-compare \
	-Wno-abi \
	-Wno-error=c++0x-compat \
	-Wno-non-virtual-dtor \
	-Wno-sign-promo


# Flags passed to both C and C++ files.
MY_CFLAGS_Release := \
	-fstack-protector \
	--param=ssp-buffer-size=4 \
	-Werror \
	-fno-exceptions \
	-fno-strict-aliasing \
	-Wall \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-fvisibility=hidden \
	-pipe \
	-fPIC \
	-fno-tree-sra \
	-fuse-ld=gold \
	-Wno-psabi \
	-ffunction-sections \
	-funwind-tables \
	-g \
	-fstack-protector \
	-fno-short-enums \
	-finline-limit=64 \
	-Wa,--noexecstack \
	-U_FORTIFY_SOURCE \
	-Wno-extra \
	-Wno-ignored-qualifiers \
	-Wno-type-limits \
	-Os \
	-fno-ident \
	-fdata-sections \
	-ffunction-sections \
	-fomit-frame-pointer

MY_DEFS_Release := \
	'-DANGLE_DX11' \
	'-D_FILE_OFFSET_BITS=64' \
	'-DNO_TCMALLOC' \
	'-DDISCARDABLE_MEMORY_ALWAYS_SUPPORTED_NATIVELY' \
	'-DSYSTEM_NATIVELY_SIGNALS_MEMORY_PRESSURE' \
	'-DDISABLE_NACL' \
	'-DCHROMIUM_BUILD' \
	'-DUSE_LIBJPEG_TURBO=1' \
	'-DUSE_PROPRIETARY_CODECS' \
	'-DENABLE_GPU=1' \
	'-DUSE_OPENSSL=1' \
	'-DENABLE_EGLIMAGE=1' \
	'-DENABLE_LANGUAGE_DETECTION=1' \
	'-D__STDC_CONSTANT_MACROS' \
	'-D__STDC_FORMAT_MACROS' \
	'-DANDROID' \
	'-D__GNU_SOURCE=1' \
	'-DUSE_STLPORT=1' \
	'-D_STLP_USE_PTR_SPECIALIZATIONS=1' \
	'-DCHROME_BUILD_ID=""' \
	'-DNDEBUG' \
	'-DNVALGRIND' \
	'-DDYNAMIC_ANNOTATIONS_ENABLED=0' \
	'-D_FORTIFY_SOURCE=2'


# Include paths placed before CFLAGS/CPPFLAGS
LOCAL_C_INCLUDES_Release := \
	$(PWD)/frameworks/wilhelm/include \
	$(PWD)/bionic \
	$(PWD)/external/stlport/stlport


# Flags passed to only C++ (and not C) files.
LOCAL_CPPFLAGS_Release := \
	-fno-rtti \
	-fno-threadsafe-statics \
	-fvisibility-inlines-hidden \
	-Wsign-compare \
	-Wno-abi \
	-Wno-error=c++0x-compat \
	-Wno-non-virtual-dtor \
	-Wno-sign-promo


LOCAL_CFLAGS := $(MY_CFLAGS_$(GYP_CONFIGURATION)) $(MY_DEFS_$(GYP_CONFIGURATION))
LOCAL_C_INCLUDES := $(GYP_COPIED_SOURCE_ORIGIN_DIRS) $(LOCAL_C_INCLUDES_$(GYP_CONFIGURATION))
LOCAL_CPPFLAGS := $(LOCAL_CPPFLAGS_$(GYP_CONFIGURATION))
### Rules for final target.
# Add target alias to "gyp_all_modules" target.
.PHONY: gyp_all_modules
gyp_all_modules: base_base_java_memory_pressure_level_list_gyp

# Alias gyp target name.
.PHONY: base_java_memory_pressure_level_list
base_java_memory_pressure_level_list: base_base_java_memory_pressure_level_list_gyp

LOCAL_MODULE_PATH := $(PRODUCT_OUT)/gyp_stamp
LOCAL_UNINSTALLABLE_MODULE := true

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(LOCAL_ADDITIONAL_DEPENDENCIES)
	$(hide) echo "Gyp timestamp: $@"
	$(hide) mkdir -p $(dir $@)
	$(hide) touch $@
