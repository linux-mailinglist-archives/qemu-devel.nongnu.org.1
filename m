Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07770723E43
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:50:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIy-0007ox-QO; Tue, 06 Jun 2023 05:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIr-0007lo-Gj
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIn-0004iN-7w
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6ef9a928fso49125665e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044912; x=1688636912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KUQNbG4swhx/GDpqUgdeCQb+xuMbYrszsJLTklcQoZk=;
 b=oGZoixJtkncbs8sq2q6gSwdXcjK/+hquIElIwN8T1kx0tAfSMePvZi+/kHfRJE0fXv
 WqK0C5wEh/X8Chj50nlk4EMQdFZbfO7W9YRWUdZ1sQjEdqpX4/LqC1MGYXj/asmfiwgi
 mxZA8mv718xx4f4Qk8dMNCiVWSy8kzsKueeLCkfur3n6DhxIHR2Tj8/QX8cqnS0kVhaV
 Agq2+af7RePTWoQNcfdHt2mQmua+dg/mW53i249KTb7t1AEDb6BYa5n1dWp4bmAZfG0e
 v0wrwSYPjoIL2rez2Ad9L0YajYg3KKvOHVc83Y0ygtPjTTyOUSDWb5IZ+rsFX7rJ/JAQ
 MeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044912; x=1688636912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUQNbG4swhx/GDpqUgdeCQb+xuMbYrszsJLTklcQoZk=;
 b=eW+8HSW/QVi7q5cZ5lFn1U28P905vj7WdQrPCSW7Dkd0QAsIamg7+9WUfKNnwpiP7A
 wqda8xCH5vfRRjfnXiH7KM7hzX+v9yCfwEcvMrbcuuBz2IFBf/pl1kN+w720SXeKlV/l
 GgIXHnffZgwH91ATKtqbLj6V9ft4sSOHvF4jFGFlbF3AbZr7fqITqcTung/avWGsEwL6
 9qGkKvKSwAcn+LZ5+skQy1XhOsxAKdSHXdxcLhw9gi3n/MPpuWm+RMbrjPdEHjEWnu0K
 pLnimirwKfOt3WmT5dwrxYqHGcoQxAt/Mg22megGOquI3h2W5QDl+LbbdzRPU2BLpDsw
 MC9g==
X-Gm-Message-State: AC+VfDx7Z5H5n88OzWnojuTAQYly7vZWKj3DUgV8QMyd9ZPwjumpvYZ5
 OB1z9Q6Y/TUE157JecuDxfix+XP3l6cO34pAtTo=
X-Google-Smtp-Source: ACHHUZ71cXQFcAA+SrBC3Va2Jt5Q69fvFIdiwVjQ8PuG7Q4pj+58QDelkuVI3Kk4Z7ZrdKgWbunkSA==
X-Received: by 2002:a7b:c30e:0:b0:3f7:e7a3:4a1c with SMTP id
 k14-20020a7bc30e000000b003f7e7a34a1cmr1481779wmj.31.1686044912495; 
 Tue, 06 Jun 2023 02:48:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/42] target/arm: Add SCTLR.nAA to TBFLAG_A64
Date: Tue,  6 Jun 2023 10:48:06 +0100
Message-Id: <20230606094814.3581397-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               | 3 ++-
 target/arm/tcg/translate.h     | 2 ++
 target/arm/tcg/hflags.c        | 6 ++++++
 target/arm/tcg/translate-a64.c | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c1db26b2998..36c608f0e6e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1248,7 +1248,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_D       (1U << 5) /* up to v5; RAO in v6 */
 #define SCTLR_CP15BEN (1U << 5) /* v7 onward */
 #define SCTLR_L       (1U << 6) /* up to v5; RAO in v6 and v7; RAZ in v8 */
-#define SCTLR_nAA     (1U << 6) /* when v8.4-LSE is implemented */
+#define SCTLR_nAA     (1U << 6) /* when FEAT_LSE2 is implemented */
 #define SCTLR_B       (1U << 7) /* up to v6; RAZ in v7 */
 #define SCTLR_ITD     (1U << 7) /* v8 onward */
 #define SCTLR_S       (1U << 8) /* up to v6; RAZ in v7 */
@@ -3044,6 +3044,7 @@ FIELD(TBFLAG_A64, SVL, 24, 4)
 /* Indicates that SME Streaming mode is active, and SMCR_ELx.FA64 is not. */
 FIELD(TBFLAG_A64, SME_TRAP_NONSTREAMING, 28, 1)
 FIELD(TBFLAG_A64, FGT_ERET, 29, 1)
+FIELD(TBFLAG_A64, NAA, 30, 1)
 
 /*
  * Helpers for using the above.
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3aa486a1ab6..d1cacff0b2f 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -142,6 +142,8 @@ typedef struct DisasContext {
     bool fgt_eret;
     /* True if fine-grained trap on SVC is enabled */
     bool fgt_svc;
+    /* True if FEAT_LSE2 SCTLR_ELx.nAA is set */
+    bool naa;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index b2ccd77cffc..616c5fa7237 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -248,6 +248,12 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    if (cpu_isar_feature(aa64_lse2, env_archcpu(env))) {
+        if (sctlr & SCTLR_nAA) {
+            DP_TBFLAG_A64(flags, NAA, 1);
+        }
+    }
+
     /* Compute the condition for using AccType_UNPRIV for LDTR et al. */
     if (!(env->pstate & PSTATE_UAO)) {
         switch (mmu_idx) {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 77073a9c1d8..91d28f86620 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -14151,6 +14151,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
+    dc->naa = EX_TBFLAG_A64(tb_flags, NAA);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.34.1


