Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF47081D1
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6Y-0004Hu-8v; Thu, 18 May 2023 08:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6U-0004Ey-8s
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:34 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6N-00081f-W0
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:33 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3093a7b71fbso1882018f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414277; x=1687006277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u3wPL3NK+XZ35Ptpin56VFyKyMzmgfDqXeAb/6jTxe8=;
 b=EcLG9Us9FbFSgL8jjBKcAwEkL2m3aSb01tKJphR2tg0kfAGGhtFBkcPY3X+iGgu/dT
 wDCcPXHGRktx4YI1c6p8kWs49cz69PQrNua4dHt6Z1d6fO7v6G+ApYu1J2M0IqY4Mlux
 4TgH3TJ/1hfY1h1KlTnw5pf9iCoV0nvtX6VkRp69pmurNiDxEbgWff4KKN6X/Ne8xAqa
 U/SSXav5UwG1Vp+3C6tSTESzi+dyK9HUSTI+0W13uISuW0cJubM4fjSfKO69nRWN/Xz8
 2nqAhY1SvKuRem9E5sDyDTf7HiLm0BDjOatddOalMkpTQY/Z20D+cgpazzku5fN6wMRS
 EDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414277; x=1687006277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u3wPL3NK+XZ35Ptpin56VFyKyMzmgfDqXeAb/6jTxe8=;
 b=O4wu6jYOIgpK3rIqR2/lnvde0HNuGvembmvi+dO80kU8BvSuyWuzJpUyFT0kKJASfx
 a95TuwHKfLXQxahCe+WmmQ9zbXTm2DQ54zE8lgagceS+v5C7trSmR3N4/E31+N++eSIo
 bG6pi6PUhwW7Fh0Wm1msW/EMqXZHfU2LBvV+5nmAlA5l7ikrz9IzeMjM/0xAZH0aw18I
 I6GnB5bskJD40drP1Pzmyxx+TDaoK1TgUxXz+ri+Vv6wuheGase44mlDSZ0JbuUKiwkZ
 nHWNCicyzu6QUB50pRNRC81NbsZ/t7i5D+v4rhWZ6c7sDWYE035LYYj59dwo6m3e1MJz
 Pcfg==
X-Gm-Message-State: AC+VfDy34jfeeXOIxPcUBWeMPBn3KNVHU+IVe3geo9w6edRJLT/vYyL7
 JDo3bJfoLZZ9hqy4zmT8GIHmfhOBBu9XNMuyvh4=
X-Google-Smtp-Source: ACHHUZ5MbocghGDrgJXt5Mhcrtxvg6yYcNblKH7nur7ctJihyS2BLx83Yoeo0N5thp21Y+S71P8Bkg==
X-Received: by 2002:a5d:6545:0:b0:309:4368:a8a0 with SMTP id
 z5-20020a5d6545000000b003094368a8a0mr1462388wrv.68.1684414277737; 
 Thu, 18 May 2023 05:51:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/29] target/arm: Convert CBZ, CBNZ to decodetree
Date: Thu, 18 May 2023 13:50:58 +0100
Message-Id: <20230518125107.146421-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Convert the compare-and-branch-immediate insns CBZ and CBNZ
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230512144106.3608981-15-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  5 +++++
 target/arm/tcg/translate-a64.c | 26 ++++++--------------------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 483e3649929..f5759a66e7f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -113,3 +113,8 @@ EXTR            0 00 100111 0 0 rm:5 0 imm:5 rn:5 rd:5   &extract sf=0
 
 B               0 00101 .......................... @branch
 BL              1 00101 .......................... @branch
+
+%imm19   5:s19 !function=times_4
+&cbz     rt imm sf nz
+
+CBZ             sf:1 011010 nz:1 ................... rt:5 &cbz imm=%imm19
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f702e9b0678..06619f8a05d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1334,33 +1334,22 @@ static bool trans_BL(DisasContext *s, arg_i *a)
     return true;
 }
 
-/* Compare and branch (immediate)
- *   31  30         25  24  23                  5 4      0
- * +----+-------------+----+---------------------+--------+
- * | sf | 0 1 1 0 1 0 | op |         imm19       |   Rt   |
- * +----+-------------+----+---------------------+--------+
- */
-static void disas_comp_b_imm(DisasContext *s, uint32_t insn)
+
+static bool trans_CBZ(DisasContext *s, arg_cbz *a)
 {
-    unsigned int sf, op, rt;
-    int64_t diff;
     DisasLabel match;
     TCGv_i64 tcg_cmp;
 
-    sf = extract32(insn, 31, 1);
-    op = extract32(insn, 24, 1); /* 0: CBZ; 1: CBNZ */
-    rt = extract32(insn, 0, 5);
-    diff = sextract32(insn, 5, 19) * 4;
-
-    tcg_cmp = read_cpu_reg(s, rt, sf);
+    tcg_cmp = read_cpu_reg(s, a->rt, a->sf);
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
 
 /* Test and branch (immediate)
@@ -2408,9 +2397,6 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 25, 7)) {
-    case 0x1a: case 0x5a: /* Compare & branch (immediate) */
-        disas_comp_b_imm(s, insn);
-        break;
     case 0x1b: case 0x5b: /* Test & branch (immediate) */
         disas_test_b_imm(s, insn);
         break;
-- 
2.34.1


