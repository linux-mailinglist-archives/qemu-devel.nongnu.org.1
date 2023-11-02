Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 922CB7DF8A1
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:24:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybP8-0004es-JK; Thu, 02 Nov 2023 13:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qybP5-0004dd-S0
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:22:47 -0400
Received: from mail-lo2gbr01on0707.outbound.protection.outlook.com
 ([2a01:111:f400:fe15::707]
 helo=GBR01-LO2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qybP4-0004ME-0s
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:22:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROTU/XlwM3KenxPXPmdG5vgXlcIhtlpOiEsOChsHGzORxouVVtyd5jL73OPqzuTUE16e0UPznIkSAFGiok70qN8/kgN82ioMJ4sUTMi4d+MrqDyldR6s5jc/EtWF7ws1O/8Nmx092hg3jNfyCrjDkTYuVZwZcgcFjyJGV2y1GvKTt3hdxDC7rTLA8VdDi52ZYzKSYn7Uwz6y4ov0I+tSoD2uDJxVtOT0vN4dkEfKzSzNBYhV72bsLhEWhd8Vn0d7e2rsLTfVWcsVQwrQa7+QP2b6+2n9bsOeQgnzoHjCsSk3WWwfvjGzVsiGh4p8uGnETL1akrxvnTNnjs818gakhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzW5ACAW5ubSA+9ssrRA0Vnz7MdMLMFnlWTB8yiQqq8=;
 b=CCwDnRsgc1jrS4F3kqQ2lvAtM1qKHC2LbLmHBjG2CsOI0DDpB/MHORI20k7h9jk3/PWEBGg7sgXtcmZe8wvvHJeq3x+ROVwladokg1BbFexqH+CWfKKYIAkhzYhBUncnA/NASZ6CH6a8/dMiPD5MLq9CC5Y/+JiCOqDa6xDhmmq+N15DzKDiw9QMmwrZOKYH7ySrtLlVUaHxSaQ1vw1hKjQMKOoqdIqlviaRtsxW36FEDeTT4Xo7qJp15RPYXWYWBCJA2pe8ibp1Iuavmyv1ibD63PH2R7FPbM+knDzMKQ5F557SiAcqQeh/gVdpJKuEDFco+H913kiX/8sho2cSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzW5ACAW5ubSA+9ssrRA0Vnz7MdMLMFnlWTB8yiQqq8=;
 b=lJ8/pPCAak0O0SQvBF1g9CMQIslyfX0IV/iV3hgWcWC1ZvL6cpfoh806I3GXeAD689P9tvch8Rq+rT7Ssgi1lMnWwbPRMOJcLTgWjg36X9XF/cbAsLXEMdhwxDnda3IeGL/qXn46gT/t8kQoJ2IgGtzM/EaJLe6M3qHpxau7cX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:19a::8)
 by CWXP123MB3365.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 17:22:37 +0000
Received: from LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a33f:4559:b41e:cea9]) by LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a33f:4559:b41e:cea9%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 17:22:37 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: luoyonggang@gmail.com, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v2 2/4] plugins: make test/example plugins work on windows
Date: Thu,  2 Nov 2023 17:19:45 +0000
Message-ID: <20231102172053.17692-3-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102172053.17692-1-gmanning@rapitasystems.com>
References: <20231102172053.17692-1-gmanning@rapitasystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::30) To LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:19a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4352:EE_|CWXP123MB3365:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ea0701-a020-4aa2-9205-08dbdbc84ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93pVrQcHmsh9FKejt7Kfa+nAyQLrT2NmvM59RPaBUXliPbSvfy0ZSrcxFrnVzzZTFB5PLcoqHBjvv6I+wxy5J0vCyJcu4mOkW6oIsTnBZZIKnvr+EYAaDVVEys3Jd/Q7r/b8gnqpILyJ4IhI8hdZq93ty9ePo32pIQJINxtCb+y52vdh3sUTGkNPEnXUob3gs9PmPlM6w6sChYNcl/C7fTAFj5FgJKFXmLTXZsI4ibVMmkAD4VqEni5lOvFWNbextS3aBwT6+5mAAIehClrRQ48cRlgEA7urRYXabks6EmY17URs6eNSxQDVvQ5Rj06lbtPd6YEgiDiAgfKYBu2jVnrwz8JFAB7ZXxjXh6ZymanN+lVQsJ6fm+N3+6fLuQEDe55FmJU5ufLOSpPf5yk9CNCmRy0soyC6kaHV1FY23EOOSikVtyjx8+E9ZukqOy9Hmn9bynoH9b2cUTAZfH/I4LNewfwyr7BvAoHxojYZKLlYGuR6mDFUpTQ5R2/ufp7rPuniBHT2ycloiGqBkXwaC9HiA7yB3nEBFkZ0KK/xkb6VOCIfTtFmRMy4KCpMJCzSHPm5u8qqIHQmHUucwioT4o/1nKmzcN39yd5il91P5rY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66556008)(54906003)(6916009)(66476007)(66946007)(316002)(6506007)(478600001)(1076003)(6666004)(107886003)(2616005)(4326008)(26005)(8936002)(83380400001)(8676002)(966005)(6486002)(19627235002)(45080400002)(6512007)(5660300002)(36756003)(2906002)(38100700002)(41300700001)(86362001)(460985005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wh3/T14oTseH4P16Tl8eQ9FX2v2ohf3d8Ln7By6Q1zZESnJ2LVTvcT6Jbqrn?=
 =?us-ascii?Q?VpksbmFFSHnKWHMysDi/1CUIb6ocW9reoMqJ6+Yid4r1yHFdrddbq5ae5jv+?=
 =?us-ascii?Q?Y9WPvq6Kl9qHQaTg6OQfXP4Sq5AH8IDfdiGowzoxQei3t1XDpXcjjMx96BBb?=
 =?us-ascii?Q?6Bq/GEcCwsrqoSxwdYuEtmlcU5Eb5y+y6vhHmk59gRsu30O3zItDvhblIFc5?=
 =?us-ascii?Q?sOlisMD0xBoWgUpiqJAr2PCjxeSMyTj/fOkaHTudDBDBnkBVIwIzhSzT4dHM?=
 =?us-ascii?Q?VEd7hOehbty8tDvUtHMclt41r+b9EFinOM7HWmrblJvfqSkyFP407DGkoPRN?=
 =?us-ascii?Q?EFGg2Fq96+3ajNIodglXidlse0tWUpwGyGvOiVGsw+6K0ps6aBm0ESZ5qxtd?=
 =?us-ascii?Q?r21vESVKR5Ziih2PdfoAj8B3LbI+Z0M1G2MdG9SdNdN8EKzulYSd469rN9PM?=
 =?us-ascii?Q?kMt6IizVniZt2ped39sTHvqHdkHxioXT5qevzchviin8Wu9Cg6xfTcMc3XFp?=
 =?us-ascii?Q?us8Lks15HiSbtbqP9nBciY3zgUkePD7WxBs02UfOhDYyaWUUpXKm+YDtIJnJ?=
 =?us-ascii?Q?yeAeKQqPahLxhPsu3g8yRz+hD4zvT+aPwvK0lNC9nAlBIL8tqUMKWtD9wSlZ?=
 =?us-ascii?Q?Z9uD5+1ryJeXFHdGZqtj81rXwRmWy/n8WirPkpYylUE0mhAUTDj4MtFFCrHi?=
 =?us-ascii?Q?yYpRBCQPFUt0vJlATjvS9davzdvqLayL2SRqUntYnRaauYnUenk60NHw7m+y?=
 =?us-ascii?Q?/NXdts0BH5Uc2vNQfVLk+4tX1zOGmmvvbCnz8R0bdUvU5Tlbemq9MRNJPdXe?=
 =?us-ascii?Q?aWTeGN7hJ5GR+On2uKqvuPUmi/vWKpH31LoVLx66OMXWV3sXFxZ6pMYRR2Tq?=
 =?us-ascii?Q?J9Xl1wubwItSJ62ZyqFfDKhhGQSLeKukgUAxqRLfFd8IykbinP6PG54oRKs6?=
 =?us-ascii?Q?1FKIHRClqUu/dHX3uh/qxSWE3LYceypdOIRQ12GlGcgHqaQ95gLXNaKJ4+Lb?=
 =?us-ascii?Q?P305+LeuqRjTl228Sgg7mLhjY+sTqnZ/aNypFOr3qftl5cyof26AkK+qA3O/?=
 =?us-ascii?Q?W1f/aEs8ilC7SD25Ztyp2SN4N7uX7R19OBrP/wdX73aQNuDLIFbmJT9n8tMz?=
 =?us-ascii?Q?D5fzv7JOXdPI5lMLXiZ1KC58svOYrKWNbd42DcJKM3xga+D7l1IJnj/fTXQD?=
 =?us-ascii?Q?h7hCr+soncgyy4sn91RkOZ0dN4FRkw1tD6cdj2PTKG9Mi6Vo4I0UqnwfnDG4?=
 =?us-ascii?Q?ScM5Ki4oYcnJr+tQN2y7fWRX1SiC0RkmndEZr+tjhK2+9sSLbzGZ080ts/DC?=
 =?us-ascii?Q?uqO41FpI+y8I4XShDzTjQMO8BtsW/rLo67GMCNBUddt9Yd2hvEqx/5I2dMRr?=
 =?us-ascii?Q?CwSDSlMLEBmaM6xZXVPtjEcMB+kgp1AT/2XktQCsEEKtn1EUf7M9/N7bXShE?=
 =?us-ascii?Q?+Rsnh8E5DFpKNX+TLZ8pGaDg/g6mDFWjp7Df58pDsC2VH7ojFarELGpTW8oZ?=
 =?us-ascii?Q?QTZdZCzRZMmkPTd1c4TvHrm4Nin+2IbGZ1FTPp/FDw8KQqNO84JEuv/RmPh0?=
 =?us-ascii?Q?tavhZuTH56cWZnDGQsUQKfzCj7u9j56Vzn9CiWqCF3Hy3wUSYxAPID8r0zE5?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ea0701-a020-4aa2-9205-08dbdbc84ef7
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:22:37.2330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwXlBy7KAeF7ehIyF5dvLwEwTcA44HTmlX1iE4k3w/osaaqmQYQ8gDz9bVaaBFAXTwOmuN39bq8es0zZsqi28Czvip9ye9sFH6kBphm8eZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3365
Received-SPF: pass client-ip=2a01:111:f400:fe15::707;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-LO2-obe.outbound.protection.outlook.com
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

Generate a qemu_plugin_api.lib delay import lib on windows, for
windows qemu plugins to link against.

Implement an example dll load fail hook to link up the API functions
correctly when a plugin is loaded on windows.

Update the build scripts for the test and example plugins to use these
things.

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
---
 configure                      |  3 +++
 contrib/plugins/Makefile       | 20 ++++++++++++++++----
 contrib/plugins/win32_linker.c | 34 ++++++++++++++++++++++++++++++++++
 plugins/meson.build            | 17 +++++++++++++++++
 tests/plugin/meson.build       | 14 +++++++++++---
 5 files changed, 81 insertions(+), 7 deletions(-)
 create mode 100644 contrib/plugins/win32_linker.c

diff --git a/configure b/configure
index f1456f6123..04f2cdd166 100755
--- a/configure
+++ b/configure
@@ -1662,6 +1662,9 @@ echo "CFLAGS=${CFLAGS-$default_cflags} $EXTRA_CFLAGS" >> contrib/plugins/$config
 if test "$targetos" = darwin; then
   echo "CONFIG_DARWIN=y" >> contrib/plugins/$config_host_mak
 fi
+if test "$targetos" = windows; then
+  echo "CONFIG_WIN32=y" >> contrib/plugins/$config_host_mak
+fi
 
 # tests/tcg configuration
 (config_host_mak=tests/tcg/config-host.mak
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 8ba78c7a32..751fa38619 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -22,7 +22,14 @@ NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
 
-SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
+ifeq ($(CONFIG_WIN32),y)
+SO_SUFFIX := .dll
+LDLIBS += $(shell $(PKG_CONFIG) --libs glib-2.0)
+else
+SO_SUFFIX := .so
+endif
+
+SONAMES := $(addsuffix $(SO_SUFFIX),$(addprefix lib,$(NAMES)))
 
 # The main QEMU uses Glib extensively so it's perfectly fine to use it
 # in plugins (which many example do).
@@ -35,15 +42,20 @@ all: $(SONAMES)
 %.o: %.c
 	$(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<
 
-lib%.so: %.o
-ifeq ($(CONFIG_DARWIN),y)
+ifeq ($(CONFIG_WIN32),y)
+lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/qemu_plugin_api.lib
+	$(CC) -shared -o $@ $^ $(LDLIBS)
+else ifeq ($(CONFIG_DARWIN),y)
+lib%$(SO_SUFFIX): %.o
 	$(CC) -bundle -Wl,-undefined,dynamic_lookup -o $@ $^ $(LDLIBS)
 else
+lib%$(SO_SUFFIX): %.o
 	$(CC) -shared -o $@ $^ $(LDLIBS)
 endif
 
+
 clean:
-	rm -f *.o *.so *.d
+	rm -f *.o *$(SO_SUFFIX) *.d
 	rm -Rf .libs
 
 .PHONY: all clean
diff --git a/contrib/plugins/win32_linker.c b/contrib/plugins/win32_linker.c
new file mode 100644
index 0000000000..50797d616e
--- /dev/null
+++ b/contrib/plugins/win32_linker.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2023, Greg Manning <gmanning@rapitasystems.com>
+ *
+ * This hook, __pfnDliFailureHook2, is documented in the microsoft documentation here:
+ * https://learn.microsoft.com/en-us/cpp/build/reference/error-handling-and-notification
+ * It gets called when a delay-loaded DLL encounters various errors.
+ * We handle the specific case of a DLL looking for a "qemu.exe",
+ * and give it the running executable (regardless of what it is named).
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include <Windows.h>
+#include <delayimp.h>
+
+FARPROC WINAPI dll_failure_hook(unsigned dliNotify, PDelayLoadInfo pdli);
+
+
+PfnDliHook __pfnDliFailureHook2 = dll_failure_hook;
+
+FARPROC WINAPI dll_failure_hook(unsigned dliNotify, PDelayLoadInfo pdli) {
+    if (dliNotify == dliFailLoadLib) {
+        /* If the failing request was for qemu.exe, ... */
+        if (strcmp(pdli->szDll, "qemu.exe") == 0) {
+            /* Then pass back a pointer to the top level module. */
+            HMODULE top = GetModuleHandle(NULL);
+            return (FARPROC) top;
+        }
+    }
+    /* Otherwise we can't do anything special. */
+    return 0;
+}
+
diff --git a/plugins/meson.build b/plugins/meson.build
index 71ed996ed3..8ed9fa270c 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -14,6 +14,23 @@ if not enable_modules
 endif
 
 if get_option('plugins')
+  if targetos == 'windows'
+    # Generate a .lib file for plugins to link against.
+    # First, create a .def file listing all the symbols a plugin should expect to have
+    # available in qemu
+    win32_plugin_def = configure_file(
+      input: files('qemu-plugins.symbols'),
+      output: 'qemu_plugin_api.def',
+      capture: true,
+      command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
+    # then use dlltool to assemble a delaylib.
+    win32_qemu_plugin_api_lib = configure_file(
+      input: win32_plugin_def,
+      output: 'qemu_plugin_api.lib',
+      command: ['dlltool', '--input-def', '@INPUT@',
+                '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
+    )
+  endif
   specific_ss.add(files(
     'loader.c',
     'core.c',
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
index 322cafcdf6..528bb9d86c 100644
--- a/tests/plugin/meson.build
+++ b/tests/plugin/meson.build
@@ -1,9 +1,17 @@
 t = []
 if get_option('plugins')
   foreach i : ['bb', 'empty', 'insn', 'mem', 'syscall']
-    t += shared_module(i, files(i + '.c'),
-                       include_directories: '../../include/qemu',
-                       dependencies: glib)
+    if targetos == 'windows'
+      t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
+                        include_directories: '../../include/qemu',
+                        objects: [win32_qemu_plugin_api_lib],
+                        dependencies: glib)
+
+    else
+      t += shared_module(i, files(i + '.c'),
+                        include_directories: '../../include/qemu',
+                        dependencies: glib)
+    endif
   endforeach
 endif
 if t.length() > 0
-- 
2.42.0


