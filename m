Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C457081CC
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6b-0004JG-6v; Thu, 18 May 2023 08:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6T-0004E2-W5
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6N-00081j-UT
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f41d087b3bso20206885e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414278; x=1687006278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W6KDzoUlerslTQhMby3OQ4q1nBSstouBuvraHtUO/aU=;
 b=srWVxZYd2kCDDPVc1wVLUC0M2xfIDKLs7iFrbG/Ye7thv0Rwc1Idq/NzA4l00UdLFx
 8eK3hJQSLX6y7b7xYY5k8PRFDNdYo/I7/O0tPNx2bc+l80MYCMmhqUHwyF/6QbpOcYl5
 bOCU8wOLdqtmMruPQE5lnoLjZxQ+fpl7Dv4Nf7hlMOtHuBVkLwMAcZ9MNIzEOJO+eHoQ
 1cgUwYgNAlqAuqHPDki4WbAf45l/66wSBjhA7Gr3FWOVt9fJwQQTsmzN/1/ezxYY4VJO
 ZzeThtVQmbKyc5kt1CCmTXXIYQIO31BLRRjHY4iJIPJtsLG7DcUAbQU4ysitk4ySTFqX
 lOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414278; x=1687006278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6KDzoUlerslTQhMby3OQ4q1nBSstouBuvraHtUO/aU=;
 b=KUb7h3fJmGR+j6ZcUHv1t1B33f9GritTKSuTvSxFqBzpe5dieL8p2rqe4SWkjq6Hun
 xFYmeIL0gGbEvA0fs/kn0Ur3EtokTz/QlZUw48mSlyNK/FKb91qSKKRHz0YN0lLDkY7L
 TgZEpPfuROfLVa3ZnXwm6apSuMcAk3G2AxmnvKSQVUat2264aR5N2zHXqohyXQC8yspy
 pbgQcWPvJD1Or8AaOsqmtjm/UusBjknLNhoOMwfNtT2/yeYTu7FKWelJrc9rnYmR/w+h
 GsgTzJv0JXea+E+Ci0Gq5emhexzM0v3ZJV2/AZdBfalgbFYxJamq7Emj4tyZxJb3iQBs
 WgtQ==
X-Gm-Message-State: AC+VfDzSyWDvO3RE5mgJUfbFh6V2ILngPEQCx3gwTt1lR6niCNXdahXn
 JkdaEEGbcOkVBtrmxHtFirB3vjAlmOTFDjAirro=
X-Google-Smtp-Source: ACHHUZ4xHy+JkugiM4xXnHlfktVfSEuIlf4s0iaRRYTtDiMRDXl4lmXnRVat3FZgtexQAbWVpgzJWA==
X-Received: by 2002:a1c:7409:0:b0:3f1:75b0:dc47 with SMTP id
 p9-20020a1c7409000000b003f175b0dc47mr1394474wmc.15.1684414278168; 
 Thu, 18 May 2023 05:51:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/29] target/arm: Convert TBZ, TBNZ to decodetree
Date: Thu, 18 May 2023 13:50:59 +0100
Message-Id: <20230518125107.146421-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
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

Convert the test-and-branch-immediate insns TBZ and TBNZ
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230512144106.3608981-16-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  6 ++++++
 target/arm/tcg/translate-a64.c | 25 +++++--------------------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f5759a66e7f..09def15863f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -118,3 +118,9 @@ BL              1 00101 .......................... @branch
 &cbz     rt imm sf nz
 
 CBZ             sf:1 011010 nz:1 ................... rt:5 &cbz imm=%imm19
+
+%imm14     5:s14 !function=times_4
+%imm31_19  31:1 19:5
+&tbz       rt imm nz bitpos
+
+TBZ             . 011011 nz:1 ..... .............. rt:5 &tbz  imm=%imm14 bitpos=%imm31_19
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 06619f8a05d..1e5977423a6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1352,35 +1352,23 @@ static bool trans_CBZ(DisasContext *s, arg_cbz *a)
     return true;
 }
 
-/* Test and branch (immediate)
- *   31  30         25  24  23   19 18          5 4    0
- * +----+-------------+----+-------+-------------+------+
- * | b5 | 0 1 1 0 1 1 | op |  b40  |    imm14    |  Rt  |
- * +----+-------------+----+-------+-------------+------+
- */
-static void disas_test_b_imm(DisasContext *s, uint32_t insn)
+static bool trans_TBZ(DisasContext *s, arg_tbz *a)
 {
-    unsigned int bit_pos, op, rt;
-    int64_t diff;
     DisasLabel match;
     TCGv_i64 tcg_cmp;
 
-    bit_pos = (extract32(insn, 31, 1) << 5) | extract32(insn, 19, 5);
-    op = extract32(insn, 24, 1); /* 0: TBZ; 1: TBNZ */
-    diff = sextract32(insn, 5, 14) * 4;
-    rt = extract32(insn, 0, 5);
-
     tcg_cmp = tcg_temp_new_i64();
-    tcg_gen_andi_i64(tcg_cmp, cpu_reg(s, rt), (1ULL << bit_pos));
+    tcg_gen_andi_i64(tcg_cmp, cpu_reg(s, a->rt), 1ULL << a->bitpos);
 
     reset_btype(s);
 
     match = gen_disas_label(s);
-    tcg_gen_brcondi_i64(op ? TCG_COND_NE : TCG_COND_EQ,
+    tcg_gen_brcondi_i64(a->nz ? TCG_COND_NE : TCG_COND_EQ,
                         tcg_cmp, 0, match.label);
     gen_goto_tb(s, 0, 4);
     set_disas_label(s, match);
-    gen_goto_tb(s, 1, diff);
+    gen_goto_tb(s, 1, a->imm);
+    return true;
 }
 
 /* Conditional branch (immediate)
@@ -2397,9 +2385,6 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 25, 7)) {
-    case 0x1b: case 0x5b: /* Test & branch (immediate) */
-        disas_test_b_imm(s, insn);
-        break;
     case 0x2a: /* Conditional branch (immediate) */
         disas_cond_b_imm(s, insn);
         break;
-- 
2.34.1


