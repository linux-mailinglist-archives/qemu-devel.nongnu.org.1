Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 594D285EB49
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 22:49:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuSn-0007KI-Rv; Wed, 21 Feb 2024 16:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuSl-0007FK-Jb; Wed, 21 Feb 2024 16:49:11 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuSj-0007bB-DV; Wed, 21 Feb 2024 16:49:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 757D94F872;
 Thu, 22 Feb 2024 00:47:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1ECF3869F3;
 Thu, 22 Feb 2024 00:47:25 +0300 (MSK)
Received: (nullmailer pid 2339890 invoked by uid 1000);
 Wed, 21 Feb 2024 21:47:23 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 22/33] target/arm: Don't get MDCR_EL2 in
 pmu_counter_enabled() before checking ARM_FEATURE_PMU
Date: Thu, 22 Feb 2024 00:47:05 +0300
Message-Id: <20240221214723.2339742-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It doesn't make sense to read the value of MDCR_EL2 on a non-A-profile
CPU, and in fact if you try to do it we will assert:

#6  0x00007ffff4b95e96 in __GI___assert_fail
    (assertion=0x5555565a8c70 "!arm_feature(env, ARM_FEATURE_M)", file=0x5555565a6e5c "../../target/arm/helper.c", line=12600, function=0x5555565a9560 <__PRETTY_FUNCTION__.0> "arm_security_space_below_el3") at ./assert/assert.c:101
#7  0x0000555555ebf412 in arm_security_space_below_el3 (env=0x555557bc8190) at ../../target/arm/helper.c:12600
#8  0x0000555555ea6f89 in arm_is_el2_enabled (env=0x555557bc8190) at ../../target/arm/cpu.h:2595
#9  0x0000555555ea942f in arm_mdcr_el2_eff (env=0x555557bc8190) at ../../target/arm/internals.h:1512

We might call pmu_counter_enabled() on an M-profile CPU (for example
from the migration pre/post hooks in machine.c); this should always
return false because these CPUs don't set ARM_FEATURE_PMU.

Avoid the assertion by not calling arm_mdcr_el2_eff() before we
have done the early return for "PMU not present".

This fixes an assertion failure if you try to do a loadvm or
savevm for an M-profile board.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2155
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240208153346.970021-1-peter.maydell@linaro.org
(cherry picked from commit ac1d88e9e7ca0bed83e91e07ce6d0597f10cc77d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 343acfab3a..2e284e048c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1125,13 +1125,21 @@ static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
     bool enabled, prohibited = false, filtered;
     bool secure = arm_is_secure(env);
     int el = arm_current_el(env);
-    uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
-    uint8_t hpmn = mdcr_el2 & MDCR_HPMN;
+    uint64_t mdcr_el2;
+    uint8_t hpmn;
 
+    /*
+     * We might be called for M-profile cores where MDCR_EL2 doesn't
+     * exist and arm_mdcr_el2_eff() will assert, so this early-exit check
+     * must be before we read that value.
+     */
     if (!arm_feature(env, ARM_FEATURE_PMU)) {
         return false;
     }
 
+    mdcr_el2 = arm_mdcr_el2_eff(env);
+    hpmn = mdcr_el2 & MDCR_HPMN;
+
     if (!arm_feature(env, ARM_FEATURE_EL2) ||
             (counter < hpmn || counter == 31)) {
         e = env->cp15.c9_pmcr & PMCRE;
-- 
2.39.2


