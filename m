Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC757B71AF
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkxK-0004zp-Oy; Tue, 03 Oct 2023 15:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwk-0004r7-Gx
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:42 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwT-0004dy-Rc
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:42 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-27740ce6c76so870336a91.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696360819; x=1696965619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcBnZHSbuxu1CEXsD4rb1K43nNPKQuPu10A2c8iY0Bc=;
 b=r1aYU5NlP+xZlqrGUDDxtHGyqTfATH5e2Ij5QXBzHgE8iRMsIqb1WPpuVZE6gziJFY
 sX/qgWlI304bA2ZwqlYyU5sbcc8kb1lGlXfTHLdSvMEh+Oq9hdBaIt2FKHUGYDhFPaga
 Ny2ExgOk3fC1AS8bvn4mpeMX8Glni+Ak8ocgWLhSe3LoadWF5bHFl6vKP9f8c8aDYlDb
 DOpa2oIooO4N6PadtuGN/IZ0krmXbx87UC6ezoldaKlAzb7wUWkMGw6Wpizxo+lZVhJR
 pEY6olW74XG7F+tbInH35yRY2JLTX5FsEQa9OT3yQ1DXOTUEka8J9cMofibMah2pMYv4
 n8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696360819; x=1696965619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZcBnZHSbuxu1CEXsD4rb1K43nNPKQuPu10A2c8iY0Bc=;
 b=pYMtkqP6Pj9VGiUhqkOhzr5kvF8gFPhSSoBWGmBCwYMMTJ4gI3pZNgrQPNc1u32g/x
 wdwtrToQE+a7W01XJhaL1xFsyvS/CVj45qLdhC3C7o4Fc9pzTMAOvJI46gI1udtLCn5F
 TfPkwoOcZdqU2c0issg0DqUH4o1mVXe+38aYqQ7WhbgEGCKORsdNgVjcOnxR+I1Y1b+Y
 2N6x43Cb7aug8Am17tCjaQ3rDtqbwfh5rBi3ov9n/qEdI52A+8BEXXgV68MdbWKury3L
 s/YZS5Ict502c38i+yqzwgDRRGLZoCOhQmTTbSnFUmi9UD80GWg8FjFy8MnjvAPFa1y8
 SzDA==
X-Gm-Message-State: AOJu0YzqOvJy3pP7F0IYTSK0v0mdRTAVUPcH2CQNcQD/oVKkW0lUuTFS
 TMcASJsOUo/wB8Vx+Qd+DK5MF5vwtu+svjTiiIY=
X-Google-Smtp-Source: AGHT+IFu3uQhXp2Z/aEj1BEH6L1UgC6JN2HUydmAXb/ZyJbKRAX3cbq51nCFz0C4eDlYKRmQl2uEQg==
X-Received: by 2002:a17:90a:fa89:b0:273:ef1b:5a2 with SMTP id
 cu9-20020a17090afa8900b00273ef1b05a2mr208416pjb.47.1696360819194; 
 Tue, 03 Oct 2023 12:20:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w5-20020a170902d3c500b001c5fd2a28d3sm1978497plb.28.2023.10.03.12.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 12:20:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	deller@gmx.de
Subject: [PATCH v5 6/9] linux-user: Simplify signal_init
Date: Tue,  3 Oct 2023 12:20:09 -0700
Message-Id: <20231003192012.1674888-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003192012.1674888-1-richard.henderson@linaro.org>
References: <20231003192012.1674888-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Install the host signal handler at the same time we are
probing the target signals for SIG_IGN/SIG_DFL.  Ignore
unmapped target signals.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 653fd2f9fd..09840b0eb0 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -558,10 +558,7 @@ static void signal_table_init(void)
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
@@ -572,23 +569,28 @@ void signal_init(void)
     sigfillset(&act.sa_mask);
     act.sa_flags = SA_SIGINFO;
     act.sa_sigaction = host_signal_handler;
-    for(i = 1; i <= TARGET_NSIG; i++) {
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


