Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 942E77DA903
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFW-0004iG-VC; Sat, 28 Oct 2023 15:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFV-0004hp-52
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:33 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFS-00046J-FW
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:32 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c77449a6daso27557555ad.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522329; x=1699127129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1jMbpp1weXZkSHBUh0Jn0kijypmzVFb4f/5Y0tU+kg=;
 b=B+qqh9KzbJAmk7ijJi0JUQ0IY60X79ZG6rtnWdP6+1BXP8I4N4M+6SuympYvucNc96
 NoR+VnZS2ISjSmhQ9D6NMaQ2ey1gZTRH6kMibpaj9/s8rLFzjOcY5zVZrT1Wjd0ZSD4C
 hKrjRSkwCEjVrq4TgMWPxB6NNmeM7wNh1lwfHHoUndBGH1FU6QFB8nZWvFteQifCxpdh
 qx0ixuAHHi1M0vHp4bhdbe3Rd6lTagwDVdvbkgNRIqaTsyo6251ND8uDCXksrE/4coiO
 LUOqL9g3jBgyC9n11/rIreWow0emxLI4T6uO4J4i2tcTnm7Xl+z7NdKzUVJb+GVzXNex
 DJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522329; x=1699127129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1jMbpp1weXZkSHBUh0Jn0kijypmzVFb4f/5Y0tU+kg=;
 b=pX/sRnD62rO9RISneRazu6vWnojWzCnJNem9+t2oryn6dqIm/aVDNOEMk8vb1cpbsN
 ySBAk/VGxuYvFlVsmdh74UOz9650Ht1n16yWD3CtF3R0jQKliB38VK9TKbVbB0p4kTTS
 RFtSgk50hFbWRHTCjRIII859qBGqFrekKFy27yzBXQUPGbEFzHLJdSCYMId7ZgDjg8k0
 l9DyjXQvsIuRK7AgWG0fxTQZI59BCBjYHEsGq244X+Yhx58913KvVY6Er8Mk8ljE4GC4
 qsXzwXQNOgbyNZUTEPty3IcTF4gMuzAcFSzhvawHWMzZH5GuQ/rEuqiljgUwVbTqSvCQ
 4xLg==
X-Gm-Message-State: AOJu0YyFMVNnqf31PEaQ6UR+xp3lS8iZO20jD5zXpappv6HIIxL/6ZhT
 GD3XpYA26ZA9EMAeArGJ/l8WtblG3OAcnCkHb6o=
X-Google-Smtp-Source: AGHT+IG8p/VYtEuYXEqfyf92qLk1u3ilKXfNk1bocvUmbDg/qP5JSDhh3w71/U6oHYh+e/blNmVl1w==
X-Received: by 2002:a17:902:ce84:b0:1c2:218c:3754 with SMTP id
 f4-20020a170902ce8400b001c2218c3754mr7209083plg.53.1698522329018; 
 Sat, 28 Oct 2023 12:45:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 05/35] tcg/optimize: Split out arg_new_constant
Date: Sat, 28 Oct 2023 12:44:52 -0700
Message-Id: <20231028194522.245170-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
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


