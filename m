Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F618716D50
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:17:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o5-0006gy-BT; Tue, 30 May 2023 15:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44o2-0006Kc-RE
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:54 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nz-0004hr-Pa
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:53 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-53fbb3a013dso841218a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474090; x=1688066090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QxG0bahKcXSUtA6+ptPNjNIckP34vwB5oyRvje+RLk=;
 b=HMnYSCtgMSNKMf9kyS9pmrCKj5oxdROVDhfHzQyTmRqhJJ3NOchCBkTzTVkNelXEBR
 WH12Kyduh+2CE8VTkahx3dBwm8kqNEnZByRdNkYz3kJj0H/OJqkCeb2vaDJeky0nKQrK
 29cLi7HXZl107IfI8Rx8PDVnrYLSlQR+YXTyzuX/zfdDaH2mEzy1vGvFYKqfGafxie25
 arE0r4z8g0N4ls7oDCR5/zvWzO0g2heqqBo/waUAg+bMxj43GnVcqKa7K/CpZS1crylI
 Hz+PdyubBCD/YY/wQ4qYhYbqrPqLltsjCmjl/qd3sDueGUl1oxrVC4byHAfz4/sDXT8Q
 481A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474090; x=1688066090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QxG0bahKcXSUtA6+ptPNjNIckP34vwB5oyRvje+RLk=;
 b=a2pruIKz6zAPPQzfh9WSEG9HgsYrBbiDOdDIC63Uw+RZiRsETWQ4+pD/sCT722fVKd
 ueHhaVOzwzRjnKeUU3kpYZaBvXlCe7hMxeEz4s5qlmR/3O9LBP8uKRWV1WquTXFj6Lwp
 o5hmWaqDCOMGhywSXyPF4H/xbLw7wD7gMimnLRw7C9MMHHRwufww0snteTqlGCcE/X/V
 /XJ4m3HSiH9DkgoXB6yjUCdmRjOjKDQHyLqhC7NX2XmhHGxOinGixaJzSdha7f2A2/YO
 2qTimifJeeCdqGxGkr5krLl0aiICSyc4gyfLD7MXu24jE9Bd5FnHuVVBa7ohxIRH7bxL
 32cA==
X-Gm-Message-State: AC+VfDyGcqs4hKRCC60/kFvXA0vs5YSssH7cTZsXZNy3pjqAt++w/4z5
 mgccbbfG+zX+gC+DdPuEijsIyHS+bcOw2s19/uY=
X-Google-Smtp-Source: ACHHUZ7d/HDomnUVkjvBaZ+UczKU5skzlIlhFfv5PxamDV6i3iyY1pdXp27PuT0OZk9lhtTO2t2n7A==
X-Received: by 2002:a17:90a:38c7:b0:255:5a5e:df22 with SMTP id
 x65-20020a17090a38c700b002555a5edf22mr3391662pjb.43.1685474090444; 
 Tue, 30 May 2023 12:14:50 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 13/20] target/arm: Pass single_memop to gen_mte_checkN
Date: Tue, 30 May 2023 12:14:31 -0700
Message-Id: <20230530191438.411344-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Pass the individual memop to gen_mte_checkN.
For the moment, do nothing with it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.h |  2 +-
 target/arm/tcg/translate-a64.c | 31 +++++++++++++++++++------------
 target/arm/tcg/translate-sve.c |  4 ++--
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index cecf2bab8f..b55dc435fc 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -51,7 +51,7 @@ TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr);
 TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
                         bool tag_checked, MemOp memop);
 TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
-                        bool tag_checked, int size);
+                        bool tag_checked, int total_size, MemOp memop);
 
 /* We should have at some point before trying to access an FP register
  * done the necessary access check, so assert that
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2a7be5c745..214a9b1638 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -295,7 +295,7 @@ TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
  * For MTE, check multiple logical sequential accesses.
  */
 TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
-                        bool tag_checked, int size)
+                        bool tag_checked, int total_size, MemOp single_mop)
 {
     if (tag_checked && s->mte_active[0]) {
         TCGv_i64 ret;
@@ -305,7 +305,7 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, size - 1);
+        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, total_size - 1);
 
         ret = tcg_temp_new_i64();
         gen_helper_mte_check(ret, cpu_env, tcg_constant_i32(desc), addr);
@@ -2853,14 +2853,12 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     bool is_vector = extract32(insn, 26, 1);
     bool is_load = extract32(insn, 22, 1);
     int opc = extract32(insn, 30, 2);
-
     bool is_signed = false;
     bool postindex = false;
     bool wback = false;
     bool set_tag = false;
-
     TCGv_i64 clean_addr, dirty_addr;
-
+    MemOp mop;
     int size;
 
     if (opc == 3) {
@@ -2943,12 +2941,17 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
         }
     }
 
+    if (is_vector) {
+        mop = finalize_memop_asimd(s, size);
+    } else {
+        mop = finalize_memop(s, size);
+    }
     clean_addr = gen_mte_checkN(s, dirty_addr, !is_load,
-                                (wback || rn != 31) && !set_tag, 2 << size);
+                                (wback || rn != 31) && !set_tag,
+                                2 << size, mop);
 
     if (is_vector) {
-        MemOp mop = finalize_memop_asimd(s, size);
-
+        /* LSE2 does not merge FP pairs; leave these as separate operations. */
         if (is_load) {
             do_fp_ld(s, rt, clean_addr, mop);
         } else {
@@ -2963,9 +2966,11 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
         TCGv_i64 tcg_rt2 = cpu_reg(s, rt2);
-        MemOp mop = size + 1;
 
         /*
+         * We built mop above for the single logical access -- rebuild it
+         * now for the paired operation.
+         *
          * With LSE2, non-sign-extending pairs are treated atomically if
          * aligned, and if unaligned one of the pair will be completely
          * within a 16-byte block and that element will be atomic.
@@ -2975,6 +2980,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
          * This treats sign-extending loads like zero-extending loads,
          * since that reuses the most code below.
          */
+        mop = size + 1;
         if (s->align_mem) {
             mop |= (size == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
         }
@@ -3753,7 +3759,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
      * promote consecutive little-endian elements below.
      */
     clean_addr = gen_mte_checkN(s, tcg_rn, is_store, is_postidx || rn != 31,
-                                total);
+                                total, finalize_memop(s, size));
 
     /*
      * Consecutive little-endian elements from a single register
@@ -3911,10 +3917,11 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     total = selem << scale;
     tcg_rn = cpu_reg_sp(s, rn);
 
-    clean_addr = gen_mte_checkN(s, tcg_rn, !is_load, is_postidx || rn != 31,
-                                total);
     mop = finalize_memop(s, scale);
 
+    clean_addr = gen_mte_checkN(s, tcg_rn, !is_load, is_postidx || rn != 31,
+                                total, mop);
+
     tcg_ebytes = tcg_constant_i64(1 << scale);
     for (xs = 0; xs < selem; xs++) {
         if (replicate) {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 18ab5bf7c6..1eea6ab5ac 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4187,7 +4187,7 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
 
     dirty_addr = tcg_temp_new_i64();
     tcg_gen_addi_i64(dirty_addr, cpu_reg_sp(s, rn), imm);
-    clean_addr = gen_mte_checkN(s, dirty_addr, false, rn != 31, len);
+    clean_addr = gen_mte_checkN(s, dirty_addr, false, rn != 31, len, MO_8);
 
     /*
      * Note that unpredicated load/store of vector/predicate registers
@@ -4289,7 +4289,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
 
     dirty_addr = tcg_temp_new_i64();
     tcg_gen_addi_i64(dirty_addr, cpu_reg_sp(s, rn), imm);
-    clean_addr = gen_mte_checkN(s, dirty_addr, false, rn != 31, len);
+    clean_addr = gen_mte_checkN(s, dirty_addr, false, rn != 31, len, MO_8);
 
     /* Note that unpredicated load/store of vector/predicate registers
      * are defined as a stream of bytes, which equates to little-endian
-- 
2.34.1


