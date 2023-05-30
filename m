Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 162BA716D5C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o8-0006ye-IP; Tue, 30 May 2023 15:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44o0-00069r-5q
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:52 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ny-0004gm-0b
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:51 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-517bdc9e81dso2474536a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474088; x=1688066088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ma8SQwZ5KYBpqGpOZ0Nisdts8XCLMgSO+IYW0PteZtg=;
 b=Txk4x2tffowrvMOKPjJQXJcabwaRjlnUawNUG2YyU32HE6zQhluU6igNC/ObNWppqW
 4YB6iDuEfe7D/3ugj/LfxJRX7TC/y1O5VqN8b3yRg8E7y8Xum6F8hFRRGCt4XwoperLk
 y+OGW+ff+MMpmX4XnQOURPZEDbWUDKd5PewVK4WjbUYKvkqGpzz+RDqteYT6SFKekRfq
 IHAbsIde6vXcp1ZaaqSIbvpMb/X8ECng4fkRuLLg0rRr43kZR+3GRls8TVGz8g87D5/8
 HyPUhju7xRYVwreuoWvAyR/WNLdxMlo4cARgbS9KVwj77hEM+a5ugn8R6xmQ4vk6pKvV
 Zijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474088; x=1688066088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ma8SQwZ5KYBpqGpOZ0Nisdts8XCLMgSO+IYW0PteZtg=;
 b=BhFpeoQZhDiXxnfeIjK67Dqal/EnV/CoDkVZx0GGcnjkxZNjPsYmJW9ygKL/e09RRl
 zAEBpl8ulPDWbltgoXFI5CgoWVp2fzAmFk0X5+KxoH/nlTLUgIDUBAlxeuoH7QDmLEBM
 GIZIFa5okTNEeUshOBCRuKwI5A09t5y7jTJHYkZHUK6DY36cWyCgudcdi3Dqubak1Y73
 e7MEE2ieXQhGg3wfmeThSNHixPSdVlI7CUoEdiqfgEbq9/i4csRgAyUnD/qko05v0x3H
 883PXFbu+FHBLcN/OObGSa5uiLm7v2YVSO6TKJEdz4rgYMncFWnh4OND7timRD6QCMpu
 FKyg==
X-Gm-Message-State: AC+VfDyUxSCFfKK0ZCMTYs21ZQlZK9fyPTQJysjSusLuPRbvdJ3Wdl8Z
 eZBTg2I2znQzSrDx1qKLHF1QDUvO2yclF+VzfDc=
X-Google-Smtp-Source: ACHHUZ6EvyAzey1vqogcmYfgU6EERCSllechrBgiXrplkVEDz1opv0rtBs9BzY9RkBD6ze9v57Rp+Q==
X-Received: by 2002:a17:90b:4a09:b0:23f:b609:e707 with SMTP id
 kk9-20020a17090b4a0900b0023fb609e707mr3509596pjb.2.1685474088658; 
 Tue, 30 May 2023 12:14:48 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/20] target/arm: Hoist finalize_memop out of do_fp_{ld,
 st}
Date: Tue, 30 May 2023 12:14:29 -0700
Message-Id: <20230530191438.411344-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

We are going to need the complete memop beforehand,
so let's not compute it twice.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 43 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 24e255aa34..02dbf76feb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -915,15 +915,14 @@ static void do_gpr_ld(DisasContext *s, TCGv_i64 dest, TCGv_i64 tcg_addr,
 /*
  * Store from FP register to memory
  */
-static void do_fp_st(DisasContext *s, int srcidx, TCGv_i64 tcg_addr, int size)
+static void do_fp_st(DisasContext *s, int srcidx, TCGv_i64 tcg_addr, MemOp mop)
 {
     /* This writes the bottom N bits of a 128 bit wide vector to memory */
     TCGv_i64 tmplo = tcg_temp_new_i64();
-    MemOp mop = finalize_memop_asimd(s, size);
 
     tcg_gen_ld_i64(tmplo, cpu_env, fp_reg_offset(s, srcidx, MO_64));
 
-    if (size < MO_128) {
+    if ((mop & MO_SIZE) < MO_128) {
         tcg_gen_qemu_st_i64(tmplo, tcg_addr, get_mem_index(s), mop);
     } else {
         TCGv_i64 tmphi = tcg_temp_new_i64();
@@ -939,14 +938,13 @@ static void do_fp_st(DisasContext *s, int srcidx, TCGv_i64 tcg_addr, int size)
 /*
  * Load from memory to FP register
  */
-static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
+static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, MemOp mop)
 {
     /* This always zero-extends and writes to a full 128 bit wide vector */
     TCGv_i64 tmplo = tcg_temp_new_i64();
     TCGv_i64 tmphi = NULL;
-    MemOp mop = finalize_memop_asimd(s, size);
 
-    if (size < MO_128) {
+    if ((mop & MO_SIZE) < MO_128) {
         tcg_gen_qemu_ld_i64(tmplo, tcg_addr, get_mem_index(s), mop);
     } else {
         TCGv_i128 t16 = tcg_temp_new_i128();
@@ -2775,6 +2773,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
     bool is_signed = false;
     int size = 2;
     TCGv_i64 tcg_rt, clean_addr;
+    MemOp memop;
 
     if (is_vector) {
         if (opc == 3) {
@@ -2785,6 +2784,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
         if (!fp_access_check(s)) {
             return;
         }
+        memop = finalize_memop_asimd(s, size);
     } else {
         if (opc == 3) {
             /* PRFM (literal) : prefetch */
@@ -2792,19 +2792,19 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
         }
         size = 2 + extract32(opc, 0, 1);
         is_signed = extract32(opc, 1, 1);
+        memop = finalize_memop(s, size + is_signed * MO_SIGN);
     }
 
     tcg_rt = cpu_reg(s, rt);
 
     clean_addr = tcg_temp_new_i64();
     gen_pc_plus_diff(s, clean_addr, imm);
+
     if (is_vector) {
-        do_fp_ld(s, rt, clean_addr, size);
+        do_fp_ld(s, rt, clean_addr, memop);
     } else {
         /* Only unsigned 32bit loads target 32bit registers.  */
         bool iss_sf = opc != 0;
-        MemOp memop = finalize_memop(s, size + is_signed * MO_SIGN);
-
         do_gpr_ld(s, tcg_rt, clean_addr, memop, false, true, rt, iss_sf, false);
     }
 }
@@ -2941,16 +2941,18 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
                                 (wback || rn != 31) && !set_tag, 2 << size);
 
     if (is_vector) {
+        MemOp mop = finalize_memop_asimd(s, size);
+
         if (is_load) {
-            do_fp_ld(s, rt, clean_addr, size);
+            do_fp_ld(s, rt, clean_addr, mop);
         } else {
-            do_fp_st(s, rt, clean_addr, size);
+            do_fp_st(s, rt, clean_addr, mop);
         }
         tcg_gen_addi_i64(clean_addr, clean_addr, 1 << size);
         if (is_load) {
-            do_fp_ld(s, rt2, clean_addr, size);
+            do_fp_ld(s, rt2, clean_addr, mop);
         } else {
-            do_fp_st(s, rt2, clean_addr, size);
+            do_fp_st(s, rt2, clean_addr, mop);
         }
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
@@ -3072,6 +3074,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
         if (!fp_access_check(s)) {
             return;
         }
+        memop = finalize_memop_asimd(s, size);
     } else {
         if (size == 3 && opc == 2) {
             /* PRFM - prefetch */
@@ -3088,6 +3091,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
         is_store = (opc == 0);
         is_signed = !is_store && extract32(opc, 1, 1);
         is_extended = (size < 3) && extract32(opc, 0, 1);
+        memop = finalize_memop(s, size + is_signed * MO_SIGN);
     }
 
     switch (idx) {
@@ -3120,7 +3124,6 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     }
 
     memidx = is_unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
-    memop = finalize_memop(s, size + is_signed * MO_SIGN);
 
     clean_addr = gen_mte_check1_mmuidx(s, dirty_addr, is_store,
                                        writeback || rn != 31,
@@ -3128,9 +3131,9 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
 
     if (is_vector) {
         if (is_store) {
-            do_fp_st(s, rt, clean_addr, size);
+            do_fp_st(s, rt, clean_addr, memop);
         } else {
-            do_fp_ld(s, rt, clean_addr, size);
+            do_fp_ld(s, rt, clean_addr, memop);
         }
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
@@ -3236,9 +3239,9 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
 
     if (is_vector) {
         if (is_store) {
-            do_fp_st(s, rt, clean_addr, size);
+            do_fp_st(s, rt, clean_addr, memop);
         } else {
-            do_fp_ld(s, rt, clean_addr, size);
+            do_fp_ld(s, rt, clean_addr, memop);
         }
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
@@ -3322,9 +3325,9 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
 
     if (is_vector) {
         if (is_store) {
-            do_fp_st(s, rt, clean_addr, size);
+            do_fp_st(s, rt, clean_addr, memop);
         } else {
-            do_fp_ld(s, rt, clean_addr, size);
+            do_fp_ld(s, rt, clean_addr, memop);
         }
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
-- 
2.34.1


