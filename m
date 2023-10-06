Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66EC7BB3EE
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:09:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognc-0008Gp-BL; Fri, 06 Oct 2023 05:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognL-0008AB-9W
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:52 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognJ-0000z9-FM
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:50 -0400
Received: (qmail 19743 invoked by uid 484); 6 Oct 2023 09:06:37 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.143277 secs); 06 Oct 2023 09:06:37 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:35 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 16/29] deleting the mcdd startup option
Date: Fri,  6 Oct 2023 11:05:57 +0200
Message-Id: <20231006090610.26171-17-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: neder <nicolas.eder@lauterbach.com>

Signed-off-by: neder <nicolas.eder@lauterbach.com>
---
 mcdstub/meson.build | 10 +---------
 qemu-options.hx     | 13 +++----------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/mcdstub/meson.build b/mcdstub/meson.build
index ebd47b0725..6b2f970eae 100644
--- a/mcdstub/meson.build
+++ b/mcdstub/meson.build
@@ -1,16 +1,9 @@
-#
-# The main gdbstub still relies on per-build definitions of various
-# types. The bits pushed to softmmu/user.c try to use guest agnostic
-# types such as hwaddr.
-#
-
 # We need to build the core mcd code via a library to be able to tweak
 # cflags so:
 
 mcd_system_ss = ss.source_set()
 
-# We build one version of the mcdstub,
-#because it only needs to work for system emulation
+# only system emulation is supported over mcd
 mcd_system_ss.add(files('mcdstub.c'))
 
 mcd_system_ss = mcd_system_ss.apply(config_host, strict: false)
@@ -23,5 +16,4 @@ libmcd_softmmu = static_library('mcd_softmmu',
 mcd_softmmu = declare_dependency(link_whole: libmcd_softmmu)
 system_ss.add(mcd_softmmu)
 
-# this might cause problems because we don't support user mode
 common_ss.add(files('mcd_syscalls.c'))
diff --git a/qemu-options.hx b/qemu-options.hx
index 0c15125b92..0b72c2de07 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4417,7 +4417,8 @@ ERST
 DEF("mcd", HAS_ARG, QEMU_OPTION_mcd, \
     "-mcd dev        accept mcd connection on 'dev'. (QEMU defaults to starting\n"
     "                the guest without waiting for a mcd client to connect; use -S too\n"
-    "                if you want it to not start execution.)\n",
+    "                if you want it to not start execution.)\n"
+    "                To use the default Port write '-mcd default'\n",
     QEMU_ARCH_ALL)
 SRST
 ``-mcd dev``
@@ -4428,15 +4429,7 @@ SRST
 
     The most usual configuration is to listen on a local TCP socket::
 
-        -mcd tcp::1234
-ERST
-
-DEF("mcdd", 0, QEMU_OPTION_mcdd, \
-    "-mcdd              shorthand for -mcd tcp::" DEFAULT_MCDSTUB_PORT "\n",
-    QEMU_ARCH_ALL)
-SRST
-``-mcdd``
-    Shorthand for -mcd tcp::1234, i.e. open a mcdserver on TCP port 1234
+        -mcd tcp::1235
 ERST
 
 DEF("d", HAS_ARG, QEMU_OPTION_d, \
-- 
2.34.1


