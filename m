Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE8193CB6A
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Jul 2024 01:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ah-0001CX-5v; Thu, 25 Jul 2024 19:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AX-0000ZZ-6O
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:45 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AU-0005N9-33
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:44 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d199fb3dfso373260b3a.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951201; x=1722556001;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyEh2IGT2rrT4mUEjjkYvKQHUbPYvHm8L55gDTTMtGA=;
 b=uTFXV0huUyloOYgO4FkLC9AoXpY6Il4saILDqUx7NB8aS+qC2DbsOx7B3RJTaA7N7d
 dOfM2wiq1nrg6NRXdKYsvF5phswLhHY1JZdR4S6YMYEL9LH+eJYnnJjASuV951NzuZnR
 o6+gDjlcadOu7GGtWtBbt5WVuVqtwFhW65i8QWe4NuSCvA8vLJdS/mR+eQGbIe0jnWUG
 Sz1uoJuItquekb1CE+4DN5g5XMH6+xO2KM1SemqWOYMHF/xc0s50UufinYDdtHHWVSPJ
 PKkqq5nmTidNOkiF+bBw8Xb892fTwYbON+qnVBVXuSFGmJf5PrVKc12p18bX1wn0te3X
 R/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951201; x=1722556001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TyEh2IGT2rrT4mUEjjkYvKQHUbPYvHm8L55gDTTMtGA=;
 b=v/YQHPuNbHM+/9AjghsKCwRxABBCiYdDMZ0T+3+rYOY8AEH/ESLqrEBRINFuTI4Ol7
 FCueFahrWZfKLVvywI33axUFZUNsm1zjQSKn3s0ZRkjmui1mz6IWw1fkHdJbVJZfYxpM
 YuEnsqzwGGTzjd1RQ5Wy5MWR45tC28lCDCh7T3gyR4q8y8aE1oF0usJ9ViA36EivZYC4
 96qH7lkmgU3wCC0/S79zcKtmHMgiF0zccB4IgGAiESM2L/Dob4vw2k9DQbP8dxiZFL4h
 /E7qkKFXvX3bA+QxHhiHQtqkxFo/pzQRvgAqWkFOzfFDMBTYCyNT1K3pKTJfFbsJLyU3
 /Llw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN1lDED8eVUyl437p19kts4cETuU8v6zcxvwge5vhWi+yhNvVoNR3WCuj5l3hX3OrNH2kBPeVPbhQ/fgxmwJprw0uQw/Q=
X-Gm-Message-State: AOJu0YxqqUyIGrzydAC+jKapm2i5KmyhXOC+h0vm84Kyw4p90kgozzou
 p9NFh2wtTq/JrJbCV2cL3snLCE7RT5qU5FAYWw1C14BAVvh8DlirXRE76Y0bovg=
X-Google-Smtp-Source: AGHT+IHjqrnOK6vx4PkOKSkD1WebI4DqdnjLhiqY1g+NrHDWANqzdrAa2Af0sb0lZjniLUOk8+e2Ug==
X-Received: by 2002:a05:6a00:2355:b0:706:8a67:c395 with SMTP id
 d2e1a72fcca58-70eaa89bc8amr5304137b3a.6.1721951200594; 
 Thu, 25 Jul 2024 16:46:40 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:40 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 13/24] target/riscv: implement zicfiss instructions
Date: Thu, 25 Jul 2024 16:46:02 -0700
Message-ID: <20240725234614.3850142-14-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 target/riscv/cpu_bits.h                 |  2 ++
 target/riscv/helper.h                   |  2 ++
 target/riscv/insn32.decode              | 17 +++++++--
 target/riscv/insn_trans/trans_rva.c.inc | 47 +++++++++++++++++++++++++
 target/riscv/op_helper.c                |  9 +++++
 target/riscv/translate.c                |  1 +
 6 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 589326e516..8e179d6965 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -696,6 +696,8 @@ typedef enum RISCVException {
 
 /* zicfilp defines lp violation results in sw check with tval = 2*/
 #define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
+/* zicfiss defines ss violation results in sw check with tval = 3*/
+#define RISCV_EXCP_SW_CHECK_BCFI_TVAL      3
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index ab55bbbf73..4efb7ba4df 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -124,6 +124,8 @@ DEF_HELPER_2(cbo_zero, void, env, tl)
 /* Forward CFI label checking */
 DEF_HELPER_2(cfi_jalr, void, env, int)
 DEF_HELPER_2(cfi_check_landing_pad, void, env, int)
+/* helper for sschk mismatch (zicfiss) */
+DEF_HELPER_3(sschk_mismatch, void, env, tl, tl)
 
 /* Special functions */
 DEF_HELPER_2(csrr, tl, env, int)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c963c59c8e..c59c992ce2 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -65,8 +65,10 @@
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
 @i       ............    ..... ... ..... ....... &i      imm=%imm_i     %rs1 %rd
+@ss_pop  ............    ..... ... ..... ....... &i      imm=0 %rs1 rd=0
 @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
 @s       .......   ..... ..... ... ..... ....... &s      imm=%imm_s %rs2 %rs1
+@ss_push .......   ..... ..... ... ..... ....... &s      imm=0 %rs2 rs1=0
 @u       ....................      ..... ....... &u      imm=%imm_u          %rd
 @j       ....................      ..... ....... &j      imm=%imm_j          %rd
 
@@ -247,6 +249,7 @@ remud    0000001 .....  ..... 111 ..... 1111011 @r
 lr_w       00010 . . 00000 ..... 010 ..... 0101111 @atom_ld
 sc_w       00011 . . ..... ..... 010 ..... 0101111 @atom_st
 amoswap_w  00001 . . ..... ..... 010 ..... 0101111 @atom_st
+ssamoswap_w 01001 . . ..... ..... 010 ..... 0101111 @atom_st
 amoadd_w   00000 . . ..... ..... 010 ..... 0101111 @atom_st
 amoxor_w   00100 . . ..... ..... 010 ..... 0101111 @atom_st
 amoand_w   01100 . . ..... ..... 010 ..... 0101111 @atom_st
@@ -260,6 +263,7 @@ amomaxu_w  11100 . . ..... ..... 010 ..... 0101111 @atom_st
 lr_d       00010 . . 00000 ..... 011 ..... 0101111 @atom_ld
 sc_d       00011 . . ..... ..... 011 ..... 0101111 @atom_st
 amoswap_d  00001 . . ..... ..... 011 ..... 0101111 @atom_st
+ssamoswap_d 01001 . . ..... ..... 011 ..... 0101111 @atom_st
 amoadd_d   00000 . . ..... ..... 011 ..... 0101111 @atom_st
 amoxor_d   00100 . . ..... ..... 011 ..... 0101111 @atom_st
 amoand_d   01100 . . ..... ..... 011 ..... 0101111 @atom_st
@@ -1023,8 +1027,17 @@ amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
 amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
 
 # *** Zimop may-be-operation extension ***
-mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
-mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
+{
+  # zicfiss instructions carved out of mop.r
+  ssrdp      1100110 11100     00000 100 ..... 1110011 %rd
+  sspopchk   1100110 11100     ..... 100 00000 1110011 @ss_pop
+  mop_r_n    1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
+}
+{
+  # zicfiss instruction carved out of mop.rr
+  sspush     1100111 .....     00000 100 00000 1110011 @ss_push
+  mop_rr_n   1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
+}
 
 # *** Zabhb Standard Extension ***
 amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 39bbf60f3c..db6c03f6a8 100644
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
@@ -114,6 +116,28 @@ static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
 }
 
+static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
+{
+    REQUIRE_A_OR_ZAAMO(ctx);
+    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
+    int ss_mmu_idx = 0;
+
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
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESL));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
@@ -183,6 +207,29 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
 }
 
+static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_A_OR_ZAAMO(ctx);
+    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
+    int ss_mmu_idx = 0;
+
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
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESQ));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 2d152f0a00..54baa3a966 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -291,6 +291,15 @@ void helper_cfi_check_landing_pad(CPURISCVState *env, int lbl)
     }
 }
 
+void helper_sschk_mismatch(CPURISCVState *env, target_ulong rs1,
+                           target_ulong ssra)
+{
+    if (rs1 != ssra) {
+        env->sw_check_code = RISCV_EXCP_SW_CHECK_BCFI_TVAL;
+        riscv_raise_exception(env, RISCV_EXCP_SW_CHECK, GETPC());
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 34c9bf093d..9152a963ee 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1143,6 +1143,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
 #include "insn_trans/trans_rvzimop.c.inc"
+#include "insn_trans/trans_rvzicfiss.c.inc"
 #include "insn_trans/trans_rvzfa.c.inc"
 #include "insn_trans/trans_rvzfh.c.inc"
 #include "insn_trans/trans_rvk.c.inc"
-- 
2.44.0


