Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D9781558
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j5-00054O-3H; Fri, 18 Aug 2023 18:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j2-00053O-UL
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j0-0004Q0-Mz
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bbff6b2679so10968755ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396825; x=1693001625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4dOhrxfb6A1qspMKsrkE0J05JHs+gGt/0uiIDKf6Ts=;
 b=RaS/9Fooq/PN9vM//rRrkAUmeKSwcpOdTPzhoYPm4wQdvoIYKn5c8rr+GaCuathyK5
 DFMFY09mhHTdb+g4O3sOyVctdDZHb32bQjETmEAUEUxS23vp6ZxpWtgKB+h2H1J41ofd
 jZaNPUhZAsdq+UZ+EOCm8iljQQFXB7EeMR0hUl3iBsn52ymF2V9axWx9Da6cwUVV0Y21
 MnRO6jvM+2q4BDmtSxV4SBqP18W+3Pyt5Wjgq3G02VxbuLnLhuUY2YLGi+3ByFym7n+7
 FK/I5bdSB7WlYkTcuQKtZJ7Xi2MKIQZI3fxiaeNiqXUW0IeqfInGOrDCq1l16Z6+JnaN
 d/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396825; x=1693001625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V4dOhrxfb6A1qspMKsrkE0J05JHs+gGt/0uiIDKf6Ts=;
 b=esRvHqgb+b4fchekwpnaD0bTaTJz0TxteFxcpVTmJGsbM4S44d05lrlgMmQONZwJNQ
 eE+RmSfR9W1MYwOjafSTDIPcJqZm1MUs3Snr7ZIcpYdSj1SIbC2ICJ3nErB7Aut7xxef
 aIS5M/Lljr6+oBPoYiwAKTwzp15OYksjduKJdMX778p346M4PIv+jJV6XbZe3QqYTxfd
 GCQB1HPnJVJyVJmoV4US+uYEjbAhF488QCW3iyZ0DSEEZE0Lu6XaOxP0UigjPorNwXyq
 QLOYbR5KQgQRv0IkkWI8UZsnnQfyt+wAvRb65H7NOPi5AGqZediQuRhJOUIaTOmP9gZ2
 Bzqw==
X-Gm-Message-State: AOJu0YzIjKmNwt278fU4RNuplzLaODZJhbUuXJU19OdwJ5rKb/XxgkuD
 ihG3S0+Wvsp+G+huoY3vlT518te+c8pEQOqRWTo=
X-Google-Smtp-Source: AGHT+IFiGjPvHqVy4J/wTJvMrzM0RHk9ZMNuMxXonP5g4tgMurPQkRG8hsvDLOGYYhO/yrdQW+WH9A==
X-Received: by 2002:a17:902:e802:b0:1bf:1acf:9c0c with SMTP id
 u2-20020a170902e80200b001bf1acf9c0cmr591576plg.26.1692396825088; 
 Fri, 18 Aug 2023 15:13:45 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 19/23] tcg/i386: Merge tcg_out_movcond{32,64}
Date: Fri, 18 Aug 2023 15:13:23 -0700
Message-Id: <20230818221327.150194-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 010432d3a9..1542afd94d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1593,24 +1593,14 @@ static void tcg_out_cmov(TCGContext *s, TCGCond cond, int rexw,
     }
 }
 
-static void tcg_out_movcond32(TCGContext *s, TCGCond cond, TCGReg dest,
-                              TCGReg c1, TCGArg c2, int const_c2,
-                              TCGReg v1)
+static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
+                            TCGReg dest, TCGReg c1, TCGArg c2, int const_c2,
+                            TCGReg v1)
 {
-    tcg_out_cmp(s, c1, c2, const_c2, 0);
-    tcg_out_cmov(s, cond, 0, dest, v1);
+    tcg_out_cmp(s, c1, c2, const_c2, rexw);
+    tcg_out_cmov(s, cond, rexw, dest, v1);
 }
 
-#if TCG_TARGET_REG_BITS == 64
-static void tcg_out_movcond64(TCGContext *s, TCGCond cond, TCGReg dest,
-                              TCGReg c1, TCGArg c2, int const_c2,
-                              TCGReg v1)
-{
-    tcg_out_cmp(s, c1, c2, const_c2, P_REXW);
-    tcg_out_cmov(s, cond, P_REXW, dest, v1);
-}
-#endif
-
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
                         TCGArg arg2, bool const_a2)
 {
@@ -2564,8 +2554,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     OP_32_64(setcond):
         tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2);
         break;
-    case INDEX_op_movcond_i32:
-        tcg_out_movcond32(s, args[5], a0, a1, a2, const_a2, args[3]);
+    OP_32_64(movcond):
+        tcg_out_movcond(s, rexw, args[5], a0, a1, a2, const_a2, args[3]);
         break;
 
     OP_32_64(bswap16):
@@ -2714,10 +2704,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
-    case INDEX_op_movcond_i64:
-        tcg_out_movcond64(s, args[5], a0, a1, a2, const_a2, args[3]);
-        break;
-
     case INDEX_op_bswap64_i64:
         tcg_out_bswap64(s, a0);
         break;
-- 
2.34.1


