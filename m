Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CADF74E101
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzL2-0003SB-5r; Mon, 10 Jul 2023 18:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzL0-0003S2-HW
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:34 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzKu-0001i3-Qo
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so51993565e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689027986; x=1691619986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2a5apNottyWIlKCx3Fnb0NFRIHlNDNa485chSeE/FA8=;
 b=vGYDwpyEiwT6bqyFHtEyNXsj55Be/8E149eTimaWEx9H42aYWc3qQWFXdqvEoK2Vqq
 hM3SeGUzNMTELYss0zGR4yZmiJxEuKpEAA+JiFuM6aU3waX0+507m3lGMvdIumUcr490
 OhUcFjFY2BiB45njmj4n3+oxyifVEQsNq1pViTDuS9bVMjNa7zlJbKjN/W8ew4QZ//z0
 V3yaJHeeyauJEzRTf8dGPQBXPeN2HnoeZQWEgsVOi4MLB0Kzhsp6elBuGW9NJBJKMwA/
 6gGrrb8ImJC2KtZVXI4PPkuqypGoBVDIOMRE4f4ig+L4w6R2nrarm7fbd5IhH4b4zsaq
 nDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689027986; x=1691619986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2a5apNottyWIlKCx3Fnb0NFRIHlNDNa485chSeE/FA8=;
 b=RRasTNhlkr1VmZk5zxo4HFZWzEWMWmVi/+Not2dDHlBCUmFgIhu6r4xysenRl4nO5x
 1Upnv8i6e2m9Ua6VY8iKNmNxiLv8o/mj6kvliS59+bAktuj/MxbKVXjP+lHknn2Gzw25
 5RTIp0sH8H8zvtTUaI7oF3kD59gwI1QA+pfGteJgcN6Gh7VftYLIbo+/43KT4ae4eYWi
 cWYAToh5LUKtHrRqspeMG6kcrGLCoZ9SFNehAol7bKVbHB72EnW5ws77fDmAiAxvQCU6
 zYkfkrJr48K32MBfPVaVga7EGLHWogio7ZKsaqgkUwGRLqcc2g3+r2A3BUxyFQm+uYxO
 iBtg==
X-Gm-Message-State: ABy/qLYj1WtpZKcOW/1svbzNTeLvnIFhYecbKOwAxHU0U3IY0Qlfu2YO
 KKsD/XhXnrS3UqrlnaSLbl8lvxD44X1tlXrFCq2Y3Q==
X-Google-Smtp-Source: APBJJlHFVrzd0XqT3ll8fBDrGc5za1WuIwycIIbV9nBF+14FlOTvODz3pjR1ValT7q6/utD/T0vkUg==
X-Received: by 2002:a1c:7914:0:b0:3f9:b1e7:8a4b with SMTP id
 l20-20020a1c7914000000b003f9b1e78a4bmr12269595wme.21.1689027985919; 
 Mon, 10 Jul 2023 15:26:25 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 f11-20020a7bc8cb000000b003fa98908014sm11482716wml.8.2023.07.10.15.26.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:26:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 02/44] target/mips: Implement Loongson CSR instructions
Date: Tue, 11 Jul 2023 00:25:29 +0200
Message-Id: <20230710222611.50978-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

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
Message-Id: <20230521214832.20145-2-jiaxun.yang@flygoat.com>
[JY:  Fixed typo in ase_lcsr_available(),
      retrict GEN_FALSE_TRANS]
[PMD: Fix meson's mips_softmmu_ss -> mips_system_ss,
      restrict AddressSpace/MemoryRegion to SysEmu]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h                    | 42 ++++++++++++++++
 target/mips/helper.h                 |  4 ++
 target/mips/internal.h               |  2 +
 target/mips/tcg/translate.h          |  1 +
 target/mips/tcg/sysemu_helper.h.inc  |  8 +++
 target/mips/tcg/lcsr.decode          | 17 +++++++
 target/mips/cpu.c                    | 10 ++++
 target/mips/tcg/lcsr_translate.c     | 75 ++++++++++++++++++++++++++++
 target/mips/tcg/op_helper.c          | 16 ++++++
 target/mips/tcg/sysemu/lcsr_helper.c | 45 +++++++++++++++++
 target/mips/tcg/translate.c          |  3 ++
 target/mips/cpu-defs.c.inc           |  9 ++++
 target/mips/tcg/meson.build          |  2 +
 target/mips/tcg/sysemu/meson.build   |  4 ++
 14 files changed, 238 insertions(+)
 create mode 100644 target/mips/tcg/lcsr.decode
 create mode 100644 target/mips/tcg/lcsr_translate.c
 create mode 100644 target/mips/tcg/sysemu/lcsr_helper.c

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index d3ee874a18..f81bd06f5e 100644
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
@@ -1156,6 +1186,12 @@ typedef struct CPUArchState {
     void *irq[8];
     struct MIPSITUState *itu;
     MemoryRegion *itc_tag; /* ITC Configuration Tags */
+
+    /* Loongson IOCSR memory */
+    struct {
+        AddressSpace as;
+        MemoryRegion mr;
+    } iocsr;
 #endif
 
     const mips_def_t *cpu_model;
@@ -1281,6 +1317,12 @@ static inline bool ase_msa_available(CPUMIPSState *env)
     return env->CP0_Config3 & (1 << CP0C3_MSAP);
 }
 
+/* Check presence of Loongson CSR instructions */
+static inline bool ase_lcsr_available(CPUMIPSState *env)
+{
+    return env->lcsr_cpucfg2 & (1 << CPUCFG2_LCSRP);
+}
+
 /* Check presence of multi-threading ASE implementation */
 static inline bool ase_mt_available(CPUMIPSState *env)
 {
diff --git a/target/mips/helper.h b/target/mips/helper.h
index de32d82e98..0f8462febb 100644
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
index 4b0031d10d..1d0c026c7d 100644
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
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 3b0498a47a..db3dc932c7 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -221,6 +221,7 @@ bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
 bool decode_ext_txx9(DisasContext *ctx, uint32_t insn);
 #if defined(TARGET_MIPS64)
+bool decode_ase_lcsr(DisasContext *ctx, uint32_t insn);
 bool decode_ext_tx79(DisasContext *ctx, uint32_t insn);
 bool decode_ext_octeon(DisasContext *ctx, uint32_t insn);
 #endif
diff --git a/target/mips/tcg/sysemu_helper.h.inc b/target/mips/tcg/sysemu_helper.h.inc
index af585b5d9c..f163af1eac 100644
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
diff --git a/target/mips/tcg/lcsr.decode b/target/mips/tcg/lcsr.decode
new file mode 100644
index 0000000000..960ef8b6f9
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
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b7119cbbb4..63da1948fd 100644
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
@@ -507,6 +509,14 @@ static void mips_cpu_initfn(Object *obj)
     cpu->count_div = clock_new(OBJECT(obj), "clk-div-count");
     env->count_clock = clock_new(OBJECT(obj), "clk-count");
     env->cpu_model = mcc->cpu_def;
+#ifndef CONFIG_USER_ONLY
+    if (mcc->cpu_def->lcsr_cpucfg2 & (1 << CPUCFG2_LCSRP)) {
+        memory_region_init_io(&env->iocsr.mr, OBJECT(cpu), NULL,
+                                env, "iocsr", UINT64_MAX);
+        address_space_init(&env->iocsr.as,
+                            &env->iocsr.mr, "IOCSR");
+    }
+#endif
 }
 
 static char *mips_cpu_type_name(const char *cpu_model)
diff --git a/target/mips/tcg/lcsr_translate.c b/target/mips/tcg/lcsr_translate.c
new file mode 100644
index 0000000000..9f2a5f4a37
--- /dev/null
+++ b/target/mips/tcg/lcsr_translate.c
@@ -0,0 +1,75 @@
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
+    gen_load_gpr(val, a->rd);
+    func(cpu_env, addr, val);
+
+    return true;
+}
+
+TRANS(RDCSR, gen_rdcsr, gen_helper_lcsr_rdcsr)
+TRANS(DRDCSR, gen_rdcsr, gen_helper_lcsr_drdcsr)
+TRANS(WRCSR, gen_wrcsr, gen_helper_lcsr_wrcsr)
+TRANS(DWRCSR, gen_wrcsr, gen_helper_lcsr_dwrcsr)
+#else
+#define GEN_FALSE_TRANS(name)   \
+static bool trans_##name(DisasContext *ctx, arg_##name * a)  \
+{   \
+    return false;   \
+}
+
+GEN_FALSE_TRANS(RDCSR)
+GEN_FALSE_TRANS(DRDCSR)
+GEN_FALSE_TRANS(WRCSR)
+GEN_FALSE_TRANS(DWRCSR)
+#endif
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index ef3dafcbb3..98935b5e64 100644
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
index 0000000000..942143d209
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
+    return address_space_ldl(&env->iocsr.as, r_addr,
+                             GET_MEMTXATTRS(env), NULL);
+}
+
+uint64_t helper_lcsr_drdcsr(CPUMIPSState *env, target_ulong r_addr)
+{
+    return address_space_ldq(&env->iocsr.as, r_addr,
+                             GET_MEMTXATTRS(env), NULL);
+}
+
+void helper_lcsr_wrcsr(CPUMIPSState *env, target_ulong w_addr,
+                      target_ulong val)
+{
+    address_space_stl(&env->iocsr.as, w_addr,
+                      val, GET_MEMTXATTRS(env), NULL);
+}
+
+void helper_lcsr_dwrcsr(CPUMIPSState *env, target_ulong w_addr,
+                      target_ulong val)
+{
+    address_space_stq(&env->iocsr.as, w_addr,
+                      val, GET_MEMTXATTRS(env), NULL);
+}
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 74af91e4f5..7abbb0b5e2 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15352,6 +15352,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         return;
     }
 #if defined(TARGET_MIPS64)
+    if (ase_lcsr_available(env) && decode_ase_lcsr(ctx, ctx->opcode)) {
+        return;
+    }
     if (cpu_supports_isa(env, INSN_OCTEON) && decode_ext_octeon(ctx, ctx->opcode)) {
         return;
     }
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index d45f245a67..167c96cb27 100644
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
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index 7ee969ec8f..ea7fb582f2 100644
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
diff --git a/target/mips/tcg/sysemu/meson.build b/target/mips/tcg/sysemu/meson.build
index 43b35b3803..ec665a4b1e 100644
--- a/target/mips/tcg/sysemu/meson.build
+++ b/target/mips/tcg/sysemu/meson.build
@@ -4,3 +4,7 @@ mips_system_ss.add(files(
   'special_helper.c',
   'tlb_helper.c',
 ))
+
+mips_system_ss.add(when: 'TARGET_MIPS64', if_true: files(
+  'lcsr_helper.c',
+))
-- 
2.38.1


