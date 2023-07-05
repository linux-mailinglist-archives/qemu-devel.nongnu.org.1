Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1FA7485BA
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 16:13:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH3G3-0001ND-Lz; Wed, 05 Jul 2023 10:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qH3G0-0001Mq-QK
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qH3Fy-000449-NO
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688566401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EniJx9r6rgFGaRa+DQapojxNNG/3I9d585AhI3qFhjM=;
 b=JnCNT3AHFIYpVkrJagmA20TyOM7rLvlINw52YwNhH+IKDmUuzXUruPySOjQ6W8W7T51OjU
 4lneHWr8C48TIMUAuDMUtJJPmwI/9KWSo5gSH0ipQo0tS+t7cn2727jVofA637K+f1Kaxn
 smj8ZNz3REU0i9Aueob09l5d2Mh2eRw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-0WXuhlBlOVClu7HiIIZITQ-1; Wed, 05 Jul 2023 10:12:15 -0400
X-MC-Unique: 0WXuhlBlOVClu7HiIIZITQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74931185A7A2;
 Wed,  5 Jul 2023 14:12:15 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.224.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 151434CD0CA;
 Wed,  5 Jul 2023 14:12:13 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Subject: [PATCH 4/4] QGA VSS: Add log in functions begin/end
Date: Wed,  5 Jul 2023 17:12:05 +0300
Message-Id: <20230705141205.525776-5-kkostiuk@redhat.com>
In-Reply-To: <20230705141205.525776-1-kkostiuk@redhat.com>
References: <20230705141205.525776-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/install.cpp   | 33 +++++++++++++++++++++++++++++++++
 qga/vss-win32/provider.cpp  |  3 +++
 qga/vss-win32/requester.cpp | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index c10a397e51..8364f60a30 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -100,6 +100,8 @@ HRESULT put_Value(ICatalogObject *pObj, LPCWSTR name, T val)
 /* Lookup Administrators group name from winmgmt */
 static HRESULT GetAdminName(_bstr_t *name)
 {
+    PRINT_DEBUG_BEGIN;
+
     HRESULT hr;
     COMPointer<IWbemLocator> pLoc;
     COMPointer<IWbemServices> pSvc;
@@ -142,6 +144,7 @@ static HRESULT GetAdminName(_bstr_t *name)
     }
 
 out:
+    PRINT_DEBUG_END;
     return hr;
 }
 
@@ -149,6 +152,8 @@ out:
 static HRESULT getNameByStringSID(
     const wchar_t *sid, LPWSTR buffer, LPDWORD bufferLen)
 {
+    PRINT_DEBUG_BEGIN;
+
     HRESULT hr = S_OK;
     PSID psid = NULL;
     SID_NAME_USE groupType;
@@ -168,6 +173,7 @@ static HRESULT getNameByStringSID(
     LocalFree(psid);
 
 out:
+    PRINT_DEBUG_END;
     return hr;
 }
 
@@ -175,6 +181,8 @@ out:
 static HRESULT QGAProviderFind(
     HRESULT (*found)(ICatalogCollection *, int, void *), void *arg)
 {
+    PRINT_DEBUG_BEGIN;
+
     HRESULT hr;
     COMInitializer initializer;
     COMPointer<IUnknown> pUnknown;
@@ -205,12 +213,15 @@ static HRESULT QGAProviderFind(
     chk(pColl->SaveChanges(&n));
 
 out:
+    PRINT_DEBUG_END;
     return hr;
 }
 
 /* Count QGA VSS provider in COM+ Application Catalog */
 static HRESULT QGAProviderCount(ICatalogCollection *coll, int i, void *arg)
 {
+    PRINT_DEBUG_BEGIN;
+
     (*(int *)arg)++;
     return S_OK;
 }
@@ -218,28 +229,35 @@ static HRESULT QGAProviderCount(ICatalogCollection *coll, int i, void *arg)
 /* Remove QGA VSS provider from COM+ Application Catalog Collection */
 static HRESULT QGAProviderRemove(ICatalogCollection *coll, int i, void *arg)
 {
+    PRINT_DEBUG_BEGIN;
     HRESULT hr;
 
     PRINT_DEBUG("Removing COM+ Application: %s", QGA_PROVIDER_NAME);
     chk(coll->Remove(i));
 out:
+    PRINT_DEBUG_END;
     return hr;
 }
 
 /* Unregister this module from COM+ Applications Catalog */
 STDAPI COMUnregister(void)
 {
+    PRINT_DEBUG_BEGIN;
+
     HRESULT hr;
 
     DllUnregisterServer();
     chk(QGAProviderFind(QGAProviderRemove, NULL));
 out:
+    PRINT_DEBUG_END;
     return hr;
 }
 
 /* Register this module to COM+ Applications Catalog */
 STDAPI COMRegister(void)
 {
+    PRINT_DEBUG_BEGIN;
+
     HRESULT hr;
     COMInitializer initializer;
     COMPointer<IUnknown> pUnknown;
@@ -259,12 +277,14 @@ STDAPI COMRegister(void)
 
     if (!g_hinstDll) {
         errmsg(E_FAIL, "Failed to initialize DLL");
+        PRINT_DEBUG_END;
         return E_FAIL;
     }
 
     chk(QGAProviderFind(QGAProviderCount, (void *)&count));
     if (count) {
         errmsg(E_ABORT, "QGA VSS Provider is already installed");
+        PRINT_DEBUG_END;
         return E_ABORT;
     }
 
@@ -355,6 +375,7 @@ out:
         COMUnregister();
     }
 
+    PRINT_DEBUG_END;
     return hr;
 }
 
@@ -370,6 +391,8 @@ STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int)
 
 static BOOL CreateRegistryKey(LPCTSTR key, LPCTSTR value, LPCTSTR data)
 {
+    PRINT_DEBUG_BEGIN;
+
     HKEY  hKey;
     LONG  ret;
     DWORD size;
@@ -390,6 +413,7 @@ static BOOL CreateRegistryKey(LPCTSTR key, LPCTSTR value, LPCTSTR data)
     RegCloseKey(hKey);
 
 out:
+    PRINT_DEBUG_END;
     if (ret != ERROR_SUCCESS) {
         /* As we cannot printf within DllRegisterServer(), show a dialog. */
         errmsg_dialog(ret, "Cannot add registry", key);
@@ -401,6 +425,8 @@ out:
 /* Register this dll as a VSS provider */
 STDAPI DllRegisterServer(void)
 {
+    PRINT_DEBUG_BEGIN;
+
     COMInitializer initializer;
     COMPointer<IVssAdmin> pVssAdmin;
     HRESULT hr = E_FAIL;
@@ -479,12 +505,15 @@ out:
         DllUnregisterServer();
     }
 
+    PRINT_DEBUG_END;
     return hr;
 }
 
 /* Unregister this VSS hardware provider from the system */
 STDAPI DllUnregisterServer(void)
 {
+    PRINT_DEBUG_BEGIN;
+
     TCHAR key[256];
     COMInitializer initializer;
     COMPointer<IVssAdmin> pVssAdmin;
@@ -502,6 +531,7 @@ STDAPI DllUnregisterServer(void)
     SHDeleteKey(HKEY_CLASSES_ROOT, key);
     SHDeleteKey(HKEY_CLASSES_ROOT, g_szProgid);
 
+    PRINT_DEBUG_END;
     return S_OK; /* Uninstall should never fail */
 }
 
@@ -528,6 +558,8 @@ namespace _com_util
 /* Stop QGA VSS provider service using Winsvc API  */
 STDAPI StopService(void)
 {
+    PRINT_DEBUG_BEGIN;
+
     HRESULT hr = S_OK;
     SC_HANDLE manager = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
     SC_HANDLE service = NULL;
@@ -552,5 +584,6 @@ STDAPI StopService(void)
 out:
     CloseServiceHandle(service);
     CloseServiceHandle(manager);
+    PRINT_DEBUG_END;
     return hr;
 }
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index 1b885e24ee..4405fb00f1 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "vss-common.h"
+#include "vss-debug.h"
 #ifdef HAVE_VSS_SDK
 #include <vscoordint.h>
 #else
@@ -529,9 +530,11 @@ STDAPI DllCanUnloadNow()
 EXTERN_C
 BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved)
 {
+    PRINT_DEBUG("begin, reason = %lu", dwReason);
     if (dwReason == DLL_PROCESS_ATTACH) {
         g_hinstDll = hinstDll;
         DisableThreadLibraryCalls(hinstDll);
     }
+    PRINT_DEBUG_END;
     return TRUE;
 }
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 73c32381eb..38c15e4d87 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -57,6 +57,8 @@ static struct QGAVSSContext {
 
 STDAPI requester_init(void)
 {
+    PRINT_DEBUG_BEGIN;
+
     COMInitializer initializer; /* to call CoInitializeSecurity */
     HRESULT hr = CoInitializeSecurity(
         NULL, -1, NULL, NULL, RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
@@ -92,11 +94,14 @@ STDAPI requester_init(void)
         return HRESULT_FROM_WIN32(GetLastError());
     }
 
+    PRINT_DEBUG_END;
     return S_OK;
 }
 
 static void requester_cleanup(void)
 {
+    PRINT_DEBUG_BEGIN;
+
     if (vss_ctx.hEventFrozen) {
         CloseHandle(vss_ctx.hEventFrozen);
         vss_ctx.hEventFrozen = NULL;
@@ -118,10 +123,13 @@ static void requester_cleanup(void)
         vss_ctx.pVssbc = NULL;
     }
     vss_ctx.cFrozenVols = 0;
+    PRINT_DEBUG_END;
 }
 
 STDAPI requester_deinit(void)
 {
+    PRINT_DEBUG_BEGIN;
+
     requester_cleanup();
 
     pCreateVssBackupComponents = NULL;
@@ -131,11 +139,14 @@ STDAPI requester_deinit(void)
         hLib = NULL;
     }
 
+    PRINT_DEBUG_END;
     return S_OK;
 }
 
 static HRESULT WaitForAsync(IVssAsync *pAsync)
 {
+    PRINT_DEBUG_BEGIN;
+
     HRESULT ret, hr;
 
     do {
@@ -151,11 +162,14 @@ static HRESULT WaitForAsync(IVssAsync *pAsync)
         }
     } while (ret == VSS_S_ASYNC_PENDING);
 
+    PRINT_DEBUG_END;
     return ret;
 }
 
 static void AddComponents(ErrorSet *errset)
 {
+    PRINT_DEBUG_BEGIN;
+
     unsigned int cWriters, i;
     VSS_ID id, idInstance, idWriter;
     BSTR bstrWriterName = NULL;
@@ -237,17 +251,21 @@ out:
     if (pComponent && info) {
         pComponent->FreeComponentInfo(info);
     }
+    PRINT_DEBUG_END;
 }
 
 DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueName,
                           DWORD defaultData)
 {
+    PRINT_DEBUG_BEGIN;
+
     DWORD regGetValueError;
     DWORD dwordData;
     DWORD dataSize = sizeof(DWORD);
 
     regGetValueError = RegGetValue(baseKey, subKey, valueName, RRF_RT_DWORD,
                                    NULL, &dwordData, &dataSize);
+    PRINT_DEBUG_END;
     if (regGetValueError  != ERROR_SUCCESS) {
         return defaultData;
     }
@@ -262,6 +280,8 @@ bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)
 VSS_BACKUP_TYPE get_vss_backup_type(
     VSS_BACKUP_TYPE defaultVssBT = DEFAULT_VSS_BACKUP_TYPE)
 {
+    PRINT_DEBUG_BEGIN;
+
     VSS_BACKUP_TYPE vssBackupType;
 
     vssBackupType = static_cast<VSS_BACKUP_TYPE>(
@@ -269,6 +289,7 @@ VSS_BACKUP_TYPE get_vss_backup_type(
                                                 QGA_PROVIDER_REGISTRY_ADDRESS,
                                                 "VssOption",
                                                 defaultVssBT));
+    PRINT_DEBUG_END;
     if (!is_valid_vss_backup_type(vssBackupType)) {
         return defaultVssBT;
     }
@@ -277,6 +298,8 @@ VSS_BACKUP_TYPE get_vss_backup_type(
 
 void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
 {
+    PRINT_DEBUG_BEGIN;
+
     COMPointer<IVssAsync> pAsync;
     HANDLE volume;
     HRESULT hr;
@@ -292,6 +315,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
 
     if (vss_ctx.pVssbc) { /* already frozen */
         *num_vols = 0;
+        PRINT_DEBUG("finished, already frozen");
         return;
     }
 
@@ -449,6 +473,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
         }
     }
 
+    PRINT_DEBUG("preparing for backup");
     hr = vss_ctx.pVssbc->PrepareForBackup(pAsync.replace());
     if (SUCCEEDED(hr)) {
         hr = WaitForAsync(pAsync);
@@ -472,6 +497,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
      * CQGAVssProvider::CommitSnapshots will kick vss_ctx.hEventFrozen
      * after the applications and filesystems are frozen.
      */
+    PRINT_DEBUG("do snapshot set");
     hr = vss_ctx.pVssbc->DoSnapshotSet(&vss_ctx.pAsyncSnapshot);
     if (FAILED(hr)) {
         err_set(errset, hr, "failed to do snapshot set");
@@ -518,6 +544,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
         *num_vols = vss_ctx.cFrozenVols = num_fixed_drives;
     }
 
+    PRINT_DEBUG("end successful");
     return;
 
 out:
@@ -528,11 +555,14 @@ out:
 out1:
     requester_cleanup();
     CoUninitialize();
+
+    PRINT_DEBUG_END;
 }
 
 
 void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
 {
+    PRINT_DEBUG_BEGIN;
     COMPointer<IVssAsync> pAsync;
 
     if (!vss_ctx.hEventThaw) {
@@ -541,6 +571,8 @@ void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
          * and no volumes must be frozen. We return without an error.
          */
         *num_vols = 0;
+        PRINT_DEBUG("finished, no volumes were frozen");
+
         return;
     }
 
@@ -597,4 +629,6 @@ void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
 
     CoUninitialize();
     StopService();
+
+    PRINT_DEBUG_END;
 }
-- 
2.34.1


