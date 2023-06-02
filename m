Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E17201DE
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53j8-0004cE-Mk; Fri, 02 Jun 2023 08:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1q53ij-0004ZW-Ku
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:17:32 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1q53ig-0000zw-DQ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:17:29 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f3a9ad31dbso2682908e87.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685708243; x=1688300243; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vdvdvagm10klshIywfqGrcjO68dSh2+XkfMXwLcC6EA=;
 b=gPX5JJq29p5/UtZinWo1S3h4HRnbGvZdMARdLAx9BOmT/JszJcAhJb0YnlnvPbDPN1
 CVIYo3Wwb/ch/3NFoz2niLWwFFnp6TNF3UbOdN63IgNWqv4QzpRVh1Hqljjt8RbqDliq
 AwGXsBPbknAYElGOnU+K1Ct/IMMpcSOydXlvyPhqO7beDJMGjBgbyBHNJt85+QNJI+42
 w17FsknVj260Aa8zAgz+hrMSXkedxYIou5+Lr6VkhIO8TRgykck+k/yOA7wYtoJWxt3R
 O6DZdXnzoHg+E6PdxN/dgvufOVDKmVpLcvgziWGE6dAoj2xfUsTOfgOJsW9reJq14bn8
 EGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685708243; x=1688300243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vdvdvagm10klshIywfqGrcjO68dSh2+XkfMXwLcC6EA=;
 b=cMYwMxFfl+aYwHCtRB0MtjWF7Qh5guoVeH5J3kb/RM8nolEmnhBQnHuAh2jpt7Mm4V
 /rQtkIevq+igiJ1PDjTP5ofu9QdtoBd7hQeDQX5szcbDkHBkYdnDQgxksaeNAgMtX5IJ
 My5P3gXzUNynSprFRE/ijbn15SsN7fxjy7kFO25q/bT1FxcwW6v1a3u+97fQ/Gf9R/wr
 xh13FYpXiFrbJE09HYni9fS3/DIYNBEON8kymvFOiTdaG00VDGeZYqm6WzM5k/xMTPuK
 4Y3L/jGlO28F3hxhECN+y2Rh4psMpLLEqBUfa7RK5QLZjUaBkZzZaP3rylK8xyqkKVK2
 i3Eg==
X-Gm-Message-State: AC+VfDxK6S8KCY/owbObAHoVrfXo40xZyClN0yxphw3WSNG7t+kTbOBk
 NSNmQDRztW8Q0fsr2SBQFHBMc6kHdAkMxe9/4JIJjA==
X-Google-Smtp-Source: ACHHUZ4kgSIpupUGRB5fxm3Pa59AWP13xjKstPjpwsXQcM/LoXt+FNYv/06IxcQWtQlmYk5CLvkoKg==
X-Received: by 2002:ac2:51a8:0:b0:4f2:53f6:d4bf with SMTP id
 f8-20020ac251a8000000b004f253f6d4bfmr1357130lfk.48.1685708243584; 
 Fri, 02 Jun 2023 05:17:23 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 z16-20020a7bc7d0000000b003f605814850sm5391847wmk.37.2023.06.02.05.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 05:17:23 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Rob Bradford <rbradford@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/2] target/riscv: Add Zacas ISA extension support
Date: Fri,  2 Jun 2023 13:16:39 +0100
Message-Id: <20230602121638.36342-2-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602121638.36342-1-rbradford@rivosinc.com>
References: <20230602121638.36342-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=rbradford@rivosinc.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This commit adds support for the the amocas.{w,d,q} instructions behind
a new property to enable that instruction.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 target/riscv/cpu.c                          |   4 +
 target/riscv/cpu.h                          |   1 +
 target/riscv/insn32.decode                  |   5 +
 target/riscv/insn_trans/trans_rvzacas.c.inc | 146 ++++++++++++++++++++
 target/riscv/translate.c                    |   1 +
 5 files changed, 157 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzacas.c.inc

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index db0875fb43..e99833eb4a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -82,6 +82,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
+    ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfh, PRIV_VERSION_1_11_0, ext_zfh),
     ISA_EXT_DATA_ENTRY(zfhmin, PRIV_VERSION_1_11_0, ext_zfhmin),
@@ -1604,6 +1605,9 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("x-zvfh", RISCVCPU, cfg.ext_zvfh, false),
     DEFINE_PROP_BOOL("x-zvfhmin", RISCVCPU, cfg.ext_zvfhmin, false),
 
+    /* Atomic CAS (Zacas) */
+    DEFINE_PROP_BOOL("x-zacas", RISCVCPU, cfg.ext_zacas, false),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de7e43126a..ac4d9e8e9c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -436,6 +436,7 @@ struct RISCVCPUConfig {
     bool ext_smaia;
     bool ext_ssaia;
     bool ext_sscofpmf;
+    bool ext_zacas;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
 
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 73d5d1b045..97d17ee520 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -255,6 +255,11 @@ amomax_d   10100 . . ..... ..... 011 ..... 0101111 @atom_st
 amominu_d  11000 . . ..... ..... 011 ..... 0101111 @atom_st
 amomaxu_d  11100 . . ..... ..... 011 ..... 0101111 @atom_st
 
+# *** Zacas Extension
+amocas_w   00101 . . ..... ..... 010 ..... 0101111 @atom_st
+amocas_d   00101 . . ..... ..... 011 ..... 0101111 @atom_st
+amocas_q   00101 . . ..... ..... 100 ..... 0101111 @atom_st
+
 # *** RV32F Standard Extension ***
 flw        ............   ..... 010 ..... 0000111 @i
 fsw        .......  ..... ..... 010 ..... 0100111 @s
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
new file mode 100644
index 0000000000..3f1b58ee8a
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -0,0 +1,146 @@
+/*
+ * RISC-V translation routines for Zacas extension
+ *
+ * Copyright (c) 2023 Rivos Inc
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_ZACAS(ctx) do {                 \
+    if (!ctx->cfg_ptr->ext_zacas) {             \
+        return false;                           \
+    }                                           \
+} while (0)
+
+static bool amocas_tl(DisasContext *ctx, arg_atomic *a, MemOp mop)
+{
+    TCGv retv = dest_gpr(ctx, a->rd);
+    TCGv addr = get_address(ctx, a->rs1, 0);
+    TCGv newv = get_gpr(ctx, a->rs2, EXT_ZERO);
+    TCGv cmpv = get_gpr(ctx, a->rd, EXT_ZERO);
+
+    decode_save_opc(ctx);
+    tcg_gen_atomic_cmpxchg_tl(retv, addr, cmpv, newv, ctx->mem_idx, mop);
+    gen_set_gpr(ctx, a->rd, retv);
+
+    return true;
+}
+
+#if TARGET_LONG_BITS == 32
+static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)
+{
+    REQUIRE_ZACAS(ctx);
+    return amocas_tl(ctx, a, MO_TESL | MO_ALIGN);
+}
+#else
+static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_ZACAS(ctx);
+    ctx->ol = MXL_RV32;
+    return amocas_tl(ctx, a, MO_TESL | MO_ALIGN);
+}
+#endif
+
+#if TARGET_LONG_BITS == 32
+static bool trans_amocas_d(DisasContext *ctx, arg_amocas_w *a)
+{
+    TCGv_i64 retv, newv, cmpv;
+    TCGv_i32 cmpv_l, cmpv_h, newv_l, newv_h;
+    TCGv addr;
+
+    REQUIRE_ZACAS(ctx);
+
+    if (a->rd % 2 == 1 || a->rs2 % 2 == 1) {
+        return false;
+    }
+
+    addr = get_address(ctx, a->rs1, 0);
+    cmpv_l = get_gpr(ctx, a->rd, 0);
+    cmpv_h = a->rd == 0 ? get_gpr(ctx, 0, 0) : get_gpr(ctx, a->rd + 1, 0);
+    cmpv = tcg_temp_new_i64();
+    tcg_gen_concat_i32_i64(cmpv, cmpv_l, cmpv_h);
+    newv_l = get_gpr(ctx, a->rs2, 0);
+    newv_h = a->rs2 == 0 ? get_gpr(ctx, 0, 0) : get_gpr(ctx, a->rs2 + 1, 0);
+    newv = tcg_temp_new_i64();
+    tcg_gen_concat_i32_i64(newv, newv_l, newv_h);
+    retv = tcg_temp_new_i64();
+
+    decode_save_opc(ctx);
+    tcg_gen_atomic_cmpxchg_i64(retv, addr, cmpv, newv, ctx->mem_idx,
+                               MO_TESQ | MO_ALIGN);
+
+    if (a->rd != 0) {
+        TCGv_i32 retv_l = tcg_temp_new_i32();
+        TCGv_i32 retv_h = tcg_temp_new_i32();
+        tcg_gen_extr_i64_i32(retv_l, retv_h, retv);
+        gen_set_gpr(ctx, a->rd, retv_l);
+        gen_set_gpr(ctx, a->rd + 1, retv_h);
+    }
+
+    return true;
+}
+#else
+static bool trans_amocas_d(DisasContext *ctx, arg_amocas_w *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_ZACAS(ctx);
+    return amocas_tl(ctx, a, MO_TESQ | MO_ALIGN);
+}
+#endif
+
+#if TARGET_LONG_BITS == 32
+static bool trans_amocas_q(DisasContext *ctx, arg_amocas_w *a)
+{
+    return false;
+}
+#else
+static bool trans_amocas_q(DisasContext *ctx, arg_amocas_w *a)
+{
+    TCGv_i128 retv, newv, cmpv;
+    TCGv_i64 cmpv_l, cmpv_h, newv_l, newv_h;
+    TCGv addr;
+
+    REQUIRE_64BIT(ctx);
+    REQUIRE_ZACAS(ctx);
+
+    if (a->rd % 2 == 1 || a->rs2 % 2 == 1) {
+        return false;
+    }
+
+    addr = get_address(ctx, a->rs1, 0);
+    cmpv_l = get_gpr(ctx, a->rd, 0);
+    cmpv_h = a->rd == 0 ? get_gpr(ctx, 0, 0) : get_gpr(ctx, a->rd + 1, 0);
+    cmpv = tcg_temp_new_i128();
+    tcg_gen_concat_i64_i128(cmpv, cmpv_l, cmpv_h);
+    newv_l = get_gpr(ctx, a->rs2, 0);
+    newv_h = a->rs2 == 0 ? get_gpr(ctx, 0, 0) : get_gpr(ctx, a->rs2 + 1, 0);
+    newv = tcg_temp_new_i128();
+    tcg_gen_concat_i64_i128(newv, newv_l, newv_h);
+    retv = tcg_temp_new_i128();
+
+    decode_save_opc(ctx);
+    tcg_gen_atomic_cmpxchg_i128(retv, addr, cmpv, newv, ctx->mem_idx,
+                                MO_TEUO | MO_ALIGN);
+
+    if (a->rd != 0) {
+        TCGv_i64 retv_l = tcg_temp_new_i64();
+        TCGv_i64 retv_h = tcg_temp_new_i64();
+        tcg_gen_extr_i128_i64(retv_l, retv_h, retv);
+        gen_set_gpr(ctx, a->rd, retv_l);
+        gen_set_gpr(ctx, a->rd + 1, retv_h);
+    }
+
+    return true;
+}
+#endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 928da0d3f0..55438f5ebf 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1074,6 +1074,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvv.c.inc"
 #include "insn_trans/trans_rvb.c.inc"
 #include "insn_trans/trans_rvzicond.c.inc"
+#include "insn_trans/trans_rvzacas.c.inc"
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
 #include "insn_trans/trans_rvzfh.c.inc"
-- 
2.40.1


