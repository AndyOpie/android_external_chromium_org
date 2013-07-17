// Copyright 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "content/browser/renderer_host/pepper/pepper_file_ref_host.h"

#include <string>

#include "content/browser/renderer_host/pepper/pepper_external_file_ref_backend.h"
#include "content/browser/renderer_host/pepper/pepper_file_system_browser_host.h"
#include "content/browser/renderer_host/pepper/pepper_internal_file_ref_backend.h"
#include "ppapi/c/pp_errors.h"
#include "ppapi/c/pp_file_info.h"
#include "ppapi/c/pp_instance.h"
#include "ppapi/c/pp_resource.h"
#include "ppapi/host/dispatch_host_message.h"
#include "ppapi/host/ppapi_host.h"
#include "ppapi/proxy/ppapi_messages.h"
#include "ppapi/shared_impl/file_ref_util.h"
#include "webkit/browser/fileapi/file_permission_policy.h"

using ppapi::host::ResourceHost;

namespace content {

PepperFileRefBackend::~PepperFileRefBackend() {
}

PepperFileRefHost::PepperFileRefHost(BrowserPpapiHost* host,
                                     PP_Instance instance,
                                     PP_Resource resource,
                                     PP_Resource file_system,
                                     const std::string& path)
    : ResourceHost(host->GetPpapiHost(), instance, resource),
      host_(host),
      fs_type_(PP_FILESYSTEMTYPE_INVALID) {
  if (!ppapi::IsValidInternalPath(path))
    return;

  int render_process_id;
  int unused;
  if (!host->GetRenderViewIDsForInstance(instance,
                                         &render_process_id,
                                         &unused)) {
    return;
  }

  ResourceHost* fs_resource_host =
      host->GetPpapiHost()->GetResourceHost(file_system);
  if (fs_resource_host == NULL) {
    DLOG(ERROR) << "Couldn't find FileSystem host: " << resource
                << " path: " << path;
    return;
  }

  PepperFileSystemBrowserHost* fs_host =
      fs_resource_host->AsPepperFileSystemBrowserHost();
  if (fs_host == NULL) {
    DLOG(ERROR) << "Filesystem PP_Resource is not PepperFileSystemBrowserHost";
    return;
  }

  fs_type_ = fs_host->GetType();
  // TODO(teravest): Add support for isolated filesystems.
  if ((fs_type_ != PP_FILESYSTEMTYPE_LOCALPERSISTENT) &&
      (fs_type_ != PP_FILESYSTEMTYPE_LOCALTEMPORARY)) {
    DLOG(ERROR) << "Unsupported filesystem type: " << fs_type_;
    return;
  }

  backend_.reset(new PepperInternalFileRefBackend(
      host->GetPpapiHost(),
      render_process_id,
      base::AsWeakPtr(fs_host),
      path));
}

PepperFileRefHost::PepperFileRefHost(BrowserPpapiHost* host,
                                     PP_Instance instance,
                                     PP_Resource resource,
                                     const base::FilePath& external_path)
    : ResourceHost(host->GetPpapiHost(), instance, resource),
      host_(host),
      fs_type_(PP_FILESYSTEMTYPE_EXTERNAL) {
  if (!ppapi::IsValidExternalPath(external_path))
    return;

  int render_process_id;
  int unused;
  if (!host->GetRenderViewIDsForInstance(instance,
                                         &render_process_id,
                                         &unused)) {
    return;
  }

  backend_.reset(new PepperExternalFileRefBackend(host->GetPpapiHost(),
                                                  render_process_id,
                                                  external_path));
}

PepperFileRefHost::~PepperFileRefHost() {
}

PepperFileRefHost* PepperFileRefHost::AsPepperFileRefHost() {
  return this;
}

PP_FileSystemType PepperFileRefHost::GetFileSystemType() const {
  return fs_type_;
}

fileapi::FileSystemURL PepperFileRefHost::GetFileSystemURL() const {
  if (backend_)
    return backend_->GetFileSystemURL();
  return fileapi::FileSystemURL();
}

std::string PepperFileRefHost::GetFileSystemURLSpec() const {
  if (backend_)
    return backend_->GetFileSystemURLSpec();
  return std::string();
}

base::FilePath PepperFileRefHost::GetExternalPath() const {
  if (backend_)
    return backend_->GetExternalPath();
  return base::FilePath();
}

int32_t PepperFileRefHost::HasPermissions(int permissions) const {
  if (backend_)
    return backend_->HasPermissions(permissions);
  return PP_ERROR_FAILED;
}

int32_t PepperFileRefHost::OnResourceMessageReceived(
    const IPC::Message& msg,
    ppapi::host::HostMessageContext* context) {
  if (!backend_)
    return PP_ERROR_FAILED;

  IPC_BEGIN_MESSAGE_MAP(PepperFileRefHost, msg)
    PPAPI_DISPATCH_HOST_RESOURCE_CALL(PpapiHostMsg_FileRef_MakeDirectory,
                                      OnMakeDirectory);
    PPAPI_DISPATCH_HOST_RESOURCE_CALL(PpapiHostMsg_FileRef_Touch,
                                      OnTouch);
    PPAPI_DISPATCH_HOST_RESOURCE_CALL_0(PpapiHostMsg_FileRef_Delete,
                                        OnDelete);
    PPAPI_DISPATCH_HOST_RESOURCE_CALL(PpapiHostMsg_FileRef_Rename,
                                      OnRename);
    PPAPI_DISPATCH_HOST_RESOURCE_CALL_0(PpapiHostMsg_FileRef_Query,
                                        OnQuery);
    PPAPI_DISPATCH_HOST_RESOURCE_CALL_0(
        PpapiHostMsg_FileRef_ReadDirectoryEntries,
        OnReadDirectoryEntries);
    PPAPI_DISPATCH_HOST_RESOURCE_CALL_0(PpapiHostMsg_FileRef_GetAbsolutePath,
                                        OnGetAbsolutePath);

  IPC_END_MESSAGE_MAP()
  return PP_ERROR_FAILED;
}

int32_t PepperFileRefHost::OnMakeDirectory(
    ppapi::host::HostMessageContext* context,
    bool make_ancestors) {
  int32_t rv = HasPermissions(fileapi::kCreateFilePermissions);
  if (rv != PP_OK)
    return rv;
  return backend_->MakeDirectory(context->MakeReplyMessageContext(),
                                 make_ancestors);
}

int32_t PepperFileRefHost::OnTouch(ppapi::host::HostMessageContext* context,
                                   PP_Time last_access_time,
                                   PP_Time last_modified_time) {
  // TODO(teravest): Change this to be kWriteFilePermissions here and in
  // fileapi_message_filter.
  int32_t rv = HasPermissions(fileapi::kCreateFilePermissions);
  if (rv != PP_OK)
    return rv;
  return backend_->Touch(context->MakeReplyMessageContext(),
                         last_access_time,
                         last_modified_time);
}

int32_t PepperFileRefHost::OnDelete(ppapi::host::HostMessageContext* context) {
  int32_t rv = HasPermissions(fileapi::kWriteFilePermissions);
  if (rv != PP_OK)
    return rv;
  return backend_->Delete(context->MakeReplyMessageContext());
}

int32_t PepperFileRefHost::OnRename(ppapi::host::HostMessageContext* context,
                                    PP_Resource new_file_ref) {
  int32_t rv = HasPermissions(
      fileapi::kReadFilePermissions | fileapi::kWriteFilePermissions);
  if (rv != PP_OK)
    return rv;

  ResourceHost* resource_host =
      host_->GetPpapiHost()->GetResourceHost(new_file_ref);
  if (!resource_host)
    return PP_ERROR_BADRESOURCE;

  PepperFileRefHost* file_ref_host = resource_host->AsPepperFileRefHost();
  if (!file_ref_host)
    return PP_ERROR_BADRESOURCE;

  rv = file_ref_host->HasPermissions(fileapi::kCreateFilePermissions);
  if (rv != PP_OK)
    return rv;

  return backend_->Rename(context->MakeReplyMessageContext(),
                          file_ref_host);
}

int32_t PepperFileRefHost::OnQuery(ppapi::host::HostMessageContext* context) {
  int32_t rv = HasPermissions(fileapi::kReadFilePermissions);
  if (rv != PP_OK)
    return rv;
  return backend_->Query(context->MakeReplyMessageContext());
}

int32_t PepperFileRefHost::OnReadDirectoryEntries(
    ppapi::host::HostMessageContext* context) {
  int32_t rv = HasPermissions(fileapi::kReadFilePermissions);
  if (rv != PP_OK)
    return rv;
  return backend_->ReadDirectoryEntries(context->MakeReplyMessageContext());
}

int32_t PepperFileRefHost::OnGetAbsolutePath(
    ppapi::host::HostMessageContext* context) {
  if (!host_->GetPpapiHost()->permissions().HasPermission(
      ppapi::PERMISSION_PRIVATE))
    return PP_ERROR_NOACCESS;
  return backend_->GetAbsolutePath(context->MakeReplyMessageContext());
}

}  // namespace content
