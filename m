Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D20FA7081E4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:55:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6V-0004FF-0W; Thu, 18 May 2023 08:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6L-0004Al-PP
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6E-0007zM-FV
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f427118644so19430045e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414273; x=1687006273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EYMNPZn0ycDWSAniczGdOCIYstv04S4syoY1G6oBBM0=;
 b=g0tRyEUOpxcX2s8O0UJsmp7DUiygSKJEwcUyIQ0sHdq+aJpi3gJCXMoafcYtKHR0BR
 DXjYXj6Lx5vRKriirkc20HzT4HpThbCMMKHic+y0+ah8Emf4M4caVAdYCBF5lrZsHgK6
 6cwwP0nUTEZ3DS0kyJwq0pDOK8zxYCPUwWACSsJVPtcGbrvEnm7Wcgj8WJpQ+UFNC+dy
 r6Rj9Yu4BAlSfoW67tIXU7kSlHmHv3SKcyrg3d1/Wijr+p/MAJpHcqKYUXUBFEjRYigl
 mSrGe90w16zVo1OAIW+RLPWmen/5HnzRTvt2z7lmMPCDBxIeNjGz/McvBUrJStTl1W0S
 /eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414273; x=1687006273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYMNPZn0ycDWSAniczGdOCIYstv04S4syoY1G6oBBM0=;
 b=IQ/uwhCJKf2iRMelN06xT7N2Oz36JmrHNLmrwS7bRbsytWKAVnh4L+zq52LrMPyfrX
 aSkZ5iUQYA0FZsb191RXZVCH/DDU4i3kwQInWOpKEjfikZ/+YMnUUTKQQRfVk5QvOEf8
 k0WC+b8wIrb4xVy4JPrKZIyo/1BSXQ1PvX96iWzPDRPISBDa2o6Uib/bTe3UCktvv3B5
 ZZqcs2SotdACRT6CByppSbmg1gqIEYHl1avm5IfBz4PyhN6TC4AypGVI3oGVCpt9pPWL
 u/mt1GL7tGH/1hcCN8SdU16gI8gwWuaBLISjzb728qDiq4V9fiOl2tEeu9r6B32H83RC
 Q2SA==
X-Gm-Message-State: AC+VfDwoi6e8X6Oa5sR2Oy5NBKdiIF7g+rCKTDbKTKDlES4Z4o0gYAWV
 aXWc6PlmyKeA9hvitqRSHZwlu0RS2rkJUtJhH0o=
X-Google-Smtp-Source: ACHHUZ6Cabe/vERvinp1Y4/ZBDcUDCYAAXO3Kkn3D8b44uVBPHk84fTFZYLogoApNnj+llifZlVhOA==
X-Received: by 2002:a05:600c:2152:b0:3f2:5be3:cd6a with SMTP id
 v18-20020a05600c215200b003f25be3cd6amr1378369wml.4.1684414273372; 
 Thu, 18 May 2023 05:51:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/29] target/arm: Convert PC-rel addressing to decodetree
Date: Thu, 18 May 2023 13:50:48 +0100
Message-Id: <20230518125107.146421-11-peter.maydell@linaro.org>
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

Convert the ADR and ADRP instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230512144106.3608981-5-peter.maydell@linaro.org
[PMM: Rebased]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 13 ++++++++++++
 target/arm/tcg/translate-a64.c | 38 +++++++++++++---------------------
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 43321bbbb05..bcf46fc37d7 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -18,3 +18,16 @@
 #
 # This file is processed by scripts/decodetree.py
 #
+
+&ri              rd imm
+
+
+### Data Processing - Immediate
+
+# PC-rel addressing
+
+%imm_pcrel      5:s19 29:2
+@pcrel          . .. ..... ................... rd:5     &ri imm=%imm_pcrel
+
+ADR             0 .. 10000 ................... .....    @pcrel
+ADRP            1 .. 10000 ................... .....    @pcrel
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1fd6f97b641..ffcd05eb38a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4179,31 +4179,24 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
     }
 }
 
-/* PC-rel. addressing
- *   31  30   29 28       24 23                5 4    0
- * +----+-------+-----------+-------------------+------+
- * | op | immlo | 1 0 0 0 0 |       immhi       |  Rd  |
- * +----+-------+-----------+-------------------+------+
+/*
+ * PC-rel. addressing
  */
-static void disas_pc_rel_adr(DisasContext *s, uint32_t insn)
+
+static bool trans_ADR(DisasContext *s, arg_ri *a)
 {
-    unsigned int page, rd;
-    int64_t offset;
+    gen_pc_plus_diff(s, cpu_reg(s, a->rd), a->imm);
+    return true;
+}
 
-    page = extract32(insn, 31, 1);
-    /* SignExtend(immhi:immlo) -> offset */
-    offset = sextract64(insn, 5, 19);
-    offset = offset << 2 | extract32(insn, 29, 2);
-    rd = extract32(insn, 0, 5);
+static bool trans_ADRP(DisasContext *s, arg_ri *a)
+{
+    int64_t offset = (int64_t)a->imm << 12;
 
-    if (page) {
-        /* ADRP (page based) */
-        offset <<= 12;
-        /* The page offset is ok for CF_PCREL. */
-        offset -= s->pc_curr & 0xfff;
-    }
-
-    gen_pc_plus_diff(s, cpu_reg(s, rd), offset);
+    /* The page offset is ok for CF_PCREL. */
+    offset -= s->pc_curr & 0xfff;
+    gen_pc_plus_diff(s, cpu_reg(s, a->rd), offset);
+    return true;
 }
 
 /*
@@ -4656,9 +4649,6 @@ static void disas_extract(DisasContext *s, uint32_t insn)
 static void disas_data_proc_imm(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 23, 6)) {
-    case 0x20: case 0x21: /* PC-rel. addressing */
-        disas_pc_rel_adr(s, insn);
-        break;
     case 0x22: /* Add/subtract (immediate) */
         disas_add_sub_imm(s, insn);
         break;
-- 
2.34.1


