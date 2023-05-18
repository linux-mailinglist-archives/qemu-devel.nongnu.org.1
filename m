Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6064F7081E7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:55:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6Z-0004IK-73; Thu, 18 May 2023 08:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6Q-0004Bj-2O
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6I-00081o-8z
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f450815d02so13086745e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414278; x=1687006278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/9DPUpf5bQDvtdp/1Tfm8Da/KNhELKY6TnW1+dKMD2w=;
 b=qi9VRKdi2iMljdx5cSizkbj94TEb9BCL0kKL3Yywa78u/7EL2I60axaZxQ/91x3bFM
 HRPuZ8+bx69lJMzn6BH4d74OnT74Yoj21F/fYIn5l0rRalxavoB13IJC6828D4CuCls+
 p3uRcP1ttZI1hD3/GGr2qidVC+irTMzVUAyoUDfbXRb8A6+EfW7WMCWmGals+UktIfIC
 YXkFYENUaYzcjqIs9j4y9Zdbd91eSIOwlylp5mO6JGrxLvcarrCzt8TszT9rDqO/S4A4
 kWVRFcWKxM6z2MQo00vRzSSlPIM7wKhunq6/38iR1bYUwwvJkGy4vtKD1ss25ATAzPzp
 3Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414278; x=1687006278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9DPUpf5bQDvtdp/1Tfm8Da/KNhELKY6TnW1+dKMD2w=;
 b=XAdIgmHbvU+GPPmAjsKJck3RX+aCxU/HW/TxiQh0JezVGo5Y5dL8eg82nDS3bGVynX
 7dKHFtL+DIg7x55OrOvELi1HfPtdRmBUSyaF3XVP8vKttAcYYYYR6dAKz4NOg36dVcmj
 S0fRWdXnNohhxJDAaFKgyNfGhKsv/GasXdybrz8XRYdegr22l87c6ufQ4OJYr/TDD4J9
 G25PQFSTPKU0TIUPdfm16dkqDsOHAWuqk3wdnzU8Vh+HyZG4DdOL/ZA0PrfruU4yTv1n
 HvsaP/t0EeLIZGk7hSAtTkX4f4rAxt9+a4oJ23IRPdCGjwkXYJJkhQC7SUNtAuIA8HYY
 R3Gw==
X-Gm-Message-State: AC+VfDxWp+Cs9vG6zBoWQ11WAlik8FF0Ljmq/g0R+N8oScSy84oQ0MAe
 MGgbpomTuCIrdmmQP/eiCoK3cxqZRvI57zwbfsI=
X-Google-Smtp-Source: ACHHUZ6UPBcwAQh31kpEeBXtu4fL2YYBEvG82x1IFAQWZDDlUPeKpiNO18DG+W3HiYUbkx3OBuRBxQ==
X-Received: by 2002:a05:600c:2243:b0:3f4:2610:5cd4 with SMTP id
 a3-20020a05600c224300b003f426105cd4mr1514435wmm.29.1684414278643; 
 Thu, 18 May 2023 05:51:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/29] target/arm: Convert conditional branch insns to
 decodetree
Date: Thu, 18 May 2023 13:51:00 +0100
Message-Id: <20230518125107.146421-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Convert the immediate conditional branch insn B.cond to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230512144106.3608981-17-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 30 ++++++------------------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 09def15863f..5b9e275b5f8 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -124,3 +124,5 @@ CBZ             sf:1 011010 nz:1 ................... rt:5 &cbz imm=%imm19
 &tbz       rt imm nz bitpos
 
 TBZ             . 011011 nz:1 ..... .............. rt:5 &tbz  imm=%imm14 bitpos=%imm31_19
+
+B_cond          0101010 0 ................... 0 cond:4 imm=%imm19
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1e5977423a6..a7ab89fdc8c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1371,36 +1371,21 @@ static bool trans_TBZ(DisasContext *s, arg_tbz *a)
     return true;
 }
 
-/* Conditional branch (immediate)
- *  31           25  24  23                  5   4  3    0
- * +---------------+----+---------------------+----+------+
- * | 0 1 0 1 0 1 0 | o1 |         imm19       | o0 | cond |
- * +---------------+----+---------------------+----+------+
- */
-static void disas_cond_b_imm(DisasContext *s, uint32_t insn)
+static bool trans_B_cond(DisasContext *s, arg_B_cond *a)
 {
-    unsigned int cond;
-    int64_t diff;
-
-    if ((insn & (1 << 4)) || (insn & (1 << 24))) {
-        unallocated_encoding(s);
-        return;
-    }
-    diff = sextract32(insn, 5, 19) * 4;
-    cond = extract32(insn, 0, 4);
-
     reset_btype(s);
-    if (cond < 0x0e) {
+    if (a->cond < 0x0e) {
         /* genuinely conditional branches */
         DisasLabel match = gen_disas_label(s);
-        arm_gen_test_cc(cond, match.label);
+        arm_gen_test_cc(a->cond, match.label);
         gen_goto_tb(s, 0, 4);
         set_disas_label(s, match);
-        gen_goto_tb(s, 1, diff);
+        gen_goto_tb(s, 1, a->imm);
     } else {
         /* 0xe and 0xf are both "always" conditions */
-        gen_goto_tb(s, 0, diff);
+        gen_goto_tb(s, 0, a->imm);
     }
+    return true;
 }
 
 /* HINT instruction group, including various allocated HINTs */
@@ -2385,9 +2370,6 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 25, 7)) {
-    case 0x2a: /* Conditional branch (immediate) */
-        disas_cond_b_imm(s, insn);
-        break;
     case 0x6a: /* Exception generation / System */
         if (insn & (1 << 24)) {
             if (extract32(insn, 22, 2) == 0) {
-- 
2.34.1


