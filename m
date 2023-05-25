Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04633711AA5
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:28:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLc-0005tJ-MO; Thu, 25 May 2023 19:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLV-0005my-Af
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLP-0005mE-Mc
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ae54b623c2so1334965ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057166; x=1687649166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVXqrkVpUbyPr7RXHtkXkDFqvAZ64HbnSrMT6ekrwjQ=;
 b=RkhP/7yWw+36cAz83PwT2CYCN5s3wwyz6N9sqeO+Cqn9dZ8Yn3QlVxWZN8uMlGDLNA
 kkgnRS5EUBMOC9duEz9smrpgmP4LbCgBzYNZqRpLJUvV+ozmProOjtkYO/ZnIt88xJms
 1OavXsgy8do2Qh5r1cK+KAgNN0b0bE4LPBEevhlhAOcBynQGdF6itdfJ3uih0mxh8uPO
 QQiO2/WES4YZaecJbc8Jaq5JBmmmQennUDsLaeWtPcjYdZrLQxpxEWn5rv90Alnp7hVZ
 g25QYmwtx5B8GB7el7NStAfIwBSxhi9SiGCGqvgY7dNL1D79dBEpffnCpx9dXVTgNx8e
 0v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057166; x=1687649166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVXqrkVpUbyPr7RXHtkXkDFqvAZ64HbnSrMT6ekrwjQ=;
 b=blHGb05Wdjoi7GPob6/ym4a/3QCC6kWDPTCfC2FJWr3YJXhKRVEFj9Fy6goWkNwLwG
 aBNabCN1XBojJuchfRpDjVoWktXmC2NmnS95sy6+3B0gkUUtB6kFmtBmk8Nl/EgYCwd7
 Dpo4GVI6WoehtCR8xZFU7vYThKdH/sWAu6oDzLg71UdcdY8GAswOUhKwvE3srDaji/2u
 aEqROB48cMgiaAInUHirdnjh04B0DMgIP7BreH/lkELq6a9eI50YXdzMBdSBxt10AS4L
 2PTpGGgCSKMjztBkN4po0M1Nx5A5EHwMrOYIP6k01NkAb+WkNeAZ/Oq+HNQ/qmiiDiEb
 sNZw==
X-Gm-Message-State: AC+VfDxoPz9frMvFFvbTWMdNYMThmOZ1RCb21VgAilWlmHaB39XE+/Qy
 jtfdIwcK9PCAVWNZ6jzIS3AfoXbpUb2Hj5HVrCQ=
X-Google-Smtp-Source: ACHHUZ4TbPytax1OWQcNHR5GaykKk/PXhuYOXJwIvBHvEOXWjLyvl2QaPez7/k6BsFbXXtgH4IZNqA==
X-Received: by 2002:a17:902:7c05:b0:1af:bb99:d590 with SMTP id
 x5-20020a1709027c0500b001afbb99d590mr373853pll.7.1685057166046; 
 Thu, 25 May 2023 16:26:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 08/20] target/arm: Sink gen_mte_check1 into
 load/store_exclusive
Date: Thu, 25 May 2023 16:25:46 -0700
Message-Id: <20230525232558.1758967-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

No need to duplicate this check across multiple call sites.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 44 ++++++++++++++++------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 51f9d227e7..19f0f20896 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2381,11 +2381,16 @@ static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
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
@@ -2393,7 +2398,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
         if (size == 2) {
             /* The pair must be single-copy atomic for the doubleword.  */
             memop = finalize_memop(s, MO_64 | MO_ALIGN);
-            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
+            tcg_gen_qemu_ld_i64(cpu_exclusive_val, clean_addr, idx, memop);
             if (s->be_data == MO_LE) {
                 tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 0, 32);
                 tcg_gen_extract_i64(cpu_reg(s, rt2), cpu_exclusive_val, 32, 32);
@@ -2412,7 +2417,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
 
             memop = finalize_memop_atom(s, MO_128 | MO_ALIGN_16,
                                         MO_ATOM_IFALIGN_PAIR);
-            tcg_gen_qemu_ld_i128(t16, addr, idx, memop);
+            tcg_gen_qemu_ld_i128(t16, clean_addr, idx, memop);
 
             if (s->be_data == MO_LE) {
                 tcg_gen_extr_i128_i64(cpu_exclusive_val,
@@ -2426,14 +2431,14 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
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
@@ -2449,9 +2454,12 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
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
@@ -2639,9 +2647,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (is_lasr) {
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
         }
-        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                    true, rn != 31, size);
-        gen_store_exclusive(s, rs, rt, rt2, clean_addr, size, false);
+        gen_store_exclusive(s, rs, rt, rt2, rn, size, false);
         return;
 
     case 0x4: /* LDXR */
@@ -2649,10 +2655,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
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
@@ -2704,9 +2707,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
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
@@ -2723,10 +2724,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
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


