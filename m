Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC295A70A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Aug 2024 23:52:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgtDq-0005Hc-Vd; Wed, 21 Aug 2024 17:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgtDp-0005CV-7y
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:50:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgtDn-00085i-BA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:50:28 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-202376301e6so1387695ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 14:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724277026; x=1724881826;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kc+5TYTwD9rlsnR3t1eH9CG1EZ2ambfIqbtNRVrBCCI=;
 b=njmBbMrYMbxZHWbWr/dOBLGH67l+Z7LAbjbT40zBbagJVv0vz+YdidK8/nhtl0hxo+
 W7XPwH4MkjLGG9JNIDk98BmoG97FC0zRVBIVb7DHTYZDATQvTrHBU3NVg51Pewyp2O12
 F5zIQfqSOfibuLDmBWFeK3wP8xTfbiSQlsRDI/h0CBTbspBKMWaNQ7k+iX6yhT1Vctp7
 nt8J77067Qj09WyspuPZOlN8+CPiapy/ADTX5ePM4L74dYB9Euc3seRXriW3TbFlxuCD
 fvtrxto5xarn7zKhNvEqHWgU4Lre6upJ8HdxlGifC5qtA0zsuKU+LeZgniQgYhGttC0+
 eovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724277026; x=1724881826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kc+5TYTwD9rlsnR3t1eH9CG1EZ2ambfIqbtNRVrBCCI=;
 b=fsNuQpqkjcRHdN3iILO8gvYo51PObTsePbZiwK+oj37OpidOfL4kqU0w2pHva0Qy/M
 SS1gxv6gaRHr7/VW+FYdUVqRLMmbXmB2qXMPq7dr30rMD0pv+62s6H6N38N6rdEuacMH
 pKAieVB/JhQnnS5dvduHPep84VndcqM2uhxYQQyi4c1ULlJODvu5zb+ZEtjNKnLj2dax
 dySJm64x2A87fabBlVSixos+ZyorJamVIqaIOGvob/rQTniTvEav2VLrn2KR/lOf6InI
 Up+oALlr9xSOUuHySpPBg1T4P34eHByTyZnl3XkbIwBc/kxvHXYBLEGUAYcy61OxyVHa
 ZZAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGJdXD0uxjpnQJOKun4ChJVkzJtzLR1xUt0SAE1jNscxem8F/aApscIrPCueo96iEnaN+GFjvY2Esl@nongnu.org
X-Gm-Message-State: AOJu0Yzwk4M7OwsfO0javWKfpeDjtTaSV+4woQBLqmY6V/PBRI2oVjD2
 ibFT49bnjtJckgX78LK/VPoXeL+tC2ymLeSy5ZUfVV5P7NBlTDS0UYRXgsv/tAU=
X-Google-Smtp-Source: AGHT+IExXuL7JI9IFQEWeDffkw8aNOQMjIWw5ZBEnsB/9C5ohWyUhxPQTE9lsmlohNITJK7iE0GjwA==
X-Received: by 2002:a17:902:f601:b0:203:6821:a839 with SMTP id
 d9443c01a7336-2036821a896mr47773545ad.8.1724277025803; 
 Wed, 21 Aug 2024 14:50:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203859ef0fdsm586345ad.248.2024.08.21.14.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 14:50:25 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 05/16] target/riscv: tracking indirect branches (fcfi) for
 zicfilp
Date: Wed, 21 Aug 2024 14:50:03 -0700
Message-ID: <20240821215014.3859190-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240821215014.3859190-1-debug@rivosinc.com>
References: <20240821215014.3859190-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x633.google.com
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

zicfilp protects forward control flow (if enabled) by enforcing all
indirect call and jmp must land on a landing pad instruction `lpad`. If
target of an indirect call or jmp is not `lpad` then cpu/hart must raise
a sw check exception with tval = 2.

This patch implements the mechanism using TCG. Target architecture branch
instruction must define the end of a TB. Using this property, during
translation of branch instruction, TB flag = FCFI_LP_EXPECTED can be set.
Translation of target TB can check if FCFI_LP_EXPECTED flag is set and a
flag (fcfi_lp_expected) can be set in DisasContext. If `lpad` gets
translated, fcfi_lp_expected flag in DisasContext can be cleared. Else
it'll fault.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        |  3 +++
 target/riscv/cpu_bits.h   |  3 +++
 target/riscv/cpu_helper.c | 12 ++++++++++++
 target/riscv/translate.c  | 20 ++++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 11c6513a90..edf540339a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -606,6 +606,9 @@ FIELD(TB_FLAGS, ITRIGGER, 22, 1)
 FIELD(TB_FLAGS, VIRT_ENABLED, 23, 1)
 FIELD(TB_FLAGS, PRIV, 24, 2)
 FIELD(TB_FLAGS, AXL, 26, 2)
+/* zicfilp needs a TB flag to track indirect branches */
+FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
+FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b05ebe6f29..900769ce60 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -685,6 +685,9 @@ typedef enum RISCVException {
     RISCV_EXCP_SEMIHOST = 0x3f,
 } RISCVException;
 
+/* zicfilp defines lp violation results in sw check with tval = 2*/
+#define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
+
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9f08a67a9e..3a56bea8b9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -133,6 +133,18 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
     }
 
+    if (cpu_get_fcfien(env)) {
+        /*
+         * For Forward CFI, only the expectation of a lpcll at
+         * the start of the block is tracked (which can only happen
+         * when FCFI is enabled for the current processor mode). A jump
+         * or call at the end of the previous TB will have updated
+         * env->elp to indicate the expectation.
+         */
+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp);
+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
+    }
+
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index acba90f170..f364a54af6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -116,6 +116,9 @@ typedef struct DisasContext {
     bool frm_valid;
     bool insn_start_updated;
     const GPtrArray *decoders;
+    /* zicfilp extension. fcfi_enabled, lp expected or not */
+    bool fcfi_enabled;
+    bool fcfi_lp_expected;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1238,6 +1241,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
+    ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
+    ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
@@ -1270,6 +1275,21 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     decode_opc(env, ctx, opcode16);
     ctx->base.pc_next += ctx->cur_insn_len;
 
+    /*
+     * instr decode of `lpad` should have lowered fcfi_lp_expected.
+     * If not `lpad`, raise sw check exception.
+     */
+    if (ctx->fcfi_lp_expected) {
+        /* Emit after insn_start, i.e. before the op following insn_start. */
+        tcg_ctx->emit_before_op = QTAILQ_NEXT(ctx->base.insn_start, link);
+        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        gen_helper_raise_exception(tcg_env,
+                      tcg_constant_i32(RISCV_EXCP_SW_CHECK));
+        tcg_ctx->emit_before_op = NULL;
+        ctx->base.is_jmp = DISAS_NORETURN;
+    }
+
     /* Only the first insn within a TB is allowed to cross a page boundary. */
     if (ctx->base.is_jmp == DISAS_NEXT) {
         if (ctx->itrigger || !is_same_page(&ctx->base, ctx->base.pc_next)) {
-- 
2.44.0


