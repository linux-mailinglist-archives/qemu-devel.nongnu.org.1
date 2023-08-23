Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B507784FEE
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:18:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgEJ-0004xF-JE; Wed, 23 Aug 2023 01:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEI-0004x3-4h
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEF-0000tY-OV
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf092a16c9so41295065ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 22:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692767786; x=1693372586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9nEQb22Vi1UF1dUb8GzU/CvfTl2MHdw8gP+pRmxf80=;
 b=We7ZcoypwsN83nU6AT5pA20G536fzY+1J2h4IpXAX71VdWXYQtHCAER4NrfgcjHio5
 lCMJMcnHr2aadKYU7HPMAbFVcFNrjDESez0TNr4O8IdKmJL3OJpnrqhtbUZYJ69wXhyg
 hQO+1zZ8oQ+VF7DgH04DKAkYhF/Xjvebu3ioScYsH23nzRwaucuXvhQMNkvJ9NqoWhRp
 dJ1F5ztB7EbLXZez1xKxEMtL7igjP4K6sNqoF8yCxOuEBugliqp9IYgoO4Lk8TAuCtGm
 CyCUEbjTtyGLR2SiZibNxpEH8CLt5g5ggq5Q4pjgLDaxrzculvsujmaoZPvNrg/uOpsZ
 eAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692767786; x=1693372586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9nEQb22Vi1UF1dUb8GzU/CvfTl2MHdw8gP+pRmxf80=;
 b=FV3zl3f+j0aN6VXqZnvw8izfg9Qey8Po6sX135mlk4bR0yR1o1fTHmRnEoe9/NT/0E
 /7gBaEx1i3eWGYiAbdZf9j0GdbzLYX4jkHySrDh2J5ThmGU1iY9FTUioDlCQ4m0ol1PJ
 yIgpKMEsmKJz4hogLmr9Xc9qWw+Qvyz3UcTo7JuRSnSYr/mEpLLMgPbOt3TpBQipeOTk
 jllBOnixtqCcOQBFsWc6ExDKcBk2SVSEkGS2Q5ZEbYbnLvwRMgATj5MBBNgqsv8qR4dK
 ZuG5RDFfGklz9nj5UoW7M/CaxMZSw5dzAfr5ne36ELPBD6GjsqPGmN+6E6o81UjlA/k+
 znGw==
X-Gm-Message-State: AOJu0YzNMmGF8x9amR/q8Hc5QNUdqfiKo7+nTK/8IM8wMbyXDMqHKt7G
 8cvT5YBp4VvhkzYxaz2dNRqsrh0hms2kM0PmCrs=
X-Google-Smtp-Source: AGHT+IGJWyotsnHwY8d/tMB6caCv3Eo6WunSEkwjO0X0HUmV2t06DDBOzNVVeNlkCt9G3esVPbJ2+Q==
X-Received: by 2002:a17:902:e846:b0:1b9:e241:ad26 with SMTP id
 t6-20020a170902e84600b001b9e241ad26mr14829987plg.9.1692767786328; 
 Tue, 22 Aug 2023 22:16:26 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001bf044dc1a6sm9969402plg.39.2023.08.22.22.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 22:16:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v4 08/10] linux-user: Simplify signal_init
Date: Tue, 22 Aug 2023 22:16:13 -0700
Message-Id: <20230823051615.1297706-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823051615.1297706-1-richard.henderson@linaro.org>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
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

Install the host signal handler at the same time we are
probing the target signals for SIG_IGN/SIG_DFL.  Ignore
unmapped target signals.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 47 +++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index b8913968cc..a6917eadd8 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -566,10 +566,7 @@ static void signal_table_init(void)
 void signal_init(void)
 {
     TaskState *ts = (TaskState *)thread_cpu->opaque;
-    struct sigaction act;
-    struct sigaction oact;
-    int i;
-    int host_sig;
+    struct sigaction act, oact;
 
     /* initialize signal conversion tables */
     signal_table_init();
@@ -580,28 +577,28 @@ void signal_init(void)
     sigfillset(&act.sa_mask);
     act.sa_flags = SA_SIGINFO;
     act.sa_sigaction = host_signal_handler;
-    for(i = 1; i <= TARGET_NSIG; i++) {
-#ifdef CONFIG_GPROF
-        if (i == TARGET_SIGPROF) {
-            continue;
-        }
-#endif
-        host_sig = target_to_host_signal(i);
-        sigaction(host_sig, NULL, &oact);
-        if (oact.sa_sigaction == (void *)SIG_IGN) {
-            sigact_table[i - 1]._sa_handler = TARGET_SIG_IGN;
-        } else if (oact.sa_sigaction == (void *)SIG_DFL) {
-            sigact_table[i - 1]._sa_handler = TARGET_SIG_DFL;
-        }
-        /* If there's already a handler installed then something has
-           gone horribly wrong, so don't even try to handle that case.  */
-        /* Install some handlers for our own use.  We need at least
-           SIGSEGV and SIGBUS, to detect exceptions.  We can not just
-           trap all signals because it affects syscall interrupt
-           behavior.  But do trap all default-fatal signals.  */
-        if (core_dump_signal(i)) {
-            sigaction(host_sig, &act, NULL);
+
+    /*
+     * A parent process may configure ignored signals, but all other
+     * signals are default.  For any target signals that have no host
+     * mapping, set to ignore.  For all core_dump_signal, install our
+     * host signal handler so that we may invoke dump_core_and_abort.
+     * This includes SIGSEGV and SIGBUS, which are also need our signal
+     * handler for paging and exceptions.
+     */
+    for (int tsig = 1; tsig <= TARGET_NSIG; tsig++) {
+        int hsig = target_to_host_signal(tsig);
+        abi_ptr thand = TARGET_SIG_IGN;
+
+        if (hsig < _NSIG) {
+            struct sigaction *iact = core_dump_signal(tsig) ? &act : NULL;
+
+            sigaction(hsig, iact, &oact);
+            if (oact.sa_sigaction != (void *)SIG_IGN) {
+                thand = TARGET_SIG_DFL;
+            }
         }
+        sigact_table[tsig - 1]._sa_handler = thand;
     }
 }
 
-- 
2.34.1


