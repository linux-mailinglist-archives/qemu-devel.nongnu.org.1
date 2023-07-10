Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED93E74D9CC
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIshw-0007lo-NJ; Mon, 10 Jul 2023 11:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qIshp-0007k1-Ak
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:21:43 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qIshl-0007vm-EQ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:21:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so43628695e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689002494; x=1691594494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoReB+bQetq/CZ2AVQqn0lg1rDXgEHC6Q4MrGNoc0WQ=;
 b=gBMAMEdpHP9wutF1gcIJjxAd9ElfevzUzq4gffWKmEzs8CDgY5Ar5jvN3kq+Z1gpp4
 xWwOraAfI6GrC3TKYVUvMIVvl0Jnf/g1KkhSgizH1yZlgGFHe0vRLZvkDOGbtIvlYSMw
 DtiDyfYqwzUZAJSpdC83/tWUptg9yDxRapYVYSkfhTESMV5fza5bowSMli4+bfC3CkJS
 mFW8wvGVjoofv4zeTi25rGNmzKuCg1sfGzx2f35sykHt06HLtmPQp3C1tGWwBUglO7HE
 3Kt441w8pIi3iQCvQ1AYE4PBrJVQPL+CbRPNYTv7lptXiqsxnxoNDLJTN2soFWQYhKM0
 pJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689002494; x=1691594494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoReB+bQetq/CZ2AVQqn0lg1rDXgEHC6Q4MrGNoc0WQ=;
 b=RInEdmavUWIx8NFxJ4Ori929zJLRUK5+3VZnrpvoFX2urMH5Sc2kDBSreqW5KaXirV
 /DDq8XMYN1Iroyh44dyPKzW3nd0lCY/EPIeyjJ79qTWq+Kih/TBiKV7/11nJM/xyDhwQ
 Tyuf9vMU0OKE47o5N2Vzycoetdw8MVvZpIHk7fOBp1PVd/c1KawAh9YwgsGuX78XU6PH
 /NYIujc06y8sMGzCTl+tH2/vr9aVfeTaw/LUYsk7HPmEBOs8roWUg/etPoLT2cQovNgc
 eOpWyc//SlEAacGKHp6l9P5ZVjKCXe284JORc+QHxFnY1KFxQLXUFsZt+dAVISmh3DM/
 r8lg==
X-Gm-Message-State: ABy/qLasZmYMkcs5R0rSdhRykqhUy0RJ8immapxu22txFcBMk2rrH3W3
 4HQysPOpBw3We0JPv5FU2wV0yMtm0aAhLbsX+5c=
X-Google-Smtp-Source: APBJJlEvZRskw81zoVQs/pTx0kq6aDzWInHL9tSy7F1TFbAZplw2nmYBJ2m9x4SFCmuQuF61vFRz7A==
X-Received: by 2002:a05:600c:1c1b:b0:3f7:e78e:8a41 with SMTP id
 j27-20020a05600c1c1b00b003f7e78e8a41mr15633383wms.18.1689002493855; 
 Mon, 10 Jul 2023 08:21:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a05600c215800b003fa95f328afsm10578798wml.29.2023.07.10.08.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:21:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-8.1 2/3] target/arm: Fix S1_ptw_translate() debug path
Date: Mon, 10 Jul 2023 16:21:29 +0100
Message-Id: <20230710152130.3928330-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710152130.3928330-1-peter.maydell@linaro.org>
References: <20230710152130.3928330-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

In commit XXX we rearranged the logic in S1_ptw_translate() so that
the debug-access "call get_phys_addr_*" codepath is used both when S1
is doing ptw reads from stage 2 and when it is doing ptw reads from
physical memory.  However, we didn't update the calculation of
s2ptw->in_space and s2ptw->in_secure to account for the "ptw reads
from physical memory" case.  This meant that debug accesses when in
Secure state broke.

Create a new function S2_security_space() which returns the
correct security space to use for the ptw load, and use it to
determine the correct .in_secure and .in_space fields for the
stage 2 lookup for the ptw load.

Reported-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
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


