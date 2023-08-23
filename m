Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69C784FF0
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:18:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgEE-0004vN-CT; Wed, 23 Aug 2023 01:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEB-0004sj-6k
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:23 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgE8-0000s7-QY
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:22 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a4bcf8a97so2242398b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 22:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692767779; x=1693372579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcsO2dVLbPUl+GizLMpXodQLIxyTwrwgsESLGfn+SH8=;
 b=KY9jrHfrkOo0NzsIQTLJejbEcsfc0x/9Yf6qNffRYhYAdQXSAWpz5xpCmnX7V6FEt0
 rzloc1NnvUsiSwcCfpVuIDabdJ3Rkfz/Nd3MwIah6eaEgRYZH+wiAv5mzFVFP1FNBDgE
 9SPdZrzpyx+lOd+u1LmrWm2zi1XOzoRDA70DR3+S3NnhO8H5bkcLJdoqgz6vup1VNAec
 g7DetQrTJxZx/Ajil/WEcWfDG120uhwkw0pAqzct6dxdhIwcLtd2rxvZqGSCnNKe9SN9
 J6reIgOy6+ubWdwYqx02fRV27oTRtDVDgsWAsz6UjRT39beEsLPtJF0tP3SjRKb/xcok
 4xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692767779; x=1693372579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcsO2dVLbPUl+GizLMpXodQLIxyTwrwgsESLGfn+SH8=;
 b=W6CrIjO37Fq5WJr+Pb1FXEb3AZrbODFemb3hdHUzLcr4tjHVXxTF3q58t5ASYLAq41
 s25xJJ9Fu/OnG+5DrvIEu7PIxzmSORwefca3mcwKsu+qkkGknQ/RQCg4gkyJXF7sI9Ty
 iT6zXWZt60vpjm8ktB+a4reXjWvBOOpjjLaJn5gkXm+nEe10evUAdi61MSNXAhs6SE4d
 Eb76ktd8vgV7b6xwz8qu1Y+zxx8JvWXfvIanmKAJ7QSO5melxXPdYkRmfov8tQTOj9LX
 eSSHTOPOrlzWqxXwEOeYoNHpcpOE0g2DeslWuYyLwsYm2jJODgYNOMhI2u00ad/UOOas
 8QXQ==
X-Gm-Message-State: AOJu0Ywa+cuR5lm8YqCbawfgBS8qcsTWIPzCGDLvF1dR5jneutymCFt5
 W3/4CGNCig1QSc5OvG4SHGEirXK7Ph9Ea+UL6p4=
X-Google-Smtp-Source: AGHT+IGmniW6dPtBK4RaXrDeLZd6PmLIdBKxGXWhIBBaVrH59uldEHI7GVwEwhyys6WXsAhUDrRz9Q==
X-Received: by 2002:a05:6a21:47c8:b0:134:2fd0:73d6 with SMTP id
 as8-20020a056a2147c800b001342fd073d6mr9150242pzc.31.1692767779222; 
 Tue, 22 Aug 2023 22:16:19 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001bf044dc1a6sm9969402plg.39.2023.08.22.22.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 22:16:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v4 01/10] linux-user: Split out die_with_signal
Date: Tue, 22 Aug 2023 22:16:06 -0700
Message-Id: <20230823051615.1297706-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823051615.1297706-1-richard.henderson@linaro.org>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 52 ++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 748a98f3e5..e1cd111a1b 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -694,6 +694,33 @@ void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
 }
 
 /* abort execution with signal */
+static G_NORETURN
+void die_with_signal(int sig)
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
+    sigaction(sig, &act, NULL);
+
+    kill(getpid(), sig);
+
+    /* Make sure the signal isn't masked (reusing the mask inside of act). */
+    sigdelset(&act.sa_mask, sig);
+    sigsuspend(&act.sa_mask);
+
+    /* unreachable */
+    abort();
+}
+
 static G_NORETURN
 void dump_core_and_abort(CPUArchState *cpu_env, int target_sig)
 {
@@ -701,7 +728,6 @@ void dump_core_and_abort(CPUArchState *cpu_env, int target_sig)
     CPUArchState *env = cpu->env_ptr;
     TaskState *ts = (TaskState *)cpu->opaque;
     int host_sig, core_dumped = 0;
-    struct sigaction act;
 
     host_sig = target_to_host_signal(target_sig);
     trace_user_dump_core_and_abort(env, target_sig, host_sig);
@@ -725,29 +751,7 @@ void dump_core_and_abort(CPUArchState *cpu_env, int target_sig)
     }
 
     preexit_cleanup(cpu_env, 128 + target_sig);
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


