Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A643711AA3
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:28:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLi-0005ws-0c; Thu, 25 May 2023 19:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLa-0005rG-43
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:18 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLV-0005oA-2a
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1afa6afcf4fso1525555ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057170; x=1687649170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QxG0bahKcXSUtA6+ptPNjNIckP34vwB5oyRvje+RLk=;
 b=LYX0rx6FkstjNBRrdzkA/o8sg/W1+eEkxH6y1Pn/51qk0fkZ1Nd7WzgnPQMqwEXBkg
 oHauMzD7KXrDjNE/EQ4D3vDNkgZ8R/gnP+DidBLUYd98IJ88Z+gjxnX/hWVmHfn6O+RT
 WIZvPFmVAsqWYCVaUuX9XNCLrk4M/Xwlrk67nr0TX6GgKXNTrV5ZWkpm3yWXgxO14RWl
 akr2Xk7lR5AkwTeeBhubxTv6WtGrZ0VhOUZUpIVFKNhhfbpMQE3dC52zKuhlrMgeAgVh
 ZhON7+fSltH46SidEJ/v92cqcNlS+i+2NOuS+QIS9g1t7A/S/sIKllyW7NRAmq3/cjhH
 ekBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057170; x=1687649170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QxG0bahKcXSUtA6+ptPNjNIckP34vwB5oyRvje+RLk=;
 b=PX1eADPFkN+wXUzm4DtcgRYQTxzdnaIk+auuzUjZGBvivSJ5InUVK6LcR3nWLjrYlX
 zZO/HbR0uVXRRqHpB44rm34t4r0zZp0/6FnDgipQHIypEVNT8PM9fY5TV8f/eQ5dWiEw
 5Afn61+rbWsyWdxNfG5zHrc1bguxMyeZAA3F3oo4ZZGqY3RfCCquaA+FEna//UvlsiHd
 L2tkXwRahPcq++6rS7L8WosGqDNB1OijLPdXInqOLaP+g9yNu/uDvadIvKD/yHEd7Hpn
 J62QuXXyL33TuuglfI0ecnVXqNGZQ7YLb9U6q+nVchgk7wD4D51Ee/ngApzmWLr4wfnk
 agIg==
X-Gm-Message-State: AC+VfDypc9KvcwlI7XN/jMGpTIsYU5xXzDvG39FrfGhdexy02l99nwm9
 9CGDHgXLjp0WxNmxSVAYGr7eIX2Taxhi60HzBOE=
X-Google-Smtp-Source: ACHHUZ5E6UvIW6ngV+rbXnBi4hlNgg84enCCztc3fYFJ8ZUq/K5+Q0nWGpaXqsoJkt4DLa6sKdIeRA==
X-Received: by 2002:a17:902:db02:b0:1ae:6135:a050 with SMTP id
 m2-20020a170902db0200b001ae6135a050mr498582plx.19.1685057170195; 
 Thu, 25 May 2023 16:26:10 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 13/20] target/arm: Pass single_memop to gen_mte_checkN
Date: Thu, 25 May 2023 16:25:51 -0700
Message-Id: <20230525232558.1758967-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


