Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7919F7708CE
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0IQ-0000NJ-73; Fri, 04 Aug 2023 15:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IM-0000Ls-V3; Fri, 04 Aug 2023 15:17:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IL-0006wh-Af; Fri, 04 Aug 2023 15:17:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3020F18459;
 Fri,  4 Aug 2023 22:17:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 90BEC1B89C;
 Fri,  4 Aug 2023 22:16:50 +0300 (MSK)
Received: (nullmailer pid 1875708 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 39/63] target/arm: Special case M-profile in
 debug_helper.c code
Date: Fri,  4 Aug 2023 22:16:22 +0300
Message-Id: <20230804191647.1875608-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

A lot of the code called from helper_exception_bkpt_insn() is written
assuming A-profile, but we will also call this helper on M-profile
CPUs when they execute a BKPT insn.  This used to work by accident,
but recent changes mean that we will hit an assert when some of this
code calls down into lower level functions that end up calling
arm_security_space_below_el3(), arm_el_is_aa64(), and other functions
that now explicitly assert that the guest CPU is not M-profile.

Handle M-profile directly to avoid the assertions:
 * in arm_debug_target_el(), M-profile debug exceptions always
   go to EL1
 * in arm_debug_exception_fsr(), M-profile always uses the short
   format FSR (compare commit d7fe699be54b2, though in this case
   the code in arm_v7m_cpu_do_interrupt() does not need to
   look at the FSR value at all)

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1775
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230721143239.1753066-1-peter.maydell@linaro.org
(cherry picked from commit 5d78893f39caf94c8587141e2219b57a7d63dd5c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index dfc8b2a1a5..0cbc8171d5 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -21,6 +21,10 @@ static int arm_debug_target_el(CPUARMState *env)
     bool secure = arm_is_secure(env);
     bool route_to_el2 = false;
 
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return 1;
+    }
+
     if (arm_is_el2_enabled(env)) {
         route_to_el2 = env->cp15.hcr_el2 & HCR_TGE ||
                        env->cp15.mdcr_el2 & MDCR_TDE;
@@ -434,18 +438,20 @@ static uint32_t arm_debug_exception_fsr(CPUARMState *env)
 {
     ARMMMUFaultInfo fi = { .type = ARMFault_Debug };
     int target_el = arm_debug_target_el(env);
-    bool using_lpae = false;
+    bool using_lpae;
 
-    if (target_el == 2 || arm_el_is_aa64(env, target_el)) {
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        using_lpae = false;
+    } else if (target_el == 2 || arm_el_is_aa64(env, target_el)) {
         using_lpae = true;
     } else if (arm_feature(env, ARM_FEATURE_PMSA) &&
                arm_feature(env, ARM_FEATURE_V8)) {
         using_lpae = true;
+    } else if (arm_feature(env, ARM_FEATURE_LPAE) &&
+               (env->cp15.tcr_el[target_el] & TTBCR_EAE)) {
+        using_lpae = true;
     } else {
-        if (arm_feature(env, ARM_FEATURE_LPAE) &&
-            (env->cp15.tcr_el[target_el] & TTBCR_EAE)) {
-            using_lpae = true;
-        }
+        using_lpae = false;
     }
 
     if (using_lpae) {
-- 
2.39.2


