/* Copyright (c) 2012 The Chromium Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

#ifndef LIBRARIES_SDK_UTIL_AUTO_LOCK_H_
#define LIBRARIES_SDK_UTIL_AUTO_LOCK_H_

#include <pthread.h>
#include "sdk_util/macros.h"
#include "sdk_util/simple_lock.h"


// This macro is provided to allow us to quickly instrument locking for
// debugging purposes.
#define AUTO_LOCK(lock)                         \
  AutoLock Lock##__LINE__(lock);

class AutoLock {
 public:
  AutoLock(const SimpleLock& lock) {
    lock_ = lock.mutex();
    pthread_mutex_lock(lock_);
  }

  ~AutoLock() {
    if (lock_) pthread_mutex_unlock(lock_);
  }

  void Unlock() {
    if (lock_) pthread_mutex_unlock(lock_);
    lock_ = NULL;
  }

 private:
  pthread_mutex_t* lock_;

  DISALLOW_COPY_AND_ASSIGN(AutoLock);
};

#endif  // LIBRARIES_SDK_UTIL_AUTO_LOCK_H_

