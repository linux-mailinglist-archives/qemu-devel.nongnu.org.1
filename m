Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C257B71AA
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:22:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkwl-0004qu-IF; Tue, 03 Oct 2023 15:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwi-0004qY-Ek
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwT-0004eP-SU
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:40 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c760b34d25so9924595ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696360822; x=1696965622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1E71x8AOuJqRUKKSfRCBk7J7r5yvF1NZG8wQysx060w=;
 b=bTaY7M1IZio59YDb9lQ1LY2aWuQtcJFOpjPbqB4xE91rORLXP+5zC63K43ZyrMH3ai
 Xc0DHz5hVxHPnfTLRXS6qzxsvajTYkNZfr4LSPZgSUV7SA4TTsWWPiBFt2L4bhLEzVt4
 IUobM8beRAPxKRiPE3QLBNaHhMiTfG5NKsnUT/JLpgMrD1N/0F2M3esvXxQAUUGI34Vo
 xpUZIyALjlVZX+EUMx3g7o4lj6Rzvcdn89UDT7x5vB6TRXm/erBuiF+bBwmT5HiG/oDi
 gWlTY08wYSTqN8OgmGv/wo35+oN6ne+Q+og4sYHqyqKdRN8kLZ72haeNsNKkIdVOk7y4
 bSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696360822; x=1696965622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1E71x8AOuJqRUKKSfRCBk7J7r5yvF1NZG8wQysx060w=;
 b=k9e5kVHZLHni8gW0YQY2EsdIP9UGd0EH+5m8ZSz+OxM5oRoliFlgZz4l1wbJYBpZoL
 3ZRSN4gUN5HJbxPMauqp4Ys8CU2d6Ac0pXC+CQt4Nm1blL6OPuCZvbJiGNEWf4xvug8R
 HFn+0YpCsN2/awSVllkfcq3DLkhXR4jeoHN5midfdKvXg1y2d0kO1CxqhSFti+qA78e5
 MvFI+LbqlKOwXMvywwTnulEt7SXEyak3EVf2x+STG7KXGHS0/lXPbejrcSECJ301SOIZ
 hyvdJXmNK2ypAuCV4WMadeiY+EKc/+XtciywzC3bYGXwCQB2eGamtcEGcoipByvql/yq
 WwFg==
X-Gm-Message-State: AOJu0YxIA64eDrx7yw9PqjxsWc8w4xzMhezN3Cjq6qzzXlNpqemT7aPa
 GmIot8WkTIRh5S8LziUD5PYim5o2BqNUSXgcBKU=
X-Google-Smtp-Source: AGHT+IEe1HzemXnkmotVP1i4wVnhz5opR30vnHt/7qoBRWHvT5KmYlEJRyjSB+wlvR2/1lDFNhzS9g==
X-Received: by 2002:a17:902:d4cc:b0:1c3:c687:4793 with SMTP id
 o12-20020a170902d4cc00b001c3c6874793mr385252plg.63.1696360822094; 
 Tue, 03 Oct 2023 12:20:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w5-20020a170902d3c500b001c5fd2a28d3sm1978497plb.28.2023.10.03.12.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 12:20:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	deller@gmx.de
Subject: [PATCH v5 9/9] linux-user: Remap guest SIGABRT
Date: Tue,  3 Oct 2023 12:20:12 -0700
Message-Id: <20231003192012.1674888-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003192012.1674888-1-richard.henderson@linaro.org>
References: <20231003192012.1674888-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Distinguish host SIGABRT from guest SIGABRT by mapping
the guest signal onto one of the host RT signals.

This prevents a cycle by which a host assertion failure
is caught and handled by host_signal_handler, queued for
the guest, and then we attempt to continue past the
host abort.  What happens next depends on the host libc,
but is neither good nor helpful.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index b67077f320..b7f4ce3cb9 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -522,8 +522,16 @@ static void signal_table_init(void)
      * multiplexed over a single host signal.
      * Attempts for configure "missing" signals via sigaction will be
      * silently ignored.
+     *
+     * Remap the target SIGABRT, so that we can distinguish host abort
+     * from guest abort.
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
@@ -582,13 +590,21 @@ void signal_init(void)
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
@@ -711,7 +727,12 @@ void dump_core_and_abort(CPUArchState *env, int target_sig)
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


