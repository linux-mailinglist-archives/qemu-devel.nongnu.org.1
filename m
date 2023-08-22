Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D557784B80
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 22:35:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYY51-0002dD-W9; Tue, 22 Aug 2023 16:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYY4z-0002bF-C2
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 16:34:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYY4x-0005EA-0x
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 16:34:21 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso31914915ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 13:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692736457; x=1693341257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcsO2dVLbPUl+GizLMpXodQLIxyTwrwgsESLGfn+SH8=;
 b=VLZUFW0puMsbd5bEY4Jg2KILmem0iqqISnxTFNRXVTPGqFgmCli0q03YRfVJKAsMHH
 ktpNrL6fBoIOuQrj62rOb0TgrlT3N7+NJU+hZSs7Qlf8IlJLyfhjbgDRa2EZxhlJertR
 5K0J/JS6dqz+aojWgPW6kLW4ByNQlI7k1HR+QRE/J99vDxbLyc5uwHnFhtr8Ca6M2n64
 /HSsRKd5PKS8w4xfTux0az6O8TgIeOBBS3BdFhKtSNeHnvWv6it1E3fCvqVqDd1AW3M6
 BP2U0DikWSlwb3GoMKJcIT2ZJLMMFKi+5YLKa49bzO2vak9+TAlYmCRymO6xXsdP4hxt
 7cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692736457; x=1693341257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcsO2dVLbPUl+GizLMpXodQLIxyTwrwgsESLGfn+SH8=;
 b=UpE97oomXayjV2KhBuX//lmika8xKqNvhCMHjw6Vq/2MmJPWDhJmFhAqcmFBIVma3d
 LMYMMeFQ5uOjx9IKPkFgW8PNQeD48hzYc21kOuAZqlLOcpylDdz9o4guWBVOQ0J5mq00
 mpyc6HvVgSRFskzdSEkv9jAnZVk2hORM0pGF70Hiop/ghcTqpUbDj58NbcM2ooKZQx/+
 8drVb8uFDO5I5QhkJwm3rbpiXXatNhbqPb/zMAKJa8ZTFKVxx4BsWd6kJRztV3o67t+a
 fbuWCNF5dSRjKUPgbWweUtf1mdb88hLvbKul/XO6/9gJwbvd3LgRGp0m/b6WNTD5DzCF
 Ducg==
X-Gm-Message-State: AOJu0Yw01fffsG93pGAapYJOYc3qUTpsj8xksobwKjEFFDFZCexqnC3i
 sKpX0HKPNngz7PPKBYKEF+eXGBULBtDKt+ibw4Q=
X-Google-Smtp-Source: AGHT+IFDMhMe/74JyadU5Bv2WCqqyeq9KJZdivNwlA5cBAvpbVDhsWFS/8d1mGSrj4Qra+J0EE7X+A==
X-Received: by 2002:a17:902:ab54:b0:1bc:2bd:8523 with SMTP id
 ij20-20020a170902ab5400b001bc02bd8523mr7431103plb.24.1692736457507; 
 Tue, 22 Aug 2023 13:34:17 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 i25-20020a633c59000000b00564aee22f33sm8311823pgn.14.2023.08.22.13.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 13:34:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 1/3] linux-user: Split out die_with_signal
Date: Tue, 22 Aug 2023 13:34:13 -0700
Message-Id: <20230822203415.1184491-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822203415.1184491-1-richard.henderson@linaro.org>
References: <20230822203415.1184491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


