// Copyright 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
#ifndef CHROME_BROWSER_EXTENSIONS_API_SYSTEM_INFO_SYSTEM_INFO_PROVIDER_H_
#define CHROME_BROWSER_EXTENSIONS_API_SYSTEM_INFO_SYSTEM_INFO_PROVIDER_H_

#include <queue>

#include "base/bind.h"
#include "base/callback.h"
#include "base/lazy_instance.h"
#include "base/memory/ref_counted.h"
#include "base/threading/sequenced_worker_pool.h"
#include "content/public/browser/browser_thread.h"

namespace extensions {

// A generic template for all kinds of system information providers. Each kind
// of SystemInfoProvider is a single shared instance. It is created if needed,
// and destroyed at exit time. This is done via LazyInstance and scoped_refptr.
//
// The SystemInfoProvider is designed to query system information on the worker
// pool. It also maintains a queue of callbacks on the UI thread which are
// waiting for the completion of querying operation. Once the query operation
// is completed, all pending callbacks in the queue get called on the UI
// thread. In this way, it avoids frequent querying operation in case of lots
// of query requests, e.g. calling systemInfo.cpu.get repeatedly in an
// extension process.
//
// Template parameter T is the system information type. It could be the
// structure type generated by IDL parser.
//
// The class member |info_| is accessed on multiple threads, but that the whole
// class is being guarded by SystemInfoProvider.
//
// |info_| is accessed on the UI thread while |is_waiting_for_completion_| is
// false and on the sequenced worker pool while |is_waiting_for_completion_| is
// true.
template<class T>
class SystemInfoProvider
    : public base::RefCountedThreadSafe<SystemInfoProvider<T> > {
 public:
  // Callback type for completing to get information. The argument indicates
  // whether its contents are valid, for example, no error occurs in querying
  // the information.
  typedef base::Callback<void(bool)> QueryInfoCompletionCallback;
  typedef std::queue<QueryInfoCompletionCallback> CallbackQueue;

  SystemInfoProvider()
    : is_waiting_for_completion_(false) {
    base::SequencedWorkerPool* pool = content::BrowserThread::GetBlockingPool();
    worker_pool_ = pool->GetSequencedTaskRunnerWithShutdownBehavior(
                       pool->GetSequenceToken(),
                       base::SequencedWorkerPool::CONTINUE_ON_SHUTDOWN);
  }

  virtual ~SystemInfoProvider() {}

  // Override to do any prepare work on UI thread before |QueryInfo()| gets
  // called.
  virtual void PrepareQueryOnUIThread() {}

  // The parameter |do_query_info_callback| is query info task which is posts to
  // SystemInfoProvider sequenced worker pool.
  //
  // You can do any initial things of *InfoProvider before start to query info.
  // While overriding this method, |do_query_info_callback| *must* be called
  // directly or indirectly.
  //
  // Sample usage please refer to StorageInfoProvider.
  virtual void InitializeProvider(const base::Closure& do_query_info_callback) {
    do_query_info_callback.Run();
  }

  // For testing
  static void InitializeForTesting(
      scoped_refptr<SystemInfoProvider<T> > provider) {
    DCHECK(provider.get() != NULL);
    provider_.Get() = provider;
  }

  // Start to query the system information. Should be called on UI thread.
  // The |callback| will get called once the query is completed.
  //
  // If the parameter |callback| itself calls StartQueryInfo(callback2),
  // callback2 will be called immediately rather than triggering another call to
  // the system.
  void StartQueryInfo(const QueryInfoCompletionCallback& callback) {
    DCHECK(content::BrowserThread::CurrentlyOn(content::BrowserThread::UI));
    DCHECK(!callback.is_null());

    callbacks_.push(callback);

    if (is_waiting_for_completion_)
      return;

    is_waiting_for_completion_ = true;

    InitializeProvider(base::Bind(
          &SystemInfoProvider<T>::StartQueryInfoPostInitialization, this));
  }

 protected:
  // Query the system information synchronously and put the result into |info_|.
  // Return true if no error occurs.
  // Should be called in the blocking pool.
  virtual bool QueryInfo() = 0;

  // Template function for creating the single shared provider instance.
  // Template paramter I is the type of SystemInfoProvider implementation.
  template<class I>
  static I* GetInstance() {
    if (!provider_.Get().get())
      provider_.Get() = new I();
    return static_cast<I*>(provider_.Get().get());
  }

  // The latest information filled up by QueryInfo implementation. Here we
  // assume the T is disallowed to copy constructor, aligns with the structure
  // type generated by IDL parser.
  T info_;

 private:
  // Called on UI thread. The |success| parameter means whether it succeeds
  // to get the information.
  void OnQueryCompleted(bool success) {
    DCHECK(content::BrowserThread::CurrentlyOn(content::BrowserThread::UI));

    while (!callbacks_.empty()) {
      QueryInfoCompletionCallback callback = callbacks_.front();
      callback.Run(success);
      callbacks_.pop();
    }

    is_waiting_for_completion_ = false;
  }

  void StartQueryInfoPostInitialization() {
    PrepareQueryOnUIThread();
    // Post the custom query info task to blocking pool for information querying
    // and reply with OnQueryCompleted.
    base::PostTaskAndReplyWithResult(
        worker_pool_,
        FROM_HERE,
        base::Bind(&SystemInfoProvider<T>::QueryInfo, this),
        base::Bind(&SystemInfoProvider<T>::OnQueryCompleted, this));
  }

  // The single shared provider instance. We create it only when needed.
  static typename base::LazyInstance<
      scoped_refptr<SystemInfoProvider<T> > > provider_;

  // The queue of callbacks waiting for the info querying completion. It is
  // maintained on the UI thread.
  CallbackQueue callbacks_;

  // Indicates if it is waiting for the querying completion.
  bool is_waiting_for_completion_;

  // Sequenced worker pool to make the operation of querying information get
  // executed in order.
  scoped_refptr<base::SequencedTaskRunner> worker_pool_;

  DISALLOW_COPY_AND_ASSIGN(SystemInfoProvider<T>);
};

}  // namespace extensions

#endif  // CHROME_BROWSER_EXTENSIONS_API_SYSTEM_INFO_SYSTEM_INFO_PROVIDER_H_
