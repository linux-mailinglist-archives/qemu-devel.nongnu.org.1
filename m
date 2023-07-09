Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3774C73A
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:38:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAn-0008Tn-4J; Sun, 09 Jul 2023 14:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAf-0008Qk-Bs
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:09 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAd-0000uN-Nt
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbf7fbe722so43507045e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927406; x=1691519406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPSt9c/ngpAMvKxksu2NUPKStpNSLJ8TjY6ZtwR8h/Q=;
 b=H80W49X/1I3xQtKjgOvJJoRShUFaD5gTWN0M1aKZI9c1oRkqKWt+31VXZfFel7/nwK
 WSqYbHqe6TQBX8m3Nr1KDv885sY/ES2+RMD4rzJAXfBeaDN7nnSue6hNgsRQQUzTekb3
 LHpId5tlj2N+hd2EfH8WrGbxuxBb1cWuOP90NjFQyxL+LsutqTaQ9fqPvTEP/RUG7pbI
 ZSqPJ1OX2widUV+XTGy2TBuHRbValKSqfZu3VU27pdHX8B27JF26BJ1YIfBPmkPYZD2r
 K7XrgkjAbgFNnOwjWtAVoSy9MxnaVjrjNsOKDIoK4SkZskx9wQumpnhYAk95lsubPkky
 9ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927406; x=1691519406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPSt9c/ngpAMvKxksu2NUPKStpNSLJ8TjY6ZtwR8h/Q=;
 b=jN5QqBuR+LYHQ9X4ku24VoRVjtVlwYhHcAgCLpNcKNVgI4xWQR/NV4cm2Ftolzju7L
 uJzPBohmJvYU5O7S4NW3aDqV8wfk/wYYrcNIYFDlNvR7DW/zTBBFGX9mZ7RSWTL2bsGA
 W0QSpi+imDt4KheFyF8rxzJ97iZaTfkC5IAwGh+FosNF1D55AdEV2m3amrxoB/5lDLTG
 WAtSAVwU1VeQg1APtdB/5Jgl+Bls5aPqj1dwRHOe/jco1y3SNzkgLgcKhqcvgLL+DExp
 PJHVd60zvjA5RjBUwtyMGWFInzDKqosd8ItODTex3npCoZnGgpGdkTOvYhpZlMnkOUPV
 gCBA==
X-Gm-Message-State: ABy/qLYzjyhpPTva+eEHJg6S/TUDwYW3raPk3PcxiGCjXhR25nDvpCuQ
 JkK57Ujs591rzQacjHhaQQ4pbXE5cF1j4887L7Zmcg==
X-Google-Smtp-Source: APBJJlF845sYS71J8+y8CxIVykPPVRWGgfQHUljCcUWCXjXYQSDgw2nehpYc6Vp7i/8Qdg32G/XRPQ==
X-Received: by 2002:a05:600c:207:b0:3fb:fef1:68b7 with SMTP id
 7-20020a05600c020700b003fbfef168b7mr9610999wmi.27.1688927406441; 
 Sun, 09 Jul 2023 11:30:06 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:30:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Richard W . M . Jones" <rjones@redhat.com>
Subject: [PATCH 18/45] accel/tcg: Split out cpu_exec_longjmp_cleanup
Date: Sun,  9 Jul 2023 19:28:47 +0100
Message-Id: <20230709182934.309468-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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


