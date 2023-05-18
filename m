Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 697E07081D5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6a-0004IO-Ia; Thu, 18 May 2023 08:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6T-0004Dv-TD
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6N-00081W-UC
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f4c6c4b51eso19541175e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414277; x=1687006277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7EB1RtFUAd4cT6NrXiFuDC7ITXwAXhWcCBcvwhZmQlQ=;
 b=vsqWPO0rmdbE0zSbdL59vSZU85G3dEcL+PTa7E3yLSQ+ZHgr6R8cYocVSovRs+qJ2C
 w0SFkZ5BlvErc+DueEGcNMC2Ficx9qkYDkRp3a8S+CgjfXYXoCchQiokuimNmKNlhEYs
 ENNiU7mJzVvuCugM9cDmGGQsmsSYRnoUNqB1i87UUG/qVbeeEpm+5OYyf/1iy7TE+HX3
 K7JZRTT+p8Y9LVj/EXPt81ghT4IZCr4jaMlVYGesotPnJEMdc+V4PQjzsYuDAitR8Z1d
 QEQCdWdHuw9CAuoVwTZHYkTSa1LCC168KWDG79KK3huiew1tPMXW1cT2h1zXlbFgXvM3
 WD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414277; x=1687006277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7EB1RtFUAd4cT6NrXiFuDC7ITXwAXhWcCBcvwhZmQlQ=;
 b=ZPPM3rLrXyF/uRg6k8cmuldE+6zhZJTTRtG1gfFzGBhPS44n4cqf9aKeyiSPBCjlZf
 QWesfpg7/kRN768hQk7vNhAkl5J5t0Imq5+6vaket/tWv71nGru0pjXigOdhp3y++shq
 HitGZR9xCTecdtkjJtjbkfrdg02w3rYVTNjfwWjy1LIUEIBQBhRgjQwnlwCoUmOs/tbk
 +6WRBfc5DFK/lyoedPnWTTt1KT08tw1HL5ey6h19lvjFQgbOkzlepmZeMvutW4DJQ1og
 zIXMt3K/YpHyria+hVvf7EeFWbbqDeMDED+5OGsUSdpeTE9//1IhgnLEDcOJLi5Z6vKD
 KUdw==
X-Gm-Message-State: AC+VfDxLjOVnVESeaZMQQCRQXjLAJAK2EvAGfrzaXduPfIV+ApSnNMLe
 hXTu7eploA2zw8bOZCx+MPrchLIVFoJQIa0E3zg=
X-Google-Smtp-Source: ACHHUZ47zmiL3jBica4j9nDr/s9O/m0TqYIwKdnOyx+3YVpXFRtsyRVeNpuMc+IOb9ySux2iwMiUGQ==
X-Received: by 2002:a05:600c:3787:b0:3f4:2b98:428f with SMTP id
 o7-20020a05600c378700b003f42b98428fmr1536220wmr.39.1684414277347; 
 Thu, 18 May 2023 05:51:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/29] target/arm: Convert unconditional branch immediate to
 decodetree
Date: Thu, 18 May 2023 13:50:57 +0100
Message-Id: <20230518125107.146421-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Convert the unconditional branch immediate insns B and BL to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230512144106.3608981-14-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  9 +++++++++
 target/arm/tcg/translate-a64.c | 31 +++++++++++--------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e6e1a5f2bcb..483e3649929 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -21,6 +21,7 @@
 
 &ri              rd imm
 &rri_sf          rd rn imm sf
+&i               imm
 
 
 ### Data Processing - Immediate
@@ -104,3 +105,11 @@ UBFM            . 10 100110 . ...... ...... ..... ..... @bitfield_32
 
 EXTR            1 00 100111 1 0 rm:5 imm:6 rn:5 rd:5     &extract sf=1
 EXTR            0 00 100111 0 0 rm:5 0 imm:5 rn:5 rd:5   &extract sf=0
+
+# Branches
+
+%imm26   0:s26 !function=times_4
+@branch         . ..... .......................... &i imm=%imm26
+
+B               0 00101 .......................... @branch
+BL              1 00101 .......................... @branch
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f939f6c9443..f702e9b0678 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1319,24 +1319,19 @@ static inline AArch64DecodeFn *lookup_disas_fn(const AArch64DecodeTable *table,
  * match up with those in the manual.
  */
 
-/* Unconditional branch (immediate)
- *   31  30       26 25                                  0
- * +----+-----------+-------------------------------------+
- * | op | 0 0 1 0 1 |                 imm26               |
- * +----+-----------+-------------------------------------+
- */
-static void disas_uncond_b_imm(DisasContext *s, uint32_t insn)
+static bool trans_B(DisasContext *s, arg_i *a)
 {
-    int64_t diff = sextract32(insn, 0, 26) * 4;
-
-    if (insn & (1U << 31)) {
-        /* BL Branch with link */
-        gen_pc_plus_diff(s, cpu_reg(s, 30), curr_insn_len(s));
-    }
-
-    /* B Branch / BL Branch with link */
     reset_btype(s);
-    gen_goto_tb(s, 0, diff);
+    gen_goto_tb(s, 0, a->imm);
+    return true;
+}
+
+static bool trans_BL(DisasContext *s, arg_i *a)
+{
+    gen_pc_plus_diff(s, cpu_reg(s, 30), curr_insn_len(s));
+    reset_btype(s);
+    gen_goto_tb(s, 0, a->imm);
+    return true;
 }
 
 /* Compare and branch (immediate)
@@ -2413,10 +2408,6 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 25, 7)) {
-    case 0x0a: case 0x0b:
-    case 0x4a: case 0x4b: /* Unconditional branch (immediate) */
-        disas_uncond_b_imm(s, insn);
-        break;
     case 0x1a: case 0x5a: /* Compare & branch (immediate) */
         disas_comp_b_imm(s, insn);
         break;
-- 
2.34.1


