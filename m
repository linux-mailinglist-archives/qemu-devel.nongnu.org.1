Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC3A7D7A3B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 03:40:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvpLn-0001uj-Bn; Wed, 25 Oct 2023 21:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpLj-0001sM-UP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:39:51 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpLi-00034C-FD
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:39:51 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso2394545ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 18:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698284389; x=1698889189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xK+JWgkPgdP/B/2EKpKortnxne1iWP7pZx29ZgBu6Lk=;
 b=NzlRk95gey5uqnF1AOUQ8ifpwdwnyzfGiNEs21RRPeZihq6u5/g1tImc7M4xsJJS/f
 CW3cJ+O1lrWFK3nsu4mpedd3RX/Q431SKQ2YcQA/ylWrU6ds6TeQTkNSRQn3oe+nQKuW
 qLfwlzxFKNz11MTE3ErKO4KTMwuhdUznHiXXvAtF1FnXRuyk5pJM+OvsucTFpTilsrIm
 ZKhCpu1dqlYrXD8I9TnmXM4lMxDxkCqAUz3ITLIaMWuhyqPDnV0y5X4asfuKf8vUgoLy
 GA08Pe4xx7a0pA/AKRsV7CH5ZbsYwbIu45HBxkQS8tUxpIi+QzcAfPMK8hfLUaX2TsqX
 HeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698284389; x=1698889189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xK+JWgkPgdP/B/2EKpKortnxne1iWP7pZx29ZgBu6Lk=;
 b=qRsT+EACeIrYPSxzntiruhDFXh8YJ46w1qyQ7saezUx0Kpqpp2dLM+rijNywiXTrNq
 ux6wtdwUGFWChcHg3IJrldfPSTNe+2PGqgi0k6cDoujTyhjbdODfgRaEg8Eqy7Qnuv+w
 L9ylX5pOqL4tHHtYUIzK1Wzz9LxE8dWGU07JT0Swzc/XAT4IcTfgopIxdvgsglflUOOq
 S0yv/4YCtUsvdKltthphXg1OOqaPVQeIpBSi7EfbCp2pP9fRlQVacAs8/sHFtMpZyC8i
 Ic38PMU3k8z9YszH+opErOKHl15951lcuMOO6NiUAcjaIjgGYDAj7Gqown/6HfGYNOCt
 4Ehg==
X-Gm-Message-State: AOJu0YwIDKBzl4I99Vh9nqGuV5tk6ApbXZzw3ij5bEoJHlhkC6JOvzAI
 jtc1Du+rXttPoPg6/jTacKHxiL7CchFFUvWYiKI=
X-Google-Smtp-Source: AGHT+IH1p3ypWgzYLvq3DoAsLEf7jTSOaKzh90WTLzHlEmNxR7zgNJzFqsCgeeqnX0zQKwUcC44KMg==
X-Received: by 2002:a17:902:d4c6:b0:1ca:15ad:1c6 with SMTP id
 o6-20020a170902d4c600b001ca15ad01c6mr15791608plg.33.1698284388962; 
 Wed, 25 Oct 2023 18:39:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y6-20020a170902864600b001c0c86a5415sm9817032plt.154.2023.10.25.18.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 18:39:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 3/4] tcg/optimize: Canonicalize sub2 with constants to add2
Date: Wed, 25 Oct 2023 18:39:44 -0700
Message-Id: <20231026013945.1152174-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026013945.1152174-1-richard.henderson@linaro.org>
References: <20231026013945.1152174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9d91c25f68..280e6089a6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1030,8 +1030,10 @@ static bool fold_add_vec(OptContext *ctx, TCGOp *op)
 
 static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
 {
-    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3]) &&
-        arg_is_const(op->args[4]) && arg_is_const(op->args[5])) {
+    bool a_const = arg_is_const(op->args[2]) && arg_is_const(op->args[3]);
+    bool b_const = arg_is_const(op->args[4]) && arg_is_const(op->args[5]);
+
+    if (a_const && b_const) {
         uint64_t al = arg_info(op->args[2])->val;
         uint64_t ah = arg_info(op->args[3])->val;
         uint64_t bl = arg_info(op->args[4])->val;
@@ -1075,6 +1077,21 @@ static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
         tcg_opt_gen_movi(ctx, op2, rh, ah);
         return true;
     }
+
+    /* Fold sub2 r,x,i to add2 r,x,-i */
+    if (!add && b_const) {
+        uint64_t bl = arg_info(op->args[4])->val;
+        uint64_t bh = arg_info(op->args[5])->val;
+
+        /* Negate the two parts without assembling and disassembling. */
+        bl = -bl;
+        bh = ~bh + !bl;
+
+        op->opc = (ctx->type == TCG_TYPE_I32
+                   ? INDEX_op_add2_i32 : INDEX_op_add2_i64);
+        op->args[4] = arg_new_constant(ctx, bl);
+        op->args[5] = arg_new_constant(ctx, bh);
+    }
     return false;
 }
 
-- 
2.34.1


