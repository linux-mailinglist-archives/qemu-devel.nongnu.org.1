Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C55E77E3339
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:50:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9P-0008Q4-Gi; Mon, 06 Nov 2023 21:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9M-0008Oi-6h
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:08 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9K-0005vh-Iw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:07 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d9beb863816so5338570276.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325345; x=1699930145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9d35huw1p7Cu08U8Degtbo7sfMGmI1/7YRi8G8catM=;
 b=ikxXuZB3Aw53PIkjED8CrYNcfD5YG71A30a9w4Kr6RgTZjtA6NoSO8x13lYADataqF
 4Tl/dTCPptpgd+RJdB+dPLmmn54+xr1IAdd5uNSZ7a4eWNrcoeElfZR3Bh5rch4zkg1c
 byAjT+n/Fnm22z0uf5HRMpJ6B0DM9TgtUGNk6zumk7dQRrITqvbaH4M2dJ+hxdSh3Eoi
 F1AOqKwyjW/P2f4PPivF5J89109atHM0dxEcNtEV1KEpX7keLVxQy4lZTU8AVmuViYL4
 Ln5pR7WYLZwCJ38SjHrr7UxHs8Vjy744ZbiSDuT7Y0iimQrEVCxaQ6+gO6uMO/l82MdW
 rWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325345; x=1699930145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9d35huw1p7Cu08U8Degtbo7sfMGmI1/7YRi8G8catM=;
 b=SKGEaukiZaMxJZr0C/fpWywgZ61PH9s6LaFpslFPLlaNX0ziNRwh64sW9s7ZO02QMb
 SJL7zAmiiNLu2P82gYw+Vqw5z3rBqZSnWNQDVYYWNNwnvCHO/0LEfhXguuRfhRNbDuex
 vj4XDAHyhJ7lLgmb2AMVXYz0GzXJTku7mlJSDG1FH7dgzAkb77kb1OhOUmP6vwHggqiP
 AcH4HeQxBzAr/GrqeJKEmVIfHdmOi0Etq0h8jwMBGJfE9+7hFYYUvXoA8zStMC5BscaX
 EzDvSyjWSaQrHH5Wik2D9I0mpnJxFWzU6HKhT6opFSoOZv17BXT4L2dnUkqZ0pEdTKq6
 cMGg==
X-Gm-Message-State: AOJu0YyZbLLce6na1sEkosUvIkU9Na10MSTo6jHD7x4ujZQoNFA1R3Rc
 f27nLDGC2926XQ9ndQJPAOWzNBgd8AtbO1g+p4c=
X-Google-Smtp-Source: AGHT+IHH4ncyd/8DQjQ2lnytMPI/3S91uC1HQy+Zi39mRJsz7CLcEkTglg/0+mfJBYGvLoCYCJJCoQ==
X-Received: by 2002:a5b:706:0:b0:da0:c49a:5103 with SMTP id
 g6-20020a5b0706000000b00da0c49a5103mr30263644ybq.47.1699325345301; 
 Mon, 06 Nov 2023 18:49:05 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 27/35] tcg/optimize: Pipe OptContext into reset_ts
Date: Mon,  6 Nov 2023 18:48:34 -0800
Message-Id: <20231107024842.7650-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2b.google.com
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

Will be needed in the next patch.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6b072d4cdb..cbb095b241 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -123,7 +123,7 @@ static inline bool ts_is_copy(TCGTemp *ts)
 }
 
 /* Reset TEMP's state, possibly removing the temp for the list of copies.  */
-static void reset_ts(TCGTemp *ts)
+static void reset_ts(OptContext *ctx, TCGTemp *ts)
 {
     TempOptInfo *ti = ts_info(ts);
     TempOptInfo *pi = ts_info(ti->prev_copy);
@@ -138,9 +138,9 @@ static void reset_ts(TCGTemp *ts)
     ti->s_mask = 0;
 }
 
-static void reset_temp(TCGArg arg)
+static void reset_temp(OptContext *ctx, TCGArg arg)
 {
-    reset_ts(arg_temp(arg));
+    reset_ts(ctx, arg_temp(arg));
 }
 
 /* Initialize and activate a temporary.  */
@@ -239,7 +239,7 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
         return true;
     }
 
-    reset_ts(dst_ts);
+    reset_ts(ctx, dst_ts);
     di = ts_info(dst_ts);
     si = ts_info(src_ts);
 
@@ -702,7 +702,7 @@ static void finish_folding(OptContext *ctx, TCGOp *op)
     nb_oargs = def->nb_oargs;
     for (i = 0; i < nb_oargs; i++) {
         TCGTemp *ts = arg_temp(op->args[i]);
-        reset_ts(ts);
+        reset_ts(ctx, ts);
         /*
          * Save the corresponding known-zero/sign bits mask for the
          * first output argument (only one supported so far).
@@ -1215,14 +1215,14 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
 
         for (i = 0; i < nb_globals; i++) {
             if (test_bit(i, ctx->temps_used.l)) {
-                reset_ts(&ctx->tcg->temps[i]);
+                reset_ts(ctx, &ctx->tcg->temps[i]);
             }
         }
     }
 
     /* Reset temp data for outputs. */
     for (i = 0; i < nb_oargs; i++) {
-        reset_temp(op->args[i]);
+        reset_temp(ctx, op->args[i]);
     }
 
     /* Stop optimizing MB across calls. */
-- 
2.34.1


