Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CF07081C6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:52:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6c-0004K2-TT; Thu, 18 May 2023 08:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6T-0004E0-Vu
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6N-00081F-V4
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f42ba32e24so12946055e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414276; x=1687006276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uNT0sE0KvR5tqYTGENxbEwXvtcUr3Gd67Gy0nr4Q/MM=;
 b=mugcpl5PqGFMf2VB1qUHBS7NuGTWAL/ahRFY5nr646zqJixTksMiWpIomJLc/78O65
 0MzP2OFBF6A6YLJHrELnCj7T4/tTABvQUEBFnnSOQ+g/1oPCxg0jEfYj6NpMlwRBd5Lf
 JjR40gE2jF5djEfNVH5OFQNZ/jaB4hjVvU9JKRtlmv2hB7FQy/wEgzf9Tmw8/mli0T/0
 XArJH9097cy/266J+DE3h2w8JLYV2hBM4YJUvpVNEr0OcF+wSJptmsh4C07M4xO31Go5
 YM4klr9eDNJ0NQaA++eZSqz5E3x+bEWu42Xj6dmEb7RoUD9G1Gs0WRorlXIkOHdP6tM4
 /AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414276; x=1687006276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNT0sE0KvR5tqYTGENxbEwXvtcUr3Gd67Gy0nr4Q/MM=;
 b=hoZncEFYv0uQveeaLuNau/zNsi8MBL7x59nbaf3KWehkBYuVe0zaZFm8LWqNpepRXN
 RC6zrkw3A88E8Kx7qjEdYossJaQp9GMyGtlyss3rnmJmfG0aLfKUvIBeWd5vt2Qh7zU5
 BRluoV6Sosgzov2B2071cJe3fpBXLWgLyBCXlTB4cfO56OZ+ECdR1ZDWCToe3op6/Hp8
 uQUQ/lHYNpqijuvZXBJ0umv1MUjeI4cuq7WeFvlrakCsGoc64+FDbQOqzCotfJnJFoJo
 CHgZPS7sALrqxW3eyOEcM5TxMVB4+HPRn4pPT702o+cN7Ze5yw1pAEl15LVt0bsKlV74
 R65Q==
X-Gm-Message-State: AC+VfDwFaNOjkNorU5DIiWqaJ2QmkXI2IcWhpdqPk4rGPbRuh+WUa9Dc
 yFGvIGAFJvadJnb4qt3dqM+V65biIrOpxzTet5U=
X-Google-Smtp-Source: ACHHUZ7VAuow0zvKMbclAf8KDyz8vn+61iWKL2ZxFnwMjJCM5p1IxKsdY3EC/zg5Q2cQ8s9MHKj1TQ==
X-Received: by 2002:a05:600c:cb:b0:3f4:23b9:eed2 with SMTP id
 u11-20020a05600c00cb00b003f423b9eed2mr1418501wmm.38.1684414276121; 
 Thu, 18 May 2023 05:51:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/29] target/arm: Convert Move wide (immediate) to decodetree
Date: Thu, 18 May 2023 13:50:54 +0100
Message-Id: <20230518125107.146421-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Convert the MON, MOVZ, MOVK instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230512144106.3608981-11-peter.maydell@linaro.org
[PMM: Rebased]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 13 ++++++
 target/arm/tcg/translate-a64.c | 73 ++++++++++++++--------------------
 2 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1933afa457b..350b37c8f37 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -71,3 +71,16 @@ EOR_i           . 10 100100 . ...... ...... ..... ..... @logic_imm_64
 EOR_i           . 10 100100 . ...... ...... ..... ..... @logic_imm_32
 ANDS_i          . 11 100100 . ...... ...... ..... ..... @logic_imm_64
 ANDS_i          . 11 100100 . ...... ...... ..... ..... @logic_imm_32
+
+# Move wide (immediate)
+
+&movw           rd sf imm hw
+@movw_64        1 .. ...... hw:2   imm:16 rd:5          &movw sf=1
+@movw_32        0 .. ...... 0 hw:1 imm:16 rd:5          &movw sf=0
+
+MOVN            . 00 100101 .. ................ .....   @movw_64
+MOVN            . 00 100101 .. ................ .....   @movw_32
+MOVZ            . 10 100101 .. ................ .....   @movw_64
+MOVZ            . 10 100101 .. ................ .....   @movw_32
+MOVK            . 11 100101 .. ................ .....   @movw_64
+MOVK            . 11 100101 .. ................ .....   @movw_32
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4192f951d48..c9117f0a405 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4395,52 +4395,40 @@ TRANS(ANDS_i, gen_rri_log, a, true, tcg_gen_andi_i64)
 
 /*
  * Move wide (immediate)
- *
- *  31 30 29 28         23 22 21 20             5 4    0
- * +--+-----+-------------+-----+----------------+------+
- * |sf| opc | 1 0 0 1 0 1 |  hw |  imm16         |  Rd  |
- * +--+-----+-------------+-----+----------------+------+
- *
- * sf: 0 -> 32 bit, 1 -> 64 bit
- * opc: 00 -> N, 10 -> Z, 11 -> K
- * hw: shift/16 (0,16, and sf only 32, 48)
  */
-static void disas_movw_imm(DisasContext *s, uint32_t insn)
+
+static bool trans_MOVZ(DisasContext *s, arg_movw *a)
 {
-    int rd = extract32(insn, 0, 5);
-    uint64_t imm = extract32(insn, 5, 16);
-    int sf = extract32(insn, 31, 1);
-    int opc = extract32(insn, 29, 2);
-    int pos = extract32(insn, 21, 2) << 4;
-    TCGv_i64 tcg_rd = cpu_reg(s, rd);
+    int pos = a->hw << 4;
+    tcg_gen_movi_i64(cpu_reg(s, a->rd), (uint64_t)a->imm << pos);
+    return true;
+}
 
-    if (!sf && (pos >= 32)) {
-        unallocated_encoding(s);
-        return;
-    }
+static bool trans_MOVN(DisasContext *s, arg_movw *a)
+{
+    int pos = a->hw << 4;
+    uint64_t imm = a->imm;
 
-    switch (opc) {
-    case 0: /* MOVN */
-    case 2: /* MOVZ */
-        imm <<= pos;
-        if (opc == 0) {
-            imm = ~imm;
-        }
-        if (!sf) {
-            imm &= 0xffffffffu;
-        }
-        tcg_gen_movi_i64(tcg_rd, imm);
-        break;
-    case 3: /* MOVK */
-        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_constant_i64(imm), pos, 16);
-        if (!sf) {
-            tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
-        }
-        break;
-    default:
-        unallocated_encoding(s);
-        break;
+    imm = ~(imm << pos);
+    if (!a->sf) {
+        imm = (uint32_t)imm;
     }
+    tcg_gen_movi_i64(cpu_reg(s, a->rd), imm);
+    return true;
+}
+
+static bool trans_MOVK(DisasContext *s, arg_movw *a)
+{
+    int pos = a->hw << 4;
+    TCGv_i64 tcg_rd, tcg_im;
+
+    tcg_rd = cpu_reg(s, a->rd);
+    tcg_im = tcg_constant_i64(a->imm);
+    tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_im, pos, 16);
+    if (!a->sf) {
+        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
+    }
+    return true;
 }
 
 /* Bitfield
@@ -4585,9 +4573,6 @@ static void disas_extract(DisasContext *s, uint32_t insn)
 static void disas_data_proc_imm(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 23, 6)) {
-    case 0x25: /* Move wide (immediate) */
-        disas_movw_imm(s, insn);
-        break;
     case 0x26: /* Bitfield */
         disas_bitfield(s, insn);
         break;
-- 
2.34.1


