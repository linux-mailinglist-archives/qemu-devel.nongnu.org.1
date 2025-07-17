Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBA9B08A2E
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 12:03:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLG0-0002sv-7v; Thu, 17 Jul 2025 05:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL0R-0001pX-Ul; Thu, 17 Jul 2025 05:34:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL0P-0001nQ-Sa; Thu, 17 Jul 2025 05:34:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 47049137CE9;
 Thu, 17 Jul 2025 12:34:04 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2B7F62491E3;
 Thu, 17 Jul 2025 12:34:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 41/65] target/arm: Don't enforce NSE,
 NS check for EL3->EL3 returns
Date: Thu, 17 Jul 2025 12:33:37 +0300
Message-ID: <20250717093412.728292-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In the Arm ARM, rule R_TYTWB that defines illegal exception return cases
includes the case:
 If FEAT_RME is implemented, then if SCR_EL3.{NSE, NS} is {1, 0}, an
 exception return from EL3 to a lower Exception level

Our implementation of this check fails to check that the
return is to a lower exception level, so it will incorrectly fire on
EL3->EL3 exception returns.

Fix the check condition. This requires us to move it further
down in the function to a point where we know the new_el value.

Fixes: 35aa6715ddcd9 ("target/arm: Catch illegal-exception-return from EL3 with bad NSE/NS")
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3016
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704165636.261888-1-peter.maydell@linaro.org
(cherry picked from commit c563cd7e61d074f58eef413322144461dd243716)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 9244848efe..be0935d194 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -653,15 +653,6 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         spsr &= ~PSTATE_SS;
     }
 
-    /*
-     * FEAT_RME forbids return from EL3 with an invalid security state.
-     * We don't need an explicit check for FEAT_RME here because we enforce
-     * in scr_write() that you can't set the NSE bit without it.
-     */
-    if (cur_el == 3 && (env->cp15.scr_el3 & (SCR_NS | SCR_NSE)) == SCR_NSE) {
-        goto illegal_return;
-    }
-
     new_el = el_from_spsr(spsr);
     if (new_el == -1) {
         goto illegal_return;
@@ -673,6 +664,17 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         goto illegal_return;
     }
 
+    /*
+     * FEAT_RME forbids return from EL3 to a lower exception level
+     * with an invalid security state.
+     * We don't need an explicit check for FEAT_RME here because we enforce
+     * in scr_write() that you can't set the NSE bit without it.
+     */
+    if (cur_el == 3 && new_el < 3 &&
+        (env->cp15.scr_el3 & (SCR_NS | SCR_NSE)) == SCR_NSE) {
+        goto illegal_return;
+    }
+
     if (new_el != 0 && arm_el_is_aa64(env, new_el) != return_to_aa64) {
         /* Return to an EL which is configured for a different register width */
         goto illegal_return;
-- 
2.47.2


