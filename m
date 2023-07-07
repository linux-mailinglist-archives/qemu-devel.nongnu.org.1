Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2867274B831
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGE-0004i2-9a; Fri, 07 Jul 2023 16:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGB-0004hQ-R3
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:40:59 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsG9-0004XO-IN
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:40:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso25946195e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762456; x=1691354456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whM4RTqMxl8XBjCzUj72s/nZoQ17sZLwVy1RI4UfkRo=;
 b=LzF4AaLuHhGKgo2DTblSFwkPX5lDHHvolXsxNpPi6I4rfxNCwrBaa47A+LPF5tmpGC
 R0dAm2/EE8OgWXHBq3XhFkmJlsn1WC8rcDU2R8mTSfTUWTUes665zfF9y8rGFr3yLevg
 H5sggPcc1V5QyKn9oGU8TJv05foouBdvsQlxKv3je9yooW+7I2KxOWpw94dBBQ0Su/AI
 eykFe1gfpicO85p3B5L4qZm8pEoi0VBOMyCS/9gI5rPzkqZ8jNygl0qQVfqd6n/tVG3/
 2xnWibCfgSarjMq3slBD7sRsiukFSsAiUlHdn14AVDLaB+SAn51JnkqRnShsKTG0Njay
 NBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762456; x=1691354456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whM4RTqMxl8XBjCzUj72s/nZoQ17sZLwVy1RI4UfkRo=;
 b=QsajSbt3It32ToeBirKzQWPYztfvyX/KAkv30175YgtnOB7R4rxcy+ziVLAeeHxVY1
 Evx9zeIUWq7ByC7e1oOFnGtKL7yvHetHmrwRH+/ydEMq3h3SyGNHXVWGzJLNnGz+0/ui
 ZnQL46EnGrgo/xZWUoj/1btNcbQrAwH2Ermt2G+sCnTDEz6pp8L2n1JSrCJV5/ox9Hh3
 rDXJHmeptaIGJHznpAqhEu/ddcYyC3lwRBv/M/eQ8b5mm44hkHWIsUxDSmhDejPGjkUU
 KhELcv2QHWnVRR8TMoR4bJu+WRjL+8Zd7rNsyyq85L3EDHKtdLVVwDKhF6o/aHI8GMFC
 Idmw==
X-Gm-Message-State: ABy/qLZh60l97spbze7NgqHqnysCdyGG5lAl5N/L2IL0a5bttAaK5obF
 swDaZAmCh+OKjYjM87UP5HPq7dXMX6pGWL2scic5tA==
X-Google-Smtp-Source: APBJJlFODsjlwYoYhw9+D/uOuqnP3M044kKkM/kTfCc6M8LmOUWuYSP1Xwu0E4kLdYZeVfethzrWOg==
X-Received: by 2002:a05:600c:22cf:b0:3fa:96ad:5d2e with SMTP id
 15-20020a05600c22cf00b003fa96ad5d2emr5221828wmg.19.1688762455956; 
 Fri, 07 Jul 2023 13:40:55 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:40:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru,
 "Richard W . M . Jones" <rjones@redhat.com>
Subject: [PATCH v2 1/2] accel/tcg: Split out cpu_exec_longjmp_cleanup
Date: Fri,  7 Jul 2023 21:40:29 +0100
Message-Id: <20230707204054.8792-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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


