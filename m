Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6D57D6310
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIV-0000Cc-Po; Wed, 25 Oct 2023 03:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIO-00009C-UY
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIM-0004eL-TL
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9bf22fe05so35210245ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218833; x=1698823633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1jMbpp1weXZkSHBUh0Jn0kijypmzVFb4f/5Y0tU+kg=;
 b=sC3UJEMwG0ttGeALGwwds6rcFUjAXl9Vu+WeXo52Sunz4+hVgLWDzNFyxCbp0LxoMh
 5ym1SCZY3lutJcpgEpNC3lfylthjp4B4fFCEKgbZupioF0glRvSL1Xsb67hGavXiy/DG
 PaF0nqFRFby0OUtOXU6rY3wvaAd2mVvMbu2Gp4tqh3NzyS/6xNRA60V5Rs3WtEo+XTQS
 zeLmcvn9Ma8mc9DPrjAeCwtvUC8Wx9dSPSDX7fFwoDJ4LY/lQMVzZNd2lknpzF+x96mU
 lHs6RnoI7XMcPE6Bw9SNbC4/eqVvZaV3+XAZ/Xrb+0qSA2hBGLuvZAJUqIh+fV9zdila
 xxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218833; x=1698823633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1jMbpp1weXZkSHBUh0Jn0kijypmzVFb4f/5Y0tU+kg=;
 b=r3n+aara03lzdNjHp+M+Y0H9rFbOZjg5QgjNz0sS5L6dKqEMGRjcoqhKMscWOObBBY
 HW/bjUl/VHpnKHYpfcAh7tlAVYipa7POLyHxeP8q27HD3uLeuGMT/fIP4HAlfLwMFG+i
 Y6rb130ER+YL0TG1kxMklTH6dGwrJnwaaFjR+n55jub52sREMRU309cAdQI3La4TqyZZ
 iRFIUh7XlK1v9RcziuPNhit4ZuLxnZncw3qQ3s3F0DSK4mjUxrOsvq6MTtCKoaO/SdPd
 EFR+mdISgk4JJvowhqhdbbvhOtls2g0XapfbAeN5pd2SsnREnv2gjPbuMm9kKhDTUsP0
 cYag==
X-Gm-Message-State: AOJu0Ywc1sY4kr/i8gYOrx+b8f8OsjjA73uu4nRHySX14DYOLRSDIzPz
 4ltuFxOk0OGouwaASHH3owae3Cla36C0PVkhW40=
X-Google-Smtp-Source: AGHT+IEYTf/BOYhQaHL7opAnZOX/XoouUkaSWJI/jzL2VUrAhMAUYOuH3fRYNjDNtAz0kgIxKX3WlQ==
X-Received: by 2002:a17:902:ea0f:b0:1c8:9bc6:2a09 with SMTP id
 s15-20020a170902ea0f00b001c89bc62a09mr14134277plg.15.1698218833521; 
 Wed, 25 Oct 2023 00:27:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 05/29] tcg/optimize: Split out arg_new_constant
Date: Wed, 25 Oct 2023 00:26:43 -0700
Message-Id: <20231025072707.833943-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


