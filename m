Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8667CEC17
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG0w-00040F-SC; Wed, 18 Oct 2023 19:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0v-0003xQ-2C
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:45 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0t-0000KW-7w
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:44 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c646b5028dso4867856a34.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671902; x=1698276702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQP2+HZbJmIj9sXXPBVMTwI7vC2S6c38AoM7akl90XU=;
 b=IBuuzY6E+oFSysj0ymtpPsytGO+XLWJHp9Omipe5GFCQ7d8fo1maMom5k7tYXDDRWi
 6RZV9X86jzzpz7N9P/tyNnntz451y5iOQa3yC0rPU/vp7+v/guOFnvLz6lCOtja5I4XV
 rYrkudo7lKT9mqWdDja7EZeL31scldfO/GJP7pAv0PARYh8R+GSiwAznEV7rl8hxZ//k
 B6LSDDQ+rk5oJVFfmArKYFqSxLs1ObSJsD5qaOaNBeBDUKy3E4z8Hkqu4+Z3+26V7pev
 ZoUC5LycWJGvdOISPjYFmgMRWX5enpTflDPvySiz3fGHefJbKJrcKSP75M8rakThoJFo
 wwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671902; x=1698276702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQP2+HZbJmIj9sXXPBVMTwI7vC2S6c38AoM7akl90XU=;
 b=qJocHFZHalqChORdaHxDJDg3aXuPETGc+G4thmpKtJ5Ajk31b3XuBb8M4yvXKT8UaD
 aRmOVM9sNEzBQoir1MVVeBD/B83mzLRMMCoNI39d09mQ1AhicYpQuW7otWxMCl4h8wGp
 G4xRK8uHu24XdkAb9gKvAUj7UzJFi/GSlYSslYSQC52EYlCvpQHgTSTpymllah42JmVN
 6xoWmrw4TercJOEb9FNJMiFYsHRucvQaMfMYab7qQZvQ/F+YfgX7kSe97T6OHtjjYFHN
 3js6JoM5qv1GEmh4w4o66UR28e1FLIPm66TAT8HjhUqX/xHMNCRZbDU9EZzzotO6GR+D
 7QQA==
X-Gm-Message-State: AOJu0YwzeuGvNE1hvRQsmJJu64802Vmfi0nnJPzQGmD2W1yXAJ5abNUl
 YPYSIpYfBJZwP3t0s6ha+8H+UuGqJYcgFu5/MXs=
X-Google-Smtp-Source: AGHT+IG9w7aQvEiov3fhjzsyLoZuCqQv31fh2lf4djm2MMCbVsWOXBnZKoFGpptx9KR6dj7Tn5rAMg==
X-Received: by 2002:a9d:4d07:0:b0:6bc:fb5f:7b06 with SMTP id
 n7-20020a9d4d07000000b006bcfb5f7b06mr731046otf.17.1697671901979; 
 Wed, 18 Oct 2023 16:31:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 08/14] linux-user: Detect and report host crashes
Date: Wed, 18 Oct 2023 16:31:28 -0700
Message-Id: <20231018233134.1594292-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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
the guest.  With an artificial error introduced, we will now print

   QEMU internal SIGSEGV {code=MAPERR, addr=(nil)}

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20230812164314.352131-1-deller@gmx.de>
[rth: Use in_code_gen_buffer and die_with_signal; drop backtrace]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 69 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 84a56b76cc..9fadc51347 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -32,6 +32,7 @@
 #include "signal-common.h"
 #include "host-signal.h"
 #include "user/safe-syscall.h"
+#include "tcg/tcg.h"
 
 static struct target_sigaction sigact_table[TARGET_NSIG];
 
@@ -779,6 +780,50 @@ static inline void rewind_if_in_safe_syscall(void *puc)
     }
 }
 
+static G_NORETURN
+void die_from_signal(siginfo_t *info)
+{
+    char sigbuf[4], codebuf[12];
+    const char *sig, *code = NULL;
+
+    switch (info->si_signo) {
+    case SIGSEGV:
+        sig = "SEGV";
+        switch (info->si_code) {
+        case SEGV_MAPERR:
+            code = "MAPERR";
+            break;
+        case SEGV_ACCERR:
+            code = "ACCERR";
+            break;
+        }
+        break;
+    case SIGBUS:
+        sig = "BUS";
+        switch (info->si_code) {
+        case BUS_ADRALN:
+            code = "ADRALN";
+            break;
+        case BUS_ADRERR:
+            code = "ADRERR";
+            break;
+        }
+        break;
+    default:
+        snprintf(sigbuf, sizeof(sigbuf), "%d", info->si_signo);
+        sig = sigbuf;
+        break;
+    }
+    if (code == NULL) {
+        snprintf(codebuf, sizeof(sigbuf), "%d", info->si_code);
+        code = codebuf;
+    }
+
+    error_report("QEMU internal SIG%s {code=%s, addr=%p}",
+                 sig, code, info->si_addr);
+    die_with_signal(info->si_signo);
+}
+
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 {
     CPUState *cpu = thread_cpu;
@@ -814,16 +859,28 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
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
+            die_from_signal(info);
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


