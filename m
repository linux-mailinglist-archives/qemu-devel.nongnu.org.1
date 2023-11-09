Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 730257E6673
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 10:16:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1183-0004Jb-O6; Thu, 09 Nov 2023 04:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r1181-0004JS-D9
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:15:09 -0500
Received: from mail-lo4gbr01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:261a::700]
 helo=GBR01-LO4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r117z-0001pa-4J
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:15:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfIGTsKgbzGQfT3Qm/sO5L97hvd0qAAHdv0FKN9TQd5FpSVjjG+4oxsuVNN+C8vj+a8DcQ4LYQQLHNM8FP/l1V+GCuIAgEj9Q3F4r0/tzjR/lN6H7OiESW3cD3mvBQPuv6r+oUHWg2YohEu7U3KEyYaYJnLrHkgSGnKYsJ8aqIh13u4H5OKp4ZAGvn4It6s5wbq+N4qM8J8pe/SicgGGIJO2+DMPCiJ5QnFZO3guL/CQH97M7lIW7+jkSVL0WDJRqv7LmAO/xoDgDfo4Kvh5mra6Hj7Tbl16s7EhZ+RHadd0jHHhMD/avGAfG4K4wtT5QqV9mc4sh1CpmxbzQ444jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqvJuCEiREtovhOnfFvz9Wlw3eiAPngAkYWPt9zRQSo=;
 b=YmvvTiOzo1SIl8M6P7MPXXnR29eX2fHQg4Y28F0O2vqe+jVpwW3tIkOxc7VT8UdwrU2Jvpzrd225ayb3uYQbJaYdUMrf9p2DHbuATOF6u72KXK8pxQKKdF6cotKalHFvxMSf2U9JMbnRJ034MNqI9o+ULs8tvwl7c982w8/Wi07d3dZPxot3cGjesDuP6TY0YtaivTRR+QEo4yFh/QV4JY8l2Lm1XmedAJmEFobiW4ppUa8m3LAfb5nD/8MWcvzELvKWrvpJZ64kaTo0A5h8QdzvfHhlCMTK6ETcWbS6GBO5WSDYokOS9oC4gTby4U07bNRge8g3wHPuOBP9plGxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqvJuCEiREtovhOnfFvz9Wlw3eiAPngAkYWPt9zRQSo=;
 b=Asy3cioAqOUidPWi4GDbNngYx/JDSYooZrTdwbyCPshUGETlCvFcw/my+DggPxMecJei5C2NfG0uXGI5qzfXUg1ZOqbte1uiRo6FmiP498ELt9fd+ZFq/SeIuX3vyc+sa5KpnZ82SDDaRQswjASorOmpQumRU6PZBU/jRUMKB9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by LO4P123MB6610.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:279::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 09:15:01 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 09:15:01 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH] plugins: Move the windows linking function to qemu
Date: Thu,  9 Nov 2023 09:14:06 +0000
Message-ID: <20231109091453.589-1-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0197.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::13) To CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:d8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB4341:EE_|LO4P123MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 826f721e-6d57-4d9a-b9e8-08dbe1045a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwFCERZki7px8YHzr1TgA/pyw9X2nPGQFoir6fmcMI5cwPTpndL5jqTS+dYq0X55jFDx9gv1P3xDhGW2hI+t8KurnFGSREhHVFbn1LEnl4hnuWuEvcx+EKLJ+75cUswpH73V/tUcV34D6U9CFTqhFaPdfx/qIL1gc8OdW+k7/wKbYAr58KWYHebdZ/LQInVcJ4JcOw8IKpZTctVXjJphULK79ZExpb6iEKeWnHrMB72h4aIyeV8eGw5pIkwO7z2wfeEMDVEN5BLS9S6WglfA0C1JngirYo1WPSe7uaRw99BwtkWM4jNQYevD87GTEjrNhCHom6okQCk5jTsrTh4WGpAdVx9HSIIvE+okIBXhiH9xPJ+ZhCF1PF/Cj/FGhoiG3PmhAuzh3UaKDQeiVE/iXN20uLTVuDEJ8DPE8z7fdMiQ9NPo8K9PkzTM8xVVErSXI6N1B6UGd/VXWU8Ln4EkgME6p0xgJI+pGufFMRmq45sMf6NVOL71WmXyUfCGUD5OPZXQJIGZ7rY3SF5E5l+YP7pAy8FNB31woJdLNSR8BeIncgjxwOGzAhW8ymF26ejXOJ7UpTHbVhV2yuVQLl14k3N34dgitYu0SqyL3KrXWHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39840400004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38100700002)(2906002)(6486002)(966005)(478600001)(41300700001)(6506007)(45080400002)(54906003)(66476007)(66556008)(6916009)(66946007)(316002)(4326008)(8676002)(8936002)(19627235002)(5660300002)(6512007)(26005)(2616005)(1076003)(107886003)(86362001)(36756003)(83380400001)(460985005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BojPXLKw8naKPzEftjrBkqwN7UPyPq/rRvTFKtazZ+75jdQDruxpdD9Vk66s?=
 =?us-ascii?Q?BmI7LSkJ2Huifw8ErVpqf3ZaxJDqDMV3zsm4I9IbpTHcAi12lf75k0A1l+P/?=
 =?us-ascii?Q?3dvxEHoEEef3tFqHIuj5ot53Fnu3oMgFAcQrIvSdNKNm5+J4xMIAI7kGreWv?=
 =?us-ascii?Q?Q2m0dDDSF0cDK8/mrpdysMyb+OUUPUv6kv8NWYeGAOJBGXk7CpcGdwai+e+W?=
 =?us-ascii?Q?8aj/uXJh3+U1HhIey/vqRJH7EMaJDcXfdtWRhncmdxMenE8P09nyXI6rlagG?=
 =?us-ascii?Q?AZKR8TxuML/GxMx0vFg5TKfKEYQpIBVet+b86mkA4k24GPy+yk6IySa+DPrf?=
 =?us-ascii?Q?bJV2lRIj/zgHFU0q+MKhi/yrr/uxbW4XQJX6xPCNOBoVc3v+r/pTLWe8wovU?=
 =?us-ascii?Q?dwNC1UWBfqFKc7KtdrWk9foPLSEmSdNg/1itvkpAjShKoC802sN5ki2+amFR?=
 =?us-ascii?Q?y9/S/egw+2+8A+DzE8mq/yMTs9Zggnxj+J9+s5s05sGXMI50s7fJL25mkRKn?=
 =?us-ascii?Q?XTArZ1/QMOHj8TjvmYtO4injbYIMpmTVb77iJ0XKcdLhEKSxNngpyYfycSRE?=
 =?us-ascii?Q?QbqlooVMfubXhMImJ+2Qg33V0RsDijKhU539pwFIWyclAyCDziWkG+PWyOdZ?=
 =?us-ascii?Q?XpZQBRRaKLOvq/VdRBDW4xLXO4sIMgyIO8RgUD71O5bMOgfjGzaiky4t045L?=
 =?us-ascii?Q?LHWlSsqBRLvfzg00oFjBZK9wLtOF5n9SXQ8O0QtQ6zW26dkdJBrPDjuX6yLW?=
 =?us-ascii?Q?vrn2wdyI7VZbisVZkJQzqft8cczXQLePAg8v84ps3apULx5Hd5vC+7SuDl2r?=
 =?us-ascii?Q?Enw787avthh9v+u+XcFj02NZbcjpuhDKKaC3rxoZQR5R/s72sFCXB1Jht+fJ?=
 =?us-ascii?Q?Ky944IPyMADEj58JVhZcglsOhp+skuk0NF95dzOV+JkncCWasfOLze5e0jwL?=
 =?us-ascii?Q?gEdHdst3lxcSMjRRSAN9xVnhWiLnkAKh5xfaYZ8l1+/N27sZ/aXS6Hbj3OyE?=
 =?us-ascii?Q?UwAf+GAQDv+5Nj3ubIQzGOw6LvmrJcfW6vUkuiUgnxkq/ooO7UbZxWSxYmSF?=
 =?us-ascii?Q?+aRPfyIjLUhy6knMJbpvE3LRoAdwFisv/QmCjQISGqr7KVfTuBY5GLS1D6Ow?=
 =?us-ascii?Q?DHFmWgna1E6vGvxZ3+7WbO4EsGSTXYWMPoRMafu+h+d4Hqp6KIRyD+Q/yTeD?=
 =?us-ascii?Q?DZVisXZDWGoYKVK1cqQ6JYFVWYIvUNlIBiIu90p0adYG1r2BkZqKaf31ym55?=
 =?us-ascii?Q?hvJAJwxeBJywj1U2xdV1iRGojuOWguUunYSDKYP/B1OAoPZtD+qv3P8mud0t?=
 =?us-ascii?Q?Nm0pPUxmVBeJWiKR1/Ez+P23e8mQgCXODA7Enwc0Qrj9P/hLEHb5LQ+Z2Zps?=
 =?us-ascii?Q?oMCJ3xJ6n6rKkxt5uT/PuZFICgi/NERC1h9TDG3lyIe7N2mW1VNHckSaAp6B?=
 =?us-ascii?Q?3jJyEmGjApM6DtoWBC/KAGYEd3m52wjCvAAuFVxWdLmlvZFTFJeGKxVBNo22?=
 =?us-ascii?Q?9/mAaGKxXZ0fuJgAQHKgmqXz7PEbNdBiWES/t+LUfUAqe5CHNGvHkCwmgHr2?=
 =?us-ascii?Q?8YJv6btXyDEBIr48Lg1U/JILK5oBNZ0oSXIualaojoweiiFCxTYKlgxKW0bO?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826f721e-6d57-4d9a-b9e8-08dbe1045a4f
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:15:01.7595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGt9J1SeLK7wV06Q6RT1jXCgsNiilrUNEs6mmptOrj6yDyWullhRY0JQCuSQ34HbQcT+gy5epgT1JT8Lpc9iGKiSq6wnOxLoE2mFVMJU7Zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6610
Received-SPF: pass client-ip=2a01:111:f403:261a::700;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-LO4-obe.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_TRY_3LD=2 autolearn=no autolearn_force=no
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

Previously, a plugin author needed an implementation of the
__pfnDliFailureHook2 or __pfnDliNotifyHook2 hook in the plugin. Now all
they need is a null exported pointer with the right name
(win32_common.c). If QEMU finds this, it will set it to the hook
function, which has now moved into qemu (os-win32.c).
---
 contrib/plugins/win32_linker.c | 23 +++--------------------
 include/sysemu/os-win32.h      | 25 +++++++++++++++++++++++++
 os-win32.c                     | 33 +++++++++++++++++++++++++++++++++
 plugins/loader.c               |  3 +++
 4 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/contrib/plugins/win32_linker.c b/contrib/plugins/win32_linker.c
index 7534b2b8bf..619fdd38c8 100644
--- a/contrib/plugins/win32_linker.c
+++ b/contrib/plugins/win32_linker.c
@@ -4,8 +4,8 @@
  * This hook, __pfnDliFailureHook2, is documented in the microsoft documentation here:
  * https://learn.microsoft.com/en-us/cpp/build/reference/error-handling-and-notification
  * It gets called when a delay-loaded DLL encounters various errors.
- * We handle the specific case of a DLL looking for a "qemu.exe",
- * and give it the running executable (regardless of what it is named).
+ * QEMU will set it to a function which handles the specific case of a DLL looking for
+ * a "qemu.exe", and give it the running executable (regardless of what it is named).
  *
  * This work is licensed under the terms of the GNU LGPL, version 2 or later.
  * See the COPYING.LIB file in the top-level directory.
@@ -14,21 +14,4 @@
 #include <windows.h>
 #include <delayimp.h>
 
-FARPROC WINAPI dll_failure_hook(unsigned dliNotify, PDelayLoadInfo pdli);
-
-
-PfnDliHook __pfnDliFailureHook2 = dll_failure_hook;
-
-FARPROC WINAPI dll_failure_hook(unsigned dliNotify, PDelayLoadInfo pdli) {
-    if (dliNotify == dliFailLoadLib) {
-        /* If the failing request was for qemu.exe, ... */
-        if (strcmp(pdli->szDll, "qemu.exe") == 0) {
-            /* Then pass back a pointer to the top level module. */
-            HMODULE top = GetModuleHandle(NULL);
-            return (FARPROC) top;
-        }
-    }
-    /* Otherwise we can't do anything special. */
-    return 0;
-}
-
+__declspec(dllexport) PfnDliHook __pfnDliNotifyHook2 = NULL;
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index 1047d260cb..0f698554b2 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -30,6 +30,8 @@
 #include <windows.h>
 #include <ws2tcpip.h>
 #include "qemu/typedefs.h"
+#include <delayimp.h>
+#include <gmodule.h>
 
 #ifdef HAVE_AFUNIX_H
 #include <afunix.h>
@@ -265,6 +267,29 @@ win32_close_exception_handler(struct _EXCEPTION_RECORD*, void*,
 void *qemu_win32_map_alloc(size_t size, HANDLE *h, Error **errp);
 void qemu_win32_map_free(void *ptr, HANDLE h, Error **errp);
 
+
+/* dll_delaylink_hook:
+ * @dliNotify: Type of event that caused this callback.
+ * @pdli: Extra data about the DLL being loaded
+ *
+ * For more info on the arguments and when this gets invoked see
+ * https://learn.microsoft.com/en-us/cpp/build/reference/understanding-the-helper-function
+ *
+ * This is to be used on windows as the target of a __pfnDliNotifyHook2 or __pfnDliFailureHook2
+ * hook. If the DLL being loaded is 'qemu.exe', it instead passes back a pointer to the main
+ * executable This gets set into plugins to assist with the plugins delay-linking back to the main
+ * executable, if they define an appropriate symbol. */
+FARPROC WINAPI dll_delaylink_hook(unsigned dliNotify, PDelayLoadInfo pdli);
+
+/* set_dll_delaylink_hook:
+ * @mod: pointer to the DLL being loaded
+ *
+ * takes a pointer to a loaded plugin DLL, and tries to find a __pfnDliNotifyHook2 or
+ * __pfnDliFailureHook2 hook. If it finds either one, and its value is null, it sets it to the
+ * address fo dll_delaylink_hook.
+ */
+void set_dll_delaylink_hook(GModule *mod);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/os-win32.c b/os-win32.c
index 725ad652e8..4a113d1d10 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -60,3 +60,36 @@ void os_set_line_buffering(void)
     setbuf(stdout, NULL);
     setbuf(stderr, NULL);
 }
+
+FARPROC WINAPI dll_delaylink_hook(unsigned dliNotify, PDelayLoadInfo pdli) {
+    /* If we just tried, or are about to try to load a DLL ... */
+    if (dliNotify == dliFailLoadLib || dliNotify == dliNotePreLoadLibrary) {
+        /* ... if the failing request was for qemu.exe, ... */
+        if (strcmp(pdli->szDll, "qemu.exe") == 0) {
+            /* ... then pass back a pointer to the top level module. */
+            HMODULE top = GetModuleHandle(NULL);
+            return (FARPROC) top;
+        }
+    }
+    /* Otherwise we can't do anything special. */
+    return 0;
+}
+void set_dll_delaylink_hook(GModule *mod) {
+    /* find the __pfnDliFailureHook2 symbol in the DLL.
+     * if found, set it to our handler.
+     */
+    gpointer sym;
+    PfnDliHook *hook;
+    if (g_module_symbol(mod, "__pfnDliFailureHook2", &sym)) {
+        hook = (PfnDliHook*) sym;
+        if (hook != NULL && *hook == NULL) {
+            *hook = &dll_delaylink_hook;
+        }
+    }
+    if (g_module_symbol(mod, "__pfnDliNotifyHook2", &sym)) {
+        hook = (PfnDliHook*) sym;
+        if (hook != NULL && *hook == NULL) {
+            *hook = &dll_delaylink_hook;
+        }
+    }
+}
diff --git a/plugins/loader.c b/plugins/loader.c
index 734c11cae0..7ead9b26e4 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -241,6 +241,9 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info, E
     }
     QTAILQ_INSERT_TAIL(&plugin.ctxs, ctx, entry);
     ctx->installing = true;
+    #ifdef CONFIG_WIN32
+        set_dll_delaylink_hook(ctx->handle);
+    #endif
     rc = install(ctx->id, info, desc->argc, desc->argv);
     ctx->installing = false;
     if (rc) {
-- 
2.42.0.windows.1


