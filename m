Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEC8953EC6
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Aug 2024 03:10:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRO-0001R5-Nr; Thu, 15 Aug 2024 21:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRI-00014G-Lh
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:36 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRG-0002MA-5P
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:36 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5bf833de7so948386eaf.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770453; x=1724375253;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=idv76gldzgGJ/vYSZUvBj081Y18KKcV09K06gx6vrZY=;
 b=yhkgDUDbKkSSQe8Bzd9OeU/PGeuSx/jtCcD6A4fxZvXjhLNxU6YqVBytioWwlF+lCm
 ZmaT8Uy6wtvulc9tJDixoMGCHbp7rpAsKPoki6IauQ++/f9Y5HiZ+HHTBiI4dhZP4MLB
 1E3fX7XjSw4/TPyEK1cG9aXMRr7V/z71PLj2QO6XVZdP2f0PGYmQKbqp7qB7EUmhYqVU
 tL++xWJW7Dwg5JUgo1Cvq8FL2LhMchkirtOKRxZhOEhoMk7yvifdIHSj6w0DmDENIPZW
 GO4+TcZFtrt1pcxpZXvhSRyvYteiAAs3f759iWb5GcmDjSdk5AZP5qImcW8V70qg4jyH
 43tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770453; x=1724375253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=idv76gldzgGJ/vYSZUvBj081Y18KKcV09K06gx6vrZY=;
 b=VsPIibutMf+i0CWjti7SYOUloLApDB0wGzHowGiqaOa7FsQRV5TlWf94Sk1EXYZ3I2
 9kJME2v1R4ZiJxrnbIRL93Mo8napolplsqJ7FNj5Z5tJoASn1+U7a24zRGCtM89ZBGI8
 alfxJ4QqSmJHXBMmRtEN8Z1ycVtTaQbhdM9WEoizVvY5yBKA/fcI9uvPNVR2wHC+xbgp
 Rasvx+oS0DMuaqSow812Mc7CyjF5I81iATHZD/aMpBV5YKDffNBe14MngBGS9G/Cc6fl
 ud/m/T14hXT+hXSW8W9EWQvO4VGgiKyGYED2K58pSyoITRSPPlkXjnRhPjayYfa1kJgu
 SfUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7Km8QfEbG8Zk0/xxIctAIBHeIepL2L/Rh2wr4qjCLtulY9LaKb0Itz9c5UsZOut2nyyJq9eySiVHf6i0Fz4yW0UKD23M=
X-Gm-Message-State: AOJu0YwTucyXws74gw/bdKscIxF6KkklPSPZETf2WBAxP7LDxY1Yopz+
 lzpSk5A9nwBeSYT63TGVimlXRb+dJWUTw9dALmFJieeXH5PlA6R/3dPIbuHEXE8=
X-Google-Smtp-Source: AGHT+IHev/T+SqCHkI7NQHrpckmcaUsai/eY//PY0vHvSFlNCnPB2tTMUZXOWJMqMv9aTNPntedXRw==
X-Received: by 2002:a05:6871:3a14:b0:261:13b6:16de with SMTP id
 586e51a60fabf-2701c3ee292mr1650987fac.25.1723770452569; 
 Thu, 15 Aug 2024 18:07:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:32 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 12/16] target/riscv: implement zicfiss instructions
Date: Thu, 15 Aug 2024 18:07:06 -0700
Message-ID: <20240816010711.3055425-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=debug@rivosinc.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

zicfiss has following instructions
 - sspopchk: pops a value from shadow stack and compares with x1/x5.
   If they dont match, reports a sw check exception with tval = 3.
 - sspush: pushes value in x1/x5 on shadow stack
 - ssrdp: reads current shadow stack
 - ssamoswap: swaps contents of shadow stack atomically

sspopchk/sspush/ssrdp default to zimop if zimop implemented and SSE=0

If SSE=0, ssamoswap is illegal instruction exception.

This patch implements shadow stack operations for qemu-user and shadow
stack is not protected.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu_bits.h                       |   2 +
 target/riscv/insn32.decode                    |  21 +++-
 target/riscv/insn_trans/trans_rva.c.inc       |  43 +++++++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 111 ++++++++++++++++++
 target/riscv/translate.c                      |   5 +
 5 files changed, 180 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 48ce24dc32..bb62fbe9ec 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -690,6 +690,8 @@ typedef enum RISCVException {
 
 /* zicfilp defines lp violation results in sw check with tval = 2*/
 #define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
+/* zicfiss defines ss violation results in sw check with tval = 3*/
+#define RISCV_EXCP_SW_CHECK_BCFI_TVAL      3
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 494b6cdcc6..c1d14b37d1 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -246,6 +246,7 @@ remud    0000001 .....  ..... 111 ..... 1111011 @r
 lr_w       00010 . . 00000 ..... 010 ..... 0101111 @atom_ld
 sc_w       00011 . . ..... ..... 010 ..... 0101111 @atom_st
 amoswap_w  00001 . . ..... ..... 010 ..... 0101111 @atom_st
+ssamoswap_w 01001 . . ..... ..... 010 ..... 0101111 @atom_st
 amoadd_w   00000 . . ..... ..... 010 ..... 0101111 @atom_st
 amoxor_w   00100 . . ..... ..... 010 ..... 0101111 @atom_st
 amoand_w   01100 . . ..... ..... 010 ..... 0101111 @atom_st
@@ -259,6 +260,7 @@ amomaxu_w  11100 . . ..... ..... 010 ..... 0101111 @atom_st
 lr_d       00010 . . 00000 ..... 011 ..... 0101111 @atom_ld
 sc_d       00011 . . ..... ..... 011 ..... 0101111 @atom_st
 amoswap_d  00001 . . ..... ..... 011 ..... 0101111 @atom_st
+ssamoswap_d 01001 . . ..... ..... 011 ..... 0101111 @atom_st
 amoadd_d   00000 . . ..... ..... 011 ..... 0101111 @atom_st
 amoxor_d   00100 . . ..... ..... 011 ..... 0101111 @atom_st
 amoand_d   01100 . . ..... ..... 011 ..... 0101111 @atom_st
@@ -1022,8 +1024,23 @@ amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
 amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
 
 # *** Zimop may-be-operation extension ***
-mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
-mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
+{
+  # zicfiss instructions carved out of mop.r
+  [
+    ssrdp     1100110 11100 00000 100 rd:5 1110011
+    sspopchk  1100110 11100 00001 100 00000 1110011  rs1=1
+    sspopchk  1100110 11100 00101 100 00000 1110011  rs1=5
+  ]
+  mop_r_n    1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
+}
+{
+  # zicfiss instruction carved out of mop.rr
+  [
+    sspush    1100111 00001  00000 100 00000 1110011 rs2=1
+    sspush    1100111 00101  00000 100 00000 1110011 rs2=5
+  ]
+  mop_rr_n   1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
+}
 
 # *** Zabhb Standard Extension ***
 amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 39bbf60f3c..da1104b4f6 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -18,6 +18,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "exec/memop.h"
+
 #define REQUIRE_A_OR_ZAAMO(ctx) do {                      \
     if (!ctx->cfg_ptr->ext_zaamo && !has_ext(ctx, RVA)) { \
         return false;                                     \
@@ -114,6 +116,26 @@ static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
 }
 
+static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
+{
+    REQUIRE_A_OR_ZAAMO(ctx);
+    /* back cfi was not enabled, return false */
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    decode_save_opc(ctx);
+    src1 = get_address(ctx, a->rs1, 0);
+
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
+                           (MO_ALIGN | MO_TESL));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
@@ -183,6 +205,27 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
 }
 
+static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_A_OR_ZAAMO(ctx);
+    /* back cfi was not enabled, return false */
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    decode_save_opc(ctx);
+    src1 = get_address(ctx, a->rs1, 0);
+
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
+                           (MO_ALIGN | MO_TESQ));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
new file mode 100644
index 0000000000..05d439c1f6
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -0,0 +1,111 @@
+/*
+ * RISC-V translation routines for the Control-Flow Integrity Extension
+ *
+ * Copyright (c) 2024 Rivos Inc.
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
+static bool gen_sspopchk(DisasContext *ctx, int rs1_reg)
+{
+    /* back cfi was not enabled, return false */
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    /*
+     * sspopchk can only compare with x1 or x5. Everything else defaults to
+     * zimops
+     */
+
+    assert(rs1_reg == 1 || rs1_reg == 5);
+
+    /*
+     * get data in TCGv using get_gpr
+     * get addr in TCGv using gen_helper_csrr on CSR_SSP
+     * use some tcg subtract arithmetic (subtract by XLEN) on addr
+     * perform ss store on computed address
+     */
+
+    TCGv addr = tcg_temp_new();
+    TCGLabel *skip = gen_new_label();
+    uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
+    TCGv data = tcg_temp_new();
+    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
+                       mxl_memop(ctx) | MO_ALIGN);
+    TCGv rs1 = get_gpr(ctx, rs1_reg, EXT_NONE);
+    tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
+    gen_helper_raise_sw_check_excep(tcg_env,
+        tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL));
+    gen_set_label(skip);
+    tcg_gen_addi_tl(addr, addr, tmp);
+    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+
+    return true;
+}
+
+static bool gen_sspush(DisasContext *ctx, int rs2_reg)
+{
+    /* back cfi was not enabled, return false */
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    assert(rs2_reg == 1 || rs2_reg == 5);
+
+    /*
+     * get data in TCGv using get_gpr
+     * get addr in TCGv using gen_helper_csrr on CSR_SSP
+     * use some tcg subtract arithmetic (subtract by XLEN) on addr
+     * perform ss store on computed address
+     */
+
+    TCGv addr = tcg_temp_new();
+    int tmp = (get_xl(ctx) == MXL_RV64) ? -8 : -4;
+    TCGv data = get_gpr(ctx, rs2_reg, EXT_NONE);
+    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_addi_tl(addr, addr, tmp);
+    tcg_gen_qemu_st_tl(data, addr, SS_MMU_INDEX(ctx),
+                       mxl_memop(ctx) | MO_ALIGN);
+    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+
+    return true;
+}
+
+static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
+{
+    /* back cfi was not enabled, return false */
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    if (a->rd == 0) {
+        return false;
+    }
+
+    TCGv dest = tcg_temp_new();
+    tcg_gen_ld_tl(dest, tcg_env, offsetof(CPURISCVState, ssp));
+    gen_set_gpr(ctx, a->rd, dest);
+
+    return true;
+}
+
+static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
+{
+    return gen_sspopchk(ctx, a->rs1);
+}
+
+static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
+{
+    return gen_sspush(ctx, a->rs2);
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 4ba42597c4..6fa98e88d9 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -144,6 +144,8 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
 #define get_address_xl(ctx)    ((ctx)->address_xl)
 #endif
 
+#define mxl_memop(ctx) ((get_xl(ctx) + 1) | MO_TE)
+
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
 {
@@ -1126,6 +1128,8 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     return translator_ldl(env, &ctx->base, pc);
 }
 
+#define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
+
 /* Include insn module translation function */
 #include "insn_trans/trans_rvi.c.inc"
 #include "insn_trans/trans_rvm.c.inc"
@@ -1156,6 +1160,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "decode-insn16.c.inc"
 #include "insn_trans/trans_rvzce.c.inc"
 #include "insn_trans/trans_rvzcmop.c.inc"
+#include "insn_trans/trans_rvzicfiss.c.inc"
 
 /* Include decoders for factored-out extensions */
 #include "decode-XVentanaCondOps.c.inc"
-- 
2.44.0


