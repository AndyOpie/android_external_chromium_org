# This file is generated by gyp; do not edit.

include $(CLEAR_VARS)

LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := third_party_protobuf_protobuf_full_do_not_use_host_gyp
LOCAL_MODULE_SUFFIX := .a
LOCAL_MODULE_TAGS := optional
LOCAL_IS_HOST_MODULE := true
gyp_intermediate_dir := $(call local-intermediates-dir)
gyp_shared_intermediate_dir := $(call intermediates-dir-for,GYP,shared)

# Make sure our deps are built first.
GYP_TARGET_DEPENDENCIES :=

GYP_GENERATED_OUTPUTS :=

# Make sure our deps and generated files are built first.
LOCAL_ADDITIONAL_DEPENDENCIES := $(GYP_TARGET_DEPENDENCIES) $(GYP_GENERATED_OUTPUTS)

LOCAL_CPP_EXTENSION := .cc
LOCAL_GENERATED_SOURCES :=

GYP_COPIED_SOURCE_ORIGIN_DIRS :=

LOCAL_SRC_FILES := \
	third_party/protobuf/src/google/protobuf/stubs/strutil.cc \
	third_party/protobuf/src/google/protobuf/stubs/substitute.cc \
	third_party/protobuf/src/google/protobuf/stubs/structurally_valid.cc \
	third_party/protobuf/src/google/protobuf/descriptor.cc \
	third_party/protobuf/src/google/protobuf/descriptor.pb.cc \
	third_party/protobuf/src/google/protobuf/descriptor_database.cc \
	third_party/protobuf/src/google/protobuf/dynamic_message.cc \
	third_party/protobuf/src/google/protobuf/extension_set_heavy.cc \
	third_party/protobuf/src/google/protobuf/generated_message_reflection.cc \
	third_party/protobuf/src/google/protobuf/message.cc \
	third_party/protobuf/src/google/protobuf/reflection_ops.cc \
	third_party/protobuf/src/google/protobuf/service.cc \
	third_party/protobuf/src/google/protobuf/text_format.cc \
	third_party/protobuf/src/google/protobuf/wire_format.cc \
	third_party/protobuf/src/google/protobuf/io/printer.cc \
	third_party/protobuf/src/google/protobuf/io/tokenizer.cc \
	third_party/protobuf/src/google/protobuf/io/zero_copy_stream_impl.cc \
	third_party/protobuf/src/google/protobuf/compiler/importer.cc \
	third_party/protobuf/src/google/protobuf/compiler/parser.cc \
	third_party/protobuf/src/google/protobuf/stubs/atomicops_internals_x86_gcc.cc \
	third_party/protobuf/src/google/protobuf/stubs/atomicops_internals_x86_msvc.cc \
	third_party/protobuf/src/google/protobuf/unknown_field_set.cc \
	third_party/protobuf/src/google/protobuf/stubs/common.cc \
	third_party/protobuf/src/google/protobuf/stubs/once.cc \
	third_party/protobuf/src/google/protobuf/extension_set.cc \
	third_party/protobuf/src/google/protobuf/generated_message_util.cc \
	third_party/protobuf/src/google/protobuf/message_lite.cc \
	third_party/protobuf/src/google/protobuf/repeated_field.cc \
	third_party/protobuf/src/google/protobuf/wire_format_lite.cc \
	third_party/protobuf/src/google/protobuf/io/coded_stream.cc \
	third_party/protobuf/src/google/protobuf/io/zero_copy_stream.cc \
	third_party/protobuf/src/google/protobuf/io/zero_copy_stream_impl_lite.cc


# Flags passed to both C and C++ files.
MY_CFLAGS_Debug := \
	-fstack-protector \
	--param=ssp-buffer-size=4 \
	 \
	-pthread \
	-fno-exceptions \
	-fno-strict-aliasing \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-fvisibility=hidden \
	-pipe \
	-fPIC \
	-Wno-format \
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
	'-DGOOGLE_PROTOBUF_NO_RTTI' \
	'-DGOOGLE_PROTOBUF_NO_STATIC_INITIALIZER' \
	'-DDYNAMIC_ANNOTATIONS_ENABLED=1' \
	'-DWTF_USE_DYNAMIC_ANNOTATIONS=1' \
	'-D_DEBUG'


# Include paths placed before CFLAGS/CPPFLAGS
LOCAL_C_INCLUDES_Debug := \
	$(LOCAL_PATH)/third_party/protobuf \
	$(LOCAL_PATH)/third_party/protobuf/src


# Flags passed to only C++ (and not C) files.
LOCAL_CPPFLAGS_Debug := \
	-fno-rtti \
	-fno-threadsafe-statics \
	-fvisibility-inlines-hidden \
	-Wno-deprecated


# Flags passed to both C and C++ files.
MY_CFLAGS_Release := \
	-fstack-protector \
	--param=ssp-buffer-size=4 \
	 \
	-pthread \
	-fno-exceptions \
	-fno-strict-aliasing \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-fvisibility=hidden \
	-pipe \
	-fPIC \
	-Wno-format \
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
	'-DGOOGLE_PROTOBUF_NO_RTTI' \
	'-DGOOGLE_PROTOBUF_NO_STATIC_INITIALIZER' \
	'-DNDEBUG' \
	'-DNVALGRIND' \
	'-DDYNAMIC_ANNOTATIONS_ENABLED=0'


# Include paths placed before CFLAGS/CPPFLAGS
LOCAL_C_INCLUDES_Release := \
	$(LOCAL_PATH)/third_party/protobuf \
	$(LOCAL_PATH)/third_party/protobuf/src


# Flags passed to only C++ (and not C) files.
LOCAL_CPPFLAGS_Release := \
	-fno-rtti \
	-fno-threadsafe-statics \
	-fvisibility-inlines-hidden \
	-Wno-deprecated


LOCAL_CFLAGS := $(MY_CFLAGS_$(GYP_CONFIGURATION)) $(MY_DEFS_$(GYP_CONFIGURATION))
# Undefine ANDROID for host modules
LOCAL_CFLAGS += -UANDROID
LOCAL_C_INCLUDES := $(GYP_COPIED_SOURCE_ORIGIN_DIRS) $(LOCAL_C_INCLUDES_$(GYP_CONFIGURATION))
LOCAL_CPPFLAGS := $(LOCAL_CPPFLAGS_$(GYP_CONFIGURATION))
### Rules for final target.

LOCAL_LDFLAGS_Debug := \
	-Wl,-z,now \
	-Wl,-z,relro \
	-pthread \
	-fPIC


LOCAL_LDFLAGS_Release := \
	-Wl,-z,now \
	-Wl,-z,relro \
	-pthread \
	-fPIC


LOCAL_LDFLAGS := $(LOCAL_LDFLAGS_$(GYP_CONFIGURATION))

LOCAL_STATIC_LIBRARIES :=

# Enable grouping to fix circular references
LOCAL_GROUP_STATIC_LIBRARIES := true

LOCAL_SHARED_LIBRARIES :=

# Add target alias to "gyp_all_modules" target.
.PHONY: gyp_all_modules
gyp_all_modules: third_party_protobuf_protobuf_full_do_not_use_host_gyp

# Alias gyp target name.
.PHONY: protobuf_full_do_not_use
protobuf_full_do_not_use: third_party_protobuf_protobuf_full_do_not_use_host_gyp

include $(BUILD_HOST_STATIC_LIBRARY)
