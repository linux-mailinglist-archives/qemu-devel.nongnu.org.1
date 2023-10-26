Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDD17D792A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2r-00075Y-BG; Wed, 25 Oct 2023 20:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2i-00070N-S8
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:08 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2g-0004qO-1z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:08 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9d922c039so2173545ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279352; x=1698884152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D1jMbpp1weXZkSHBUh0Jn0kijypmzVFb4f/5Y0tU+kg=;
 b=WmYjuOPQnWYowCgVOigqJACvsa2g/1OEDSIhZ9omh8JP1QpCmBSltEC1+Yf8gs73Sj
 e8raS8ecIu1+Z2Tzw2GQD5tMi6SMS3GauyVVk+5HajgOiXNo0clpo+a0pktGPggFhw7e
 Y8pmIjZLF0pXSmeIQ2xoqz7RK5CzSmALzP7S0zSDrEWGWHyGyHNb8SiJssTUf0j0EfUE
 OZsEcyD4DnhQ4NY23sIs3mskm937qPFYQWCoHvjYabh7rZG05KiOvECkGnMF1aKM8n21
 tFeJUr9Xw+Ui/iFOU4wKuSJ2pJCy7IZOexgEL1U7XQXlhGcEzzhwy/DIQsDHMBCb8xtM
 aurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279352; x=1698884152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1jMbpp1weXZkSHBUh0Jn0kijypmzVFb4f/5Y0tU+kg=;
 b=MKheI31gDT4f8GjaQ8oSjfzMvwMIjqrR4DgRkoik5B8FVEOOtM2CTo0est0H6Vq5OQ
 xndK/6q3YOTlUOvjbyo2WXL3vLgoIKZEi9DVh5iXAMIOKCbE3EhqqynT7gE+lDzI8ZCD
 0Gx78WOpN8TCoC3lskU7KhfNuEzgJ4X5DcAU4JdFmHlFSzwcUVEua7VVhP5iwEgy1+to
 NmZ5/e1gaffB8bHyXquM/x77OwPQkWVyuUX+NWAirAVDleNlW8+Nn9Uv/mn+lo6NrZL+
 hN6Du2cpYNSuVLA3VvrYDyjjJsKWpCFMJW1d65PVc9N1eUzIgjY74k4g0LnqnE7iOb+3
 WsoQ==
X-Gm-Message-State: AOJu0YySiAY3XwotLMPkfv4xBLGPUuJD8LzwbtNRWYpeklAyrW5JXbqn
 vo8ybcF6RgU1SU1cjM++Vkx5DfmFBr1GCusCjvM=
X-Google-Smtp-Source: AGHT+IFwoTIEC/Tr7pl7KEvOj401ibO/S1DIfGRHC3W/c7vcTwruYJ4YUvPHgX+BB8fIB7hA4meI8A==
X-Received: by 2002:a17:902:e747:b0:1c9:fb76:42fe with SMTP id
 p7-20020a170902e74700b001c9fb7642femr19636917plf.45.1698279352351; 
 Wed, 25 Oct 2023 17:15:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/29] tcg/optimize: Split out arg_new_constant
Date: Wed, 25 Oct 2023 17:13:49 -0700
Message-Id: <20231026001542.1141412-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Fixes a bug wherein raw uses of tcg_constant_internal
do not have their TempOptInfo initialized.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 76be0fc337..2f2d1c3001 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -237,6 +237,21 @@ static bool args_are_copies(TCGArg arg1, TCGArg arg2)
     return ts_are_copies(arg_temp(arg1), arg_temp(arg2));
 }
 
+static TCGArg arg_new_constant(OptContext *ctx, uint64_t val)
+{
+    TCGType type = ctx->type;
+    TCGTemp *ts;
+
+    if (type == TCG_TYPE_I32) {
+        val = (int32_t)val;
+    }
+
+    ts = tcg_constant_internal(type, val);
+    init_ts_info(ctx, ts);
+
+    return temp_arg(ts);
+}
+
 static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
 {
     TCGTemp *dst_ts = arg_temp(dst);
@@ -293,16 +308,8 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
 static bool tcg_opt_gen_movi(OptContext *ctx, TCGOp *op,
                              TCGArg dst, uint64_t val)
 {
-    TCGTemp *tv;
-
-    if (ctx->type == TCG_TYPE_I32) {
-        val = (int32_t)val;
-    }
-
     /* Convert movi to mov with constant temp. */
-    tv = tcg_constant_internal(ctx->type, val);
-    init_ts_info(ctx, tv);
-    return tcg_opt_gen_mov(ctx, op, dst, temp_arg(tv));
+    return tcg_opt_gen_mov(ctx, op, dst, arg_new_constant(ctx, val));
 }
 
 static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
@@ -1340,7 +1347,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
 
         op->opc = and_opc;
         op->args[1] = op->args[2];
-        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
+        op->args[2] = arg_new_constant(ctx, mask);
         ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
         return false;
     }
@@ -1350,7 +1357,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
 
         op->opc = and_opc;
-        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
+        op->args[2] = arg_new_constant(ctx, mask);
         ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
         return false;
     }
-- 
2.34.1


