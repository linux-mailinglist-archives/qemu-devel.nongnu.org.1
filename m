Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E15487B42FA
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 20:20:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmeYC-0007Y5-0m; Sat, 30 Sep 2023 14:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmeYA-0007Xw-A0
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 14:18:46 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmeY8-0001rr-Ba
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 14:18:46 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3af86819ba9so174062b6e.3
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696097923; x=1696702723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VAlFURYqoSaKMruKBoV0/ytiIKDMInglRFGzQIfOSJg=;
 b=C1e7URD6++iH6Rz29YTegGkFcEir/b8NBeYQLlywc7ReSyN3wZ/l+/GcU0cvLA7EFm
 QJAlAKbY28QrOX6W4kcQ3wgyzlw9hrinn5eFz8nh3n9NZtGfLShX7jq5DgHUW60RGeNw
 tEAaVjqUmM0AkRMTNspQl5smx9CEqr3TnX6vPPfUkqPcLqJJ37QoLkcSZbkxISEIBelo
 9VmbHI6DZE2V66DoJmwcFj81aA0vaJNNO4O2MCUF/qPOGbYfBXEHCrRczQ1mhdz1sVbe
 G5r/S0Akn7pdvQ4ZFr1LD7bXTt2OQVvQnlaWfFXamnVAeoS+rjqaRQkc14re3KGd0zQZ
 W6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696097923; x=1696702723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VAlFURYqoSaKMruKBoV0/ytiIKDMInglRFGzQIfOSJg=;
 b=XMlPmrfuMrQSpK9ANR5iGTpne0MkYSfhXWQ+/MrQKGcdOdQTukNNwjRKBNfQOup9lj
 OWzRB5pG4uHj3+/Ge/5EaBdYHbjoqLAsOIqPcn6W8Oxc+g8iNfrwu+zjjJkyi/oPheOC
 s6xh4zRuWnpJnrB2Vrb5xFptOBk3JYNYn8GOPXxfAd52F7lJ9sVjAZKVcZUAa2Yk4qkm
 r/9+sIMjfLO0fwePMUCw5gAiv+HPYL8aUd/JZMaeoiPCyDcgYz76/qWlz7G6zfK1nrxO
 HRaqpD07o5qGzmSHD+TCCxR5ycQh5e0PbkQceHX3dvKbsgPfsQg9KILFijMR5lhGK2By
 MeIg==
X-Gm-Message-State: AOJu0Yz9mdvji0TtUTsP4a+E8pEauCOlr+BiIUnaTUCMFNzIvOX4HDRB
 Z9HIsQVPs8K1ypIMvuAP1B+/FMQVXtoJVsCS+ks=
X-Google-Smtp-Source: AGHT+IH8ZIfUgI2prMaQRHBvwrcR/4V3Yx7JhveDDAYl5gXktHkIXtpXU2+WNPtL7KvfI//04QCKlg==
X-Received: by 2002:a05:6808:2392:b0:3ae:16b6:6338 with SMTP id
 bp18-20020a056808239200b003ae16b66338mr9490473oib.3.1696097922843; 
 Sat, 30 Sep 2023 11:18:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u25-20020a63a919000000b0057ab7d42a4dsm16138224pge.86.2023.09.30.11.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 11:18:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH] build: Remove --enable-gprof
Date: Sat, 30 Sep 2023 11:18:41 -0700
Message-Id: <20230930181841.245024-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This build option has been deprecated since 8.0.
Remove all CONFIG_GPROF code that depends on that,
including one errant check using TARGET_GPROF.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/about/deprecated.rst      | 14 --------------
 meson.build                    | 12 ------------
 bsd-user/bsd-proc.h            |  3 ---
 bsd-user/signal.c              |  5 -----
 linux-user/exit.c              |  6 ------
 linux-user/signal.c            |  5 -----
 meson_options.txt              |  3 ---
 scripts/meson-buildoptions.sh  |  3 ---
 tests/qemu-iotests/meson.build |  2 +-
 9 files changed, 1 insertion(+), 52 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8f3fef97bd..54be9e21a4 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -20,20 +20,6 @@ they were first deprecated in the 2.10.0 release.
 What follows is a list of all features currently marked as
 deprecated.
 
-Build options
--------------
-
-``gprof`` builds (since 8.0)
-''''''''''''''''''''''''''''
-
-The ``--enable-gprof`` configure setting relies on compiler
-instrumentation to gather its data which can distort the generated
-profile. As other non-instrumenting tools are available that give a
-more holistic view of the system with non-instrumented binaries we are
-deprecating the build option and no longer defend it in CI. The
-``--enable-gcov`` build option remains for analysis test case
-coverage.
-
 System emulator command line arguments
 --------------------------------------
 
diff --git a/meson.build b/meson.build
index 5139db2ff7..726d690e27 100644
--- a/meson.build
+++ b/meson.build
@@ -254,11 +254,6 @@ if host_arch == 'i386' and not cc.links('''
   qemu_common_flags = ['-march=i486'] + qemu_common_flags
 endif
 
-if get_option('gprof')
-  qemu_common_flags += ['-p']
-  qemu_ldflags += ['-p']
-endif
-
 if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
@@ -2214,7 +2209,6 @@ config_host_data.set('CONFIG_DEBUG_GRAPH_LOCK', get_option('debug_graph_lock'))
 config_host_data.set('CONFIG_DEBUG_MUTEX', get_option('debug_mutex'))
 config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage'))
 config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
-config_host_data.set('CONFIG_GPROF', get_option('gprof'))
 config_host_data.set('CONFIG_LIVE_BLOCK_MIGRATION', get_option('live_block_migration').allowed())
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
 config_host_data.set('CONFIG_REPLICATION', get_option('replication').allowed())
@@ -4122,12 +4116,6 @@ summary_info += {'memory allocator':  get_option('malloc')}
 summary_info += {'avx2 optimization': config_host_data.get('CONFIG_AVX2_OPT')}
 summary_info += {'avx512bw optimization': config_host_data.get('CONFIG_AVX512BW_OPT')}
 summary_info += {'avx512f optimization': config_host_data.get('CONFIG_AVX512F_OPT')}
-if get_option('gprof')
-  gprof_info = 'YES (deprecated)'
-else
-  gprof_info = get_option('gprof')
-endif
-summary_info += {'gprof':             gprof_info}
 summary_info += {'gcov':              get_option('b_coverage')}
 summary_info += {'thread sanitizer':  get_option('tsan')}
 summary_info += {'CFI support':       get_option('cfi')}
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index a1061bffb8..0e1d461c4c 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -25,9 +25,6 @@
 /* exit(2) */
 static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
 {
-#ifdef TARGET_GPROF
-    _mcleanup();
-#endif
     gdb_exit(arg1);
     qemu_plugin_user_exit();
     _exit(arg1);
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index b6beab659e..0b13455f4a 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -848,11 +848,6 @@ void signal_init(void)
     act.sa_flags = SA_SIGINFO;
 
     for (i = 1; i <= TARGET_NSIG; i++) {
-#ifdef CONFIG_GPROF
-        if (i == TARGET_SIGPROF) {
-            continue;
-        }
-#endif
         host_sig = target_to_host_signal(i);
         sigaction(host_sig, NULL, &oact);
         if (oact.sa_sigaction == (void *)SIG_IGN) {
diff --git a/linux-user/exit.c b/linux-user/exit.c
index 3017d28a3c..50266314e0 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -22,9 +22,6 @@
 #include "qemu.h"
 #include "user-internals.h"
 #include "qemu/plugin.h"
-#ifdef CONFIG_GPROF
-#include <sys/gmon.h>
-#endif
 
 #ifdef CONFIG_GCOV
 extern void __gcov_dump(void);
@@ -32,9 +29,6 @@ extern void __gcov_dump(void);
 
 void preexit_cleanup(CPUArchState *env, int code)
 {
-#ifdef CONFIG_GPROF
-        _mcleanup();
-#endif
 #ifdef CONFIG_GCOV
         __gcov_dump();
 #endif
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 748a98f3e5..920db8978f 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -588,11 +588,6 @@ void signal_init(void)
     act.sa_flags = SA_SIGINFO;
     act.sa_sigaction = host_signal_handler;
     for(i = 1; i <= TARGET_NSIG; i++) {
-#ifdef CONFIG_GPROF
-        if (i == TARGET_SIGPROF) {
-            continue;
-        }
-#endif
         host_sig = target_to_host_signal(i);
         sigaction(host_sig, NULL, &oact);
         if (oact.sa_sigaction == (void *)SIG_IGN) {
diff --git a/meson_options.txt b/meson_options.txt
index 57e265c871..6a17b90968 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -348,9 +348,6 @@ option('debug_stack_usage', type: 'boolean', value: false,
        description: 'measure coroutine stack usage')
 option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
-option('gprof', type: 'boolean', value: false,
-       description: 'QEMU profiling with gprof',
-       deprecated: true)
 option('slirp_smbd', type : 'feature', value : 'auto',
        description: 'use smbd (at path --smbd=*) in slirp networking')
 
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e4b46d5715..2a74b0275b 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -34,7 +34,6 @@ meson_options_help() {
   printf "%s\n" '                           (choices: auto/disabled/enabled/internal/system)'
   printf "%s\n" '  --enable-fuzzing         build fuzzing targets'
   printf "%s\n" '  --enable-gcov            Enable coverage tracking.'
-  printf "%s\n" '  --enable-gprof           QEMU profiling with gprof'
   printf "%s\n" '  --enable-lto             Use link time optimization'
   printf "%s\n" '  --enable-malloc=CHOICE   choose memory allocator to use [system] (choices:'
   printf "%s\n" '                           jemalloc/system/tcmalloc)'
@@ -309,8 +308,6 @@ _meson_option_parse() {
     --disable-glusterfs) printf "%s" -Dglusterfs=disabled ;;
     --enable-gnutls) printf "%s" -Dgnutls=enabled ;;
     --disable-gnutls) printf "%s" -Dgnutls=disabled ;;
-    --enable-gprof) printf "%s" -Dgprof=true ;;
-    --disable-gprof) printf "%s" -Dgprof=false ;;
     --enable-gtk) printf "%s" -Dgtk=enabled ;;
     --disable-gtk) printf "%s" -Dgtk=disabled ;;
     --enable-gtk-clipboard) printf "%s" -Dgtk_clipboard=enabled ;;
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 44761e1e4d..53847cb98f 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -1,4 +1,4 @@
-if not have_tools or targetos == 'windows' or get_option('gprof')
+if not have_tools or targetos == 'windows'
   subdir_done()
 endif
 
-- 
2.34.1


