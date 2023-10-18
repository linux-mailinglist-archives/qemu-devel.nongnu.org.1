Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 126197CEC12
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG12-00046k-W9; Wed, 18 Oct 2023 19:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0x-00045t-Hs
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:47 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0v-0000M3-T7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:47 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57b5f0d658dso4313547eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671904; x=1698276704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypG+ldHB73o41Fm0bO8P6h70i3rbf+HtP65cG8LvxlI=;
 b=pzG5zr46atE5QdTXGfnCBd4stxYeKsXYGtFMl7A8ZcxYviExjTX8HwCKlrFZHyy1AM
 An25RFjTnbph3IrIkomaYHFjIFBLDrFrRDnCJmQb+rhOaRfAG2yGiUnFTLwHx9NVDx9s
 EoB7PfHaWcjHHnK9s4CZlMKy4pG/PuzFKf7jvvQ6GRW9RURkJrRea7r/z8YLj/zDrHfs
 b9tOuklMN80IlPKTM20/138fG0qWP+hPBJmwIxbFGIrUHdhp9WkqK77vxhi+aDYVWoye
 iGKhNCGA3J31YZ11rRDVnuig1pTIVw4g9fatPC+yz0KYtuDr4EWfj4+neApcpjPIf+ny
 /KiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671904; x=1698276704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypG+ldHB73o41Fm0bO8P6h70i3rbf+HtP65cG8LvxlI=;
 b=huRgmOl8U2DpvKbr2rksGBYlDU7rfvZZbMf8k0d0BKkwlQy0bF3rqK2yWNQMhYWjBR
 Xz4F5+ZmCc7LOmJR55ChtWw6i1XArRt6lIh5TzpFHaIoK53BcpJ02g6ob6KchThOgyzG
 eetAHwmZitSi1CwVWOo3lqSOG8WHo84O3D6Fn8w6O/jRWkup0Ro1CMBgGDnMqKw/ZMVE
 5fXYO8F7jDqA+dUsNsnX4SgDexsiolpAD2JoxaAYd4snpXb/jUhkp4+3fsh7lpA5kT6d
 ctCUAZsllQKXwCg2wWbeIr26KPTQGep8UVUBU/+bX2Ef1REQpVVUVU+3xOKPfnWCEKxp
 D6EQ==
X-Gm-Message-State: AOJu0YybdRJc/AhjxsuCsq257HTv9kIrtt0ypECm9QTlynrqQmKihRUw
 CHZfLgABzLE9RsOZPZLSaYTd+2xIhgbZg724qPI=
X-Google-Smtp-Source: AGHT+IEl7mPttHERM78ISqrmIPoyBEJmmolLhmHzT1Ds/3Lfh5w/nRCnvrcIltrcev3e/AAjp+c0Zw==
X-Received: by 2002:a05:6358:ca6:b0:143:8084:e625 with SMTP id
 o38-20020a0563580ca600b001438084e625mr514122rwj.11.1697671904636; 
 Wed, 18 Oct 2023 16:31:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 11/14] linux-user: Simplify signal_init
Date: Wed, 18 Oct 2023 16:31:31 -0700
Message-Id: <20231018233134.1594292-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

Acked-by: Helge Deller <deller@gmx.de>
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


