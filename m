Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 371FCB385B2
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Aug 2025 17:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHgZ-0002Yc-PB; Wed, 27 Aug 2025 11:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHgX-0002Xs-1k; Wed, 27 Aug 2025 11:03:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHgU-0004lw-OP; Wed, 27 Aug 2025 11:03:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7F9A314C52C;
 Wed, 27 Aug 2025 18:02:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6B5D2269834;
 Wed, 27 Aug 2025 18:03:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 04/59] linux-user/aarch64: Clear TPIDR2_EL0 when
 delivering signals
Date: Wed, 27 Aug 2025 18:02:09 +0300
Message-ID: <20250827150323.2694101-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

A recent change to the kernel (Linux commit b376108e1f88
"arm64/fpsimd: signal: Clear TPIDR2 when delivering signals") updated
the signal-handler entry code to always clear TPIDR2_EL0.

This is necessary for the userspace ZA lazy saving scheme to work
correctly when unwinding exceptions across a signal boundary.
(For the essay-length description of the incorrect behaviour and
why this is the correct fix, see the commit message for the
kernel commit.)

Make QEMU also clear TPIDR2_EL0 on signal entry, applying the
equivalent bugfix to our implementation.

Note that getting this unwinding to work correctly also requires
changes to the userspace code, e.g.  as implemented in gcc in
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b5ffc8e75a8

This change is technically an ABI change; from the kernel's
point of view SME was never enabled (it was hidden behind
CONFIG_BROKEN) before the change. From QEMU's point of view
our SME-related signal handling was broken anyway as we weren't
saving and restoring TPIDR2_EL0.

Cc: qemu-stable@nongnu.org
Fixes: 78011586b90d1 ("target/arm: Enable SME for user-only")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250725175510.3864231-2-peter.maydell@linaro.org>
(cherry picked from commit 3cdd990aa920ec8f2994b634f758dab4a86ac167)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index bc7a13800d..df85354adc 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -666,8 +666,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         env->btype = 2;
     }
 
-    /* Invoke the signal handler with both SM and ZA disabled. */
+    /*
+     * Invoke the signal handler with a clean SME state: both SM and ZA
+     * disabled and TPIDR2_EL0 cleared.
+     */
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
+    env->cp15.tpidr2_el0 = 0;
 
     if (info) {
         frame->info = *info;
-- 
2.47.2


