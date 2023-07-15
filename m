Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D53C5754904
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjl-0006Rz-3b; Sat, 15 Jul 2023 09:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiN-00045M-I6
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:40 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiK-0001Gs-Pa
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3094910b150so3067963f8f.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429214; x=1692021214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPSt9c/ngpAMvKxksu2NUPKStpNSLJ8TjY6ZtwR8h/Q=;
 b=SXRp5ip1qgGnb2AYrM50ZLVsfXoYjtYlbeA+FLdZB1Ek9gWdhuvoxpDD4lqY5GOM7S
 jx8qVgun/qW1/hEIGWK45CtgUNymy8iOEypJFydySVeSyvlOv6gzgmp+pg1LtpyfZu0T
 8hnX09zPnGMpcKvS9U5wua/VnhOX6nxRvH6CiYcbYXObxyLhifvnR+hNHFZ0MIUtav3/
 k9HXxQRSVNflrTh3dVfGBmkbOB6xDQTqBNGMH7SXBc8m7BWBF1oLpU+P+bbmI/hc8adw
 LU18hEp5f4j/dPcw6lo+VE1NEXQVYs+xJQNoMDlVRJChEwkZ4xEBV6St/UxitPtUvu7t
 FvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429214; x=1692021214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPSt9c/ngpAMvKxksu2NUPKStpNSLJ8TjY6ZtwR8h/Q=;
 b=O9Bk8lw/piKM9pTL9iHW2NZgB9hv0PD5hFH9bDRSMBwvN0nrttwz/DYtsNtPjm+uCR
 i8gsF76st+bOr5Qd8mI5+tIiwhnRct26QOji0uVsDH0721EqLGiyfx3AxOBAbxbtYtav
 Y/MWbli7pbgmbw44ojusCZeX0JBaRAwmKIPq5gay66bJvFl13bBn+bVf5sVBeHWWC+g4
 ZOBlSgktJ7el76D/x1TRbDtz320wHw/gQswdMYIDlpdZvj/eyO12GJIb11iMYq2kB00p
 Ul4qc/y+p7RK+5ixxyvnQDaPH+uHqU8vTN2NaITumRGhuyjJn3bbqgL1VZxi+5A6vSqm
 7oSQ==
X-Gm-Message-State: ABy/qLbV7gFYSEK935SC7qG+tQNWOtYcFx2hJnMZfsPDiQl5gdP8M8uj
 0je2aAZ1da0MnR7rBvgOu9y7tFKrECxnlrh5rtlnOQ==
X-Google-Smtp-Source: APBJJlHPfAtmLxUgRx1KXnllskaahA2u0E42lJ/RIEITz3uNqBVXJ2zdLGlwgg0nSi3ev8YjNn+2Vg==
X-Received: by 2002:a5d:4bd1:0:b0:315:a74c:f627 with SMTP id
 l17-20020a5d4bd1000000b00315a74cf627mr6938552wrt.16.1689429214383; 
 Sat, 15 Jul 2023 06:53:34 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Richard W . M . Jones" <rjones@redhat.com>
Subject: [PULL 18/47] accel/tcg: Split out cpu_exec_longjmp_cleanup
Date: Sat, 15 Jul 2023 14:52:48 +0100
Message-Id: <20230715135317.7219-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Share the setjmp cleanup between cpu_exec_step_atomic
and cpu_exec_setjmp.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ba1890a373..31aa320513 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -526,6 +526,23 @@ static void cpu_exec_exit(CPUState *cpu)
     }
 }
 
+static void cpu_exec_longjmp_cleanup(CPUState *cpu)
+{
+    /* Non-buggy compilers preserve this; assert the correct value. */
+    g_assert(cpu == current_cpu);
+
+#ifdef CONFIG_USER_ONLY
+    clear_helper_retaddr();
+    if (have_mmap_lock()) {
+        mmap_unlock();
+    }
+#endif
+    if (qemu_mutex_iothread_locked()) {
+        qemu_mutex_unlock_iothread();
+    }
+    assert_no_pages_locked();
+}
+
 void cpu_exec_step_atomic(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
@@ -568,16 +585,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         cpu_tb_exec(cpu, tb, &tb_exit);
         cpu_exec_exit(cpu);
     } else {
-#ifdef CONFIG_USER_ONLY
-        clear_helper_retaddr();
-        if (have_mmap_lock()) {
-            mmap_unlock();
-        }
-#endif
-        if (qemu_mutex_iothread_locked()) {
-            qemu_mutex_unlock_iothread();
-        }
-        assert_no_pages_locked();
+        cpu_exec_longjmp_cleanup(cpu);
     }
 
     /*
@@ -1023,20 +1031,7 @@ static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
 {
     /* Prepare setjmp context for exception handling. */
     if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
-        /* Non-buggy compilers preserve this; assert the correct value. */
-        g_assert(cpu == current_cpu);
-
-#ifdef CONFIG_USER_ONLY
-        clear_helper_retaddr();
-        if (have_mmap_lock()) {
-            mmap_unlock();
-        }
-#endif
-        if (qemu_mutex_iothread_locked()) {
-            qemu_mutex_unlock_iothread();
-        }
-
-        assert_no_pages_locked();
+        cpu_exec_longjmp_cleanup(cpu);
     }
 
     return cpu_exec_loop(cpu, sc);
-- 
2.34.1


