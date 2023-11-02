Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A47DF0C7
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:01:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVS4-0008JI-RC; Thu, 02 Nov 2023 07:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qyVS2-0008J1-EZ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:01:26 -0400
Received: from mail-lo4gbr01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:261a::701]
 helo=GBR01-LO4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qyVRz-00018c-1e
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:01:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8BnlV3wf7PL55VZ71s7oCkjr+DLQTZ7s8LUoRxU4NOPFclrp69gmZ2WgfTVEPkM0UZFefIBPG8ooFf0RINzubSr8QccAxGxyPubTjD5JKh1402SfeCLpIfA0sGT8yeRdJs51dieglXwv0oZSfRe1s5y8XEckfZrAQehfs9aWP8r87iYYF4VPaawVlUEvDe3pctKAxfy3lCqpdfYTbSVS9kvixOHzfPdbJ2Ua2MxRc1JMY90PQOin78z0hYZ3MQO6GX5eGJvLWVC2gbIAZ6EdfhQACgvtYI7x3mQUTc2T9ot56OLkIyC7fm6vycrrFpLv4JT7vhMvJwd1RW+s74FRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaxluWWc86sWznRHakV/CNYtTlfvFEZmWaPpzNKMQ4k=;
 b=eaVhQkvBOOgnTVxYD3wLeNy1ihkec1/iIOd6tQ/LusNBfMdVM2ogrYff0xd5rEF51qkKUNXqoHMMelWNxq464SJHCym53Yz6Rf5X6HCTBF71VW96w16UaHTYXIhQuKP6v8N0+lEO6G3vphEy1nf/zRbIhoSJtmoBxznkq9AYdoGFyXYR5uY9fgpG7uSaNpO4TmscOZ46nyg+UR5b8pT8yHkQzqgxf54uGWbGVsg/ptF4KT9zvIQ66quKTxb1UBA3MuonOvDXD+mdTf02pJxhIRCCGvFfmyvkBSvxRcF8EJmqEB6lBjap+gcaEj7K+WiowOW7yqUps5BdiBwFG/LH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaxluWWc86sWznRHakV/CNYtTlfvFEZmWaPpzNKMQ4k=;
 b=alchbMlA6gEFF73fRgVQFKlp0l7fpBzjrrfdhJm/IP1GDwVKRgIiDT8QSRW60qvpCBBDbikLtFmU+sqio8JZPMdTYYsU8scWaF/2J8+hO7RYKFzc5PuShDmGx4FlKJNWWM3E07Wv+whY3xXmoGNv/vGEe1heHcHBwbKwJxwCBRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by LOYP123MB2832.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 11:00:47 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1e33:b4ba:d19a:8236]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1e33:b4ba:d19a:8236%6]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 11:00:47 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: luoyonggang@gmail.com, richard.henderson@linaro.org,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH 1/1] plugins: enable plugins for windows
Date: Thu,  2 Nov 2023 10:59:42 +0000
Message-ID: <20231102110016.9494-2-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102110016.9494-1-gmanning@rapitasystems.com>
References: <20231102110016.9494-1-gmanning@rapitasystems.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:d8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB4341:EE_|LOYP123MB2832:EE_
X-MS-Office365-Filtering-Correlation-Id: 3418cfec-4178-4d0d-27e6-08dbdb92f7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GChMrnt3hgzZIKBwK0uIrSus9AJ+DLPya3XtZL4oflXDBflXco0dA34XU2DJSXnLmx3V+Gn32yvOv9PIB1rgdEbbmTwMU8CWI+IrIzuSJT2EypErHU0onEqFkLRcA3LQ79WuzFKgIUnjfOx3494J9i2b0cNI3Bs/wJ99cbgX4bAfDDTVhLLbfj2ml/3T1fDxAVvV2NE6cp5y8mCudbu1wJPXBBomAKc7ug5Q8EpBXIMbmdgXLHLf/XJ6AnSje93zC57Keq1Na3IQXVpB996luETIvmVTszmi7/nnQMqkT2KMhMgqTfs6Lqrfe/P7E60Cq+Pc980Sp5xFcA5IXm4ESlJDCfFexb89eO3td1dCgR9+zBycRXUwErW5qjmVnv4psioIm+CBHjwkptFTKiDxdhrlwR734ffDgrdhdSLPFNb85zakC7OOUyUZcWfKwnVk2ZKDu/p3WtVSTaNPPJyTDBulKxvzig5KQCgums/piSkLpDn2zrQT3M8YhsZjtclNQNbw4skEMKI7PxeZB/O7SO5ypLLqkUNoRpEG0KztEiQ3sUTNd2ok3ji95Juj48QhFoeI1lHnpJPKixzmNDyNWIWRomTK2z6AfhqxzlTFIrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(39840400004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66946007)(66556008)(66476007)(316002)(6916009)(6506007)(2616005)(6512007)(36756003)(26005)(107886003)(1076003)(6666004)(45080400002)(38100700002)(86362001)(83380400001)(966005)(6486002)(478600001)(19627235002)(5660300002)(41300700001)(30864003)(2906002)(8936002)(66899024)(8676002)(4326008)(460985005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dw0102fsdBw7YOWhTipvOswg/bUpHbIK/aaiKs0yFxda8e0CDom4bBr8dqPS?=
 =?us-ascii?Q?4++FV0PBa4RtIX7R2/LO/KbNAX5lQ1Rh/KbgLI2hLO6WK/6wzKiN2yzcAyi1?=
 =?us-ascii?Q?P1iRtFqQlCVBHJQKNN+b3gGR2emHSH1UReLF3Xx2DqsioDLFy6gCWDsLkR6z?=
 =?us-ascii?Q?fWxK/cuHOzWSlz0dfP8YKPLsnO1US3GV6funrqwiuL4exMonFsR9/P0QJdf/?=
 =?us-ascii?Q?yxlcmD2qFyv7boSotEfzOSL1HDGtFE9wGYatOQ/tWgxdsKznhZ0FGlijCnLc?=
 =?us-ascii?Q?Pcw5vtlNFnPV30MSrIRndtChxII9Hkkm5HEx7AdztuvBlK3a+GAssY+IuBYU?=
 =?us-ascii?Q?YqCX7M8mZIqg2wWiNDwnI5wChweyASET7T7ygbi48MDw5JS99wo1R6Pceaq/?=
 =?us-ascii?Q?II69wsgJZ3wV4O2/0uBiocZcHyw/vYbr6khdbB7aXBwBOA/+ZXpvGo60HXpD?=
 =?us-ascii?Q?H4LMEoTz6eK7+LyVJlKZReZWKpCV8yWYHlbv+66Fe6Ex8Ee8etb+qXsAJyOn?=
 =?us-ascii?Q?aesZKKkRr2ot/Dsael8X6QgEICZA8BWB7XTm9TmJl1LYHRKyK9HJMog0jn5k?=
 =?us-ascii?Q?twjnbJjpkD1BJZKUbesldxQBMT3t6RD5Rc/t+3ShvNgk+N409nRIbzUr98b6?=
 =?us-ascii?Q?1CRKaU2/fhZ3+cBsjySkpuXCqgeBR9V8aHP/iMELTau/6gtv5a+70ifpwyMN?=
 =?us-ascii?Q?BNkPuoKAkYoLPhA7E2PhNeAOE6q1O6wGBesftoorGz6ZIM9SYgQYokUK2dlJ?=
 =?us-ascii?Q?oluFNuGlZfqmO7aUPRahlazpdkg089tMF2AFvTx6NaKIeWLXHSSQXObMJfSs?=
 =?us-ascii?Q?xDdtEzjUfR8no+QjVTLVe6hFZyF9IIRq0nCY7D3X3BmY9JSLRfYQ8dlzK/U4?=
 =?us-ascii?Q?EoNGdDyd9yRQXfmmjx6irN2VaqP/JWdbmS+7h4FTqcxG3gLwfjpSwl/dbsO9?=
 =?us-ascii?Q?LsqU7aveCjWccsnd4nCGT4ixUoNX6HoUbBSvAjU9+Q3ZUsXS2tK3xbUsthBc?=
 =?us-ascii?Q?3FELO1GwZz4n4EqdbE8R+yjCeh8KK59LO8tim9N1+0d/NQ1Gge1O3p3LklQ7?=
 =?us-ascii?Q?i8dt7UQgfGQ5f/a9/xlnKRx3Lun/DayR7Y2Dl1XPF9hLqAgHhB4erbLcAR93?=
 =?us-ascii?Q?Ef+YyTG/dTVO3M8m4xmn4FrBov1e1lxnkckRA32XHBEfdF9K+LL/gxaFSTqh?=
 =?us-ascii?Q?XLS1b46ihSkzAZyazhtkPfjtXGI7eF9cQnhT963o6mRi1S9ubeVIN8inzSdY?=
 =?us-ascii?Q?TnARtO3NzUkPsgvwoBk5gS+3mRZ1Ksvexro9jSQnf6sZTkhzNNWYcIZ6rAY2?=
 =?us-ascii?Q?Rnv24WyR9Gd4qowM5rgXJlu7ANyw1EOu/05BAxte4mZwAtdZHRALICBKZmyi?=
 =?us-ascii?Q?xr2g5A+MEc0/XoDkbsSvo4DD/jCo4YY7VvIauVoS8kfSGXxAm8Xr70uIcUtv?=
 =?us-ascii?Q?oHDXaGT0tGlEImpYzWPTY3sk0EpQMyLf0uKksU5ZjAlqaIVo4sldyre+B7cT?=
 =?us-ascii?Q?Zi7LUGJe0vAEy3wegiYKAKgNU9cbzU+ktSa8zBgxEHQTD2m9b8I1t44yZ/E7?=
 =?us-ascii?Q?PE+tD77O45QIKRcUXXmYl+l72USvDsZj3/95PECSwwEgxerOLcbFYMVOh//h?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3418cfec-4178-4d0d-27e6-08dbdb92f7e0
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:00:47.5644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1x5+NXarJfLBQAzaN36r82kOIUwEP7jQ97Gk52oRZL6mU5phmMceleDhnjecRz/LW9RZ3iukrnpe0XVrPZ3yEO1YwCUJGnl4uovd3EaN764=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2832
Received-SPF: pass client-ip=2a01:111:f403:261a::701;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-LO4-obe.outbound.protection.outlook.com
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

Enable plugins for windows, including updating the example plugins to
compile and work on windows (except lockstep.c, which uses unix sockets)

In qemu-plugin.h, mark all API functions as __declspec(dllexport) when
compiling the executables, and as __declspec(dllimport) when being used
to compile plugins against.

Generate a qemu_plugin_api.lib delay import lib on windows, for
windows qemu plugins to link against.

Implement an example dll load fail hook to link up the API functions
correctly when a plugin is loaded on windows.

Build system changes to get the plugins in contrib/plugins and
test/plugin to compile correctly on windows

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
---
 configure                      |  9 ++----
 contrib/plugins/Makefile       | 27 ++++++++++++++++--
 contrib/plugins/win32_linker.c | 34 +++++++++++++++++++++++
 include/qemu/qemu-plugin.h     | 50 ++++++++++++++++++++++++++++++++--
 meson.build                    |  5 ++++
 plugins/meson.build            | 17 ++++++++++++
 tests/plugin/meson.build       | 14 ++++++++--
 7 files changed, 141 insertions(+), 15 deletions(-)
 create mode 100644 contrib/plugins/win32_linker.c

diff --git a/configure b/configure
index f1456f6123..1129e6dd94 100755
--- a/configure
+++ b/configure
@@ -1010,12 +1010,6 @@ if test "$targetos" =3D "bogus"; then
 fi

 # test for any invalid configuration combinations
-if test "$targetos" =3D "windows"; then
-  if test "$plugins" =3D "yes"; then
-    error_exit "TCG plugins not currently supported on Windows platforms"
-  fi
-  plugins=3D"no"
-fi
 if test "$tcg" =3D "disabled" ; then
   if test "$plugins" =3D "yes"; then
     error_exit "Can't enable plugins on non-TCG builds"
@@ -1662,6 +1656,9 @@ echo "CFLAGS=3D${CFLAGS-$default_cflags} $EXTRA_CFLAG=
S" >> contrib/plugins/$config
 if test "$targetos" =3D darwin; then
   echo "CONFIG_DARWIN=3Dy" >> contrib/plugins/$config_host_mak
 fi
+if test "$targetos" =3D windows; then
+  echo "CONFIG_WIN32=3Dy" >> contrib/plugins/$config_host_mak
+fi

 # tests/tcg configuration
 (config_host_mak=3Dtests/tcg/config-host.mak
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 8ba78c7a32..c319d6862b 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -17,12 +17,25 @@ NAMES +=3D execlog
 NAMES +=3D hotblocks
 NAMES +=3D hotpages
 NAMES +=3D howvec
+
+# The lockstep example communicates using unix sockets,
+# and can't be easily made to work on windows.
+ifneq ($(CONFIG_WIN32),y)
 NAMES +=3D lockstep
+endif
+
 NAMES +=3D hwprofile
 NAMES +=3D cache
 NAMES +=3D drcov

-SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
+ifeq ($(CONFIG_WIN32),y)
+SO_SUFFIX :=3D .dll
+LDLIBS +=3D $(shell $(PKG_CONFIG) --libs glib-2.0)
+else
+SO_SUFFIX :=3D .so
+endif
+
+SONAMES :=3D $(addsuffix $(SO_SUFFIX),$(addprefix lib,$(NAMES)))

 # The main QEMU uses Glib extensively so it's perfectly fine to use it
 # in plugins (which many example do).
@@ -35,15 +48,23 @@ all: $(SONAMES)
 %.o: %.c
        $(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<

-lib%.so: %.o
+ifeq ($(CONFIG_WIN32),y)
+lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/qemu_plugin_api.lib
+       $(CC) -shared -o $@ $^ $(LDLIBS)
+else
+
+lib%$(SO_SUFFIX): %.o
 ifeq ($(CONFIG_DARWIN),y)
        $(CC) -bundle -Wl,-undefined,dynamic_lookup -o $@ $^ $(LDLIBS)
 else
        $(CC) -shared -o $@ $^ $(LDLIBS)
 endif

+endif
+
+
 clean:
-       rm -f *.o *.so *.d
+       rm -f *.o *$(SO_SUFFIX) *.d
        rm -Rf .libs

 .PHONY: all clean
diff --git a/contrib/plugins/win32_linker.c b/contrib/plugins/win32_linker.=
c
new file mode 100644
index 0000000000..50797d616e
--- /dev/null
+++ b/contrib/plugins/win32_linker.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2023, Greg Manning <gmanning@rapitasystems.com>
+ *
+ * This hook, __pfnDliFailureHook2, is documented in the microsoft documen=
tation here:
+ * https://learn.microsoft.com/en-us/cpp/build/reference/error-handling-an=
d-notification
+ * It gets called when a delay-loaded DLL encounters various errors.
+ * We handle the specific case of a DLL looking for a "qemu.exe",
+ * and give it the running executable (regardless of what it is named).
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or lat=
er.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include <Windows.h>
+#include <delayimp.h>
+
+FARPROC WINAPI dll_failure_hook(unsigned dliNotify, PDelayLoadInfo pdli);
+
+
+PfnDliHook __pfnDliFailureHook2 =3D dll_failure_hook;
+
+FARPROC WINAPI dll_failure_hook(unsigned dliNotify, PDelayLoadInfo pdli) {
+    if (dliNotify =3D=3D dliFailLoadLib) {
+        /* If the failing request was for qemu.exe, ... */
+        if (strcmp(pdli->szDll, "qemu.exe") =3D=3D 0) {
+            /* Then pass back a pointer to the top level module. */
+            HMODULE top =3D GetModuleHandle(NULL);
+            return (FARPROC) top;
+        }
+    }
+    /* Otherwise we can't do anything special. */
+    return 0;
+}
+
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 50a9957279..4daab6efd2 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -22,15 +22,18 @@
  *   https://gcc.gnu.org/wiki/Visibility
  */
 #if defined _WIN32 || defined __CYGWIN__
-  #ifdef BUILDING_DLL
-    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
-  #else
+  #ifdef CONFIG_PLUGIN
     #define QEMU_PLUGIN_EXPORT __declspec(dllimport)
+    #define QEMU_PLUGIN_API __declspec(dllexport)
+  #else
+    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
+    #define QEMU_PLUGIN_API __declspec(dllimport)
   #endif
   #define QEMU_PLUGIN_LOCAL
 #else
   #define QEMU_PLUGIN_EXPORT __attribute__((visibility("default")))
   #define QEMU_PLUGIN_LOCAL  __attribute__((visibility("hidden")))
+  #define QEMU_PLUGIN_API
 #endif

 /**
@@ -147,6 +150,7 @@ typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned in=
t vcpu_index,
  *
  * Note: Calling this function from qemu_plugin_install() is a bug.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb=
);

 /**
@@ -160,6 +164,7 @@ void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_pl=
ugin_simple_cb_t cb);
  * Plugins are reset asynchronously, and therefore the given plugin receiv=
es
  * callbacks until @cb is called.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);

 /**
@@ -171,6 +176,7 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin=
_simple_cb_t cb);
  *
  * See also: qemu_plugin_register_vcpu_exit_cb()
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);

@@ -183,6 +189,7 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t=
 id,
  *
  * See also: qemu_plugin_register_vcpu_init_cb()
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);

@@ -193,6 +200,7 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t=
 id,
  *
  * The @cb function is called every time a vCPU idles.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);

@@ -203,6 +211,7 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t=
 id,
  *
  * The @cb function is called every time a vCPU resumes execution.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb);

@@ -253,6 +262,7 @@ typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plu=
gin_id_t id,
  * callbacks to be triggered when the block or individual instruction
  * executes.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t =
cb);

@@ -265,6 +275,7 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_=
id_t id,
  *
  * The @cb function is called every time a translated unit executes.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           qemu_plugin_vcpu_udata_cb_t cb,
                                           enum qemu_plugin_cb_flags flags,
@@ -296,6 +307,7 @@ enum qemu_plugin_op {
  * Note: ops are not atomic so in multi-threaded/multi-smp situations
  * you will get inexact results.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm);
@@ -309,6 +321,7 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qe=
mu_plugin_tb *tb,
  *
  * The @cb function is called every time an instruction is executed
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             qemu_plugin_vcpu_udata_cb_t cb=
,
                                             enum qemu_plugin_cb_flags flag=
s,
@@ -324,6 +337,7 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu=
_plugin_insn *insn,
  * Insert an inline op to every time an instruction executes. Useful
  * if you just want to increment a single counter somewhere in memory.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *i=
nsn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm);
@@ -334,6 +348,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct =
qemu_plugin_insn *insn,
  *
  * Returns: number of instructions in this block
  */
+QEMU_PLUGIN_API
 size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);

 /**
@@ -342,6 +357,7 @@ size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_=
tb *tb);
  *
  * Returns: virtual address of block start
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb);

 /**
@@ -355,6 +371,7 @@ uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_=
tb *tb);
  *
  * Returns: opaque handle to instruction
  */
+QEMU_PLUGIN_API
 struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);

@@ -368,6 +385,7 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb=
, size_t idx);
  * Returns: pointer to a stream of bytes containing the value of this
  * instructions opcode.
  */
+QEMU_PLUGIN_API
 const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);

 /**
@@ -376,6 +394,7 @@ const void *qemu_plugin_insn_data(const struct qemu_plu=
gin_insn *insn);
  *
  * Returns: size of instruction in bytes
  */
+QEMU_PLUGIN_API
 size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn);

 /**
@@ -384,6 +403,7 @@ size_t qemu_plugin_insn_size(const struct qemu_plugin_i=
nsn *insn);
  *
  * Returns: virtual address of instruction
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);

 /**
@@ -392,6 +412,7 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugi=
n_insn *insn);
  *
  * Returns: hardware (physical) target address of instruction
  */
+QEMU_PLUGIN_API
 void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);

 /**
@@ -410,6 +431,7 @@ struct qemu_plugin_hwaddr;
  *
  * Returns: size of access in ^2 (0=3Dbyte, 1=3D16bit, 2=3D32bit etc...)
  */
+QEMU_PLUGIN_API
 unsigned int qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
 /**
  * qemu_plugin_mem_is_sign_extended() - was the access sign extended
@@ -417,6 +439,7 @@ unsigned int qemu_plugin_mem_size_shift(qemu_plugin_mem=
info_t info);
  *
  * Returns: true if it was, otherwise false
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info);
 /**
  * qemu_plugin_mem_is_big_endian() - was the access big endian
@@ -424,6 +447,7 @@ bool qemu_plugin_mem_is_sign_extended(qemu_plugin_memin=
fo_t info);
  *
  * Returns: true if it was, otherwise false
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
 /**
  * qemu_plugin_mem_is_store() - was the access a store
@@ -431,6 +455,7 @@ bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_=
t info);
  *
  * Returns: true if it was, otherwise false
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);

 /**
@@ -446,6 +471,7 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t inf=
o);
  * information about the handle should be recovered before the
  * callback returns.
  */
+QEMU_PLUGIN_API
 struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t in=
fo,
                                                   uint64_t vaddr);

@@ -462,6 +488,7 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_=
plugin_meminfo_t info,
  * Returns true if the handle's memory operation is to memory-mapped IO, o=
r
  * false if it is to RAM
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);

 /**
@@ -473,12 +500,14 @@ bool qemu_plugin_hwaddr_is_io(const struct qemu_plugi=
n_hwaddr *haddr);
  * Note that the returned physical address may not be unique if you are de=
aling
  * with multiple address spaces.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *had=
dr);

 /*
  * Returns a string representing the device. The string is valid for
  * the lifetime of the plugin.
  */
+QEMU_PLUGIN_API
 const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr=
 *h);

 /**
@@ -513,6 +542,7 @@ typedef void (*qemu_plugin_vcpu_mem_cb_t) (unsigned int=
 vcpu_index,
  * callback so the plugin is responsible for ensuring it doesn't get
  * confused by making appropriate use of locking if required.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       qemu_plugin_vcpu_mem_cb_t cb,
                                       enum qemu_plugin_cb_flags flags,
@@ -531,6 +561,7 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugi=
n_insn *insn,
  * instruction. This provides for a lightweight but not thread-safe
  * way of counting the number of operations done.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_mem_rw rw,
                                           enum qemu_plugin_op op, void *pt=
r,
@@ -544,6 +575,7 @@ typedef void
                                  uint64_t a3, uint64_t a4, uint64_t a5,
                                  uint64_t a6, uint64_t a7, uint64_t a8);

+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb=
);

@@ -551,6 +583,7 @@ typedef void
 (*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcp=
u_idx,
                                      int64_t num, int64_t ret);

+QEMU_PLUGIN_API
 void
 qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t=
 cb);
@@ -563,6 +596,7 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id=
_t id,
  * Returns an allocated string containing the disassembly
  */

+QEMU_PLUGIN_API
 char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);

 /**
@@ -572,6 +606,7 @@ char *qemu_plugin_insn_disas(const struct qemu_plugin_i=
nsn *insn);
  * Return a static string referring to the symbol. This is dependent
  * on the binary QEMU is running having provided a symbol table.
  */
+QEMU_PLUGIN_API
 const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);

 /**
@@ -583,9 +618,11 @@ const char *qemu_plugin_insn_symbol(const struct qemu_=
plugin_insn *insn);
  *
  * See also: qemu_plugin_register_vcpu_init_cb()
  */
+QEMU_PLUGIN_API
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
                                qemu_plugin_vcpu_simple_cb_t cb);

+QEMU_PLUGIN_API
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
                                    qemu_plugin_simple_cb_t cb);

@@ -602,6 +639,7 @@ void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
  * In user-mode it is possible a few un-instrumented instructions from
  * child threads may run before the host kernel reaps the threads.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userd=
ata);

@@ -615,6 +653,7 @@ int qemu_plugin_n_max_vcpus(void);
  * qemu_plugin_outs() - output string via QEMU's logging system
  * @string: a string
  */
+QEMU_PLUGIN_API
 void qemu_plugin_outs(const char *string);

 /**
@@ -628,6 +667,7 @@ void qemu_plugin_outs(const char *string);
  * returns true if the combination @name=3D@val parses correctly to a bool=
ean
  * argument, and false otherwise
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_bool_parse(const char *name, const char *val, bool *ret);

 /**
@@ -638,6 +678,7 @@ bool qemu_plugin_bool_parse(const char *name, const cha=
r *val, bool *ret);
  * return NULL. The user should g_free() the string once no longer
  * needed.
  */
+QEMU_PLUGIN_API
 const char *qemu_plugin_path_to_binary(void);

 /**
@@ -646,6 +687,7 @@ const char *qemu_plugin_path_to_binary(void);
  * Returns the nominal start address of the main text segment in
  * user-mode. Currently returns 0 for system emulation.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_start_code(void);

 /**
@@ -654,6 +696,7 @@ uint64_t qemu_plugin_start_code(void);
  * Returns the nominal end address of the main text segment in
  * user-mode. Currently returns 0 for system emulation.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_end_code(void);

 /**
@@ -662,6 +705,7 @@ uint64_t qemu_plugin_end_code(void);
  * Returns the nominal entry address of the main text segment in
  * user-mode. Currently returns 0 for system emulation.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_entry_code(void);

 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/meson.build b/meson.build
index dcef8b1e79..b855224acc 100644
--- a/meson.build
+++ b/meson.build
@@ -3904,6 +3904,11 @@ endforeach

 if get_option('plugins')
   install_headers('include/qemu/qemu-plugin.h')
+  if targetos =3D=3D 'windows'
+    # On windows, we want to deliver the qemu_plugin_api.lib file in the q=
emu installer,
+    # so that plugin authors can compile against it.
+    install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
+  endif
 endif

 subdir('qga')
diff --git a/plugins/meson.build b/plugins/meson.build
index 71ed996ed3..8ed9fa270c 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -14,6 +14,23 @@ if not enable_modules
 endif

 if get_option('plugins')
+  if targetos =3D=3D 'windows'
+    # Generate a .lib file for plugins to link against.
+    # First, create a .def file listing all the symbols a plugin should ex=
pect to have
+    # available in qemu
+    win32_plugin_def =3D configure_file(
+      input: files('qemu-plugins.symbols'),
+      output: 'qemu_plugin_api.def',
+      capture: true,
+      command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
+    # then use dlltool to assemble a delaylib.
+    win32_qemu_plugin_api_lib =3D configure_file(
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
 t =3D []
 if get_option('plugins')
   foreach i : ['bb', 'empty', 'insn', 'mem', 'syscall']
-    t +=3D shared_module(i, files(i + '.c'),
-                       include_directories: '../../include/qemu',
-                       dependencies: glib)
+    if targetos =3D=3D 'windows'
+      t +=3D shared_module(i, files(i + '.c') + '../../contrib/plugins/win=
32_linker.c',
+                        include_directories: '../../include/qemu',
+                        objects: [win32_qemu_plugin_api_lib],
+                        dependencies: glib)
+
+    else
+      t +=3D shared_module(i, files(i + '.c'),
+                        include_directories: '../../include/qemu',
+                        dependencies: glib)
+    endif
   endforeach
 endif
 if t.length() > 0
--
2.42.0

--

Follow Rapita Systems on LinkedIn<https://www.linkedin.com/company/rapita-s=
ystems?utm_source=3Drs_email_sig>

