Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A51784B7F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 22:35:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYY53-0002eG-Kz; Tue, 22 Aug 2023 16:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYY50-0002cm-VB
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 16:34:22 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYY4y-0005Ed-GV
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 16:34:22 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68a6cd7c6a6so1003450b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692736459; x=1693341259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsaRliMGQZhQnMvBkKr3ovb5Yrpz1aO1dp2IimUflrE=;
 b=ndptI9LtTqvLHw/k9Ef+04SNc0KF1e4SqbSN4cAQcXHbknMIfPAeQDR/R/awh5ZoHi
 9Yb8GN94vkZqm0BeJiKm4bjwUk1xJxueKVVZiFNbqGq2WWNikI0iSG+SAZYyOcTCYvI4
 QKJmM4e7ByfEBkP9dopD0fdPbgOufHe7e3668mA/txIt2EjkixcWkp2b+oIQfSoSgHMw
 rsHKY4iOyGLj0f8yzTfNnQDk6aqMbSuSThVC1DSDryP7Y2iTDDnakhVN3Q2gXPp1bxqJ
 ePACBlOEmaPblnd5nPlfoxjipP5OiRM93NTgV5ae/wNuh6w0s1Cy/MWuMGPS40ygkfC+
 df3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692736459; x=1693341259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WsaRliMGQZhQnMvBkKr3ovb5Yrpz1aO1dp2IimUflrE=;
 b=XJBqdYkQtJ0mSfzVN0Jh+sce0VQd06CvM8NiXiyCdtVYciJ8AbTHln7p8BC9pQANgE
 ZGDXwwX5UOtOt2XPjFnJf5RAqEXij06cHulGdXFAuouYdzt3USnJHb8xGPDjDctJQHo9
 piOUsPJCjXfCEorgIuLp8635FpTSskfir76gI44vDKImFkrCThXjcYy9wHWNfZzZ0ZNM
 dNrS14+iG+Ve0E/zY/Isc6uzD9z5COFUQ+xO7SfAVBBHy8NmS81VEpYlxIOrFKnBI+uN
 aYqN4G8DuQ6uEDP9YbJIYkdUGafgyFrvVbDUi4No6llbGWNcQdDKD0uzFHO9MQOZ6mlb
 +IbA==
X-Gm-Message-State: AOJu0YwEPdPYgEKN+FNBMBXtYzvfzxnOwJlXcAPKBANpouryFrFvFSjD
 P/tAhGDkfqW2mzoxBUtnOYSPrzkrA6N/2wxAD60=
X-Google-Smtp-Source: AGHT+IF6++pYlnkB1lGbhA55ryJYLu490q8fGJc9sC8ZGv6E79MGVATzoaKaVTHZbE0YFiC+49PWEg==
X-Received: by 2002:a05:6a20:8e12:b0:148:c3ea:fb6c with SMTP id
 y18-20020a056a208e1200b00148c3eafb6cmr7827464pzj.36.1692736458951; 
 Tue, 22 Aug 2023 13:34:18 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 i25-20020a633c59000000b00564aee22f33sm8311823pgn.14.2023.08.22.13.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 13:34:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 3/3] linux-user: Detect and report host crashes
Date: Tue, 22 Aug 2023 13:34:15 -0700
Message-Id: <20230822203415.1184491-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822203415.1184491-1-richard.henderson@linaro.org>
References: <20230822203415.1184491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

From: Helge Deller <deller@gmx.de>

If there is an internal program error in the qemu source code which
raises SIGSEGV or SIGBUS, we currently assume the signal belongs to
the guest.

With an artificial error introduced, we will now print

QEMU internal SIGSEGV {si_code=1, si_addr=(nil)}
QEMU v8.1.50 target x86_64 running /usr/bin/cat
QEMU backtrace:
    ./qemu-x86_64(+0xf83d9) [0x55c48587a3d9]
    ./qemu-x86_64(+0xf8663) [0x55c48587a663]
    /lib/x86_64-linux-gnu/libc.so.6(+0x42520) [0x7f39eee42520]
    ./qemu-x86_64(+0x1132fa) [0x55c4858952fa]
    ./qemu-x86_64(+0x11396f) [0x55c48589596f]
    ./qemu-x86_64(+0x1140ef) [0x55c4858960ef]
    ./qemu-x86_64(+0x115796) [0x55c485897796]
    ./qemu-x86_64(+0x11f9dd) [0x55c4858a19dd]
    ./qemu-x86_64(+0x3f8da) [0x55c4857c18da]
    ./qemu-x86_64(+0xf3bfb) [0x55c485875bfb]
    /lib/x86_64-linux-gnu/libc.so.6(+0x29d90) [0x7f39eee29d90]
    /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x80) [0x7f39eee29e40]
    ./qemu-x86_64(+0x39075) [0x55c4857bb075]
Segmentation fault

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20230812164314.352131-1-deller@gmx.de>
[rth: Use in_code_gen_buffer and die_with_signal]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 54 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 57fbf2f58b..1ffd1354c3 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -23,6 +23,7 @@
 
 #include <sys/ucontext.h>
 #include <sys/resource.h>
+#include <execinfo.h>
 
 #include "qemu.h"
 #include "user-internals.h"
@@ -32,6 +33,7 @@
 #include "signal-common.h"
 #include "host-signal.h"
 #include "user/safe-syscall.h"
+#include "tcg/tcg.h"
 
 static struct target_sigaction sigact_table[TARGET_NSIG];
 
@@ -785,6 +787,34 @@ static inline void rewind_if_in_safe_syscall(void *puc)
     }
 }
 
+static G_NORETURN
+void die_with_backtrace(siginfo_t *info)
+{
+    void *array[20];
+    int size;
+
+    fprintf(stderr,
+            "QEMU internal SIG%s {si_code=%d, si_addr=%p}\n"
+            "QEMU v" QEMU_VERSION " target " UNAME_MACHINE " running %s\n",
+            sigabbrev_np(info->si_signo), info->si_code, info->si_addr,
+            exec_path);
+
+    size = backtrace(array, ARRAY_SIZE(array));
+    if (size) {
+        char **strings = backtrace_symbols(array, size);
+        if (strings) {
+            fprintf(stderr, "QEMU backtrace:\n");
+            for (int i = 0; i < size; ++i) {
+                fprintf(stderr, "    %s\n", strings[i]);
+            }
+            free(strings);
+        }
+    }
+
+    preexit_cleanup(thread_cpu->env_ptr, TARGET_SIGKILL);
+    die_with_signal(info->si_signo);
+}
+
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 {
     CPUArchState *env = thread_cpu->env_ptr;
@@ -820,16 +850,28 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
         is_write = host_signal_write(info, uc);
         access_type = adjust_signal_pc(&pc, is_write);
 
+        /* If this was a write to a TB protected page, restart. */
+        if (is_write
+            && host_sig == SIGSEGV
+            && info->si_code == SEGV_ACCERR
+            && h2g_valid(host_addr)
+            && handle_sigsegv_accerr_write(cpu, sigmask, pc, guest_addr)) {
+            return;
+        }
+
+        /*
+         * If the access was not on behalf of the guest, within the executable
+         * mapping of the generated code buffer, then it is a host bug.
+         */
+        if (access_type != MMU_INST_FETCH
+            && !in_code_gen_buffer((void *)(pc - tcg_splitwx_diff))) {
+            die_with_backtrace(info);
+        }
+
         if (host_sig == SIGSEGV) {
             bool maperr = true;
 
             if (info->si_code == SEGV_ACCERR && h2g_valid(host_addr)) {
-                /* If this was a write to a TB protected page, restart. */
-                if (is_write &&
-                    handle_sigsegv_accerr_write(cpu, sigmask, pc, guest_addr)) {
-                    return;
-                }
-
                 /*
                  * With reserved_va, the whole address space is PROT_NONE,
                  * which means that we may get ACCERR when we want MAPERR.
-- 
2.34.1


