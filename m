Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E47E3335
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:50:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9S-0008R9-Bg; Mon, 06 Nov 2023 21:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9P-0008QC-Hj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:11 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9N-0005wL-R3
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:11 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6cd0963c61cso2754785a34.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325349; x=1699930149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9z9UDH6HsfK3PAJgBAA8lIx6YK0Bl0hMEwM1O6FOrY=;
 b=GQKCy4YuJoNAAjQcHm0ecWe1WoFU+TBJVOUM3IFo8WGphCMo3kIxd07WaaYb0k0T5l
 ETF5NrXR27gxbAjHNcjylBKlbxMvKeSATmFJSRAlmsWYKvwLyXMEJTOA2DVVfHr45KUd
 IhFlEzd3L3rFTI3DCEuyHPwn+vFSXNCmi2cIAGCIbXnDOQDBj92TXIzGpciMqDVLsblk
 TG9cSOVINX2IiImZDCX3nTSq6v5sIvMQQgcejBGYuSVSWLmkuXI2Nxc/SiUuxFK6pBTR
 j8jHMwncLPdOIbYbb5rt3FIPEjC1i42noZiGyMsUUd53qxW6lGKlt+AtSLWlBgK4SE7D
 pyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325349; x=1699930149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9z9UDH6HsfK3PAJgBAA8lIx6YK0Bl0hMEwM1O6FOrY=;
 b=Dv3O8LGq0aPpbDOXLc9mj50YpE7jKU3108aDhsi6QA7Db8JBZFjt8D5nwaiJ9B23LP
 yB/vJHFZDvg7VcjNXY3zfr/dQm0dJSrVZMzYgAjbv4tnjhpxyDDTTUkxwBCSyV+S4Cb0
 zfXflCzXNGVU/G4ggu2nbJ1LHmnptQ0G/P6NXk4Z9We1mSsWJabFbysvn+GMvCMRcrC3
 atNzwSq1gEOHeZS9b2IpZ5wBhZeiuhXsKk3E6gGhY+BzS4e8RnowEyFGtAQ+6MDSsEJ2
 hJkmUYMOqmGq7yG4syh9Z3bYVmjlol3dZHpMe+q80oomTDBBweKWTNEzBvU0Ov1v4iQV
 4StQ==
X-Gm-Message-State: AOJu0YxT94pSktKFTNp/19rxb1m46G0a5Qd36X1mGwBWlYUmdJCBvZ70
 NhaijHk//Uj7h8jLzjh+pmKWc8+OKjn0l+eb4Mc=
X-Google-Smtp-Source: AGHT+IHWpxW/EM+pd+i88pSWjbpYl43e8EZ40I3w0qx8aXk3Uhno5uxGO4DFKoVKGdIpLCGByv8now==
X-Received: by 2002:a05:6830:3149:b0:6b8:dc53:9efd with SMTP id
 c9-20020a056830314900b006b8dc539efdmr32406598ots.3.1699325348783; 
 Mon, 06 Nov 2023 18:49:08 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 31/35] tcg/optimize: Split out arg_new_constant
Date: Mon,  6 Nov 2023 18:48:38 -0800
Message-Id: <20231107024842.7650-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

Fixes a bug wherein raw uses of tcg_constant_internal
do not have their TempOptInfo initialized.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index a4fe9ee9bb..d8e437c826 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -338,6 +338,21 @@ static TCGTemp *find_mem_copy_for(OptContext *ctx, TCGType type, intptr_t s)
     return NULL;
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
@@ -399,16 +414,8 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
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
@@ -1431,7 +1438,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
 
         op->opc = and_opc;
         op->args[1] = op->args[2];
-        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
+        op->args[2] = arg_new_constant(ctx, mask);
         ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
         return false;
     }
@@ -1442,7 +1449,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
 
         op->opc = and_opc;
-        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
+        op->args[2] = arg_new_constant(ctx, mask);
         ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
         return false;
     }
-- 
2.34.1


