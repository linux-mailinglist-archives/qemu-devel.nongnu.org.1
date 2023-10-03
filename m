Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC917B71A9
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:22:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkxS-00051q-UX; Tue, 03 Oct 2023 15:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkws-0004ti-4A
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:52 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwT-0004dw-SQ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:49 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-27777174297so877652a91.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696360818; x=1696965618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5UDBGcrrmujtcvRVyuE029O9vjXuHtI35qzP2H7Ibo=;
 b=SCEY5LqOplL3tFiRC/WQJZuEHzkhqCEIT5/+M5GRhNhSJS3jiJrBFlWXPNoNX+F29L
 qOmYhb9nxFGKq6bXmrNyqAPL6YvZ2vnRr/odtIzYtcSfpFDt+fRqF1/0QsqjDY7GCEYs
 7xCqOeEhmrpJDrfhlyi0yiIJWCXJ3/1iHUESYYjyt0wVa9CmvOq0cydJ+Hq3m9adnGP0
 t+ToyjU5MDTaybsRRWpWn+GZOxWRa8aAkGPXHYu9wD7RMqXz9JlzxuohzMk+YE0EqTES
 +JZtSYrh+KDWFazV2ixo8S250wPTwdHNxvJlYtbfylLtCYv3VNiM1Vl6XvS9XaYmk90J
 sjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696360818; x=1696965618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z5UDBGcrrmujtcvRVyuE029O9vjXuHtI35qzP2H7Ibo=;
 b=C2yr5LmK1mQxOyNMg3aGXovLRtng/wyREg1dXLff8LN/qmu7YK3vuHNpOYLfjHP66d
 1L5wwT5Dc/MSS8NmxZ/w2bXQgcBkwv2F5JT/MiWg1fEXKoVz6VkXluZ0ZiptSXrcPZNu
 7kPUyBe+8zC0942qjwFU2q56TL9V6jtlzoLNMBlh7bEuWn5GoUCfsiTKD3Z6Ui5Xr3Pb
 iNvjqj8YyDMoKHGa40F/jitvqyoenvpnpy2EwvKrgJr5mBx0nZR16F0/A8A83P1ka5rK
 q22VHVTjMk91t+FszKyrdCFDMhpdKtxXH1PsyskYRWE91ggJyN2+5ugSlxVFyEtYxsZZ
 jdWQ==
X-Gm-Message-State: AOJu0YyEBgxkTNpGpkK7cgoKBHCtNyXU7zg6jyv3BUrUX8g/do6Zi3X8
 7KfO0MhKIrY8T9VGx4b7122N+3TvAn+oXCVOkbk=
X-Google-Smtp-Source: AGHT+IGEMY1n7Fw3LkY86uhtjKMz5MATe9yndGfE2Lh4hNFq/QUy3Yi6LnbUdZSFBk0hFvKIS+/NPw==
X-Received: by 2002:a17:90a:4f04:b0:274:77df:50d1 with SMTP id
 p4-20020a17090a4f0400b0027477df50d1mr295914pjh.21.1696360818159; 
 Tue, 03 Oct 2023 12:20:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w5-20020a170902d3c500b001c5fd2a28d3sm1978497plb.28.2023.10.03.12.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 12:20:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	deller@gmx.de
Subject: [PATCH v5 5/9] linux-user: Map unsupported signals to an
 out-of-bounds value
Date: Tue,  3 Oct 2023 12:20:08 -0700
Message-Id: <20231003192012.1674888-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003192012.1674888-1-richard.henderson@linaro.org>
References: <20231003192012.1674888-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Do not return a valid signal number in one domain
when given an invalid signal number in the other domain.

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


