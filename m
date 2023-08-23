Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF06F784FE9
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:17:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgEG-0004wD-Pa; Wed, 23 Aug 2023 01:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEE-0004vQ-7N
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:26 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEB-0000sf-SX
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:25 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bc5acc627dso34762075ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692767782; x=1693372582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5gfbYEtQOxd0dUyPKXMEvc82rL/zzDhhmw3j/jKEBw=;
 b=KDYu0rnbCx64hAqW/5t5zoZ3MpDPhwSz1HXedEURdtp/KVwgm9xdZKB+VutdulVMsW
 MGjquymJMXEX0qxhgX3R/YaYuTCfKle0z9EDc5reLjUHyZSQaLLLGFH7HFEndKSkJ6P9
 Wetpua2NjFaECp/zfLtcSZl2/pJAIuhEyr5F4QLNvbkQ0y6T/OViiaZrD3z45+pNuwGW
 HSqDhjHIbCRXKcNnVBk3LoOLdBqsTBIJucmP4ynX8yzGbfcDuLt14uvYPo6JXCYQ0Sey
 Y95bWDZmJjO6qgnFRtvH4ZOYjdvntZ4nY9u7iV/20JMnTzZQgJvFYTrDCpjmAqkOR0x5
 7o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692767782; x=1693372582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5gfbYEtQOxd0dUyPKXMEvc82rL/zzDhhmw3j/jKEBw=;
 b=O/y4+qLCU84tdMzFp8F1HTB8j2UgaKnnCWdXVBkVD3AjCPPB4jkKubWEnRoKlPrS+m
 xDNJ4K/KdFLe/ssGDbc9GVAizSiNfEDrot4Lqs82s0oRuFGxL+g1lU8W0cFa58RZ7WkB
 NY9NJgQnDLYPunNx0xr44pJozZ7Ae5sSq2nyZOSUJVcmoW6W6mgpT43Rwb8MpGqvGuQb
 BYU2Wo4z6HKItlxdPW3P5gXcDv9ph9yQtPtLe2YA57X186oLCuov+yS1M0q/U4LXz0ss
 23OGUaBbYyFZInjwOlfosWaKO1z/lsN2Izb0L/r4tqVpgKhZ4p+xNJgg72WgZ3ycLkIM
 j4Vw==
X-Gm-Message-State: AOJu0YwUHptWz+Bpzj6XhllGaT+2+1zvKXcNWXcA7Wklfg+HmOnz8Zud
 ERCGgwzr76POmp0296JYgYweYZ494XFHHddxZdM=
X-Google-Smtp-Source: AGHT+IHiJJt+Ryamws1QeBAtockAs9MlLEwTT5M9rXSxVzkicxlPVd8CS7Nn/DLUt0l8i2waZYL9Ag==
X-Received: by 2002:a17:902:e849:b0:1bd:eef1:41c0 with SMTP id
 t9-20020a170902e84900b001bdeef141c0mr10336507plg.29.1692767782359; 
 Tue, 22 Aug 2023 22:16:22 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001bf044dc1a6sm9969402plg.39.2023.08.22.22.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 22:16:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v4 04/10] linux-user: Detect and report host crashes
Date: Tue, 22 Aug 2023 22:16:09 -0700
Message-Id: <20230823051615.1297706-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823051615.1297706-1-richard.henderson@linaro.org>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
Aborted

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20230812164314.352131-1-deller@gmx.de>
[rth: Use in_code_gen_buffer and die_with_signal]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 53 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index a77d003de6..529fea8bba 100644
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
 
@@ -797,6 +799,33 @@ static inline void rewind_if_in_safe_syscall(void *puc)
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
+    abort();
+}
+
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 {
     CPUArchState *env = thread_cpu->env_ptr;
@@ -832,16 +861,28 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
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


