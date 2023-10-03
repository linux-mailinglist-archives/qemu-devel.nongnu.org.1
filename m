Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7613B7B71AB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:22:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkxP-00052p-HT; Tue, 03 Oct 2023 15:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwy-0004vT-LU
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:58 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwT-0004dS-Us
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:56 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2773f2e599cso960203a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696360814; x=1696965614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQFT1MeaWl1DywCggWsF6gUy0qHwX2/cAPNMuk55ZU0=;
 b=pb99Swa/hbwJL/Zia60/yXd+Wn6OIj50niL5WoiCeSJf1//LuW3x5Qt94RapwsnGPz
 2TtWcWhgWLPy3FqVV9sbP2YVQdvvfg7115VXvjLKupPSkAeJgaH9vIYgvpwwgRLBCsoS
 m2mqii+ztsUQVvAUE3Z0GN3Kyl0tejjhIRZHHDPBBFtT0xrYROkvzeqbski8iDOoUnD+
 /C1Z9EYgctcMK+QfCvh+tYwi9c2wL3aF74NgGHk/Yh0HbicTOT5VTnx5SvUUirJ34P6E
 y9hGNrVeCnTGLMcmS1bBmVXUPEEeiqS2Zv9vgDe8d2eb18BSb677z7i2i4NoQDajj/kE
 SxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696360814; x=1696965614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQFT1MeaWl1DywCggWsF6gUy0qHwX2/cAPNMuk55ZU0=;
 b=ft9N1lK8VTgpF9sxzSfw7ct56tr9xgHMfqjlhBLis/Qv6e4H+pfZUkw7/F5DqF8ymz
 PRE6KMbecfeiG+X1Q5tyJjdJrOHqIb1m9+4CTJ1UEJrvxyZbYVtkFz7lT1zvJAhCeFA5
 UOzwySlA+aRKYNHB2e7sx6s582r8nbZvvSNMeVD/ncHG5kb5QaAUhWuWFiq6uq0INk3r
 dtac750LEDYsUof96uJPB8T771uTyEpyMcBA56vqxdT4ybxzFbNhusroM1xrLlR8Bux5
 XL2Zlk5YWs4SBbqIhHe9p0Nz3oSNq2vzEL/uywM3iNzGvsNXZ5bbgAPg7w8ya8Y2tmCk
 HTfw==
X-Gm-Message-State: AOJu0Yykfy3ntCj0/uP5+n/RNQse6tY/CQW1qjyR/fzdV+dWcx2FLudq
 4Zx4WeBh7j0jvs8yZsBfxphQnf6Y7FuHd44e1iU=
X-Google-Smtp-Source: AGHT+IFUMfPxx5BInY+KcIxcybTMBOTy9MfMuXAtlNbH8QIvP6O5DRz4mTjEFMd5/Fr9iuOKozNiLw==
X-Received: by 2002:a17:90b:224d:b0:274:566a:3477 with SMTP id
 hk13-20020a17090b224d00b00274566a3477mr240985pjb.39.1696360814503; 
 Tue, 03 Oct 2023 12:20:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w5-20020a170902d3c500b001c5fd2a28d3sm1978497plb.28.2023.10.03.12.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 12:20:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 1/9] linux-user: Split out die_with_signal
Date: Tue,  3 Oct 2023 12:20:04 -0700
Message-Id: <20231003192012.1674888-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003192012.1674888-1-richard.henderson@linaro.org>
References: <20231003192012.1674888-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Because we trap so many signals for use by the guest,
we have to take extra steps to exit properly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 52 ++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index a67ab47d30..b7a2c47837 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -689,13 +689,39 @@ void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
 }
 
 /* abort execution with signal */
+static G_NORETURN
+void die_with_signal(int host_sig)
+{
+    struct sigaction act = {
+        .sa_handler = SIG_DFL,
+    };
+
+    /*
+     * The proper exit code for dying from an uncaught signal is -<signal>.
+     * The kernel doesn't allow exit() or _exit() to pass a negative value.
+     * To get the proper exit code we need to actually die from an uncaught
+     * signal.  Here the default signal handler is installed, we send
+     * the signal and we wait for it to arrive.
+     */
+    sigfillset(&act.sa_mask);
+    sigaction(host_sig, &act, NULL);
+
+    kill(getpid(), host_sig);
+
+    /* Make sure the signal isn't masked (reusing the mask inside of act). */
+    sigdelset(&act.sa_mask, host_sig);
+    sigsuspend(&act.sa_mask);
+
+    /* unreachable */
+    abort();
+}
+
 static G_NORETURN
 void dump_core_and_abort(CPUArchState *env, int target_sig)
 {
     CPUState *cpu = env_cpu(env);
     TaskState *ts = (TaskState *)cpu->opaque;
     int host_sig, core_dumped = 0;
-    struct sigaction act;
 
     host_sig = target_to_host_signal(target_sig);
     trace_user_dump_core_and_abort(env, target_sig, host_sig);
@@ -719,29 +745,7 @@ void dump_core_and_abort(CPUArchState *env, int target_sig)
     }
 
     preexit_cleanup(env, 128 + target_sig);
-
-    /* The proper exit code for dying from an uncaught signal is
-     * -<signal>.  The kernel doesn't allow exit() or _exit() to pass
-     * a negative value.  To get the proper exit code we need to
-     * actually die from an uncaught signal.  Here the default signal
-     * handler is installed, we send ourself a signal and we wait for
-     * it to arrive. */
-    sigfillset(&act.sa_mask);
-    act.sa_handler = SIG_DFL;
-    act.sa_flags = 0;
-    sigaction(host_sig, &act, NULL);
-
-    /* For some reason raise(host_sig) doesn't send the signal when
-     * statically linked on x86-64. */
-    kill(getpid(), host_sig);
-
-    /* Make sure the signal isn't masked (just reuse the mask inside
-    of act) */
-    sigdelset(&act.sa_mask, host_sig);
-    sigsuspend(&act.sa_mask);
-
-    /* unreachable */
-    abort();
+    die_with_signal(host_sig);
 }
 
 /* queue a signal so that it will be send to the virtual CPU as soon
-- 
2.34.1


