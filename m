Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A1736C49
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:49:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBain-0001Uy-Un; Tue, 20 Jun 2023 08:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBail-0001Sl-MO
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:31 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaii-0001ur-I8
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:31 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51a200fc3eeso6258810a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265067; x=1689857067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufvtDg+SmNGDf9pVWsSClAqyvu8TpfX9hKzFT9IdNIg=;
 b=uvyAKOQPUvaFP3bxonh8UOhPCTLkNYIHN0JFZPeaJ03syFBnhaI06I61h55PmBudL3
 GQhAa9Lohe9fQ41M/cq5geNvRvi9UeKQ1rOq2RVMIRbk+dqbsokVclAGFLV9/KngUjaQ
 AFR0OP9if0pOMgwsBU5ylvFYXjVwP6Ev980iEz/2DJeXirnJfDz4QK327vOMdrorpiYn
 UeKZ8RqqlENUg1Z1SYGUmF4De9ezed9ZfHeWhL+13c8rXGkdlrG+bccnWuO+0dUTu7XZ
 yObJ8/daWJiAeQA2mwBaXRHQVBXtbV7iqaAitfB80S9xmnRwsmVr8rcy/RqImTfkXaVn
 Q3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265067; x=1689857067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufvtDg+SmNGDf9pVWsSClAqyvu8TpfX9hKzFT9IdNIg=;
 b=Oa6WGYMqfGX/SgksxKiWYK/3V8Ewhhz4sF7Ih76aq/0fO/LZOzzcWx7oM3DEBtKJoC
 AuhnH3YfaHcw5z1RQvDBP+E2tIFU69SGTlsij+pmevhSNy7UvnoaI+fWXOBzjetSoU8I
 ABig+QRec0oUSM84zwH401ptBtK4FdfEQRorw2oV+EDwbxB/DV/Hb83BN499Q6fYBbpT
 O42CBH1bhMIhvz7/Qhgq+vD3146PVTnUH85vy6fwCG3V1YHE38XkwllA8iitzu1M9QSb
 7A0G2nL5mrATCZnrQuVRC0yvRvVFaM64+y+F+Tw7h3siYigZOzJLgaL0D8zCL+m/xwLN
 TI8w==
X-Gm-Message-State: AC+VfDy1l5xPwBkNsBV09ck7GJrACVvDxxgm+boB8KPgtkdX2SeuKhBr
 alSrxCQFmASssLsEHTJ9rg7I1eLMIqvRXowFjppAnZYL
X-Google-Smtp-Source: ACHHUZ6PEoFxAPESR+owGN/Vb7IKZf4JIwZmltdlZdqpbH3eOOKt5soju/zoH+B8SyS7l8q0y16Dog==
X-Received: by 2002:a05:6402:1357:b0:51a:40d2:c7b8 with SMTP id
 y23-20020a056402135700b0051a40d2c7b8mr7515856edw.27.1687265067043; 
 Tue, 20 Jun 2023 05:44:27 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 07/20] target/arm: Adjust the order of Phys and Stage2
 ARMMMUIdx
Date: Tue, 20 Jun 2023 14:44:05 +0200
Message-Id: <20230620124418.805717-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x536.google.com
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

It will be helpful to have ARMMMUIdx_Phys_* to be in the same
relative order as ARMSecuritySpace enumerators. This requires
the adjustment to the nstable check. While there, check for being
in secure state rather than rely on clearing the low bit making
no change to non-secure state.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 12 ++++++------
 target/arm/ptw.c | 12 +++++-------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 125e53b83f..b338619775 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2860,18 +2860,18 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_E2        = 6 | ARM_MMU_IDX_A,
     ARMMMUIdx_E3        = 7 | ARM_MMU_IDX_A,
 
-    /* TLBs with 1-1 mapping to the physical address spaces. */
-    ARMMMUIdx_Phys_NS   = 8 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_S    = 9 | ARM_MMU_IDX_A,
-
     /*
      * Used for second stage of an S12 page table walk, or for descriptor
      * loads during first stage of an S1 page table walk.  Note that both
      * are in use simultaneously for SecureEL2: the security state for
      * the S2 ptw is selected by the NS bit from the S1 ptw.
      */
-    ARMMMUIdx_Stage2    = 10 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Stage2_S  = 11 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2_S  = 8 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2    = 9 | ARM_MMU_IDX_A,
+
+    /* TLBs with 1-1 mapping to the physical address spaces. */
+    ARMMMUIdx_Phys_S    = 10 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_NS   = 11 | ARM_MMU_IDX_A,
 
     /*
      * These are not allocated TLBs and are used only for AT system
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 37bcb17a9e..3f3517f70b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1449,16 +1449,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr |= (address >> (stride * (4 - level))) & indexmask;
     descaddr &= ~7ULL;
     nstable = !regime_is_stage2(mmu_idx) && extract32(tableattrs, 4, 1);
-    if (nstable) {
+    if (nstable && ptw->in_secure) {
         /*
          * Stage2_S -> Stage2 or Phys_S -> Phys_NS
-         * Assert that the non-secure idx are even, and relative order.
+         * Assert the relative order of the secure/non-secure indexes.
          */
-        QEMU_BUILD_BUG_ON((ARMMMUIdx_Phys_NS & 1) != 0);
-        QEMU_BUILD_BUG_ON((ARMMMUIdx_Stage2 & 1) != 0);
-        QEMU_BUILD_BUG_ON(ARMMMUIdx_Phys_NS + 1 != ARMMMUIdx_Phys_S);
-        QEMU_BUILD_BUG_ON(ARMMMUIdx_Stage2 + 1 != ARMMMUIdx_Stage2_S);
-        ptw->in_ptw_idx &= ~1;
+        QEMU_BUILD_BUG_ON(ARMMMUIdx_Phys_S + 1 != ARMMMUIdx_Phys_NS);
+        QEMU_BUILD_BUG_ON(ARMMMUIdx_Stage2_S + 1 != ARMMMUIdx_Stage2);
+        ptw->in_ptw_idx += 1;
         ptw->in_secure = false;
     }
     if (!S1_ptw_translate(env, ptw, descaddr, fi)) {
-- 
2.34.1


