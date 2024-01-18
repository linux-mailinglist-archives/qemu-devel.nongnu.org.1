Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A310831C06
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:09:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU0a-0000GY-Od; Thu, 18 Jan 2024 10:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU01-0008U3-UZ; Thu, 18 Jan 2024 10:08:11 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzz-00087k-EP; Thu, 18 Jan 2024 10:08:09 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d6ff29293dso10376905ad.0; 
 Thu, 18 Jan 2024 07:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590485; x=1706195285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJ1BsA7SC2kFJbLPy81q22d3u2G9b0JVcUuIo1/lqnM=;
 b=BsRIeprBnOif/iDF2AjO8ZjSk2uNe2P6AtAgfaSHzm9JO4t40P5fnXxv8mseeZCcjx
 7rIv5jPNBrvcbp4Yt7hsNuSoF8b1709xdIPEIMpVFTh0/jBeKs3iz432dduMrPLR1rE9
 rjAGJcVEarL6+Ziuan11NIWKUonSS9QF3chXbaAhX78p7VoizOE1QiIXDWgU5LJve29g
 KBa7jb8jBKF1Q881zD/yg64IfdDHPZNZf7noMLTV7cjZDe9gRT0DyLHgNPDEQ3Zqgoub
 Ppum7tIqQo9EtQchgNXGTcQv5RYZdMdbOE467X92qmLdbTbE8Kq6Z5hT0/wKb16faLJo
 +7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590485; x=1706195285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJ1BsA7SC2kFJbLPy81q22d3u2G9b0JVcUuIo1/lqnM=;
 b=GGO6qC/rX+SqG4JfPAmDDzgZ6FJImatB6pu3HqtMj2VkRuUFtobKeWAapkq385X1hl
 Wnd1cuwixcQUZUjP3b9ZCXNiw+OnwsXMwqA/tcfzMoC/s9v0pE/uTXBaMgvJ0PDzOIzR
 RS0VMzxjiQGTrqhHDOp675oDrg0S+4LC7ziKXGcixMeTyo+na8FWgqzaZ7+T7hC+4532
 NI4AHTEy3BzJ/lYMqUD63dH1kSF5gj9R/DAJFyXAVEn1EFEWbw1F9bpC+hOq5hEPIpRC
 4l3L7dz479iqfZVByUDK1a1uRr5gShmBNPkT33OD4Z/Ko1pdUjv02/8brjKbJxzcsyA7
 VjGg==
X-Gm-Message-State: AOJu0YwPImAqUb1+tC7L5xGe0G6oFvk16jo+Wjiz2qtcisDHcVbUK0y2
 DNwH0KBUDbEwKKNFJkGeLrJDh1xVUKZ46TdeyynfSLqsXq1o04HsSzsGXROh
X-Google-Smtp-Source: AGHT+IGI6ikdFJQzmiRR92bQkvF5NpbSt8Y1jLk36Q/Ftyjkuv4dQdWLMwJCXQFGxCUdPn34+k3Zgg==
X-Received: by 2002:a17:902:ff02:b0:1d5:36ea:f63e with SMTP id
 f2-20020a170902ff0200b001d536eaf63emr919735plj.22.1705590485273; 
 Thu, 18 Jan 2024 07:08:05 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 15/26] target/ppc: Add recording of taken branches to BHRB
Date: Fri, 19 Jan 2024 01:06:33 +1000
Message-ID: <20240118150644.177371-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

This commit continues adding support for the Branch History
Rolling Buffer (BHRB) as is provided starting with the P8
processor and continuing with its successors.  This commit
is limited to the recording and filtering of taken branches.

The following changes were made:

  - Enabled functionality on P10 processors only due to
    performance impact seen with P8 and P9 where it is not
    disabled for non problem state branches.
  - Added a BHRB buffer for storing branch instruction and
    target addresses for taken branches
  - Renamed gen_update_cfar to gen_update_branch_history and
    added a 'target' parameter to hold the branch target
    address and 'inst_type' parameter to use for filtering
  - Added TCG code to gen_update_branch_history that stores
    data to the BHRB and updates the BHRB offset.
  - Added BHRB resource initialization and reset functions

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
[npiggin: rebase and minor compile fixes]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h                       | 17 +++++
 target/ppc/power8-pmu.h                |  7 ++
 target/ppc/cpu_init.c                  | 37 +++++++++-
 target/ppc/power8-pmu.c                | 33 +++++++++
 target/ppc/translate.c                 | 97 ++++++++++++++++++++++++--
 target/ppc/translate/branch-impl.c.inc |  2 +-
 6 files changed, 185 insertions(+), 8 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 60dd644cb9..9bda69f779 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -550,6 +550,8 @@ FIELD(MSR, LE, MSR_LE, 1)
                          MMCR2_FC4P0 | MMCR2_FC5P0 | MMCR2_FC6P0)
 
 #define MMCRA_BHRBRD    PPC_BIT(26)         /* BHRB Recording Disable */
+#define MMCRA_IFM_MASK  PPC_BITMASK(32, 33) /* BHRB Instruction Filtering */
+#define MMCRA_IFM_SHIFT PPC_BIT_NR(33)
 
 #define MMCR1_EVT_SIZE 8
 /* extract64() does a right shift before extracting */
@@ -776,6 +778,8 @@ enum {
     POWERPC_FLAG_SMT      = 0x00400000,
     /* Using "LPAR per core" mode  (as opposed to per-thread)                */
     POWERPC_FLAG_SMT_1LPAR = 0x00800000,
+    /* Has BHRB */
+    POWERPC_FLAG_BHRB      = 0x01000000,
 };
 
 /*
@@ -1217,6 +1221,9 @@ struct pnv_tod_tbst {
 #define PPC_CPU_OPCODES_LEN          0x40
 #define PPC_CPU_INDIRECT_OPCODES_LEN 0x20
 
+#define BHRB_MAX_NUM_ENTRIES_LOG2 (5)
+#define BHRB_MAX_NUM_ENTRIES      (1 << BHRB_MAX_NUM_ENTRIES_LOG2)
+
 struct CPUArchState {
     /* Most commonly used resources during translated code execution first */
     target_ulong gpr[32];  /* general purpose registers */
@@ -1313,6 +1320,16 @@ struct CPUArchState {
     int dcache_line_size;
     int icache_line_size;
 
+#ifdef TARGET_PPC64
+    /* Branch History Rolling Buffer (BHRB) resources */
+    target_ulong bhrb_num_entries;
+    target_ulong bhrb_base;
+    target_ulong bhrb_filter;
+    target_ulong bhrb_offset;
+    target_ulong bhrb_offset_mask;
+    uint64_t bhrb[BHRB_MAX_NUM_ENTRIES];
+#endif
+
     /* These resources are used during exception processing */
     /* CPU model definition */
     target_ulong msr_mask;
diff --git a/target/ppc/power8-pmu.h b/target/ppc/power8-pmu.h
index 87fa8c9334..3f79cfc45b 100644
--- a/target/ppc/power8-pmu.h
+++ b/target/ppc/power8-pmu.h
@@ -13,6 +13,13 @@
 #ifndef POWER8_PMU_H
 #define POWER8_PMU_H
 
+#define BHRB_TYPE_NORECORD      0x00
+#define BHRB_TYPE_CALL          0x01
+#define BHRB_TYPE_INDIRECT      0x02
+#define BHRB_TYPE_COND          0x04
+#define BHRB_TYPE_OTHER         0x08
+#define BHRB_TYPE_XL_FORM       0x10
+
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 
 #define PMC_COUNTER_NEGATIVE_VAL 0x80000000UL
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 72e0ac7029..421900cd11 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6110,6 +6110,28 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x8000;
 }
 
+static void bhrb_init_state(CPUPPCState *env, target_long num_entries_log2)
+{
+    if (env->flags & POWERPC_FLAG_BHRB) {
+        if (num_entries_log2 > BHRB_MAX_NUM_ENTRIES_LOG2) {
+            num_entries_log2 = BHRB_MAX_NUM_ENTRIES_LOG2;
+        }
+        env->bhrb_num_entries = 1 << num_entries_log2;
+        env->bhrb_base = (target_long)&env->bhrb[0];
+        env->bhrb_offset_mask = (env->bhrb_num_entries * sizeof(uint64_t)) - 1;
+    }
+}
+
+static void bhrb_reset_state(CPUPPCState *env)
+{
+    if (env->flags & POWERPC_FLAG_BHRB) {
+        env->bhrb_offset = 0;
+        env->bhrb_filter = 0;
+        memset(env->bhrb, 0, sizeof(env->bhrb));
+    }
+}
+
+#define POWER8_BHRB_ENTRIES_LOG2 5
 static void init_proc_POWER8(CPUPPCState *env)
 {
     /* Common Registers */
@@ -6151,6 +6173,8 @@ static void init_proc_POWER8(CPUPPCState *env)
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
+    bhrb_init_state(env, POWER8_BHRB_ENTRIES_LOG2);
+
     /* Allocate hardware IRQ controller */
     init_excp_POWER8(env);
     ppcPOWER7_irq_init(env_archcpu(env));
@@ -6275,6 +6299,7 @@ static struct ppc_radix_page_info POWER9_radix_page_info = {
 };
 #endif /* CONFIG_USER_ONLY */
 
+#define POWER9_BHRB_ENTRIES_LOG2 5
 static void init_proc_POWER9(CPUPPCState *env)
 {
     /* Common Registers */
@@ -6325,6 +6350,8 @@ static void init_proc_POWER9(CPUPPCState *env)
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
+    bhrb_init_state(env, POWER9_BHRB_ENTRIES_LOG2);
+
     /* Allocate hardware IRQ controller */
     init_excp_POWER9(env);
     ppcPOWER9_irq_init(env_archcpu(env));
@@ -6444,7 +6471,8 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
                  POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV |
+                 POWERPC_FLAG_BHRB;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
@@ -6468,6 +6496,7 @@ static struct ppc_radix_page_info POWER10_radix_page_info = {
 };
 #endif /* !CONFIG_USER_ONLY */
 
+#define POWER10_BHRB_ENTRIES_LOG2 5
 static void init_proc_POWER10(CPUPPCState *env)
 {
     /* Common Registers */
@@ -6515,6 +6544,8 @@ static void init_proc_POWER10(CPUPPCState *env)
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
+    bhrb_init_state(env, POWER10_BHRB_ENTRIES_LOG2);
+
     /* Allocate hardware IRQ controller */
     init_excp_POWER10(env);
     ppcPOWER9_irq_init(env_archcpu(env));
@@ -7189,6 +7220,10 @@ static void ppc_cpu_reset_hold(Object *obj)
         }
         env->spr[i] = spr->default_value;
     }
+
+#if defined(TARGET_PPC64)
+    bhrb_reset_state(env);
+#endif
 }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index 6f5d4e1256..db9ee8e96b 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -82,6 +82,37 @@ static void pmu_update_summaries(CPUPPCState *env)
     env->pmc_cyc_cnt = cyc_cnt;
 }
 
+static void hreg_bhrb_filter_update(CPUPPCState *env)
+{
+    target_long ifm;
+
+    if (!(env->spr[SPR_POWER_MMCR0] & MMCR0_PMAE)) {
+        /* disable recording to BHRB */
+        env->bhrb_filter = BHRB_TYPE_NORECORD;
+        return;
+    }
+
+    ifm = (env->spr[SPR_POWER_MMCRA] & MMCRA_IFM_MASK) >> MMCRA_IFM_SHIFT;
+    switch (ifm) {
+    case 0:
+        /* record all branches */
+        env->bhrb_filter = -1;
+        break;
+    case 1:
+        /* only record calls (LK = 1) */
+        env->bhrb_filter = BHRB_TYPE_CALL;
+        break;
+    case 2:
+        /* only record indirect branches */
+        env->bhrb_filter = BHRB_TYPE_INDIRECT;
+        break;
+    case 3:
+        /* only record conditional branches */
+        env->bhrb_filter = BHRB_TYPE_COND;
+        break;
+    }
+}
+
 void pmu_mmcr01a_updated(CPUPPCState *env)
 {
     PowerPCCPU *cpu = env_archcpu(env);
@@ -95,6 +126,8 @@ void pmu_mmcr01a_updated(CPUPPCState *env)
         ppc_set_irq(cpu, PPC_INTERRUPT_PERFM, 0);
     }
 
+    hreg_bhrb_filter_update(env);
+
     /*
      * Should this update overflow timers (if mmcr0 is updated) so they
      * get set in cpu_post_load?
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 033d6f7bad..3ff023fafc 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -181,6 +181,7 @@ struct DisasContext {
 #if defined(TARGET_PPC64)
     bool sf_mode;
     bool has_cfar;
+    bool has_bhrb;
 #endif
     bool fpu_enabled;
     bool altivec_enabled;
@@ -4166,14 +4167,85 @@ static void gen_rvwinkle(DisasContext *ctx)
     gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
+
+static inline TCGv gen_write_bhrb(TCGv base, TCGv offset, TCGv mask, TCGv value)
+{
+    TCGv tmp = tcg_temp_new();
+
+    /* add base and offset to get address of bhrb entry */
+    tcg_gen_add_tl(tmp, base, offset);
+
+    /* store value into bhrb at bhrb_offset */
+    tcg_gen_st_i64(value, (TCGv_ptr)tmp, 0);
+
+    /* add 8 to current bhrb_offset */
+    tcg_gen_addi_tl(offset, offset, 8);
+
+    /* apply offset mask */
+    tcg_gen_and_tl(offset, offset, mask);
+
+    return offset;
+}
 #endif /* #if defined(TARGET_PPC64) */
 
-static inline void gen_update_cfar(DisasContext *ctx, target_ulong nip)
+static inline void gen_update_branch_history(DisasContext *ctx,
+                                             target_ulong nip,
+                                             TCGv target,
+                                             target_long inst_type)
 {
 #if defined(TARGET_PPC64)
+    TCGv base;
+    TCGv tmp;
+    TCGv offset;
+    TCGv mask;
+    TCGLabel *no_update;
+
     if (ctx->has_cfar) {
         tcg_gen_movi_tl(cpu_cfar, nip);
     }
+
+    if (!ctx->has_bhrb ||
+        !ctx->bhrb_enable ||
+        inst_type == BHRB_TYPE_NORECORD) {
+        return;
+    }
+
+    tmp = tcg_temp_new();
+    no_update = gen_new_label();
+
+    /* check for bhrb filtering */
+    tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPUPPCState, bhrb_filter));
+    tcg_gen_andi_tl(tmp, tmp, inst_type);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, 0, no_update);
+
+    base = tcg_temp_new();
+    offset = tcg_temp_new();
+    mask = tcg_temp_new();
+
+    /* load bhrb base address */
+    tcg_gen_ld_tl(base, tcg_env, offsetof(CPUPPCState, bhrb_base));
+
+    /* load current bhrb_offset */
+    tcg_gen_ld_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
+
+    /* load a BHRB offset mask */
+    tcg_gen_ld_tl(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
+
+    offset = gen_write_bhrb(base, offset, mask, tcg_constant_i64(nip));
+
+    /* Also record the target address for XL-Form branches */
+    if (inst_type & BHRB_TYPE_XL_FORM) {
+
+        /* Set the 'T' bit for target entries */
+        tcg_gen_ori_tl(tmp, target, 0x2);
+
+        offset = gen_write_bhrb(base, offset, mask, tmp);
+    }
+
+    /* save updated bhrb_offset for next time */
+    tcg_gen_st_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
+
+    gen_set_label(no_update);
 #endif
 }
 
@@ -4303,8 +4375,10 @@ static void gen_b(DisasContext *ctx)
     }
     if (LK(ctx->opcode)) {
         gen_setlr(ctx, ctx->base.pc_next);
+        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_CALL);
+    } else {
+        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_OTHER);
     }
-    gen_update_cfar(ctx, ctx->cia);
     gen_goto_tb(ctx, 0, target);
     ctx->base.is_jmp = DISAS_NORETURN;
 }
@@ -4319,6 +4393,7 @@ static void gen_bcond(DisasContext *ctx, int type)
     uint32_t bo = BO(ctx->opcode);
     TCGLabel *l1;
     TCGv target;
+    target_long bhrb_type = BHRB_TYPE_OTHER;
 
     if (type == BCOND_LR || type == BCOND_CTR || type == BCOND_TAR) {
         target = tcg_temp_new();
@@ -4329,11 +4404,16 @@ static void gen_bcond(DisasContext *ctx, int type)
         } else {
             tcg_gen_mov_tl(target, cpu_lr);
         }
+        if (!LK(ctx->opcode)) {
+            bhrb_type |= BHRB_TYPE_INDIRECT;
+        }
+        bhrb_type |= BHRB_TYPE_XL_FORM;
     } else {
         target = NULL;
     }
     if (LK(ctx->opcode)) {
         gen_setlr(ctx, ctx->base.pc_next);
+        bhrb_type |= BHRB_TYPE_CALL;
     }
     l1 = gen_new_label();
     if ((bo & 0x4) == 0) {
@@ -4384,6 +4464,7 @@ static void gen_bcond(DisasContext *ctx, int type)
                 tcg_gen_brcondi_tl(TCG_COND_EQ, temp, 0, l1);
             }
         }
+        bhrb_type |= BHRB_TYPE_COND;
     }
     if ((bo & 0x10) == 0) {
         /* Test CR */
@@ -4398,8 +4479,11 @@ static void gen_bcond(DisasContext *ctx, int type)
             tcg_gen_andi_i32(temp, cpu_crf[bi >> 2], mask);
             tcg_gen_brcondi_i32(TCG_COND_NE, temp, 0, l1);
         }
+        bhrb_type |= BHRB_TYPE_COND;
     }
-    gen_update_cfar(ctx, ctx->cia);
+
+    gen_update_branch_history(ctx, ctx->cia, target, bhrb_type);
+
     if (type == BCOND_IM) {
         target_ulong li = (target_long)((int16_t)(BD(ctx->opcode)));
         if (likely(AA(ctx->opcode) == 0)) {
@@ -4515,7 +4599,7 @@ static void gen_rfi(DisasContext *ctx)
     /* Restore CPU state */
     CHK_SV(ctx);
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfi(tcg_env);
     ctx->base.is_jmp = DISAS_EXIT;
 #endif
@@ -4530,7 +4614,7 @@ static void gen_rfid(DisasContext *ctx)
     /* Restore CPU state */
     CHK_SV(ctx);
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfid(tcg_env);
     ctx->base.is_jmp = DISAS_EXIT;
 #endif
@@ -4545,7 +4629,7 @@ static void gen_rfscv(DisasContext *ctx)
     /* Restore CPU state */
     CHK_SV(ctx);
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfscv(tcg_env);
     ctx->base.is_jmp = DISAS_EXIT;
 #endif
@@ -7377,6 +7461,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #if defined(TARGET_PPC64)
     ctx->sf_mode = (hflags >> HFLAGS_64) & 1;
     ctx->has_cfar = !!(env->flags & POWERPC_FLAG_CFAR);
+    ctx->has_bhrb = !!(env->flags & POWERPC_FLAG_BHRB);
 #endif
     ctx->lazy_tlb_flush = env->mmu_model == POWERPC_MMU_32B
         || env->mmu_model & POWERPC_MMU_64;
diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
index fb0fcf30cc..9ade0c659a 100644
--- a/target/ppc/translate/branch-impl.c.inc
+++ b/target/ppc/translate/branch-impl.c.inc
@@ -17,7 +17,7 @@ static bool trans_RFEBB(DisasContext *ctx, arg_XL_s *arg)
     REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
 
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfebb(tcg_env, cpu_gpr[arg->s]);
 
     ctx->base.is_jmp = DISAS_CHAIN;
-- 
2.42.0


