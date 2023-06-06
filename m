Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C161F723E5D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:52:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIy-0007on-LR; Tue, 06 Jun 2023 05:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIp-0007jL-AN
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIk-0004nj-No
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f6042d605dso49131005e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044909; x=1688636909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8m2mp8wmyjfK8hBjizRn5hqJ9d0JSrh1YzKO3oNVgLc=;
 b=gafVz2Qr6ZdFZRNBwpatPklK0wlJk8DWVLucPj+UfpMRmD7pubd5GjbHs5WE1sLTOc
 xQH1F9iVZjKAaILRws/82OrQKQ9BLHWLbgXxjW+gzUH6nwkwxrCj2OgNKkxxtKmGrCmd
 /nCP385z2jZ+GhfOVPriMFxPH5q3TV+LtaJBy2UyOBhLJD9IF9TLooQK8088aIgLgXWi
 wUQprJR3wfto1ZE7ij/fvWce41UTaFfm3+bcszbwea6/PXp8ZzhykntKXi0IqDT3ccQv
 5taxItOyJpJEfvLPmJQBnYGtHsvbOh61rxDfo6KI1+MOS2w/WWIJxtKRQCkCofICzMLn
 4NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044909; x=1688636909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8m2mp8wmyjfK8hBjizRn5hqJ9d0JSrh1YzKO3oNVgLc=;
 b=g84ld62fwYxAiwu3Ue/LUndPIVdtrNS4J434ix6X+RidKSp7AYq5ER69pjsrteBWO5
 x4bUl73nMLe9FojDH/vX5FYsZ1BwDh7sleZoOmePF/Lpyv/XNbLhrkeJLiTU9rG4CLxL
 QTPeIzBU8oRnBct4nwF4QyNSD1k1cdG1kZg15S0Jefew65Lyb4wrrXwZUPh8aF79UW97
 w8jN8VnfyhgBbRTE/DRh77VQWalTrWgkEUci8Zg0Ec+vllRLkO8hvTqC+zC4srD9B8Nt
 4tOCAXye1olUymXRCN4o8lRjSYUoKUiarAnM0KiG6ZV651ayoVfOmCTf+y0AumYbpLTB
 C1fQ==
X-Gm-Message-State: AC+VfDxMVM3+1gtqTfLW/QYwYQT/ydeQ1YoLTD7A36at0NWJ6Vebxe6Z
 FgzafyL62ulsL7ZS45cmpwdjx6stNQfB6tCz50A=
X-Google-Smtp-Source: ACHHUZ7H+ftf5aPhnyYM6gT6NRmbM2btzJwsqFtwFmFdWpug/pbfOow3T2HXZMARwS2mxe9bRx6aVA==
X-Received: by 2002:a7b:cb94:0:b0:3f7:e48b:9754 with SMTP id
 m20-20020a7bcb94000000b003f7e48b9754mr1455353wmi.30.1686044909117; 
 Tue, 06 Jun 2023 02:48:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/42] target/arm: Sink gen_mte_check1 into load/store_exclusive
Date: Tue,  6 Jun 2023 10:47:59 +0100
Message-Id: <20230606094814.3581397-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

No need to duplicate this check across multiple call sites.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 44 ++++++++++++++++------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 35eac7729b0..729947b11a4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2369,11 +2369,16 @@ static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
  * races in multi-threaded linux-user and when MTTCG softmmu is
  * enabled.
  */
-static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
-                               TCGv_i64 addr, int size, bool is_pair)
+static void gen_load_exclusive(DisasContext *s, int rt, int rt2, int rn,
+                               int size, bool is_pair)
 {
     int idx = get_mem_index(s);
     MemOp memop;
+    TCGv_i64 dirty_addr, clean_addr;
+
+    s->is_ldex = true;
+    dirty_addr = cpu_reg_sp(s, rn);
+    clean_addr = gen_mte_check1(s, dirty_addr, false, rn != 31, size);
 
     g_assert(size <= 3);
     if (is_pair) {
@@ -2381,7 +2386,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
         if (size == 2) {
             /* The pair must be single-copy atomic for the doubleword.  */
             memop = finalize_memop(s, MO_64 | MO_ALIGN);
-            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
+            tcg_gen_qemu_ld_i64(cpu_exclusive_val, clean_addr, idx, memop);
             if (s->be_data == MO_LE) {
                 tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 0, 32);
                 tcg_gen_extract_i64(cpu_reg(s, rt2), cpu_exclusive_val, 32, 32);
@@ -2400,7 +2405,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
 
             memop = finalize_memop_atom(s, MO_128 | MO_ALIGN_16,
                                         MO_ATOM_IFALIGN_PAIR);
-            tcg_gen_qemu_ld_i128(t16, addr, idx, memop);
+            tcg_gen_qemu_ld_i128(t16, clean_addr, idx, memop);
 
             if (s->be_data == MO_LE) {
                 tcg_gen_extr_i128_i64(cpu_exclusive_val,
@@ -2414,14 +2419,14 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
         }
     } else {
         memop = finalize_memop(s, size | MO_ALIGN);
-        tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
+        tcg_gen_qemu_ld_i64(cpu_exclusive_val, clean_addr, idx, memop);
         tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
     }
-    tcg_gen_mov_i64(cpu_exclusive_addr, addr);
+    tcg_gen_mov_i64(cpu_exclusive_addr, clean_addr);
 }
 
 static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
-                                TCGv_i64 addr, int size, int is_pair)
+                                int rn, int size, int is_pair)
 {
     /* if (env->exclusive_addr == addr && env->exclusive_val == [addr]
      *     && (!is_pair || env->exclusive_high == [addr + datasize])) {
@@ -2437,9 +2442,12 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
      */
     TCGLabel *fail_label = gen_new_label();
     TCGLabel *done_label = gen_new_label();
-    TCGv_i64 tmp;
+    TCGv_i64 tmp, dirty_addr, clean_addr;
 
-    tcg_gen_brcond_i64(TCG_COND_NE, addr, cpu_exclusive_addr, fail_label);
+    dirty_addr = cpu_reg_sp(s, rn);
+    clean_addr = gen_mte_check1(s, dirty_addr, true, rn != 31, size);
+
+    tcg_gen_brcond_i64(TCG_COND_NE, clean_addr, cpu_exclusive_addr, fail_label);
 
     tmp = tcg_temp_new_i64();
     if (is_pair) {
@@ -2627,9 +2635,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (is_lasr) {
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
         }
-        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                    true, rn != 31, size);
-        gen_store_exclusive(s, rs, rt, rt2, clean_addr, size, false);
+        gen_store_exclusive(s, rs, rt, rt2, rn, size, false);
         return;
 
     case 0x4: /* LDXR */
@@ -2637,10 +2643,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (rn == 31) {
             gen_check_sp_alignment(s);
         }
-        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                    false, rn != 31, size);
-        s->is_ldex = true;
-        gen_load_exclusive(s, rt, rt2, clean_addr, size, false);
+        gen_load_exclusive(s, rt, rt2, rn, size, false);
         if (is_lasr) {
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
         }
@@ -2692,9 +2695,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             if (is_lasr) {
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
             }
-            clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                        true, rn != 31, size);
-            gen_store_exclusive(s, rs, rt, rt2, clean_addr, size, true);
+            gen_store_exclusive(s, rs, rt, rt2, rn, size, true);
             return;
         }
         if (rt2 == 31
@@ -2711,10 +2712,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             if (rn == 31) {
                 gen_check_sp_alignment(s);
             }
-            clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                        false, rn != 31, size);
-            s->is_ldex = true;
-            gen_load_exclusive(s, rt, rt2, clean_addr, size, true);
+            gen_load_exclusive(s, rt, rt2, rn, size, true);
             if (is_lasr) {
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
             }
-- 
2.34.1


