Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6E682958A
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:00:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURo-0006V1-Ec; Wed, 10 Jan 2024 04:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQr-0004Vb-JP
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:32 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQo-000458-Qt
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:28 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bbc755167fso3576566b6e.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877164; x=1705481964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clFhRyKOA0pSu/+l5L0nBfk45kGRHvF3FLF32sssB6M=;
 b=fLaJXhmOkhezNzJhiU2cdJO4QtZWe7DIvLC4/t0Ct5Ba98kld+r24mPSBgfDMA2M8M
 0C07IijCpZfFLzAgKPZnzlrUcUUZWBcRgmJK+VGq57UXvN/cI6JHV3QXHF+/TBcfLYqP
 I3o+xHjsTJe7H8b2IHo4F6GjWBDF7s008n7hffc1hQy/QvIkukN2lEWLfccmUNDe2C4h
 ishsh6W7viIsqtFNThgbk8AIfUdiLeR37FKb3phEbM3VHYzPJN+KiC0XcP4ZbfnuzFxO
 ud7HOIYfN+tMjS5Ky7MbiWLedey52QsYiqN/aixDmR+6iQgypJ5RpL+ToZr1R0EdkUdw
 CAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877164; x=1705481964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clFhRyKOA0pSu/+l5L0nBfk45kGRHvF3FLF32sssB6M=;
 b=TIY1KAlTF/OmkjysPbibA94BXFPi0bAsd1uZWgwAS3ojiqiX3yFhdYB4D1hTv/Xrzt
 2VRh19kqK+Lk/+v16R3w4IwFNza855rRzSfrrhdeVVThMk30nrlJNVmOlYMN+TP3vG2o
 FDqZfux4IK2bHlAtQUFDnUshUVMprwIQmeyAJq+bDvZHwvQdRsvOZ74D/BeIMml8ua1X
 R+bz3VtyMYoD9OEi3KGqKUqonjzA/ecXbhBarmVj4dQnE5nY06N6xkbf+FkPmdWHNqli
 zFv91qRxXi1MpJZM7wc3gg4pf5KTme1Py7onip0vROKq6ZuTnQKC/MF7cZ80UfSPUl/9
 fF+A==
X-Gm-Message-State: AOJu0YxR9oi6bIzJxCGJBd1NKh0lB5mmCtd0nnWpxRBMW7gVjERzVmz9
 ifZERtmCKwXyKTgT/f2SMgN+UkFHvlqhPyug
X-Google-Smtp-Source: AGHT+IG52d+F4h84Vxr3vPGC8a/iaRTIclmIjFN6FtBT7dCzDwnHM5Wa+E22ITNpNnOVf2DCFeZQCg==
X-Received: by 2002:a05:6358:9192:b0:172:cfec:416f with SMTP id
 j18-20020a056358919200b00172cfec416fmr721189rwa.13.1704877164353; 
 Wed, 10 Jan 2024 00:59:24 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:59:23 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Rob Bradford <rbradford@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/65] target/riscv: Add support for Zacas extension
Date: Wed, 10 Jan 2024 18:56:54 +1000
Message-ID: <20240110085733.1607526-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Add support for amocas.w/d/q instructions which are part of the ratified
Zacas extension: https://github.com/riscv/riscv-zacas

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231207153842.32401-2-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                      |   1 +
 target/riscv/insn32.decode                  |   6 +
 target/riscv/cpu.c                          |   2 +
 target/riscv/tcg/tcg-cpu.c                  |   5 +
 target/riscv/translate.c                    |   1 +
 target/riscv/insn_trans/trans_rvzacas.c.inc | 150 ++++++++++++++++++++
 6 files changed, 165 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzacas.c.inc

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index f4605fb190..d516de4a44 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -77,6 +77,7 @@ struct RISCVCPUConfig {
     bool ext_svnapot;
     bool ext_svpbmt;
     bool ext_zdinx;
+    bool ext_zacas;
     bool ext_zawrs;
     bool ext_zfa;
     bool ext_zfbfmin;
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 33597fe2bb..f22df04cfd 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1004,3 +1004,9 @@ vgmul_vv    101000 1 ..... 10001 010 ..... 1110111 @r2_vm_1
 vsm4k_vi    100001 1 ..... ..... 010 ..... 1110111 @r_vm_1
 vsm4r_vv    101000 1 ..... 10000 010 ..... 1110111 @r2_vm_1
 vsm4r_vs    101001 1 ..... 10000 010 ..... 1110111 @r2_vm_1
+
+# *** RV32 Zacas Standard Extension ***
+amocas_w    00101 . . ..... ..... 010 ..... 0101111 @atom_st
+amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
+# *** RV64 Zacas Standard Extension ***
+amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 53b82cc581..21b0eddf6f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -87,6 +87,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
+    ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
     ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
@@ -1297,6 +1298,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
+    MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
     MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
     MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
     MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8a35683a34..29b5a88931 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -343,6 +343,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if ((cpu->cfg.ext_zacas) && !riscv_has_ext(env, RVA)) {
+        error_setg(errp, "Zacas extension requires A extension");
+        return;
+    }
+
     if ((cpu->cfg.ext_zawrs) && !riscv_has_ext(env, RVA)) {
         error_setg(errp, "Zawrs extension requires A extension");
         return;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f0be79bb16..071fbad7ef 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1089,6 +1089,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvv.c.inc"
 #include "insn_trans/trans_rvb.c.inc"
 #include "insn_trans/trans_rvzicond.c.inc"
+#include "insn_trans/trans_rvzacas.c.inc"
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
 #include "insn_trans/trans_rvzfa.c.inc"
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
new file mode 100644
index 0000000000..5d274d4c08
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -0,0 +1,150 @@
+/*
+ * RISC-V translation routines for the RV64 Zacas Standard Extension.
+ *
+ * Copyright (c) 2020-2023 PLCT Lab
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
+#define REQUIRE_ZACAS(ctx) do {          \
+    if (!ctx->cfg_ptr->ext_zacas) {      \
+        return false;                     \
+    }                                     \
+} while (0)
+
+static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
+{
+    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGv src1 = get_address(ctx, a->rs1, 0);
+    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    decode_save_opc(ctx);
+    tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
+
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
+static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)
+{
+    REQUIRE_ZACAS(ctx);
+    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TESL);
+}
+
+static TCGv_i64 get_gpr_pair(DisasContext *ctx, int reg_num)
+{
+    TCGv_i64 t;
+
+    assert(get_ol(ctx) == MXL_RV32);
+
+    if (reg_num == 0) {
+        return tcg_constant_i64(0);
+    }
+
+    t = tcg_temp_new_i64();
+    tcg_gen_concat_tl_i64(t, cpu_gpr[reg_num], cpu_gpr[reg_num + 1]);
+    return t;
+}
+
+static void gen_set_gpr_pair(DisasContext *ctx, int reg_num, TCGv_i64 t)
+{
+    assert(get_ol(ctx) == MXL_RV32);
+
+    if (reg_num != 0) {
+#ifdef TARGET_RISCV32
+        tcg_gen_extr_i64_i32(cpu_gpr[reg_num], cpu_gpr[reg_num + 1], t);
+#else
+        tcg_gen_ext32s_i64(cpu_gpr[reg_num], t);
+        tcg_gen_sari_i64(cpu_gpr[reg_num + 1], t, 32);
+#endif
+
+        if (get_xl_max(ctx) == MXL_RV128) {
+            tcg_gen_sari_tl(cpu_gprh[reg_num], cpu_gpr[reg_num], 63);
+            tcg_gen_sari_tl(cpu_gprh[reg_num + 1], cpu_gpr[reg_num + 1], 63);
+        }
+    }
+}
+
+static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
+{
+    /*
+     * Encodings with odd numbered registers specified in rs2 and rd are
+     * reserved.
+     */
+    if ((a->rs2 | a->rd) & 1) {
+        return false;
+    }
+
+    TCGv_i64 dest = get_gpr_pair(ctx, a->rd);
+    TCGv src1 = get_address(ctx, a->rs1, 0);
+    TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
+
+    decode_save_opc(ctx);
+    tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
+
+    gen_set_gpr_pair(ctx, a->rd, dest);
+    return true;
+}
+
+static bool trans_amocas_d(DisasContext *ctx, arg_amocas_d *a)
+{
+    REQUIRE_ZACAS(ctx);
+    switch (get_ol(ctx)) {
+    case MXL_RV32:
+        return gen_cmpxchg64(ctx, a, MO_ALIGN | MO_TEUQ);
+    case MXL_RV64:
+    case MXL_RV128:
+        return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TEUQ);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
+{
+    REQUIRE_ZACAS(ctx);
+    REQUIRE_64BIT(ctx);
+
+    /*
+     * Encodings with odd numbered registers specified in rs2 and rd are
+     * reserved.
+     */
+    if ((a->rs2 | a->rd) & 1) {
+        return false;
+    }
+
+#ifdef TARGET_RISCV64
+    TCGv_i128 dest = tcg_temp_new_i128();
+    TCGv src1 = get_address(ctx, a->rs1, 0);
+    TCGv_i128 src2 = tcg_temp_new_i128();
+    TCGv_i64 src2l = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv_i64 src2h = get_gpr(ctx, a->rs2 == 0 ? 0 : a->rs2 + 1, EXT_NONE);
+    TCGv_i64 destl = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGv_i64 desth = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
+
+    tcg_gen_concat_i64_i128(src2, src2l, src2h);
+    tcg_gen_concat_i64_i128(dest, destl, desth);
+    decode_save_opc(ctx);
+    tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx,
+                                (MO_ALIGN | MO_TEUO));
+
+    tcg_gen_extr_i128_i64(destl, desth, dest);
+
+    if (a->rd != 0) {
+        gen_set_gpr(ctx, a->rd, destl);
+        gen_set_gpr(ctx, a->rd + 1, desth);
+    }
+#endif
+
+    return true;
+}
-- 
2.43.0


