Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F16A7C8F09
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:30:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiJ-0006Ag-BP; Fri, 13 Oct 2023 17:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiI-0006AE-1Q
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:54 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiG-0000P8-3O
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:53 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6c61d955161so1591485a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232531; x=1697837331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NSD1a8m2pJ6AL+7QLFHG+z8njvoCbrnsh9v22o4fA4=;
 b=vLbCXBWVYljOHwOhOEMQ2T+skEDRfjT+N1sqOhcaSvTpFX9e95lmZv4j3us6VJ3yFx
 47pxGbGgiytM51qsdYa3Rg/xOs8FxDYJl1Q8hUC7Jntv6yG+K3UNgygrbtP3pCPSAtJi
 JQRN14S0PUEjPzTKy/xjyLi6xkz3qUFWp8NLWCsCo86KBxkBXURFeXi0bUJ6SGCO4Pjm
 UTTD7NuL1wKS0Ny5ZvJVpHyQlo1PB/BUklR8KXnpcaT7vruk9iSrOygO7npSjpF46ytT
 7iJSR/23+NUaVpDyQo5evXM1Utr7/gRNJvq0QK58CWjGRKfxhsMiPqWfXboYUTIYy1kQ
 lNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232531; x=1697837331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NSD1a8m2pJ6AL+7QLFHG+z8njvoCbrnsh9v22o4fA4=;
 b=HRhVz8fRZh5D0eDmiBUZt+9yMiPghDe3T/01yFn4kDA+4LkzxuVuj6mNA3PsU3oeTs
 1Vi8J42wOpaAwTTlINUSKA0ydVeTMQ2MIYYLUs5nzHGklhQMmNpqezY1lGIivrbyYqzl
 nO9f1rEQyE1/8dyVJeLWYEM0C3vGusGVQgzS/qZUHhoYgDvDYwFP7UvjSF595J6iQv0L
 2Lv31MvISN9l28g/Ja0Mjsb7h56CUthjGcn9CTRV1a9/QWX11e+02tpdx3vrdyvcBG92
 fWcGTjfvltW88Pn5IJRumcaoWz6scRxjJUwk1vlBQTNWJpr6Yb6AQVFzbUxYNZe+8O4R
 8bbw==
X-Gm-Message-State: AOJu0Yz4In9QWgvKIfYtKaWeDpuD/B2upqlPnUrs0H9Oma7GTMoMOzCy
 XSVn1wA9Ctz5m+PlFMIanbWRbnE3X33jzO8iIiM=
X-Google-Smtp-Source: AGHT+IEr1hZicmuh44fDIQg26c+d7VKCOO+cVo3xxeV/DHpcy3rgSe1cgM9G1/0dEGxGMtImts3zNA==
X-Received: by 2002:a05:6870:f703:b0:1d4:d5a8:3d1a with SMTP id
 ej3-20020a056870f70300b001d4d5a83d1amr29377824oab.30.1697232530917; 
 Fri, 13 Oct 2023 14:28:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 03/85] target/sparc: Remove always-set cpu features
Date: Fri, 13 Oct 2023 14:27:24 -0700
Message-Id: <20231013212846.165724-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

The oldest supported cpu is the microsparc 1;
all other cpus use CPU_DEFAULT_FEATURES.

Remove all bits that are always set: FLOAT, SWAP, MUL, DIV,
FLUSH, FSQRT, FMUL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_syscall.h |  6 +---
 target/sparc/cpu.h                | 50 +++++++++++--------------------
 target/sparc/cpu.c                |  8 ++---
 target/sparc/translate.c          | 16 ----------
 4 files changed, 20 insertions(+), 60 deletions(-)

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
index 9fc5c401d2..bb8b65e47e 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -291,38 +291,24 @@ struct sparc_def_t {
     uint32_t maxtl;
 };
 
-#define CPU_FEATURE_FLOAT        (1 << 0)
-#define CPU_FEATURE_FLOAT128     (1 << 1)
-#define CPU_FEATURE_SWAP         (1 << 2)
-#define CPU_FEATURE_MUL          (1 << 3)
-#define CPU_FEATURE_DIV          (1 << 4)
-#define CPU_FEATURE_FLUSH        (1 << 5)
-#define CPU_FEATURE_FSQRT        (1 << 6)
-#define CPU_FEATURE_FMUL         (1 << 7)
-#define CPU_FEATURE_VIS1         (1 << 8)
-#define CPU_FEATURE_VIS2         (1 << 9)
-#define CPU_FEATURE_FSMULD       (1 << 10)
-#define CPU_FEATURE_HYPV         (1 << 11)
-#define CPU_FEATURE_CMT          (1 << 12)
-#define CPU_FEATURE_GL           (1 << 13)
-#define CPU_FEATURE_TA0_SHUTDOWN (1 << 14) /* Shutdown on "ta 0x0" */
-#define CPU_FEATURE_ASR17        (1 << 15)
-#define CPU_FEATURE_CACHE_CTRL   (1 << 16)
-#define CPU_FEATURE_POWERDOWN    (1 << 17)
-#define CPU_FEATURE_CASA         (1 << 18)
+#define CPU_FEATURE_FLOAT128     (1 << 0)
+#define CPU_FEATURE_VIS1         (1 << 1)
+#define CPU_FEATURE_VIS2         (1 << 2)
+#define CPU_FEATURE_FSMULD       (1 << 3)
+#define CPU_FEATURE_HYPV         (1 << 4)
+#define CPU_FEATURE_CMT          (1 << 5)
+#define CPU_FEATURE_GL           (1 << 6)
+#define CPU_FEATURE_TA0_SHUTDOWN (1 << 7) /* Shutdown on "ta 0x0" */
+#define CPU_FEATURE_ASR17        (1 << 8)
+#define CPU_FEATURE_CACHE_CTRL   (1 << 9)
+#define CPU_FEATURE_POWERDOWN    (1 << 10)
+#define CPU_FEATURE_CASA         (1 << 11)
 
 #ifndef TARGET_SPARC64
-#define CPU_DEFAULT_FEATURES (CPU_FEATURE_FLOAT | CPU_FEATURE_SWAP |  \
-                              CPU_FEATURE_MUL | CPU_FEATURE_DIV |     \
-                              CPU_FEATURE_FLUSH | CPU_FEATURE_FSQRT | \
-                              CPU_FEATURE_FMUL | CPU_FEATURE_FSMULD)
+#define CPU_DEFAULT_FEATURES CPU_FEATURE_FSMULD
 #else
-#define CPU_DEFAULT_FEATURES (CPU_FEATURE_FLOAT | CPU_FEATURE_SWAP |  \
-                              CPU_FEATURE_MUL | CPU_FEATURE_DIV |     \
-                              CPU_FEATURE_FLUSH | CPU_FEATURE_FSQRT | \
-                              CPU_FEATURE_FMUL | CPU_FEATURE_VIS1 |   \
-                              CPU_FEATURE_VIS2 | CPU_FEATURE_FSMULD | \
-                              CPU_FEATURE_CASA)
+#define CPU_DEFAULT_FEATURES (CPU_FEATURE_VIS1 | CPU_FEATURE_VIS2 | \
+                              CPU_FEATURE_FSMULD | CPU_FEATURE_CASA)
 enum {
     mmu_us_12, // Ultrasparc < III (64 entry TLB)
     mmu_us_3,  // Ultrasparc III (512 entry TLB)
@@ -805,14 +791,12 @@ static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
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
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 8ba96ae225..117800d670 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -403,9 +403,7 @@ static const sparc_def_t sparc_defs[] = {
         .mmu_sfsr_mask = 0x00016fff,
         .mmu_trcr_mask = 0x0000003f,
         .nwindows = 7,
-        .features = CPU_FEATURE_FLOAT | CPU_FEATURE_SWAP | CPU_FEATURE_MUL |
-        CPU_FEATURE_DIV | CPU_FEATURE_FLUSH | CPU_FEATURE_FSQRT |
-        CPU_FEATURE_FMUL,
+        .features = 0,
     },
     {
         .name = "TI MicroSparc II",
@@ -757,9 +755,7 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUSPARCState *env = &cpu->env;
 
 #if defined(CONFIG_USER_ONLY)
-    if ((env->def.features & CPU_FEATURE_FLOAT)) {
-        env->def.features |= CPU_FEATURE_FLOAT128;
-    }
+    env->def.features |= CPU_FEATURE_FLOAT128;
 #endif
 
     env->version = env->def.iu_version;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f92ff80ac8..7405173dea 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3488,11 +3488,9 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
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
@@ -3520,16 +3518,13 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
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
@@ -3979,7 +3974,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         break;
 #endif
                     case 0xa: /* umul */
-                        CHECK_IU_FEATURE(dc, MUL);
                         gen_op_umul(cpu_dst, cpu_src1, cpu_src2);
                         if (xop & 0x10) {
                             tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
@@ -3988,7 +3982,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         }
                         break;
                     case 0xb: /* smul */
-                        CHECK_IU_FEATURE(dc, MUL);
                         gen_op_smul(cpu_dst, cpu_src1, cpu_src2);
                         if (xop & 0x10) {
                             tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
@@ -4006,7 +3999,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         break;
 #endif
                     case 0xe: /* udiv */
-                        CHECK_IU_FEATURE(dc, DIV);
                         if (xop & 0x10) {
                             gen_helper_udiv_cc(cpu_dst, tcg_env, cpu_src1,
                                                cpu_src2);
@@ -4017,7 +4009,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         }
                         break;
                     case 0xf: /* sdiv */
-                        CHECK_IU_FEATURE(dc, DIV);
                         if (xop & 0x10) {
                             gen_helper_sdiv_cc(cpu_dst, tcg_env, cpu_src1,
                                                cpu_src2);
@@ -5069,8 +5060,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     goto jmp_insn;
 #endif
                 case 0x3b: /* flush */
-                    if (!((dc)->def->features & CPU_FEATURE_FLUSH))
-                        goto unimp_flush;
                     /* nop */
                     break;
                 case 0x3c:      /* save */
@@ -5188,7 +5177,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     break;
                 case 0x0f:
                     /* swap, swap register with memory. Also atomically */
-                    CHECK_IU_FEATURE(dc, SWAP);
                     cpu_src1 = gen_load_gpr(dc, rd);
                     gen_swap(dc, cpu_val, cpu_src1, cpu_addr,
                              dc->mem_idx, MO_TEUL);
@@ -5220,7 +5208,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     break;
                 case 0x1f:      /* swapa, swap reg with alt. memory. Also
                                    atomically */
-                    CHECK_IU_FEATURE(dc, SWAP);
                     cpu_src1 = gen_load_gpr(dc, rd);
                     gen_swap_asi(dc, cpu_val, cpu_src1, cpu_addr, insn);
                     break;
@@ -5542,9 +5529,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
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


