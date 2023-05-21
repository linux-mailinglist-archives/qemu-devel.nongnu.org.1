Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE7470B0F9
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 23:50:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0qvB-0000WQ-Dg; Sun, 21 May 2023 17:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0qv9-0000Vu-RF
 for qemu-devel@nongnu.org; Sun, 21 May 2023 17:48:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0qv7-00067m-Bc
 for qemu-devel@nongnu.org; Sun, 21 May 2023 17:48:55 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id BADC15C00BA;
 Sun, 21 May 2023 17:48:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Sun, 21 May 2023 17:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1684705732; x=
 1684792132; bh=LFTT9qS6dpROvKZufkeWxjXRhGNZwh6mbVfaRluSDiA=; b=m
 83uFx8RveYwQQrdMyWfGejS24Fmo9NW/eqvZ6vk+YrgsBZkgRmZRkAQEhS7QLyyL
 TzbNKC+NGS1+WrXeB4/yJkpqzlsQWh9o3uKDhxyxW4j3GLkxkfKekl7T1+TBPwdt
 pvnlCqGErSXCOdUhPJHT5kLWSTNnDyqJxBB7+cMrox76l8YglZyj5K5hbPupyRkW
 6r7qNXWqaYx/ELiYb7IOkwDu+DZa5VFnWGIr8RLIuRdIrLTEFbhQLlEWEEv3ftCf
 7Ar2OJR/iLigF22c8C3+Y7Iu32CcrxqCTN1uYWHXgH4MGeAdXU75QdwaYX7nVceE
 flrP5dpUPzP+V/npkls2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684705732; x=
 1684792132; bh=LFTT9qS6dpROvKZufkeWxjXRhGNZwh6mbVfaRluSDiA=; b=i
 VDPB4zbJqv/NzIq30TgruY42vVKJnUnANOwrX9F/5tP649pkeBYmuvJYpdT9CYvr
 RXuWxg9MkicztPdRWf6AUuvQ2o3wPmBqXPkTJmzWW/pqaZ8kYNzPlTqkUmaOav2P
 6EE7DsYzMc36XKBEj78hN8gWPj0MgwAlav9SLFfDx0XYtyXuNOwAu4LE9M+kjn5p
 F/fteKTNQSOaH7nTiXrO5tDE2ixrB4C1F+sSCU2wjQAd3g4q8IDXJRN8LQDNLsty
 niIySVKbI4JWI2DUH2OCxSzaJVAlRS25+z3bUnkUJtJqQj2Zz3q7erHYQHt5ilg2
 RTyxhHmCE0XFEiMGjFZeg==
X-ME-Sender: <xms:xJFqZAWRtukViakmtNze5lZnXoBjQ8x7ZjkHIaNqJwSzvpYj9Lpt0A>
 <xme:xJFqZElZmNdroa0epiJpb_jeDTN47H1msgr02y-zatwC3xpbRKF2MKxfs8yWKelLG
 _GX2UM4omrNt51m_NY>
X-ME-Received: <xmr:xJFqZEbywUASBWH03KC7dg_WNAxbehWd3ThL0CVenVSS809WugPrrvaKt4sk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejtddgtddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
 ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
 dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomh
X-ME-Proxy: <xmx:xJFqZPV3qiOdRgD2BNEbWQ-tmZHTyCJKcvrGpGaKrXYnxGbIWBxO-g>
 <xmx:xJFqZKn1ep9MmMhu2tUFmJBBwSHjsmYlPww_0XPdRbgFOkbXVMOaSw>
 <xmx:xJFqZEcLw-ZziZIuxMbWELPg5HluADl1eg-RARHyLnHyC9DVjODwEQ>
 <xmx:xJFqZLCuSiEVY4mzt4UKU27KfiJi87_pBpejZnLTrNPCQbthlSPffg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 17:48:51 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, philmd@linaro.org,
 chenhuacai@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/2] target/mips: Implement Loongson CSR instructions
Date: Sun, 21 May 2023 22:48:31 +0100
Message-Id: <20230521214832.20145-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
References: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.27; envelope-from=jiaxun.yang@flygoat.com;
 helo=out3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Loongson introduced CSR instructions since 3A4000, which looks
similar to IOCSR and CPUCFG instructions we seen in LoongArch.

Unfortunately we don't have much document about those instructions,
bit fields of CPUCFG instructions and IOCSR registers can be found
at 3A4000's user manual, while instruction encodings can be found
at arch/mips/include/asm/mach-loongson64/loongson_regs.h from
Linux Kernel.

Our predefined CPUCFG bits are differ from actual 3A4000, since
we can't emulate all CPUCFG features present in 3A4000 for now,
we just enable bits for what we have in TCG.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/cpu-defs.c.inc           |  9 ++++
 target/mips/cpu.c                    |  8 ++++
 target/mips/cpu.h                    | 40 ++++++++++++++++
 target/mips/helper.h                 |  4 ++
 target/mips/internal.h               |  2 +
 target/mips/tcg/lcsr.decode          | 17 +++++++
 target/mips/tcg/lcsr_translate.c     | 69 ++++++++++++++++++++++++++++
 target/mips/tcg/meson.build          |  2 +
 target/mips/tcg/op_helper.c          | 16 +++++++
 target/mips/tcg/sysemu/lcsr_helper.c | 45 ++++++++++++++++++
 target/mips/tcg/sysemu/meson.build   |  4 ++
 target/mips/tcg/sysemu_helper.h.inc  |  8 ++++
 target/mips/tcg/translate.c          |  3 ++
 target/mips/tcg/translate.h          |  7 +++
 14 files changed, 234 insertions(+)
 create mode 100644 target/mips/tcg/lcsr.decode
 create mode 100644 target/mips/tcg/lcsr_translate.c
 create mode 100644 target/mips/tcg/sysemu/lcsr_helper.c

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index d45f245a6718..167c96cb2748 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -895,6 +895,15 @@ const mips_def_t mips_defs[] =
         .CP1_fcr31 = 0,
         .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .MSAIR = (0x01 << MSAIR_ProcID) | (0x40 << MSAIR_Rev),
+        .lcsr_cpucfg1 = (1 << CPUCFG1_FP) | (2 << CPUCFG1_FPREV) |
+                    (1 << CPUCFG1_MSA1) | (1 << CPUCFG1_LSLDR0) |
+                    (1 << CPUCFG1_LSPERF) | (1 << CPUCFG1_LSPERFX) |
+                    (1 << CPUCFG1_LSSYNCI) | (1 << CPUCFG1_LLEXC) |
+                    (1 << CPUCFG1_SCRAND) | (1 << CPUCFG1_MUALP) |
+                    (1 << CPUCFG1_KMUALEN) | (1 << CPUCFG1_ITLBT) |
+                    (1 << CPUCFG1_SFBP) | (1 << CPUCFG1_CDMAP),
+        .lcsr_cpucfg2 = (1 << CPUCFG2_LEXT1) | (1 << CPUCFG2_LCSRP) |
+                    (1 << CPUCFG2_LDISBLIKELY),
         .SEGBITS = 48,
         .PABITS = 48,
         .insn_flags = CPU_MIPS64R2 | INSN_LOONGSON3A |
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b7119cbbb459..e675b9178192 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -244,6 +244,8 @@ static void mips_cpu_reset_hold(Object *obj)
     env->CP0_PageGrain_rw_bitmask = env->cpu_model->CP0_PageGrain_rw_bitmask;
     env->CP0_PageGrain = env->cpu_model->CP0_PageGrain;
     env->CP0_EBaseWG_rw_bitmask = env->cpu_model->CP0_EBaseWG_rw_bitmask;
+    env->lcsr_cpucfg1 = env->cpu_model->lcsr_cpucfg1;
+    env->lcsr_cpucfg2 = env->cpu_model->lcsr_cpucfg2;
     env->active_fpu.fcr0 = env->cpu_model->CP1_fcr0;
     env->active_fpu.fcr31_rw_bitmask = env->cpu_model->CP1_fcr31_rw_bitmask;
     env->active_fpu.fcr31 = env->cpu_model->CP1_fcr31;
@@ -507,6 +509,12 @@ static void mips_cpu_initfn(Object *obj)
     cpu->count_div = clock_new(OBJECT(obj), "clk-div-count");
     env->count_clock = clock_new(OBJECT(obj), "clk-count");
     env->cpu_model = mcc->cpu_def;
+    if (mcc->cpu_def->lcsr_cpucfg2 & (1 << CPUCFG2_LCSRP)) {
+        memory_region_init_io(&env->system_iocsr, OBJECT(cpu), NULL,
+                                env, "iocsr", UINT64_MAX);
+        address_space_init(&env->address_space_iocsr,
+                            &env->system_iocsr, "IOCSR");
+    }
 }
 
 static char *mips_cpu_type_name(const char *cpu_model)
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 1b8107b0af86..f63b128ff3d3 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -3,6 +3,9 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#ifndef CONFIG_USER_ONLY
+#include "exec/memory.h"
+#endif
 #include "fpu/softfloat-types.h"
 #include "hw/clock.h"
 #include "mips-defs.h"
@@ -1068,6 +1071,33 @@ typedef struct CPUArchState {
  */
     int32_t CP0_DESAVE;
     target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
+/*
+ * Loongson CSR CPUCFG registers
+ */
+    uint32_t lcsr_cpucfg1;
+#define CPUCFG1_FP     0
+#define CPUCFG1_FPREV  1
+#define CPUCFG1_MMI    4
+#define CPUCFG1_MSA1   5
+#define CPUCFG1_MSA2   6
+#define CPUCFG1_LSLDR0 16
+#define CPUCFG1_LSPERF 17
+#define CPUCFG1_LSPERFX 18
+#define CPUCFG1_LSSYNCI 19
+#define CPUCFG1_LLEXC   20
+#define CPUCFG1_SCRAND  21
+#define CPUCFG1_MUALP   25
+#define CPUCFG1_KMUALEN 26
+#define CPUCFG1_ITLBT   27
+#define CPUCFG1_SFBP    29
+#define CPUCFG1_CDMAP   30
+    uint32_t lcsr_cpucfg2;
+#define CPUCFG2_LEXT1   0
+#define CPUCFG2_LEXT2   1
+#define CPUCFG2_LEXT3   2
+#define CPUCFG2_LSPW    3
+#define CPUCFG2_LCSRP   27
+#define CPUCFG2_LDISBLIKELY 28
 
     /* We waste some space so we can handle shadow registers like TCs. */
     TCState tcs[MIPS_SHADOW_SET_MAX];
@@ -1162,6 +1192,10 @@ typedef struct CPUArchState {
     QEMUTimer *timer; /* Internal timer */
     Clock *count_clock; /* CP0_Count clock */
     target_ulong exception_base; /* ExceptionBase input to the core */
+
+    /* Loongson IOCSR memory */
+    AddressSpace address_space_iocsr;
+    MemoryRegion system_iocsr;
 } CPUMIPSState;
 
 /**
@@ -1281,6 +1315,12 @@ static inline bool ase_msa_available(CPUMIPSState *env)
     return env->CP0_Config3 & (1 << CP0C3_MSAP);
 }
 
+/* Check presence of Loongson CSR instructions */
+static inline bool ase_lcsr_available(CPUMIPSState *env)
+{
+    return env->lcsr_cpucfg1 & (1 << CPUCFG2_LCSRP);
+}
+
 /* Check presence of multi-threading ASE implementation */
 static inline bool ase_mt_available(CPUMIPSState *env)
 {
diff --git a/target/mips/helper.h b/target/mips/helper.h
index de32d82e980e..0f8462febb57 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -196,6 +196,10 @@ DEF_HELPER_1(rdhwr_xnp, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
+#ifdef TARGET_MIPS64
+DEF_HELPER_FLAGS_2(lcsr_cpucfg, TCG_CALL_NO_RWG_SE, tl, env, tl)
+#endif
+
 /* Loongson multimedia functions.  */
 DEF_HELPER_FLAGS_2(paddsh, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(paddush, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 4b0031d10d34..1d0c026c7d0d 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -79,6 +79,8 @@ struct mips_def_t {
     int32_t CP0_PageGrain_rw_bitmask;
     int32_t CP0_PageGrain;
     target_ulong CP0_EBaseWG_rw_bitmask;
+    uint32_t lcsr_cpucfg1;
+    uint32_t lcsr_cpucfg2;
     uint64_t insn_flags;
     enum mips_mmu_types mmu_type;
     int32_t SAARP;
diff --git a/target/mips/tcg/lcsr.decode b/target/mips/tcg/lcsr.decode
new file mode 100644
index 000000000000..960ef8b6f99b
--- /dev/null
+++ b/target/mips/tcg/lcsr.decode
@@ -0,0 +1,17 @@
+# Loongson CSR instructions
+#
+# Copyright (C) 2023 Jiaxun Yang <jiaxun.yang@flygoat.com>
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+
+&r           rs rt rd sa
+
+@rs_rd       ...... rs:5 ..... rd:5 ..... ...... &r rt=0 sa=0
+
+CPUCFG       110010 ..... 01000 ..... 00100 011000 @rs_rd
+
+RDCSR        110010 ..... 00000 ..... 00100 011000 @rs_rd
+WRCSR        110010 ..... 00001 ..... 00100 011000 @rs_rd
+DRDCSR       110010 ..... 00010 ..... 00100 011000 @rs_rd
+DWRCSR       110010 ..... 00011 ..... 00100 011000 @rs_rd
diff --git a/target/mips/tcg/lcsr_translate.c b/target/mips/tcg/lcsr_translate.c
new file mode 100644
index 000000000000..0ca6f2e7f8db
--- /dev/null
+++ b/target/mips/tcg/lcsr_translate.c
@@ -0,0 +1,69 @@
+/*
+ * Loongson CSR instructions translation routines
+ *
+ *  Copyright (c) 2023 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "exec/helper-gen.h"
+#include "translate.h"
+
+/* Include the auto-generated decoder.  */
+#include "decode-lcsr.c.inc"
+
+static bool trans_CPUCFG(DisasContext *ctx, arg_CPUCFG *a)
+{
+    TCGv dest = tcg_temp_new();
+    TCGv src1 = tcg_temp_new();
+
+    gen_load_gpr(src1, a->rs);
+    gen_helper_lcsr_cpucfg(dest, cpu_env, src1);
+    gen_store_gpr(dest, a->rd);
+
+    return true;
+}
+
+#ifndef CONFIG_USER_ONLY
+static bool gen_rdcsr(DisasContext *ctx, arg_r *a,
+                        void (*func)(TCGv, TCGv_ptr, TCGv))
+{
+    TCGv dest = tcg_temp_new();
+    TCGv src1 = tcg_temp_new();
+
+    check_cp0_enabled(ctx);
+    gen_load_gpr(src1, a->rs);
+    func(dest, cpu_env, src1);
+    gen_store_gpr(dest, a->rd);
+
+    return true;
+}
+
+static bool gen_wrcsr(DisasContext *ctx, arg_r *a,
+                        void (*func)(TCGv_ptr, TCGv, TCGv))
+{
+    TCGv val = tcg_temp_new();
+    TCGv addr = tcg_temp_new();
+
+    check_cp0_enabled(ctx);
+    gen_load_gpr(addr, a->rs);
+    func(cpu_env, addr, val);
+    gen_store_gpr(val, a->rd);
+
+    return true;
+}
+
+TRANS(RDCSR, gen_rdcsr, gen_helper_lcsr_rdcsr)
+TRANS(DRDCSR, gen_rdcsr, gen_helper_lcsr_drdcsr)
+TRANS(WRCSR, gen_wrcsr, gen_helper_lcsr_wrcsr)
+TRANS(DWRCSR, gen_wrcsr, gen_helper_lcsr_wrcsr)
+#else
+GEN_FALSE_TRANS(RDCSR)
+GEN_FALSE_TRANS(DRDCSR)
+GEN_FALSE_TRANS(WRCSR)
+GEN_FALSE_TRANS(DWRCSR)
+#endif
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index 7ee969ec8f23..ea7fb582f2ab 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -4,6 +4,7 @@ gen = [
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
   decodetree.process('vr54xx.decode', extra_args: '--decode=decode_ext_vr54xx'),
   decodetree.process('octeon.decode', extra_args: '--decode=decode_ext_octeon'),
+  decodetree.process('lcsr.decode', extra_args: '--decode=decode_ase_lcsr'),
 ]
 
 mips_ss.add(gen)
@@ -26,6 +27,7 @@ mips_ss.add(files(
 mips_ss.add(when: 'TARGET_MIPS64', if_true: files(
   'tx79_translate.c',
   'octeon_translate.c',
+  'lcsr_translate.c',
 ), if_false: files(
   'mxu_translate.c',
 ))
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index ef3dafcbb3fd..98935b5e6418 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -257,6 +257,22 @@ void helper_pmon(CPUMIPSState *env, int function)
     }
 }
 
+#ifdef TARGET_MIPS64
+target_ulong helper_lcsr_cpucfg(CPUMIPSState *env, target_ulong rs)
+{
+    switch (rs) {
+    case 0:
+        return env->CP0_PRid;
+    case 1:
+        return env->lcsr_cpucfg1;
+    case 2:
+        return env->lcsr_cpucfg2;
+    default:
+        return 0;
+    }
+}
+#endif
+
 #if !defined(CONFIG_USER_ONLY)
 
 void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/mips/tcg/sysemu/lcsr_helper.c b/target/mips/tcg/sysemu/lcsr_helper.c
new file mode 100644
index 000000000000..1152695ba2c1
--- /dev/null
+++ b/target/mips/tcg/sysemu/lcsr_helper.c
@@ -0,0 +1,45 @@
+/*
+ * Loongson CSR instructions translation routines
+ *
+ *  Copyright (c) 2023 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "cpu.h"
+#include "internal.h"
+#include "qemu/host-utils.h"
+#include "exec/helper-proto.h"
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+
+#define GET_MEMTXATTRS(cas) \
+        ((MemTxAttrs){.requester_id = env_cpu(cas)->cpu_index})
+
+uint64_t helper_lcsr_rdcsr(CPUMIPSState *env, target_ulong r_addr)
+{
+    return address_space_ldl(&env->address_space_iocsr, r_addr,
+                             GET_MEMTXATTRS(env), NULL);
+}
+
+uint64_t helper_lcsr_drdcsr(CPUMIPSState *env, target_ulong r_addr)
+{
+    return address_space_ldq(&env->address_space_iocsr, r_addr,
+                             GET_MEMTXATTRS(env), NULL);
+}
+
+void helper_lcsr_wrcsr(CPUMIPSState *env, target_ulong w_addr,
+                      target_ulong val)
+{
+    address_space_stl(&env->address_space_iocsr, w_addr,
+                      val, GET_MEMTXATTRS(env), NULL);
+}
+
+void helper_lcsr_dwrcsr(CPUMIPSState *env, target_ulong w_addr,
+                      target_ulong val)
+{
+    address_space_stq(&env->address_space_iocsr, w_addr,
+                      val, GET_MEMTXATTRS(env), NULL);
+}
diff --git a/target/mips/tcg/sysemu/meson.build b/target/mips/tcg/sysemu/meson.build
index 4da2c577b203..098b6069159b 100644
--- a/target/mips/tcg/sysemu/meson.build
+++ b/target/mips/tcg/sysemu/meson.build
@@ -4,3 +4,7 @@ mips_softmmu_ss.add(files(
   'special_helper.c',
   'tlb_helper.c',
 ))
+
+mips_softmmu_ss.add(when: 'TARGET_MIPS64', if_true: files(
+  'lcsr_helper.c',
+))
diff --git a/target/mips/tcg/sysemu_helper.h.inc b/target/mips/tcg/sysemu_helper.h.inc
index af585b5d9c13..f163af1eac75 100644
--- a/target/mips/tcg/sysemu_helper.h.inc
+++ b/target/mips/tcg/sysemu_helper.h.inc
@@ -181,3 +181,11 @@ DEF_HELPER_1(eret, void, env)
 DEF_HELPER_1(eretnc, void, env)
 DEF_HELPER_1(deret, void, env)
 DEF_HELPER_3(cache, void, env, tl, i32)
+
+#ifdef TARGET_MIPS64
+/* Longson CSR */
+DEF_HELPER_2(lcsr_rdcsr, i64, env, tl)
+DEF_HELPER_2(lcsr_drdcsr, i64, env, tl)
+DEF_HELPER_3(lcsr_wrcsr, void, env, tl, tl)
+DEF_HELPER_3(lcsr_dwrcsr, void, env, tl, tl)
+#endif
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index a6ca2e5a3b96..45558899229a 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15361,6 +15361,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         return;
     }
 #if defined(TARGET_MIPS64)
+    if (ase_lcsr_available(env) && decode_ase_lcsr(ctx, ctx->opcode)) {
+        return;
+    }
     if (cpu_supports_isa(env, INSN_OCTEON) && decode_ext_octeon(ctx, ctx->opcode)) {
         return;
     }
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 69f85841d213..99f7a404ba7e 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -218,6 +218,7 @@ bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
 bool decode_ext_txx9(DisasContext *ctx, uint32_t insn);
 #if defined(TARGET_MIPS64)
+bool decode_ase_lcsr(DisasContext *ctx, uint32_t insn);
 bool decode_ext_tx79(DisasContext *ctx, uint32_t insn);
 bool decode_ext_octeon(DisasContext *ctx, uint32_t insn);
 #endif
@@ -231,6 +232,12 @@ bool decode_ext_vr54xx(DisasContext *ctx, uint32_t insn);
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
     { return FUNC(ctx, a, __VA_ARGS__); }
 
+#define GEN_FALSE_TRANS(name)   \
+static bool trans_##name(DisasContext *ctx, arg_##name * a)  \
+{   \
+    return false;   \
+}
+
 static inline bool cpu_is_bigendian(DisasContext *ctx)
 {
     return extract32(ctx->CP0_Config0, CP0C0_BE, 1);
-- 
2.39.2 (Apple Git-143)


