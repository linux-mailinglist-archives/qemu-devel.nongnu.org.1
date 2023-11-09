Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA3E7E66B6
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 10:26:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r11Ii-0000c8-Mo; Thu, 09 Nov 2023 04:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r11Ih-0000bt-7k
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:26:11 -0500
Received: from mail-cwxgbr01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:261b::701]
 helo=GBR01-CWX-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r11If-0003nR-8q
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:26:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyY5zP47l56s6LFpj8kHrVefEWOIRvymEbRp76BTSn4XiSjz7kEPNDfu4BrvVZlXycRU4dEjpj83xILsM5bM9ZPfKhyg6PdEcKV381NjdxYUN9cJP1lN5UtiqMetK/+n9eKVPxYgMUmWhktRHH4f/fHSkwq26/Vg0JsfP6i3eLiQ6amdtPAZc8OUTtQuc13TiszPukp8pGG8efnGOFEDXfTbHsUGNEP2wW1XpMAPo1HvTi9HlhzdHepEVocvh+RagYkcnvzjAkOJOk6DI5WBGCQHH0sjCRu/sFnKHNgp+ANblJbDYXwPOF2KpDwfMUSb9g6jM/4M8/NBztA7jreK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6QHUZEywMS8mEGLjOg+nKtMZ+wr9AEwf9xvzjgy3hk=;
 b=QANtSleOnCJGVdzQyrkG1mswQILfBkAZqseDOOX5xCciUbLxYXj7uHeiPZscV831gWbnN/Po16KW4cNUB21SekdZbbAECz/oCxnCpYR0E5W4V9y14gsmPkpgquXOfiw7ofsdZknL0LsWs19Kov2R6Zuwsz8CscZtYrVxD+NzvLRUdkVBYkwXAMXbKZxswa7A/x164EBL/VYuJjGw468fy1V1Nz2bU4vvUB81T4DhsHiHCae3j9Emoh9KN84bNDGhIYIf17mboW6dCfcCnQRGPXn8yKGVSiPgZ8HeyTNxm9DJiJBfC5IQ0RMgCDfkHWv8FTu3CnbTprt7hggApGfM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6QHUZEywMS8mEGLjOg+nKtMZ+wr9AEwf9xvzjgy3hk=;
 b=aDISjXhq+FRnLJ/5VgJjTGgProL9q+IrYK3QPml9ha727Gt5QsGShSReglW94ArKT23Nuh2spD4PYLpVAvt1hcEFjlV0/MeSzaHx72G3P/d5RHdW2fDLXah3g6XhL6M3xg/D0dg21eseLClre/n5A6XSV0A/XbnO4TD2Q9VMxGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by LO4P123MB6881.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 09:26:02 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 09:26:02 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v2 1/1] plugins: Move the windows linking function to qemu
Date: Thu,  9 Nov 2023 09:25:47 +0000
Message-ID: <20231109092554.1253-2-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0.windows.1
In-Reply-To: <20231109092554.1253-1-gmanning@rapitasystems.com>
References: <20231109092554.1253-1-gmanning@rapitasystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::13) To CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:d8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB4341:EE_|LO4P123MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 48831faf-be0c-453c-423c-08dbe105e411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQTJB8WT54Z3MlAj5vY4PpDxm9uZYEF5n3TBFg7XuPQRV13Gb92IxHb+TNUxVYaU3DMZ0P7rRYbupADq2KcRbsp1bUjJi81KUNvaINgF1a8pUEo4BpPNdhxnXeMFzU94rAf8Fx9SC2QJd+WxYaAcNtP91rmePVtMgziXuv00OmVlx9MoEzKsQt5I7CmYrqAdT00zAwR0fdhPejgcdaoTiTEbfcPE/bgLbCqtNfn+vyUIT3k+YPKhyYPas/y8Du+0bFVDhTXe2M/G0BNVR/WelVwcnuhrPBciZv+KazDGBDpmtFHW1Yrrhig49yz+oTu5snusEVCMx+gDrQKSAYO6OPHDTJOA2OFn57Fc2yPmOITqYl/IzKhb4ggMQ1WI1s422BASFbnh//Hk+ZCWXVMH2SwohjIKfvkUHEC6AYZ3WSGr/DxnMWzQj7S7WrRti7th5/83KX568BVYWv8RL/HRX84fKCMQcr3Q2MFfUGk9qmgsS/tC4sL0jm37B+xxCqFQSqfxheG292w+DXtv73ZPTJBV999IwRGzlROnrpDTyay5eOV/sXbAvwwIUtYGvtsnC5G8XsUJi6t9f3rcfeCWnaBdOcJPtSOvpZ+UpxXnQwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(346002)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(19627235002)(38100700002)(26005)(6916009)(478600001)(66946007)(66556008)(54906003)(66476007)(83380400001)(316002)(966005)(6486002)(41300700001)(4326008)(45080400002)(8936002)(8676002)(2616005)(6666004)(2906002)(1076003)(86362001)(107886003)(6506007)(5660300002)(6512007)(36756003)(460985005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sphLWkZuxiW22PYOkOFJ8+K8/noOJ9HzohotZToQDcy6Ut1qExYXn1LbQ8OB?=
 =?us-ascii?Q?r1jWWapZVYOd2sz7snOQBnbLt8+9rfNyUVhonJxnZa1sZ/zr5iP/pbvcLKvS?=
 =?us-ascii?Q?5pMPATq95LQah9qC7ay4Y/Pqrk47froBI5jFLn8zWBFmkybNv/nvHWnL6S6u?=
 =?us-ascii?Q?u4/U1wDpIFRG6LDnHw+J1s5yYuzG6UKACm9VDkLIAvZCXegszQof0lwXyEPI?=
 =?us-ascii?Q?RmowCqGFaix3Ch8OY8BSG6PqW3ObcIikrNE4y92/AzaDXy/k5WXX6pAT4zws?=
 =?us-ascii?Q?QmxKwYxT1SLiawaEv+qec1s6NRlgCGXSl7gX261gmVED51CgMkW+xr+RVf1h?=
 =?us-ascii?Q?+I4lUA+yUz/r2b2BL8ev4tWBYRVI5tuuk5LM35Svgy15E4poSZ1hb/tqCY04?=
 =?us-ascii?Q?/Tr668jyr/KsIBB6ZAFQErOvEh7/hqzuHMWM2W+/URY8NAtWnL3wuOxHkuX/?=
 =?us-ascii?Q?e/nRPJl74IHDjjv1ccneKBtWvLshPEXivvRgoDE7fndexXhAXXl/XIPy3vCM?=
 =?us-ascii?Q?4IBfWGESY+OfGk0dwkQ+wwZbhYpc92GExLwUE/rlR5+VBdUwu7BgwmgXEKeu?=
 =?us-ascii?Q?QQAF3MhkXS4rc/NMKHhGzEMlIU2BYUukJGvXh3PxtJLc30OW+Q1qF9zrpdV3?=
 =?us-ascii?Q?86VbFNis+1DhZAA1C1UxfxZHYWeEm38gOC1X1c24e4z3MEysxr2rQj0sl5ZG?=
 =?us-ascii?Q?9Aho1voLxqzNE/DnfwH06sQA4aYR3HYP6AacF/q69PusS29rffg9EGXyocNI?=
 =?us-ascii?Q?f4xtlH+T/KHsnUg3zckG8wura5eA5ppj1sI6KkjUmUeHQLgSFtYy/XK1o85N?=
 =?us-ascii?Q?yeykYM+XSXZAXYqMBypwYppwLjBh82McjIVdPppdKJgY12cdOAsjYWbqzcsR?=
 =?us-ascii?Q?VkFl+OAjolziZO1Itw9rLh5R343HH+ih55c/oeaBfzY967Pm/GdVxUSY4SfX?=
 =?us-ascii?Q?faF8UR1RfAlRI4KOo/tB6ZAmpXUHHtJh7/B0hZjP3i55bqDg4GYI0/+kL3K+?=
 =?us-ascii?Q?AmKCHfrzyeobvsSyvJbsfZ2tcFGuFK+OorNjroZsxBHk0q3r/Ga1tuT3Ovnu?=
 =?us-ascii?Q?/g788gjUDL0bySp1SzPDLACqXRgbRibSCS47hplh3I6UUrAeR7R2Yfo8MHoH?=
 =?us-ascii?Q?eADH9eas06NYxCdy4Udf5KZ8IKtPEhee8iqDbRLWXgcnDlQWaKYaAqWFRi4B?=
 =?us-ascii?Q?fQzfuBALD1ojbExA2jgxSxhEnlxiW1ALKgS8phIp4FCASftLZ0sQS5dU+P/v?=
 =?us-ascii?Q?vSQTYHKcvBc9izTJGWx0qTHf2eMFcjKGWBe8VuJcdaS6Ez4/J8qKFdELnCC7?=
 =?us-ascii?Q?yQ0OkAiFD9Wa5e+ogsSR0d3rw1LcNDRTUQwjnB9nh6LLUDaJFqRokkuj/0p0?=
 =?us-ascii?Q?pjYa74yD8UFJx9qCrGcmsu2u9lP+b0IIuW3r61e+1BKaqdvI6rAtKvBPZpNq?=
 =?us-ascii?Q?ikug29lHXqYealb7FojHdDbFcO8CMVqWy2XnzgG23TQa23pW6zpdvbIOlfWA?=
 =?us-ascii?Q?l2OLOtlhoeEO8M4HiXNoHBUx4EMTI95qscBlmuwg35Ot6nsod1KItnwX+ViZ?=
 =?us-ascii?Q?7h2Leb3oIrQQ55kROMChjQYw9AS7zzjYEZ1be6tqy47HfvibMiVjUUQGQqFr?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48831faf-be0c-453c-423c-08dbe105e411
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:26:02.2037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKsnwJ3N5BnKXbzKl2bX0lj9F4861HnojqZR8daLjXzhD0JXprG1YQyYyCi+MnUDbfTL3WhclhnmBJU7VIIXpYQea86SVsXeyQOO/RXcwow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6881
Received-SPF: pass client-ip=2a01:111:f403:261b::701;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-CWX-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
they need is a null exported pointer with the right name (as in
win32_linker.c). If QEMU finds this, it will set it to the hook
function, which has now moved into qemu (os-win32.c).

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
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


