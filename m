Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C34773785
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:17:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD9a-0003gJ-7Y; Mon, 07 Aug 2023 23:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8s-0001bW-K1
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:20 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8c-0000JY-Cl
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:18 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bd0425ad4fso256892a34.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464321; x=1692069121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bAv2VkeF2nF/Nch+eWToS5kdoZdnIAW3FmjUUhtDDU=;
 b=SUUPWgh+XIMAPs7bvA4YCksr0dMjMZVJDkI9hzC6Ku7umWLcpE/uAZT4Tnq97H48lD
 TTj/Fy9BFJPnjcGwBwaG6sdZg/cSqnSb61KEDIV6rTSioQ6woN049qJkFFaP79jEDh8I
 kKSKLM2FETsJfq/xAOvMDMboIKQXPXs/YUs9JIPI1emJaE2cAYiajzKEBqIUjsV/PzqM
 j1fV3dRwxR3KT/gW6lZZ1m6OTt/iXkaTAj1rTla/FZoeKkmCdm50AOrfjDFE8VvpsJeD
 nt0bDeaFRSdMeDfFDzD/lTJy1EeChsJI47M0GzOJxxHV1p71WSpgsWHQJmqmtpxPZobn
 EYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464321; x=1692069121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bAv2VkeF2nF/Nch+eWToS5kdoZdnIAW3FmjUUhtDDU=;
 b=kNAlUs0IQcPF+hn/ns6OHOQzzkhdluYi7G4pkMeO7SZ9dBtekX0SV6DGCxmBIIImuk
 6ugDE0w3kItAc3TVJIbrGBQ3J/dRzFhuoD1cnKfX+wm+czCYK0yogCxpBrmfe9XCRqe8
 ED7oTheHI/cQ5sRdO91SOaCaRXek5WV08ycJkeyUwP8OHrA0tewgZzQAnQBpbhcWXqJZ
 P45iAVB++js+bYC4yAKcW7xa/ssz9egVZ0K63SPq/vZlDNMK0itgqCqlbw6wrpOgFeVl
 geIQ0tSRlR18AFaEZfOaTTWYIK7Id0EbnaFLzPk8OuaOik++JjR8s4ueqx4cVuIAypzK
 Pjeg==
X-Gm-Message-State: AOJu0YygNExOluBlLQQ2fqrQPKpFG6B0rHGiqdcI8NuSE8Q4mPqzlS4Z
 iSKXEnPxgLwvXGZbHmVDVGaDHj8WjPYRNI2vOiA=
X-Google-Smtp-Source: AGHT+IGCRUZv8SyCwzVdSnph8+vaIWmk7xHFufrzLKQeDcaUu+J5LR7Mb3E+jI1UWOHCokpmyjOxwA==
X-Received: by 2002:a05:6358:7250:b0:134:e777:c78b with SMTP id
 i16-20020a056358725000b00134e777c78bmr9986135rwa.5.1691464320876; 
 Mon, 07 Aug 2023 20:12:00 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:12:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 18/24] tcg/i386: Merge tcg_out_setcond{32,64}
Date: Mon,  7 Aug 2023 20:11:37 -0700
Message-Id: <20230808031143.50925-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808031143.50925-1-richard.henderson@linaro.org>
References: <20230808031143.50925-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Pass a rexw parameter instead of duplicating the functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index b9673b55bd..ec3c7012d4 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1524,23 +1524,16 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
 }
 #endif
 
-static void tcg_out_setcond32(TCGContext *s, TCGCond cond, TCGArg dest,
-                              TCGArg arg1, TCGArg arg2, int const_arg2)
+static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
+                            TCGArg dest, TCGArg arg1, TCGArg arg2,
+                            int const_arg2)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2, 0);
+    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
     tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
     tcg_out_ext8u(s, dest, dest);
 }
 
-#if TCG_TARGET_REG_BITS == 64
-static void tcg_out_setcond64(TCGContext *s, TCGCond cond, TCGArg dest,
-                              TCGArg arg1, TCGArg arg2, int const_arg2)
-{
-    tcg_out_cmp(s, arg1, arg2, const_arg2, P_REXW);
-    tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
-    tcg_out_ext8u(s, dest, dest);
-}
-#else
+#if TCG_TARGET_REG_BITS == 32
 static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
                              const int *const_args)
 {
@@ -2565,8 +2558,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_brcond(s, rexw, a2, a0, a1, const_args[1],
                        arg_label(args[3]), 0);
         break;
-    case INDEX_op_setcond_i32:
-        tcg_out_setcond32(s, args[3], a0, a1, a2, const_a2);
+    OP_32_64(setcond):
+        tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2);
         break;
     case INDEX_op_movcond_i32:
         tcg_out_movcond32(s, args[5], a0, a1, a2, const_a2, args[3]);
@@ -2718,9 +2711,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
-    case INDEX_op_setcond_i64:
-        tcg_out_setcond64(s, args[3], a0, a1, a2, const_a2);
-        break;
     case INDEX_op_movcond_i64:
         tcg_out_movcond64(s, args[5], a0, a1, a2, const_a2, args[3]);
         break;
-- 
2.34.1


