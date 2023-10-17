Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDC97CBB7B
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdlX-0007r6-Ki; Tue, 17 Oct 2023 02:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlU-0007qX-Ar
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlR-0001ps-BC
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c9d922c039so42782495ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524872; x=1698129672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7obh1xj62WyJcU1BfYfLTUfbiNd3asc7Dm3Hwtql9CA=;
 b=EpffJd0VefSw/9LjX+A38hOBesvPVEDyyteYESq1kYAFl1lyeVniAMoMSgNraooGb1
 HhI23QjcpmgPFDB6BYSTH1/bBdmlEMHy0BkIrWxKgp5Fbv+C74av7EpJy7Jdm9zV2ecj
 P4F4xvqGKfY8EGfL7zk8UQ4cQC9cbrj+iPl2ErRJfISslx+UsjNpR305Xc10Ad6ENoVY
 qytVxOC0qbTihITfmJefklRyhBsuqseXEIrNsN284ueq+2xWK3KxN4zZSoVWV1xiKUtK
 wMyvZ5Q40g2GfhgL0E6t38ZSd0ARsubLtP6eXWQ2w8fX1he5BJrDgZXKvaDEd1wiOF/j
 RlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524872; x=1698129672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7obh1xj62WyJcU1BfYfLTUfbiNd3asc7Dm3Hwtql9CA=;
 b=qcr6MCKTSqiNQWS5CmhZH0rLoiGwh2yCrLOo7HAKKB66KzsA3DUbk6mSMZAzzUMiYd
 Dp6D2KJK1VROVyMZRWnG9S74jNfVieQLyAWIJT+N1zmJ/j0dO82BLIs7ykDhwjFuNPQ5
 s1LBbu0MgMoiHpwFRnb/wXA07G6rKc3/J3YF0tupJRaQeZlh2kpK05acdgBK7HZf6Enz
 FhqDH6srwDW7wpDrYBzvAqVwmO2sVHp9VCe6oqRIWe5FbAViPDoSB3Kh8uHYbam7BaPQ
 HAYSf5fIzcedyjqL178P/l+jfQOGqhweigiw6VbTLROJ2Gl9CaTKa66GG2SyXHUVYm+o
 zIlQ==
X-Gm-Message-State: AOJu0YwP8QZoaFNS6btNLb2INaanjFsTKmEFXkJPqW2vU2iljHz0vFWx
 jv5yLt4U5Pxe8tBTUaqRUdhxZ4v0mauNxEeVMJM=
X-Google-Smtp-Source: AGHT+IEeQA83xmor9+RLeFd+Vhw99H0epifs6DygVeFT5dbS8OhDeFPWckz2M5VI3Nhlxu2rQeg6ig==
X-Received: by 2002:a17:902:ecce:b0:1c9:d940:78ea with SMTP id
 a14-20020a170902ecce00b001c9d94078eamr1521015plh.22.1697524871930; 
 Mon, 16 Oct 2023 23:41:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 02/20] target/sparc: Split psr and xcc into components
Date: Mon, 16 Oct 2023 23:40:51 -0700
Message-Id: <20231017064109.681935-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Step in removing CC_OP: change the representation of CC_OP_FLAGS.
The 8 bits are distributed between 6 variables, which should make
it easy to keep up to date.

The code within cc_helper.c is quite ugly but is only temporary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_cpu.h |   4 +-
 target/sparc/cpu.h            |  30 ++-
 linux-user/sparc/cpu_loop.c   |  18 +-
 target/sparc/cc_helper.c      |  51 +++--
 target/sparc/machine.c        |  44 ++++-
 target/sparc/translate.c      | 363 +++++++++++++---------------------
 target/sparc/win_helper.c     |  51 ++++-
 7 files changed, 292 insertions(+), 269 deletions(-)

diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 1f4bed50f4..00a9fab98b 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -59,9 +59,9 @@ static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp,
          */
         env->regwptr[WREG_O0] = 0;
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
-        env->xcc &= ~PSR_CARRY;
+        env->cc_xcc_C = 0;
 #else
-        env->psr &= ~PSR_CARRY;
+        env->cc_icc_C = 0;
 #endif
         env->pc = env->npc;
         env->npc = env->npc + 4;
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 955329f6c9..ac93658c33 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -149,7 +149,7 @@ enum {
  */
 enum {
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
-    CC_OP_FLAGS,   /* all cc are back in status register */
+    CC_OP_FLAGS,   /* all cc are back in cc_*_[NZCV] registers */
     CC_OP_DIV,     /* modify N, Z and V, C = 0*/
     CC_OP_ADD,     /* modify all flags, CC_DST = res, CC_SRC = src1 */
     CC_OP_ADDX,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
@@ -458,6 +458,32 @@ struct CPUArchState {
     target_ulong npc;      /* next program counter */
     target_ulong y;        /* multiply/divide register */
 
+    /*
+     * Bit 31 is for icc, bit 63 for xcc.
+     * Other bits are garbage.
+     */
+    target_long cc_N;
+    target_long cc_V;
+
+    /*
+     * Z is represented as == 0; any non-zero value is !Z.
+     * For sparc64, the high 32-bits of icc.Z are garbage.
+     */
+    target_ulong cc_icc_Z;
+#ifdef TARGET_SPARC64
+    target_ulong cc_xcc_Z;
+#endif
+
+    /*
+     * For sparc32, icc.C is boolean.
+     * For sparc64, xcc.C is boolean;
+     *              icc.C is bit 32 with other bits garbage.
+     */
+    target_ulong cc_icc_C;
+#ifdef TARGET_SPARC64
+    target_ulong cc_xcc_C;
+#endif
+
     /* emulator internal flags handling */
     target_ulong cc_src, cc_src2;
     target_ulong cc_dst;
@@ -466,7 +492,6 @@ struct CPUArchState {
     target_ulong cond; /* conditional branch result (XXX: save it in a
                           temporary register when possible) */
 
-    uint32_t psr;      /* processor state register */
     target_ulong fsr;      /* FPU state register */
     CPU_DoubleU fpr[TARGET_DPREGS];  /* floating point registers */
     uint32_t cwp;      /* index of current register window (extracted
@@ -522,7 +547,6 @@ struct CPUArchState {
 #define MAXTL_MAX 8
 #define MAXTL_MASK (MAXTL_MAX - 1)
     trap_state ts[MAXTL_MAX];
-    uint32_t xcc;               /* Extended integer condition codes */
     uint32_t asi;
     uint32_t pstate;
     uint32_t tl;
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index b36bb2574b..a2086afada 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -197,12 +197,22 @@ static uint32_t do_getpsr(CPUSPARCState *env)
 /* Avoid ifdefs below for the abi32 and abi64 paths. */
 #ifdef TARGET_ABI32
 #define TARGET_TT_SYSCALL  (TT_TRAP + 0x10) /* t_linux */
-#define syscall_cc         psr
 #else
 #define TARGET_TT_SYSCALL  (TT_TRAP + 0x6d) /* tl0_linux64 */
-#define syscall_cc         xcc
 #endif
 
+static void set_syscall_cc(CPUSPARCState *env, bool val)
+{
+#ifndef TARGET_SPARC64
+    env->cc_icc_C = val;
+#elif defined(TARGET_ABI32)
+    env->cc_icc_C = (uint64_t)val << 32;
+#else
+    env->cc_xcc_C = val;
+#endif
+}
+
+
 /* Avoid ifdefs below for the v9 and pre-v9 hw traps. */
 #ifdef TARGET_SPARC64
 #define TARGET_TT_SPILL  TT_SPILL
@@ -240,10 +250,10 @@ void cpu_loop (CPUSPARCState *env)
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)(-515)) {
-                env->syscall_cc |= PSR_CARRY;
+                set_syscall_cc(env, 1);
                 ret = -ret;
             } else {
-                env->syscall_cc &= ~PSR_CARRY;
+                set_syscall_cc(env, 0);
             }
             env->regwptr[0] = ret;
             /* next instruction */
diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
index 7ad5b9b29e..fe4618ad34 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -21,16 +21,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 
-static uint32_t compute_all_flags(CPUSPARCState *env)
-{
-    return env->psr & PSR_ICC;
-}
-
-static uint32_t compute_C_flags(CPUSPARCState *env)
-{
-    return env->psr & PSR_CARRY;
-}
-
 static inline uint32_t get_NZ_icc(int32_t dst)
 {
     uint32_t ret = 0;
@@ -44,16 +34,6 @@ static inline uint32_t get_NZ_icc(int32_t dst)
 }
 
 #ifdef TARGET_SPARC64
-static uint32_t compute_all_flags_xcc(CPUSPARCState *env)
-{
-    return env->xcc & PSR_ICC;
-}
-
-static uint32_t compute_C_flags_xcc(CPUSPARCState *env)
-{
-    return env->xcc & PSR_CARRY;
-}
-
 static inline uint32_t get_NZ_xcc(target_long dst)
 {
     uint32_t ret = 0;
@@ -422,7 +402,6 @@ typedef struct CCTable {
 
 static const CCTable icc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_FLAGS] = { compute_all_flags, compute_C_flags },
     [CC_OP_DIV] = { compute_all_div, compute_C_div },
     [CC_OP_ADD] = { compute_all_add, compute_C_add },
     [CC_OP_ADDX] = { compute_all_addx, compute_C_addx },
@@ -438,7 +417,6 @@ static const CCTable icc_table[CC_OP_NB] = {
 #ifdef TARGET_SPARC64
 static const CCTable xcc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_FLAGS] = { compute_all_flags_xcc, compute_C_flags_xcc },
     [CC_OP_DIV] = { compute_all_logic_xcc, compute_C_logic },
     [CC_OP_ADD] = { compute_all_add_xcc, compute_C_add_xcc },
     [CC_OP_ADDX] = { compute_all_addx_xcc, compute_C_addx_xcc },
@@ -454,18 +432,37 @@ static const CCTable xcc_table[CC_OP_NB] = {
 
 void helper_compute_psr(CPUSPARCState *env)
 {
-    uint32_t new_psr;
+    if (CC_OP == CC_OP_FLAGS) {
+        return;
+    }
 
-    new_psr = icc_table[CC_OP].compute_all(env);
-    env->psr = new_psr;
+    uint32_t icc = icc_table[CC_OP].compute_all(env);
 #ifdef TARGET_SPARC64
-    new_psr = xcc_table[CC_OP].compute_all(env);
-    env->xcc = new_psr;
+    uint32_t xcc = xcc_table[CC_OP].compute_all(env);
+
+    env->cc_N = deposit64(-(icc & PSR_NEG), 32, 32, -(xcc & PSR_NEG));
+    env->cc_V = deposit64(-(icc & PSR_OVF), 32, 32, -(xcc & PSR_OVF));
+    env->cc_icc_C = (uint64_t)icc << (32 - PSR_CARRY_SHIFT);
+    env->cc_xcc_C = (xcc >> PSR_CARRY_SHIFT) & 1;
+    env->cc_xcc_Z = ~xcc & PSR_ZERO;
+#else
+    env->cc_N = -(icc & PSR_NEG);
+    env->cc_V = -(icc & PSR_OVF);
+    env->cc_icc_C = (icc >> PSR_CARRY_SHIFT) & 1;
 #endif
+    env->cc_icc_Z = ~icc & PSR_ZERO;
+
     CC_OP = CC_OP_FLAGS;
 }
 
 uint32_t helper_compute_C_icc(CPUSPARCState *env)
 {
+    if (CC_OP == CC_OP_FLAGS) {
+#ifdef TARGET_SPARC64
+        return extract64(env->cc_icc_C, 32, 1);
+#else
+        return env->cc_icc_C;
+#endif
+    }
     return icc_table[CC_OP].compute_c(env) >> PSR_CARRY_SHIFT;
 }
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 274e1217df..72f6dc8220 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -83,6 +83,41 @@ static const VMStateInfo vmstate_psr = {
     .put = put_psr,
 };
 
+#ifdef TARGET_SPARC64
+static int get_xcc(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    uint32_t val = qemu_get_be32(f);
+
+    env->cc_N = deposit64(env->cc_N, 32, 32, -(val & PSR_NEG));
+    env->cc_V = deposit64(env->cc_V, 32, 32, -(val & PSR_OVF));
+    env->cc_xcc_Z = ~val & PSR_ZERO;
+    env->cc_xcc_C = (val >> PSR_CARRY_SHIFT) & 1;
+
+    return 0;
+}
+
+static int put_xcc(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    uint32_t val = cpu_get_ccr(env);
+
+    /* Extract just xcc out of ccr and shift into legacy position. */
+    qemu_put_be32(f, (val & 0xf0) << (20 - 4));
+    return 0;
+}
+
+static const VMStateInfo vmstate_xcc = {
+    .name = "xcc",
+    .get = get_xcc,
+    .put = put_xcc,
+};
+#endif
+
 static int cpu_pre_save(void *opaque)
 {
     SPARCCPU *cpu = opaque;
@@ -155,7 +190,14 @@ const VMStateDescription vmstate_sparc_cpu = {
         VMSTATE_UINT32(env.mmu_version, SPARCCPU),
         VMSTATE_STRUCT_ARRAY(env.ts, SPARCCPU, MAXTL_MAX, 0,
                              vmstate_trap_state, trap_state),
-        VMSTATE_UINT32(env.xcc, SPARCCPU),
+        {
+            .name = "xcc",
+            .version_id = 0,
+            .size = sizeof(uint32_t),
+            .info = &vmstate_xcc,
+            .flags = VMS_SINGLE,
+            .offset = 0,
+        },
         VMSTATE_UINT32(env.asi, SPARCCPU),
         VMSTATE_UINT32(env.pstate, SPARCCPU),
         VMSTATE_UINT32(env.tl, SPARCCPU),
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c458de2103..f2a2d69f91 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -118,20 +118,36 @@ static void gen_helper_array8(TCGv r, TCGv a, TCGv b)
 static TCGv_ptr cpu_regwptr;
 static TCGv cpu_cc_src, cpu_cc_src2, cpu_cc_dst;
 static TCGv_i32 cpu_cc_op;
-static TCGv_i32 cpu_psr;
 static TCGv cpu_fsr, cpu_pc, cpu_npc;
 static TCGv cpu_regs[32];
 static TCGv cpu_y;
 static TCGv cpu_tbr;
 static TCGv cpu_cond;
+static TCGv cpu_cc_N;
+static TCGv cpu_cc_V;
+static TCGv cpu_icc_Z;
+static TCGv cpu_icc_C;
 #ifdef TARGET_SPARC64
-static TCGv_i32 cpu_xcc, cpu_fprs;
+static TCGv cpu_xcc_Z;
+static TCGv cpu_xcc_C;
+static TCGv_i32 cpu_fprs;
 static TCGv cpu_gsr;
 static TCGv cpu_tick_cmpr, cpu_stick_cmpr, cpu_hstick_cmpr;
 static TCGv cpu_hintp, cpu_htba, cpu_hver, cpu_ssr, cpu_ver;
 #else
 static TCGv cpu_wim;
 #endif
+
+#ifdef TARGET_SPARC64
+#define cpu_cc_Z  cpu_xcc_Z
+#define cpu_cc_C  cpu_xcc_C
+#else
+#define cpu_cc_Z  cpu_icc_Z
+#define cpu_cc_C  cpu_icc_C
+#define cpu_xcc_Z ({ qemu_build_not_reached(); NULL; })
+#define cpu_xcc_C ({ qemu_build_not_reached(); NULL; })
+#endif
+
 /* Floating point registers */
 static TCGv_i64 cpu_fpr[TARGET_DPREGS];
 
@@ -364,31 +380,6 @@ static void gen_goto_tb(DisasContext *s, int tb_num,
     }
 }
 
-// XXX suboptimal
-static void gen_mov_reg_N(TCGv reg, TCGv_i32 src)
-{
-    tcg_gen_extu_i32_tl(reg, src);
-    tcg_gen_extract_tl(reg, reg, PSR_NEG_SHIFT, 1);
-}
-
-static void gen_mov_reg_Z(TCGv reg, TCGv_i32 src)
-{
-    tcg_gen_extu_i32_tl(reg, src);
-    tcg_gen_extract_tl(reg, reg, PSR_ZERO_SHIFT, 1);
-}
-
-static void gen_mov_reg_V(TCGv reg, TCGv_i32 src)
-{
-    tcg_gen_extu_i32_tl(reg, src);
-    tcg_gen_extract_tl(reg, reg, PSR_OVF_SHIFT, 1);
-}
-
-static void gen_mov_reg_C(TCGv reg, TCGv_i32 src)
-{
-    tcg_gen_extu_i32_tl(reg, src);
-    tcg_gen_extract_tl(reg, reg, PSR_CARRY_SHIFT, 1);
-}
-
 static void gen_op_add_cc(TCGv dst, TCGv src1, TCGv src2)
 {
     tcg_gen_mov_tl(cpu_cc_src, src1);
@@ -601,13 +592,11 @@ static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_deposit_tl(cpu_y, t0, cpu_cc_src, 31, 1);
 
     // b1 = N ^ V;
-    gen_mov_reg_N(t0, cpu_psr);
-    gen_mov_reg_V(r_temp, cpu_psr);
-    tcg_gen_xor_tl(t0, t0, r_temp);
+    tcg_gen_xor_tl(t0, cpu_cc_N, cpu_cc_V);
 
     // T0 = (b1 << 31) | (T0 >> 1);
     // src1 = T0;
-    tcg_gen_shli_tl(t0, t0, 31);
+    tcg_gen_andi_tl(t0, t0, 1u << 31);
     tcg_gen_shri_tl(cpu_cc_src, cpu_cc_src, 1);
     tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, t0);
 
@@ -779,114 +768,12 @@ static void gen_op_eval_ba(TCGv dst)
     tcg_gen_movi_tl(dst, 1);
 }
 
-// Z
-static void gen_op_eval_be(TCGv dst, TCGv_i32 src)
-{
-    gen_mov_reg_Z(dst, src);
-}
-
-// Z | (N ^ V)
-static void gen_op_eval_ble(TCGv dst, TCGv_i32 src)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_N(t0, src);
-    gen_mov_reg_V(dst, src);
-    tcg_gen_xor_tl(dst, dst, t0);
-    gen_mov_reg_Z(t0, src);
-    tcg_gen_or_tl(dst, dst, t0);
-}
-
-// N ^ V
-static void gen_op_eval_bl(TCGv dst, TCGv_i32 src)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_V(t0, src);
-    gen_mov_reg_N(dst, src);
-    tcg_gen_xor_tl(dst, dst, t0);
-}
-
-// C | Z
-static void gen_op_eval_bleu(TCGv dst, TCGv_i32 src)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_Z(t0, src);
-    gen_mov_reg_C(dst, src);
-    tcg_gen_or_tl(dst, dst, t0);
-}
-
-// C
-static void gen_op_eval_bcs(TCGv dst, TCGv_i32 src)
-{
-    gen_mov_reg_C(dst, src);
-}
-
-// V
-static void gen_op_eval_bvs(TCGv dst, TCGv_i32 src)
-{
-    gen_mov_reg_V(dst, src);
-}
-
 // 0
 static void gen_op_eval_bn(TCGv dst)
 {
     tcg_gen_movi_tl(dst, 0);
 }
 
-// N
-static void gen_op_eval_bneg(TCGv dst, TCGv_i32 src)
-{
-    gen_mov_reg_N(dst, src);
-}
-
-// !Z
-static void gen_op_eval_bne(TCGv dst, TCGv_i32 src)
-{
-    gen_mov_reg_Z(dst, src);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// !(Z | (N ^ V))
-static void gen_op_eval_bg(TCGv dst, TCGv_i32 src)
-{
-    gen_op_eval_ble(dst, src);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// !(N ^ V)
-static void gen_op_eval_bge(TCGv dst, TCGv_i32 src)
-{
-    gen_op_eval_bl(dst, src);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// !(C | Z)
-static void gen_op_eval_bgu(TCGv dst, TCGv_i32 src)
-{
-    gen_op_eval_bleu(dst, src);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// !C
-static void gen_op_eval_bcc(TCGv dst, TCGv_i32 src)
-{
-    gen_mov_reg_C(dst, src);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// !N
-static void gen_op_eval_bpos(TCGv dst, TCGv_i32 src)
-{
-    gen_mov_reg_N(dst, src);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// !V
-static void gen_op_eval_bvc(TCGv dst, TCGv_i32 src)
-{
-    gen_mov_reg_V(dst, src);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
 /*
   FPSR bit field FCC1 | FCC0:
    0 =
@@ -1203,34 +1090,22 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
         TCG_COND_ALWAYS, /* vc:  !V -> 1 */
     };
 
-    TCGv_i32 r_src;
-    TCGv r_dst;
+    TCGv t1, t2;
 
-#ifdef TARGET_SPARC64
-    if (xcc) {
-        r_src = cpu_xcc;
-    } else {
-        r_src = cpu_psr;
-    }
-#else
-    r_src = cpu_psr;
-#endif
+    cmp->is_bool = false;
 
     switch (dc->cc_op) {
     case CC_OP_LOGIC:
         cmp->cond = logic_cond[cond];
     do_compare_dst_0:
-        cmp->is_bool = false;
         cmp->c2 = tcg_constant_tl(0);
-#ifdef TARGET_SPARC64
-        if (!xcc) {
-            cmp->c1 = tcg_temp_new();
-            tcg_gen_ext32s_tl(cmp->c1, cpu_cc_dst);
-            break;
+        if (TARGET_LONG_BITS == 32 || xcc) {
+            cmp->c1 = cpu_cc_dst;
+        } else {
+            cmp->c1 = t1 = tcg_temp_new();
+            tcg_gen_ext32s_tl(t1, cpu_cc_dst);
         }
-#endif
-        cmp->c1 = cpu_cc_dst;
-        break;
+        return;
 
     case CC_OP_SUB:
         switch (cond) {
@@ -1241,92 +1116,128 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 
         case 7: /* overflow */
         case 15: /* !overflow */
-            goto do_dynamic;
+            break;
 
         default:
             cmp->cond = subcc_cond[cond];
-            cmp->is_bool = false;
-#ifdef TARGET_SPARC64
-            if (!xcc) {
+            if (TARGET_LONG_BITS == 32 || xcc) {
+                cmp->c1 = cpu_cc_src;
+                cmp->c2 = cpu_cc_src2;
+            } else {
                 /* Note that sign-extension works for unsigned compares as
                    long as both operands are sign-extended.  */
-                cmp->c1 = tcg_temp_new();
-                cmp->c2 = tcg_temp_new();
-                tcg_gen_ext32s_tl(cmp->c1, cpu_cc_src);
-                tcg_gen_ext32s_tl(cmp->c2, cpu_cc_src2);
-                break;
+                cmp->c1 = t1 = tcg_temp_new();
+                tcg_gen_ext32s_tl(t1, cpu_cc_src);
+                cmp->c2 = t2 = tcg_temp_new();
+                tcg_gen_ext32s_tl(t2, cpu_cc_src2);
             }
-#endif
-            cmp->c1 = cpu_cc_src;
-            cmp->c2 = cpu_cc_src2;
-            break;
+            return;
         }
         break;
 
     default:
-    do_dynamic:
         gen_helper_compute_psr(tcg_env);
         dc->cc_op = CC_OP_FLAGS;
-        /* FALLTHRU */
+        break;
 
     case CC_OP_FLAGS:
-        /* We're going to generate a boolean result.  */
-        cmp->cond = TCG_COND_NE;
-        cmp->is_bool = true;
-        cmp->c1 = r_dst = tcg_temp_new();
-        cmp->c2 = tcg_constant_tl(0);
+        break;
+    }
 
-        switch (cond) {
-        case 0x0:
-            gen_op_eval_bn(r_dst);
-            break;
-        case 0x1:
-            gen_op_eval_be(r_dst, r_src);
-            break;
-        case 0x2:
-            gen_op_eval_ble(r_dst, r_src);
-            break;
-        case 0x3:
-            gen_op_eval_bl(r_dst, r_src);
-            break;
-        case 0x4:
-            gen_op_eval_bleu(r_dst, r_src);
-            break;
-        case 0x5:
-            gen_op_eval_bcs(r_dst, r_src);
-            break;
-        case 0x6:
-            gen_op_eval_bneg(r_dst, r_src);
-            break;
-        case 0x7:
-            gen_op_eval_bvs(r_dst, r_src);
-            break;
-        case 0x8:
-            gen_op_eval_ba(r_dst);
-            break;
-        case 0x9:
-            gen_op_eval_bne(r_dst, r_src);
-            break;
-        case 0xa:
-            gen_op_eval_bg(r_dst, r_src);
-            break;
-        case 0xb:
-            gen_op_eval_bge(r_dst, r_src);
-            break;
-        case 0xc:
-            gen_op_eval_bgu(r_dst, r_src);
-            break;
-        case 0xd:
-            gen_op_eval_bcc(r_dst, r_src);
-            break;
-        case 0xe:
-            gen_op_eval_bpos(r_dst, r_src);
-            break;
-        case 0xf:
-            gen_op_eval_bvc(r_dst, r_src);
-            break;
+    cmp->c1 = NULL;
+    cmp->c2 = tcg_constant_tl(0);
+
+    switch (cond & 7) {
+    case 0x0: /* never */
+        cmp->cond = TCG_COND_NEVER;
+        cmp->c1 = cmp->c2;
+        break;
+
+    case 0x1: /* eq */
+        cmp->cond = TCG_COND_EQ;
+        if (TARGET_LONG_BITS == 32 || xcc) {
+            cmp->c1 = cpu_cc_Z;
+        } else {
+            cmp->c1 = t1 = tcg_temp_new();
+            tcg_gen_ext32u_tl(t1, cpu_icc_Z);
         }
         break;
+
+    case 0x2: /* le: Z | (N ^ V) */
+        cmp->cond = TCG_COND_LT;
+        cmp->c1 = t1 = tcg_temp_new();
+        if (TARGET_LONG_BITS == 32 || xcc) {
+            tcg_gen_negsetcond_tl(TCG_COND_EQ, t1, cpu_cc_Z, cmp->c2);
+        } else {
+            tcg_gen_ext32u_tl(t1, cpu_icc_Z);
+            tcg_gen_negsetcond_tl(TCG_COND_EQ, t1, t1, cmp->c2);
+        }
+        t2 = tcg_temp_new();
+        tcg_gen_xor_tl(t2, cpu_cc_N, cpu_cc_V);
+        if (TARGET_LONG_BITS == 64 && !xcc) {
+            tcg_gen_ext32s_tl(t2, t2);
+        }
+        tcg_gen_or_tl(t1, t1, t2);
+        break;
+
+    case 0x3: /* lt: N ^ V */
+        cmp->cond = TCG_COND_LT;
+        cmp->c1 = t1 = tcg_temp_new();
+        tcg_gen_xor_tl(t1, cpu_cc_N, cpu_cc_V);
+        if (TARGET_LONG_BITS == 64 && !xcc) {
+            tcg_gen_ext32s_tl(t1, t1);
+        }
+        break;
+
+    case 0x4: /* leu: C | Z -> !(!C & !Z) */
+        cmp->cond = TCG_COND_EQ;
+        cmp->c1 = t1 = tcg_temp_new();
+        if (TARGET_LONG_BITS == 32 || xcc) {
+            tcg_gen_subi_tl(t1, cpu_cc_C, 1);
+            tcg_gen_and_tl(t1, t1, cpu_cc_Z);
+        } else {
+            tcg_gen_extract_tl(t1, cpu_icc_C, 32, 1);
+            tcg_gen_subi_tl(t1, t1, 1);
+            t2 = tcg_temp_new();
+            tcg_gen_ext32u_tl(t2, cpu_icc_Z);
+            tcg_gen_and_tl(t1, t1, t2);
+        }
+        break;
+
+    case 0x5: /* ltu: C */
+        cmp->cond = TCG_COND_NE;
+        cmp->is_bool = true;
+        if (TARGET_LONG_BITS == 32 || xcc) {
+            cmp->c1 = cpu_cc_C;
+        } else {
+            cmp->c1 = t1 = tcg_temp_new();
+            tcg_gen_extract_tl(t1, cpu_icc_C, 32, 1);
+        }
+        break;
+
+    case 0x6: /* neg: N */
+        cmp->cond = TCG_COND_LT;
+        if (TARGET_LONG_BITS == 32 || xcc) {
+            cmp->c1 = cpu_cc_N;
+        } else {
+            cmp->c1 = t1 = tcg_temp_new();
+            tcg_gen_ext32s_tl(t1, cpu_cc_N);
+        }
+        break;
+
+    case 0x7: /* vs: V */
+        cmp->cond = TCG_COND_LT;
+        if (TARGET_LONG_BITS == 32 || xcc) {
+            cmp->c1 = cpu_cc_V;
+        } else {
+            cmp->c1 = t1 = tcg_temp_new();
+            tcg_gen_ext32s_tl(t1, cpu_cc_V);
+        }
+        break;
+    }
+    if (cond & 8) {
+        cmp->cond = tcg_invert_cond(cmp->cond);
+        cmp->is_bool = false;
     }
 }
 
@@ -5602,13 +5513,11 @@ void sparc_tcg_init(void)
 
     static const struct { TCGv_i32 *ptr; int off; const char *name; } r32[] = {
 #ifdef TARGET_SPARC64
-        { &cpu_xcc, offsetof(CPUSPARCState, xcc), "xcc" },
         { &cpu_fprs, offsetof(CPUSPARCState, fprs), "fprs" },
 #else
         { &cpu_wim, offsetof(CPUSPARCState, wim), "wim" },
 #endif
         { &cpu_cc_op, offsetof(CPUSPARCState, cc_op), "cc_op" },
-        { &cpu_psr, offsetof(CPUSPARCState, psr), "psr" },
     };
 
     static const struct { TCGv *ptr; int off; const char *name; } rtl[] = {
@@ -5623,7 +5532,13 @@ void sparc_tcg_init(void)
         { &cpu_hver, offsetof(CPUSPARCState, hver), "hver" },
         { &cpu_ssr, offsetof(CPUSPARCState, ssr), "ssr" },
         { &cpu_ver, offsetof(CPUSPARCState, version), "ver" },
+        { &cpu_xcc_Z, offsetof(CPUSPARCState, cc_xcc_Z), "xcc_Z" },
+        { &cpu_xcc_C, offsetof(CPUSPARCState, cc_xcc_C), "xcc_C" },
 #endif
+        { &cpu_cc_N, offsetof(CPUSPARCState, cc_N), "cc_N" },
+        { &cpu_cc_V, offsetof(CPUSPARCState, cc_V), "cc_V" },
+        { &cpu_icc_Z, offsetof(CPUSPARCState, cc_icc_Z), "icc_Z" },
+        { &cpu_icc_C, offsetof(CPUSPARCState, cc_icc_C), "icc_C" },
         { &cpu_cond, offsetof(CPUSPARCState, cond), "cond" },
         { &cpu_cc_src, offsetof(CPUSPARCState, cc_src), "cc_src" },
         { &cpu_cc_src2, offsetof(CPUSPARCState, cc_src2), "cc_src2" },
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index bf2c90c780..a446c1785d 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -53,23 +53,43 @@ void cpu_set_cwp(CPUSPARCState *env, int new_cwp)
 
 target_ulong cpu_get_psr(CPUSPARCState *env)
 {
+    target_ulong icc = 0;
+
     helper_compute_psr(env);
 
+    icc |= ((int32_t)env->cc_N < 0) << PSR_NEG_SHIFT;
+    icc |= ((int32_t)env->cc_V < 0) << PSR_OVF_SHIFT;
+    icc |= ((int32_t)env->cc_icc_Z == 0) << PSR_ZERO_SHIFT;
+    if (TARGET_LONG_BITS == 64) {
+        icc |= extract64(env->cc_icc_C, 32, 1) << PSR_CARRY_SHIFT;
+    } else {
+        icc |= env->cc_icc_C << PSR_CARRY_SHIFT;
+    }
+
 #if !defined(TARGET_SPARC64)
-    return env->version | (env->psr & PSR_ICC) |
+    return env->version | icc |
         (env->psref ? PSR_EF : 0) |
         (env->psrpil << 8) |
         (env->psrs ? PSR_S : 0) |
         (env->psrps ? PSR_PS : 0) |
         (env->psret ? PSR_ET : 0) | env->cwp;
 #else
-    return env->psr & PSR_ICC;
+    return icc;
 #endif
 }
 
 void cpu_put_psr_icc(CPUSPARCState *env, target_ulong val)
 {
-    env->psr = val & PSR_ICC;
+    if (TARGET_LONG_BITS == 64) {
+        env->cc_N = deposit64(env->cc_N, 0, 32, -(val & PSR_NEG));
+        env->cc_V = deposit64(env->cc_V, 0, 32, -(val & PSR_OVF));
+        env->cc_icc_C = -(val & PSR_CARRY);
+    } else {
+        env->cc_N = -(val & PSR_NEG);
+        env->cc_V = -(val & PSR_OVF);
+        env->cc_icc_C = (val >> PSR_CARRY_SHIFT) & 1;
+    }
+    env->cc_icc_Z = ~val & PSR_ZERO;
 }
 
 void cpu_put_psr_raw(CPUSPARCState *env, target_ulong val)
@@ -249,17 +269,32 @@ void helper_restored(CPUSPARCState *env)
 
 target_ulong cpu_get_ccr(CPUSPARCState *env)
 {
-    target_ulong psr;
+    target_ulong ccr = 0;
 
-    psr = cpu_get_psr(env);
+    helper_compute_psr(env);
 
-    return ((env->xcc >> 20) << 4) | ((psr & PSR_ICC) >> 20);
+    ccr |= (env->cc_icc_C >> 32) & 1;
+    ccr |= ((int32_t)env->cc_V < 0) << 1;
+    ccr |= ((int32_t)env->cc_icc_Z == 0) << 2;
+    ccr |= ((int32_t)env->cc_N < 0) << 3;
+
+    ccr |= env->cc_xcc_C << 4;
+    ccr |= (env->cc_V < 0) << 5;
+    ccr |= (env->cc_xcc_Z == 0) << 6;
+    ccr |= (env->cc_N < 0) << 7;
+
+    return ccr;
 }
 
 void cpu_put_ccr(CPUSPARCState *env, target_ulong val)
 {
-    env->xcc = (val >> 4) << 20;
-    env->psr = (val & 0xf) << 20;
+    env->cc_N = deposit64(-(val & 0x08), 32, 32, -(val & 0x80));
+    env->cc_V = deposit64(-(val & 0x02), 32, 32, -(val & 0x20));
+    env->cc_icc_C = (uint64_t)val << 32;
+    env->cc_xcc_C = (val >> 4) & 1;
+    env->cc_icc_Z = ~val & 0x04;
+    env->cc_xcc_Z = ~val & 0x40;
+
     CC_OP = CC_OP_FLAGS;
 }
 
-- 
2.34.1


