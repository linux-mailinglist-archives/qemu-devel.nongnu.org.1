Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52746723E6A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:53:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIt-0007n4-Ss; Tue, 06 Jun 2023 05:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIr-0007lK-3z
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:37 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIn-0004pU-45
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30c55d2b9f3so4257386f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044911; x=1688636911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CgXGqqHmHxh9IvjW0W6EJGkiJZ/xxqMV4YgEDbgJoDw=;
 b=sO8kphV6vu8vNl0yLf8uUGfovEbiGKqwvYcIzSA15jRmUeVBY6QmU58rtbYB3fX77n
 SE7/4JwHNNP+fPur5SWJ9t5wBJmheutMzuKliOQsx3uAylh1gD5G9fP9Gt7KzgMWzmyl
 Ece2ThEDe/Hg/RsShhrnqFFUffuADQIgm6rdWZwmLFGxy3hooOKPzisnL8jI3ofUnwA1
 3iR1OUUvuGtexg1J0Fij7dr0CjDfP7BhHqgGEOOO7JxKXpr6lofwZFBT7GdR9jE6WpyV
 nBRiXH8ssdeiV8JyPEUssy/NfnyVLYI/WRHz4KfiLFabwURtzDNZi+y40YDqgD+MdYUy
 9jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044911; x=1688636911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CgXGqqHmHxh9IvjW0W6EJGkiJZ/xxqMV4YgEDbgJoDw=;
 b=C7qJVYm2x3qHaUg3x17yUB9ODXSfrCjQAmgf3F1Nplh76jAwWTBjGxRR3oeoim3i69
 tG2VY5n1Lgfu1KgSDenW5vtNaifQeUBLKDTXC7rSl4PV7vBK3yMxhR8Ei7/4nAvy/1SQ
 hM6gdrz2hRTyyZxP8VLavyroqHuyuwB/CLc9QlBwubXnNUBbXfF35VF/jxmgbY5cmBpb
 glaOAlu9WQE6rbeBkf0RZFHG4cKY0hRY0We6YAeVozXIGvI2M6SeOGH1TBfFgG0dRBUS
 lfZMeWGERN8PKReg7c4NCa0I98V/Nh/cplGyb4an0pIKyadb5+lwe5yJLJYSu8IVzy+z
 KB8w==
X-Gm-Message-State: AC+VfDynEuDkPq2pBJ8VGU3gat3wxkNqesa9EAt418iboy9LnT2NAjSP
 xmoICZzdI3CzfsXJk2+XVLtOoUlbMyPjRRx2Umg=
X-Google-Smtp-Source: ACHHUZ41zl/ZW5+TW+8ZeYXbNuVzqLzdhOj3iVklBbUqgs88AV1Xokp5wVjVbbihVkjh+hvq02pqRA==
X-Received: by 2002:a5d:448d:0:b0:306:2c16:8359 with SMTP id
 j13-20020a5d448d000000b003062c168359mr1340093wrq.39.1686044911678; 
 Tue, 06 Jun 2023 02:48:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/42] target/arm: Pass single_memop to gen_mte_checkN
Date: Tue,  6 Jun 2023 10:48:04 +0100
Message-Id: <20230606094814.3581397-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Pass the individual memop to gen_mte_checkN.
For the moment, do nothing with it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.h |  2 +-
 target/arm/tcg/translate-a64.c | 31 +++++++++++++++++++------------
 target/arm/tcg/translate-sve.c |  4 ++--
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index cecf2bab8f6..b55dc435fc5 100644
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
index 85d896e9752..0b600695965 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -285,7 +285,7 @@ TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
  * For MTE, check multiple logical sequential accesses.
  */
 TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
-                        bool tag_checked, int size)
+                        bool tag_checked, int total_size, MemOp single_mop)
 {
     if (tag_checked && s->mte_active[0]) {
         TCGv_i64 ret;
@@ -295,7 +295,7 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, size - 1);
+        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, total_size - 1);
 
         ret = tcg_temp_new_i64();
         gen_helper_mte_check(ret, cpu_env, tcg_constant_i32(desc), addr);
@@ -2841,14 +2841,12 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
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
@@ -2931,12 +2929,17 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
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
@@ -2951,9 +2954,11 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
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
@@ -2963,6 +2968,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
          * This treats sign-extending loads like zero-extending loads,
          * since that reuses the most code below.
          */
+        mop = size + 1;
         if (s->align_mem) {
             mop |= (size == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
         }
@@ -3741,7 +3747,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
      * promote consecutive little-endian elements below.
      */
     clean_addr = gen_mte_checkN(s, tcg_rn, is_store, is_postidx || rn != 31,
-                                total);
+                                total, finalize_memop(s, size));
 
     /*
      * Consecutive little-endian elements from a single register
@@ -3899,10 +3905,11 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
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
index 671d2efa85d..ff050626e66 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4176,7 +4176,7 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
 
     dirty_addr = tcg_temp_new_i64();
     tcg_gen_addi_i64(dirty_addr, cpu_reg_sp(s, rn), imm);
-    clean_addr = gen_mte_checkN(s, dirty_addr, false, rn != 31, len);
+    clean_addr = gen_mte_checkN(s, dirty_addr, false, rn != 31, len, MO_8);
 
     /*
      * Note that unpredicated load/store of vector/predicate registers
@@ -4278,7 +4278,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
 
     dirty_addr = tcg_temp_new_i64();
     tcg_gen_addi_i64(dirty_addr, cpu_reg_sp(s, rn), imm);
-    clean_addr = gen_mte_checkN(s, dirty_addr, false, rn != 31, len);
+    clean_addr = gen_mte_checkN(s, dirty_addr, false, rn != 31, len, MO_8);
 
     /* Note that unpredicated load/store of vector/predicate registers
      * are defined as a stream of bytes, which equates to little-endian
-- 
2.34.1


