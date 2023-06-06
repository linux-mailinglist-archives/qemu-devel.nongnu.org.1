Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E63723E44
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:50:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TJ5-0007wZ-Li; Tue, 06 Jun 2023 05:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TJ3-0007up-B5
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:49 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIl-0004oq-Vi
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:48 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30aea656e36so4799380f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044910; x=1688636910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3IMRMdmWIJL4NOrL8D2fUiVSHGs20xuwlZJEYnyy85M=;
 b=gj801N93tvRDPlllGmmfcCybXJom+fHQGUeulcQ9kgt9oqAMvXK6o/a4EKtZE0NJN2
 JTKzHxU59PbuoD+mOJRKYQcjsU03BDzpyShgtzY5Vncq5R7zUgKBu/vVDIkx47XKcwXa
 p4Thx+PR1AxY38w5az641JRRN4GNUzSUtEUhOfEg25nOWvtNFnMSRcvejLRIK8OFW1xo
 3lYr12j8DbhT9JmDhAXGwJ81E5iYIyV4P8qISQD9nJCdhEsD5YPfYJzwGGdQcBe5s1Us
 seJu1J/6Gtj9TrPTCl52xnP/WJ1xVqetJJI8b1YkVTuZpeI+MuaosGv/ie5aqyq/XKyr
 M2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044910; x=1688636910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IMRMdmWIJL4NOrL8D2fUiVSHGs20xuwlZJEYnyy85M=;
 b=dzqfUK+Bf5fVk2C0QUYaX2uizo3s2BmIo8RNM48JEcZuOke3LE5kF0MEQb6pzi89ep
 1wLz2TrcL9fvCoSTKRfmlyF+8QlIX314BLmScGe1hukofUKAj5gXs3oaDHhysJM8bslG
 oeuwL5jjvv0o9ir46oAeL85yHUBdTZ1voK1Q1KsC2ew4ZsuN1NbhsTmt9zo3kjcYhVD6
 xgQaV8+irNcgSRjaxzU7xLCcGUsMuJcgSifG8So8TCxx1KlXq//upsGZ6Bt5+D2W5d6s
 oJioBJD25KhoTCb4Atf08/Apl9N/LpkZSL5dxnmzHYfEhLsM4XHfaWwOANnUX9rsklpF
 r8hA==
X-Gm-Message-State: AC+VfDzuwHEcKkNW9Fs+kmFXCs932OIkapRt92iCKmAz6euFt8ILFCJ3
 tehW4fATXL7VwTuznmWfwjpXT3FliR1VXGpuQmQ=
X-Google-Smtp-Source: ACHHUZ4cbRUt2LNYzAt6i4a2OEp+JIOx2DUNrwlsLrROoVKJoI96t4JeYLEEeTcwM43OekJDfCrkEw==
X-Received: by 2002:adf:e5c6:0:b0:30e:5380:5eb3 with SMTP id
 a6-20020adfe5c6000000b0030e53805eb3mr22296wrn.33.1686044910426; 
 Tue, 06 Jun 2023 02:48:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/42] target/arm: Hoist finalize_memop out of do_fp_{ld, st}
Date: Tue,  6 Jun 2023 10:48:02 +0100
Message-Id: <20230606094814.3581397-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

We are going to need the complete memop beforehand,
so let's not compute it twice.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 43 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d90e8661ca5..3e93f6e848e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -905,15 +905,14 @@ static void do_gpr_ld(DisasContext *s, TCGv_i64 dest, TCGv_i64 tcg_addr,
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
@@ -929,14 +928,13 @@ static void do_fp_st(DisasContext *s, int srcidx, TCGv_i64 tcg_addr, int size)
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
@@ -2763,6 +2761,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
     bool is_signed = false;
     int size = 2;
     TCGv_i64 tcg_rt, clean_addr;
+    MemOp memop;
 
     if (is_vector) {
         if (opc == 3) {
@@ -2773,6 +2772,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
         if (!fp_access_check(s)) {
             return;
         }
+        memop = finalize_memop_asimd(s, size);
     } else {
         if (opc == 3) {
             /* PRFM (literal) : prefetch */
@@ -2780,19 +2780,19 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
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
@@ -2929,16 +2929,18 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
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
@@ -3060,6 +3062,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
         if (!fp_access_check(s)) {
             return;
         }
+        memop = finalize_memop_asimd(s, size);
     } else {
         if (size == 3 && opc == 2) {
             /* PRFM - prefetch */
@@ -3076,6 +3079,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
         is_store = (opc == 0);
         is_signed = !is_store && extract32(opc, 1, 1);
         is_extended = (size < 3) && extract32(opc, 0, 1);
+        memop = finalize_memop(s, size + is_signed * MO_SIGN);
     }
 
     switch (idx) {
@@ -3108,7 +3112,6 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     }
 
     memidx = is_unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
-    memop = finalize_memop(s, size + is_signed * MO_SIGN);
 
     clean_addr = gen_mte_check1_mmuidx(s, dirty_addr, is_store,
                                        writeback || rn != 31,
@@ -3116,9 +3119,9 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
 
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
@@ -3224,9 +3227,9 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
 
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
@@ -3310,9 +3313,9 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
 
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


