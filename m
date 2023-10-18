Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7F97CEC1D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG13-00046m-MP; Wed, 18 Oct 2023 19:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0x-00044s-2n
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:47 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0v-0000Lp-2x
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:46 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57b5ef5b947so4745129eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671904; x=1698276704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKWfNxY8ZBT24vryvV7tNUff057UO3MB5fEykagaJko=;
 b=UbN7ggD/knFsrh6J2kylQfTclqqk2mpjtFLBZmj3WV70we/mhb/JZ4rT12cHyXVJx/
 SYnV79oHZBXNNsFoYgdIO0px2IEPDXKTnfeTRDyCEvX0xbthXWCtHMG5y9HRZ/yLJPEe
 Q2Y/vLzWhKUbm8GX5G7HG2fKROzHn91wuGZ+MddUFXb33a0EMMfqm2tpGeuG1ccGA8Aa
 xll5YEU6kyQRJlP1VUAcvzylV2NydDC2EWLd68lMXfJq5RW2p7oORo47ErrrW+OaVrMm
 vUY4gpFZJkr7aHdQf0zOEhiQQbFC56wZcPflbuEo4NOvlwyxw+5HJtx5UgFwJO4V/F8D
 xMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671904; x=1698276704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKWfNxY8ZBT24vryvV7tNUff057UO3MB5fEykagaJko=;
 b=eNbZKn4H2WwiWwqqZfUGZW3CkGtjfBPl/f5S8066fk3KHZrSHoA4TX4RtoE1G8eTnQ
 QXEFAfgcRQCSjQGD2U/wHfYtXWsSas+DQfrhoIxQqTlCVqI/YcC0L6Za1Obyx7F+5prg
 xpfMcppQb6JjiTVc9UGWjjmS2e6MO9ihCDTUsFeeh9Hueh1yKyA81qqSwz0QGNF96n9a
 cKdW8Nf0hqp0ebRK8/a4W+SGM0JfCbWgAzARdysvZ3yDJbTxgDvESSIgd2dSE89WZLwP
 o75QcEvO3FWiSQK6wDQD3FbSftMjHyqzHbdiiH22y+0NZuVh3mh7Zs1c66y46HjgTOU5
 Brsw==
X-Gm-Message-State: AOJu0YxABLazEsGwKuOpeWx7uakuLLgAQMg2pcqqG9V5kViS54SQycxZ
 Lhnn+Jvb2gUvb3oaYmFwEHKANHwZBs+knW2MR6o=
X-Google-Smtp-Source: AGHT+IHcIJkYa6B91qw/GdY/qa/2bUqeSZ9CRv/rHVqCXsOpRmSTmdSfjdTkrrscL2C6/VN6wRLdRw==
X-Received: by 2002:a05:6358:3a0e:b0:168:9f53:9d67 with SMTP id
 g14-20020a0563583a0e00b001689f539d67mr493003rwe.20.1697671903722; 
 Wed, 18 Oct 2023 16:31:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 10/14] linux-user: Map unsupported signals to an out-of-bounds
 value
Date: Wed, 18 Oct 2023 16:31:30 -0700
Message-Id: <20231018233134.1594292-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

Do not return a valid signal number in one domain
when given an invalid signal number in the other domain.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 72 ++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index aab05f8eec..653fd2f9fd 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -44,9 +44,8 @@ abi_ulong default_sigreturn;
 abi_ulong default_rt_sigreturn;
 
 /*
- * System includes define _NSIG as SIGRTMAX + 1,
- * but qemu (like the kernel) defines TARGET_NSIG as TARGET_SIGRTMAX
- * and the first signal is SIGHUP defined as 1
+ * System includes define _NSIG as SIGRTMAX + 1, but qemu (like the kernel)
+ * defines TARGET_NSIG as TARGET_SIGRTMAX and the first signal is 1.
  * Signal number 0 is reserved for use as kill(pid, 0), to test whether
  * a process exists without sending it a signal.
  */
@@ -57,7 +56,6 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
 #define MAKE_SIG_ENTRY(sig)     [sig] = TARGET_##sig,
         MAKE_SIGNAL_LIST
 #undef MAKE_SIG_ENTRY
-    /* next signals stay the same */
 };
 
 static uint8_t target_to_host_signal_table[TARGET_NSIG + 1];
@@ -65,18 +63,24 @@ static uint8_t target_to_host_signal_table[TARGET_NSIG + 1];
 /* valid sig is between 1 and _NSIG - 1 */
 int host_to_target_signal(int sig)
 {
-    if (sig < 1 || sig >= _NSIG) {
+    if (sig < 1) {
         return sig;
     }
+    if (sig >= _NSIG) {
+        return TARGET_NSIG + 1;
+    }
     return host_to_target_signal_table[sig];
 }
 
 /* valid sig is between 1 and TARGET_NSIG */
 int target_to_host_signal(int sig)
 {
-    if (sig < 1 || sig > TARGET_NSIG) {
+    if (sig < 1) {
         return sig;
     }
+    if (sig > TARGET_NSIG) {
+        return _NSIG;
+    }
     return target_to_host_signal_table[sig];
 }
 
@@ -507,48 +511,48 @@ static int core_dump_signal(int sig)
 
 static void signal_table_init(void)
 {
-    int host_sig, target_sig, count;
+    int hsig, tsig, count;
 
     /*
      * Signals are supported starting from TARGET_SIGRTMIN and going up
-     * until we run out of host realtime signals.
-     * glibc at least uses only the lower 2 rt signals and probably
-     * nobody's using the upper ones.
-     * it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32)
-     * To fix this properly we need to do manual signal delivery multiplexed
-     * over a single host signal.
+     * until we run out of host realtime signals.  Glibc uses the lower 2
+     * RT signals and (hopefully) nobody uses the upper ones.
+     * This is why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
+     * To fix this properly we would need to do manual signal delivery
+     * multiplexed over a single host signal.
      * Attempts for configure "missing" signals via sigaction will be
      * silently ignored.
      */
-    for (host_sig = SIGRTMIN; host_sig <= SIGRTMAX; host_sig++) {
-        target_sig = host_sig - SIGRTMIN + TARGET_SIGRTMIN;
-        if (target_sig <= TARGET_NSIG) {
-            host_to_target_signal_table[host_sig] = target_sig;
+    for (hsig = SIGRTMIN; hsig <= SIGRTMAX; hsig++) {
+        tsig = hsig - SIGRTMIN + TARGET_SIGRTMIN;
+        if (tsig <= TARGET_NSIG) {
+            host_to_target_signal_table[hsig] = tsig;
         }
     }
 
-    /* generate signal conversion tables */
-    for (target_sig = 1; target_sig <= TARGET_NSIG; target_sig++) {
-        target_to_host_signal_table[target_sig] = _NSIG; /* poison */
-    }
-    for (host_sig = 1; host_sig < _NSIG; host_sig++) {
-        if (host_to_target_signal_table[host_sig] == 0) {
-            host_to_target_signal_table[host_sig] = host_sig;
-        }
-        target_sig = host_to_target_signal_table[host_sig];
-        if (target_sig <= TARGET_NSIG) {
-            target_to_host_signal_table[target_sig] = host_sig;
+    /* Invert the mapping that has already been assigned. */
+    for (hsig = 1; hsig < _NSIG; hsig++) {
+        tsig = host_to_target_signal_table[hsig];
+        if (tsig) {
+            assert(target_to_host_signal_table[tsig] == 0);
+            target_to_host_signal_table[tsig] = hsig;
         }
     }
 
-    if (trace_event_get_state_backends(TRACE_SIGNAL_TABLE_INIT)) {
-        for (target_sig = 1, count = 0; target_sig <= TARGET_NSIG; target_sig++) {
-            if (target_to_host_signal_table[target_sig] == _NSIG) {
-                count++;
-            }
+    /* Map everything else out-of-bounds. */
+    for (hsig = 1; hsig < _NSIG; hsig++) {
+        if (host_to_target_signal_table[hsig] == 0) {
+            host_to_target_signal_table[hsig] = TARGET_NSIG + 1;
         }
-        trace_signal_table_init(count);
     }
+    for (count = 0, tsig = 1; tsig <= TARGET_NSIG; tsig++) {
+        if (target_to_host_signal_table[tsig] == 0) {
+            target_to_host_signal_table[tsig] = _NSIG;
+            count++;
+        }
+    }
+
+    trace_signal_table_init(count);
 }
 
 void signal_init(void)
-- 
2.34.1


