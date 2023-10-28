Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D82E7DA906
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFl-0004jG-MH; Sat, 28 Oct 2023 15:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFW-0004iH-N8
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFU-00046b-OI
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:34 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso28590415ad.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522331; x=1699127131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCkSZfcN8VkWWjgSJsiqANAyZlfoh+Pc4PDDAjEe7LU=;
 b=L7qiQeQKD54f0wf6gGaDyDzLccfvqm69M2ZA8zfVWy75yte4j6SLNrsJ7tInamOagm
 wfWYsXXwISYramCFYFbtxeRp2MvSllzYy8QUpsOpRpfXWhwg5XNOOSGcYieXJNH6G/ns
 0qLtJvVaeP+bWKUI6tT9LW2D1mFr567HpQSJYK1vtrvuZsiftOgzPqyZqbRAhCfB+P6z
 U81MKbSoVGEgbV8ADp687MijPE0eGZmaTnxqeeeneSBmqZ7cLHYZayOt+pEuOWfyIyOd
 mYl+b5Dm1ygfrT+FSsovrTPJ+pzE2YjlV0dS2M2uwxNn7kCmB6OtSwExjSRLjAmsZ03+
 AjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522331; x=1699127131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCkSZfcN8VkWWjgSJsiqANAyZlfoh+Pc4PDDAjEe7LU=;
 b=NicIIQXD0OhZ9KXQQH7HowEmkofu6EVCPhY5l3r2kT/DudE39KSDtbjka3/64UHd0X
 iG/B1txZTUESDeAhlgmFxOt2kwjmNnWhOpExMBmyaS4DIW9AoWcYPvQDobhGy5q8h4Rd
 SP6ZoOcIuKNKRP+857aEe6jXbLEmr/qOr8b2GZ/WIOBtaGjbqdiecdygIpi+WtQYRFHz
 cgBq+F2/wRkFhsWRzK2ZV2pBsM5uFJEzr4Xd/nhirB55sFgsiKWvFa2i3x2mpAkHSqcy
 Ho3hz+0QDuvs5sLwpYWN274huGT/4LKf9FYmXgtaSmJDagVu9qSoRXHzV+nqMnMtU8C7
 4CIA==
X-Gm-Message-State: AOJu0YyLzn/etCInJwKvYeKVBM0LRKYLKO7kq/JZdvbQrBmGyRzA8vlX
 ROnwC46QnqFU8jUJdUnl2nQh4vyzrwjydahfaZo=
X-Google-Smtp-Source: AGHT+IFa0HONHNNMETJJtBLKRvgh9gZAfqFCxE9RoKKCyxsrV0d/Sk2Fs4Cp7GCexd3+c2U2XQXH2Q==
X-Received: by 2002:a17:903:60e:b0:1bb:c06e:647a with SMTP id
 kg14-20020a170903060e00b001bbc06e647amr5469819plb.53.1698522330916; 
 Sat, 28 Oct 2023 12:45:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 07/35] tcg: Add TCGConst argument to tcg_target_const_match
Date: Sat, 28 Oct 2023 12:44:54 -0700
Message-Id: <20231028194522.245170-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Fill the new argument from any condition within the opcode.
Not yet used within any backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 34 ++++++++++++++++++++++++++++++--
 tcg/aarch64/tcg-target.c.inc     |  3 ++-
 tcg/arm/tcg-target.c.inc         |  3 ++-
 tcg/i386/tcg-target.c.inc        |  3 ++-
 tcg/loongarch64/tcg-target.c.inc |  3 ++-
 tcg/mips/tcg-target.c.inc        |  3 ++-
 tcg/ppc/tcg-target.c.inc         |  3 ++-
 tcg/riscv/tcg-target.c.inc       |  3 ++-
 tcg/s390x/tcg-target.c.inc       |  3 ++-
 tcg/sparc64/tcg-target.c.inc     |  3 ++-
 tcg/tci/tcg-target.c.inc         |  3 ++-
 11 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 57d0583fe7..58b431b579 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -173,7 +173,8 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target,
                          const TCGHelperInfo *info);
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot);
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece);
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece);
 #ifdef TCG_TARGET_NEED_LDST_LABELS
 static int tcg_out_ldst_finalize(TCGContext *s);
 #endif
@@ -4680,6 +4681,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     TCGTemp *ts;
     TCGArg new_args[TCG_MAX_OP_ARGS];
     int const_args[TCG_MAX_OP_ARGS];
+    TCGCond op_cond;
 
     nb_oargs = def->nb_oargs;
     nb_iargs = def->nb_iargs;
@@ -4692,6 +4694,33 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     i_allocated_regs = s->reserved_regs;
     o_allocated_regs = s->reserved_regs;
 
+    switch (op->opc) {
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        op_cond = op->args[2];
+        break;
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+    case INDEX_op_cmp_vec:
+        op_cond = op->args[3];
+        break;
+    case INDEX_op_brcond2_i32:
+        op_cond = op->args[4];
+        break;
+    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
+    case INDEX_op_setcond2_i32:
+    case INDEX_op_cmpsel_vec:
+        op_cond = op->args[5];
+        break;
+    default:
+        /* No condition within opcode. */
+        op_cond = TCG_COND_ALWAYS;
+        break;
+    }
+
     /* satisfy input constraints */
     for (k = 0; k < nb_iargs; k++) {
         TCGRegSet i_preferred_regs, i_required_regs;
@@ -4705,7 +4734,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         ts = arg_temp(arg);
 
         if (ts->val_type == TEMP_VAL_CONST
-            && tcg_target_const_match(ts->val, ts->type, arg_ct->ct, TCGOP_VECE(op))) {
+            && tcg_target_const_match(ts->val, arg_ct->ct, ts->type,
+                                      op_cond, TCGOP_VECE(op))) {
             /* constant is OK for instruction */
             const_args[i] = 1;
             new_args[i] = ts->val;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index a3efa1e67a..420e4a35ea 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -270,7 +270,8 @@ static bool is_shimm1632(uint32_t v32, int *cmode, int *imm8)
     }
 }
 
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index fc78566494..0c29a3929b 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -501,7 +501,8 @@ static bool is_shimm1632(uint32_t v32, int *cmode, int *imm8)
  * mov operand2:     values represented with x << (2 * y), x < 0x100
  * add, sub, eor...: ditto
  */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a83f8aab30..eeb23d3fca 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -195,7 +195,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index ccf133db4b..384d2ba342 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -185,7 +185,8 @@ static inline tcg_target_long sextreg(tcg_target_long val, int pos, int len)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return true;
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 328984ccff..35eff82bb3 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -188,7 +188,8 @@ static bool is_p2m1(tcg_target_long val)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 856c3b18f5..a5871f55b1 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -282,7 +282,8 @@ static bool reloc_pc34(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 34e10e77d9..639363039b 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -145,7 +145,8 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define sextreg  sextract64
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fbee43d3b0..08fe00a392 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -538,7 +538,8 @@ static bool risbg_mask(uint64_t c)
 }
 
 /* Test if a constant matches the constraint. */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 19d9df4a09..386f51f29e 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -322,7 +322,8 @@ static bool patch_reloc(tcg_insn_unit *src_rw, int type,
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 461f4b47ff..c740864b96 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -913,7 +913,8 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 }
 
 /* Test if a constant matches the constraint. */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     return ct & TCG_CT_CONST;
 }
-- 
2.34.1


