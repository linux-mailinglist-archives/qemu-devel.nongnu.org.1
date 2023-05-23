Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E9470DA21
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P3q-0006kw-Qx; Tue, 23 May 2023 06:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3d-0006ji-LW; Tue, 23 May 2023 06:15:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3a-0001pk-K6; Tue, 23 May 2023 06:15:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 07AC27CF5;
 Tue, 23 May 2023 13:15:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4905F7285;
 Tue, 23 May 2023 13:15:49 +0300 (MSK)
Received: (nullmailer pid 85499 invoked by uid 1000);
 Tue, 23 May 2023 10:15:48 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 39/59] util/async-teardown: wire up
 query-command-line-options
Date: Tue, 23 May 2023 13:14:59 +0300
Message-Id: <20230523101536.85424-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Add new -run-with option with an async-teardown=on|off parameter. It is
visible in the output of query-command-line-options QMP command, so it
can be discovered and used by libvirt.

The option -async-teardown is now redundant, deprecate it.

Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Fixes: c891c24b1a ("os-posix: asynchronous teardown for shutdown on Linux")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-Id: <20230505120051.36605-2-imbrenda@linux.ibm.com>
[thuth: Add curly braces to fix error with GCC 8.5, fix bug in deprecated.rst]
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 80bd81cadd127c1e2fc784612a52abe392670ba4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context tweak in docs/about/deprecated.rst)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 914938fd76..2823362791 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -111,6 +111,10 @@ Use ``-machine acpi=off`` instead.
 The HAXM project has been retired (see https://github.com/intel/haxm#status).
 Use "whpx" (on Windows) or "hvf" (on macOS) instead.
 
+``-async-teardown`` (since 8.1)
+'''''''''''''''''''''''''''''''
+
+Use ``-run-with async-teardown=on`` instead.
 
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
diff --git a/os-posix.c b/os-posix.c
index 5adc69f560..90ea71725f 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -36,6 +36,8 @@
 #include "qemu/log.h"
 #include "sysemu/runstate.h"
 #include "qemu/cutils.h"
+#include "qemu/config-file.h"
+#include "qemu/option.h"
 
 #ifdef CONFIG_LINUX
 #include <sys/prctl.h>
@@ -152,9 +154,21 @@ int os_parse_cmd_args(int index, const char *optarg)
         daemonize = 1;
         break;
 #if defined(CONFIG_LINUX)
+    /* deprecated */
     case QEMU_OPTION_asyncteardown:
         init_async_teardown();
         break;
+    case QEMU_OPTION_run_with: {
+        QemuOpts *opts = qemu_opts_parse_noisily(qemu_find_opts("run-with"),
+                                                 optarg, false);
+        if (!opts) {
+            exit(1);
+        }
+        if (qemu_opt_get_bool(opts, "async-teardown", false)) {
+            init_async_teardown();
+        }
+        break;
+    }
 #endif
     default:
         return -1;
diff --git a/qemu-options.hx b/qemu-options.hx
index 4b8855a4f7..fdddfab6ff 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4786,20 +4786,32 @@ DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
 DEF("async-teardown", 0, QEMU_OPTION_asyncteardown,
     "-async-teardown enable asynchronous teardown\n",
     QEMU_ARCH_ALL)
-#endif
 SRST
 ``-async-teardown``
-    Enable asynchronous teardown. A new process called "cleanup/<QEMU_PID>"
-    will be created at startup sharing the address space with the main qemu
-    process, using clone. It will wait for the main qemu process to
-    terminate completely, and then exit.
-    This allows qemu to terminate very quickly even if the guest was
-    huge, leaving the teardown of the address space to the cleanup
-    process. Since the cleanup process shares the same cgroups as the
-    main qemu process, accounting is performed correctly. This only
-    works if the cleanup process is not forcefully killed with SIGKILL
-    before the main qemu process has terminated completely.
+    This option is deprecated and should no longer be used. The new option
+    ``-run-with async-teardown=on`` is a replacement.
 ERST
+DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
+    "-run-with async-teardown[=on|off]\n"
+    "                misc QEMU process lifecycle options\n"
+    "                async-teardown=on enables asynchronous teardown\n",
+    QEMU_ARCH_ALL)
+SRST
+``-run-with``
+    Set QEMU process lifecycle options.
+
+    ``async-teardown=on`` enables asynchronous teardown. A new process called
+    "cleanup/<QEMU_PID>" will be created at startup sharing the address
+    space with the main QEMU process, using clone. It will wait for the
+    main QEMU process to terminate completely, and then exit. This allows
+    QEMU to terminate very quickly even if the guest was huge, leaving the
+    teardown of the address space to the cleanup process. Since the cleanup
+    process shares the same cgroups as the main QEMU process, accounting is
+    performed correctly. This only works if the cleanup process is not
+    forcefully killed with SIGKILL before the main QEMU process has
+    terminated completely.
+ERST
+#endif
 
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
     "-msg [timestamp[=on|off]][,guest-name=[on|off]]\n"
diff --git a/util/async-teardown.c b/util/async-teardown.c
index 62cdeb0f20..3ab19c8740 100644
--- a/util/async-teardown.c
+++ b/util/async-teardown.c
@@ -12,6 +12,9 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/config-file.h"
+#include "qemu/option.h"
+#include "qemu/module.h"
 #include <dirent.h>
 #include <sys/prctl.h>
 #include <sched.h>
@@ -144,3 +147,21 @@ void init_async_teardown(void)
     clone(async_teardown_fn, new_stack_for_clone(), CLONE_VM, NULL);
     sigprocmask(SIG_SETMASK, &old_signals, NULL);
 }
+
+static QemuOptsList qemu_run_with_opts = {
+    .name = "run-with",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_run_with_opts.head),
+    .desc = {
+        {
+            .name = "async-teardown",
+            .type = QEMU_OPT_BOOL,
+        },
+        { /* end of list */ }
+    },
+};
+
+static void register_teardown(void)
+{
+    qemu_add_opts(&qemu_run_with_opts);
+}
+opts_init(register_teardown);
-- 
2.39.2


