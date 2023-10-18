Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B147CEC13
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG1J-0004Ho-JB; Wed, 18 Oct 2023 19:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG10-00046n-7s
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:51 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0y-0000Md-2O
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:49 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-57be3d8e738so4161992eaf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671907; x=1698276707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnu9T106+3Frnuh9qTylVBrRrlFzWm5MBIT4IbQZiD0=;
 b=bGdIuMhRHz4aRB7J3gowVA8JKknhwObHJvk3PnhzNtSGbGG7KzLc24hvke0P4pAf2k
 3cLfROlbtFfXJiFZ2LG7FRYnrUlWOsknkN7CMnJMsaSfBj04gWiafeC/PqrQK/dLLdX/
 LmeI6EEyt5KAi4IoeeFcDK9LXt7cs0d3L6p15IIO2QTrB5qT/sjT0xNsH7RiaY8jdtLv
 FkxDlY3r10F5EqU9Z8rf5GN7NVblkswi8bWySeI5PICer5wcy14UDW7nD4cB95JwnlCb
 P7MxmQf4+t5tqoSoOPgApiOXIbJqOJqHFdAqmx3QFeWRITPQX/BkDQztzudH4M/tBEUS
 95tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671907; x=1698276707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bnu9T106+3Frnuh9qTylVBrRrlFzWm5MBIT4IbQZiD0=;
 b=D+AE1z0xAHzpjnIl5F8eJJEpbTQiA/spqhqbZu3xyumHJ/xy4kUycJTCYysc46D6U1
 tylO24+G8NL8E8dqSbverXBxyKVa3VccGxWtacaZukJyUMxIEt3bemPO5Y479ESif3X8
 m2f58vpzMEzRjdP6z305JPFXTegmmP5xVlUe+OwwqSbLw3lk6leRd/fkooS+F0ATXQmJ
 jouhEkftdqNFMfSL3dp/1+Oe8ESegWK9yaEOxakKQ19Jb/eUPCRkf/cKBTOtBne3BGJK
 2gvD3OSap6J/iAm1/bB/tDDv2ur/ScbmN0wduNEcbbipadowSKslVuH8BQCc2l1yCLzM
 Sgow==
X-Gm-Message-State: AOJu0Yw6NuexBVOV8U6EDNVyRqaE3HaDKTded6aHLmJZyso5YVXSlcjR
 cJVXrxLDwnCVCsHtzZSUM90WnVf/3MbCNCCGBZY=
X-Google-Smtp-Source: AGHT+IGHGeg/Thp/MvOBWr47nlNt2wd1PoccI1xeNEuUJCZpfAB/CqMIrIui43oupOxyxJ2uSoktGg==
X-Received: by 2002:a05:6359:5e18:b0:164:8d78:258a with SMTP id
 pw24-20020a0563595e1800b001648d78258amr419570rwb.20.1697671906794; 
 Wed, 18 Oct 2023 16:31:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 14/14] linux-user: Remap guest SIGABRT
Date: Wed, 18 Oct 2023 16:31:34 -0700
Message-Id: <20231018233134.1594292-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

Distinguish host SIGABRT from guest SIGABRT by mapping
the guest signal onto one of the host RT signals.

This prevents a cycle by which a host assertion failure
is caught and handled by host_signal_handler, queued for
the guest, and then we attempt to continue past the
host abort.  What happens next depends on the host libc,
but is neither good nor helpful.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index b67077f320..3b8efec89f 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -522,8 +522,21 @@ static void signal_table_init(void)
      * multiplexed over a single host signal.
      * Attempts for configure "missing" signals via sigaction will be
      * silently ignored.
+     *
+     * Remap the target SIGABRT, so that we can distinguish host abort
+     * from guest abort.  When the guest registers a signal handler or
+     * calls raise(SIGABRT), the host will raise SIG_RTn.  If the guest
+     * arrives at dump_core_and_abort(), we will map back to host SIGABRT
+     * so that the parent (native or emulated) sees the correct signal.
+     * Finally, also map host to guest SIGABRT so that the emulated
+     * parent sees the correct mapping from wait status.
      */
-    for (hsig = SIGRTMIN; hsig <= SIGRTMAX; hsig++) {
+
+    hsig = SIGRTMIN;
+    host_to_target_signal_table[SIGABRT] = 0;
+    host_to_target_signal_table[hsig++] = TARGET_SIGABRT;
+
+    for (; hsig <= SIGRTMAX; hsig++) {
         tsig = hsig - SIGRTMIN + TARGET_SIGRTMIN;
         if (tsig <= TARGET_NSIG) {
             host_to_target_signal_table[hsig] = tsig;
@@ -539,6 +552,8 @@ static void signal_table_init(void)
         }
     }
 
+    host_to_target_signal_table[SIGABRT] = TARGET_SIGABRT;
+
     /* Map everything else out-of-bounds. */
     for (hsig = 1; hsig < _NSIG; hsig++) {
         if (host_to_target_signal_table[hsig] == 0) {
@@ -582,13 +597,21 @@ void signal_init(void)
         int hsig = target_to_host_signal(tsig);
         abi_ptr thand = TARGET_SIG_IGN;
 
-        if (hsig < _NSIG) {
-            struct sigaction *iact = core_dump_signal(tsig) ? &act : NULL;
+        if (hsig >= _NSIG) {
+            continue;
+        }
 
+        /* As we force remap SIGABRT, cannot probe and install in one step. */
+        if (tsig == TARGET_SIGABRT) {
+            sigaction(SIGABRT, NULL, &oact);
+            sigaction(hsig, &act, NULL);
+        } else {
+            struct sigaction *iact = core_dump_signal(tsig) ? &act : NULL;
             sigaction(hsig, iact, &oact);
-            if (oact.sa_sigaction != (void *)SIG_IGN) {
-                thand = TARGET_SIG_DFL;
-            }
+        }
+
+        if (oact.sa_sigaction != (void *)SIG_IGN) {
+            thand = TARGET_SIG_DFL;
         }
         sigact_table[tsig - 1]._sa_handler = thand;
     }
@@ -711,7 +734,12 @@ void dump_core_and_abort(CPUArchState *env, int target_sig)
     TaskState *ts = (TaskState *)cpu->opaque;
     int host_sig, core_dumped = 0;
 
-    host_sig = target_to_host_signal(target_sig);
+    /* On exit, undo the remapping of SIGABRT. */
+    if (target_sig == TARGET_SIGABRT) {
+        host_sig = SIGABRT;
+    } else {
+        host_sig = target_to_host_signal(target_sig);
+    }
     trace_user_dump_core_and_abort(env, target_sig, host_sig);
     gdb_signalled(env, target_sig);
 
-- 
2.34.1


