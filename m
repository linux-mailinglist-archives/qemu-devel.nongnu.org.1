Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC37CEC14
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG1B-000483-EG; Wed, 18 Oct 2023 19:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0t-0003rB-AS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:43 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0r-0000JX-Jf
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:43 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35757bfb3f7so28872835ab.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671900; x=1698276700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HR6OhNjXMnjPeW+GKwBhvGRBpRXClWtOK/vmyhs99O8=;
 b=Q2h+rqhZP/VuOhuhJBPUC+pYz1Ni0cd+/mXSDmr6rBfHRuAjzeT8Hq4ACQo/VwcjOK
 bNsmiLaWnMavwKjZRjfdA4SFwYvXS+MgQCQo9IcaJc5ZPwvuhWdlVJMqE+rVNlY9T/n9
 0MR8IJdGmJgh6Ujz49P8PYzo7Z5ULMGromwIzREJBGL3xnRUb5QBp71GJYDWPmOZjW+O
 Q5LQ0m1FmPZcmm+8klaTPELYzT9nd8fJGY/WovEyuh55CaiAJ71qy1gli6Bp4G4AnDLe
 O630yfdG5WyDGVUr+jV32p4M4/r8ahFHZSh3AIW0sC6gzMoAUUblKOAFZ7G5eUGKjGAe
 DFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671900; x=1698276700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HR6OhNjXMnjPeW+GKwBhvGRBpRXClWtOK/vmyhs99O8=;
 b=XWP3j2rC+GO+CqlA+DcgJN81THZF02YuV8qJHJYQFlcFVJHw6vVICse30F7BvrWLdx
 6+xU8it0q+GIMTwdKRd7ee3PL91v2PvKinbr3GFwS/iVVpuC9WQEA1HJOlbjCrr5X7l7
 /ZPOEYk7ZMv83sy1s8Az1R4wMP0uY30m0vxrauoZhscOmkQky3GDTIzg7j1wVhmeWKvn
 XhYfOUYIWtldcnEm/r/yNlB1dC8OgmxbH1yRtRpgqJ8hmp4kzabdQm68sEiUVlLMWwYl
 jJ97oMEK/KqarFAb4KhRSOIvYAzRcVkUo8b8F/pgsBqTNgZ6UaTr8C7uMM+au6EoHDC2
 6dRA==
X-Gm-Message-State: AOJu0YxlA/cUCafIsRRcnyNpAIqOoO4WRTk5VUCtjdNSZEjzrNsTXLXM
 M2E1fL0CGtZaSeM3gi1UmGrzKamNX/ZpyVSSf/A=
X-Google-Smtp-Source: AGHT+IE1VFj4HJaZkhv20LfcraCD09eH6yPZXMQCghbmIYGz99xBpR4xzK4BR0sR99N+7Pus/dntCw==
X-Received: by 2002:a05:6e02:219b:b0:357:72e5:4adf with SMTP id
 j27-20020a056e02219b00b0035772e54adfmr1090888ila.26.1697671900599; 
 Wed, 18 Oct 2023 16:31:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/14] linux-user: Split out die_with_signal
Date: Wed, 18 Oct 2023 16:31:26 -0700
Message-Id: <20231018233134.1594292-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
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

Because we trap so many signals for use by the guest,
we have to take extra steps to exit properly.

Acked-by: Helge Deller <deller@gmx.de>
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


