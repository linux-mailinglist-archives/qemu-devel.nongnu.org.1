Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA167E5984
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 15:54:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0jvO-0001T7-7U; Wed, 08 Nov 2023 09:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0jvM-0001ST-0q
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:52:56 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0jvJ-0002FW-S5
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:52:55 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9dd5879a126so832104166b.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 06:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699455172; x=1700059972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVFDT+R54Bka3Z7J05tSdo0rO45X1nMnKArEtpE1spQ=;
 b=QeK9is+Zc7cAbTsHAnGrdr9wOp1AtUbUenY3Js1Qg4nbzxxScPAaRm729pYhDrQjt0
 Cq1OD48tizbalsmHeT/Urx1A8hNpHliGzEZwFNtqVAjXO8eRtWvAd06IozEZE1jMvy2M
 QlKTQa1+rA0/LTJYCVKVAptxlm/rCf0S/7R649kegvsd398txZCaVpT8dLPCYkRJCjA8
 bweXTsQSS4AS6p7WKmllNunG4Z4PcRXQeS8g8p0drejTob3IfAY7eEzSVMR7fKfpHYeT
 5PX8nyj0rO3H3sgTq6sIVM/qQP8fvJ3LP4yz5XLb8u8pUBVnsB6XIhcJgDRcgF4TEJo0
 QMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699455172; x=1700059972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVFDT+R54Bka3Z7J05tSdo0rO45X1nMnKArEtpE1spQ=;
 b=Hh9LSWRHuZWBqHe5D4xKaOfEnWQp2vJbXsjvuHFySqj3KY7berfU0UGZcYGwDRybqp
 lqCzBupWSC9sEwAHszU5SKiEtxa7+xr1drP/x+eUJdh+k1h4SMLr1owEY9rUem0g/PwH
 M2HVKMH1u+wR0bhNzF/sA9LZsrzBVvW9hpr+iq0RYzhU6wr6Xzgdny7s3iblnJXPDWAc
 oO4lYFlEvlsRbqWzYs6xslNdLsoAM9FnYSuZO0gwgfNLo+3IOysLBiISjvcjVDPm+7Uh
 2jWzWMOf2MhlBuDZ9GRW6eHuIeznLvZ+DvT8f1qlEfTvEpmmAGghhEx4ZBVkMKDdQsAB
 qonw==
X-Gm-Message-State: AOJu0YzAfYSj6dL6fnGc4xff5aKqr6dJD7lwBnjfALSyA6YNPRtMKJ+W
 c8ceD26gerdekya3RIN2vTpWJyy2umSescwLGcs=
X-Google-Smtp-Source: AGHT+IGFIKFKECWUDz1k2CeW04Zjgrc0KjXKV9eufZIgVXcipfj+ouVo+O/hCB1HiLFifVYoj2PUvg==
X-Received: by 2002:a17:907:e88:b0:9ae:588e:142 with SMTP id
 ho8-20020a1709070e8800b009ae588e0142mr1794162ejc.67.1699455171905; 
 Wed, 08 Nov 2023 06:52:51 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a1709064f0f00b0099bcf9c2ec6sm1163516eju.75.2023.11.08.06.52.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Nov 2023 06:52:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/35 2/2] tcg/arm: Support TCG_COND_TST{EQ,NE}
Date: Wed,  8 Nov 2023 15:52:43 +0100
Message-ID: <20231108145244.72421-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231028194522.245170-12-richard.henderson@linaro.org>
References: <20231028194522.245170-12-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231028194522.245170-12-richard.henderson@linaro.org>
[PMD: Split from bigger patch, part 2/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 66d71af8bf..0fc7273b16 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1194,7 +1194,27 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
 static TCGCond tcg_out_cmp(TCGContext *s, TCGCond cond, TCGReg a,
                            TCGArg b, int b_const)
 {
-    tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, a, b, b_const);
+    if (!is_tst_cond(cond)) {
+        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, a, b, b_const);
+        return cond;
+    }
+
+    cond = tcg_tst_eqne_cond(cond);
+    if (b_const) {
+        int imm12 = encode_imm(b);
+
+        /*
+         * The compare constraints allow rIN, but TST does not support N.
+         * Be prepared to load the constant into a scratch register.
+         */
+        if (imm12 >= 0) {
+            tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, a, imm12);
+            return cond;
+        }
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, b);
+        b = TCG_REG_TMP;
+    }
+    tcg_out_dat_reg(s, COND_AL, ARITH_TST, 0, a, b, SHIFT_IMM_LSL(0));
     return cond;
 }
 
@@ -1225,6 +1245,13 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
         tcg_out_dat_rI(s, COND_EQ, ARITH_CMP, 0, al, bl, const_bl);
         return cond;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        /* Similar, but with TST instead of CMP. */
+        tcg_out_dat_rI(s, COND_AL, ARITH_TST, 0, ah, bh, const_bh);
+        tcg_out_dat_rI(s, COND_EQ, ARITH_TST, 0, al, bl, const_bl);
+        return tcg_tst_eqne_cond(cond);
+
     case TCG_COND_LT:
     case TCG_COND_GE:
         /* We perform a double-word subtraction and examine the result.
-- 
2.41.0


