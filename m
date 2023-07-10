Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4570674D52E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:20:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpoV-0000sa-QU; Mon, 10 Jul 2023 08:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoO-0000qP-ET
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoM-0003Wj-In
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BRphK0Bgs5/sopCbWyztf8M45awJy9BVj1+lXDCEtg=;
 b=QOiRRtY6fZluvhZPdeDr16hevyECbtQSo4B4CuoyexjcVLPp3iD9a+ETrzWnkEjWBRxovW
 7bZ1Ycq7JEykcmUg9A9xC4ddOqvi628bXDOhcJnzrHcSN6FvHVRnb8B4taf2qpq79CbGcR
 /hmbwlrDI8oOEziIk9TMy8vYBceIWAw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-X0p5VeMSMf6RZcp_7qLP8w-1; Mon, 10 Jul 2023 08:16:10 -0400
X-MC-Unique: X0p5VeMSMf6RZcp_7qLP8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DBC8185A792;
 Mon, 10 Jul 2023 12:16:10 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FDE0F66BA;
 Mon, 10 Jul 2023 12:16:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>
Subject: [PULL 17/21] os-posix: Allow 'chroot' via '-run-with' and deprecate
 the old '-chroot' option
Date: Mon, 10 Jul 2023 14:15:39 +0200
Message-Id: <20230710121543.197250-18-thuth@redhat.com>
In-Reply-To: <20230710121543.197250-1-thuth@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

We recently introduced "-run-with" for options that influence the
runtime behavior of QEMU. This option has the big advantage that it
can group related options (so that it is easier for the users to spot
them) and that the options become introspectable via QMP this way.
So let's start moving more switches into this option group, starting
with "-chroot" now.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Message-Id: <20230703074447.17044-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst |  5 +++++
 os-posix.c                | 35 ++++++++++++++++++++++++++++++++++-
 util/async-teardown.c     | 21 ---------------------
 qemu-options.hx           | 18 +++++++++++++-----
 4 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ddc1e48460..02ea5a839f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -116,6 +116,11 @@ Use "whpx" (on Windows) or "hvf" (on macOS) instead.
 
 Use ``-run-with async-teardown=on`` instead.
 
+``-chroot`` (since 8.1)
+'''''''''''''''''''''''
+
+Use ``-run-with chroot=dir`` instead.
+
 ``-singlestep`` (since 8.1)
 '''''''''''''''''''''''''''
 
diff --git a/os-posix.c b/os-posix.c
index 90ea71725f..cfcb96533c 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -38,6 +38,7 @@
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
+#include "qemu/module.h"
 
 #ifdef CONFIG_LINUX
 #include <sys/prctl.h>
@@ -148,6 +149,7 @@ int os_parse_cmd_args(int index, const char *optarg)
         }
         break;
     case QEMU_OPTION_chroot:
+        warn_report("option is deprecated, use '-run-with chroot=...' instead");
         chroot_dir = optarg;
         break;
     case QEMU_OPTION_daemonize:
@@ -158,18 +160,25 @@ int os_parse_cmd_args(int index, const char *optarg)
     case QEMU_OPTION_asyncteardown:
         init_async_teardown();
         break;
+#endif
     case QEMU_OPTION_run_with: {
+        const char *str;
         QemuOpts *opts = qemu_opts_parse_noisily(qemu_find_opts("run-with"),
                                                  optarg, false);
         if (!opts) {
             exit(1);
         }
+#if defined(CONFIG_LINUX)
         if (qemu_opt_get_bool(opts, "async-teardown", false)) {
             init_async_teardown();
         }
+#endif
+        str = qemu_opt_get(opts, "chroot");
+        if (str) {
+            chroot_dir = str;
+        }
         break;
     }
-#endif
     default:
         return -1;
     }
@@ -348,3 +357,27 @@ int os_mlock(void)
     return -ENOSYS;
 #endif
 }
+
+static QemuOptsList qemu_run_with_opts = {
+    .name = "run-with",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_run_with_opts.head),
+    .desc = {
+#if defined(CONFIG_LINUX)
+        {
+            .name = "async-teardown",
+            .type = QEMU_OPT_BOOL,
+        },
+#endif
+        {
+            .name = "chroot",
+            .type = QEMU_OPT_STRING,
+        },
+        { /* end of list */ }
+    },
+};
+
+static void register_runwith(void)
+{
+    qemu_add_opts(&qemu_run_with_opts);
+}
+opts_init(register_runwith);
diff --git a/util/async-teardown.c b/util/async-teardown.c
index 3ab19c8740..62cdeb0f20 100644
--- a/util/async-teardown.c
+++ b/util/async-teardown.c
@@ -12,9 +12,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/config-file.h"
-#include "qemu/option.h"
-#include "qemu/module.h"
 #include <dirent.h>
 #include <sys/prctl.h>
 #include <sched.h>
@@ -147,21 +144,3 @@ void init_async_teardown(void)
     clone(async_teardown_fn, new_stack_for_clone(), CLONE_VM, NULL);
     sigprocmask(SIG_SETMASK, &old_signals, NULL);
 }
-
-static QemuOptsList qemu_run_with_opts = {
-    .name = "run-with",
-    .head = QTAILQ_HEAD_INITIALIZER(qemu_run_with_opts.head),
-    .desc = {
-        {
-            .name = "async-teardown",
-            .type = QEMU_OPT_BOOL,
-        },
-        { /* end of list */ }
-    },
-};
-
-static void register_teardown(void)
-{
-    qemu_add_opts(&qemu_run_with_opts);
-}
-opts_init(register_teardown);
diff --git a/qemu-options.hx b/qemu-options.hx
index 96087505b2..f8f384e551 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4677,11 +4677,12 @@ ERST
 
 #ifndef _WIN32
 DEF("chroot", HAS_ARG, QEMU_OPTION_chroot, \
-    "-chroot dir     chroot to dir just before starting the VM\n",
+    "-chroot dir     chroot to dir just before starting the VM (deprecated)\n",
     QEMU_ARCH_ALL)
 #endif
 SRST
 ``-chroot dir``
+    Deprecated, use '-run-with chroot=...' instead.
     Immediately before starting guest execution, chroot to the specified
     directory. Especially useful in combination with -runas.
 ERST
@@ -4868,13 +4869,16 @@ SRST
     This option is deprecated and should no longer be used. The new option
     ``-run-with async-teardown=on`` is a replacement.
 ERST
+#endif
+#ifdef CONFIG_POSIX
 DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
-    "-run-with async-teardown[=on|off]\n"
-    "                misc QEMU process lifecycle options\n"
-    "                async-teardown=on enables asynchronous teardown\n",
+    "-run-with [async-teardown=on|off][,chroot=dir]\n"
+    "                Set miscellaneous QEMU process lifecycle options:\n"
+    "                async-teardown=on enables asynchronous teardown (Linux only)\n"
+    "                chroot=dir chroot to dir just before starting the VM\n",
     QEMU_ARCH_ALL)
 SRST
-``-run-with``
+``-run-with [async-teardown=on|off][,chroot=dir]``
     Set QEMU process lifecycle options.
 
     ``async-teardown=on`` enables asynchronous teardown. A new process called
@@ -4887,6 +4891,10 @@ SRST
     performed correctly. This only works if the cleanup process is not
     forcefully killed with SIGKILL before the main QEMU process has
     terminated completely.
+
+    ``chroot=dir`` can be used for doing a chroot to the specified directory
+    immediately before starting the guest execution. This is especially useful
+    in combination with -runas.
 ERST
 #endif
 
-- 
2.39.3


