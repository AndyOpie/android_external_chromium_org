# Copyright (c) 2013 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
[[def ExpandDict(key, value_in, pre_list=[], post_list=[]):]]
[[  value = value_in or [] ]]
[[  pre = pre_list or [] ]]
[[  post = post_list or [] ]]
[[  if type(value) is not dict:]]
[[    out = pre]]
[[    out.extend(value)]]
[[    out.extend(post)]]
[[    if out:]]
{{key}} = {{' '.join(out)}}
[[    ]]
[[    return]]
[[  ]]
[[  for subkey in value:]]
[[    out = pre]]
[[    out.extend(value[subkey])]]
[[    out.extend(post)]]
{{key}}_{{subkey}} = {{' '.join(out)}}
[[  ]]
{{key}} = $({{key}}_$(TOOLCHAIN))
[[]]

[[target = targets[0] ]]
# GNU Makefile based on shared rules provided by the Native Client SDK.
# See README.Makefiles for more details.

VALID_TOOLCHAINS := {{' '.join(tools)}}
NACL_SDK_ROOT ?= $(abspath $(CURDIR)/../..)
[[if 'INCLUDES' in target:]]
EXTRA_INC_PATHS={{' '.join(target['INCLUDES'])}}
[[]]

include $(NACL_SDK_ROOT)/tools/common.mk

TARGET = {{target['NAME']}}
[[flags = target.get('CCFLAGS', [])]]
[[flags.extend(target.get('CXXFLAGS', []))]]
[[ExpandDict('CFLAGS', flags)]]

SOURCES = \
[[for source in sorted(target['SOURCES']):]]
  {{source}} \
[[]]

all: install

# Build rules generated by macros from common.mk:
#
$(foreach src,$(SOURCES),$(eval $(call COMPILE_RULE,$(src),$(CFLAGS))))
$(eval $(call LIB_RULE,$(TARGET),$(SOURCES)))

[[if target['TYPE'] != 'static-lib':]]
ifeq ($(TOOLCHAIN),glibc)
$(eval $(call SO_RULE,$(TARGET),$(SOURCES)))
endif
[[]]
