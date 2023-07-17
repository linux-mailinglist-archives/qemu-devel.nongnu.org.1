Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE875638D
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNhd-0002xG-TJ; Mon, 17 Jul 2023 08:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNds-0008TF-6P
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdn-0008TM-82
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82d9cso40105105e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689598070; x=1692190070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6/kWyXsyxk23z+UX5RxhswptfdLynFYZwEMDMUpOvjE=;
 b=mxmdPB+Lwjmn3PTO103yjoXDjQgyeXU5CNsa/O6mOrPMRtn1b2EKu99lMq2aUzNb0i
 tJMDDY5NGujTQg/leKz3IzNPjPQsOxTncE+u1iWA3yVgLD4rh9uzxq18I+2gDuvlNTu1
 UPmHmYpPDAGcvdZXvednZc08mLjJNSC/+i20m4wwYj9dvoud46ksnzrtYfL6+UkjyJTC
 ybY4zMDyrE1ikkXkMisI8ZHiznFasTh0FSXVMHcDCCEXZzfZBOfvwxFb5c8/ew9/3gPr
 Y0ULCFEKILGR/S59t7e5yiL4WC+B+oZni6DKjBxr9SuB8HBaInOVM6P7LRYmPN/nVxkm
 8pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689598070; x=1692190070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6/kWyXsyxk23z+UX5RxhswptfdLynFYZwEMDMUpOvjE=;
 b=YqHdsiQKZoClMQUI86wHCzGMPBcZZp/rQd1brIQD5BTlzMHyPOzDYO9OISAwZU9A3F
 jshPkvvU1Ihvyvzwbug2IixgtXasU7A5dnknbLIuJ0IZixIPzUlNrLTS7e8FKMif1xM+
 h3vhallntq/Jhp95ls4zANKOlSOYpvVP795c39Tm/xugfc0gQI6bqPICvISOKKKnz3Gt
 Vcskm2lFJVlEY1uWXE/caA3uJCGeJjfsJTXn84Kx1M+iiaHyvmof5Aqan2kWVOiPjnDR
 DouDns9yQo3Nypg7ZwiCj3PoEQiaDqeO/nT9yyAHsGEU7B4PoYhdEPohRtbZRKPU/q1c
 su3g==
X-Gm-Message-State: ABy/qLbMhU+36fkhXN5RfKinoKNQMwSCHLjHhNq0RdeG7NFyJHKs2TMd
 y1R/wypqo8e064VfSIDkfFM645xrUFxe3E9Lvgo=
X-Google-Smtp-Source: APBJJlHgNGnXc2GBuofx8vf3MJicP/0QnWdDKmv6BtiToCNF1vxNxnJfk4QVVyZi3KTYhwqAekoEOw==
X-Received: by 2002:adf:f5cd:0:b0:30a:e9cb:1a2e with SMTP id
 k13-20020adff5cd000000b0030ae9cb1a2emr8531637wrp.65.1689598069695; 
 Mon, 17 Jul 2023 05:47:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d6790000000b003112ab916cdsm19337737wru.73.2023.07.17.05.47.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 05:47:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/7] target/arm: Fix S1_ptw_translate() debug path
Date: Mon, 17 Jul 2023 13:47:43 +0100
Message-Id: <20230717124746.759085-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717124746.759085-1-peter.maydell@linaro.org>
References: <20230717124746.759085-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In commit fe4a5472ccd6 we rearranged the logic in S1_ptw_translate()
so that the debug-access "call get_phys_addr_*" codepath is used both
when S1 is doing ptw reads from stage 2 and when it is doing ptw
reads from physical memory.  However, we didn't update the
calculation of s2ptw->in_space and s2ptw->in_secure to account for
the "ptw reads from physical memory" case.  This meant that debug
accesses when in Secure state broke.

Create a new function S2_security_space() which returns the
correct security space to use for the ptw load, and use it to
determine the correct .in_secure and .in_space fields for the
stage 2 lookup for the ptw load.

Reported-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230710152130.3928330-3-peter.maydell@linaro.org
Fixes: fe4a5472ccd6 ("target/arm: Use get_phys_addr_with_struct in S1_ptw_translate")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 21749375f97..c0b9cee5843 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -485,11 +485,39 @@ static bool S2_attrs_are_device(uint64_t hcr, uint8_t attrs)
     }
 }
 
+static ARMSecuritySpace S2_security_space(ARMSecuritySpace s1_space,
+                                          ARMMMUIdx s2_mmu_idx)
+{
+    /*
+     * Return the security space to use for stage 2 when doing
+     * the S1 page table descriptor load.
+     */
+    if (regime_is_stage2(s2_mmu_idx)) {
+        /*
+         * The security space for ptw reads is almost always the same
+         * as that of the security space of the stage 1 translation.
+         * The only exception is when stage 1 is Secure; in that case
+         * the ptw read might be to the Secure or the NonSecure space
+         * (but never Realm or Root), and the s2_mmu_idx tells us which.
+         * Root translations are always single-stage.
+         */
+        if (s1_space == ARMSS_Secure) {
+            return arm_secure_to_space(s2_mmu_idx == ARMMMUIdx_Stage2_S);
+        } else {
+            assert(s2_mmu_idx != ARMMMUIdx_Stage2_S);
+            assert(s1_space != ARMSS_Root);
+            return s1_space;
+        }
+    } else {
+        /* ptw loads are from phys: the mmu idx itself says which space */
+        return arm_phys_to_space(s2_mmu_idx);
+    }
+}
+
 /* Translate a S1 pagetable walk through S2 if needed.  */
 static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
                              hwaddr addr, ARMMMUFaultInfo *fi)
 {
-    ARMSecuritySpace space = ptw->in_space;
     bool is_secure = ptw->in_secure;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
     ARMMMUIdx s2_mmu_idx = ptw->in_ptw_idx;
@@ -502,13 +530,12 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
          * From gdbstub, do not use softmmu so that we don't modify the
          * state of the cpu at all, including softmmu tlb contents.
          */
+        ARMSecuritySpace s2_space = S2_security_space(ptw->in_space, s2_mmu_idx);
         S1Translate s2ptw = {
             .in_mmu_idx = s2_mmu_idx,
             .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
-            .in_secure = s2_mmu_idx == ARMMMUIdx_Stage2_S,
-            .in_space = (s2_mmu_idx == ARMMMUIdx_Stage2_S ? ARMSS_Secure
-                         : space == ARMSS_Realm ? ARMSS_Realm
-                         : ARMSS_NonSecure),
+            .in_secure = arm_space_is_secure(s2_space),
+            .in_space = s2_space,
             .in_debug = true,
         };
         GetPhysAddrResult s2 = { };
-- 
2.34.1


