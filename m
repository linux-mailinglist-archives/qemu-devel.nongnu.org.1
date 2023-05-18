Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7754A7081C9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:52:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6Y-0004IC-S0; Thu, 18 May 2023 08:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6Q-0004Bl-4A
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6L-00080i-Jd
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f49bf0223cso19415455e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414274; x=1687006274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KPbocWaggxSVkxKTVO05DNcZGruO9AVgr5QQFu9P3DA=;
 b=SeXJgGfH73wzZ0ZXIzLJu+VasEZ1jl/tTx/Iynh9W2/VWp/H0eI4MN75PMMu03yKm7
 cfkm5UwePxZx8xKQSLKnBJdKg1l2mYPQ9284YKPLc46GRvA1tiBwbXHwIpyWNAd6vxAU
 s6WctZobj+i8GMmBqaGwsRdl+GYP+tvPvX3Lpod3Vacb6clHMBQrMAwYpfqwlbX2WJU7
 mT4P/zdgKLMFOwl/6Ef5TbHeIgImUdS2IAs4rYyouUA9H3KfkSAwjN5bMzyrih7Si5t1
 vvXnnDbthebYdwFq0WBXzJXsMxaVPu8er3hF/z8M2zquTG6PrMDv/HEVbZSNIY6J+EYr
 Ss5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414274; x=1687006274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPbocWaggxSVkxKTVO05DNcZGruO9AVgr5QQFu9P3DA=;
 b=CdS075or/WxLKNmJvptlChRHKBmElBgvIg6vgo+dBNEvctbyM1uW7CkPE+LARdvyXh
 alPvclGEZeVZhYjNSZ6iPsXdLhOvP36vdH9yx8UUYMfLXedJCNv4kGpjfHZJ7SUAehVL
 ZF29xGgMflk8VY0OaO/v/9S9t36Rb29MZbD4345wxDxoA+cuQrlUHh65QKrqYSCSpwu5
 p4r6qrinE1PqQd77TkUSxEop39IzQvHQRkz5KWXP2sO7TUs5ovINypKgFGG9vfVrcYiJ
 c5/kZIoAtawlZ8lMgsXtu6/ICa2tWuIhXaLkISjko1KcwPnqJnMOkkclvIIb5udJD+Gg
 mXpQ==
X-Gm-Message-State: AC+VfDz5EEh9C6MZlQ2bDJLrUCkLiLYl4tI8u4U29FcBn13QYrWwI0nM
 Yqg/BUlnnx2E5pFiMqH5FK4tekgB1dWtCuh824w=
X-Google-Smtp-Source: ACHHUZ5XfVjcUFqAogB7GNoumuXjFqR84L2nCalIPrSLJ8TGWjLTEMUgaCjqDiuAZJ28CnrbnqGwnA==
X-Received: by 2002:a1c:4c11:0:b0:3f5:4e1:2a89 with SMTP id
 z17-20020a1c4c11000000b003f504e12a89mr1419147wmf.34.1684414274239; 
 Thu, 18 May 2023 05:51:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/29] target/arm: Convert Add/subtract (immediate) to
 decodetree
Date: Thu, 18 May 2023 13:50:50 +0100
Message-Id: <20230518125107.146421-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Convert the ADD and SUB (immediate) instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230512144106.3608981-7-peter.maydell@linaro.org
[PMM: Rebased; adjusted to use translate.h's TRANS macro]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h     |  5 +++
 target/arm/tcg/a64.decode      | 17 ++++++++
 target/arm/tcg/translate-a64.c | 73 ++++++++++------------------------
 3 files changed, 42 insertions(+), 53 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f02d4685b4c..a9d1f4adc28 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -220,6 +220,11 @@ static inline int rsub_8(DisasContext *s, int x)
     return 8 - x;
 }
 
+static inline int shl_12(DisasContext *s, int x)
+{
+    return x << 12;
+}
+
 static inline int neon_3same_fp_size(DisasContext *s, int x)
 {
     /* Convert 0==fp32, 1==fp16 into a MO_* value */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index bcf46fc37d7..30c2ac7e271 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -20,6 +20,7 @@
 #
 
 &ri              rd imm
+&rri_sf          rd rn imm sf
 
 
 ### Data Processing - Immediate
@@ -31,3 +32,19 @@
 
 ADR             0 .. 10000 ................... .....    @pcrel
 ADRP            1 .. 10000 ................... .....    @pcrel
+
+# Add/subtract (immediate)
+
+%imm12_sh12     10:12 !function=shl_12
+@addsub_imm     sf:1 .. ...... . imm:12 rn:5 rd:5
+@addsub_imm12   sf:1 .. ...... . ............ rn:5 rd:5 imm=%imm12_sh12
+
+ADD_i           . 00 100010 0 ............ ..... .....  @addsub_imm
+ADD_i           . 00 100010 1 ............ ..... .....  @addsub_imm12
+ADDS_i          . 01 100010 0 ............ ..... .....  @addsub_imm
+ADDS_i          . 01 100010 1 ............ ..... .....  @addsub_imm12
+
+SUB_i           . 10 100010 0 ............ ..... .....  @addsub_imm
+SUB_i           . 10 100010 1 ............ ..... .....  @addsub_imm12
+SUBS_i          . 11 100010 0 ............ ..... .....  @addsub_imm
+SUBS_i          . 11 100010 1 ............ ..... .....  @addsub_imm12
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7a633abf830..2dd0df7286e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4198,6 +4198,22 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
     }
 }
 
+typedef void ArithTwoOp(TCGv_i64, TCGv_i64, TCGv_i64);
+
+static bool gen_rri(DisasContext *s, arg_rri_sf *a,
+                    bool rd_sp, bool rn_sp, ArithTwoOp *fn)
+{
+    TCGv_i64 tcg_rn = rn_sp ? cpu_reg_sp(s, a->rn) : cpu_reg(s, a->rn);
+    TCGv_i64 tcg_rd = rd_sp ? cpu_reg_sp(s, a->rd) : cpu_reg(s, a->rd);
+    TCGv_i64 tcg_imm = tcg_constant_i64(a->imm);
+
+    fn(tcg_rd, tcg_rn, tcg_imm);
+    if (!a->sf) {
+        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
+    }
+    return true;
+}
+
 /*
  * PC-rel. addressing
  */
@@ -4220,57 +4236,11 @@ static bool trans_ADRP(DisasContext *s, arg_ri *a)
 
 /*
  * Add/subtract (immediate)
- *
- *  31 30 29 28         23 22 21         10 9   5 4   0
- * +--+--+--+-------------+--+-------------+-----+-----+
- * |sf|op| S| 1 0 0 0 1 0 |sh|    imm12    |  Rn | Rd  |
- * +--+--+--+-------------+--+-------------+-----+-----+
- *
- *    sf: 0 -> 32bit, 1 -> 64bit
- *    op: 0 -> add  , 1 -> sub
- *     S: 1 -> set flags
- *    sh: 1 -> LSL imm by 12
  */
-static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    uint64_t imm = extract32(insn, 10, 12);
-    bool shift = extract32(insn, 22, 1);
-    bool setflags = extract32(insn, 29, 1);
-    bool sub_op = extract32(insn, 30, 1);
-    bool is_64bit = extract32(insn, 31, 1);
-
-    TCGv_i64 tcg_rn = cpu_reg_sp(s, rn);
-    TCGv_i64 tcg_rd = setflags ? cpu_reg(s, rd) : cpu_reg_sp(s, rd);
-    TCGv_i64 tcg_result;
-
-    if (shift) {
-        imm <<= 12;
-    }
-
-    tcg_result = tcg_temp_new_i64();
-    if (!setflags) {
-        if (sub_op) {
-            tcg_gen_subi_i64(tcg_result, tcg_rn, imm);
-        } else {
-            tcg_gen_addi_i64(tcg_result, tcg_rn, imm);
-        }
-    } else {
-        TCGv_i64 tcg_imm = tcg_constant_i64(imm);
-        if (sub_op) {
-            gen_sub_CC(is_64bit, tcg_result, tcg_rn, tcg_imm);
-        } else {
-            gen_add_CC(is_64bit, tcg_result, tcg_rn, tcg_imm);
-        }
-    }
-
-    if (is_64bit) {
-        tcg_gen_mov_i64(tcg_rd, tcg_result);
-    } else {
-        tcg_gen_ext32u_i64(tcg_rd, tcg_result);
-    }
-}
+TRANS(ADD_i, gen_rri, a, 1, 1, tcg_gen_add_i64)
+TRANS(SUB_i, gen_rri, a, 1, 1, tcg_gen_sub_i64)
+TRANS(ADDS_i, gen_rri, a, 0, 1, a->sf ? gen_add64_CC : gen_add32_CC)
+TRANS(SUBS_i, gen_rri, a, 0, 1, a->sf ? gen_sub64_CC : gen_sub32_CC)
 
 /*
  * Add/subtract (immediate, with tags)
@@ -4668,9 +4638,6 @@ static void disas_extract(DisasContext *s, uint32_t insn)
 static void disas_data_proc_imm(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 23, 6)) {
-    case 0x22: /* Add/subtract (immediate) */
-        disas_add_sub_imm(s, insn);
-        break;
     case 0x23: /* Add/subtract (immediate, with tags) */
         disas_add_sub_imm_with_tags(s, insn);
         break;
-- 
2.34.1


