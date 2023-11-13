Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D78A7EA1E2
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:33:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ao5-0001YA-Gl; Mon, 13 Nov 2023 12:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anv-0001Tu-GL
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:57 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anm-0000vY-Q9
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:54 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc3216b2a1so34835995ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896764; x=1700501564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=osIK/2PUKxHJZqiG0Ph90IvOHQ+akZXlmSPjI1L4ukk=;
 b=T37hyV8NGOP7lwUmbsGCBTvYiZ8Qd32+fnFeZ1CdUlz9W8fa1dNsv2kUuJce6XuDH6
 ZvvSqHB7dgiyt+PF4+hSBVTKjlQGlj6cJrH8QYiy64lXqQPdZUQs/VpwM+5DeV8Gau9/
 I/kt26IHzqTqKa+uyjX4t/dTkNHT50gUkJEBt3Fj0QpNMk6yen0Mg51HYnz2e4FfVG8I
 gqGSA6YmKh3G7M1ZQFCbKNOcnieZnJOnPUBpVOKcO8wPiHzfoVxE3gAXMUFyfzbs84y/
 Eb+DUBdn3sxjQU4bR8H+SgxYX/4WvcxgK+89UM6s6C+19PBkC4mjzqxMrWvk6McVxCdb
 epsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896764; x=1700501564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=osIK/2PUKxHJZqiG0Ph90IvOHQ+akZXlmSPjI1L4ukk=;
 b=H+zm/dxxoUCZ5fp7dDZfRdriXNvMdSlNjqSFwskJGO8aZS1d9bcwiN02criMhrv7PT
 XiofplmIm2W6uddNUWtu6dKB2dHMa1Y/wQnYl2lQTATjUYlfAW3++iILO5cZ63Arr9oh
 arL9cNDuS8tvbSBt5SnRLWPAk+S8/IGmk8fwwWwubtncAmVLtDs/4YZRHNl4DxCb4lI4
 kBwnHvtP2/ZvFA0IruwgnESry0RUKPoaSzf+aLBJkg3/j848qcWFXyqBHdnLZwyPykB5
 mPXhQbhXmNh0qln6Z1F6lITKpIeaSAIKI4dT+E+swvr/jdlVvqFqeN8wZrGxbejOUd4A
 I9rg==
X-Gm-Message-State: AOJu0Yx+ZqsWBxtwOTnXH+D+wjpG06FfwrJho8b644C7H/NMP8c0rmsz
 aIdZMl3Dpuj0OLtFrvLw1yMu/GHAtmyLbSdpbz4=
X-Google-Smtp-Source: AGHT+IEnXdPIPkCHDKjbqMJT8pV0Bl23lNybLTR9/volZ3v19x22sB+7MUOR0tDtHWiNkIlobLQp2A==
X-Received: by 2002:a17:903:1210:b0:1cc:4fbe:9278 with SMTP id
 l16-20020a170903121000b001cc4fbe9278mr224539plh.50.1699896764376; 
 Mon, 13 Nov 2023 09:32:44 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] target/hppa: Replace MMU_PHYS_IDX with MMU_ABS_IDX,
 MMU_ABS_W_IDX
Date: Mon, 13 Nov 2023 09:32:32 -0800
Message-Id: <20231113173237.48233-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Align the language with pa2.0, separating absolute and physical.
The translation from absolute to physical depends on PSW.W, and
we prefer not to flush between changes, therefore use 2 mmu_idx.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        | 26 +++++++++++++------------
 target/hppa/mem_helper.c | 41 ++++++++++++++++++++--------------------
 target/hppa/translate.c  |  6 +++---
 3 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6c0f104661..bcfed04f7c 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -31,24 +31,25 @@
    basis.  It's probably easier to fall back to a strong memory model.  */
 #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
 
-#define MMU_KERNEL_IDX    7
-#define MMU_KERNEL_P_IDX  8
-#define MMU_PL1_IDX       9
-#define MMU_PL1_P_IDX     10
-#define MMU_PL2_IDX       11
-#define MMU_PL2_P_IDX     12
-#define MMU_USER_IDX      13
-#define MMU_USER_P_IDX    14
-#define MMU_PHYS_IDX      15
+#define MMU_ABS_W_IDX     6
+#define MMU_ABS_IDX       7
+#define MMU_KERNEL_IDX    8
+#define MMU_KERNEL_P_IDX  9
+#define MMU_PL1_IDX       10
+#define MMU_PL1_P_IDX     11
+#define MMU_PL2_IDX       12
+#define MMU_PL2_P_IDX     13
+#define MMU_USER_IDX      14
+#define MMU_USER_P_IDX    15
 
-#define MMU_IDX_MMU_DISABLED(MIDX)  ((MIDX) == MMU_PHYS_IDX)
+#define MMU_IDX_MMU_DISABLED(MIDX)  ((MIDX) < MMU_KERNEL_IDX)
 #define MMU_IDX_TO_PRIV(MIDX)       (((MIDX) - MMU_KERNEL_IDX) / 2)
 #define MMU_IDX_TO_P(MIDX)          (((MIDX) - MMU_KERNEL_IDX) & 1)
 #define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P) + MMU_KERNEL_IDX)
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-/* No need to flush MMU_PHYS_IDX  */
+/* No need to flush MMU_ABS*_IDX  */
 #define HPPA_MMU_FLUSH_MASK                             \
         (1 << MMU_KERNEL_IDX | 1 << MMU_KERNEL_P_IDX |  \
          1 << MMU_PL1_IDX    | 1 << MMU_PL1_P_IDX    |  \
@@ -288,7 +289,8 @@ static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
     if (env->psw & (ifetch ? PSW_C : PSW_D)) {
         return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
     }
-    return MMU_PHYS_IDX;  /* mmu disabled */
+    /* mmu disabled */
+    return env->psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
 #endif
 }
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index af8e86699d..7bc456d4ee 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -53,17 +53,6 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
     return (addr & MAKE_64BIT_MASK(0, 24)) | MAKE_64BIT_MASK(60, 4);
 }
 
-static hwaddr hppa_abs_to_phys(CPUHPPAState *env, vaddr addr)
-{
-    if (!hppa_is_pa20(env)) {
-        return addr;
-    } else if (env->psw & PSW_W) {
-        return hppa_abs_to_phys_pa2_w1(addr);
-    } else {
-        return hppa_abs_to_phys_pa2_w0(addr);
-    }
-}
-
 static HPPATLBEntry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
 {
     IntervalTreeNode *i = interval_tree_iter_first(&env->tlb_root, addr, addr);
@@ -161,9 +150,22 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         *tlb_entry = NULL;
     }
 
-    /* Virtual translation disabled.  Direct map virtual to physical.  */
-    if (mmu_idx == MMU_PHYS_IDX) {
-        phys = addr;
+    /* Virtual translation disabled.  Map absolute to physical.  */
+    if (MMU_IDX_MMU_DISABLED(mmu_idx)) {
+        switch (mmu_idx) {
+        case MMU_ABS_W_IDX:
+            phys = hppa_abs_to_phys_pa2_w1(addr);
+            break;
+        case MMU_ABS_IDX:
+            if (hppa_is_pa20(env)) {
+                phys = hppa_abs_to_phys_pa2_w0(addr);
+            } else {
+                phys = (uint32_t)addr;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
         prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         goto egress;
     }
@@ -261,7 +263,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     }
 
  egress:
-    *pphys = phys = hppa_abs_to_phys(env, phys);
+    *pphys = phys;
     *pprot = prot;
     trace_hppa_tlb_get_physical_address(env, ret, prot, addr, phys);
     return ret;
@@ -271,16 +273,15 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     hwaddr phys;
-    int prot, excp;
+    int prot, excp, mmu_idx;
 
     /* If the (data) mmu is disabled, bypass translation.  */
     /* ??? We really ought to know if the code mmu is disabled too,
        in order to get the correct debugging dumps.  */
-    if (!(cpu->env.psw & PSW_D)) {
-        return hppa_abs_to_phys(&cpu->env, addr);
-    }
+    mmu_idx = (cpu->env.psw & PSW_D ? MMU_KERNEL_IDX :
+               cpu->env.psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX);
 
-    excp = hppa_get_physical_address(&cpu->env, addr, MMU_KERNEL_IDX, 0,
+    excp = hppa_get_physical_address(&cpu->env, addr, mmu_idx, 0,
                                      &phys, &prot, NULL);
 
     /* Since we're translating for debugging, the only error that is a
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 727dd8a829..4a4830c3e3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3172,7 +3172,7 @@ static bool trans_lda(DisasContext *ctx, arg_ldst *a)
     int hold_mmu_idx = ctx->mmu_idx;
 
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-    ctx->mmu_idx = MMU_PHYS_IDX;
+    ctx->mmu_idx = ctx->tb_flags & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
     trans_ld(ctx, a);
     ctx->mmu_idx = hold_mmu_idx;
     return true;
@@ -3183,7 +3183,7 @@ static bool trans_sta(DisasContext *ctx, arg_ldst *a)
     int hold_mmu_idx = ctx->mmu_idx;
 
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-    ctx->mmu_idx = MMU_PHYS_IDX;
+    ctx->mmu_idx = ctx->tb_flags & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
     trans_st(ctx, a);
     ctx->mmu_idx = hold_mmu_idx;
     return true;
@@ -4435,7 +4435,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
     ctx->mmu_idx = (ctx->tb_flags & PSW_D
                     ? PRIV_P_TO_MMU_IDX(ctx->privilege, ctx->tb_flags & PSW_P)
-                    : MMU_PHYS_IDX);
+                    : ctx->tb_flags & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX);
 
     /* Recover the IAOQ values from the GVA + PRIV.  */
     uint64_t cs_base = ctx->base.tb->cs_base;
-- 
2.34.1


