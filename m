Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DAC7D1B21
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:45:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4as-000799-Ui; Sat, 21 Oct 2023 01:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ao-00077C-JZ
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:10 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4am-0008M7-DI
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:10 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-694ed847889so1438853b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866327; x=1698471127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+wpTJ/UmKvrUO2dhPZ2tX5kAAWYozv+5cgy4f/b128=;
 b=H77ow5Z+ihgShvHDl1IBfLcZ6r/0iXk8TdG8LFH20cGJBAiuQk2OwArGJd2gVH5XGq
 cjBOtaO6ULbUGbP1quP62W0ByIpMRzGQjJmD/YpJxwmS+EWt21sJoLLMvHiR24xuWk64
 0JL+jXYgWa6GrUkyzEbrfo3DtlJNnwWeroLGQiuwBgq21ZDfXVwXmI8ngHpQCSuwB+MT
 xDIQrdCkpBPRUQJbIkihbkfvjJznLbc6GKkMIaokC9IkbykBgdRHMVlWJqqAc/oXonU/
 fapWj9Y2Rw8emTvBvJW3P7wRJNXZHCsBmcgccjaVuAjxSk1RBUj9fo5ma0fya9K4n0wt
 fbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866327; x=1698471127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v+wpTJ/UmKvrUO2dhPZ2tX5kAAWYozv+5cgy4f/b128=;
 b=aijSNzQ2QuKbXUCmhm07uxKp5QgSQepqeqTzj1srqF/tj/Q6xP7FL9/3p2aF+B2jGU
 P6UnbCNH9pJgiTZ2puROYTVAFJNus9w1sblOYcq3OnD+F0314+HTufvpfMBu8yHVGppp
 R2Cr9QF7NjUpBG671MPUvDCTYmq7B7cUfwtL7aNcvFzZRmviDGAwVRDcba7NVANDvO8M
 SP+JZDpP1O66mLMXONBCkaq1zAIj7vY6GXTcFbZ/B/3ZOwJENo/BuUJY96JjDEheyWfb
 ac0adfq7ZhjidkPEeWOeqN94W3xc9qf/CqimUHg35m9YY+NWEtx5eDOo3sIA43disxye
 fvkA==
X-Gm-Message-State: AOJu0YwmKdPfVUoMdtHfx8jgx/1qEX/q4kZWbNWOfdm+N0M9Gfn0lOJC
 Trlgqn3Q6RLWRjITTyHrbG+TqmEmq0yvnsda4iQ=
X-Google-Smtp-Source: AGHT+IHOlUSHwZ5YAILSdxvs3BF/1ndSmvGJ8JYNtewTDVtHhnApsv5os+PBmU6VPmJX3Qg82SyQng==
X-Received: by 2002:a05:6a00:194c:b0:6bb:8982:411c with SMTP id
 s12-20020a056a00194c00b006bb8982411cmr3503317pfk.8.1697866326853; 
 Fri, 20 Oct 2023 22:32:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 08/90] target/sparc: Remove sparcv7 cpu features
Date: Fri, 20 Oct 2023 22:30:36 -0700
Message-Id: <20231021053158.278135-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

The oldest supported cpu is the microsparc 1; all other cpus
use CPU_DEFAULT_FEATURES.  Remove the features that must always
be present for sparcv7: FLOAT, SWAP, FLUSH, FSQRT, FMUL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_syscall.h |  6 +-----
 target/sparc/cpu.h                | 21 +++++++--------------
 target/sparc/cpu-feature.h.inc    |  5 -----
 target/sparc/cpu.c                | 19 +++----------------
 target/sparc/translate.c          | 12 ------------
 5 files changed, 11 insertions(+), 52 deletions(-)

diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_syscall.h
index be77e44eb8..e421165357 100644
--- a/linux-user/sparc/target_syscall.h
+++ b/linux-user/sparc/target_syscall.h
@@ -50,11 +50,7 @@ static inline abi_ulong target_shmlba(CPUSPARCState *env)
 #ifdef TARGET_SPARC64
     return MAX(TARGET_PAGE_SIZE, 16 * 1024);
 #else
-    if (!(env->def.features & CPU_FEATURE_FLUSH)) {
-        return 64 * 1024;
-    } else {
-        return 256 * 1024;
-    }
+    return 256 * 1024;
 #endif
 }
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index aaecbf0876..758a4e8aaa 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -306,17 +306,12 @@ enum {
 #undef FEATURE
 
 #ifndef TARGET_SPARC64
-#define CPU_DEFAULT_FEATURES (CPU_FEATURE_FLOAT | CPU_FEATURE_SWAP |  \
-                              CPU_FEATURE_MUL | CPU_FEATURE_DIV |     \
-                              CPU_FEATURE_FLUSH | CPU_FEATURE_FSQRT | \
-                              CPU_FEATURE_FMUL | CPU_FEATURE_FSMULD)
+#define CPU_DEFAULT_FEATURES (CPU_FEATURE_MUL | CPU_FEATURE_DIV | \
+                              CPU_FEATURE_FSMULD)
 #else
-#define CPU_DEFAULT_FEATURES (CPU_FEATURE_FLOAT | CPU_FEATURE_SWAP |  \
-                              CPU_FEATURE_MUL | CPU_FEATURE_DIV |     \
-                              CPU_FEATURE_FLUSH | CPU_FEATURE_FSQRT | \
-                              CPU_FEATURE_FMUL | CPU_FEATURE_VIS1 |   \
-                              CPU_FEATURE_VIS2 | CPU_FEATURE_FSMULD | \
-                              CPU_FEATURE_CASA)
+#define CPU_DEFAULT_FEATURES (CPU_FEATURE_MUL | CPU_FEATURE_DIV | \
+                              CPU_FEATURE_FSMULD | CPU_FEATURE_CASA | \
+                              CPU_FEATURE_VIS1 | CPU_FEATURE_VIS2)
 enum {
     mmu_us_12, // Ultrasparc < III (64 entry TLB)
     mmu_us_3,  // Ultrasparc III (512 entry TLB)
@@ -799,14 +794,12 @@ static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
     if (env->pstate & PS_AM) {
         flags |= TB_FLAG_AM_ENABLED;
     }
-    if ((env->def.features & CPU_FEATURE_FLOAT)
-        && (env->pstate & PS_PEF)
-        && (env->fprs & FPRS_FEF)) {
+    if ((env->pstate & PS_PEF) && (env->fprs & FPRS_FEF)) {
         flags |= TB_FLAG_FPU_ENABLED;
     }
     flags |= env->asi << TB_FLAG_ASI_SHIFT;
 #else
-    if ((env->def.features & CPU_FEATURE_FLOAT) && env->psref) {
+    if (env->psref) {
         flags |= TB_FLAG_FPU_ENABLED;
     }
 #endif
diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index d35fe90c92..d800f18c4e 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -1,11 +1,6 @@
-FEATURE(FLOAT)
 FEATURE(FLOAT128)
-FEATURE(SWAP)
 FEATURE(MUL)
 FEATURE(DIV)
-FEATURE(FLUSH)
-FEATURE(FSQRT)
-FEATURE(FMUL)
 FEATURE(VIS1)
 FEATURE(VIS2)
 FEATURE(FSMULD)
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e4d1c552e5..0a3882653c 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -403,9 +403,7 @@ static const sparc_def_t sparc_defs[] = {
         .mmu_sfsr_mask = 0x00016fff,
         .mmu_trcr_mask = 0x0000003f,
         .nwindows = 7,
-        .features = CPU_FEATURE_FLOAT | CPU_FEATURE_SWAP | CPU_FEATURE_MUL |
-        CPU_FEATURE_DIV | CPU_FEATURE_FLUSH | CPU_FEATURE_FSQRT |
-        CPU_FEATURE_FMUL,
+        .features = CPU_FEATURE_MUL | CPU_FEATURE_DIV,
     },
     {
         .name = "TI MicroSparc II",
@@ -757,9 +755,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUSPARCState *env = &cpu->env;
 
 #if defined(CONFIG_USER_ONLY)
-    if ((env->def.features & CPU_FEATURE_FLOAT)) {
-        env->def.features |= CPU_FEATURE_FLOAT128;
-    }
+    /* We are emulating the kernel, which will trap and emulate float128. */
+    env->def.features |= CPU_FEATURE_FLOAT128;
 #endif
 
     env->version = env->def.iu_version;
@@ -836,22 +833,12 @@ static PropertyInfo qdev_prop_nwindows = {
 };
 
 static Property sparc_cpu_properties[] = {
-    DEFINE_PROP_BIT("float",    SPARCCPU, env.def.features,
-                    CPU_FEATURE_BIT_FLOAT, false),
     DEFINE_PROP_BIT("float128", SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_FLOAT128, false),
-    DEFINE_PROP_BIT("swap",     SPARCCPU, env.def.features,
-                    CPU_FEATURE_BIT_SWAP, false),
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
     DEFINE_PROP_BIT("div",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_DIV, false),
-    DEFINE_PROP_BIT("flush",    SPARCCPU, env.def.features,
-                    CPU_FEATURE_BIT_FLUSH, false),
-    DEFINE_PROP_BIT("fsqrt",    SPARCCPU, env.def.features,
-                    CPU_FEATURE_BIT_FSQRT, false),
-    DEFINE_PROP_BIT("fmul",     SPARCCPU, env.def.features,
-                    CPU_FEATURE_BIT_FMUL, false),
     DEFINE_PROP_BIT("vis1",     SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_VIS1, false),
     DEFINE_PROP_BIT("vis2",     SPARCCPU, env.def.features,
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8f6fd453e7..cab9f13421 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3527,11 +3527,9 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     gen_ne_fop_FF(dc, rd, rs2, gen_helper_fabss);
                     break;
                 case 0x29: /* fsqrts */
-                    CHECK_FPU_FEATURE(dc, FSQRT);
                     gen_fop_FF(dc, rd, rs2, gen_helper_fsqrts);
                     break;
                 case 0x2a: /* fsqrtd */
-                    CHECK_FPU_FEATURE(dc, FSQRT);
                     gen_fop_DD(dc, rd, rs2, gen_helper_fsqrtd);
                     break;
                 case 0x2b: /* fsqrtq */
@@ -3559,16 +3557,13 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fsubq);
                     break;
                 case 0x49: /* fmuls */
-                    CHECK_FPU_FEATURE(dc, FMUL);
                     gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fmuls);
                     break;
                 case 0x4a: /* fmuld */
-                    CHECK_FPU_FEATURE(dc, FMUL);
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld);
                     break;
                 case 0x4b: /* fmulq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
-                    CHECK_FPU_FEATURE(dc, FMUL);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fmulq);
                     break;
                 case 0x4d: /* fdivs */
@@ -5105,8 +5100,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     goto jmp_insn;
 #endif
                 case 0x3b: /* flush */
-                    if (!((dc)->def->features & CPU_FEATURE_FLUSH))
-                        goto unimp_flush;
                     /* nop */
                     break;
                 case 0x3c:      /* save */
@@ -5224,7 +5217,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     break;
                 case 0x0f:
                     /* swap, swap register with memory. Also atomically */
-                    CHECK_IU_FEATURE(dc, SWAP);
                     cpu_src1 = gen_load_gpr(dc, rd);
                     gen_swap(dc, cpu_val, cpu_src1, cpu_addr,
                              dc->mem_idx, MO_TEUL);
@@ -5256,7 +5248,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     break;
                 case 0x1f:      /* swapa, swap reg with alt. memory. Also
                                    atomically */
-                    CHECK_IU_FEATURE(dc, SWAP);
                     cpu_src1 = gen_load_gpr(dc, rd);
                     gen_swap_asi(dc, cpu_val, cpu_src1, cpu_addr, insn);
                     break;
@@ -5578,9 +5569,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
  illegal_insn:
     gen_exception(dc, TT_ILL_INSN);
     return;
- unimp_flush:
-    gen_exception(dc, TT_UNIMP_FLUSH);
-    return;
 #if !defined(CONFIG_USER_ONLY)
  priv_insn:
     gen_exception(dc, TT_PRIV_INSN);
-- 
2.34.1


