Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B97974D789
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:29:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqwK-0005Nu-02; Mon, 10 Jul 2023 09:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIqwH-0005NK-1J
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIqwF-0007CT-Ds
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688995706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7aRBiFZBrzRWk2bgkW6A6GYILqG4nuSsFVT11qbE54=;
 b=NKGF9hIzv36J1/sTtVCEL1L2xlH/SnDK+Qarn62GNPxzfH5ofmkJ1770/5jaSUgbL0Rs/2
 c60cgERWtLoHkgwXtzyF8zVQCKIwpJeMcV+LQsUWqcOc2oNAwhPQBEEGaETY2vaH1kcUIJ
 wM55p1Xq8KP/J0oJ3O78YYF6fFHO45o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-YY0ftcr-P4CaduAoY0Antg-1; Mon, 10 Jul 2023 09:28:21 -0400
X-MC-Unique: YY0ftcr-P4CaduAoY0Antg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEB428DBB40;
 Mon, 10 Jul 2023 13:28:20 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08608111E3E4;
 Mon, 10 Jul 2023 13:28:19 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 5/7] QGA VSS: Replace 'fprintf(stderr' with qga_debug
Date: Mon, 10 Jul 2023 16:28:08 +0300
Message-Id: <20230710132810.1049912-6-kkostiuk@redhat.com>
In-Reply-To: <20230710132810.1049912-1-kkostiuk@redhat.com>
References: <20230710132810.1049912-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/install.cpp   | 12 ++++++------
 qga/vss-win32/requester.cpp |  9 +++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index ff93b08a9e..e03473d1a8 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 
 #include "vss-common.h"
+#include "vss-debug.h"
 #ifdef HAVE_VSS_SDK
 #include <vscoordint.h>
 #else
@@ -54,7 +55,7 @@ void errmsg(DWORD err, const char *text)
                   FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
                   NULL, err, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                   (char *)&msg, 0, NULL);
-    fprintf(stderr, "%.*s. (Error: %lx) %s\n", len, text, err, msg);
+    qga_debug("%.*s. (Error: %lx) %s", len, text, err, msg);
     LocalFree(msg);
 }
 
@@ -219,7 +220,7 @@ static HRESULT QGAProviderRemove(ICatalogCollection *coll, int i, void *arg)
 {
     HRESULT hr;
 
-    fprintf(stderr, "Removing COM+ Application: %s\n", QGA_PROVIDER_NAME);
+    qga_debug("Removing COM+ Application: %s", QGA_PROVIDER_NAME);
     chk(coll->Remove(i));
 out:
     return hr;
@@ -304,9 +305,8 @@ STDAPI COMRegister(void)
     }
     strcpy(tlbPath, dllPath);
     strcpy(tlbPath+n-3, "tlb");
-    fprintf(stderr, "Registering " QGA_PROVIDER_NAME ":\n");
-    fprintf(stderr, "  %s\n", dllPath);
-    fprintf(stderr, "  %s\n", tlbPath);
+    qga_debug("Registering " QGA_PROVIDER_NAME ": %s %s",
+              dllPath, tlbPath);
     if (!PathFileExists(tlbPath)) {
         hr = HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND);
         errmsg(hr, "Failed to lookup tlb");
@@ -517,7 +517,7 @@ namespace _com_util
         }
 
         if (mbstowcs(bstr, ascii, len) == (size_t)-1) {
-            fprintf(stderr, "Failed to convert string '%s' into BSTR", ascii);
+            qga_debug("Failed to convert string '%s' into BSTR", ascii);
             bstr[0] = 0;
         }
         return bstr;
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 3e998af4a8..e85b9bc633 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "vss-common.h"
+#include "vss-debug.h"
 #include "requester.h"
 #include "install.h"
 #include <vswriter.h>
@@ -59,13 +60,13 @@ STDAPI requester_init(void)
         NULL, -1, NULL, NULL, RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
         RPC_C_IMP_LEVEL_IDENTIFY, NULL, EOAC_NONE, NULL);
     if (FAILED(hr)) {
-        fprintf(stderr, "failed to CoInitializeSecurity (error %lx)\n", hr);
+        qga_debug("failed to CoInitializeSecurity (error %lx)", hr);
         return hr;
     }
 
     hLib = LoadLibraryA("VSSAPI.DLL");
     if (!hLib) {
-        fprintf(stderr, "failed to load VSSAPI.DLL\n");
+        qga_debug("failed to load VSSAPI.DLL");
         return HRESULT_FROM_WIN32(GetLastError());
     }
 
@@ -78,14 +79,14 @@ STDAPI requester_init(void)
 #endif
         );
     if (!pCreateVssBackupComponents) {
-        fprintf(stderr, "failed to get proc address from VSSAPI.DLL\n");
+        qga_debug("failed to get proc address from VSSAPI.DLL");
         return HRESULT_FROM_WIN32(GetLastError());
     }
 
     pVssFreeSnapshotProperties = (t_VssFreeSnapshotProperties)
         GetProcAddress(hLib, "VssFreeSnapshotProperties");
     if (!pVssFreeSnapshotProperties) {
-        fprintf(stderr, "failed to get proc address from VSSAPI.DLL\n");
+        qga_debug("failed to get proc address from VSSAPI.DLL");
         return HRESULT_FROM_WIN32(GetLastError());
     }
 
-- 
2.34.1


