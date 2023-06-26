Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 177FF73E3A0
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:41:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKb-0000nR-K7; Mon, 26 Jun 2023 11:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJq-0000If-8W
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJk-0002no-L6
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:57 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-313f18f5295so1388437f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793988; x=1690385988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Re2PQ2EG6HG3aGVdydO0fCiV5HwMtot1P0ZEKfNn7zY=;
 b=kmG4A2FhjLqHrSpwMNU/otIsiq95IWkzIRCssaRMnys53zG3OE9+HdvFrX8ToUmot+
 Fjcv6ryWz5f+9kQlnmpRG5VDJBI+S2YQULDdYi6mIBW6C/QCULc7YUy1iw5weYfTOYtz
 7PwDZ8sJlPos9BXpdzTRamK90RloFSHX8H+QqyRc4WC9UscPRWzrHeyANVnzds9m5sHV
 bghK86+lPOa6AAFVpBtSndT5TbJH2OiPtK6gpPOHUFBrn6NoTIYwBlNNUIf8KZOxw6xJ
 ah4b25kjYAY3lCucIp+GURDKn35vNf1DZ58gssSPiBlde9coHm+aAr+Qf4rBxGX6+1N6
 2rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793988; x=1690385988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Re2PQ2EG6HG3aGVdydO0fCiV5HwMtot1P0ZEKfNn7zY=;
 b=lRKc8vmEnEV3DG93q/AmUDgI0iBAnbNS6OTNByV3e52NdW/lTspG7Et0gxLL0crnBz
 OGFVsKHNKRCWJT/kmKznghEN51mrt6x1Go73X0poGABkzH94xM3t3OO5F18BuvLBnbbn
 zWQVvUK4QjpnqfmWoqUtGVmRBJiG9iJK0mjjGF2BOilxbRsX/iyB8pzypMC0iVJDC2W2
 SHoChihgp34CWer1JwHxg+/Qa3TtIUjjLAfnbdbK6pDKB4BJoAYhunAu9WuytjvFeeL2
 /NBHZywWFkTNQ9E5DOr+O+voarxMb0pdJ9M0BOspqMRWtiaYnjMrFv8Hf5QRoKw3yjOP
 aySQ==
X-Gm-Message-State: AC+VfDwlL68+GVV6CdzrrYGdeVmVjBjbLT+P3hvJRSpFj5/2C8D1gJ3/
 CdKwsO/P6YzoOI3V+DYXdok1ZL/a+FKWQAf0VA/Y4pCX
X-Google-Smtp-Source: ACHHUZ6v6bY2m2M0M4aQyYk8D0WkJ3Ta4muQq6mSSU4QWD9vIZqOEWqbMtPGV0sWRtZtZYspnSDWmg==
X-Received: by 2002:a5d:5960:0:b0:30e:19a8:4b0a with SMTP id
 e32-20020a5d5960000000b0030e19a84b0amr26084465wri.2.1687793988552; 
 Mon, 26 Jun 2023 08:39:48 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 03/22] target: Widen pc/cs_base in cpu_get_tb_cpu_state
Date: Mon, 26 Jun 2023 17:39:26 +0200
Message-Id: <20230626153945.76180-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

From: Anton Johansson <anjo@rev.ng>

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621135633.1649-4-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h        | 4 ++--
 target/arm/cpu.h          | 4 ++--
 target/avr/cpu.h          | 4 ++--
 target/cris/cpu.h         | 4 ++--
 target/hexagon/cpu.h      | 4 ++--
 target/hppa/cpu.h         | 5 ++---
 target/i386/cpu.h         | 4 ++--
 target/loongarch/cpu.h    | 6 ++----
 target/m68k/cpu.h         | 4 ++--
 target/microblaze/cpu.h   | 4 ++--
 target/mips/cpu.h         | 4 ++--
 target/nios2/cpu.h        | 4 ++--
 target/openrisc/cpu.h     | 5 ++---
 target/ppc/cpu.h          | 8 ++++----
 target/riscv/cpu.h        | 4 ++--
 target/rx/cpu.h           | 4 ++--
 target/s390x/cpu.h        | 4 ++--
 target/sh4/cpu.h          | 4 ++--
 target/sparc/cpu.h        | 4 ++--
 target/tricore/cpu.h      | 4 ++--
 target/xtensa/cpu.h       | 4 ++--
 accel/tcg/cpu-exec.c      | 9 ++++++---
 accel/tcg/translate-all.c | 3 ++-
 target/arm/helper.c       | 4 ++--
 target/ppc/helper_regs.c  | 4 ++--
 target/riscv/cpu_helper.c | 4 ++--
 26 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 5e67304d81..fcd20bfd3a 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -462,8 +462,8 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      MemTxResult response, uintptr_t retaddr);
 #endif
 
-static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *pflags)
+static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *pflags)
 {
     *pc = env->pc;
     *cs_base = 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 11c3850ad9..00e675f58f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3220,8 +3220,8 @@ static inline bool arm_cpu_bswap_data(CPUARMState *env)
 }
 #endif
 
-void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
-                          target_ulong *cs_base, uint32_t *flags);
+void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags);
 
 enum {
     QEMU_PSCI_CONDUIT_DISABLED = 0,
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index f19dd72926..7225174668 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -190,8 +190,8 @@ enum {
     TB_FLAGS_SKIP = 2,
 };
 
-static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *pflags)
+static inline void cpu_get_tb_cpu_state(CPUAVRState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *pflags)
 {
     uint32_t flags = 0;
 
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 71fa1f96e0..8e37c6e50d 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -266,8 +266,8 @@ static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
 
 #include "exec/cpu-all.h"
 
-static inline void cpu_get_tb_cpu_state(CPUCRISState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUCRISState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
     *cs_base = 0;
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index bfcb1057dd..daef5c3f00 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -153,8 +153,8 @@ struct ArchCPU {
 
 FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
 
-static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     uint32_t hex_flags = 0;
     *pc = env->gpr[HEX_REG_PC];
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index b595ef25a9..7373177b55 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -268,9 +268,8 @@ static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
 
-static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, target_ulong *pc,
-                                        target_ulong *cs_base,
-                                        uint32_t *pflags)
+static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *pflags)
 {
     uint32_t flags = env->psw_n * PSW_N;
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cd047e0410..2c9b0d2ebc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2275,8 +2275,8 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
 #include "hw/i386/apic.h"
 #endif
 
-static inline void cpu_get_tb_cpu_state(CPUX86State *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     *cs_base = env->segs[R_CS].base;
     *pc = *cs_base + env->eip;
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index b23f38c3d5..ed04027af1 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -427,10 +427,8 @@ static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 #define HW_FLAGS_EUEN_FPE   0x04
 #define HW_FLAGS_EUEN_SXE   0x08
 
-static inline void cpu_get_tb_cpu_state(CPULoongArchState *env,
-                                        target_ulong *pc,
-                                        target_ulong *cs_base,
-                                        uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
     *cs_base = 0;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 048d5aae2b..cf70282717 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -601,8 +601,8 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_TRACE          16
 #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
 
-static inline void cpu_get_tb_cpu_state(CPUM68KState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
     *cs_base = 0;
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 88324d0bc1..3525de144c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -401,8 +401,8 @@ void mb_tcg_init(void);
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
-static inline void cpu_get_tb_cpu_state(CPUMBState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
     *flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK);
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 142c55af47..a3bc646976 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1313,8 +1313,8 @@ void itc_reconfigure(struct MIPSITUState *tag);
 /* helper.c */
 target_ulong exception_resume_pc(CPUMIPSState *env);
 
-static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     *pc = env->active_tc.PC;
     *cs_base = 0;
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 20042c4332..477a3161fd 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -302,8 +302,8 @@ FIELD(TBFLAGS, CRS0, 0, 1)  /* Set if CRS == 0. */
 FIELD(TBFLAGS, U, 1, 1)     /* Overlaps CR_STATUS_U */
 FIELD(TBFLAGS, R0_0, 2, 1)  /* Set if R0 == 0. */
 
-static inline void cpu_get_tb_cpu_state(CPUNios2State *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUNios2State *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     unsigned crs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, CRS);
 
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f16e8b3274..92c38f54c2 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -367,9 +367,8 @@ static inline void cpu_set_gpr(CPUOpenRISCState *env, int i, uint32_t val)
     env->shadow_gpr[0][i] = val;
 }
 
-static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env,
-                                        target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
     *cs_base = 0;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4138a25801..94497aa115 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2508,11 +2508,11 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer);
 #define is_book3s_arch2x(ctx) (!!((ctx)->insns_flags & PPC_SEGMENT_64B))
 
 #ifdef CONFIG_DEBUG_TCG
-void cpu_get_tb_cpu_state(CPUPPCState *env, target_ulong *pc,
-                          target_ulong *cs_base, uint32_t *flags);
+void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags);
 #else
-static inline void cpu_get_tb_cpu_state(CPUPPCState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     *pc = env->nip;
     *cs_base = 0;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e3e08d315f..7bff1d47f6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -587,8 +587,8 @@ static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
     return cpu->cfg.vlen >> (sew + 3 - lmul);
 }
 
-void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
-                          target_ulong *cs_base, uint32_t *pflags);
+void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags);
 
 void riscv_cpu_update_mask(CPURISCVState *env);
 
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 555d230f24..7f03ffcfed 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -143,8 +143,8 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
 #define RX_CPU_IRQ 0
 #define RX_CPU_FIR 1
 
-static inline void cpu_get_tb_cpu_state(CPURXState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
     *cs_base = 0;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index f130c29f83..eb5b65b7d3 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -378,8 +378,8 @@ static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 #endif
 }
 
-static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     if (env->psw.addr & 1) {
         /*
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 02bfd612ea..1399d3840f 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -368,8 +368,8 @@ static inline void cpu_write_sr(CPUSH4State *env, target_ulong sr)
     env->sr = sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
 }
 
-static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
     /* For a gUSA region, notice the end of the region.  */
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 3d090e8278..95d2d0da71 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -762,8 +762,8 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_HYPER        (1 << 7)
 #define TB_FLAG_ASI_SHIFT    24
 
-static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *pflags)
+static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *pflags)
 {
     uint32_t flags;
     *pc = env->pc;
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 257fcf3cee..a50b91cc36 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -384,8 +384,8 @@ FIELD(TB_FLAGS, PRIV, 0, 2)
 void cpu_state_reset(CPUTriCoreState *s);
 void tricore_tcg_init(void);
 
-static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     uint32_t new_flags = 0;
     *pc = env->PC;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index b7a54711a6..87fe992ba6 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -727,8 +727,8 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
 
 #include "exec/cpu-all.h"
 
-static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
-        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
     *cs_base = 0;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 179847b294..4d952a6cc2 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -408,7 +408,8 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
 {
     CPUState *cpu = env_cpu(env);
     TranslationBlock *tb;
-    target_ulong cs_base, pc;
+    vaddr pc;
+    uint64_t cs_base;
     uint32_t flags, cflags;
 
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
@@ -529,7 +530,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
     TranslationBlock *tb;
-    target_ulong cs_base, pc;
+    vaddr pc;
+    uint64_t cs_base;
     uint32_t flags, cflags;
     int tb_exit;
 
@@ -942,7 +944,8 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
 
         while (!cpu_handle_interrupt(cpu, &last_tb)) {
             TranslationBlock *tb;
-            target_ulong cs_base, pc;
+            vaddr pc;
+            uint64_t cs_base;
             uint32_t flags, cflags;
 
             cpu_get_tb_cpu_state(cpu->env_ptr, &pc, &cs_base, &flags);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 03caf62459..03c49baf1c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -580,7 +580,8 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
         /* The exception probably happened in a helper.  The CPU state should
            have been saved before calling it. Fetch the PC from there.  */
         CPUArchState *env = cpu->env_ptr;
-        target_ulong pc, cs_base;
+        vaddr pc;
+        uint64_t cs_base;
         tb_page_addr_t addr;
         uint32_t flags;
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 323cadd3c8..d08c058e42 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11945,8 +11945,8 @@ static bool mve_no_pred(CPUARMState *env)
     return true;
 }
 
-void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
-                          target_ulong *cs_base, uint32_t *pflags)
+void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
 {
     CPUARMTBFlags flags;
 
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index e27f4a75a4..f380342d4d 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -218,8 +218,8 @@ void hreg_update_pmu_hflags(CPUPPCState *env)
 }
 
 #ifdef CONFIG_DEBUG_TCG
-void cpu_get_tb_cpu_state(CPUPPCState *env, target_ulong *pc,
-                          target_ulong *cs_base, uint32_t *flags)
+void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
 {
     uint32_t hflags_current = env->hflags;
     uint32_t hflags_rebuilt;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 90cef9856d..a944f25694 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -61,8 +61,8 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 #endif
 }
 
-void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
-                          target_ulong *cs_base, uint32_t *pflags)
+void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
 {
     CPUState *cs = env_cpu(env);
     RISCVCPU *cpu = RISCV_CPU(cs);
-- 
2.34.1


