Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD9179727C
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:02:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEcp-0002kq-4t; Thu, 07 Sep 2023 09:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcl-0002ji-Eh
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEci-0007F1-Si
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYuXssgBTkUCtCv1DH+hKuG0uKZ+en2/n30kR0Kci5k=;
 b=H8BiGGhdHDlFCWJPuRMe8zmTWINnflCVrvEC7rXt0DPPYQe0uIgMTGmYfri5hlociy6ZJm
 W9eH5JPgSgh7E49xVeEUNdqazfjdGdqMdrcypB4pqSfyp5PVqAoTcBGWOhXb8gS+OhL5bh
 odCrL5c0cOJMiyniHFy7RtN7lSntb+U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-n0iaXSqsMm2HpJBVxw97sA-1; Thu, 07 Sep 2023 09:00:35 -0400
X-MC-Unique: n0iaXSqsMm2HpJBVxw97sA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4011fa32e99so6671495e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091627; x=1694696427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYuXssgBTkUCtCv1DH+hKuG0uKZ+en2/n30kR0Kci5k=;
 b=MKu2ub30lzNB7yJa1BqwUgX3IWomOJTNv4ircI0nhwSnsDiFLZPsPXMaqXAyoLw3Ua
 wW+KL3mWQZBKjvybsiq4ablv0LfLF4hPTBF94w1C1yIj1MsnAtx0451zd2MgxmIx+VpB
 VeQuqAN1wonVET14uWuWlaL6RhxbeCjGTDis3u2U2AnwPz1o3lhzt0JzFny+WP6dvhE0
 KJJ14NPeHU2esLMXChe93sILy0nc91Kf8lGT6SQ9etCwlCltJT4yKYe1lFOjbdZTlWps
 JJ7FUiN5m7IWGyTDQc6CjOae4JKx0gTS/Z7qk/xnAA/vq0BbF4w/j+/YDoPI9p/VBrlM
 aRww==
X-Gm-Message-State: AOJu0Ywvp8LCVZC/gr8+4QYWyS4Czj6jRzJPtxwAritnaCmr1z/bNbn4
 cASMBUQPeQRqG+/BbDzQP/UorklModbgjIeg+q3WhuSK2zDDIdMzrfJnuiz8cvz8VV5RGneExGY
 huBYXwXBVlpx+ila8DyLO/SyymDtWk0FL9iXYr5/DQJlDM7cWaj/lRTyV7IMaQmyRE4GilQCY82
 k=
X-Received: by 2002:a05:600c:25cc:b0:401:a0b1:aef6 with SMTP id
 12-20020a05600c25cc00b00401a0b1aef6mr4703710wml.2.1694091627436; 
 Thu, 07 Sep 2023 06:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQgPKYqV4bab8/tJ2S4KkoxQ7Tc+0Mw+G+yPqL/pu0kVT3/Z+tMOOQtyj7PJ9n7HQfwQ0f/w==
X-Received: by 2002:a05:600c:25cc:b0:401:a0b1:aef6 with SMTP id
 12-20020a05600c25cc00b00401a0b1aef6mr4703679wml.2.1694091627026; 
 Thu, 07 Sep 2023 06:00:27 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a7bc4d1000000b003fc02e8ea68sm2497696wmk.13.2023.09.07.06.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 09/51] os-posix.c,
 softmmu/vl.c: move os_parse_cmd_args() into qemu_init()
Date: Thu,  7 Sep 2023 14:59:18 +0200
Message-ID: <20230907130004.500601-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Michael Tokarev <mjt@tls.msk.ru>

This will stop linking softmmu-specific os_parse_cmd_args() into every
qemu executable which happens to use other functions from os-posix.c,
such as os_set_line_buffering() or os_setup_signal_handling().

Also, since there's no win32-specific options, *all* option parsing is
now done in softmmu/vl.c:qemu_init(), which is easier to read without
extra indirection, - all options are in the single function now.

This effectively reverts commit 59a5264b99434.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230901101302.3618955-5-mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/os-posix.h |  1 -
 include/sysemu/os-win32.h |  1 -
 os-posix.c                | 82 ---------------------------------------
 softmmu/vl.c              | 76 ++++++++++++++++++++++++++++++++++--
 4 files changed, 73 insertions(+), 87 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index 8a667633953..6dfdcbb0863 100644
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
index 91aa0d7ec04..8ae30fac159 100644
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
index ed0787ecfd9..fc2883ff82c 100644
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
index b0b96f67fac..0a74810ca32 100644
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
                     exit(1);
                 }
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
+                    exit(1);
+                }
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
2.41.0


