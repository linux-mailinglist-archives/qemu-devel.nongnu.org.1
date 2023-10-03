Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E607F7B71A8
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkx5-0004t3-U4; Tue, 03 Oct 2023 15:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwk-0004qs-Ju
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:43 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwT-0004dh-S8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:40 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so9979445ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696360816; x=1696965616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQP2+HZbJmIj9sXXPBVMTwI7vC2S6c38AoM7akl90XU=;
 b=lzog5Va2VVr3xhuo199ZJGARfS2H5rUovzlLFwuosMlYubSR8qyo1CvM7RP1E6BKZK
 dk/EDDyoJOlX5NfVFFZTemeajSFPg7bchO8JHbOvB0dstxI/owbd56KhGmiE19m2zab+
 CVvp+uRVoaudipLppRMAs4u81EXYy1/8wjchnuwF2G1Vh5y/L6Xq6QXxJ4XBM2GB+5uW
 CQg70nvbWNV1idmAChMz3NYwVYW2S3Ny2xzfUqmQk3lT830kHwhkruM/hDK0tS0G9Q8Z
 Tpig7Z2mhm1ahJBRDnFp8eBjWRR6gKiBJpTiSg3y/ylJH60owaoROXy6dFDyNV6ALf5N
 FhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696360816; x=1696965616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQP2+HZbJmIj9sXXPBVMTwI7vC2S6c38AoM7akl90XU=;
 b=qXwucJNCRGlfUbZPuAI/ToplFngGMKAMPAvE6IowHo5hovvo6SowHLRm8rgowFjvJc
 qOPZ5BzpsJSThCan3gfYreFdbKcIzIBW5Xmb1hDv0S7J3zgYberjIc07i2oHniAEPPDi
 VtqxSWKtcGRxOCTCirRcpTK8MWqTwy4hpNPtIBmSJt4m9KCRfv5jNS17dzf8zOSUVZUf
 ehxJgpRzBajtg+RmLR1fOikBfUbt7Ib7JVTdtS95lb1GbFH8yXMkRN47pJjkn+m+QRie
 BJ3TvntzTVd9a/fZJK7RmiT7qqQcvJv1DhJGItalvh8pF3vMkD8ISKO7Gtx8l1bvmNvN
 n74Q==
X-Gm-Message-State: AOJu0YzjtyDydC5JF9UlcQS/pbrG8urLOvkWmFijO8KXNnwMtvEZLUNM
 mbYGhPx2L9p6dOSd1bIA9Pyv9z1OQ7dLtVmdXmg=
X-Google-Smtp-Source: AGHT+IEKXCU5jieZpkhL9CvgoX7Sk802ujtP/pCkUp636JdIT5gHloZ5f1yKUkkC2YdCIoGctmuY4g==
X-Received: by 2002:a17:902:c946:b0:1c3:e3b1:98df with SMTP id
 i6-20020a170902c94600b001c3e3b198dfmr488534pla.52.1696360816134; 
 Tue, 03 Oct 2023 12:20:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w5-20020a170902d3c500b001c5fd2a28d3sm1978497plb.28.2023.10.03.12.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 12:20:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	deller@gmx.de
Subject: [PATCH v5 3/9] linux-user: Detect and report host crashes
Date: Tue,  3 Oct 2023 12:20:06 -0700
Message-Id: <20231003192012.1674888-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003192012.1674888-1-richard.henderson@linaro.org>
References: <20231003192012.1674888-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


