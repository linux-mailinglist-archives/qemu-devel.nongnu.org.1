Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D39DA74ADC2
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:24:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhgR-000783-US; Fri, 07 Jul 2023 05:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHhgI-000772-Bz
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:23:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHhgE-0001K7-MD
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688721789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OO+o+a37PP66k1jdVxoprix7n0gXr/Z8ptkEq4BJeUg=;
 b=glaMir8RroTy0g2nr870g43rDjxrGT3NXBRSnwIAc23u08dBuuvqq3PhpTdWVyR9kqHve3
 U+WzL1SgMYqLgmbWQ8PNdFD/YLymJdpPfmt5uxUX48h+BXerQ90k9oiG9Nu0dY7OPow/Xl
 NbxDNsf5fUEzI2zwh4yGhgvwpCpwxoI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-MMbzCcRjNHO8t_A3X39HJA-1; Fri, 07 Jul 2023 05:23:08 -0400
X-MC-Unique: MMbzCcRjNHO8t_A3X39HJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BB7285A58A;
 Fri,  7 Jul 2023 09:23:08 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C106D4067A00;
 Fri,  7 Jul 2023 09:23:06 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/4] QGA VSS: Add log in functions begin/end
Date: Fri,  7 Jul 2023 12:22:58 +0300
Message-Id: <20230707092258.768420-5-kkostiuk@redhat.com>
In-Reply-To: <20230707092258.768420-1-kkostiuk@redhat.com>
References: <20230707092258.768420-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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
index 9bd2c52b70..6865c04d8a 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -100,6 +100,8 @@ HRESULT put_Value(ICatalogObject *pObj, LPCWSTR name, T val)
 /* Lookup Administrators group name from winmgmt */
 static HRESULT GetAdminName(_bstr_t *name)
 {
+    qga_debug_begin;
+
     HRESULT hr;
     COMPointer<IWbemLocator> pLoc;
     COMPointer<IWbemServices> pSvc;
@@ -142,6 +144,7 @@ static HRESULT GetAdminName(_bstr_t *name)
     }
 
 out:
+    qga_debug_end;
     return hr;
 }
 
@@ -149,6 +152,8 @@ out:
 static HRESULT getNameByStringSID(
     const wchar_t *sid, LPWSTR buffer, LPDWORD bufferLen)
 {
+    qga_debug_begin;
+
     HRESULT hr = S_OK;
     PSID psid = NULL;
     SID_NAME_USE groupType;
@@ -168,6 +173,7 @@ static HRESULT getNameByStringSID(
     LocalFree(psid);
 
 out:
+    qga_debug_end;
     return hr;
 }
 
@@ -175,6 +181,8 @@ out:
 static HRESULT QGAProviderFind(
     HRESULT (*found)(ICatalogCollection *, int, void *), void *arg)
 {
+    qga_debug_begin;
+
     HRESULT hr;
     COMInitializer initializer;
     COMPointer<IUnknown> pUnknown;
@@ -205,12 +213,15 @@ static HRESULT QGAProviderFind(
     chk(pColl->SaveChanges(&n));
 
 out:
+    qga_debug_end;
     return hr;
 }
 
 /* Count QGA VSS provider in COM+ Application Catalog */
 static HRESULT QGAProviderCount(ICatalogCollection *coll, int i, void *arg)
 {
+    qga_debug_begin;
+
     (*(int *)arg)++;
     return S_OK;
 }
@@ -218,28 +229,35 @@ static HRESULT QGAProviderCount(ICatalogCollection *coll, int i, void *arg)
 /* Remove QGA VSS provider from COM+ Application Catalog Collection */
 static HRESULT QGAProviderRemove(ICatalogCollection *coll, int i, void *arg)
 {
+    qga_debug_begin;
     HRESULT hr;
 
     qga_debug("Removing COM+ Application: %s", QGA_PROVIDER_NAME);
     chk(coll->Remove(i));
 out:
+    qga_debug_end;
     return hr;
 }
 
 /* Unregister this module from COM+ Applications Catalog */
 STDAPI COMUnregister(void)
 {
+    qga_debug_begin;
+
     HRESULT hr;
 
     DllUnregisterServer();
     chk(QGAProviderFind(QGAProviderRemove, NULL));
 out:
+    qga_debug_end;
     return hr;
 }
 
 /* Register this module to COM+ Applications Catalog */
 STDAPI COMRegister(void)
 {
+    qga_debug_begin;
+
     HRESULT hr;
     COMInitializer initializer;
     COMPointer<IUnknown> pUnknown;
@@ -259,12 +277,14 @@ STDAPI COMRegister(void)
 
     if (!g_hinstDll) {
         errmsg(E_FAIL, "Failed to initialize DLL");
+        qga_debug_end;
         return E_FAIL;
     }
 
     chk(QGAProviderFind(QGAProviderCount, (void *)&count));
     if (count) {
         errmsg(E_ABORT, "QGA VSS Provider is already installed");
+        qga_debug_end;
         return E_ABORT;
     }
 
@@ -354,6 +374,7 @@ out:
         COMUnregister();
     }
 
+    qga_debug_end;
     return hr;
 }
 
@@ -369,6 +390,8 @@ STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int)
 
 static BOOL CreateRegistryKey(LPCTSTR key, LPCTSTR value, LPCTSTR data)
 {
+    qga_debug_begin;
+
     HKEY  hKey;
     LONG  ret;
     DWORD size;
@@ -389,6 +412,7 @@ static BOOL CreateRegistryKey(LPCTSTR key, LPCTSTR value, LPCTSTR data)
     RegCloseKey(hKey);
 
 out:
+    qga_debug_end;
     if (ret != ERROR_SUCCESS) {
         /* As we cannot printf within DllRegisterServer(), show a dialog. */
         errmsg_dialog(ret, "Cannot add registry", key);
@@ -400,6 +424,8 @@ out:
 /* Register this dll as a VSS provider */
 STDAPI DllRegisterServer(void)
 {
+    qga_debug_begin;
+
     COMInitializer initializer;
     COMPointer<IVssAdmin> pVssAdmin;
     HRESULT hr = E_FAIL;
@@ -478,12 +504,15 @@ out:
         DllUnregisterServer();
     }
 
+    qga_debug_end;
     return hr;
 }
 
 /* Unregister this VSS hardware provider from the system */
 STDAPI DllUnregisterServer(void)
 {
+    qga_debug_begin;
+
     TCHAR key[256];
     COMInitializer initializer;
     COMPointer<IVssAdmin> pVssAdmin;
@@ -501,6 +530,7 @@ STDAPI DllUnregisterServer(void)
     SHDeleteKey(HKEY_CLASSES_ROOT, key);
     SHDeleteKey(HKEY_CLASSES_ROOT, g_szProgid);
 
+    qga_debug_end;
     return S_OK; /* Uninstall should never fail */
 }
 
@@ -527,6 +557,8 @@ namespace _com_util
 /* Stop QGA VSS provider service using Winsvc API  */
 STDAPI StopService(void)
 {
+    qga_debug_begin;
+
     HRESULT hr = S_OK;
     SC_HANDLE manager = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
     SC_HANDLE service = NULL;
@@ -551,5 +583,6 @@ STDAPI StopService(void)
 out:
     CloseServiceHandle(service);
     CloseServiceHandle(manager);
+    qga_debug_end;
     return hr;
 }
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index 1b885e24ee..cc72e5ef1b 100644
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
+    qga_debug("begin, reason = %lu", dwReason);
     if (dwReason == DLL_PROCESS_ATTACH) {
         g_hinstDll = hinstDll;
         DisableThreadLibraryCalls(hinstDll);
     }
+    qga_debug_end;
     return TRUE;
 }
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index f3eafacfc1..9884c65e70 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -57,6 +57,8 @@ static struct QGAVSSContext {
 
 STDAPI requester_init(void)
 {
+    qga_debug_begin;
+
     COMInitializer initializer; /* to call CoInitializeSecurity */
     HRESULT hr = CoInitializeSecurity(
         NULL, -1, NULL, NULL, RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
@@ -92,11 +94,14 @@ STDAPI requester_init(void)
         return HRESULT_FROM_WIN32(GetLastError());
     }
 
+    qga_debug_end;
     return S_OK;
 }
 
 static void requester_cleanup(void)
 {
+    qga_debug_begin;
+
     if (vss_ctx.hEventFrozen) {
         CloseHandle(vss_ctx.hEventFrozen);
         vss_ctx.hEventFrozen = NULL;
@@ -118,10 +123,13 @@ static void requester_cleanup(void)
         vss_ctx.pVssbc = NULL;
     }
     vss_ctx.cFrozenVols = 0;
+    qga_debug_end;
 }
 
 STDAPI requester_deinit(void)
 {
+    qga_debug_begin;
+
     requester_cleanup();
 
     pCreateVssBackupComponents = NULL;
@@ -131,11 +139,14 @@ STDAPI requester_deinit(void)
         hLib = NULL;
     }
 
+    qga_debug_end;
     return S_OK;
 }
 
 static HRESULT WaitForAsync(IVssAsync *pAsync)
 {
+    qga_debug_begin;
+
     HRESULT ret, hr;
 
     do {
@@ -151,11 +162,14 @@ static HRESULT WaitForAsync(IVssAsync *pAsync)
         }
     } while (ret == VSS_S_ASYNC_PENDING);
 
+    qga_debug_end;
     return ret;
 }
 
 static void AddComponents(ErrorSet *errset)
 {
+    qga_debug_begin;
+
     unsigned int cWriters, i;
     VSS_ID id, idInstance, idWriter;
     BSTR bstrWriterName = NULL;
@@ -237,17 +251,21 @@ out:
     if (pComponent && info) {
         pComponent->FreeComponentInfo(info);
     }
+    qga_debug_end;
 }
 
 DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueName,
                           DWORD defaultData)
 {
+    qga_debug_begin;
+
     DWORD regGetValueError;
     DWORD dwordData;
     DWORD dataSize = sizeof(DWORD);
 
     regGetValueError = RegGetValue(baseKey, subKey, valueName, RRF_RT_DWORD,
                                    NULL, &dwordData, &dataSize);
+    qga_debug_end;
     if (regGetValueError  != ERROR_SUCCESS) {
         return defaultData;
     }
@@ -262,6 +280,8 @@ bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)
 VSS_BACKUP_TYPE get_vss_backup_type(
     VSS_BACKUP_TYPE defaultVssBT = DEFAULT_VSS_BACKUP_TYPE)
 {
+    qga_debug_begin;
+
     VSS_BACKUP_TYPE vssBackupType;
 
     vssBackupType = static_cast<VSS_BACKUP_TYPE>(
@@ -269,6 +289,7 @@ VSS_BACKUP_TYPE get_vss_backup_type(
                                                 QGA_PROVIDER_REGISTRY_ADDRESS,
                                                 "VssOption",
                                                 defaultVssBT));
+    qga_debug_end;
     if (!is_valid_vss_backup_type(vssBackupType)) {
         return defaultVssBT;
     }
@@ -277,6 +298,8 @@ VSS_BACKUP_TYPE get_vss_backup_type(
 
 void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
 {
+    qga_debug_begin;
+
     COMPointer<IVssAsync> pAsync;
     HANDLE volume;
     HRESULT hr;
@@ -292,6 +315,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
 
     if (vss_ctx.pVssbc) { /* already frozen */
         *num_vols = 0;
+        qga_debug("finished, already frozen");
         return;
     }
 
@@ -449,6 +473,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
         }
     }
 
+    qga_debug("preparing for backup");
     hr = vss_ctx.pVssbc->PrepareForBackup(pAsync.replace());
     if (SUCCEEDED(hr)) {
         hr = WaitForAsync(pAsync);
@@ -472,6 +497,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
      * CQGAVssProvider::CommitSnapshots will kick vss_ctx.hEventFrozen
      * after the applications and filesystems are frozen.
      */
+    qga_debug("do snapshot set");
     hr = vss_ctx.pVssbc->DoSnapshotSet(&vss_ctx.pAsyncSnapshot);
     if (FAILED(hr)) {
         err_set(errset, hr, "failed to do snapshot set");
@@ -518,6 +544,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
         *num_vols = vss_ctx.cFrozenVols = num_fixed_drives;
     }
 
+    qga_debug("end successful");
     return;
 
 out:
@@ -528,11 +555,14 @@ out:
 out1:
     requester_cleanup();
     CoUninitialize();
+
+    qga_debug_end;
 }
 
 
 void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
 {
+    qga_debug_begin;
     COMPointer<IVssAsync> pAsync;
 
     if (!vss_ctx.hEventThaw) {
@@ -541,6 +571,8 @@ void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
          * and no volumes must be frozen. We return without an error.
          */
         *num_vols = 0;
+        qga_debug("finished, no volumes were frozen");
+
         return;
     }
 
@@ -597,4 +629,6 @@ void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
 
     CoUninitialize();
     StopService();
+
+    qga_debug_end;
 }
-- 
2.34.1


