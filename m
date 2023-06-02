Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5177206A2
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574v-0003CL-TW; Fri, 02 Jun 2023 11:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574t-0003B8-NP
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:35 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574q-0003Su-2D
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30c4c1fd511so1498281f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721150; x=1688313150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EEoCGtTV/Xe6vXxMlBDKyD8Heo9qu37gFRA53k9Pqe4=;
 b=qKIwXDebAZpKEYxq23C063dR1P3XPlQCYs/Ac3qY/YsmnIQUgIrI6QkzkYvqEA8Ttn
 HmxL+QXSN1HDzzugaWsBQtSHwNOEtdEqpba+4CMdyr/dAauqhhd5K1v68jzfkOnPr44K
 wE0obCqfXJyZqifLh99yDVnSQ5yybAClVDoo49QFLj8KX6uEwqAQrsKca3Z3pPuliTnJ
 0FxROkKMcGj0WtA5JsgnYwH3oPxKpElYf7uwsjdaXwoi/0cYD2XBTfzxlL/98T2hudin
 pcW5hMad3AiUQQgXm0WoHeEP9c0sUwiJMNcLa7b5cVRpHnUPntsMZJjFMPlNkZ5nKbTg
 AJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721150; x=1688313150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEoCGtTV/Xe6vXxMlBDKyD8Heo9qu37gFRA53k9Pqe4=;
 b=FbAxp0+SB1lXs7pbvnUUTVSWzusPWBUbwczKcxjsQv/P5dgOoDlmz1z3ySanP/r7iq
 t64fd6ajKI7NBlI1lGshzefQyfCyV/KQOgkycBOCz2zOdTvOF2XcMIi/W6ctBeia3Kvs
 CQXh0ct0IAZnPAYO8wpPW1tymqZyLcNRbRXIqp3ZqyB2YhJWfB8pqw0904JSNLzjnIuo
 Qshs4xeSQ2nRPzdPrdfL9dnUGP+EgwiXSMYpf+IHfhwLrQVx7JJ6NKaEBXnL7a687Eg8
 nSomRwfJeKXp/zVKLTPvLVyMJhCQgBM//J8xt968cQYD+ZmQu0Wxa+Zoej7M3DMNcs68
 tldw==
X-Gm-Message-State: AC+VfDyF/Xew7pSbx4zAg/xCHtNc5Sp6W7cH7OHGQfgAmTCW53zuijQi
 Q8LmzkkOwLln+8ttSrrYATgB7c5K+NErWIR8djQ=
X-Google-Smtp-Source: ACHHUZ748G3rDpiJReGeSDF1WVMVMMfUgdF3kakoKcfwc8IeEK5Ah0F962Oeb2n+nyBoA/+MmR3AQg==
X-Received: by 2002:adf:e606:0:b0:309:5029:b075 with SMTP id
 p6-20020adfe606000000b003095029b075mr323721wrm.13.1685721150711; 
 Fri, 02 Jun 2023 08:52:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/20] target/arm: Convert LDXP, STXP, CASP, CAS to decodetree
Date: Fri,  2 Jun 2023 16:52:12 +0100
Message-Id: <20230602155223.2040685-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
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

Convert the load/store exclusive pair (LDXP, STXP, LDAXP, STLXP),
compare-and-swap pair (CASP, CASPA, CASPAL, CASPL), and compare-and
swap (CAS, CASA, CASAL, CASL) instructions to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  10 +++
 target/arm/tcg/translate-a64.c | 132 ++++++++++++---------------------
 2 files changed, 59 insertions(+), 83 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b9b32490cef..2b4827384b5 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -237,7 +237,17 @@ HLT             1101 0100 010 ................ 000 00 @i16
 &stlr           rn rt sz lasr
 @stxr           sz:2 ...... ... rs:5 lasr:1 rt2:5 rn:5 rt:5 &stxr
 @stlr           sz:2 ...... ... ..... lasr:1 ..... rn:5 rt:5 &stlr
+%imm1_30_p2 30:1 !function=plus_2
+@stxp           .. ...... ... rs:5 lasr:1 rt2:5 rn:5 rt:5 &stxr sz=%imm1_30_p2
 STXR            .. 001000 000 ..... . ..... ..... ..... @stxr  # inc STLXR
 LDXR            .. 001000 010 ..... . ..... ..... ..... @stxr  # inc LDAXR
 STLR            .. 001000 100 11111 . 11111 ..... ..... @stlr  # inc STLLR
 LDAR            .. 001000 110 11111 . 11111 ..... ..... @stlr  # inc LDLAR
+
+STXP            1 . 001000 001 ..... . ..... ..... ..... @stxp # inc STLXP
+LDXP            1 . 001000 011 ..... . ..... ..... ..... @stxp # inc LDAXP
+
+# CASP, CASPA, CASPAL, CASPL
+CASP            0 . 001000 0 a:1 1 rs:5 lasr:1 11111 rn:5 rt:5 sz=%imm1_30_p2
+# CAS, CASA, CASAL, CASL
+CAS             sz:2 001000 1 a:1 1 rs:5 lasr:1 11111 rn:5 rt:5
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2a5c4eea02f..ce4cf1a3878 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2656,90 +2656,59 @@ static bool trans_LDAR(DisasContext *s, arg_stlr *a)
     return true;
 }
 
-/* Load/store exclusive
- *
- *  31 30 29         24  23  22   21  20  16  15  14   10 9    5 4    0
- * +-----+-------------+----+---+----+------+----+-------+------+------+
- * | sz  | 0 0 1 0 0 0 | o2 | L | o1 |  Rs  | o0 |  Rt2  |  Rn  | Rt   |
- * +-----+-------------+----+---+----+------+----+-------+------+------+
- *
- *  sz: 00 -> 8 bit, 01 -> 16 bit, 10 -> 32 bit, 11 -> 64 bit
- *   L: 0 -> store, 1 -> load
- *  o2: 0 -> exclusive, 1 -> not
- *  o1: 0 -> single register, 1 -> register pair
- *  o0: 1 -> load-acquire/store-release, 0 -> not
- */
-static void disas_ldst_excl(DisasContext *s, uint32_t insn)
+static bool trans_STXP(DisasContext *s, arg_stxr *a)
 {
-    int rt = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int rt2 = extract32(insn, 10, 5);
-    int rs = extract32(insn, 16, 5);
-    int is_lasr = extract32(insn, 15, 1);
-    int o2_L_o1_o0 = extract32(insn, 21, 3) * 2 | is_lasr;
-    int size = extract32(insn, 30, 2);
     TCGv_i64 clean_addr;
 
-    switch (o2_L_o1_o0) {
-    case 0x2: case 0x3: /* CASP / STXP */
-        if (size & 2) { /* STXP / STLXP */
-            if (rn == 31) {
-                gen_check_sp_alignment(s);
-            }
-            if (is_lasr) {
-                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-            }
-            clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                        true, rn != 31, size);
-            gen_store_exclusive(s, rs, rt, rt2, clean_addr, size, true);
-            return;
-        }
-        if (rt2 == 31
-            && ((rt | rs) & 1) == 0
-            && dc_isar_feature(aa64_atomics, s)) {
-            /* CASP / CASPL */
-            gen_compare_and_swap_pair(s, rs, rt, rn, size | 2);
-            return;
-        }
-        break;
-
-    case 0x6: case 0x7: /* CASPA / LDXP */
-        if (size & 2) { /* LDXP / LDAXP */
-            if (rn == 31) {
-                gen_check_sp_alignment(s);
-            }
-            clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                        false, rn != 31, size);
-            s->is_ldex = true;
-            gen_load_exclusive(s, rt, rt2, clean_addr, size, true);
-            if (is_lasr) {
-                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
-            }
-            return;
-        }
-        if (rt2 == 31
-            && ((rt | rs) & 1) == 0
-            && dc_isar_feature(aa64_atomics, s)) {
-            /* CASPA / CASPAL */
-            gen_compare_and_swap_pair(s, rs, rt, rn, size | 2);
-            return;
-        }
-        break;
-
-    case 0xa: /* CAS */
-    case 0xb: /* CASL */
-    case 0xe: /* CASA */
-    case 0xf: /* CASAL */
-        if (rt2 == 31 && dc_isar_feature(aa64_atomics, s)) {
-            gen_compare_and_swap(s, rs, rt, rn, size);
-            return;
-        }
-        break;
-    default:
-        /* Handled in decodetree */
-        break;
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
     }
-    unallocated_encoding(s);
+    if (a->lasr) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    }
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn),
+                                true, a->rn != 31, a->sz);
+    gen_store_exclusive(s, a->rs, a->rt, a->rt2, clean_addr, a->sz, true);
+    return true;
+}
+
+static bool trans_LDXP(DisasContext *s, arg_stxr *a)
+{
+    TCGv_i64 clean_addr;
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn),
+                                false, a->rn != 31, a->sz);
+    s->is_ldex = true;
+    gen_load_exclusive(s, a->rt, a->rt2, clean_addr, a->sz, true);
+    if (a->lasr) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    }
+    return true;
+}
+
+static bool trans_CASP(DisasContext *s, arg_CASP *a)
+{
+    if (!dc_isar_feature(aa64_atomics, s)) {
+        return false;
+    }
+    if (((a->rt | a->rs) & 1) != 0) {
+        return false;
+    }
+
+    gen_compare_and_swap_pair(s, a->rs, a->rt, a->rn, a->sz);
+    return true;
+}
+
+static bool trans_CAS(DisasContext *s, arg_CAS *a)
+{
+    if (!dc_isar_feature(aa64_atomics, s)) {
+        return false;
+    }
+    gen_compare_and_swap(s, a->rs, a->rt, a->rn, a->sz);
+    return true;
 }
 
 /*
@@ -4098,9 +4067,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
 static void disas_ldst(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 24, 6)) {
-    case 0x08: /* Load/store exclusive */
-        disas_ldst_excl(s, insn);
-        break;
     case 0x18: case 0x1c: /* Load register (literal) */
         disas_ld_lit(s, insn);
         break;
-- 
2.34.1


