Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5074AECD
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:37:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHip5-0001c5-K1; Fri, 07 Jul 2023 06:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHip3-0001bc-7q
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:36:21 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHip0-0005IR-Ji
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:36:21 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fb94b1423eso2573906e87.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688726175; x=1691318175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whM4RTqMxl8XBjCzUj72s/nZoQ17sZLwVy1RI4UfkRo=;
 b=HHOTJT561vK2DTgt6mo1VhxT0909SdAgLFN+cbXLpcaVrh34j5QOukkiMZPD0ra/5s
 ff+fhQeYWnHhZeCzz/42Ch12q2xquJ1PpuL8ZH53uaAwHB+tZLeghpisqs3yfEp/QVdu
 WAjYSQ+/4710HLyc6jr9CgeMgkriG+sTJkAxD1wTOaBtOf2WlhjL1Rduwdj0OiE9E5d9
 rDeyZo0b7P5VZ/1U8MTArtaREKHN7pFPaNQ5QNNIRrY1PIIlAMrFmIDjn+s1YihmX2mS
 n6bjjBkF3QGNASl84mJkOmTwAFSrE88HLmwJF9orpXJ03Y9iR5hl9ZGW1fsuaBkP+emH
 sFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688726175; x=1691318175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whM4RTqMxl8XBjCzUj72s/nZoQ17sZLwVy1RI4UfkRo=;
 b=eVsZ2l2zVCmtmPQAO3++RmeuvhkYWPBInNGg+9AghFT6p3352ZYzyBZmGORJkbx8Ea
 y0W4nIkptKqbFXEuaY4EZ5O4av0PAwE/hu/0iqvfvl9NnA+d8MsmjuhX36Ls8mdiummT
 iIvycp9RRQgCy8s1iVf46hhxrfXrTgMiGQsS6DikTYKEx3zJ1M4YdQfMC3IRY1ZZoChe
 QPMxyZF1P7q1slCtRfL5kLySCaAm3Y6F/SXzzeabWqHxY2ZpsyBcWDjPcertUENYpvjO
 Gi91JRYAjG9xAYEgMobhgiS85ppFGmYPbNratjrr3XxCkjDVrkrG4q0EqYjIbtL9OTgA
 +L6w==
X-Gm-Message-State: ABy/qLYqnunqgbvbLW/MGvt7IKSu8CSJEcfIpOSjKKQKDtm8oyyZLnZr
 86lGmLH+utWt8mweh5sCyePfR3h/zgVjkg2fB0A=
X-Google-Smtp-Source: APBJJlGDkcfuKJdKpKAmcESNsH05K19ljIgGOem12CtehHHl/+Fc4aclDFcL995fBXyIK2Z+/7HlUw==
X-Received: by 2002:a19:3849:0:b0:4fb:8771:e898 with SMTP id
 d9-20020a193849000000b004fb8771e898mr3340378lfj.15.1688726175016; 
 Fri, 07 Jul 2023 03:36:15 -0700 (PDT)
Received: from stoup.. ([91.223.100.9]) by smtp.gmail.com with ESMTPSA id
 q14-20020ac25a0e000000b004fb953f74d3sm626966lfn.264.2023.07.07.03.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 03:36:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: rjones@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH v2 1/2] accel/tcg: Split out cpu_exec_longjmp_cleanup
Date: Fri,  7 Jul 2023 11:36:10 +0100
Message-Id: <20230707103611.5906-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707103611.5906-1-richard.henderson@linaro.org>
References: <20230707103611.5906-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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


