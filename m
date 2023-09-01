Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA44578FBA3
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:14:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc19e-0001NA-1M; Fri, 01 Sep 2023 06:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc19O-0001K2-NI
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:13:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc19M-0001am-6p
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:13:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 351371E731;
 Fri,  1 Sep 2023 13:13:39 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1D21025069;
 Fri,  1 Sep 2023 13:13:03 +0300 (MSK)
Received: (nullmailer pid 3618996 invoked by uid 1000);
 Fri, 01 Sep 2023 10:13:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 4/8] os-posix.c,
 softmmu/vl.c: move os_parse_cmd_args() into qemu_init()
Date: Fri,  1 Sep 2023 13:12:58 +0300
Message-Id: <20230901101302.3618955-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230901101302.3618955-1-mjt@tls.msk.ru>
References: <20230901101302.3618955-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This will stop linking softmmu-specific os_parse_cmd_args() into every
qemu executable which happens to use other functions from os-posix.c,
such as os_set_line_buffering() or os_setup_signal_handling().

Also, since there's no win32-specific options, *all* option parsing is
now done in softmmu/vl.c:qemu_init(), which is easier to read without
extra indirection, - all options are in the single function now.

This effectively reverts commit 59a5264b99434.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/sysemu/os-posix.h |  1 -
 include/sysemu/os-win32.h |  1 -
 os-posix.c                | 82 ---------------------------------------
 softmmu/vl.c              | 76 ++++++++++++++++++++++++++++++++++--
 4 files changed, 73 insertions(+), 87 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index 8a66763395..6dfdcbb086 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -42,7 +42,6 @@
 extern "C" {
 #endif
 
-int os_parse_cmd_args(int index, const char *optarg);
 void os_set_line_buffering(void);
 void os_setup_early_signal_handling(void);
 void os_set_proc_name(const char *s);
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index 91aa0d7ec0..8ae30fac15 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -101,7 +101,6 @@ static inline void os_setup_signal_handling(void) {}
 static inline void os_daemonize(void) {}
 static inline void os_setup_post(void) {}
 static inline void os_set_proc_name(const char *dummy) {}
-static inline int os_parse_cmd_args(int index, const char *optarg) { return -1; }
 void os_set_line_buffering(void);
 void os_setup_early_signal_handling(void);
 
diff --git a/os-posix.c b/os-posix.c
index 081f3db685..4102fcdb5e 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -31,18 +31,13 @@
 
 /* Needed early for CONFIG_BSD etc. */
 #include "net/slirp.h"
-#include "qemu/qemu-options.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "sysemu/runstate.h"
 #include "qemu/cutils.h"
-#include "qemu/config-file.h"
-#include "qemu/option.h"
-#include "qemu/module.h"
 
 #ifdef CONFIG_LINUX
 #include <sys/prctl.h>
-#include "qemu/async-teardown.h"
 #endif
 
 /*
@@ -142,59 +137,6 @@ bool os_set_runas(const char *optarg)
     return true;
 }
 
-/*
- * Parse OS specific command line options.
- * return 0 if option handled, -1 otherwise
- */
-int os_parse_cmd_args(int index, const char *optarg)
-{
-    switch (index) {
-    case QEMU_OPTION_runas:
-        if (!os_set_runas(optarg)) {
-            error_report("User \"%s\" doesn't exist"
-                         " (and is not <uid>:<gid>)",
-                         optarg);
-            exit(1);
-        }
-        break;
-    case QEMU_OPTION_chroot:
-        warn_report("option is deprecated, use '-run-with chroot=...' instead");
-        os_set_chroot(optarg);
-        break;
-    case QEMU_OPTION_daemonize:
-        daemonize = 1;
-        break;
-#if defined(CONFIG_LINUX)
-    /* deprecated */
-    case QEMU_OPTION_asyncteardown:
-        init_async_teardown();
-        break;
-#endif
-    case QEMU_OPTION_run_with: {
-        const char *str;
-        QemuOpts *opts = qemu_opts_parse_noisily(qemu_find_opts("run-with"),
-                                                 optarg, false);
-        if (!opts) {
-            exit(1);
-        }
-#if defined(CONFIG_LINUX)
-        if (qemu_opt_get_bool(opts, "async-teardown", false)) {
-            init_async_teardown();
-        }
-#endif
-        str = qemu_opt_get(opts, "chroot");
-        if (str) {
-            os_set_chroot(str);
-        }
-        break;
-    }
-    default:
-        return -1;
-    }
-
-    return 0;
-}
-
 static void change_process_uid(void)
 {
     assert((user_uid == (uid_t)-1) || user_pwd == NULL);
@@ -371,27 +313,3 @@ int os_mlock(void)
     return -ENOSYS;
 #endif
 }
-
-static QemuOptsList qemu_run_with_opts = {
-    .name = "run-with",
-    .head = QTAILQ_HEAD_INITIALIZER(qemu_run_with_opts.head),
-    .desc = {
-#if defined(CONFIG_LINUX)
-        {
-            .name = "async-teardown",
-            .type = QEMU_OPT_BOOL,
-        },
-#endif
-        {
-            .name = "chroot",
-            .type = QEMU_OPT_STRING,
-        },
-        { /* end of list */ }
-    },
-};
-
-static void register_runwith(void)
-{
-    qemu_add_opts(&qemu_run_with_opts);
-}
-opts_init(register_runwith);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..0a74810ca3 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -49,6 +49,7 @@
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "qemu/accel.h"
+#include "qemu/async-teardown.h"
 #include "hw/usb.h"
 #include "hw/isa/isa.h"
 #include "hw/scsi/scsi.h"
@@ -748,6 +749,33 @@ static QemuOptsList qemu_smp_opts = {
     },
 };
 
+#if defined(CONFIG_POSIX)
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
+#define qemu_add_run_with_opts() qemu_add_opts(&qemu_run_with_opts)
+
+#else
+
+#define qemu_add_run_with_opts()
+
+#endif /* CONFIG_POSIX */
+
 static void realtime_init(void)
 {
     if (enable_mlock) {
@@ -2704,6 +2732,7 @@ void qemu_init(int argc, char **argv)
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
     qemu_add_opts(&qemu_action_opts);
+    qemu_add_run_with_opts();
     module_call_init(MODULE_INIT_OPTS);
 
     error_init(argv[0]);
@@ -3522,11 +3551,52 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_nouserconfig:
                 /* Nothing to be parsed here. Especially, do not error out below. */
                 break;
-            default:
-                if (os_parse_cmd_args(popt->index, optarg)) {
-                    error_report("Option not supported in this build");
+#if defined(CONFIG_POSIX)
+            case QEMU_OPTION_runas:
+                if (!os_set_runas(optarg)) {
+                    error_report("User \"%s\" doesn't exist"
+                                 " (and is not <uid>:<gid>)",
+                                 optarg);
+                    exit(1);
+                }
+                break;
+            case QEMU_OPTION_chroot:
+                warn_report("option is deprecated,"
+                            " use '-run-with chroot=...' instead");
+                os_set_chroot(optarg);
+                break;
+            case QEMU_OPTION_daemonize:
+                os_set_daemonize(true);
+                break;
+#if defined(CONFIG_LINUX)
+            /* deprecated */
+            case QEMU_OPTION_asyncteardown:
+                init_async_teardown();
+                break;
+#endif
+            case QEMU_OPTION_run_with: {
+                const char *str;
+                opts = qemu_opts_parse_noisily(qemu_find_opts("run-with"),
+                                                         optarg, false);
+                if (!opts) {
                     exit(1);
                 }
+#if defined(CONFIG_LINUX)
+                if (qemu_opt_get_bool(opts, "async-teardown", false)) {
+                    init_async_teardown();
+                }
+#endif
+                str = qemu_opt_get(opts, "chroot");
+                if (str) {
+                    os_set_chroot(str);
+                }
+                break;
+            }
+#endif /* CONFIG_POSIX */
+
+            default:
+                error_report("Option not supported in this build");
+                exit(1);
             }
         }
     }
-- 
2.39.2


