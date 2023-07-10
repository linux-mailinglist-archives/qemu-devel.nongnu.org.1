Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA6474D3B8
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:39:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIoIF-0001Jh-2Z; Mon, 10 Jul 2023 06:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIoIC-0001Ix-IW
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIoI9-0006r2-Px
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688985532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=injIhs2pOH+utemLh9UhlTSPuWx9WWRbXnwOnycVvEU=;
 b=DRA6bcWHcqxnF01xGDcDk5EDxye7pQTUvOrpOw4jBNGaMDM2Vjbo5LaEFUh2pgvlNZzZjq
 ZRkaAa0X1xTBaA0bWd/IOknklgfLm+ejSMffwKt+Jy/5mskn1qF/pEIGefTpaiErTWMgg/
 9OzP1Hjl9KjoavSEErQPrt45xURwJ14=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-NLCDTNAIMze6JX7xc5c7sg-1; Mon, 10 Jul 2023 06:38:50 -0400
X-MC-Unique: NLCDTNAIMze6JX7xc5c7sg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6fbed5189so37885551fa.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 03:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688985529; x=1691577529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=injIhs2pOH+utemLh9UhlTSPuWx9WWRbXnwOnycVvEU=;
 b=O4j0H5vrS/zpwYBDIZMX0RHcn/qZjefZphOtx4mEjEkxduOA17QM2EKFVnNIHHMgB0
 9VqdhuxmjbLieiSi9yiIO+zKM/MI+ZupX+4YvgIQyDOrUGEpKR+x+WwrDCsqe0bobbvh
 A8OX9TY7e5SzScJSnNcbau0uXipleLsbVdvezA0l2DI0Os5yLUjQ/aylTM8+C5uNNweS
 FcR/V2HnO3+b8752uDZ49/xunFF1e1u6GaqrtNPPtfPGJ9aKJSJoN6j6y+4xc21jvjwJ
 LG+0R6et9Bz+5srTlZdQD8Y94boJDWY0kB9p1c4WOC48iUikqAf+Osjg2OIYqKV9GQKy
 Fvxg==
X-Gm-Message-State: ABy/qLZDvCDeeZdcjLErGqBWVdMFRvqGso83fcd7mvHlKpLIggJZlfq0
 HKoonb5bWFjQaXQy+eJOavBV7j9YlxVg9ZNaU/U3ds2fotZyTD4Hb8o/2DHoaxeAojPU68AKOlN
 iw+Jn0skKQ9UevdIOIYeMLVejQ3Y3+zg=
X-Received: by 2002:a2e:8782:0:b0:2b7:243e:a2 with SMTP id
 n2-20020a2e8782000000b002b7243e00a2mr293958lji.48.1688985529204; 
 Mon, 10 Jul 2023 03:38:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEUUciaBxBrOu155Tq7tCrhnYt05vbV4ohPK7WTkIH7o4e33bf7UVEBwdCwPOcKnz/lxVk/DbKPxDskclqqTrA=
X-Received: by 2002:a2e:8782:0:b0:2b7:243e:a2 with SMTP id
 n2-20020a2e8782000000b002b7243e00a2mr293944lji.48.1688985528859; 
 Mon, 10 Jul 2023 03:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230710091439.1010553-1-kkostiuk@redhat.com>
 <20230710091439.1010553-5-kkostiuk@redhat.com>
In-Reply-To: <20230710091439.1010553-5-kkostiuk@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 10 Jul 2023 13:38:37 +0300
Message-ID: <CAPMcbCq8LcQaaSptFzCaCcBs0qpss72GbLWkvSw22T7hwH9k9A@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] QGA VSS: Add log in functions begin/end
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007a959906001f9609"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000007a959906001f9609
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

Do you have any other comments about this commit?

On Mon, Jul 10, 2023 at 12:16=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redha=
t.com>
wrote:

> Add several qga_debug() statements in functions.
>
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/vss-win32/install.cpp   | 35 +++++++++++++++++++++++++++++++++++
>  qga/vss-win32/provider.cpp  |  3 +++
>  qga/vss-win32/requester.cpp | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index e03473d1a8..ae38662a62 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -100,6 +100,8 @@ HRESULT put_Value(ICatalogObject *pObj, LPCWSTR name,
> T val)
>  /* Lookup Administrators group name from winmgmt */
>  static HRESULT GetAdminName(_bstr_t *name)
>  {
> +    qga_debug_begin;
> +
>      HRESULT hr;
>      COMPointer<IWbemLocator> pLoc;
>      COMPointer<IWbemServices> pSvc;
> @@ -142,6 +144,7 @@ static HRESULT GetAdminName(_bstr_t *name)
>      }
>
>  out:
> +    qga_debug_end;
>      return hr;
>  }
>
> @@ -149,6 +152,8 @@ out:
>  static HRESULT getNameByStringSID(
>      const wchar_t *sid, LPWSTR buffer, LPDWORD bufferLen)
>  {
> +    qga_debug_begin;
> +
>      HRESULT hr =3D S_OK;
>      PSID psid =3D NULL;
>      SID_NAME_USE groupType;
> @@ -168,6 +173,7 @@ static HRESULT getNameByStringSID(
>      LocalFree(psid);
>
>  out:
> +    qga_debug_end;
>      return hr;
>  }
>
> @@ -175,6 +181,8 @@ out:
>  static HRESULT QGAProviderFind(
>      HRESULT (*found)(ICatalogCollection *, int, void *), void *arg)
>  {
> +    qga_debug_begin;
> +
>      HRESULT hr;
>      COMInitializer initializer;
>      COMPointer<IUnknown> pUnknown;
> @@ -205,41 +213,53 @@ static HRESULT QGAProviderFind(
>      chk(pColl->SaveChanges(&n));
>
>  out:
> +    qga_debug_end;
>      return hr;
>  }
>
>  /* Count QGA VSS provider in COM+ Application Catalog */
>  static HRESULT QGAProviderCount(ICatalogCollection *coll, int i, void
> *arg)
>  {
> +    qga_debug_begin;
> +
>      (*(int *)arg)++;
> +
> +    qga_debug_end;
>      return S_OK;
>  }
>
>  /* Remove QGA VSS provider from COM+ Application Catalog Collection */
>  static HRESULT QGAProviderRemove(ICatalogCollection *coll, int i, void
> *arg)
>  {
> +    qga_debug_begin;
>      HRESULT hr;
>
>      qga_debug("Removing COM+ Application: %s", QGA_PROVIDER_NAME);
>      chk(coll->Remove(i));
>  out:
> +    qga_debug_end;
>      return hr;
>  }
>
>  /* Unregister this module from COM+ Applications Catalog */
>  STDAPI COMUnregister(void)
>  {
> +    qga_debug_begin;
> +
>      HRESULT hr;
>
>      DllUnregisterServer();
>      chk(QGAProviderFind(QGAProviderRemove, NULL));
>  out:
> +    qga_debug_end;
>      return hr;
>  }
>
>  /* Register this module to COM+ Applications Catalog */
>  STDAPI COMRegister(void)
>  {
> +    qga_debug_begin;
> +
>      HRESULT hr;
>      COMInitializer initializer;
>      COMPointer<IUnknown> pUnknown;
> @@ -259,12 +279,14 @@ STDAPI COMRegister(void)
>
>      if (!g_hinstDll) {
>          errmsg(E_FAIL, "Failed to initialize DLL");
> +        qga_debug_end;
>          return E_FAIL;
>      }
>
>      chk(QGAProviderFind(QGAProviderCount, (void *)&count));
>      if (count) {
>          errmsg(E_ABORT, "QGA VSS Provider is already installed");
> +        qga_debug_end;
>          return E_ABORT;
>      }
>
> @@ -354,6 +376,7 @@ out:
>          COMUnregister();
>      }
>
> +    qga_debug_end;
>      return hr;
>  }
>
> @@ -369,6 +392,8 @@ STDAPI_(void) CALLBACK DLLCOMUnregister(HWND,
> HINSTANCE, LPSTR, int)
>
>  static BOOL CreateRegistryKey(LPCTSTR key, LPCTSTR value, LPCTSTR data)
>  {
> +    qga_debug_begin;
> +
>      HKEY  hKey;
>      LONG  ret;
>      DWORD size;
> @@ -389,6 +414,7 @@ static BOOL CreateRegistryKey(LPCTSTR key, LPCTSTR
> value, LPCTSTR data)
>      RegCloseKey(hKey);
>
>  out:
> +    qga_debug_end;
>      if (ret !=3D ERROR_SUCCESS) {
>          /* As we cannot printf within DllRegisterServer(), show a dialog=
.
> */
>          errmsg_dialog(ret, "Cannot add registry", key);
> @@ -400,6 +426,8 @@ out:
>  /* Register this dll as a VSS provider */
>  STDAPI DllRegisterServer(void)
>  {
> +    qga_debug_begin;
> +
>      COMInitializer initializer;
>      COMPointer<IVssAdmin> pVssAdmin;
>      HRESULT hr =3D E_FAIL;
> @@ -478,12 +506,15 @@ out:
>          DllUnregisterServer();
>      }
>
> +    qga_debug_end;
>      return hr;
>  }
>
>  /* Unregister this VSS hardware provider from the system */
>  STDAPI DllUnregisterServer(void)
>  {
> +    qga_debug_begin;
> +
>      TCHAR key[256];
>      COMInitializer initializer;
>      COMPointer<IVssAdmin> pVssAdmin;
> @@ -501,6 +532,7 @@ STDAPI DllUnregisterServer(void)
>      SHDeleteKey(HKEY_CLASSES_ROOT, key);
>      SHDeleteKey(HKEY_CLASSES_ROOT, g_szProgid);
>
> +    qga_debug_end;
>      return S_OK; /* Uninstall should never fail */
>  }
>
> @@ -527,6 +559,8 @@ namespace _com_util
>  /* Stop QGA VSS provider service using Winsvc API  */
>  STDAPI StopService(void)
>  {
> +    qga_debug_begin;
> +
>      HRESULT hr =3D S_OK;
>      SC_HANDLE manager =3D OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCES=
S);
>      SC_HANDLE service =3D NULL;
> @@ -551,5 +585,6 @@ STDAPI StopService(void)
>  out:
>      CloseServiceHandle(service);
>      CloseServiceHandle(manager);
> +    qga_debug_end;
>      return hr;
>  }
> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
> index 1b885e24ee..cc72e5ef1b 100644
> --- a/qga/vss-win32/provider.cpp
> +++ b/qga/vss-win32/provider.cpp
> @@ -12,6 +12,7 @@
>
>  #include "qemu/osdep.h"
>  #include "vss-common.h"
> +#include "vss-debug.h"
>  #ifdef HAVE_VSS_SDK
>  #include <vscoordint.h>
>  #else
> @@ -529,9 +530,11 @@ STDAPI DllCanUnloadNow()
>  EXTERN_C
>  BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserve=
d)
>  {
> +    qga_debug("begin, reason =3D %lu", dwReason);
>      if (dwReason =3D=3D DLL_PROCESS_ATTACH) {
>          g_hinstDll =3D hinstDll;
>          DisableThreadLibraryCalls(hinstDll);
>      }
> +    qga_debug_end;
>      return TRUE;
>  }
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index f3eafacfc1..9884c65e70 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -57,6 +57,8 @@ static struct QGAVSSContext {
>
>  STDAPI requester_init(void)
>  {
> +    qga_debug_begin;
> +
>      COMInitializer initializer; /* to call CoInitializeSecurity */
>      HRESULT hr =3D CoInitializeSecurity(
>          NULL, -1, NULL, NULL, RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
> @@ -92,11 +94,14 @@ STDAPI requester_init(void)
>          return HRESULT_FROM_WIN32(GetLastError());
>      }
>
> +    qga_debug_end;
>      return S_OK;
>  }
>
>  static void requester_cleanup(void)
>  {
> +    qga_debug_begin;
> +
>      if (vss_ctx.hEventFrozen) {
>          CloseHandle(vss_ctx.hEventFrozen);
>          vss_ctx.hEventFrozen =3D NULL;
> @@ -118,10 +123,13 @@ static void requester_cleanup(void)
>          vss_ctx.pVssbc =3D NULL;
>      }
>      vss_ctx.cFrozenVols =3D 0;
> +    qga_debug_end;
>  }
>
>  STDAPI requester_deinit(void)
>  {
> +    qga_debug_begin;
> +
>      requester_cleanup();
>
>      pCreateVssBackupComponents =3D NULL;
> @@ -131,11 +139,14 @@ STDAPI requester_deinit(void)
>          hLib =3D NULL;
>      }
>
> +    qga_debug_end;
>      return S_OK;
>  }
>
>  static HRESULT WaitForAsync(IVssAsync *pAsync)
>  {
> +    qga_debug_begin;
> +
>      HRESULT ret, hr;
>
>      do {
> @@ -151,11 +162,14 @@ static HRESULT WaitForAsync(IVssAsync *pAsync)
>          }
>      } while (ret =3D=3D VSS_S_ASYNC_PENDING);
>
> +    qga_debug_end;
>      return ret;
>  }
>
>  static void AddComponents(ErrorSet *errset)
>  {
> +    qga_debug_begin;
> +
>      unsigned int cWriters, i;
>      VSS_ID id, idInstance, idWriter;
>      BSTR bstrWriterName =3D NULL;
> @@ -237,17 +251,21 @@ out:
>      if (pComponent && info) {
>          pComponent->FreeComponentInfo(info);
>      }
> +    qga_debug_end;
>  }
>
>  DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueName,
>                            DWORD defaultData)
>  {
> +    qga_debug_begin;
> +
>      DWORD regGetValueError;
>      DWORD dwordData;
>      DWORD dataSize =3D sizeof(DWORD);
>
>      regGetValueError =3D RegGetValue(baseKey, subKey, valueName,
> RRF_RT_DWORD,
>                                     NULL, &dwordData, &dataSize);
> +    qga_debug_end;
>      if (regGetValueError  !=3D ERROR_SUCCESS) {
>          return defaultData;
>      }
> @@ -262,6 +280,8 @@ bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)
>  VSS_BACKUP_TYPE get_vss_backup_type(
>      VSS_BACKUP_TYPE defaultVssBT =3D DEFAULT_VSS_BACKUP_TYPE)
>  {
> +    qga_debug_begin;
> +
>      VSS_BACKUP_TYPE vssBackupType;
>
>      vssBackupType =3D static_cast<VSS_BACKUP_TYPE>(
> @@ -269,6 +289,7 @@ VSS_BACKUP_TYPE get_vss_backup_type(
>
>  QGA_PROVIDER_REGISTRY_ADDRESS,
>                                                  "VssOption",
>                                                  defaultVssBT));
> +    qga_debug_end;
>      if (!is_valid_vss_backup_type(vssBackupType)) {
>          return defaultVssBT;
>      }
> @@ -277,6 +298,8 @@ VSS_BACKUP_TYPE get_vss_backup_type(
>
>  void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset=
)
>  {
> +    qga_debug_begin;
> +
>      COMPointer<IVssAsync> pAsync;
>      HANDLE volume;
>      HRESULT hr;
> @@ -292,6 +315,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>
>      if (vss_ctx.pVssbc) { /* already frozen */
>          *num_vols =3D 0;
> +        qga_debug("finished, already frozen");
>          return;
>      }
>
> @@ -449,6 +473,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>          }
>      }
>
> +    qga_debug("preparing for backup");
>      hr =3D vss_ctx.pVssbc->PrepareForBackup(pAsync.replace());
>      if (SUCCEEDED(hr)) {
>          hr =3D WaitForAsync(pAsync);
> @@ -472,6 +497,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>       * CQGAVssProvider::CommitSnapshots will kick vss_ctx.hEventFrozen
>       * after the applications and filesystems are frozen.
>       */
> +    qga_debug("do snapshot set");
>      hr =3D vss_ctx.pVssbc->DoSnapshotSet(&vss_ctx.pAsyncSnapshot);
>      if (FAILED(hr)) {
>          err_set(errset, hr, "failed to do snapshot set");
> @@ -518,6 +544,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>          *num_vols =3D vss_ctx.cFrozenVols =3D num_fixed_drives;
>      }
>
> +    qga_debug("end successful");
>      return;
>
>  out:
> @@ -528,11 +555,14 @@ out:
>  out1:
>      requester_cleanup();
>      CoUninitialize();
> +
> +    qga_debug_end;
>  }
>
>
>  void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
>  {
> +    qga_debug_begin;
>      COMPointer<IVssAsync> pAsync;
>
>      if (!vss_ctx.hEventThaw) {
> @@ -541,6 +571,8 @@ void requester_thaw(int *num_vols, void *mountpints,
> ErrorSet *errset)
>           * and no volumes must be frozen. We return without an error.
>           */
>          *num_vols =3D 0;
> +        qga_debug("finished, no volumes were frozen");
> +
>          return;
>      }
>
> @@ -597,4 +629,6 @@ void requester_thaw(int *num_vols, void *mountpints,
> ErrorSet *errset)
>
>      CoUninitialize();
>      StopService();
> +
> +    qga_debug_end;
>  }
> --
> 2.34.1
>
>
>

--0000000000007a959906001f9609
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Thomas,</div><div><br></div><div>Do you have any o=
ther comments about this commit? <br></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 10, 2023 at 12:16=E2=
=80=AFPM Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkos=
tiuk@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Add several qga_debug() statements in functions.<br>
<br>
Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com=
" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/install.cpp=C2=A0 =C2=A0| 35 ++++++++++++++++++++++++++=
+++++++++<br>
=C2=A0qga/vss-win32/provider.cpp=C2=A0 |=C2=A0 3 +++<br>
=C2=A0qga/vss-win32/requester.cpp | 34 ++++++++++++++++++++++++++++++++++<b=
r>
=C2=A03 files changed, 72 insertions(+)<br>
<br>
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
index e03473d1a8..ae38662a62 100644<br>
--- a/qga/vss-win32/install.cpp<br>
+++ b/qga/vss-win32/install.cpp<br>
@@ -100,6 +100,8 @@ HRESULT put_Value(ICatalogObject *pObj, LPCWSTR name, T=
 val)<br>
=C2=A0/* Lookup Administrators group name from winmgmt */<br>
=C2=A0static HRESULT GetAdminName(_bstr_t *name)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;IWbemLocator&gt; pLoc;<br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;IWbemServices&gt; pSvc;<br>
@@ -142,6 +144,7 @@ static HRESULT GetAdminName(_bstr_t *name)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0out:<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return hr;<br>
=C2=A0}<br>
<br>
@@ -149,6 +152,8 @@ out:<br>
=C2=A0static HRESULT getNameByStringSID(<br>
=C2=A0 =C2=A0 =C2=A0const wchar_t *sid, LPWSTR buffer, LPDWORD bufferLen)<b=
r>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr =3D S_OK;<br>
=C2=A0 =C2=A0 =C2=A0PSID psid =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0SID_NAME_USE groupType;<br>
@@ -168,6 +173,7 @@ static HRESULT getNameByStringSID(<br>
=C2=A0 =C2=A0 =C2=A0LocalFree(psid);<br>
<br>
=C2=A0out:<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return hr;<br>
=C2=A0}<br>
<br>
@@ -175,6 +181,8 @@ out:<br>
=C2=A0static HRESULT QGAProviderFind(<br>
=C2=A0 =C2=A0 =C2=A0HRESULT (*found)(ICatalogCollection *, int, void *), vo=
id *arg)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
=C2=A0 =C2=A0 =C2=A0COMInitializer initializer;<br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;IUnknown&gt; pUnknown;<br>
@@ -205,41 +213,53 @@ static HRESULT QGAProviderFind(<br>
=C2=A0 =C2=A0 =C2=A0chk(pColl-&gt;SaveChanges(&amp;n));<br>
<br>
=C2=A0out:<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return hr;<br>
=C2=A0}<br>
<br>
=C2=A0/* Count QGA VSS provider in COM+ Application Catalog */<br>
=C2=A0static HRESULT QGAProviderCount(ICatalogCollection *coll, int i, void=
 *arg)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0(*(int *)arg)++;<br>
+<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return S_OK;<br>
=C2=A0}<br>
<br>
=C2=A0/* Remove QGA VSS provider from COM+ Application Catalog Collection *=
/<br>
=C2=A0static HRESULT QGAProviderRemove(ICatalogCollection *coll, int i, voi=
d *arg)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
<br>
=C2=A0 =C2=A0 =C2=A0qga_debug(&quot;Removing COM+ Application: %s&quot;, QG=
A_PROVIDER_NAME);<br>
=C2=A0 =C2=A0 =C2=A0chk(coll-&gt;Remove(i));<br>
=C2=A0out:<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return hr;<br>
=C2=A0}<br>
<br>
=C2=A0/* Unregister this module from COM+ Applications Catalog */<br>
=C2=A0STDAPI COMUnregister(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
<br>
=C2=A0 =C2=A0 =C2=A0DllUnregisterServer();<br>
=C2=A0 =C2=A0 =C2=A0chk(QGAProviderFind(QGAProviderRemove, NULL));<br>
=C2=A0out:<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return hr;<br>
=C2=A0}<br>
<br>
=C2=A0/* Register this module to COM+ Applications Catalog */<br>
=C2=A0STDAPI COMRegister(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
=C2=A0 =C2=A0 =C2=A0COMInitializer initializer;<br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;IUnknown&gt; pUnknown;<br>
@@ -259,12 +279,14 @@ STDAPI COMRegister(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!g_hinstDll) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errmsg(E_FAIL, &quot;Failed to initialize=
 DLL&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return E_FAIL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0chk(QGAProviderFind(QGAProviderCount, (void *)&amp;coun=
t));<br>
=C2=A0 =C2=A0 =C2=A0if (count) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errmsg(E_ABORT, &quot;QGA VSS Provider is=
 already installed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return E_ABORT;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -354,6 +376,7 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COMUnregister();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return hr;<br>
=C2=A0}<br>
<br>
@@ -369,6 +392,8 @@ STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE=
, LPSTR, int)<br>
<br>
=C2=A0static BOOL CreateRegistryKey(LPCTSTR key, LPCTSTR value, LPCTSTR dat=
a)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0HKEY=C2=A0 hKey;<br>
=C2=A0 =C2=A0 =C2=A0LONG=C2=A0 ret;<br>
=C2=A0 =C2=A0 =C2=A0DWORD size;<br>
@@ -389,6 +414,7 @@ static BOOL CreateRegistryKey(LPCTSTR key, LPCTSTR valu=
e, LPCTSTR data)<br>
=C2=A0 =C2=A0 =C2=A0RegCloseKey(hKey);<br>
<br>
=C2=A0out:<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0if (ret !=3D ERROR_SUCCESS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* As we cannot printf within DllRegister=
Server(), show a dialog. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errmsg_dialog(ret, &quot;Cannot add regis=
try&quot;, key);<br>
@@ -400,6 +426,8 @@ out:<br>
=C2=A0/* Register this dll as a VSS provider */<br>
=C2=A0STDAPI DllRegisterServer(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0COMInitializer initializer;<br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;IVssAdmin&gt; pVssAdmin;<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr =3D E_FAIL;<br>
@@ -478,12 +506,15 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DllUnregisterServer();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return hr;<br>
=C2=A0}<br>
<br>
=C2=A0/* Unregister this VSS hardware provider from the system */<br>
=C2=A0STDAPI DllUnregisterServer(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0TCHAR key[256];<br>
=C2=A0 =C2=A0 =C2=A0COMInitializer initializer;<br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;IVssAdmin&gt; pVssAdmin;<br>
@@ -501,6 +532,7 @@ STDAPI DllUnregisterServer(void)<br>
=C2=A0 =C2=A0 =C2=A0SHDeleteKey(HKEY_CLASSES_ROOT, key);<br>
=C2=A0 =C2=A0 =C2=A0SHDeleteKey(HKEY_CLASSES_ROOT, g_szProgid);<br>
<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return S_OK; /* Uninstall should never fail */<br>
=C2=A0}<br>
<br>
@@ -527,6 +559,8 @@ namespace _com_util<br>
=C2=A0/* Stop QGA VSS provider service using Winsvc API=C2=A0 */<br>
=C2=A0STDAPI StopService(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr =3D S_OK;<br>
=C2=A0 =C2=A0 =C2=A0SC_HANDLE manager =3D OpenSCManager(NULL, NULL, SC_MANA=
GER_ALL_ACCESS);<br>
=C2=A0 =C2=A0 =C2=A0SC_HANDLE service =3D NULL;<br>
@@ -551,5 +585,6 @@ STDAPI StopService(void)<br>
=C2=A0out:<br>
=C2=A0 =C2=A0 =C2=A0CloseServiceHandle(service);<br>
=C2=A0 =C2=A0 =C2=A0CloseServiceHandle(manager);<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return hr;<br>
=C2=A0}<br>
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp<br>
index 1b885e24ee..cc72e5ef1b 100644<br>
--- a/qga/vss-win32/provider.cpp<br>
+++ b/qga/vss-win32/provider.cpp<br>
@@ -12,6 +12,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;vss-common.h&quot;<br>
+#include &quot;vss-debug.h&quot;<br>
=C2=A0#ifdef HAVE_VSS_SDK<br>
=C2=A0#include &lt;vscoordint.h&gt;<br>
=C2=A0#else<br>
@@ -529,9 +530,11 @@ STDAPI DllCanUnloadNow()<br>
=C2=A0EXTERN_C<br>
=C2=A0BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpRese=
rved)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug(&quot;begin, reason =3D %lu&quot;, dwReason);<br>
=C2=A0 =C2=A0 =C2=A0if (dwReason =3D=3D DLL_PROCESS_ATTACH) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_hinstDll =3D hinstDll;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DisableThreadLibraryCalls(hinstDll);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return TRUE;<br>
=C2=A0}<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index f3eafacfc1..9884c65e70 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -57,6 +57,8 @@ static struct QGAVSSContext {<br>
<br>
=C2=A0STDAPI requester_init(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0COMInitializer initializer; /* to call CoInitializeSecu=
rity */<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr =3D CoInitializeSecurity(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, -1, NULL, NULL, RPC_C_AUTHN_LEVEL_P=
KT_PRIVACY,<br>
@@ -92,11 +94,14 @@ STDAPI requester_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return HRESULT_FROM_WIN32(GetLastError())=
;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return S_OK;<br>
=C2=A0}<br>
<br>
=C2=A0static void requester_cleanup(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (vss_ctx.hEventFrozen) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CloseHandle(vss_ctx.hEventFrozen);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vss_ctx.hEventFrozen =3D NULL;<br>
@@ -118,10 +123,13 @@ static void requester_cleanup(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vss_ctx.pVssbc =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0vss_ctx.cFrozenVols =3D 0;<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0}<br>
<br>
=C2=A0STDAPI requester_deinit(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0requester_cleanup();<br>
<br>
=C2=A0 =C2=A0 =C2=A0pCreateVssBackupComponents =3D NULL;<br>
@@ -131,11 +139,14 @@ STDAPI requester_deinit(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hLib =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return S_OK;<br>
=C2=A0}<br>
<br>
=C2=A0static HRESULT WaitForAsync(IVssAsync *pAsync)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0HRESULT ret, hr;<br>
<br>
=C2=A0 =C2=A0 =C2=A0do {<br>
@@ -151,11 +162,14 @@ static HRESULT WaitForAsync(IVssAsync *pAsync)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} while (ret =3D=3D VSS_S_ASYNC_PENDING);<br>
<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
=C2=A0static void AddComponents(ErrorSet *errset)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0unsigned int cWriters, i;<br>
=C2=A0 =C2=A0 =C2=A0VSS_ID id, idInstance, idWriter;<br>
=C2=A0 =C2=A0 =C2=A0BSTR bstrWriterName =3D NULL;<br>
@@ -237,17 +251,21 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0if (pComponent &amp;&amp; info) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pComponent-&gt;FreeComponentInfo(info);<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0}<br>
<br>
=C2=A0DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueNa=
me,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0DWORD defaultData)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0DWORD regGetValueError;<br>
=C2=A0 =C2=A0 =C2=A0DWORD dwordData;<br>
=C2=A0 =C2=A0 =C2=A0DWORD dataSize =3D sizeof(DWORD);<br>
<br>
=C2=A0 =C2=A0 =C2=A0regGetValueError =3D RegGetValue(baseKey, subKey, value=
Name, RRF_RT_DWORD,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, &amp;dwordData, =
&amp;dataSize);<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0if (regGetValueError=C2=A0 !=3D ERROR_SUCCESS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return defaultData;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -262,6 +280,8 @@ bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)<br=
>
=C2=A0VSS_BACKUP_TYPE get_vss_backup_type(<br>
=C2=A0 =C2=A0 =C2=A0VSS_BACKUP_TYPE defaultVssBT =3D DEFAULT_VSS_BACKUP_TYP=
E)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0VSS_BACKUP_TYPE vssBackupType;<br>
<br>
=C2=A0 =C2=A0 =C2=A0vssBackupType =3D static_cast&lt;VSS_BACKUP_TYPE&gt;(<b=
r>
@@ -269,6 +289,7 @@ VSS_BACKUP_TYPE get_vss_backup_type(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0QGA_PROVIDER_REGISTRY_ADDRESS,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;VssOption&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0defaultVssBT));<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0if (!is_valid_vss_backup_type(vssBackupType)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return defaultVssBT;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -277,6 +298,8 @@ VSS_BACKUP_TYPE get_vss_backup_type(<br>
<br>
=C2=A0void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *err=
set)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;IVssAsync&gt; pAsync;<br>
=C2=A0 =C2=A0 =C2=A0HANDLE volume;<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
@@ -292,6 +315,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (vss_ctx.pVssbc) { /* already frozen */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*num_vols =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug(&quot;finished, already frozen&quot;=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -449,6 +473,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 qga_debug(&quot;preparing for backup&quot;);<br>
=C2=A0 =C2=A0 =C2=A0hr =3D vss_ctx.pVssbc-&gt;PrepareForBackup(pAsync.repla=
ce());<br>
=C2=A0 =C2=A0 =C2=A0if (SUCCEEDED(hr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hr =3D WaitForAsync(pAsync);<br>
@@ -472,6 +497,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 * CQGAVssProvider::CommitSnapshots will kick vss_ctx.h=
EventFrozen<br>
=C2=A0 =C2=A0 =C2=A0 * after the applications and filesystems are frozen.<b=
r>
=C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 qga_debug(&quot;do snapshot set&quot;);<br>
=C2=A0 =C2=A0 =C2=A0hr =3D vss_ctx.pVssbc-&gt;DoSnapshotSet(&amp;vss_ctx.pA=
syncSnapshot);<br>
=C2=A0 =C2=A0 =C2=A0if (FAILED(hr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err_set(errset, hr, &quot;failed to do sn=
apshot set&quot;);<br>
@@ -518,6 +544,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*num_vols =3D vss_ctx.cFrozenVols =3D num=
_fixed_drives;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 qga_debug(&quot;end successful&quot;);<br>
=C2=A0 =C2=A0 =C2=A0return;<br>
<br>
=C2=A0out:<br>
@@ -528,11 +555,14 @@ out:<br>
=C2=A0out1:<br>
=C2=A0 =C2=A0 =C2=A0requester_cleanup();<br>
=C2=A0 =C2=A0 =C2=A0CoUninitialize();<br>
+<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0}<br>
<br>
<br>
=C2=A0void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset=
)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_debug_begin;<br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;IVssAsync&gt; pAsync;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!vss_ctx.hEventThaw) {<br>
@@ -541,6 +571,8 @@ void requester_thaw(int *num_vols, void *mountpints, Er=
rorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and no volumes must be frozen. We retu=
rn without an error.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*num_vols =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug(&quot;finished, no volumes were froz=
en&quot;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -597,4 +629,6 @@ void requester_thaw(int *num_vols, void *mountpints, Er=
rorSet *errset)<br>
<br>
=C2=A0 =C2=A0 =C2=A0CoUninitialize();<br>
=C2=A0 =C2=A0 =C2=A0StopService();<br>
+<br>
+=C2=A0 =C2=A0 qga_debug_end;<br>
=C2=A0}<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div>

--0000000000007a959906001f9609--


