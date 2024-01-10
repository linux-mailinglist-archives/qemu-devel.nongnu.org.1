Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E77482A422
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:46:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhKz-000643-5X; Wed, 10 Jan 2024 17:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKZ-0005Qq-Rd
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:53 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKV-00031d-Ha
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:51 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-42989a64713so28033661cf.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926745; x=1705531545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yt1amn66GV+70TUwg6QhzJ4YUnpX4UUEzHPNr30u2sg=;
 b=diuisTxzDDwVBO0OX7VSiNMAE6vO2MxrhyyL+ti+38sfQCSzcHpp1JmMBlRKaPRvGj
 glFzUS1oyRbgCPoMuUlCJddOzh7Q8z59xFbgApdfuaBpKvl+sJGWYbCd/xw13jQwq84L
 HJ61Sgu030kUgDqE+B8F40SsSJNftyDUh8/A1U9IOuhxO54V5U1WVobZIglB+FXtkD9Y
 bbnUkX3DXzhPPQreHYUVW4RYSjLRT3cN/aRIoFQcsKEmQWZWcMDxhQnplsPQjM+W6ZG1
 hDXOuFPh0K6uTpcc1ZO+fuCLlAaS9hSvGuy2R6A4Ut4+YRiTeoPcCHxdmTDRoyp0P3Mr
 COHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926745; x=1705531545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yt1amn66GV+70TUwg6QhzJ4YUnpX4UUEzHPNr30u2sg=;
 b=nDodeq5C9sv9Z35B9U49fH6ZLcGXtia6fC4S6ZGaF0+X5B850hhKo20vqoX0gJO/AY
 sDaGJWEN7cPrFPDX1pwbuvXbyBZYJonVbBNKm92XW/CygDkFEc+mN6C4pO4CnnVrD801
 naf6xzd9GF+GeBss0USAQjUzCz+dO1tNZ7pYMcODG+QvJM8O6jCLA7wUqz1ibm2MxiNn
 fooN1bQti+dtP4twI5UPTWnaLJYWNOkKxPT7JBVXpeAIsy7iDH6/l+iptgiKQiiUbrOX
 52pgeXXhIzboxh0wher77rJHUwDJnS4MXD1zrnzAvFhLKFH5PV0Eepz/4mhD6sD+FNMl
 D6Lg==
X-Gm-Message-State: AOJu0YxBBi013PvskuBx64AxCzAIOrQj5dciPlf4q4Gwk0GxTE+yJM5C
 gnW8DG/vaFzqvvNGUugYbGBSO3nPGZxljQSeZNIeN2eV8TexwvaZ
X-Google-Smtp-Source: AGHT+IGcOnVPuHupy2QbjUIjkNN0J26tp03wNPvRyYUilChN5bDxLraKKAE97bsj4KanX/qKx7p4aA==
X-Received: by 2002:a05:622a:48:b0:429:8ed0:3e1b with SMTP id
 y8-20020a05622a004800b004298ed03e1bmr322884qtw.13.1704926744842; 
 Wed, 10 Jan 2024 14:45:44 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 16/38] tcg: Add TCGConst argument to tcg_target_const_match
Date: Thu, 11 Jan 2024 09:43:46 +1100
Message-Id: <20240110224408.10444-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
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

Fill the new argument from any condition within the opcode.
Not yet used within any backend.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 2f4522488a..4169ce89a4 100644
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
@@ -4786,6 +4787,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     TCGTemp *ts;
     TCGArg new_args[TCG_MAX_OP_ARGS];
     int const_args[TCG_MAX_OP_ARGS];
+    TCGCond op_cond;
 
     nb_oargs = def->nb_oargs;
     nb_iargs = def->nb_iargs;
@@ -4798,6 +4800,33 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
@@ -4811,7 +4840,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index d268199fc1..accaaa2660 100644
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
index bab0a173a3..076fc8a917 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -183,7 +183,8 @@ static inline tcg_target_long sextreg(tcg_target_long val, int pos, int len)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return true;
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 8328dbdecc..3b5b5c6d5b 100644
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
index 54816967bc..850ace98b2 100644
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
index a91defd0ac..ac86b92b75 100644
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


