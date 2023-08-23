Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDA0784FED
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgEJ-0004xW-Up; Wed, 23 Aug 2023 01:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEG-0004wS-Ie
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:28 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEE-0000t9-0z
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:28 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso34956655ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 22:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692767784; x=1693372584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TV1TciBhkf4DHVRrzToQTqKckAEQKZ4+I2kgg1P7TXM=;
 b=RxAJjeNLloBT6VR1NWFt/G/gTCHKVA7TdGYmAHhP7lrZj8DU9Zyfdl0OYlhi7B2Zaf
 BLSWDgnrQTj5PJDWjz4nKwHLFlXwEV9k4OTUUunW4xWJOChf796NNzOOOOIK8bSsvN2O
 od36PHx0+vVx/72QNxWr7jk0UvBOn3jK3nXRfKzI1JGExjT+Mg1D9FXRuZGFsueqhETD
 sKMOX1kY4+nDABnLPNYRjw77qa6f1+gok170wSeYKBkNUsWQDlXjpwweELgW3LdyB3PW
 dCY1KPaG3ytiD3c17tDjpJ9xeHMHIxXR/vY+U4cJZDCWk9FaB4jiBoneexf0z/2LYBlp
 nrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692767784; x=1693372584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TV1TciBhkf4DHVRrzToQTqKckAEQKZ4+I2kgg1P7TXM=;
 b=k2Q+UVktQIMReu0f6R4IhpKerBOZs4OJ+WTysM1VuS7Fsvt/JNw4yCyXbq3gROLKAB
 Sjet91H16J3VkYfwFceBRlTSIZ2VbXurc7H6RzN6ENRE0MeC/0V0kJd/Zm4qmSt8400x
 ebkTshsJ0ICMvE6xgwat5PYODHUEs3F3q/bANS51PWiFkdYuyws6iz/b2cz0Fpuf0o4y
 AWab5VTTAt62QGMGaw1V5PoKB8zq7eme+ED8QR1x7ozzZFERjzBy5AGefUbajKFPSgED
 obuw8jTBY7WhBrxM7qH+RdzOAQRdMVDTji7qyx7Qst7U9TcWL0VpZhoJKFxAnMrGcKQd
 MItg==
X-Gm-Message-State: AOJu0Yw4st8gcMSpK95wQWot9Ztkcg5M5pSQGLnyC5iLlPthQZS3fhsq
 gMeRDZg93Eos74OHLhLZAqiX/6IVw4WW9IM9uys=
X-Google-Smtp-Source: AGHT+IHh87DunGp0C41L5wcgeASrjmcDluc6P4AZIkHHyVBO6B+teC5ioPDX856Lpe/Ieb9hAUPWYQ==
X-Received: by 2002:a17:903:4cd:b0:1bf:4185:ed1c with SMTP id
 jm13-20020a17090304cd00b001bf4185ed1cmr8172600plb.43.1692767784368; 
 Tue, 22 Aug 2023 22:16:24 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001bf044dc1a6sm9969402plg.39.2023.08.22.22.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 22:16:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v4 06/10] linux-user: Map unsupported signals to an
 out-of-bounds value
Date: Tue, 22 Aug 2023 22:16:11 -0700
Message-Id: <20230823051615.1297706-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823051615.1297706-1-richard.henderson@linaro.org>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 72 ++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 73f40699ad..9d16e3c8c5 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -45,9 +45,8 @@ abi_ulong default_sigreturn;
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
@@ -58,7 +57,6 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
 #define MAKE_SIG_ENTRY(sig)     [sig] = TARGET_##sig,
         MAKE_SIGNAL_LIST
 #undef MAKE_SIG_ENTRY
-    /* next signals stay the same */
 };
 
 static uint8_t target_to_host_signal_table[TARGET_NSIG + 1];
@@ -66,18 +64,24 @@ static uint8_t target_to_host_signal_table[TARGET_NSIG + 1];
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
 
@@ -508,48 +512,48 @@ static int core_dump_signal(int sig)
 
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


