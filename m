Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 747DD797636
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:04:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHU6-0000w6-Lp; Thu, 07 Sep 2023 12:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHU4-0000v2-IA
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:56 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTx-000210-HX
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-401bbfc05fcso12755535e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102628; x=1694707428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v2kymloLLTuf3IOcdS9RQAfIjcbsr5L1WTZqHwm+RXg=;
 b=i40GcLj4Y6FNsq7VhKmezBW2topbJhuIZt6/QDNhOQ+MdgDahyEeAwpnleQcXA0t3/
 5IGnAJ3zbaiSxQgSfYBKXV+sbYwdgKfel7NpQTLSDRvoe/mtRXXtUrFuMJHsMPaXosop
 PpBvm/xZXBg6A/5K5t+oZ6U3gY3IwF9Q7pisbQ6QNGZ5lYl5rpsmFCaYSs+AzxYfASZg
 iyRoWcuk0bkAZUOfTxBS6SNhlk/xsCqXMOPinrRjOohAPhE4XAEG0nfjAEFIjOAjmuk0
 vM7s+Usd1+PaMAVp3jWiXbhZfLPhPrYHr+46rW0x7xrVatYN4zl3MY/Mv62Cyqp8VF+R
 fpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102628; x=1694707428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2kymloLLTuf3IOcdS9RQAfIjcbsr5L1WTZqHwm+RXg=;
 b=OtxikhQWZso4Y5RHOZLc9ANFPVDntmvUeoP1pA/9z5HAhBiaBrRhgmKzPvq6MZIk0e
 8uZ4BNV+SGXZI3kVmvOR7rq+8wHc1Z0YqCOrsNPK/BSLg7UbideoMWenZQhKFJUdGG1R
 NnPcRWbxFrpmXRRvxENlukRm0WJ/xDa6FbGIeDoIT3aBiQ3pXz0CBsQsECtCmSeOXVBJ
 +H+FvtWfIYc+eIgecGvn36+maEE6QH4TlfAgj0fE8bVeqlm6I7zOh938ATOM29mfhFms
 OQ1PCixZTzG2tw6kt/aVIjTC7GTkoMylBqPD1upsiuzknU+9xFN3NBX3+au/sVZWHZh8
 JEPQ==
X-Gm-Message-State: AOJu0YxXcg4uwyW23+qAM5ZlXwWYoKYx7Pj5zkNkJLRcuB04+RmhDbuZ
 2WjBKqy0b6acO4/m0yZajpkpoQ==
X-Google-Smtp-Source: AGHT+IEsWCObvGGHM1cuh84kyH6E9TNxBSX+dX8pyWC7g+abSA/zTL3oO1mPG89RVumAih6gW2gl3Q==
X-Received: by 2002:adf:f30a:0:b0:31d:cf59:8d8 with SMTP id
 i10-20020adff30a000000b0031dcf5908d8mr4980274wro.14.1694102628087; 
 Thu, 07 Sep 2023 09:03:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/14] target/arm: Define new TB flag for ATA0
Date: Thu,  7 Sep 2023 17:03:36 +0100
Message-Id: <20230907160340.260094-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907160340.260094-1-peter.maydell@linaro.org>
References: <20230907160340.260094-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Currently the only tag-setting instructions always do so in the
context of the current EL, and so we only need one ATA bit in the TB
flags.  The FEAT_MOPS SETG instructions include ones which set tags
for a non-privileged access, so we now also need the equivalent "are
tags enabled?" information for EL0.

Add the new TB flag, and convert the existing 'bool ata' field in
DisasContext to a 'bool ata[2]' that can be indexed by the is_unpriv
bit in an instruction, similarly to mte[2].

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  1 +
 target/arm/tcg/translate.h     |  4 ++--
 target/arm/tcg/hflags.c        | 12 ++++++++++++
 target/arm/tcg/translate-a64.c | 23 ++++++++++++-----------
 4 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7d2e1a1cfe8..8312291f083 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3147,6 +3147,7 @@ FIELD(TBFLAG_A64, SVL, 24, 4)
 FIELD(TBFLAG_A64, SME_TRAP_NONSTREAMING, 28, 1)
 FIELD(TBFLAG_A64, FGT_ERET, 29, 1)
 FIELD(TBFLAG_A64, NAA, 30, 1)
+FIELD(TBFLAG_A64, ATA0, 31, 1)
 
 /*
  * Helpers for using the above.
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f748ba6f394..63922f8bad1 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -114,8 +114,8 @@ typedef struct DisasContext {
     bool unpriv;
     /* True if v8.3-PAuth is active.  */
     bool pauth_active;
-    /* True if v8.5-MTE access to tags is enabled.  */
-    bool ata;
+    /* True if v8.5-MTE access to tags is enabled; index with is_unpriv.  */
+    bool ata[2];
     /* True if v8.5-MTE tag checks affect the PE; index with is_unpriv.  */
     bool mte_active[2];
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index ea642384f5a..cea1adb7b62 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -325,6 +325,18 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
             && allocation_tag_access_enabled(env, 0, sctlr)) {
             DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
         }
+        /*
+         * For unpriv tag-setting accesses we alse need ATA0. Again, in
+         * contexts where unpriv and normal insns are the same we
+         * duplicate the ATA bit to save effort for translate-a64.c.
+         */
+        if (EX_TBFLAG_A64(flags, UNPRIV)) {
+            if (allocation_tag_access_enabled(env, 0, sctlr)) {
+                DP_TBFLAG_A64(flags, ATA0, 1);
+            }
+        } else {
+            DP_TBFLAG_A64(flags, ATA0, EX_TBFLAG_A64(flags, ATA));
+        }
         /* Cache TCMA as well as TBI. */
         DP_TBFLAG_A64(flags, TCMA, aa64_va_parameter_tcma(tcr, mmu_idx));
     }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index acb96251704..366ddde57f7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2251,7 +2251,7 @@ static void handle_sys(DisasContext *s, bool isread,
             clean_addr = clean_data_tbi(s, tcg_rt);
             gen_probe_access(s, clean_addr, MMU_DATA_STORE, MO_8);
 
-            if (s->ata) {
+            if (s->ata[0]) {
                 /* Extract the tag from the register to match STZGM.  */
                 tag = tcg_temp_new_i64();
                 tcg_gen_shri_i64(tag, tcg_rt, 56);
@@ -2268,7 +2268,7 @@ static void handle_sys(DisasContext *s, bool isread,
             clean_addr = clean_data_tbi(s, tcg_rt);
             gen_helper_dc_zva(cpu_env, clean_addr);
 
-            if (s->ata) {
+            if (s->ata[0]) {
                 /* Extract the tag from the register to match STZGM.  */
                 tag = tcg_temp_new_i64();
                 tcg_gen_shri_i64(tag, tcg_rt, 56);
@@ -3028,7 +3028,7 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
         tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     }
 
-    if (!s->ata) {
+    if (!s->ata[0]) {
         /*
          * TODO: We could rely on the stores below, at least for
          * system mode, if we arrange to add MO_ALIGN_16.
@@ -3758,7 +3758,7 @@ static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
     tcg_gen_addi_i64(addr, addr, a->imm);
     tcg_rt = cpu_reg(s, a->rt);
 
-    if (s->ata) {
+    if (s->ata[0]) {
         gen_helper_stzgm_tags(cpu_env, addr, tcg_rt);
     }
     /*
@@ -3790,7 +3790,7 @@ static bool trans_STGM(DisasContext *s, arg_ldst_tag *a)
     tcg_gen_addi_i64(addr, addr, a->imm);
     tcg_rt = cpu_reg(s, a->rt);
 
-    if (s->ata) {
+    if (s->ata[0]) {
         gen_helper_stgm(cpu_env, addr, tcg_rt);
     } else {
         MMUAccessType acc = MMU_DATA_STORE;
@@ -3822,7 +3822,7 @@ static bool trans_LDGM(DisasContext *s, arg_ldst_tag *a)
     tcg_gen_addi_i64(addr, addr, a->imm);
     tcg_rt = cpu_reg(s, a->rt);
 
-    if (s->ata) {
+    if (s->ata[0]) {
         gen_helper_ldgm(tcg_rt, cpu_env, addr);
     } else {
         MMUAccessType acc = MMU_DATA_LOAD;
@@ -3857,7 +3857,7 @@ static bool trans_LDG(DisasContext *s, arg_ldst_tag *a)
 
     tcg_gen_andi_i64(addr, addr, -TAG_GRANULE);
     tcg_rt = cpu_reg(s, a->rt);
-    if (s->ata) {
+    if (s->ata[0]) {
         gen_helper_ldg(tcg_rt, cpu_env, addr, tcg_rt);
     } else {
         /*
@@ -3894,7 +3894,7 @@ static bool do_STG(DisasContext *s, arg_ldst_tag *a, bool is_zero, bool is_pair)
         tcg_gen_addi_i64(addr, addr, a->imm);
     }
     tcg_rt = cpu_reg_sp(s, a->rt);
-    if (!s->ata) {
+    if (!s->ata[0]) {
         /*
          * For STG and ST2G, we need to check alignment and probe memory.
          * TODO: For STZG and STZ2G, we could rely on the stores below,
@@ -4063,7 +4063,7 @@ static bool gen_add_sub_imm_with_tags(DisasContext *s, arg_rri_tag *a,
     tcg_rn = cpu_reg_sp(s, a->rn);
     tcg_rd = cpu_reg_sp(s, a->rd);
 
-    if (s->ata) {
+    if (s->ata[0]) {
         gen_helper_addsubg(tcg_rd, cpu_env, tcg_rn,
                            tcg_constant_i32(imm),
                            tcg_constant_i32(a->uimm4));
@@ -5450,7 +5450,7 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
         if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
             goto do_unallocated;
         }
-        if (s->ata) {
+        if (s->ata[0]) {
             gen_helper_irg(cpu_reg_sp(s, rd), cpu_env,
                            cpu_reg_sp(s, rn), cpu_reg(s, rm));
         } else {
@@ -13941,7 +13941,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->bt = EX_TBFLAG_A64(tb_flags, BT);
     dc->btype = EX_TBFLAG_A64(tb_flags, BTYPE);
     dc->unpriv = EX_TBFLAG_A64(tb_flags, UNPRIV);
-    dc->ata = EX_TBFLAG_A64(tb_flags, ATA);
+    dc->ata[0] = EX_TBFLAG_A64(tb_flags, ATA);
+    dc->ata[1] = EX_TBFLAG_A64(tb_flags, ATA0);
     dc->mte_active[0] = EX_TBFLAG_A64(tb_flags, MTE_ACTIVE);
     dc->mte_active[1] = EX_TBFLAG_A64(tb_flags, MTE0_ACTIVE);
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
-- 
2.34.1


