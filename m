Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF29A7D270C
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtO-00077T-L1; Sun, 22 Oct 2023 19:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtA-00074A-9q
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:44 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht8-0006iK-82
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:44 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b2e44c7941so2070554b6e.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017381; x=1698622181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imDgEUum8PsXbQ/+Z4HhrVdRHwLKWjtXZ1f2ZH8WSQs=;
 b=xR3v2ouN1Y91MGp6Kh+k5vq3VvGtRMCLogNGZHhwN46jZRAvZYkgGDEaGoCqtG3rpe
 H1f/KYS2eQ0uqXH3dcVVW7rgvX2YKIYThKaviuVRwSwTEflTw/7Vd/gWOLLcZJXHmVfj
 NP7FshdwiVcTUwzDo/A1lqjhzrhWKyy/CEimjOT96qRSoIVHZXjYX/cKQ6A3W7G5+Q5J
 m4yFYsdWuslZ8VcflOZuXX1ALZlv0o69JoxYuKDGd8RquZjGUVTdQMWimLzdxvQhIF1V
 Pws/0X3qCvVoCpF86oraLi/RB/8rPn8WVydfKfhPtEqE94Ma5W+xnqMUX8iB8DZAgS0+
 dxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017381; x=1698622181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imDgEUum8PsXbQ/+Z4HhrVdRHwLKWjtXZ1f2ZH8WSQs=;
 b=tebmq2g0j6b79xMqb9IFW6a81N3OWmjChtAqeX7zARTdpAELzCqkOoxmNHx4ij5K3Y
 6QOEVhICD5bTjvTGhtwgTQ5RolO2sNV8aYHdsbCnPEp46Xrq5LO1QlS8Xey8cToNwDLh
 n3Gogn1wrwkOukolq1WHewkZvPR/UnLi3dnwpw1CMmgyMNdY7+EvBNhHYDIn43ixe+oo
 SALQNOPTJf3Vm4YwasUYPaX1u2osI9bR/ux6LJji8We36zt+8MHeUdiZYQH214R7y+8a
 F2wJSpeTN51zynCkLUbqA82hoxsvoNlAYb5wDnsIgOE+aTR5+Fqs9rypKi1vPo0GHyHc
 k8SA==
X-Gm-Message-State: AOJu0YxauFD0ofR0tRqi2bmoijUPC7/0pL67oCsmeNboZMovNdByeT/w
 0fIUI30zmHWDlCnK4M7CTYCMKQKmW9SIbqB9s9A=
X-Google-Smtp-Source: AGHT+IE5DXz57oaWNu3nBCjU6Z3k2Z+tqQxnmDDhu5UFbFngB1/CfbGuK00nFGvkQtwRJVAYC5ZAow==
X-Received: by 2002:a54:4513:0:b0:398:5d57:3d08 with SMTP id
 l19-20020a544513000000b003985d573d08mr8796421oil.37.1698017381067; 
 Sun, 22 Oct 2023 16:29:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 08/94] target/sparc: Remove sparcv7 cpu features
Date: Sun, 22 Oct 2023 16:28:06 -0700
Message-Id: <20231022232932.80507-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_syscall.h |  6 +-----
 target/sparc/cpu.h                | 21 +++++++--------------
 target/sparc/cpu-feature.h.inc    |  5 -----
 target/sparc/cpu.c                | 24 +++---------------------
 target/sparc/translate.c          | 12 ------------
 5 files changed, 11 insertions(+), 57 deletions(-)

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
index 330b7bead3..f527244aa4 100644
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
@@ -547,14 +545,9 @@ static const sparc_def_t sparc_defs[] = {
 
 /* This must match sparc_cpu_properties[]. */
 static const char * const feature_name[] = {
-    [CPU_FEATURE_BIT_FLOAT] = "float",
     [CPU_FEATURE_BIT_FLOAT128] = "float128",
-    [CPU_FEATURE_BIT_SWAP] = "swap",
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
-    [CPU_FEATURE_BIT_FLUSH] = "flush",
-    [CPU_FEATURE_BIT_FSQRT] = "fsqrt",
-    [CPU_FEATURE_BIT_FMUL] = "fmul",
     [CPU_FEATURE_BIT_VIS1] = "vis1",
     [CPU_FEATURE_BIT_VIS2] = "vis2",
     [CPU_FEATURE_BIT_FSMULD] = "fsmuld",
@@ -758,9 +751,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUSPARCState *env = &cpu->env;
 
 #if defined(CONFIG_USER_ONLY)
-    if ((env->def.features & CPU_FEATURE_FLOAT)) {
-        env->def.features |= CPU_FEATURE_FLOAT128;
-    }
+    /* We are emulating the kernel, which will trap and emulate float128. */
+    env->def.features |= CPU_FEATURE_FLOAT128;
 #endif
 
     env->version = env->def.iu_version;
@@ -838,22 +830,12 @@ static PropertyInfo qdev_prop_nwindows = {
 
 /* This must match feature_name[]. */
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


