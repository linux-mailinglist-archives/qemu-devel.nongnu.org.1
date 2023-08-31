Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1192778EABA
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:46:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBD-0003YP-2e; Thu, 31 Aug 2023 06:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB1-0003Ix-9g
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:27 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfAx-00042L-Hm
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4013454fa93so6502225e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478721; x=1694083521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sqDepVXoZwHSwJpS9MMP5oFVXnn43HF4tsSvcENoNxg=;
 b=K6r3kOp4eX2o2hYhCczl6gW/zCKFr4/mi7dO2ngBYv98X9t4JDsqeDaFsYKivYSZ6h
 bHIQo2/pUKS1Uc1HIbcTluRe05erWe0mzguuvKmSS+cpvGMtpoqlPL/nAshZqd5/JmCc
 FkwGy5AL9F1uKHc1HphZf2HjAbtWg9xoYHsvRqQ9bqX1D3Hv1jJI2HEabpokT6gNRBAa
 zuXlYqcWWQOtfXO1LcrwFUqsuElwpDIMIDpt0ggLn+APwNWw/VvwuU2N7vdpGXROKmeJ
 0SJhuYxhsFILpcgd68mNKWEwVBecZ7/8mYH2Y5hQntTkjTiF7TVM9EYL5yUBS7QmVKDT
 Y6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478721; x=1694083521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqDepVXoZwHSwJpS9MMP5oFVXnn43HF4tsSvcENoNxg=;
 b=lBDpUQohX7pB8WKQGWseUTdgvZ0vZEYXmPIIJ4k1iDoRc5zw2j1KOhYoOrYjUnmpp7
 7pwYIa/AeuE00u7bn2fNjmpTtlJT6VJtmRB/IXMslcKAokjugTYstDloT/k6+25WDU7o
 6211UwYfoxiNmTe/b056JQFI350XYT57mdy/f8OCidOfqlgViRM75rnxacIYrk9uh8F8
 KyU7UPadXmDXbF+l5yWQM3sz4u+e58+SjwyjVxcWbSjEIqsbwVRsI/aS6J5ozua9Qx0Y
 q2jf21Sc5ohnYus1BXfIk2/SSmE4LCM36cv1kgxbHi+46vwpBPV8i80spPezwHqszoKn
 Gs5Q==
X-Gm-Message-State: AOJu0YyPtRPj4ZDDcbMJ6qR4f2PRkYQLNOphRsfCLzBpmqRTqoZXaAYh
 vZpIK16FUn8cdNFUryeOgCyaM9fzMTVIX2OZ8u8=
X-Google-Smtp-Source: AGHT+IFk1rINzeKxubee+yLU5yqDsVOJbIFBeaJq+r9MG8F727EucCM+foYdF4eFmyYqJttcsu0IKQ==
X-Received: by 2002:a05:600c:2294:b0:401:bdf9:c336 with SMTP id
 20-20020a05600c229400b00401bdf9c336mr3995613wmf.27.1693478721367; 
 Thu, 31 Aug 2023 03:45:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/24] target/arm: Allow cpu to configure GM blocksize
Date: Thu, 31 Aug 2023 11:44:57 +0100
Message-Id: <20230831104519.3520658-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Previously we hard-coded the blocksize with GMID_EL1_BS.
But the value we choose for -cpu max does not match the
value that cortex-a710 uses.

Mirror the way we handle dcz_blocksize.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230811214031.171020-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  2 ++
 target/arm/internals.h         |  6 -----
 target/arm/tcg/translate.h     |  2 ++
 target/arm/helper.c            | 11 +++++---
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/mte_helper.c    | 46 ++++++++++++++++++++++------------
 target/arm/tcg/translate-a64.c |  5 ++--
 7 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a1e604366b2..278cc135c23 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1075,6 +1075,8 @@ struct ArchCPU {
 
     /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
     uint8_t dcz_blocksize;
+    /* GM blocksize, in log_2(words), ie low 4 bits of GMID_EL0 */
+    uint8_t gm_blocksize;
 
     uint64_t rvbar_prop; /* Property/input signals.  */
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index cf13bb94f59..5f5393b25c4 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1246,12 +1246,6 @@ void arm_log_exception(CPUState *cs);
 
 #endif /* !CONFIG_USER_ONLY */
 
-/*
- * The log2 of the words in the tag block, for GMID_EL1.BS.
- * The is the maximum, 256 bytes, which manipulates 64-bits of tags.
- */
-#define GMID_EL1_BS  6
-
 /*
  * SVE predicates are 1/8 the size of SVE vectors, and cannot use
  * the same simd_desc() encoding due to restrictions on size.
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index d1cacff0b2f..f748ba6f394 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -151,6 +151,8 @@ typedef struct DisasContext {
     int8_t btype;
     /* A copy of cpu->dcz_blocksize. */
     uint8_t dcz_blocksize;
+    /* A copy of cpu->gm_blocksize. */
+    uint8_t gm_blocksize;
     /* True if this page is guarded.  */
     bool guarded_page;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 85291d5b8e2..4dfc51de351 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7748,10 +7748,6 @@ static const ARMCPRegInfo mte_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 6,
       .access = PL1_RW, .accessfn = access_mte,
       .fieldoffset = offsetof(CPUARMState, cp15.gcr_el1) },
-    { .name = "GMID_EL1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 4,
-      .access = PL1_R, .accessfn = access_aa64_tid5,
-      .type = ARM_CP_CONST, .resetvalue = GMID_EL1_BS },
     { .name = "TCO", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 4, .crm = 2, .opc2 = 7,
       .type = ARM_CP_NO_RAW,
@@ -9342,6 +9338,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
      * then define only a RAZ/WI version of PSTATE.TCO.
      */
     if (cpu_isar_feature(aa64_mte, cpu)) {
+        ARMCPRegInfo gmid_reginfo = {
+            .name = "GMID_EL1", .state = ARM_CP_STATE_AA64,
+            .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 4,
+            .access = PL1_R, .accessfn = access_aa64_tid5,
+            .type = ARM_CP_CONST, .resetvalue = cpu->gm_blocksize,
+        };
+        define_one_arm_cp_reg(cpu, &gmid_reginfo);
         define_arm_cp_regs(cpu, mte_reginfo);
         define_arm_cp_regs(cpu, mte_el0_cacheop_reginfo);
     } else if (cpu_isar_feature(aa64_mte_insn_reg, cpu)) {
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8019f00bc3f..4cd73779c80 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -868,6 +868,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
     cpu->dcz_blocksize = 7; /*  512 bytes */
 #endif
+    cpu->gm_blocksize = 6;  /*  256 bytes */
 
     cpu->sve_vq.supported = MAKE_64BIT_MASK(0, ARM_MAX_VQ);
     cpu->sme_vq.supported = SVE_VQ_POW2_MAP;
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 9c64def0816..3640c6e57f5 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -421,46 +421,54 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
     }
 }
 
-#define LDGM_STGM_SIZE  (4 << GMID_EL1_BS)
-
 uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
 {
     int mmu_idx = cpu_mmu_index(env, false);
     uintptr_t ra = GETPC();
+    int gm_bs = env_archcpu(env)->gm_blocksize;
+    int gm_bs_bytes = 4 << gm_bs;
     void *tag_mem;
 
-    ptr = QEMU_ALIGN_DOWN(ptr, LDGM_STGM_SIZE);
+    ptr = QEMU_ALIGN_DOWN(ptr, gm_bs_bytes);
 
     /* Trap if accessing an invalid page.  */
     tag_mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_LOAD,
-                                 LDGM_STGM_SIZE, MMU_DATA_LOAD,
-                                 LDGM_STGM_SIZE / (2 * TAG_GRANULE), ra);
+                                 gm_bs_bytes, MMU_DATA_LOAD,
+                                 gm_bs_bytes / (2 * TAG_GRANULE), ra);
 
     /* The tag is squashed to zero if the page does not support tags.  */
     if (!tag_mem) {
         return 0;
     }
 
-    QEMU_BUILD_BUG_ON(GMID_EL1_BS != 6);
     /*
-     * We are loading 64-bits worth of tags.  The ordering of elements
-     * within the word corresponds to a 64-bit little-endian operation.
+     * The ordering of elements within the word corresponds to
+     * a little-endian operation.
      */
-    return ldq_le_p(tag_mem);
+    switch (gm_bs) {
+    case 6:
+        /* 256 bytes -> 16 tags -> 64 result bits */
+        return ldq_le_p(tag_mem);
+    default:
+        /* cpu configured with unsupported gm blocksize. */
+        g_assert_not_reached();
+    }
 }
 
 void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
 {
     int mmu_idx = cpu_mmu_index(env, false);
     uintptr_t ra = GETPC();
+    int gm_bs = env_archcpu(env)->gm_blocksize;
+    int gm_bs_bytes = 4 << gm_bs;
     void *tag_mem;
 
-    ptr = QEMU_ALIGN_DOWN(ptr, LDGM_STGM_SIZE);
+    ptr = QEMU_ALIGN_DOWN(ptr, gm_bs_bytes);
 
     /* Trap if accessing an invalid page.  */
     tag_mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE,
-                                 LDGM_STGM_SIZE, MMU_DATA_LOAD,
-                                 LDGM_STGM_SIZE / (2 * TAG_GRANULE), ra);
+                                 gm_bs_bytes, MMU_DATA_LOAD,
+                                 gm_bs_bytes / (2 * TAG_GRANULE), ra);
 
     /*
      * Tag store only happens if the page support tags,
@@ -470,12 +478,18 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
         return;
     }
 
-    QEMU_BUILD_BUG_ON(GMID_EL1_BS != 6);
     /*
-     * We are storing 64-bits worth of tags.  The ordering of elements
-     * within the word corresponds to a 64-bit little-endian operation.
+     * The ordering of elements within the word corresponds to
+     * a little-endian operation.
      */
-    stq_le_p(tag_mem, val);
+    switch (gm_bs) {
+    case 6:
+        stq_le_p(tag_mem, val);
+        break;
+    default:
+        /* cpu configured with unsupported gm blocksize. */
+        g_assert_not_reached();
+    }
 }
 
 void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index da686cc9537..0b77c92437f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3786,7 +3786,7 @@ static bool trans_STGM(DisasContext *s, arg_ldst_tag *a)
         gen_helper_stgm(cpu_env, addr, tcg_rt);
     } else {
         MMUAccessType acc = MMU_DATA_STORE;
-        int size = 4 << GMID_EL1_BS;
+        int size = 4 << s->gm_blocksize;
 
         clean_addr = clean_data_tbi(s, addr);
         tcg_gen_andi_i64(clean_addr, clean_addr, -size);
@@ -3818,7 +3818,7 @@ static bool trans_LDGM(DisasContext *s, arg_ldst_tag *a)
         gen_helper_ldgm(tcg_rt, cpu_env, addr);
     } else {
         MMUAccessType acc = MMU_DATA_LOAD;
-        int size = 4 << GMID_EL1_BS;
+        int size = 4 << s->gm_blocksize;
 
         clean_addr = clean_data_tbi(s, addr);
         tcg_gen_andi_i64(clean_addr, clean_addr, -size);
@@ -13896,6 +13896,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->cp_regs = arm_cpu->cp_regs;
     dc->features = env->features;
     dc->dcz_blocksize = arm_cpu->dcz_blocksize;
+    dc->gm_blocksize = arm_cpu->gm_blocksize;
 
 #ifdef CONFIG_USER_ONLY
     /* In sve_probe_page, we assume TBI is enabled. */
-- 
2.34.1


