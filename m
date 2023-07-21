Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EF475CA15
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrBX-0005EJ-JN; Fri, 21 Jul 2023 10:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMrBV-0005Do-H4
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:32:45 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMrBT-00085s-Qk
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:32:45 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3142a9ff6d8so1692626f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689949961; x=1690554761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Eu0+efAdWmcM1kvXZ0gk+7iJlGZwvte0bs6QH7LutQ=;
 b=p+P/js7FdoZ0UlkJmWtnUKM5bZRYeVU7S5ga4C8XqVq0zxS+AMNuM63g//wk+ve+k8
 l0bwSJ/KpOGfGXQWC6Lbal6yUg5Z4EXiHaYnSra6IiX0rCG3VrN6w3K0RMuYj3ialsLH
 ycrelooUaA0C+ieDVW62KHAA7fA9NzFyP/hky/RLhYsfHq+r1AbYkOaH/9hJ5ru4z+fC
 z3ev1ZCRyYWaUAwAGivpXdt8vBjwaQPQXXa37nps8AipfX2DHbnTd+1LwZ4lKr2xHwth
 6AuKb+zhEsQZQogZ/HbOIQ1PX1LJBgbra8StggTUHbjHHh6YDHSf8w/akYwrFMgvcAzF
 WyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689949961; x=1690554761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Eu0+efAdWmcM1kvXZ0gk+7iJlGZwvte0bs6QH7LutQ=;
 b=e7F8GBDazlrY+XjXvFl0XlaPjZ937A/N8OiRZs4hTthXhdbFCA1eYVsJV/IxxsAZiv
 WcNJYbkrp0lWLYvq07tSFLZfCmFrya1xefM/cViK7lDW+5BIjKMMu5ixZY5r9q3mNpQm
 uVMBMmET9llwtLnjdT1X3TvhwAOBuhlXYLk7LBj5vcSCCOcnCxHaOYLj7w3MqNXvR0+X
 U9SQuvn0y6K7ozLSEmxwHVZ3m5AIvoeYLPmNyqaj7rcR9Dl5rf1K7ouT5LTYHrNQuGmM
 1AhKM9zbzgpvUJDYHgaB/bPOiFycURdzfgLzDohBRWnVQn7eODEllo5d9Ls3PSBPCl+d
 N1Ow==
X-Gm-Message-State: ABy/qLZwvuxYz/BBZEca1qc5MIQbywWuR6VsAA9Lnqee2tXLSWtnhUng
 /TWkHr8ujmLcFYi+AxKuQhSS3g==
X-Google-Smtp-Source: APBJJlFlnaPJ2XXjQbKSx703YGsfFpuG1xJ2pZ8YDjlBiv3C1NzBVwlG/V1SJqCKkf5cly6odYHwwg==
X-Received: by 2002:adf:f488:0:b0:315:9fb7:bd9 with SMTP id
 l8-20020adff488000000b003159fb70bd9mr1445146wro.69.1689949961429; 
 Fri, 21 Jul 2023 07:32:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6046000000b003143b14848dsm4304533wrt.102.2023.07.21.07.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 07:32:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-8.1] target/arm: Special case M-profile in debug_helper.c
 code
Date: Fri, 21 Jul 2023 15:32:39 +0100
Message-Id: <20230721143239.1753066-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
Not sure exactly when this assert() got in (probably in the
semi-recent refactorings for realm support), but it won't hurt
to backport the fix even if the older QEMU doesn't assert().
---
 target/arm/debug_helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 8362462a07e..abe72e35ae6 100644
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
2.34.1


